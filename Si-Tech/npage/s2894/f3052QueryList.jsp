 <%
	/********************
	 version v2.0
	������: si-tech
	update:anln@2009-02-13 ҳ�����,�޸���ʽ
	********************/
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType="text/html;charset=Gbk"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="com.sitech.boss.util.page.*"%>

<%
	String implRegion= (String)session.getAttribute("regCode");	
	String opCode = "3052";		
	String opName = "ҵ��������Ա�ʷѹ�ϵά��";	//header.jsp��Ҫ�Ĳ��� 	
	
%>

<%
	String sqlStr = "";
	String sqlStr1 = "";
	String sqlStmt = "";
	String whereSql = "";
	
	String bizCode= request.getParameter("bizCode")==null?"":request.getParameter("bizCode");//ҵ�����
	String spCode = request.getParameter("spCode")== null?"":request.getParameter("spCode"); //��ҵ����
	
	
	
	if(!(bizCode.equals("")))
	{
	    whereSql = whereSql + " and c.bizcodeadd like '"+bizCode+"%' ";
	}
	if(!(spCode.equals("")))
	{
	    whereSql = whereSql + " and c.enterprice_code like '"+spCode+"%' ";
	}

	whereSql = whereSql + " order by b.region_code,c.enterprice_code,a.field_code1,a.field_code3";

	sqlStmt ="select b.region_code,c.enterprice_code,a.field_code1,c.product_note"
		+",a.field_code3,b.mode_name "
 		+"from dbvipadm.sCommonCode a,sBillModeCode b,sBillSpCode c "
 		+"where a.common_code='0001' and a.field_code2=b.mode_type and a.field_code3=b.mode_code "
 		+"and trim(c.bizcodeadd)=a.field_code1 and b.region_code='"+implRegion+"' ";

	sqlStmt = sqlStmt + whereSql ;
	

	/**************** ��ҳ���� ********************/
	int iPageNumber = request.getParameter("pageNumber")==null?1:Integer.parseInt(request.getParameter("pageNumber"));
	int iPageSize = 10;
	int iStartPos = (iPageNumber-1)*iPageSize;
	int iEndPos = iPageNumber*iPageSize;
	/**********************************************/
		
	//SPubCallSvrImpl impl = new SPubCallSvrImpl();
	ArrayList retList = new ArrayList(); 
	ArrayList retList1= new ArrayList(); 

	
	//��ѯ�ܼ�¼��
	sqlStr  =  "SELECT count(*) from ("	+ sqlStmt + ")"; 
		        
	//��ѯ����        
	sqlStr1 = "select * from (select row_.*,rownum id from (" + sqlStmt + ") row_ where rownum <= "+iEndPos+") where id > "+iStartPos; //��ѯָ�������ļ�¼
	System.out.println("sqlStr1:"+sqlStr1);
	
		//retList = impl.sPubSelect("1",sqlStr , "region", implRegion);
		//retList1= impl.sPubSelect("6",sqlStr1, "region", implRegion);
		%>
		<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=implRegion%>"  retcode="retCode1" retmsg="retMsg1" outnum="1">
			<wtc:sql><%=sqlStr%></wtc:sql>
		</wtc:pubselect>
		<wtc:array id="result" scope="end" />
		
		<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=implRegion%>"  retcode="retCode2" retmsg="retMsg2" outnum="8">
			<wtc:sql><%=sqlStr1%></wtc:sql>
		</wtc:pubselect>
		<wtc:array id="result2" scope="end" />	
			
		<%
		System.out.println("result2=================="+result2.length);
		for(int ii=0;ii<result2.length;ii++){
				for(int jj=0;jj<result2[ii].length;jj++){
					System.out.println("result2["+ii+"]["+jj+"]="+result2[ii][jj]);
				}
		}
		
		System.out.println("\n==================\nok1");	
	
		String[][] allNumStr = new String[][]{};
		String[][] result1   = new String[][]{};
	
	try 
	{
		//allNumStr = (String[][])retList.get(0);
		allNumStr=result;
		//System.out.println("allNumStr = " + allNumStr[0][0]);
		System.out.println("\n==================\nok2");	
	}
	catch(Exception e)
	{
		System.out.println("\n==================\nerror2");
	}
	
	try 
	{
		//result1 = (String[][])retList1.get(0);	
		result1=result2;	
		System.out.println("\n==================\nok3");	
	}
	catch(Exception e)
	{
		System.out.println("\n==================\nerror3");
	}
	
	System.out.println("allNumStr = " + allNumStr[0][0]);
	
	if(result1 == null || result1.length == 0)
	{
	%>
		<script language='jscript'>
			rdShowMessageDialog("û�в鵽��ؼ�¼��");
			parent.location="f3052_1.jsp";				
		</script>      
	<%            
	}
	%>	

<html>
<head>
</head>

<script type=text/javascript>
		
	//���ƴ�����ƶ�
	function initAd() 
	{		
		document.all.page0.style.posLeft = -200;
		document.all.page0.style.visibility = 'visible'
		MoveLayer('page0');
	}
	
	function MoveLayer(layerName) 
	{
		var x = 10;
		var x = document.body.scrollLeft + x;		
		eval("document.all." + layerName + ".style.posLeft = x");
		setTimeout("MoveLayer('page0');", 20);
	}
	
</script>

<body onload="initAd()" >
	<form name="form1" method="post" action="">	
		<%@ include file="/npage/include/header.jsp" %>   			
		<table id="tabList"  cellspacing=0 >			
			<tr align='center'>				
				<th>���д���</th>
				<th>��ҵ����</th>
				<th>ҵ�����</th>
				<th>ҵ������</th>
				<th>�ʷѴ���</th>
				<th>�ʷ�����</th>
				
			</tr>
		<%	
		for(int i = 0; i < result1.length; i++)
		{		  
		%>			
			<tr>				
				<td nowrap align='center'><%=result1[i][0].trim()%>&nbsp;</td>
				<td nowrap align='center'><%=result1[i][1].trim()%>&nbsp;</td>
				<td nowrap align='center'><%=result1[i][2].trim()%>&nbsp;</td>
				<td nowrap align='center'><%=result1[i][3].trim()%>&nbsp;</td>
				<td nowrap align='center'><%=result1[i][4].trim()%>&nbsp;</td>
				<td nowrap align='center'><%=result1[i][5].trim()%>&nbsp;</td>
				
			</tr>
		<%
		}
		%>				
			<tr>	
				<td colspan="10">
					<div id="page0" style="position:relative;font-size:12px;">
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					<%	
					    //ʵ�ַ�ҳ
					    int iQuantity = Integer.parseInt(allNumStr[0][0].trim());
					    Page pg = new Page(iPageNumber,iPageSize,iQuantity);
						PageView view = new PageView(request,out,pg); 
					   	view.setVisible(true,true,0,0);      
					%>
					</div>
				</td>				
			</tr>
		</table>
 		<%@ include file="/npage/include/footer_simple.jsp" %>  
</form>
</body>
</html>


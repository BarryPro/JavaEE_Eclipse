<%
  /*
   * ����: Ǳ�ڼ����б�
�� * �汾: v1.0
�� * ����: 2011��05��10��
�� * ����: zhoujf
�� * ��Ȩ: sitech
   * �޸���ʷ
   * �޸�����      �޸���      �޸�Ŀ��
 ��*/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd>
<HTML xmlns="http://www.w3.org/1999/xhtml">
<%@ taglib uri="weblogic-tags.tld" prefix="wl" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page contentType="text/html; charset=GBK" %>
<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>
<%@ page import="com.sitech.boss.util.page.*"%>
<%
	String sqlStr = "";
	String sqlStr1 = "";
	String OWNER_CODE=request.getParameter("OWNER_CODE")==null?"":request.getParameter("OWNER_CODE");
	String work_no =  request.getParameter("work_no")==null?"":request.getParameter("work_no");
	String implRegion= (String)session.getAttribute("regCode");	
  String workName = (String)session.getAttribute("workName");
  String ipAddr = (String)session.getAttribute("ipAddr");
  String orgCode = (String)session.getAttribute("orgCode");
  String regionCode = orgCode.substring(0,2);
  String opCode="";
  String opName="Ǳ�ڼ��Ų�ѯ";
  String sqlStmt="SELECT T.OWNER_CODE,T.UNIT_ID,T.UNIT_NAME,T.CONTACT_PERSON,T.CONTACT_PHONE FROM DBVIPADM.DGRPPREMSG T  WHERE T.SERVICE_NO = '"+work_no+"' AND T.pre_owner_code = '"+OWNER_CODE+"'";

	/**************** ��ҳ���� ********************/
	int iPageNumber = request.getParameter("pageNumber")==null?1:Integer.parseInt(request.getParameter("pageNumber"));
	int iPageSize = 10;
	int iStartPos = (iPageNumber-1)*iPageSize;
	int iEndPos = iPageNumber*iPageSize;
	/**********************************************/
	
	//��ѯ�ܼ�¼��
	sqlStr  =  "SELECT count(*) from ("	+ sqlStmt + ")"; 
		        
	//��ѯ����        
	sqlStr1 = "select * from (select row_.*,rownum id from (" + sqlStmt + ") row_ where rownum <= "+iEndPos+") where id > "+iStartPos; //��ѯָ�������ļ�¼
	System.out.println("+++++++++++++++zhou+++++++++++++++++++++++sqlStr1:"+sqlStr1);
%>
	<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=implRegion%>"  retcode="retCode1" retmsg="retMsg1" outnum="5">
			<wtc:sql><%=sqlStr%></wtc:sql>
		</wtc:pubselect>
	<wtc:array id="result" scope="end" />
	
	<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=implRegion%>"  retcode="retCode1" retmsg="retMsg1" outnum="5">
			<wtc:sql><%=sqlStr1%></wtc:sql>
		</wtc:pubselect>
	<wtc:array id="result2" scope="end" />
		
		<%
			System.out.println("result=====zhoujf begin=============\n"+work_no);
			System.out.println("result=====zhoujf begin=============\n"+sqlStr);
		System.out.println("result=================="+result.length);
		for(int ii=0;ii<result.length;ii++){
				for(int jj=0;jj<result[ii].length;jj++){
					System.out.println("result["+ii+"]["+jj+"]="+result[ii][jj]);
				}
		}
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
		function closeDivWin(obj){
		if(!obj){
			obj = parent;
		}
		obj.$(".window .close:last").click();
		}
			rdShowMessageDialog("û�в鵽��ؼ�¼��");
			closeDivWin();			
		</script>      
	<%            
	}
		System.out.println("result============1023  END======");
		%>
<HTML>
<HEAD>
<link href="s2002.css" rel="stylesheet" type="text/css">
</HEAD>
<BODY>
<FORM name="form1" method="post">
<%@ include file="/npage/include/header.jsp" %>

<div class="title"><div id="title_zi">�����б�</div></div>
  <table id="tabList"  cellspacing=0 >			
			<tr align='center'>				
				<th>���ű��</th>
				<th>��������</th>
				<th>���ŵȼ�</th>
				<th>��ϵ��</th>
				<th>��ϵ�˵绰</th>
			</tr>
		<%	
		for(int i = 0; i < result1.length; i++)
		{		  
		%>			
			<tr>				
				<td nowrap align='center'><%=result1[i][1].trim()%>&nbsp;</td>
				<td nowrap align='center'><%=result1[i][2].trim()%>&nbsp;</td>
				<td nowrap align='center'><%=result1[i][0].trim()%>&nbsp;</td>
				<td nowrap align='center'><%=result1[i][3].trim()%>&nbsp;</td>
				<td nowrap align='center'><%=result1[i][4].trim()%>&nbsp;</td>

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
</BODY>
</HTML>



<%
  /*
   * ����: ���ܼ����б�
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
	String PARENT_GROUP_ID =  request.getParameter("PARENT_GROUP_ID")==null?"":request.getParameter("PARENT_GROUP_ID");
	String implRegion= (String)session.getAttribute("regCode");	
  String workName = (String)session.getAttribute("workName");
  String ipAddr = (String)session.getAttribute("ipAddr");
  String orgCode = (String)session.getAttribute("orgCode");
  String regionCode = orgCode.substring(0,2);
  String opCode="";
  String opName="�����б����ܣ�";
   String sqlStmt="SELECT A.UNIT_ID, A.UNIT_NAME, A.OWNER_CODE, A.CONTACT_PERSON, A.CONTACT_PHONE, T.NAME, T.PHONE_NO FROM DBVIPADM.DGRPCUSTMSG A, DBVIPADM.DGRPMANAGERMSG T WHERE A.SERVICE_NO = T.SERVICE_NO AND A.ORG_CODE IN (SELECT A1.GROUP_ID FROM DBVIPADM.DGRPGROUPS A1 WHERE A1.PARENT_GROUP_ID = '"+PARENT_GROUP_ID+"') AND  A.OWNER_CODE = '"+OWNER_CODE+"'";
 
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
	System.out.println("sqlStr1:"+sqlStr1);

%>
	<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=implRegion%>"  retcode="retCode1" retmsg="retMsg1" outnum="7">
			<wtc:sql><%=sqlStr%></wtc:sql>
		</wtc:pubselect>
	<wtc:array id="result" scope="end" />
		
		<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=implRegion%>"  retcode="retCode1" retmsg="retMsg1" outnum="7">
			<wtc:sql><%=sqlStr1%></wtc:sql>
		</wtc:pubselect>
	<wtc:array id="result2" scope="end" />
		
		<%

			System.out.println("result=====zhoujf begin=============\n"+sqlStr);
		System.out.println("result=================="+result.length);
		for(int ii=0;ii<result.length;ii++){
				for(int jj=0;jj<result[ii].length;jj++){
					System.out.println("result["+ii+"]["+jj+"]="+result[ii][jj]);
				}
		}
		
		System.out.println("result============1023  END======");
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
			parent.location="f1023_main.jsp";				
		</script>      
	<%            
	}
	%>	
<script language='jscript'>
function grp(unit_id){
			var url = "grp_main.jsp?unit_id="+unit_id;
    	window.open(url,"","width=800,height=600,left=10,top=10,resizable=yes,scrollbars=yes,status=yes,location=no,menubar=no");
	}
</script>  
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
				<th>�ͻ�����</th>
				<th>�ͻ�����绰</th>
				<th>����</th>
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
				<td nowrap align='center'><%=result1[i][6].trim()%>&nbsp;</td>
				<td nowrap align='center'>
				<input name="queryAcBtn" class="b_foot"  type="button"  value="ͳһ��ͼ" onClick="grp(<%=result1[i][0].trim()%>);">
				</td>
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



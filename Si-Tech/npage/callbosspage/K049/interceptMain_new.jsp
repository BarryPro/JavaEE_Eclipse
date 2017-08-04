<%@ page contentType= "text/html;charset=gb2312" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%
   String retType = WtcUtil.repNull(request.getParameter("retType"));
   String contactId = WtcUtil.repNull(request.getParameter("contactId"));
   String filePath = WtcUtil.repNull(request.getParameter("filePath"));
    String transagent = WtcUtil.repNull(request.getParameter("transagent"));
   String loginNo = (String)session.getAttribute("workNo");  //取login_no
   String orgCode = (String)session.getAttribute("orgCode");
    String regionCode = orgCode.substring(0,2);
		java.util.Date current=new java.util.Date();
    java.text.SimpleDateFormat sdf=new java.text.SimpleDateFormat("yyyyMM"); 
    String table_name="dcallcall"+sdf.format(current);
		
		String sql= "insert into DCALLRECORDFILE"+sdf.format(current)+" (FILE_ID,CONTACT_ID,FILE_PATH,LOGIN_NO,CREATE_TIME)"+
		"select lpad(SEQ_FILE_NO.nextval,14,'0'),contact_id,:v1,:v2,sysdate from "
    +table_name+" where contact_id in (select max(contact_id) from "+table_name+" where ACCEPT_LOGIN_NO=:v3)";  
   	
%>
	<wtc:service name="sPubModifyKfCfm" outnum="2" routerKey="region" routerValue="<%=regionCode%>">
			<wtc:param value="<%=sql%>"/>
			<wtc:param value="dbchange"/>
			<wtc:param value="<%=filePath%>"/>
			<wtc:param value="<%=loginNo%>"/>
			<wtc:param value="<%=transagent%>"/>
	</wtc:service>
	<wtc:array id="rows"  scope="end"/>
	<%
	  if(rows[0][0].equals("000001")){
	     retCode = "000001";
	     retMsg = "保存关系失败";
	     out.println("000001");
	  }
	else
		{
		out.println("000000");
		}
	%>






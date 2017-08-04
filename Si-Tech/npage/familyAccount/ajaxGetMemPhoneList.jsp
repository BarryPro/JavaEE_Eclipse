<%
/********************
 version v2.0
开发商: si-tech
*
* create hejwa
* 取成员下拉列表
* 2013-5-3 9:58:04
*
********************/
%>
<%@ page contentType="text/html; charset=gb2312" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%
		
String regionCode = (String)session.getAttribute("regCode");
String srv_no     = request.getParameter("srv_no");
String type       = request.getParameter("type");
StringBuffer sb   = new StringBuffer("<option value=''>--请选择--</option>");
try{

System.out.println("hejwa-------------------srv_no-------------------"+srv_no);
System.out.println("hejwa-------------------type---------------------"+type);
%>
 <wtc:service name="sG645Qry" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode" retmsg="retMsg" outnum="7">
	  <wtc:param value="<%=srv_no%>"/>
	  <wtc:param value="<%=type%>"/>
 </wtc:service>
<wtc:array id="result_t2"  scope="end"/>
		 	
<%
	for(int i=0;i<result_t2.length;i++){
		sb.append("<option value='"+result_t2[i][2].trim()+"'>"+result_t2[i][2].trim()+"</option>");
	}
}catch(Exception e){
}
out.print(sb.toString());
%>		 	
 
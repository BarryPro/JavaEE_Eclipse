<%@ page contentType= "text/html;charset=gb2312" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>

<%
  String custmsgFlag = "";
  String regionCode  = (String)session.getAttribute("regCode");
  String g_CustId    = WtcUtil.repNull(request.getParameter("g_CustId")); 
  String paramsql    = "select cust_id from dcustmsg where cust_id=:g_CustId";
  String paramIn     = "g_CustId="+g_CustId;
%>

  <wtc:service name="TlsPubSelCrm" outnum="1" retmsg="msg" retcode="code" routerKey="region" routerValue="<%=regionCode%>">
		<wtc:param value="<%=paramsql%>" />
		<wtc:param value="<%=paramIn%>" />	
	</wtc:service>
	<wtc:array id="result_t"   scope="end"/>
		
<%

if(result_t.length>0){
	custmsgFlag = result_t[0][0];
}
%>
var response = new AJAXPacket();
response.data.add("custmsgFlag","<%=custmsgFlag%>");
core.ajax.receivePacket(response);
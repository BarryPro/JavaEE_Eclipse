<%@ include file="/page/workflow/admin/pub/wb_include.jsp" %>

<%
String wono = (String)request.getAttribute("wono");
String wano = (String)request.getAttribute("wano");
%>

<wtc:service name="sGetWAParamPage" outnum="1"  >
	      <wtc:param value="<%=loginNo%>"/>
        <wtc:param value="2"/>
        <wtc:param value="<%=wano%>"/>
</wtc:service>

<% 
if(retCode.equals("000000"))
{
%>

<wtc:array id="ret"  start="0" length="1"> 
<%
String url="busi/create1.jsp";
request.setAttribute("wano",wano);
%>
	<jsp:forward page="<%=url%>" />
</wtc:array>

<%				
}
else
{
	throw new Exception("error");
}

%>

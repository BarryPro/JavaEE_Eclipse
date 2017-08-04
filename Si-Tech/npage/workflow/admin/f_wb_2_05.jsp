<%@ include file="/page/workflow/admin/pub/wb_include.jsp" %>

<%
String wano = (String)request.getParameter("wano");
String wono = (String)request.getParameter("wono");
request.setAttribute("wono",wono);
request.setAttribute("wano",wano);
%>
	<jsp:include page="pub/f_wb_pub_5.jsp" flush="true" /> 




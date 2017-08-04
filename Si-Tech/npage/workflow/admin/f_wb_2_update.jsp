
<%@ include file="/npage/workflow/admin/pub/wb_include.jsp" %>


<%
	String wano=request.getParameter("wano");
	String openUrl=request.getParameter("openUrl");
	
	request.setAttribute("wano",wano);

%>
<script>
    var openUrl2 = "<%=openUrl%>";
    var openUrl3 = openUrl2.replace(/@/g,"&");
    parent.parent.openPage("1","1111","任务处理",openUrl3,"000");
</script>


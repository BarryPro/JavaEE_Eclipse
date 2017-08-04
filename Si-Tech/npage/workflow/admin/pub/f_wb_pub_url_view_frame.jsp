<%
/***************************
* url查看托管页面
* 提供输入和输出控制，url调度，框架显示等
* 石柏成
* 20080407
***************************/
%>
<%@ include file="/page/workflow/admin/pub/wb_include.jsp" %>

<%
    Map _paramap = (Map)request.getAttribute("_paraMap");
    String _url = (String)_paramap.get("_url");

%>
 
	<div id='_customdiv' style="display:block">
		<jsp:include page="<%=_url%>" flush="true" /> 
	</div>

<%
/***************************
* url�鿴�й�ҳ��
* �ṩ�����������ƣ�url���ȣ������ʾ��
* ʯ�س�
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

<%@ include file="/page/workflow/admin/pub/wb_include.jsp" %>
<%
String wano=request.getParameter("wano");
String wono=request.getParameter("wono");
String targetPage="f_wb_3_02.jsp";
%>

<wtc:service name="s7055Del" outnum="0"  >
	    <wtc:param value="<%=loginNo%>"/>
        <wtc:param value="3"/>
		<wtc:param value="<%=wono%>"/>
		<wtc:param value="<%=wano%>"/>
</wtc:service>


<% 
if(retCode.equals("000000"))
{
%>
	<script>
	alert("���ճɹ�");
	//window.location="<%=targetPage%>";
    </script>
<%				
}
else
{
	%>
<script>
	alert("����ʧ��,ԭ��Ϊ��<%=retMsg%>");
	//window.location="<%=targetPage%>";
</script>
<%
}

%>

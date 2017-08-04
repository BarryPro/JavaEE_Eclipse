<%@ include file="/page/workflow/admin/pub/wb_include.jsp" %>

<%
String wano=(String)request.getParameter("wano");
String groupId=(String)request.getParameter("groupId");
String assignLogin=(String)request.getParameter("assignLogin");
String change_type=(String)request.getParameter("change_type");
String targetPage="f_wb_3_02.jsp";
%>

<wtc:service name="sRecWA" outnum="0"  >
	      <wtc:param value="<%=wano%>"/>
        <wtc:param value="7557"/>
        <wtc:param value="<%=loginNo%>"/>
		<wtc:param value="<%=change_type%>"/>
        <wtc:param value="<%=groupId%>"/>
        <wtc:param value="<%=assignLogin%>"/>
      
</wtc:service>

<% 
if(retCode.equals("000000"))
{
%>
alert('执行成功');	
	<%	
}
else
{
%>
	alert('提交失败,原因为:<%=retMsg%>');
	<%
}

%>
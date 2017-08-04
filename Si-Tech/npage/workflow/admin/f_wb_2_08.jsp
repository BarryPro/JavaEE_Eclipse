<%@ include file="/page/workflow/admin/pub/wb_include.jsp" %>
<%

String wano=(String)request.getParameter("wano");
String change_type=(String)request.getParameter("change_type");
String assignRole=(String)request.getParameter("assignRole");
String belongOrg=(String)request.getParameter("belongOrg");
String assignLogin=(String)request.getParameter("assignLogin");
String targetPage="f_wb_2_01.jsp";
%>

<wtc:service name="sRecWA" outnum="0"  >
	      <wtc:param value="<%=wano%>"/>
        <wtc:param value="2"/>
        <wtc:param value="<%=loginNo%>"/>
        <wtc:param value="<%=change_type%>"/>
		<wtc:param value="<%=assignRole%>"/>
        <wtc:param value="<%=assignLogin%>"/>
        <wtc:param value="<%=belongOrg%>"/>
      
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
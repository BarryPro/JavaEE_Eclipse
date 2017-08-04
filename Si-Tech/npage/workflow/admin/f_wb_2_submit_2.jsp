<%@ include file="/page/workflow/admin/pub/wb_include.jsp" %>

<%

String wano=(String)request.getParameter("wano");
String region=(String)request.getParameter("region");
String targetPage="f_wb_2_02.jsp";
%>

<wtc:service name="sLoadWA" outnum="0"  >
	      <wtc:param value="<%=loginNo%>"/>
        <wtc:param value="7"/>
        <wtc:param value="<%=wano%>"/>
        <wtc:param value="<%=region%>"/>
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
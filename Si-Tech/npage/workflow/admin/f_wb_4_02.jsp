<%@ include file="/page/workflow/admin/pub/wb_include.jsp" %>

<%
String orderType = (String)request.getParameter("order_type");
String orderPriority = (String)request.getParameter("order_priority");
%>

<wtc:service name="sInitWO" outnum="2"  >
	      <wtc:param value="<%=loginNo%>"/>
        <wtc:param value="1"/>
        <wtc:param value="9"/>
        <wtc:param value="0"/>
</wtc:service>

<% 
if(retCode.equals("000000"))
{
%>

<wtc:array id="ret"  start="0" length="2"> 
<%
request.setAttribute("wono",ret[0][0]);
request.setAttribute("wano",ret[0][1]);
%>
	<jsp:forward page="pub/f_wb_pub_1.jsp" /> 

</wtc:array>
<%			
}
else
{
	%>
<script>
	alert("提交失败,原因为：<%=retMsg%>");
	window.close();
</script>

<%
}

%>



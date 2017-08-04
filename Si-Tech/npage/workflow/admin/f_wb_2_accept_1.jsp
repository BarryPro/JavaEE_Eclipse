
<%@ include file="/npage/workflow/admin/pub/wb_include.jsp" %>


<%
	String wano=request.getParameter("wano");
	String openUrl=request.getParameter("openUrl");
	
	request.setAttribute("wano",wano);
%>

<wtc:service name="sRecWA" outnum="0"  >
	<wtc:param value="<%=wano%>"/>
	<wtc:param value="7556"/>
	<wtc:param value="<%=loginNo%>"/>
	<wtc:param value="10"/>
</wtc:service>


<% 
if(retCode.equals("000000"))
{
System.out.println("cx=====================retCode:"+retCode);
%>
<script>
    var openUrl2 = "<%=openUrl%>";
    var openUrl3 = openUrl2.replace(/@/g,"&");
    parent.parent.openPage("1","1111","任务处理",openUrl3,"000");
    //window.close();
</script>
<%				
}
else
{
	%>
    <script>
    	rdShowMessageDialog('提交失败,原因为:<%=retMsg%>',0);
    	window.close();
    </script>
<%
}

%>

<%@ include file="/page/workflow/admin/pub/wb_include.jsp" %>
<%
String wano=request.getParameter("wano");
String targetPage="f_wb_2_02.jsp";
%>

<wtc:service name="sRecWA" outnum="0"  >
	      <wtc:param value="<%=wano%>"/>
		  <wtc:param value="7556"/>
        <wtc:param value="<%=loginNo%>"/>
		<wtc:param value="11"/>
</wtc:service>


<% 
if(retCode.equals("000000"))
{
%>

	parent.rdShowMessageDialog("���˳ɹ�",2);

<%				
}
else
{
	%>
	parent.rdShowMessageDialog("����ʧ��,ԭ��Ϊ��<%=retMsg%>",0);
<%
}

%>

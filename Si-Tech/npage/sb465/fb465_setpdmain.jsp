<%@page contentType="text/html;charset=gb2312"%>
<%
	String roleCode = request.getParameter("roleCode");	//��ɫ����
	String roleName = request.getParameter("roleName");	//��ɫ����
	String roleTypeCode = request.getParameter("roleTypeCode");
	String roles = request.getParameter("roles");	//������ѡ�Ľ�ɫ����

%>
	<frameset rows="*" cols="240,*" framespacing="0" frameborder="no" border="0">

<%
	out.println("<frame src=\"functree.jsp?roleCode="+roleCode+"&roleName="+roleName+"&roleTypeCode="+roleTypeCode+"&roles="+roles+"\" name=\"leftFrame\" scrolling=\"Yes\" noresize=\"noresize\" id=\"leftFrame\" />");
 	out.println("<frame src=\"funclist.jsp?roleCode="+roleCode+"&roleName="+roleName+"&roleTypeCode="+roleTypeCode+"&roles="+roles+"\" name=\"rightFrame\"  id=\"rightFrame\" />");
%>
  </frameset>
<noframes></noframes>
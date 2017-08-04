<%@page contentType="text/html;charset=gb2312"%>
<%
	String roleCode = request.getParameter("roleCode");	//角色代码
	String roleName = request.getParameter("roleName");	//角色代码
	String roleTypeCode = request.getParameter("roleTypeCode");
	String roles = request.getParameter("roles");	//所有所选的角色代码

%>
	<frameset rows="*" cols="240,*" framespacing="0" frameborder="no" border="0">

<%
	out.println("<frame src=\"functree.jsp?roleCode="+roleCode+"&roleName="+roleName+"&roleTypeCode="+roleTypeCode+"&roles="+roles+"\" name=\"leftFrame\" scrolling=\"Yes\" noresize=\"noresize\" id=\"leftFrame\" />");
 	out.println("<frame src=\"funclist.jsp?roleCode="+roleCode+"&roleName="+roleName+"&roleTypeCode="+roleTypeCode+"&roles="+roles+"\" name=\"rightFrame\"  id=\"rightFrame\" />");
%>
  </frameset>
<noframes></noframes>
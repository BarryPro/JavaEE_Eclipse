<%@page contentType="text/html;charset=gb2312"%>
<%
	String roleCode = request.getParameter("roleCode");	//角色代码
	String roleName = request.getParameter("roleName");	//角色代码
	String loginNo1 = request.getParameter("loginNo1");	//新建或修改的工号代码
	System.out.println("roleCode="+roleCode);
	System.out.println("loginNo1="+loginNo1);
	System.out.println("setpdmain.jsp  roleName="+roleName);

%>
  <frameset rows="*" cols="240,*" framespacing="0" frameborder="no" border="0">
  
<%  
	
	out.println("<frame src=\"functree.jsp?roleCode="+roleCode+"&roleName="+roleName+"&loginNo1="+loginNo1+"\"   name=\"leftFrame\" scrolling=\"Yes\" noresize=\"noresize\" id=\"leftFrame\" />");
   
 	out.println("<frame src=\"funclist.jsp?roleCode="+roleCode+"&roleName="+roleName+"&loginNo1="+loginNo1+"\"   name=\"rightFrame\"  id=\"rightFrame\" />");
%>  
  </frameset>
<noframes></noframes>
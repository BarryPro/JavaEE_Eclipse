<%@page contentType="text/html;charset=gb2312"%>
<%
	String roleCode = request.getParameter("roleCode");	//��ɫ����
	String roleName = request.getParameter("roleName");	//��ɫ����
	String loginNo1 = request.getParameter("loginNo1");	//�½����޸ĵĹ��Ŵ���
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
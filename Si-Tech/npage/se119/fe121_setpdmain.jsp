<%
/********************
version v2.0
������: si-tech
update:anln@2009-02-25 ҳ�����,�޸���ʽ
********************/
%>
<%@page contentType="text/html;charset=gb2312"%>
<%
	String roleCode      = (String)session.getAttribute("powerCode");
	String roleName = "";
	String loginNo1 = (String)session.getAttribute("workNo");	
	System.out.println(">>>>>>>>>>>>>>>>>>>>>>roleCode="+roleCode);
	System.out.println(">>>>>>>>>>>>>>>>>>>>>>roleName="+roleName);
	System.out.println(">>>>>>>>>>>>>>>>>>>>>>loginNo1="+loginNo1);

%>
  <frameset rows="*" cols="240,*" framespacing="0" frameborder="no" border="0">
<%
	out.println("<frame src=\"functree.jsp?roleCode="+roleCode+"&roleName="+roleName+"&loginNo1="+loginNo1+"\"   name=\"leftFrame\" scrolling=\"Yes\" noresize=\"noresize\" id=\"leftFrame\" />");
	out.println("<frame src=\"funclist.jsp?roleCode="+roleCode+"&roleName="+roleName+"&loginNo1="+loginNo1+"\"   name=\"rightFrame\"  id=\"rightFrame\" />");
%>  
  </frameset>
<noframes></noframes>
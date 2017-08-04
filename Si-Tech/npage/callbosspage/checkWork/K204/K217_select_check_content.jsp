<%
  /*
   * 功能: 计划外质检-》选择考评内容
　 * 版本: 1.0.0
　 * 日期: 2008/11/05
　 * 作者: mixh
　 * 版权: sitech
   * update:
　 */
%>
<%
	//String opCode = "K217";
	//String opName = "选择考评内容";
	String staffno = request.getParameter("staffno");
	
	// add for 中测 start
	String isTest = request.getParameter("isTest");
	// add for 中测 end 
%>

<%@page contentType="text/html;charset=GBK"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Frameset//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-frameset.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<title>计划外质检</title>
</head>
<frameset rows="50,*" cols="*" frameborder="no" border="0" framespacing="0">
  <frame src="K217_show_outline.jsp?serialnum=<%=request.getParameter("serialnum")%>&staffno=<%=staffno%>" name="topFrame" scrolling="No" noresize="noresize" id="topFrame" title="topFrame" frameborder="yes"/>
  <frameset cols="250,*" frameborder="no" border="0" framespacing="0">
    <frame src="K217_qc_object_tree.jsp" name="leftFrame" scrolling="No" noresize="noresize" id="leftFrame" frameborder="yes"/>
    <frame src="K217_qc_content_list.jsp" name="mainFrame" id="mainFrame" frameborder="yes"/>
  </frameset>
</frameset>
<noframes>
<body>
</body>
</noframes>
</html>

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
	String group_flag = request.getParameter("group_flag");
%>

<%@page contentType="text/html;charset=GBK"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Frameset//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-frameset.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<title>计划外质检</title>
</head>
<frameset rows="50,*" cols="*" frameborder="no" border="0" framespacing="0">
  <frame src="K217_show_outline.jsp?serialnum=<%=request.getParameter("serialnum")%>&staffno=<%=staffno%>&group_flag=<%=group_flag%>" name="topFrame" scrolling="No" id="topFrame" title="topFrame" style="border:solid #DFE8F6 3px;cursor:move"/>
  <frameset cols="200,*" frameborder="no" border="0" framespacing="0">
    <frame src="K217_qc_object_tree.jsp" name="leftFrame" scrolling="No" id="leftFrame" style="border:solid #DFE8F6 3px;cursor:move"/>
    <frame src="K217_qc_content_list.jsp" name="mainFrame" id="mainFrame" style="border:solid #DFE8F6 3px;cursor:move"/>
  </frameset>
</frameset>
<noframes>
<body>
</body>
</noframes>
</html>

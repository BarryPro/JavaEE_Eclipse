<%
  /*
   * 功能: 修改班组成员
　 * 版本: 1.0.0
　 * 日期: 2008/12/09
　 * 作者: hanjc
　 * 版权: sitech
   * update:
　 */
%>
<%
	String opCode = "K084";
	String opName = "修改班组成员";
%>

<%@page contentType="text/html;charset=GBK"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Frameset//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-frameset.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312"/>
<title>修改班组成员</title>
</head>

<frameset cols="230,*" frameborder="no" border="0" framespacing="0">
<frame src="K084_group_list.jsp" name="leftFrame" scrolling="auto" noresize="noresize" id="leftFrame" frameborder="yes"/>
  <frameset rows="*,25" frameborder="no" border="0" framespacing="0">
    <frame src="K084_member_list.jsp?serialnum=<%=request.getParameter("serialnum")%>" name="mainFrame" id="mainFrame" frameborder="yes"/>
    <frame src="K084_rightFooterButton.jsp" name="rightFootFrame" id="rightFootFrame" title="rightFootFrame" scrolling="no" />
  </frameset>
</frameset>

<noframes>
<body>
</body>
</noframes>
</html>

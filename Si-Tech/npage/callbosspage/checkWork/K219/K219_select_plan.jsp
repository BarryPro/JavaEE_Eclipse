<%
  /*
   * 功能: 对流水进行质检->选择质检计划->主页面
　 * 版本: 1.0.0
　 * 日期: 2008/11/05
　 * 作者: mixh
　 * 版权: sitech
   * update:
　 */
%>
<%
	String opCode = "K218";
	String opName = "对流水进行质检";
%>

<%@page contentType="text/html;charset=GBK"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Frameset//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-frameset.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312"/>
<title>计划内质检</title>
</head>
<%
String serialnum = request.getParameter("serialnum");//质检单流水
String login_no  = request.getParameter("staffno");
String contact_id     = request.getParameter("contact_id");//通话流水
String style_flag     = request.getParameter("style_flag");
%>
<frameset cols="180,*" frameborder="no" border="0" framespacing="0">
<frame src="K219_plan_list.jsp?serialnum=<%=serialnum%>&staffno=<%=login_no%>" name="leftFrame" scrolling="No" noresize="noresize" id="leftFrame" frameborder="yes"/>
<frame src="K219_plan_content_list.jsp?serialnum=<%=serialnum%>&staffno=<%=login_no%>&contact_id=<%=contact_id%>&style_flag=<%=style_flag%>" name="mainFrame" id="mainFrame" frameborder="yes"/>
</frameset>

<noframes>
<body>
</body>
</noframes>
</html>

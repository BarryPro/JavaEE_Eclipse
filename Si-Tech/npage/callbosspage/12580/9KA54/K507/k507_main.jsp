
<%
  /*
   * 功能: 短信日志
　 * 版本: 1.0.0
　 * 日期: 2009/01/09
　 * 作者: libin
　 * 版权: sitech
   * update:
　 */
%>

<%@page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_ajax.jsp"%>
<%@ page import="com.sitech.crmpd.core.wtc.util.*,java.util.*"%>

<%
	String opCode = "K507";
	String opName = "短信日志";
%>


<html>
<head>
<title>12580短信日志</title>
<meta http-equiv=Content-Type content="text/html; charset=GBK">
</head>

<frameset name="frame1" cols="350,0,*" frameborder="NO" border="0" framespacing="0">
  
  <frame src="k507_query.jsp" name="mainFrame" scrolling="auto" noresize>
  <frame src="k507_midframe.jsp" name="midFrame" scrolling="no" noresize>
  <frame src="k507_list.jsp" name="rightFrame" scrolling="auto" noresize>
</frameset>
<noframes><body>
</body></noframes>
</html>
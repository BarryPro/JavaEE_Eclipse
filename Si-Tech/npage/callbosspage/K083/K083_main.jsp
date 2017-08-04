
<%
	/*
	* 功能: 预定义短信 
	* 版本: 1.0.0
	* 日期: 2009/01/11      
	* 作者: libin
	* 版权: sitech
	* update:
	*/
%>
<%                                                     
	String opCode = "K083";                              
	String opName = "自定义短信";
%>
<%@ page contentType="text/html;charset=GBK"%>
<html>
<head>
<title>预定义短信</title>
<meta http-equiv=Content-Type content="text/html; charset=GBK">                                                
</head>
<frameset rows="*" cols="300,*" frameborder="NO" border="1" framespacing="0">
  <frame  src="K083_message_tree.jsp" name="leftFrame" >
  <frame src="sort_content.jsp" name="mainFrame">
</frameset>
<noframes><body>
</body></noframes>
</html>

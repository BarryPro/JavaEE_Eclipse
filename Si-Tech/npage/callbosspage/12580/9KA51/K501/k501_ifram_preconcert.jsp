
<%
	/*
	* 功能: 预定义短信 
	* 版本: 1.0.0
	* 日期: 2009/03/10      
	* 作者: libin
	* 版权: sitech
	* update:
	*/
%>
<%                                                     
	String opCode = "K501";                              
	String opName = "预定义短信";
%>
<%@ page contentType="text/html;charset=GBK"%>
<html>
<head>
<title>预定义短信</title>
<meta http-equiv=Content-Type content="text/html; charset=GBK">                                                
</head>
<frameset rows="*" cols="200,*" frameborder="1" border="1" framespacing="0">
  <frame  src="K503/K503_message_tree.jsp" name="ifram_leftFrame" >
  <frame src="k501_msg_content.jsp" name="ifram_mainFrame">
</frameset>
<noframes><body>
</body></noframes>
</html>

<html>
<head>
<title></title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
</head>
<%
	String accountType = (String)session.getAttribute("accountType"); /*ȡ�������� 2Ϊ�ͷ�����*/
%>
<frameset cols="25%,*" name="frameright0" framespacing="1" border="1" frameborder="yes">
	<%if(accountType.equals("2")){%>
		<frame name="frameMode" src="./f5144ModeKf.jsp" frameborder="0" marginwidth="0" marginheight="0" scrolling="auto">    
	<%}else{%>
        <frame name="frameMode" src="./f5144Mode.jsp" frameborder="0" marginwidth="0" marginheight="0" scrolling="auto">    
    <%}%>
        <frame name="frameMain" src="./blank.htm" frameborder="0" marginwidth="0" marginheight="0" scrolling="auto">
</frameset>

<noframes>
<body></body></noframes>

</html>


<%
  /*
   * ����: ������־
�� * �汾: 1.0.0
�� * ����: 2009/01/09
�� * ����: libin
�� * ��Ȩ: sitech
   * update:
�� */
%>

<%@page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_ajax.jsp"%>
<%@ page import="com.sitech.crmpd.core.wtc.util.*,java.util.*"%>

<%
	String opCode = "K507";
	String opName = "������־";
%>


<html>
<head>
<title>12580������־</title>
<meta http-equiv=Content-Type content="text/html; charset=GBK">
</head>

<frameset cols="350,*" frameborder="NO" border="0" framespacing="0">
  
  <frame src="k508_query.jsp" name="mainFrame">
   
  <frame src="k508_list.jsp" name="rightFrame" scrolling="auto" noresize>
</frameset>
<noframes><body>
</body></noframes>
</html>
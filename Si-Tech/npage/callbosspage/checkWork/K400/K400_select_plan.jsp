<%
  /*
   * ����: �Զ�����->ѡ���ʼ�ƻ�->��ҳ��
�� * �汾: 1.0.0
�� * ����: 2009/08/19
�� * ����: zengzq
�� * ��Ȩ: sitech
   * update:
�� */
%>

<%
String opCode = "K400";
String opName = "����ˮ�����Զ��ʼ�";
%>

<%@page contentType="text/html;charset=GBK"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=GBK"/>
<title>ѡ���Զ������ƻ�</title>
</head>

<%
String serialnum = request.getParameter("serialnum");
String login_no  = request.getParameter("staffno");
%>

<frameset cols="180,*" frameborder="no" border="0" framespacing="0">
<frame src="K400_plan_list.jsp" name="leftFrame" scrolling="No" id="leftFrame" style="border:solid #DFE8F6 3px;cursor:move"/>
<frame src="K400_plan_content_list.jsp" name="mainFrame" id="mainFrame" style="border:solid #DFE8F6 3px;cursor:move"/>
</frameset>

<noframes>
<body>
</body>
</noframes>
</html>

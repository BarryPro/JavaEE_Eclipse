<%
  /*
   * ����: ����ˮ�����ʼ�->ѡ���ʼ�ƻ�->��ҳ��
�� * �汾: 1.0.0
�� * ����: 2008/11/05
�� * ����: mixh
�� * ��Ȩ: sitech
   * update:
�� */
%>

<%
String opCode = "K218";
String opName = "����ˮ�����ʼ�";
%>

<%@page contentType="text/html;charset=GBK"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Frameset//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-frameset.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312"/>
<title>�ƻ����ʼ�</title>
</head>

<%
String serialnum = request.getParameter("serialnum");
String login_no  = request.getParameter("staffno");
String flag  = request.getParameter("flag");
String start_date  = request.getParameter("start_date");
%>

<frameset cols="180,*" frameborder="no" border="0" framespacing="0">
<frame src="K218_plan_list.jsp?serialnum=<%=serialnum%>&staffno=<%=login_no%>&flag=<%=flag%>&start_date=<%=start_date%>" name="leftFrame" scrolling="No" id="leftFrame" style="border:solid #DFE8F6 3px;cursor:move"/>
<frame src="K218_plan_content_list.jsp?serialnum=<%=serialnum%>&staffno=<%=login_no%>&flag=<%=flag%>&start_date=<%=start_date%>" name="mainFrame" id="mainFrame" style="border:solid #DFE8F6 3px;cursor:move"/>
</frameset>

<noframes>
<body>
</body>
</noframes>
</html>

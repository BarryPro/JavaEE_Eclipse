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
String serialnum = request.getParameter("serialnum");//�ʼ쵥��ˮ
String login_no  = request.getParameter("staffno");
String contact_id     = request.getParameter("contact_id");//ͨ����ˮ
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

<%
  /*
   * ����: �ʼ�������
�� * �汾: 1.0.0
�� * ����: 2008/12/22
�� * ����: hanjc
�� * ��Ȩ: sitech
   * update:
�� */
%>

<%@page contentType="text/html;charset=GBK"%>

<head>
<title></title>
</head>
<%
String serialnum  = (String)request.getParameter("serialnum");//�������ʼ���ˮ
String object_id  = request.getParameter("object_id");
String content_id = request.getParameter("content_id");
String contact_id = request.getParameter("contact_id");//ͨ����ˮ
//��ʱ����
String plan_id = request.getParameter("plan_id");
String isOutPlanflag  = request.getParameter("isOutPlanflag");
String staffno = (String)request.getParameter("staffno");
String tabId   = request.getParameter("tabId");//tabҳ���idֵ
String group_flag     = request.getParameter("group_flag");
%>

<frameset cols="170,*" frameborder="no" border="0" framespacing="0">
<frame src="<%=request.getContextPath()%>/npage/callbosspage/checkWork/K217/K217_qc_item_tree.jsp?object_id=<%=object_id%>&content_id=<%=content_id%>" name="leftFrame" scrolling="auto"  id="leftFrame" frameborder="yes"/>
<frame src="<%=request.getContextPath()%>/npage/callbosspage/checkWork/K219/K219_check_plan_qc_form.jsp?serialnum=<%=serialnum%>&object_id=<%=object_id%>&content_id=<%=content_id%>&isOutPlanflag=<%=isOutPlanflag%>&staffno=<%=staffno%>&contact_id=<%=contact_id%>&tabId=<%=tabId%>&plan_id=<%=plan_id%>&group_flag=<%=group_flag%>" name="mainFrame" id="mainFrame" frameborder="yes"/>
</frameset>

<noframes>
<body>
</body>
</noframes>
</html>

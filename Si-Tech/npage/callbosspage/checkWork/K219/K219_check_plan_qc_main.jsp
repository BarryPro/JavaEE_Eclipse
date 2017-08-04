<%
  /*
   * 功能: 质检结果复核
　 * 版本: 1.0.0
　 * 日期: 2008/12/22
　 * 作者: hanjc
　 * 版权: sitech
   * update:
　 */
%>

<%@page contentType="text/html;charset=GBK"%>

<head>
<title></title>
</head>
<%
String serialnum  = (String)request.getParameter("serialnum");//被复核质检流水
String object_id  = request.getParameter("object_id");
String content_id = request.getParameter("content_id");
String contact_id = request.getParameter("contact_id");//通话流水
//临时测试
String plan_id = request.getParameter("plan_id");
String isOutPlanflag  = request.getParameter("isOutPlanflag");
String staffno = (String)request.getParameter("staffno");
String tabId   = request.getParameter("tabId");//tab页面的id值
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

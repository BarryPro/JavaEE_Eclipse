<%
  /*
   * 功能: 自动质检
　 * 版本: 1.0.0
　 * 日期: 
　 * 作者: 
　 * 版权: sitech
   * update:
　 */
%>
<%
	String opCode = request.getParameter("opCode");
	String opName = request.getParameter("opName");
	if(opCode == null || opCode ==""){
			opCode = "K400";
	}
	if(opName == null || opName ==""){
			opName = "对流水进行自动质检";
	}	
%>

<%
	/****************获得质检对象流水、考评内容流水、被检通话流水开始******************/
	String object_id  = request.getParameter("object_id");
	String content_id = request.getParameter("content_id");
	String serialnum  = request.getParameter("serialnum");
	String isOutPlanflag  = request.getParameter("isOutPlanflag");
	String staffno = (String)request.getParameter("staffno");
	String plan_id = request.getParameter("plan_id");
	String group_flag = request.getParameter("group_flag");
	String tabId   = request.getParameter("tabId");//tab页面的id值
	String qc_objectvalue = request.getParameter("qc_objectvalue");
	String qc_contentvalue = request.getParameter("qc_contentvalue");
	String out_returnVal = request.getParameter("out_returnVal");
	String returnNum = request.getParameter("returnNum");
	String qc_flag = request.getParameter("qc_flag");
	/****************获得质检对象流水、考评内容流水、被检通话流水结束******************/
%>

<%@page contentType="text/html;charset=GBK"%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<title><%=opName%></title>
</head>

<frameset cols="170,*" frameborder="no" border="0" framespacing="0">
<frame src="<%=request.getContextPath()%>/npage/callbosspage/checkWork/K400/K400_qc_item_tree.jsp?object_id=<%=object_id%>&content_id=<%=content_id%>" name="leftFrame" scrolling="auto" id="leftFrame" style="border:solid #DFE8F6 3px;cursor:move"/>
<frame src="<%=request.getContextPath()%>/npage/callbosspage/checkWork/K400/K400_out_plan_qc_form.jsp?serialnum=<%=serialnum%>&opCode=<%=opCode%>&opName=<%=opName%>&object_id=<%=object_id%>&content_id=<%=content_id%>&isOutPlanflag=<%=isOutPlanflag%>&staffno=<%=staffno%>&plan_id=<%=plan_id%>&group_flag=<%=group_flag%>&tabId=<%=tabId%>&qc_objectvalue=<%=qc_objectvalue%>&qc_contentvalue=<%=qc_contentvalue%>&out_returnVal=<%=out_returnVal%>&returnNum=<%=returnNum%>" name="mainFrame" id="mainFrame" style="border:solid #DFE8F6 3px;cursor:move"/>
</frameset>

<noframes>
<body>
</body>
</noframes>
</html>

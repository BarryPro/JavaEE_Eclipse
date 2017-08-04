<%
  /*
   * 功能: 计划外质检
　 * 版本: 1.0.0
　 * 日期: 2008/11/05
　 * 作者: mixh
　 * 版权: sitech
   * update:
　 */
%>
<%
	String opCode = request.getParameter("opCode");
	String opName = request.getParameter("opName");
	
	if(opCode == null || opCode ==""){
			opCode = "K217";
	}
	
	if(opName == null || opName ==""){
			opName = "计划外质检";
	}	
%>

<%
/****************获得质检对象流水、考评内容流水开始******************/
String object_id  = request.getParameter("object_id");
String content_id = request.getParameter("content_id");
String serialnum  = request.getParameter("serialnum");
String isOutPlanflag = request.getParameter("isOutPlanflag");
String staffno = request.getParameter("staffno");

if(object_id == null || object_id == ""){
		object_id = "01";
}
if(content_id == null || content_id == ""){
		content_id = "02";
}
/**********获得质检对象流水、考评内容流水开始**************************/
%>

<%@page contentType="text/html;charset=GBK"%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<title><%=opName%></title>
</head>

<frameset cols="100,*" frameborder="no" border="0" framespacing="0">
<frame src="<%=request.getContextPath()%>/npage/callbosspage/checkWork/K217/K217_qc_item_tree.jsp?object_id=<%=object_id%>&content_id=<%=content_id%>" id="leftFrame" name="leftFrame" scrolling="auto" style="border:solid #DFE8F6 3px;cursor:move"/>
<frame src="<%=request.getContextPath()%>/npage/callbosspage/checkWork/K217/K217_out_plan_qc_form.jsp?serialnum=<%=serialnum%>&opCode=<%=opCode%>&opName=<%=opName%>&object_id=<%=object_id%>&content_id=<%=content_id%>&staffno=<%=staffno%>" name="mainFrame" id="mainFrame" style="border:solid #DFE8F6 3px;cursor:move"/>
</frameset>

<noframes>
<body>
</body>
</noframes>
</html>

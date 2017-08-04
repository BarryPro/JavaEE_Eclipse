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
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ page import="com.sitech.crmpd.core.wtc.util.*,java.util.*"%>

<html>
<head>
<title></title>
</head>
<%
String serialnum  = WtcUtil.repNull((String)request.getParameter("serialnum"));//当前质检流水
String object_id  = WtcUtil.repNull(request.getParameter("object_id"));
String content_id = WtcUtil.repNull(request.getParameter("content_id"));
String mod_flag  = WtcUtil.repNull(request.getParameter("mod_flag"));
String isOutPlanflag  = WtcUtil.repNull(request.getParameter("isOutPlanflag"));
String staffno = WtcUtil.repNull((String)request.getParameter("staffno"));
String isAdjust  = WtcUtil.repNull(request.getParameter("isAdjust"));
String opCode = WtcUtil.repNull(request.getParameter("opCode"));
String opName  = WtcUtil.repNull(request.getParameter("opName"));
String tabId   = request.getParameter("tabId");//tab页面的id值
%>

<frameset cols="170,*" frameborder="no" border="0" framespacing="0">
<frame src="<%=request.getContextPath()%>/npage/callbosspage/checkWork/K217/K217_qc_item_tree.jsp?object_id=<%=object_id%>&content_id=<%=content_id%>" name="leftFrame" scrolling="auto"  id="leftFrame" style="border:solid #DFE8F6 3px;cursor:move"/>
<frame src="./K214_modify_plan_qc_form.jsp?serialnum=<%=serialnum%>&object_id=<%=object_id%>&content_id=<%=content_id%>&isOutPlanflag=<%=isOutPlanflag%>&staffno=<%=staffno%>&isAdjust=<%=isAdjust%>&opCode=<%=opCode%>&opName=<%=opName%>&tabId=<%=tabId%>&mod_flag=<%=mod_flag%>" name="mainFrame" id="mainFrame" style="border:solid #DFE8F6 3px;cursor:move"/>
</frameset>

<noframes>
<body>
</body>
</noframes>
</html>

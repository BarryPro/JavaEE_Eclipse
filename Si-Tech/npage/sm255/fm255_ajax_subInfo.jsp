<%
  /*
   * 功能: m255·外省有价卡补录投诉单号 
   * 版本: 1.0
   * 日期: 2015/4/6 
   * 作者: diling
   * 版权: si-tech
  */
%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ page contentType="text/html; charset=GBK" %>
<%
  String regionCode = (String)session.getAttribute("regCode");
  String opCode = request.getParameter("opCode");
  String opName = request.getParameter("opName");
  String printAccp = request.getParameter("printAccp");
  String operWorkNo = request.getParameter("operWorkNo");
  String operPhoneNo = request.getParameter("operPhoneNo");
  String orderNo = request.getParameter("orderNo");
  String opNote = "工号["+operWorkNo+"]进行了["+opName+"]操作";
%>
<wtc:service name="sM255Upd" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode" retmsg="retMsg" outnum="2">
	<wtc:param value="<%=printAccp%>"/>
	<wtc:param value="01"/>
	<wtc:param value="<%=opCode%>"/>
	<wtc:param value="<%=operWorkNo%>"/>
	<wtc:param value=""/>
	<wtc:param value="<%=operPhoneNo%>"/>
	<wtc:param value=""/>
	<wtc:param value="<%=opNote%>"/>
	<wtc:param value="<%=orderNo%>"/>
</wtc:service>
<wtc:array id="ret"  scope="end"/>

var response = new AJAXPacket();
response.data.add("retCode", "<%=retCode%>");
response.data.add("retMsg", "<%=retMsg%>");
core.ajax.receivePacket(response);

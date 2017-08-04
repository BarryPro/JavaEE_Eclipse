<%
  /*
   * 功能: 家庭成员管理
   * 版本: 1.0
   * 日期: 2013-5-9 13:51:47
   * 作者: yansca
   * 版权: si-tech
   * update:
  */
%>
<% request.setCharacterEncoding("GBK");%>
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>

 <%
  String workNo = (String)session.getAttribute("workNo");
	String regionCode = (String)session.getAttribute("regCode");
	String password = (String)session.getAttribute("password");
	String orgCode  = (String)session.getAttribute("orgCode");
	String groupId  = (String)session.getAttribute("groupId");
	String orgId    = (String)session.getAttribute("orgId");
	String opCode = WtcUtil.repNull(request.getParameter("opCode"));
	String opName = WtcUtil.repNull(request.getParameter("opName"));
	String relId = WtcUtil.repNull(request.getParameter("relId"));
	String masterCustId = WtcUtil.repNull(request.getParameter("masterCustId"));
	String phoneNo = WtcUtil.repNull(request.getParameter("phoneNo"));
	String custId = WtcUtil.repNull(request.getParameter("custId"));
	String loginAccept = WtcUtil.repNull(request.getParameter("loginAccept"));
%>

<wtc:service name="sG645ChgMaster" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode" retmsg="retMsg" outnum="2" >
	      <wtc:param value="<%=loginAccept%>"/>
	      <wtc:param value="01"/>
	      <wtc:param value="<%=opCode%>"/>
	      <wtc:param value="<%=workNo%>"/>
	      <wtc:param value="<%=password%>"/>
	      <wtc:param value=""/>
	      <wtc:param value=""/>
	      <wtc:param value="<%=relId%>"/>
	      <wtc:param value="<%=masterCustId%>"/>
	      <wtc:param value="<%=phoneNo%>"/>
	      <wtc:param value="<%=custId%>"/>
</wtc:service>

var response = new AJAXPacket();
response.data.add("retCode","<%=retCode%>");
response.data.add("retMsg","<%=retMsg%>");
response.data.add("phoneNo","<%=phoneNo%>");
core.ajax.receivePacket(response);


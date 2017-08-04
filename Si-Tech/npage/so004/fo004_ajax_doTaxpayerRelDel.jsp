<%
  /*
   * 功能: 家庭成员管理
   * 版本: 1.0
   * 日期: 2013-4-27 14:38:59
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
	String DelCustId = WtcUtil.repNull(request.getParameter("DelCustId"));
	String delMod = WtcUtil.repNull(request.getParameter("delMod"));
	String loginAccept = WtcUtil.repNull(request.getParameter("loginAccept"));
%>

<wtc:service name="so001RelDel" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode" retmsg="retMsg" outnum="2" >
	      <wtc:param value="<%=loginAccept%>"/>
	      <wtc:param value="01"/>
	      <wtc:param value="o003"/>
	      <wtc:param value="<%=workNo%>"/>
	      <wtc:param value="<%=password%>"/>
	      <wtc:param value=""/>
	      <wtc:param value=""/>
	      <wtc:param value="<%=DelCustId%>"/>
	      <wtc:param value="<%=delMod%>"/>
</wtc:service>

var response = new AJAXPacket();
response.data.add("retCode","<%=retCode%>");
response.data.add("retMsg","<%=retMsg%>");
core.ajax.receivePacket(response);


<%
   /*
   * 功能: 审批
　 * 版本: v1.0
　 * 日期: 2013/10/17
　 * 作者: wangjxc
　 * 版权: sitech
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
	String ApproveIdea = request.getParameter("ApproveIdea");
	String UpCustOne = request.getParameter("UpCustOne");
	String UptCustId = request.getParameter("UptCustId");
	String AppFlag = request.getParameter("AppFlag");
	String AppStatus = request.getParameter("AppStatus");
	String AppState = request.getParameter("AppState");
	String loginAccept = WtcUtil.repNull(request.getParameter("loginAccept"));
%>

<wtc:service name="so001AppUpt" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode" retmsg="retMsg" outnum="2" >
	      <wtc:param value="<%=loginAccept%>"/>
	      <wtc:param value="01"/>
	      <wtc:param value="o003"/>
	      <wtc:param value="<%=workNo%>"/>
	      <wtc:param value="<%=password%>"/>
	      <wtc:param value=""/>
	      <wtc:param value=""/>
	      <wtc:param value="<%=UpCustOne%>"/>
	      <wtc:param value="<%=ApproveIdea%>"/>
	      <wtc:param value="<%=AppFlag%>"/>
	      <wtc:param value="<%=AppStatus%>"/>
	      <wtc:param value="<%=AppState%>"/>
	      <wtc:param value="<%=UptCustId%>"/>
</wtc:service>

var response = new AJAXPacket();
response.data.add("retCode","<%=retCode%>");
response.data.add("retMsg","<%=retMsg%>");
core.ajax.receivePacket(response);
<%
  /*
   * 功能: 家庭成员管理
   * 版本: 1.0
   * 日期: 2013-4-28 14:09:08
   * 作者: hejwa
   * 版权: si-tech
   * update:
  */
%>
<% request.setCharacterEncoding("GBK");%>
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>

 <%
  String workNo     = (String)session.getAttribute("workNo");
	String regionCode = (String)session.getAttribute("regCode");
	String password   = (String)session.getAttribute("password");
	String orgCode    = (String)session.getAttribute("orgCode");
	String groupId    = (String)session.getAttribute("groupId");
	String orgId      = (String)session.getAttribute("orgId");
	
	String opCode     = WtcUtil.repNull(request.getParameter("opCode"));
	String opName     = WtcUtil.repNull(request.getParameter("opName"));
	String masterFlag = WtcUtil.repNull(request.getParameter("masterFlag"));
	String userId     = WtcUtil.repNull(request.getParameter("userId"));
	String custId     = WtcUtil.repNull(request.getParameter("custId"));
	String phoneNo    = WtcUtil.repNull(request.getParameter("phoneNo"));
	/*
	System.out.println("hejwa--------------------opCode----------------"+opCode);
	System.out.println("hejwa--------------------opName----------------"+opName);
	System.out.println("hejwa--------------------masterFlag------------"+masterFlag);
	System.out.println("hejwa--------------------userId----------------"+userId);
	System.out.println("hejwa--------------------custId----------------"+custId);
	System.out.println("hejwa--------------------phoneNo---------------"+phoneNo);
	*/
%>

<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="regioncode" 
			routerValue="<%=regionCode%>"  id="loginAccept" />
<wtc:service name="sG645AddMem" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode" retmsg="retMsg" outnum="2" >
	      <wtc:param value="<%=loginAccept%>"/>
	      <wtc:param value="01"/>
	      <wtc:param value="<%=opCode%>"/>
	      <wtc:param value="<%=workNo%>"/>
	      <wtc:param value="<%=password%>"/>
	      <wtc:param value=""/>
	      <wtc:param value=""/>
	      <wtc:param value="<%=custId%>"/>
		    <wtc:param value="<%=userId%>"/>  
        <wtc:param value="0"/>  
        <wtc:param value="<%=phoneNo%>"/>  
        <wtc:param value="0"/>   
</wtc:service>	

var response = new AJAXPacket();
response.data.add("retCode","<%=retCode%>");
response.data.add("retMsg","<%=retMsg%>");
core.ajax.receivePacket(response);
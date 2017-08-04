<%
  /*
   * 功能: 4G备卡卡号录入 m036
   * 版本: 1.0
   * 日期: 2014/1/13 
   * 作者: diling
   * 版权: si-tech
  */
%>
<%@ page contentType="text/html; charset=gb2312"%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%
	String simNo = request.getParameter("simNo");
	String opCode = request.getParameter("opCode");
	String v_phoneNo = request.getParameter("v_phoneNo");
	String v_simType = request.getParameter("v_simType");
	String v_hlrCode = request.getParameter("v_hlrCode");
	String workNo = (String)session.getAttribute("workNo");
	String workPwd = (String)session.getAttribute("password");
	String regCode=(String)session.getAttribute("regCode");
	String notes = "4G备卡信息录入";
%>
	<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="region" routerValue="<%=regCode%>" id="printAccept"/>

	<wtc:service name="sM036Cfm" routerKey="region" routerValue="<%=regCode%>" retcode="retCode2" retmsg="retMsg2" outnum="4" >
		<wtc:param value="<%=printAccept%>"/>
		<wtc:param value="01"/>
		<wtc:param value="<%=opCode%>"/>
		<wtc:param value="<%=workNo%>"/>
		<wtc:param value="<%=workPwd%>"/>
		<wtc:param value="<%=v_phoneNo%>"/>
		<wtc:param value=""/>
		<wtc:param value="<%=simNo%>"/>
		<wtc:param value="<%=v_hlrCode%>"/>
		<wtc:param value="<%=v_simType%>"/>
		<wtc:param value="<%=notes%>"/>
	</wtc:service>
	<wtc:array id="result"  scope="end" />

var response = new AJAXPacket();
response.data.add("retCode2","<%=retCode2%>");
response.data.add("retMsg2","<%=retMsg2%>");
core.ajax.receivePacket(response);

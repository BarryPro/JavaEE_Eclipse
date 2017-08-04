<%
  /*
   * 功能: 物流单下单确认 预占操作 a381
   * 版本: 1.0
   * 日期: 2013/10/9
   * 作者: diling
   * 版权: si-tech
   * update:
   */
%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<% request.setCharacterEncoding("GBK");%>
<%@ page contentType="text/html; charset=GBK" %>
<%
	String opCode 	= "a381";
	String loginNo 	= (String)session.getAttribute("workNo");
	String loginPwd = (String)session.getAttribute("password");
	String orgCode 		= (String)session.getAttribute("orgCode");
	String regionCode 	= orgCode.substring(0,2);
	String groupId 	= (String)session.getAttribute("groupId");
	String phoneNo 	= request.getParameter("phoneNo");
	String orderId 	= request.getParameter("orderId");
	String phoneStatus= "1";	
%>
<wtc:service name="sA381SubCfm" routerKey="region" outnum="2" 
	routerValue="<%=regionCode%>" retCode="retCode1" retMsg="retMsg1" >
	<wtc:param value=""/>
	<wtc:param value="01"/>
	<wtc:param value="<%=opCode%>"/>
	<wtc:param value="<%=loginNo%>"/>
	<wtc:param value="<%=loginPwd%>"/>
		
	<wtc:param value="<%=phoneNo%>"/>
	<wtc:param value=""/>
	<wtc:param value=""/>
	<wtc:param value="<%=orderId%>"/>
	<wtc:param value="07"/>
</wtc:service>
<wtc:array id="result11" scope="end"/>

var response = new AJAXPacket();
response.data.add("retCode","<%=retCode1%>");
response.data.add("retMsg","<%=retMsg1%>");
core.ajax.receivePacket(response);

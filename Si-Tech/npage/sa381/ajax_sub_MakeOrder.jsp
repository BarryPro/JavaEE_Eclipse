<%
  /*
   * 功能: 物流单下单确认 下单操作 a381
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
	String phone 	= request.getParameter("phone");//服务号码
	String orderId 	= request.getParameter("orderId");//订单平台订单ID
	String orderItemId 	= request.getParameter("orderItemId");//订单平台订单ID
	String express 	= request.getParameter("express");//快递:两位数字，1顺丰、2中通
	String contactOrderNos 	= request.getParameter("contactOrderNos");//快递编号:非顺丰时传入
%>
<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="region" 	routerValue="<%=regionCode%>"  id="loginAccept" />
  
<wtc:service name="sA381Cfm" routerKey="region" routerValue="<%=regionCode%>" retCode="retCode1" retMsg="retMsg1" outnum="2" >
	<wtc:param value="<%=loginAccept%>"/>
	<wtc:param value="01"/>
	<wtc:param value="<%=opCode%>"/>
	<wtc:param value="<%=loginNo%>"/>
	<wtc:param value="<%=loginPwd%>"/>
	<wtc:param value="<%=phone%>"/>
	<wtc:param value=""/>
	<wtc:param value="<%=orderId%>"/>
	<wtc:param value="<%=orderItemId%>"/>
	<wtc:param value="1"/> <%//0、外呼失败 1、外呼成功 2、出库 3、回单成功%>
	<wtc:param value=""/>  <%//配送地址（外呼修改地址时有值）%>
	<wtc:param value="1"/> <%//是否通知物流下单0、否  1、是 %>
	<wtc:param value="<%=express%>"/> 
	<wtc:param value="<%=contactOrderNos%>"/> 
</wtc:service>
<wtc:array id="result11" scope="end"/>

var response = new AJAXPacket();
response.data.add("retCode","<%=retCode1%>");
response.data.add("retMsg","<%=retMsg1%>");
core.ajax.receivePacket(response);

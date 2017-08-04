<%
  /*
   * 功能: m218·集团客户购充值卡
   * 版本: 1.0
   * 日期: 2015/1/8 
   * 作者: diling
   * 版权: si-tech
  */
%>
<%@ page contentType="text/html; charset=GB2312" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%
	String regCode=WtcUtil.repNull((String)session.getAttribute("regCode"));
	String loginNo= (String)session.getAttribute("workNo");
	String password = (String)session.getAttribute("password");

	String opCode = WtcUtil.repStr(request.getParameter("opCode"), "");
	String cardBeginNo = WtcUtil.repStr(request.getParameter("cardBeginNo"), "");
	String cardEndNo = WtcUtil.repStr(request.getParameter("cardEndNo"), "");
	String card_num = WtcUtil.repStr(request.getParameter("card_num"), "");
	String sale_price = WtcUtil.repStr(request.getParameter("sale_price"), "");
	String real_salePrice = WtcUtil.repStr(request.getParameter("real_salePrice"), "");
	String res_code = WtcUtil.repStr(request.getParameter("res_code"), "");
	String ip_Addr = (String)session.getAttribute("ipAddr");
	String login_accept = WtcUtil.repStr(request.getParameter("login_accept"), "");
%>
	<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="region" routerValue="<%=regCode%>" id="printAccept"/>
		
	<wtc:service name="sm219Cfm" routerKey="regionCode" routerValue="<%=regCode%>" retcode="retCode" retmsg="retMsg" outnum="7">
		<wtc:param value="<%=printAccept%>"/>
		<wtc:param value="01"/>
		<wtc:param value="<%=opCode%>"/> 
		<wtc:param value="<%=loginNo%>"/>
		<wtc:param value="<%=password%>"/> 
		<wtc:param value=""/>
		<wtc:param value=""/>
		<wtc:param value="<%=cardBeginNo%>"/>
		<wtc:param value="<%=cardEndNo%>"/>
		<wtc:param value="<%=card_num%>"/>
		<wtc:param value="<%=sale_price%>"/>
		<wtc:param value="<%=real_salePrice%>"/>
		<wtc:param value="<%=res_code%>"/>
		<wtc:param value="<%=ip_Addr%>"/>
		<wtc:param value="<%=login_accept%>"/>
	</wtc:service>
	<wtc:array id="ret"  scope="end"/>

var response = new AJAXPacket();
response.data.add("retCode","<%=retCode%>");
response.data.add("retMsg","<%=retMsg%>");
core.ajax.receivePacket(response);
 
	    
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ page contentType="text/html; charset=GB2312" %>
<%@ page import="com.sitech.crmpd.core.wtc.utype.UType"%>
<%@ page import="com.sitech.crmpd.core.wtc.utype.UtypeUtil"%>
<%@ page import="com.sitech.crmpd.core.wtc.utype.UElement"%>
<%@ page import="com.sitech.crmpd.core.wtc.WtcUtil"%>
<%
		//----------------已有订购关系退订-----------------------
		String loginAccept = WtcUtil.repNull(request.getParameter("loginAccept"));
		String servId = WtcUtil.repNull(request.getParameter("servId"));
		String offerInstId = WtcUtil.repNull(request.getParameter("offerInstId"));
		String offerId = WtcUtil.repNull(request.getParameter("offerId"));
		String optype = WtcUtil.repNull(request.getParameter("optype"));
		String workNo = (String)session.getAttribute("workNo");
%>
<wtc:utype name="sCutOfferInst" id="retVal" scope="end">
  <wtc:uparam value="<%=loginAccept%>" type="long"/>
  <wtc:uparam value="<%=servId%>" type="long"/>
  <wtc:uparam value="<%=offerInstId%>" type="long"/>
  <wtc:uparam value="<%=offerId%>" type="long"/>	
  <wtc:uparam value="<%=workNo%>" type="string"/>
  <wtc:uparam name="opCode" type="string"/>	
  <wtc:uparam value="3" type="string"/>				
</wtc:utype>

<%
	String retCode = retVal.getValue(0);
	String retMsg  = retVal.getValue(1).replaceAll("\\n"," ");
%>

var response = new AJAXPacket();

response.data.add("errorCode","<%=retCode%>");
response.data.add("errorMsg","<%=retMsg%>");
response.data.add("optype","<%=optype%>");
response.data.add("offerId","<%=offerId%>");
core.ajax.receivePacket(response);
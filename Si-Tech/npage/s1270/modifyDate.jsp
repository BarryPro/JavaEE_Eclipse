<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ page contentType="text/html; charset=GB2312" %>
<%@ page import="com.sitech.crmpd.core.wtc.utype.UType"%>
<%@ page import="com.sitech.crmpd.core.wtc.utype.UtypeUtil"%>
<%@ page import="com.sitech.crmpd.core.wtc.utype.UElement"%>
<%@ page import="com.sitech.crmpd.core.wtc.WtcUtil"%>
<%
		//----------------³·Ïú±¾´ÎÍË¶©-----------------------
		String loginAccept = WtcUtil.repNull(request.getParameter("loginAccept"));
		String servId = WtcUtil.repNull(request.getParameter("servId"));
		String offerInstId = WtcUtil.repNull(request.getParameter("offerInstId"));
		String offerId = WtcUtil.repNull(request.getParameter("offerId"));
		String phoneNo = WtcUtil.repNull(request.getParameter("phoneNo"));
		String newEffTime = WtcUtil.repNull(request.getParameter("newEffTime"));
		String newExpTime = WtcUtil.repNull(request.getParameter("newExpTime"));
		String workNo = (String)session.getAttribute("workNo");
%>
<wtc:utype name="sCutQuitOffer" id="retVal" scope="end">
  <wtc:uparam value="<%=loginAccept%>" type="long"/>
  <wtc:uparam value="<%=servId%>" type="long"/>
  <wtc:uparam value="<%=offerInstId%>" type="long"/>
  <wtc:uparam value="<%=offerId%>" type="long"/>	
  <wtc:uparam value="<%=newEffTime%>" type="string"/>	
  <wtc:uparam value="<%=newExpTime%>" type="string"/>			
  <wtc:uparam value="<%=workNo%>" type="string"/>
  <wtc:uparam value="qp01" type="string"/>
  <wtc:uparam value="<%=phoneNo%>" type="string"/>				
</wtc:utype>

<%
	String retCode = retVal.getValue(0);
	String retMsg  = retVal.getValue(1).replaceAll("\\n"," ");
%>

var response = new AJAXPacket();

response.data.add("errorCode","<%=retCode%>");
response.data.add("errorMsg","<%=retMsg%>");
core.ajax.receivePacket(response);
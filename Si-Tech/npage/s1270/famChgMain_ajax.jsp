<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ page contentType="text/html;charset=GB2312"%>
<%@ page import="com.sitech.crmpd.core.wtc.utype.UType"%>
<%@ page import="com.sitech.crmpd.core.wtc.utype.UtypeUtil"%>
<%@ page import="com.sitech.crmpd.core.wtc.utype.UElement"%>
<%
		String offerId = WtcUtil.repNull(request.getParameter("offerId"));
		String loginAccept = WtcUtil.repNull(request.getParameter("loginAccept"));
		String servId = WtcUtil.repNull(request.getParameter("servId"));
		String phoneNo = WtcUtil.repNull(request.getParameter("phoneNo"));
		
		System.out.println("offerId=="+offerId);
		System.out.println("loginAccept=="+loginAccept);
		System.out.println("servId=="+servId);
		System.out.println("phoneNo=="+phoneNo);
%>
	<wtc:utype name="sDelMemSrv" id="retVals" scope="end" >	
		<wtc:uparam value="<%=phoneNo%>" type="string"/>
		<wtc:uparam value="<%=offerId%>" type="int"/>
	  <wtc:uparam value="<%=servId%>" type="long"/>
	  <wtc:uparam value="<%=loginAccept%>" type="long"/>		
  </wtc:utype>
<%

String retCode = retVals.getValue(0);
String retMsg  = retVals.getValue(1).replaceAll("\\n"," ");

%>
var response = new AJAXPacket();
response.data.add("retcode","<%=retCode%>");
response.data.add("retmsg","<%=retMsg%>");
core.ajax.receivePacket(response);
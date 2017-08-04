<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ page contentType="text/html; charset=GB2312" %>
<%@ page import="com.sitech.crmpd.core.wtc.utype.UType"%>
<%@ page import="com.sitech.crmpd.core.wtc.utype.UtypeUtil"%>
<%@ page import="com.sitech.crmpd.core.wtc.utype.UElement"%>
<%@ page import="com.sitech.crmpd.core.wtc.WtcUtil"%>
<%
		String offerId = WtcUtil.repNull(request.getParameter("offerId"));
		String workNo = (String)session.getAttribute("workNo");
%>

<wtc:utype name="sPMDBookMark" id="retVal" scope="end">
	<wtc:uparam value="<%=workNo%>" type="string"/>
  <wtc:uparam value="<%=offerId%>" type="long"/>
</wtc:utype>

<%
	String retCode = retVal.getValue(0);
	String retMsg  = retVal.getValue(1).replaceAll("\\n"," ");;
%>

var response = new AJAXPacket();

response.data.add("errorCode","<%=retCode%>");
response.data.add("errorMsg","<%=retMsg%>");
core.ajax.receivePacket(response);
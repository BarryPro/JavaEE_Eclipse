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
<wtc:utype name="sPMIBookMark" id="retVal" scope="end">
	<wtc:uparam value="<%=workNo%>" type="string"/>
  <wtc:uparam value="<%=offerId%>" type="long"/>
</wtc:utype>

<%
	StringBuffer logBuffer = new StringBuffer(80);
	WtcUtil.recursivePrint(retVal,1,"2",logBuffer);
	System.out.println(logBuffer.toString());
	
	String retCode = retVal.getValue(0);
	String retMsg  = retVal.getValue(1).replaceAll("\\n"," ");
	String showMsg = "";
	if(retCode.equals("0") && retVal.getUtype("2").getSize() > 0){
		showMsg = retVal.getValue("2.0");
	}	
	System.out.println("---------showMsg----------------"+showMsg);
%>

var response = new AJAXPacket();

response.data.add("errorCode","<%=retCode%>");
response.data.add("errorMsg","<%=retMsg%>");
response.data.add("showMsg","<%=showMsg%>");
core.ajax.receivePacket(response);
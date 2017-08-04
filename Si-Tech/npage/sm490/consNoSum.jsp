<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ page contentType="text/html; charset=GB2312" %>
<%@ page import="com.sitech.crmpd.core.wtc.utype.UType"%>
<%@ page import="com.sitech.crmpd.core.wtc.utype.UtypeUtil"%>
<%@ page import="com.sitech.crmpd.core.wtc.utype.UElement"%>
<%@ page import="com.sitech.crmpd.core.wtc.WtcUtil"%>
<%
		String offerId = WtcUtil.repNull(request.getParameter("offerId"));		
		System.out.println("----------------------offerId------------------"+offerId);		
%>
<wtc:utype name="sQryMemCount" id="retVal" scope="end">
		<wtc:uparam value="<%=offerId%>" type="int"/>
</wtc:utype>

<%
	String retCode = retVal.getValue(0);
	String retMsg  = retVal.getValue(1).replaceAll("\\n"," ");
	
	
	System.out.println("-----------retCode----------"+retCode);
	System.out.println("-----------retMsg-----------"+retMsg);
	
	StringBuffer logBuffer = new StringBuffer(80);
	WtcUtil.recursivePrint(retVal,1,"2",logBuffer);
	System.out.println(logBuffer.toString());
	
String  maxV1 = retVal.getUtype("2").getValue(0);
String  maxV2 = retVal.getUtype("2").getValue(1);
String  maxV3 = retVal.getUtype("2").getValue(2);
String  maxV4 = retVal.getUtype("2").getValue(3);

	
	System.out.println("-----------maxV1-----------"+maxV1);
	System.out.println("-----------maxV2-----------"+maxV2);
	System.out.println("-----------maxV3-----------"+maxV3);
	System.out.println("-----------maxV4-----------"+maxV4);
%>

var response = new AJAXPacket();

response.data.add("errorCode","<%=retCode%>");
response.data.add("errorMsg","<%=retMsg%>");
response.data.add("maxV1","<%=maxV1%>");
response.data.add("maxV2","<%=maxV2%>");
response.data.add("maxV3","<%=maxV3%>");
response.data.add("maxV4","<%=maxV4%>");

core.ajax.receivePacket(response);
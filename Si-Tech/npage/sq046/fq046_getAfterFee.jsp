<%@ page contentType= "text/html;charset=gb2312" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>

<%@ page import="com.sitech.crmpd.core.wtc.utype.UType"%>
<%@ page import="com.sitech.crmpd.core.wtc.utype.UtypeUtil"%>
<%@ page import="com.sitech.crmpd.core.wtc.utype.UElement"%>
<%
System.out.println("----------------------------------------------fq046_getAfterFee.jsp---------------------------------------");
	String phoneNo = request.getParameter("phone_no");
	String payFeeAfter = "";
	System.out.println(".............................phoneNo=="+phoneNo);
	UType phoneUtype = new UType();
	phoneUtype.setUe("STRING", phoneNo);    			  				
	%>
		<wtc:utype name="sShowNumInfo" id="retVal2" scope="end" >
	          <wtc:uparam value="<%=phoneUtype%>" type="UTYPE"/>      
	    </wtc:utype>
	<%
	String retCode = retVal2.getValue(0);
	String retMsg = retVal2.getValue(1);
	String phoneNum ="";
	String prePayFee ="";
	String jifen ="";
	System.out.println(retCode + "==retCode.............................retMsg=="+retMsg);
	if(retCode.equals("0")){
		phoneNum = retVal2.getValue("2.0.0");
		prePayFee = retVal2.getValue("2.0.1");
		jifen = retVal2.getValue("2.0.2");
		payFeeAfter = prePayFee +"~" + jifen + "~";
	 }
%>
var response = new AJAXPacket();
response.data.add("retCode","<%=retCode%>");
response.data.add("retMsg","<%=retMsg%>");
response.data.add("payFeeAfter","<%=payFeeAfter%>");
core.ajax.receivePacket(response);
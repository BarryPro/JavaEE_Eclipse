<%@ page contentType= "text/html;charset=gb2312" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ page import="com.sitech.crmpd.core.wtc.utype.UType"%>
<%@ page import="com.sitech.crmpd.core.wtc.utype.UtypeUtil"%>
<%@ page import="com.sitech.crmpd.core.wtc.utype.UElement"%>

<%
  String login_no =(String) session.getAttribute("workNo");//工号
  String offerId = WtcUtil.repNull(request.getParameter("offer_id"));//销售品编码
  String phoneNo = WtcUtil.repNull(request.getParameter("phoneNo"));//销售品名称
%>

<wtc:utype name="sChkQhOffer" id="retVal" scope="end">
	<wtc:uparams name="TChkOfferMsg" iMaxOccurs="1">
			<wtc:uparam value="<%=offerId%>" type="LONG"/>  
			<wtc:uparam value="<%=login_no%>" type="STRING"/>  
			<wtc:uparam value="<%=phoneNo%>" type="STRING"/>
	</wtc:uparams>
</wtc:utype>
<%
	 String retCode = retVal.getValue(0);
	 String retMsg = retVal.getValue(1).replaceAll("\\n"," "); 
	 String temp="";
	 	StringBuffer logBuffer = new StringBuffer(80);
                System.out.println(logBuffer.toString());
                WtcUtil.recursivePrint(retVal,1,"2",logBuffer);
	 if(retCode.equals("0"))
	{
	    int n = retVal.getUtype("2").getSize();
	    if(n>0){
	    		temp = retVal.getUtype("2").getValue(0);
	    }
	}else{
			temp="";
		}
%>


var response = new AJAXPacket();
response.data.add("retCode","<%=retCode%>");
response.data.add("retMsg","<%=retMsg%>");
response.data.add("retResult","<%=temp%>");
core.ajax.receivePacket(response);
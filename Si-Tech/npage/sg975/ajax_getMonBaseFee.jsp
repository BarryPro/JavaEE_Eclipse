<%@ page contentType= "text/html;charset=gb2312" %>
<%@ page import="java.math.BigDecimal"%>
<%@ include file="../../npage/bill/getMaxAccept.jsp" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%
	String regionCode= (String)session.getAttribute("regCode");
	String limit_fee = request.getParameter("limit_fee");//底限资费代码
	double monBaseFee = 0.00;//底限资费的月租

  String  inParams [] = new String[2];
  inParams[0] = "select offer_attr_value from product_offer_attr  where offer_attr_seq ='50003'  and  offer_id =:offerid";
  inParams[1] = "offerid="+limit_fee;
%>
  <wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode1" retmsg="retMsg1" outnum="2"> 
    <wtc:param value="<%=inParams[0]%>"/>
    <wtc:param value="<%=inParams[1]%>"/> 
  </wtc:service>  
  <wtc:array id="ret"  scope="end"/>
<%
	  if(("000000").equals(retCode1)) {
	    if(ret.length>0){
	      monBaseFee = Double.parseDouble(ret[0][0]);
	    }
	 }	
%>
	var response = new AJAXPacket();
	response.data.add("retCode","<%=retCode1%>");
	response.data.add("retMsg","<%=retMsg1%>");
	response.data.add("monBaseFee","<%=monBaseFee%>");
	core.ajax.receivePacket(response);

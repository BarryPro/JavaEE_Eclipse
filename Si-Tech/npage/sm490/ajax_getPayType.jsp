<%@ page contentType= "text/html;charset=gb2312" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
 
<%@ page import="com.sitech.crmpd.core.wtc.utype.UType"%>
<%@ page import="com.sitech.crmpd.core.wtc.utype.UtypeUtil"%>
<%@ page import="com.sitech.crmpd.core.wtc.utype.UElement"%>
 
<%
 String servId = WtcUtil.repNull(request.getParameter("servId"));
 String payType = "";
%>
 
<wtc:utype name="sGetServ" id="retVal" scope="end">
		<wtc:uparam value="<%=servId%>" type="long"/>   
</wtc:utype>
<%
	 String retCode = retVal.getValue(0);
	 String retMsg = retVal.getValue(1).replaceAll("\\n"," "); 
%> 
<%
 if("0".equals(retCode)){
  int retNum = retVal.getUtype("2").getSize();
  System.out.println("#########################retNum=="+retNum);
  if(retNum>0){  		
  		payType = retVal.getValue("2.15");
  		System.out.println("#########################payType=="+payType);
  }else{
  	payType = null;
  	}
 } 
%>
 
var response = new AJAXPacket();
response.data.add("payType","<%=payType %>");
core.ajax.receivePacket(response);
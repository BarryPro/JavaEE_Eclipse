<%@ page import="java.util.*"%>
<%@ page import="com.sitech.crmpd.core.wtc.WtcUtil"%>
<%@ taglib uri="/WEB-INF/wtc.tld" prefix="wtc" %>
<%@ page contentType= "text/html;charset=gb2312" %>
<%
  //清除缓存
	response.setHeader("Pragma","No-Cache"); 
	response.setHeader("Cache-Control","No-Cache");
	response.setDateHeader("Expires", 0); 
	
	String workNo = (String)session.getAttribute("workNo");
	String opCode = WtcUtil.repNull(request.getParameter("opCode"));
	String offerId= WtcUtil.repNull(request.getParameter("offerId"));

	System.out.println("-------------------workNo-----------------"+workNo);
	System.out.println("-------------------opCode-----------------"+opCode);
	System.out.println("-------------------offerId----------------"+offerId);
	
	String retCode = "";
	String retMsg  = "";
    
try{	
%>
	<wtc:utype name="sOrderOfrChk" id="retVal" scope="end" >
		<wtc:uparam value="<%=offerId%>" type="INT" />
		<wtc:uparam value="<%=workNo%>" type="STRING" />
		<wtc:uparam value="<%=opCode%>" type="STRING" />
	</wtc:utype>	
<%
		 retCode =retVal.getValue(0);
		 retMsg  =retVal.getValue(1);
}catch(Exception ex){
	retCode = "000404";
	retMsg = "取销售品限制出错";
}		
		System.out.println("-------------------retCode-----------------"+retCode);
	  System.out.println("-------------------retMsg------------------"+retMsg);
%>	

var response = new AJAXPacket();
response.data.add("retCode","<%= retCode %>");
response.data.add("retMsg","<%= retMsg %>");
core.ajax.receivePacket(response);
<%@ page contentType="text/html;charset=GB2312"%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%
	String custId = request.getParameter("custId");
	String currentTime =  new java.text.SimpleDateFormat("yyyyMM").format(new java.util.Date());//当前日期
	String retType = request.getParameter("retType");
%>
<wtc:utype name="sFinishMsg" id="retVal" scope="end" >
          <wtc:uparam value="<%= currentTime %>" type="String"/>      
          <wtc:uparam value="<%= custId %>" type="String"/>      
 </wtc:utype>
<%
	String retCode=retVal.getValue(0);
	String retMsg=retVal.getValue(1);
	System.out.println("retCode========================="+retCode);
	System.out.println("retMsg========================="+retMsg);
%>
	
var response = new AJAXPacket();
response.data.add("retType","<%=retType%>");
response.data.add("retCode","<%=retCode%>");
response.data.add("retMsg","<%=retMsg%>");

core.ajax.receivePacket(response);
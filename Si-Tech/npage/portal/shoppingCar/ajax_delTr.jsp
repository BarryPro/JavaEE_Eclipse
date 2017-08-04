<%@ page contentType="text/html;charset=GB2312"%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%
	String sCustArrOrderId =  request.getParameter("custArrOrderId");
	String workNo = (String)session.getAttribute("workNo");
	System.out.println("sCustArrOrderId=="+sCustArrOrderId);
%>
<wtc:utype name="sOrdArryCncl" id="retVal" >
<wtc:uparam value="<%=sCustArrOrderId%>" type="STRING"/> 
<wtc:uparam value="<%=workNo%>" type="STRING"/>
</wtc:utype>
<%
	 String retCode = retVal.getValue(0);
	 String retMsg  =  retVal.getValue(1).replaceAll("\\n"," "); 
%>
var response = new AJAXPacket();
response.data.add("retCode","<%=retCode%>");
response.data.add("retMsg","<%=retMsg%>");
core.ajax.receivePacket(response);
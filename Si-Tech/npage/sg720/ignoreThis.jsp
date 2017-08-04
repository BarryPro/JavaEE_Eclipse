<%@ page contentType="text/html;charset=GB2312"%>
<%@ include file="/npage/include/public_title_ajax.jsp"%>
<%
System.out.println("-----------------------------ignoreThis.jsp---------------------------------------");  
	String sOrderArrayId = WtcUtil.repNull(request.getParameter("sOrderArrayId"));
	String loginNo = (String)session.getAttribute("workNo");
	String regionCode = (String)session.getAttribute("regCode");
	System.out.println("-----------------------------sOrderArrayId---------------------------------------"+sOrderArrayId);  
%>

<%String regionCode_sOrdArryCncl = (String)session.getAttribute("regCode");%>
<wtc:utype name="sOrdArryCncl" id="retVal"  routerKey="region" routerValue="<%=regionCode_sOrdArryCncl%>">
	<wtc:uparam value="<%=sOrderArrayId%>" type="STRING"/> 
	<wtc:uparam value="<%=loginNo%>" type="STRING"/>
</wtc:utype>
	
<%

  String retrunCode=String.valueOf(retVal.getValue(0));//返回的retCode为LONG类型；
	String returnMsg=retVal.getValue(1);
	
 System.out.println("---------------------------retrunCode-------------------------"+retrunCode);
 System.out.println("---------------------------returnMsg--------------------------"+returnMsg);
%>

var response = new AJAXPacket();
response.data.add("retrunCode","<%=retrunCode%>");
response.data.add("returnMsg","<%=returnMsg%>");
core.ajax.receivePacket(response);

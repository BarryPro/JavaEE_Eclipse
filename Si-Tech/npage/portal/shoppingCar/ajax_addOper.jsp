<%@ page contentType="text/html;charset=GB2312"%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%
	String workNo = (String)session.getAttribute("workNo");
	String vAction_Code =  request.getParameter("vAction_Code");
	String iCust_Type =  request.getParameter("iCust_Type");
	String phone_no =  request.getParameter("phone_no");
	String orgCode = (String) session.getAttribute("orgCode");
  String regionCode = orgCode.substring(0, 2);
	System.out.println("========================"+vAction_Code+"==========="+iCust_Type+"======="+phone_no);
%>
<wtc:service name="sRecommend" routerKey="region" routerValue="<%=regionCode%>"  outnum="2">
	  <wtc:param value="<%=workNo%>"/>
	  <wtc:param value="<%=phone_no%>"/>	
	  <wtc:param value="01"/>
	  <wtc:param value="<%=iCust_Type%>"/>	
	  <wtc:param value="<%=vAction_Code%>"/>	
</wtc:service>

var response = new AJAXPacket();
response.data.add("retCode","<%=retCode%>");
response.data.add("retMsg","<%=retMsg%>");
core.ajax.receivePacket(response);

<% request.setCharacterEncoding("GBK");%>
<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %> 
<%
   	String work_no = (String)session.getAttribute("workNo");
	String regionCode = (String)session.getAttribute("regCode");
	String password = (String)session.getAttribute("password"); 
	String printAccept=request.getParameter("printAccept");//流水
	String iPhoneNo=request.getParameter("iPhoneNo");//手机号
	String phone_type=request.getParameter("phone_type");//机型
	
%>

<wtc:service name="sd069Init" routerKey="region" routerValue="<%=regionCode%>" outnum="2" retcode="retCode" retmsg="retMsg">
	<wtc:param value="<%=printAccept%>"/>
	<wtc:param value="01"/>
	<wtc:param value="d069"/>
	<wtc:param value="<%=work_no%>"/>
	<wtc:param value="<%=password%>"/>
	<wtc:param value="<%=iPhoneNo%>"/>
	<wtc:param value=""/>
	<wtc:param value="<%=phone_type%>"/>
</wtc:service>
<wtc:array id="result" scope="end"/>
	
var response = new AJAXPacket();
response.data.add("retCode","<%=retCode%>");
response.data.add("retMsg","<%=retMsg%>");
core.ajax.receivePacket(response);
	


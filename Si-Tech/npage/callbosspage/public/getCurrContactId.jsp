<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ page import="java.net.InetAddress"%>
<%
	String callPhone = WtcUtil.repNull(request.getParameter("phone_no"));
	String workNo = (String)session.getAttribute("workNo");
	String ip_Addr = (String)session.getAttribute("ipAddr");
%>

<wtc:service name="sInitCntt"  outnum="1">
  <wtc:param value=""/>
  <wtc:param value=""/>
	<wtc:param value=""/>
	<wtc:param value=""/>
	<wtc:param value="1"/>
	<wtc:param value="<%=callPhone%>"/>
	<wtc:param value="01"/>
	<wtc:param value="00"/>
	<wtc:param value="i"/>
	<wtc:param value="<%=workNo%>"/>
	<wtc:param value=""/>
	<wtc:param value=""/>
	<wtc:param value=""/>
	<wtc:param value=""/>		
	<wtc:param value="<%=ip_Addr%>"/>			
</wtc:service>
<wtc:array id="rows"  scope="end"/>

var response = new AJAXPacket();
response.data.add("CurrContactId","<%=rows[0][0]%>");
response.data.add("retCode","<%=retCode%>");
response.data.add("retMsg","<%=retMsg%>");
core.ajax.receivePacket(response);	

<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ page import="com.sitech.boss.pub.util.CreatePlanerArray"%>
<%@ page import="com.sitech.crmpd.core.wtc.utype.UType"%>
<%@ page import="com.sitech.crmpd.core.wtc.utype.UtypeUtil"%>
<%@ page import="com.sitech.crmpd.core.wtc.utype.UElement"%>

<%
		String workNo = (String)session.getAttribute("workNo");
		String regionCode= (String)session.getAttribute("regCode");
		String addtype = request.getParameter("addtype");
		String custOrderId = request.getParameter("custOrderId");
%>
		<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="regioncode" 
			routerValue="<%=regionCode%>"  id="loginAccept" />

   <wtc:utype name="sMktPrintFlag" id="retVal" scope="end" routerKey="region" routerValue="<%=regionCode%>">
     <wtc:uparam value="<%=custOrderId%>" type="STRING"/> 
     <wtc:uparam value="<%=addtype%>" type="STRING"/>  
   </wtc:utype>
<%   
	String errCodeGetCust =retVal.getValue(0);
	String errMsgGetCust  =retVal.getValue(1);
%>

	var response = new AJAXPacket();
	response.data.add("retcode","<%= errCodeGetCust %>");
	response.data.add("retmsg","<%= errMsgGetCust %>");
	core.ajax.receivePacket(response);
<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%
		String workNo = (String)session.getAttribute("workNo");
		String regionCode= (String)session.getAttribute("regCode");
		String idTypeVal = request.getParameter("idType");
		String idIccId = request.getParameter("idIccid");
		String openNum = request.getParameter("openNum");
		String opCode = request.getParameter("opCode");
		
		String openType = request.getParameter("openType");
		String custName = request.getParameter("custName");
		
		
		String  inputParsm [] = new String[11];
		inputParsm[0] = "";
		inputParsm[1] = "01";
		inputParsm[2] = opCode;
		inputParsm[3] = workNo;
		inputParsm[4] = "";
		inputParsm[5] = "";
		inputParsm[6] = "";
		inputParsm[7] = idTypeVal;
		inputParsm[8] = idIccId;
		inputParsm[9] = openType;
		inputParsm[10] = custName;
%>
		<wtc:service name="sE977Cfm" routerKey="region" routerValue="<%=regionCode%>"
					 retcode="retCode" retmsg="retMsg" outnum="1">
				<wtc:param value="<%=inputParsm[0]%>"/>
				<wtc:param value="<%=inputParsm[1]%>"/>
				<wtc:param value="<%=inputParsm[2]%>"/>
				<wtc:param value="<%=inputParsm[3]%>"/>
				<wtc:param value="<%=inputParsm[4]%>"/>
				<wtc:param value="<%=inputParsm[5]%>"/>
				<wtc:param value="<%=inputParsm[6]%>"/>
				<wtc:param value="<%=inputParsm[7]%>"/>
				<wtc:param value="<%=inputParsm[8]%>"/>
				<wtc:param value="<%=inputParsm[9]%>"/>
				<wtc:param value="<%=inputParsm[10]%>"/>
		</wtc:service>
		<wtc:array id="ret" scope="end"/>
<%

%>

	var response = new AJAXPacket();

	response.data.add("retcode","<%= retCode %>");
	response.data.add("retmsg","<%= retMsg %>");
	core.ajax.receivePacket(response);
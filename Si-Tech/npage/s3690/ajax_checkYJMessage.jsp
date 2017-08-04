<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="../../npage/bill/getMaxAccept.jsp" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%
		String workNo = (String)session.getAttribute("workNo");
		String regionCode= (String)session.getAttribute("regCode");
		String password = (String)session.getAttribute("password");
		String ipAddr = (String)session.getAttribute("ipAddr");
		String orgId = (String)session.getAttribute("orgId");		
		String offerids = request.getParameter("offerids");
		String oldpricess = request.getParameter("oldpricess");
		String flagss = request.getParameter("flagss");
		String userPrice = request.getParameter("userPrice");
		String opcode = request.getParameter("opcode");


%>
		<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="regioncode" 
			routerValue="<%=regionCode%>"  id="loginAccept" />
<%
		
		String  inputParsm [] = new String[13];
		inputParsm[0] = workNo;
		inputParsm[1] = regionCode;
		inputParsm[2] = "01";
		inputParsm[3] = opcode;
		inputParsm[4] = "进行议价信息校验";
		inputParsm[5] = loginAccept;
		inputParsm[6] = ipAddr;
		inputParsm[7] = orgId;
		inputParsm[8] = "";
		inputParsm[9] = offerids;
		inputParsm[10] = oldpricess;
		inputParsm[11] = flagss;
		inputParsm[12] = userPrice;

%>
		<wtc:service name="sCustPriceCheck" routerKey="region" routerValue="<%=regionCode%>"
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
				<wtc:param value="<%=inputParsm[11]%>"/>
				<wtc:param value="<%=inputParsm[12]%>"/>

		</wtc:service>
		<wtc:array id="ret" scope="end"/>

	var response = new AJAXPacket();
	response.data.add("retcode","<%= retCode %>");
	response.data.add("retmsg","<%= retMsg %>");
	response.data.add("retprodids","<%= offerids %>");
	core.ajax.receivePacket(response);
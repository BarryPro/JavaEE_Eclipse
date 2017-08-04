<%@ page contentType= "text/html;charset=gb2312" %>
<%@ include file="../../npage/bill/getMaxAccept.jsp" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%
		String workNo = (String)session.getAttribute("workNo");
		String regionCode= (String)session.getAttribute("regCode");
		String password = (String)session.getAttribute("password");
		String ip_Addr = (String)session.getAttribute("ipAddr");
		
		String iAgentPhone = request.getParameter("iAgentPhone");
		String phoneNo = request.getParameter("phoneNo");
		String opCode = request.getParameter("OpCode");
%>
		<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="regioncode" 
			routerValue="<%=regionCode%>"  id="loginAccept" />
<%
		System.out.println(" ==== start fe156_save.jsp ==== " + iAgentPhone + " | " + phoneNo);
		
		String  inputParsm [] = new String[9];
		inputParsm[0] = "0";
		inputParsm[1] = "01";
		inputParsm[2] = opCode;
		inputParsm[3] = workNo;
		inputParsm[4] = password;
		inputParsm[5] = phoneNo;
		inputParsm[6] = "";
		inputParsm[7] = iAgentPhone;
		inputParsm[8] = ip_Addr;
%>
		<wtc:service name="se156Cfm" routerKey="region" routerValue="<%=regionCode%>"
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
		</wtc:service>
		<wtc:array id="ret" scope="end"/>
<%

	if("000000".equals(retCode)){
		System.out.println(" ======== se156Cfm 调用成功 ========"  + retCode + " | " + retMsg);

	}
else {
		System.out.println(" ======== se156Cfm 调用失败 ========" + retCode + " | " + retMsg);
	}
%>

	var response = new AJAXPacket();
	response.data.add("retcode","<%= retCode %>");
	response.data.add("retmsg","<%= retMsg %>");
	core.ajax.receivePacket(response);
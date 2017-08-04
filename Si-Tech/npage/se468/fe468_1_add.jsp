<%@ page contentType= "text/html;charset=gb2312" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%
		String workNo = (String)session.getAttribute("workNo");
		String regionCode= (String)session.getAttribute("regCode");
		String password = (String)session.getAttribute("password");		
		
		String opCode = request.getParameter("opCode");
		String phoneNo = request.getParameter("phoneNo");
		String kehumc = request.getParameter("kehumc");
		String quxiandm = request.getParameter("quxiandm");
		String dishidm = request.getParameter("dishidm");
		String kehdanwei = request.getParameter("kehdanwei");		
		String kehjlphoneno = request.getParameter("kehjlphoneno");
		String kehujlmingc = request.getParameter("kehujlmingc");
		String ip_Addr = request.getParameter("ip_Addr");
		String retQf = request.getParameter("retQf");
		

		String  inputParsm [] = new String[15];
		inputParsm[0] = "0";
		inputParsm[1] = "01";
		inputParsm[2] = opCode;
		inputParsm[3] = workNo;
		inputParsm[4] = password;
		inputParsm[5] = phoneNo;
		inputParsm[6] = "";
		inputParsm[7] = "工号"+workNo+"执行网络优先接入客户录入";
		inputParsm[8] = kehumc;
		inputParsm[9] = quxiandm;
		inputParsm[10] = dishidm;
		inputParsm[11] = kehdanwei;
		inputParsm[12] = kehjlphoneno;
		inputParsm[13] = kehujlmingc;
		inputParsm[14] = ip_Addr;

%>
		<wtc:service name="sE468Cfm" routerKey="region" routerValue="<%=regionCode%>"
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
			  <wtc:param value="<%=inputParsm[13]%>"/>
				<wtc:param value="<%=inputParsm[14]%>"/>

		</wtc:service>
		<wtc:array id="ret" scope="end"/>

	var response = new AJAXPacket();
	response.data.add("retcode","<%= retCode %>");
	response.data.add("retmsg","<%= retMsg %>");
	response.data.add("retQf","<%=retQf%>");
	core.ajax.receivePacket(response);
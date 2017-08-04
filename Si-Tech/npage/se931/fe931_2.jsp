<%@ page contentType= "text/html;charset=gb2312" %>
 <%@ page import="java.math.BigDecimal"%>
<%@ include file="../../npage/bill/getMaxAccept.jsp" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%
		String workNo = (String)session.getAttribute("workNo");
		String regionCode= (String)session.getAttribute("regCode");
		String loginPwd  = (String)session.getAttribute("password");//µÇÂ½ÃÜÂë
		String opCode = request.getParameter("opCode");
		String proType = request.getParameter("proType");
		String valText = request.getParameter("valText");
		String checkedText = request.getParameter("checkedText");
%>
		<wtc:sequence name="TlsPubSelCrm" key="sMaxSysAccept" routerKey="regioncode" 
			routerValue="<%=regionCode%>"  id="loginAccept" />
		
<% 
		String[] inputParams = new String[10];
		inputParams[0] = loginAccept;
		inputParams[1] = "01";
		inputParams[2] = opCode;
		inputParams[3] = workNo;
		inputParams[4] = loginPwd;
		inputParams[5] = "";
		inputParams[6] = "";
		inputParams[7] = proType;
		inputParams[8] = valText;
		inputParams[9] = checkedText;
%>
		<wtc:service name="se931Cfm" routerKey="region" routerValue="<%=regionCode%>"
					 retcode="retCode" retmsg="retMsg" outnum="1">
				<wtc:param value="<%=inputParams[0]%>"/>
				<wtc:param value="<%=inputParams[1]%>"/>
				<wtc:param value="<%=inputParams[2]%>"/>
				<wtc:param value="<%=inputParams[3]%>"/>
				<wtc:param value="<%=inputParams[4]%>"/>
				<wtc:param value="<%=inputParams[5]%>"/>
				<wtc:param value="<%=inputParams[6]%>"/>
				<wtc:param value="<%=inputParams[7]%>"/>
				<wtc:param value="<%=inputParams[8]%>"/>
				<wtc:param value="<%=inputParams[9]%>"/>
		</wtc:service>
		var response = new AJAXPacket();
		response.data.add("retcode","<%= retCode %>");
		response.data.add("retmsg","<%= retMsg %>");
		core.ajax.receivePacket(response);
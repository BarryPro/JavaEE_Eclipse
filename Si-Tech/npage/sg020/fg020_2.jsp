<%@ page contentType= "text/html;charset=gb2312" %>
 <%@ page import="java.math.BigDecimal"%>
<%@ include file="../../npage/bill/getMaxAccept.jsp" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%
		String workNo = (String)session.getAttribute("workNo");
		String regionCode= (String)session.getAttribute("regCode");
		String loginPwd  = (String)session.getAttribute("password");//µÇÂ½ÃÜÂë
		String method = request.getParameter("method");
		String opCode = request.getParameter("opCode");
		String idiccId = request.getParameter("idiccId");
		String custId = request.getParameter("custId");
		String unitId = request.getParameter("unitId");
		String serviceNo = request.getParameter("serviceNo");
		
		String idNo =  request.getParameter("idNo");
		String oprType =  request.getParameter("oprType");
		String offerId =  request.getParameter("offerId");
		String offerIdNew =  request.getParameter("offerIdNew");
%>
		<wtc:sequence name="TlsPubSelCrm" key="sMaxSysAccept" routerKey="regioncode" 
			routerValue="<%=regionCode%>"  id="loginAccept" />
	
<% 	
	if(method != null && method.equals("getBaseInfo")) {
		String[] inputParams = new String[12];
		inputParams[0] = loginAccept;
		inputParams[1] = "01";
		inputParams[2] = opCode;
		inputParams[3] = workNo;
		inputParams[4] = loginPwd;
		inputParams[5] = "";
		inputParams[6] = "";
		inputParams[7] = regionCode;
		inputParams[8] = idiccId;
		inputParams[9] = custId;
		inputParams[10] = unitId;
		inputParams[11] = serviceNo;
		
		for(int i=0;i<inputParams.length;i++) {
			System.out.println("----------liujian-----inputParams[" + i + "]=" + inputParams[i]);
		}
%>
		<wtc:service name="sg020Qry" routerKey="region" routerValue="<%=regionCode%>"
					 retcode="retCode" retmsg="retMsg" outnum="11">
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
				<wtc:param value="<%=inputParams[10]%>"/>
				<wtc:param value="<%=inputParams[11]%>"/>
		</wtc:service>
		<wtc:array id="result" scope="end" />
<%
		System.out.println("--------liujian-------retCode=" + retCode);
		if(retCode.equals("000000")) {
%>
			var response = new AJAXPacket();
			response.data.add("retcode","<%= retCode %>");
			response.data.add("retmsg","<%= retMsg %>");
			response.data.add("oIdiccId","<%= result[0][0] %>");
			response.data.add("oCustId","<%=result[0][1] %>");
			response.data.add("oUnitId","<%=result[0][2] %>");
			response.data.add("oUnitName","<%=result[0][3] %>");
			response.data.add("oServiceNo","<%=result[0][4] %>");
			response.data.add("oIdNo","<%=result[0][5]  %>");
			response.data.add("oProductCode","<%=result[0][6]  %>");
			response.data.add("oProductName","<%=result[0][7] %>");
			response.data.add("oAccountId","<%=result[0][8] %>");
			response.data.add("oZhwwFlag","<%=result[0][9] %>");
			response.data.add("oVpZ0OfferId","<%=result[0][10] %>");
			core.ajax.receivePacket(response);
<%			
		}else {
%>
			var response = new AJAXPacket();
			response.data.add("retcode","<%= retCode %>");
			response.data.add("retmsg","<%= retMsg %>");
			core.ajax.receivePacket(response);
<%
		}
	}else if(method != null && method.equals("submit")) {
		String[] inputParams = new String[11];
		inputParams[0] = loginAccept;
		inputParams[1] = "01";
		inputParams[2] = opCode;
		inputParams[3] = workNo;
		inputParams[4] = loginPwd;
		inputParams[5] = "";
		inputParams[6] = "";
		inputParams[7] = idNo;
		inputParams[8] = oprType;
		inputParams[9] = offerId;
		inputParams[10] = offerIdNew;
		
		for(int i=0;i<inputParams.length;i++) {
			System.out.println("----------liujian---cfm--inputParams[" + i + "]=" + inputParams[i]);
		}
		
%>			
		<wtc:service name="sg020Cfm" routerKey="region" routerValue="<%=regionCode%>"
					 retcode="retCode2" retmsg="retMsg2" outnum="1">
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
				<wtc:param value="<%=inputParams[10]%>"/>
		</wtc:service>
		<wtc:array id="result2" scope="end" />
			
		var response = new AJAXPacket();
		response.data.add("retcode","<%= retCode2 %>");
		response.data.add("retmsg","<%= retMsg2 %>");
		core.ajax.receivePacket(response);
<%			
	}
%>		

		

		
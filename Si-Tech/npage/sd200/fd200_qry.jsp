<%@ page contentType= "text/html;charset=gb2312" %>
<%@ include file="../../npage/bill/getMaxAccept.jsp" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%
		String workNo = (String)session.getAttribute("workNo");
		String regionCode= (String)session.getAttribute("regCode");
		String searchOpCode = request.getParameter("searchOpCode");
		String opCode = request.getParameter("OpCode");
%>
		<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="regioncode" 
			routerValue="<%=regionCode%>"  id="loginAccept" />
<%
		System.out.println(" ==== start fd200_qry.jsp ==== " + searchOpCode + " | " + loginAccept);
		
		String  inputParsm [] = new String[9];
		inputParsm[0] = loginAccept;
		inputParsm[1] = "01";
		inputParsm[2] = opCode;
		inputParsm[3] = workNo;
		inputParsm[4] = "";
		inputParsm[5] = "";
		inputParsm[6] = "";
		inputParsm[7] = "";
		inputParsm[8] = searchOpCode;
%>
		<wtc:service name="sOpcodeQry" routerKey="region" routerValue="<%=regionCode%>"
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
	String vSrvName = "";
	if("000000".equals(retCode)){
		System.out.println(" ======== sOpcodeQry 调用成功 ========" + ret.length + " | " + ret[0].length);
		for(int i = ret.length - 1; i >= 0; i--){
			if(i == 0){
				vSrvName += "(" + searchOpCode + ")";
			}
			vSrvName += ret[i][0].trim() + "-->";
		}
	}
%>

	var response = new AJAXPacket();

	response.data.add("retcode","<%= retCode %>");
	response.data.add("retmsg","<%= retMsg %>");
	response.data.add("vSrvName","<%= vSrvName %>");
	core.ajax.receivePacket(response);
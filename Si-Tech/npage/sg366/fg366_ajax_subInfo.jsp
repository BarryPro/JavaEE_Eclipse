<%
    /*************************************
    * 功  能: 营销限制配置 g366
    * 版  本: version v1.0
    * 开发商: si-tech
    * 创建者: diling @ 2012-12-24
    **************************************/
%>
<%@ page contentType= "text/html;charset=gb2312" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%
		String workNo = (String)session.getAttribute("workNo");
		String regionCode= (String)session.getAttribute("regCode");
		String password = (String)session.getAttribute("password");
		String groupId = (String)session.getAttribute("groupId");
		
		String opCode = WtcUtil.repNull((String)request.getParameter("opCode"));
		String offerIdStr = WtcUtil.repNull((String)request.getParameter("offerIdStr"));
		String orderMainOffer = WtcUtil.repNull((String)request.getParameter("orderMainOffer"));
		String operateLimit = WtcUtil.repNull((String)request.getParameter("operateLimit"));
		String limitCode = WtcUtil.repNull((String)request.getParameter("limitCode"));
		String limitPrompt = WtcUtil.repNull((String)request.getParameter("limitPrompt"));
%>
<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="region" routerValue="<%=regionCode%>" id="printAccept"/>
<%
		String  inputParsm [] = new String[13];
		inputParsm[0] = printAccept;
		inputParsm[1] = "01";
		inputParsm[2] = opCode;
		inputParsm[3] = workNo;
		inputParsm[4] = password;
		inputParsm[5] = "";
		inputParsm[6] = "";
		inputParsm[7] = groupId;
		inputParsm[8] = offerIdStr;
		inputParsm[9] = orderMainOffer;
		inputParsm[10] = operateLimit;
		inputParsm[11] = limitCode;
		inputParsm[12] = limitPrompt;
%>
		<wtc:service name="sProdLimCfg" routerKey="region" routerValue="<%=regionCode%>"
					 retcode="retCode" retmsg="retMsg" outnum="2">
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
	response.data.add("retcode_subInfo","<%=retCode%>");
	response.data.add("retmsg_subInfo","<%=retMsg%>");
	core.ajax.receivePacket(response);
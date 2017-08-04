<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%
		String workNo = (String)session.getAttribute("workNo");
		String regionCode= (String)session.getAttribute("regCode");
		String password = (String)session.getAttribute("password");
		String groupId = (String)session.getAttribute("groupId");
		
		String phoneNo = request.getParameter("phoneNo");
		String phoneStatus = request.getParameter("phoneStatus");
		String gCustId = request.getParameter("gCustId");
		String fee_sumPay = request.getParameter("fee_sumPay");
		String simFee = request.getParameter("simFee");

		
%>
		<wtc:service name="sb893Cfm" routerKey="region" routerValue="<%=regionCode%>"
					 retcode="retCode" retmsg="retMsg" outnum="2">
				<wtc:param value="b893"/>
				<wtc:param value="<%=workNo%>"/>
				<wtc:param value="<%=password%>"/>
				<wtc:param value="<%=groupId%>"/>
				<wtc:param value="<%=phoneNo%>"/>
				<wtc:param value="<%=phoneStatus%>"/>
				<wtc:param value="<%=gCustId%>"/>
				<wtc:param value="<%=fee_sumPay%>"/>
				<wtc:param value="<%=simFee%>"/>
			</wtc:service>
		<wtc:array id="ret" scope="end"/>
<%

	if("000000".equals(retCode)){
		System.out.println(" ======== sb893Cfm 调用成功 ========"  + retCode + " | " + retMsg);

	}
else {
		System.out.println(" ======== sb893Cfm 调用失败 ========" + retCode + " | " + retMsg);
	}
%>

	var response = new AJAXPacket();
	response.data.add("retcode","<%= retCode %>");
	response.data.add("retmsg","<%= retMsg %>");
	core.ajax.receivePacket(response);
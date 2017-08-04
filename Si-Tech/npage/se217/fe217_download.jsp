<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ include file="../../npage/bill/getMaxAccept.jsp" %>

	<%
    String workNo = (String)session.getAttribute("workNo");
		String regionCode= (String)session.getAttribute("regCode");
		String password = (String)session.getAttribute("password");
		String phoneNo = request.getParameter("phoneNo");
		String doloadtype = request.getParameter("doloadtype");
		String bianhao = request.getParameter("bianhao");
		String iToneType = request.getParameter("iToneType");
		String price = request.getParameter("price");

	%>

		<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="regioncode" 
			routerValue="<%=regionCode%>"  id="loginAccept" />
		<wtc:service name="sE217Cfm" routerKey="region" routerValue="<%=regionCode%>"
					 retcode="retCode" retmsg="retMsg" outnum="1">
				<wtc:param value="<%=loginAccept%>"/>
				<wtc:param value="9"/>
				<wtc:param value="e217"/>
				<wtc:param value="<%=workNo%>"/>
				<wtc:param value="<%=password%>"/>
				<wtc:param value="<%=phoneNo%>"/>
				<wtc:param value=""/>
				<wtc:param value=""/>
				<wtc:param value="<%=doloadtype%>"/>
				<wtc:param value="<%=bianhao%>"/>
				<wtc:param value="<%=iToneType%>"/>
				<wtc:param value="<%=price%>"/>

		</wtc:service>
		<wtc:array id="result1" scope="end"/>
			<%

if("000000".equals(retCode)){
		System.out.println(" ======== sE217Cfm 调用成功 ========"  + retCode + " | " + retMsg);
		}
	else {
		System.out.println(" ======== sE217Cfm 调用失败 ========"  + retCode + " | " + retMsg);
		}
		
		%>

	var response = new AJAXPacket();

	response.data.add("retcode","<%= retCode %>");
	response.data.add("retmsg","<%= retMsg %>");
	core.ajax.receivePacket(response);
<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ include file="../../npage/bill/getMaxAccept.jsp" %>

	<%
    String workNo = (String)session.getAttribute("workNo");
		String regionCode= (String)session.getAttribute("regCode");
		String password = (String)session.getAttribute("password");
		String PhoneNo = request.getParameter("PhoneNo");
		String groupId = (String)session.getAttribute("groupId");
		String opCode = request.getParameter("opCode");
		String opName = request.getParameter("opName");
		String jsontext=request.getParameter("myJSONText");
    String entertime=request.getParameter("entertime");		
		String grpname=request.getParameter("grpname");
		String newregion=request.getParameter("newregion");

	%>

		<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="regioncode" 
			routerValue="<%=regionCode%>"  id="loginAccept" />
		<wtc:service name="sGetImpCustOut" routerKey="region" routerValue="<%=regionCode%>"
					 retcode="retCode" retmsg="retMsg" outnum="1">
        <wtc:param value="<%=loginAccept%>"/>
        <wtc:param value="01"/>
        <wtc:param value="<%=opCode%>"/>
        <wtc:param value="<%=workNo%>"/>
        <wtc:param value="<%=password%>"/>
        <wtc:param value="<%=PhoneNo%>"/>
        <wtc:param value=""/>
        <wtc:param value="<%=groupId%>"/>
        <wtc:param value="crm"/>
				<wtc:param value="<%=entertime%>"/>
				<wtc:param value="<%=grpname%>"/>
				<wtc:param value="<%=newregion%>"/>
		</wtc:service>
		<wtc:array id="result1" scope="end"/>
			<%

if("000000".equals(retCode)){
		System.out.println(" ======== sGetImpCustOut 调用成功 ========"  + retCode + " | " + retMsg);
		}
	else {
		System.out.println(" ======== sGetImpCustOut 调用失败 ========"  + retCode + " | " + retMsg);
		}
		
		%>

	var response = new AJAXPacket();

	response.data.add("retcode","<%= retCode %>");
	response.data.add("retmsg","<%= retMsg %>");
	core.ajax.receivePacket(response);
<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%
		String workNo = (String)session.getAttribute("workNo");
		String regionCode= (String)session.getAttribute("regCode");
		String password = (String)session.getAttribute("password");

		String phonenos = request.getParameter("phonenos");

		String opnote =workNo+"正在更新sim信息";
		String opcode = WtcUtil.repNull((String)request.getParameter("opcode"));
%>
		<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="regioncode" 
			routerValue="<%=regionCode%>"  id="loginAccept" />

		<wtc:service name="sG842Cfm" routerKey="region" routerValue="<%=regionCode%>"
					 retcode="retCode" retmsg="retMsg" outnum="1">
        <wtc:param value="<%=loginAccept%>"/>
        <wtc:param value="01"/>
        <wtc:param value="<%=opcode%>"/>
        	<wtc:param value="<%=workNo%>"/>
        	<wtc:param value="<%=password%>"/>
         	<wtc:param value="<%=phonenos%>"/>
        	<wtc:param value=""/>
        	<wtc:param value="<%=opnote%>"/>
		</wtc:service>
		<wtc:array id="ret" scope="end"/>


	var response = new AJAXPacket();

	response.data.add("retcode","<%= retCode %>");
	response.data.add("retmsg","<%= retMsg %>");
	core.ajax.receivePacket(response);
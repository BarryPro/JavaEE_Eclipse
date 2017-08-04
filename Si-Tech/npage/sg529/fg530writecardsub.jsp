<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%
		String workNo = (String)session.getAttribute("workNo");
		String regionCode= (String)session.getAttribute("regCode");
		String searchOpCode = request.getParameter("searchOpCode");
		String password = (String)session.getAttribute("password");
		String cardNo = request.getParameter("cardNo");
		String simtypes = request.getParameter("simtypes");
		String simnos = request.getParameter("simnos");
		String phonenos = request.getParameter("phonenos");
		String groupids = request.getParameter("groupids");
		String phonesnames = request.getParameter("phonesnames");
		String opnote =workNo+"进行写卡受理操作";
		String opcode = WtcUtil.repNull((String)request.getParameter("opcode"));
%>
		<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="regioncode" 
			routerValue="<%=regionCode%>"  id="loginAccept" />

		<wtc:service name="sg530Cfm" routerKey="region" routerValue="<%=regionCode%>"
					 retcode="retCode" retmsg="retMsg" outnum="1">
        <wtc:param value="<%=loginAccept%>"/>
        <wtc:param value="01"/>
        <wtc:param value="<%=opcode%>"/>
        	<wtc:param value="<%=workNo%>"/>
        	<wtc:param value="<%=password%>"/>
         	<wtc:param value="<%=phonenos%>"/>
        	<wtc:param value=""/>
        	<wtc:param value="<%=opnote%>"/>
        	<wtc:param value="<%=groupids%>"/>
        	<wtc:param value="<%=cardNo%>"/>
        	<wtc:param value="<%=simnos%>"/>
        	<wtc:param value=""/>
        	<wtc:param value=""/>
        	<wtc:param value=""/>
        	<wtc:param value=""/>
        	<wtc:param value=""/>
        	<wtc:param value="0"/>
		</wtc:service>
		<wtc:array id="ret" scope="end"/>


	var response = new AJAXPacket();

	response.data.add("retcode","<%= retCode %>");
	response.data.add("retmsg","<%= retMsg %>");
	response.data.add("liushui","<%= loginAccept %>");
	response.data.add("phonesno","<%= phonenos %>");
	response.data.add("phonesnames","<%= phonesnames %>");
	core.ajax.receivePacket(response);
<%@ page contentType= "text/html;charset=gbk" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%
		String inLoginNo = (String)session.getAttribute("workNo");
		String regionCode= (String)session.getAttribute("regCode");
		String password = (String)session.getAttribute("password");
		
		String phoneNo = (String)request.getParameter("phoneNo");
		String opCode = (String)request.getParameter("opCode");
		
		/**
		System.out.println("zhouby opCode " + opCode);
		System.out.println("zhouby inLoginNo " + inLoginNo);
		System.out.println("zhouby password " + password);
		System.out.println("zhouby phoneNo " + phoneNo);
		*/
%>
		<wtc:sequence name="sPubSelect" key="sMaxSysAccept" id="loginAccept"/>
		
		<wtc:service name="sRanDomPass" routerKey="region" routerValue="<%=regionCode%>"
			 retcode="retCode" retmsg="retMsg" outnum="1">				
				<wtc:param value="<%=loginAccept%>"/>
				<wtc:param value="01"/>
				<wtc:param value="<%=opCode%>"/>
				<wtc:param value="<%=inLoginNo%>"/>
				<wtc:param value="<%=password%>"/>
				<wtc:param value="<%=phoneNo%>"/>
				<wtc:param value=""/>
				<wtc:param value="0"/>
		</wtc:service>

		var response = new AJAXPacket();
		response.data.add("retCode", "<%=retCode%>");
		response.data.add("retMsg", "<%=retMsg%>");
		core.ajax.receivePacket(response);
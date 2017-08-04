<%@ page contentType= "text/html;charset=gb2312" %>
<%@ include file="../../npage/bill/getMaxAccept.jsp" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%
    //需要的参数
		String loginNo = (String)session.getAttribute("workNo");
		String loginPwd  = (String)session.getAttribute("password");//登陆密码
		String regionCode= (String)session.getAttribute("regCode");
		String opCode = request.getParameter("opCode");
		String phone = request.getParameter("phone");
		String groupSchool = request.getParameter("groupSchool");
		String childCard = request.getParameter("childCard");
		String method = request.getParameter("method");
%>
		<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="regioncode" 
			routerValue="<%=regionCode%>"  id="loginAccept" />
  <%
		if("init".equals(method)) {	
			String[] inputParams = new String[7];
			inputParams[0] = loginAccept;
			inputParams[1] = "01";
			inputParams[2] = opCode;
			inputParams[3] = loginNo;
			inputParams[4] = loginPwd;
			inputParams[5] = phone;
			inputParams[6] = "";
			for(int i=0;i<inputParams.length;i++){
				System.out.println("se465Qry : inputParams[" + i + "]=" + inputParams[i]);
			}
	%>
		<wtc:service name="se465Qry" routerKey="region" routerValue="<%=regionCode%>"
					 retcode="retCode" retmsg="retMsg" outnum="2">
				<wtc:param value="<%=inputParams[0]%>"/>
				<wtc:param value="<%=inputParams[1]%>"/>
				<wtc:param value="<%=inputParams[2]%>"/>
				<wtc:param value="<%=inputParams[3]%>"/>
				<wtc:param value="<%=inputParams[4]%>"/>
				<wtc:param value="<%=inputParams[5]%>"/>
				<wtc:param value="<%=inputParams[6]%>"/>
		</wtc:service>
		<wtc:array id="ret" scope="end"/>
		var response = new AJAXPacket();
		response.data.add("retcode","<%= retCode %>");
		response.data.add("retmsg","<%= retMsg %>");
<%
    System.out.println("se465Qry :retCode=" + retCode);
    System.out.println("se465Qry :retMsg=" + retMsg);
		if(retCode.equals("000000")) {
%>
			response.data.add("groupName","<%= ret[0][0] %>");
			response.data.add("custName","<%= ret[0][1] %>");
<%
		}
%>
		core.ajax.receivePacket(response);
<%
	  }else if("submit".equals(method)) {
	  	String[] inputParams = new String[9];
			inputParams[0] = loginAccept;
			inputParams[1] = "01";
			inputParams[2] = opCode;
			inputParams[3] = loginNo;
			inputParams[4] = loginPwd;
			inputParams[5] = phone;
			inputParams[6] = "";
			inputParams[7] = groupSchool;
			inputParams[8] = childCard;
			for(int i=0;i<inputParams.length;i++){
				System.out.println("se465Cfm : inputParams[" + i + "]=" + inputParams[i]);
			}
			
	%>
		<wtc:service name="se465Cfm" routerKey="region" routerValue="<%=regionCode%>"
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
		</wtc:service>
		<wtc:array id="ret" scope="end"/>
<%
    System.out.println("se465Cfm :retCode=" + retCode);
    System.out.println("se465Cfm :retMsg=" + retMsg);
%>
		var response = new AJAXPacket();
		response.data.add("retcode","<%= retCode %>");
		response.data.add("retmsg","<%= retMsg %>");
		core.ajax.receivePacket(response);
<%
	 }
%>
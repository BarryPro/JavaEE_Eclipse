<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ include file="../../npage/bill/getMaxAccept.jsp" %>

	<%
    String workNo = (String)session.getAttribute("workNo");
		String regionCode= (String)session.getAttribute("regCode");
		String password = (String)session.getAttribute("password");
		String phoneNo = request.getParameter("phoneNo");
		String bianhao = request.getParameter("bianhao");
		String price = request.getParameter("price");
		Date currentTime = new Date(); 
    java.text.SimpleDateFormat formatter = new java.text.SimpleDateFormat("yyyyMMddHHmmss");
    String currentTimeString = formatter.format(currentTime);

	%>

		<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="regioncode" 
			routerValue="<%=regionCode%>"  id="loginAccept" />
			<%
			String  inputParsm [] = new String[17];
			inputParsm[0] = loginAccept;
			inputParsm[1] = "01";
			inputParsm[2] = "e217";
			inputParsm[3] = workNo;
			inputParsm[4] = password;
			inputParsm[5] = phoneNo;
			inputParsm[6] = "";
			inputParsm[7] = "ZY";
			inputParsm[8] = "045102";
			inputParsm[9] = "ZY0202";
			inputParsm[10] ="06";
			inputParsm[11] =currentTimeString;
			inputParsm[12] ="20501231235959";
			inputParsm[13] =currentTimeString;
			inputParsm[14] ="魔法铃音盒下载";
			inputParsm[15] =bianhao;
			inputParsm[16] =price;

			
			for(int k = 0; k <= 16; k++ ){
				System.out.println("-------ningtn--------inputParsm[" + k + "] " + inputParsm[k]);
			}
		%>
			
<wtc:service name="sProWorkFlowCfm" routerKey="phone" routerValue="<%=phoneNo%>" retcode="retCode" retmsg="retMsg" outnum="4">
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
				<wtc:param value="<%=inputParsm[13]%>"/>
				<wtc:param value="<%=inputParsm[14]%>"/>
				<wtc:param value="<%=inputParsm[15]%>"/>
					<wtc:param value="<%=inputParsm[16]%>"/>
	</wtc:service>
		<wtc:array id="result1" scope="end"/>
			<%

if("000000".equals(retCode)){
		System.out.println(" ======== sProWorkFlowCfm 调用成功 ========"  + retCode + " | " + retMsg);
		}
	else {
		System.out.println(" ======== sProWorkFlowCfm 调用失败 ========"  + retCode + " | " + retMsg);
		}
		
		%>

	var response = new AJAXPacket();

	response.data.add("retcode","<%= retCode %>");
	response.data.add("retmsg","<%= retMsg %>");
	core.ajax.receivePacket(response);
<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="../../npage/bill/getMaxAccept.jsp" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%
		String regionCode = (String)session.getAttribute("regCode");
		
		String iLoginAccept = request.getParameter("iLoginAccept");
		String iChnSource = request.getParameter("iChnSource");
		String OpCode = request.getParameter("OpCode");
		String iLoginNo = request.getParameter("iLoginNo");
		String iLoginPwd = request.getParameter("iLoginPwd");
		String iPhoneNo = request.getParameter("iPhoneNo");
		String iUserPwd = request.getParameter("iUserPwd");
		String iInputFile = request.getParameter("iInputFile");
		String iServerIp = request.getParameter("iServerIp");
		String iOpNote = request.getParameter("iOpNote");
		String close_reason = request.getParameter("close_reason");
		String oaNumber = request.getParameter("oaNumber");//OA编号
		String oaTitle = request.getParameter("oaTitle");  //OA标题
		int flag = 0;
		String total_no = "";//操作成功数量
		String ermsg=""; //错误信息
%>

<wtc:service name="se941Cfm" routerKey="region" routerValue="<%=regionCode%>"  retcode="sReturnCode" retmsg="sErrorMessage"  outnum="1" >
		<wtc:param value="<%=iLoginAccept%>"/>
		<wtc:param value="<%=iChnSource%>"/>		
		<wtc:param value="<%=OpCode%>"/>
		<wtc:param value="<%=iLoginNo%>"/>
		<wtc:param value="<%=iLoginPwd%>"/>	
		<wtc:param value="<%=iPhoneNo%>"/>
		<wtc:param value="<%=iUserPwd%>"/>			
		<wtc:param value="<%=iInputFile%>"/>		
		<wtc:param value="<%=iServerIp%>"/>			
		<wtc:param value="<%=iOpNote%>"/>			
		<wtc:param value="<%=close_reason%>"/>
		<wtc:param value="<%=oaNumber%>" />
		<wtc:param value="<%=oaTitle%>" />
	</wtc:service>
	<wtc:array id="result" scope="end" />
<%
	if(!sReturnCode.equals("000000")){
		flag = -1;
		ermsg = sErrorMessage;
	}
	if (flag == 0)
	{	
		total_no = result[0][0];
	}
	else
	{
		System.out.println("failed, 请检查 !");
	}
%>
	var response = new AJAXPacket();
	response.data.add("SuccessNo","<%= total_no %>");
	response.data.add("ErrorMsg","<%= ermsg %>");
	response.data.add("Flag","<%= flag %>");
	core.ajax.receivePacket(response);
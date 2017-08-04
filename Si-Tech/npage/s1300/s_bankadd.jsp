<%
/********************
 version v2.0
¿ª·¢ÉÌ: si-tech
********************/
%>
<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>

<%
		String regionCode = (String)session.getAttribute("regCode");
		String workno = (String)session.getAttribute("workNo");
		String workname = (String)session.getAttribute("workName");
		String org_code = (String)session.getAttribute("orgCode");
		String pay_money = (String)request.getParameter("pay_money");
		String phoneNo = (String)request.getParameter("phoneNo");
		String in_MerchantNameChs = (String)request.getParameter("in_MerchantNameChs");
		String MerchantId = (String)request.getParameter("MerchantId");
		String TerminalId = (String)request.getParameter("TerminalId");
		String IssCode = (String)request.getParameter("IssCode");
		String AcqCode = (String)request.getParameter("AcqCode");
		String CardNo = (String)request.getParameter("CardNo");
		String BatchNo = (String)request.getParameter("BatchNo");
		String Response_time = (String)request.getParameter("Response_time");
		String Rrn = (String)request.getParameter("Rrn");
		String AuthNo = (String)request.getParameter("AuthNo");
		String TraceNo = (String)request.getParameter("TraceNo");
		String CardNoPingBi = (String)request.getParameter("CardNoPingBi");
		String ExpDate = (String)request.getParameter("ExpDate"); 
		String Remak = (String)request.getParameter("Remak");
		String TC = (String)request.getParameter("TC"); 
    String requestTime = (String)request.getParameter("requestTime");
		System.out.println("£¤£¤£¤£¤£¤£¤£¤£¤£¤£¤£¤£¤£¤£¤£¤£¤£¤£¤£¤£¤£¤£¤AAAAAAAAAAAAAAAA pay_money is "+pay_money+" and in_MerchantNameChs is "+in_MerchantNameChs+" and phoneNo is "+phoneNo);
%>			
	<wtc:service name="addBankPosInf" routerKey="region" routerValue="<%=regionCode%>"  retcode="return_codes" retmsg="return_msgs" outnum="2">
		<wtc:param value="<%=workno%>"/>
		<wtc:param value="<%=org_code%>"/>
		<wtc:param value="<%=phoneNo%>"/>
		<wtc:param value="<%=pay_money%>"/>
		<wtc:param value="<%=in_MerchantNameChs%>"/>
		<wtc:param value="<%=MerchantId%>"/>
		<wtc:param value="<%=TerminalId%>"/>
		<wtc:param value="<%=IssCode%>"/>
		<wtc:param value="<%=AcqCode%>"/>
		<wtc:param value="<%=CardNo%>"/>
		<wtc:param value="<%=BatchNo%>"/>
		<wtc:param value="<%=Response_time%>"/>
		<wtc:param value="<%=Rrn%>"/>
		<wtc:param value="<%=AuthNo%>"/>
		<wtc:param value="<%=TraceNo%>"/>
		<wtc:param value="<%=requestTime%>"/>
		<wtc:param value="<%=CardNoPingBi%>"/>
		<wtc:param value="<%=ExpDate%>"/>
		<wtc:param value="<%=Remak%>"/>
		<wtc:param value="<%=TC%>"/>
	</wtc:service>
	<wtc:array id="ret_val" scope="end" />			
<%
/*
		String return_codes = ret_val[0][0].trim();
		String return_msgs = ret_val[0][1].trim();
*/
System.out.println("666666666666666666666666666666666666666666666666666AAAAAAAAAAAAAAAAAAAAAAAAAAAAaa BBBBBBBBBBBBBBBBBBBBBBBBBBBBBB return_code is "+return_codes+" and return_msg is "+return_msgs);
System.out.println("9999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999");
%>	
		
		var response = new AJAXPacket();
		response.data.add("retCode","<%=return_codes%>");
		response.data.add("retMsg","<%=return_msgs%>");
		core.ajax.receivePacket(response);

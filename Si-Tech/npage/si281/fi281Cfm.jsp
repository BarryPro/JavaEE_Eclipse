<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="../../npage/bill/getMaxAccept.jsp" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%
		String regionCode = (String)session.getAttribute("regCode");
		
		String iLoginAccept = request.getParameter("iLoginAccept");
		String iChnSource = request.getParameter("iChnSource");
		String iOpCode = request.getParameter("iOpCode");
		String iLoginNo = request.getParameter("iLoginNo");
		String iLoginPwd = request.getParameter("iLoginPwd");
		String iPhoneNo = request.getParameter("iPhoneNo");
		String iUserPwd = request.getParameter("iUserPwd");
		
		String inKdType = request.getParameter("inKdType");
		String inOpFlag = request.getParameter("inOpFlag");
		String inFileName = request.getParameter("inFileName");
		String inServerIP = request.getParameter("inServerIP");
		String inFileDir = request.getParameter("inFileDir");
		
		
		String errCode="";
		String errMsg=""; //错误信息
		String success_no = "";//操作成功数量
		String error_no = "";//操作成功数量
		
		String  inputParsm [] = new String[12];
		inputParsm[0] = iLoginAccept;
		inputParsm[1] = iChnSource;
		inputParsm[2] = iOpCode;
		inputParsm[3] = iLoginNo;
		inputParsm[4] = iLoginPwd;
		inputParsm[5] = iPhoneNo;
		inputParsm[6] = iUserPwd;
		
		inputParsm[7] = inKdType;
		inputParsm[8] = inOpFlag;
		inputParsm[9] = inFileName;
		inputParsm[10] = inServerIP;
		inputParsm[11] = inFileDir;
		System.out.println("===========gaopengSeeLog=============fi281Cfm.jsp=====sKdUpdateCfm====Start==================");
		System.out.println("===========gaopengSeeLog=============fi281Cfm.jsp=====inputParsm[0]======================" +inputParsm[0]);
		System.out.println("===========gaopengSeeLog=============fi281Cfm.jsp=====inputParsm[1]======================" +inputParsm[1]);
		System.out.println("===========gaopengSeeLog=============fi281Cfm.jsp=====inputParsm[2]======================" +inputParsm[2]);
		System.out.println("===========gaopengSeeLog=============fi281Cfm.jsp=====inputParsm[3]======================" +inputParsm[3]);
		System.out.println("===========gaopengSeeLog=============fi281Cfm.jsp=====inputParsm[4]======================" +inputParsm[4]);
		System.out.println("===========gaopengSeeLog=============fi281Cfm.jsp=====inputParsm[5]======================" +inputParsm[5]);
		System.out.println("===========gaopengSeeLog=============fi281Cfm.jsp=====inputParsm[6]======================" +inputParsm[6]);
		System.out.println("===========gaopengSeeLog=============fi281Cfm.jsp=====inputParsm[7]======================" +inputParsm[7]);
		System.out.println("===========gaopengSeeLog=============fi281Cfm.jsp=====inputParsm[8]======================" +inputParsm[8]);
		System.out.println("===========gaopengSeeLog=============fi281Cfm.jsp=====inputParsm[9]======================" +inputParsm[9]);
		System.out.println("===========gaopengSeeLog=============fi281Cfm.jsp=====inputParsm[10]======================"+inputParsm[10]);
		System.out.println("===========gaopengSeeLog=============fi281Cfm.jsp=====inputParsm[11]======================"+inputParsm[11]);
		System.out.println("===========gaopengSeeLog=============fi281Cfm.jsp=====sKdUpdateCfm====End==================");
%>

<wtc:service name="sKdUpdateCfm" routerKey="region" routerValue="<%=regionCode%>"  retcode="sReturnCode" retmsg="sErrorMessage"  outnum="2" >
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
	</wtc:service>
	<wtc:array id="result" scope="end" />
<%
System.out.println("gaopeng===================sReturnCode===="+sReturnCode);
	if(!sReturnCode.equals("000000")){
		errCode = sReturnCode;
		errMsg = sErrorMessage;
	}
	if("000000".equals(sReturnCode)){
		errCode = sReturnCode;
		errMsg = sErrorMessage;
		
	}
	if(result.length > 0){
		success_no = result[0][0];
		System.out.println("gaopeng===================success_no===="+success_no);
		System.out.println("gaopeng===================error_no===="+error_no);
	}
	
%>
	var response = new AJAXPacket();
	response.data.add("errCode","<%= errCode %>");
	response.data.add("errMsg","<%= errMsg %>");
	response.data.add("inOpFlag","<%= inOpFlag %>");
	<%
	if(result.length > 0){
	%>
	response.data.add("successNo","<%= success_no %>");
	<%
	}
	%>
	
	
	core.ajax.receivePacket(response);
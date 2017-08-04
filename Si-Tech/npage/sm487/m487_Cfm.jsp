<%
/*
 * 功能: 
 * 版本: 1.0
 * 日期: liangyl 2017/06/06 关于协助开发手机代付宽带费用功能的函
 * 作者: liangyl
 * 版权: si-tech
*/
%>
<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%
	String regionCode = (String)session.getAttribute("regCode");
	String iLoginAccept = request.getParameter("iLoginAccept");
	String iChnSource = request.getParameter("iChnSource");
	String iOpCode =  request.getParameter("iOpCode");
	String iLoginNo = request.getParameter("iLoginNo");
	String iLoginPwd =  request.getParameter("iLoginPwd");
	String iPhoneNo =  request.getParameter("iPhoneNo");
	String iUserPwd =  request.getParameter("iUserPwd");
	String offerId =  request.getParameter("offerId");
	String opType =  request.getParameter("opType");
	String kdphoneNo = request.getParameter("kdphoneNo");
	
	System.out.println("---liangyl---iLoginAccept--------------"+iLoginAccept);
	System.out.println("---liangyl---iChnSource--------------"+iChnSource);
	System.out.println("---liangyl---iOpCode--------------"+iOpCode);
	System.out.println("---liangyl---iLoginNo--------------"+iLoginNo);
	System.out.println("---liangyl---iLoginPwd--------------"+iLoginPwd);
	System.out.println("---liangyl---iPhoneNo--------------"+iPhoneNo);
	System.out.println("---liangyl---iUserPwd--------------"+iUserPwd);
	System.out.println("---liangyl---offerId--------------"+offerId);
	System.out.println("---liangyl---opType--------------"+opType);
	System.out.println("---liangyl---kdphoneNo--------------"+kdphoneNo);
	
	System.out.println("-----------------------------");
	
	
	String  inputParsm [] = new String[10];
	inputParsm[0] = iLoginAccept;
	inputParsm[1] = iChnSource;
	inputParsm[2] = iOpCode;
	inputParsm[3] = iLoginNo;
	inputParsm[4] = iLoginPwd;
	inputParsm[5] = iPhoneNo;
	inputParsm[6] = iUserPwd;
	inputParsm[7] = offerId;
	inputParsm[8] = opType;
	inputParsm[9] = kdphoneNo;
	System.out.println("---liangyl---inputParsm[0]--------------"+inputParsm[0]);
	System.out.println("---liangyl---inputParsm[1]--------------"+inputParsm[1]);
	System.out.println("---liangyl---inputParsm[2]--------------"+inputParsm[2]);
	System.out.println("---liangyl---inputParsm[3]--------------"+inputParsm[3]);
	System.out.println("---liangyl---inputParsm[4]--------------"+inputParsm[4]);
	System.out.println("---liangyl---inputParsm[5]--------------"+inputParsm[5]);
	System.out.println("---liangyl---inputParsm[6]--------------"+inputParsm[6]);
	System.out.println("---liangyl---inputParsm[7]--------------"+inputParsm[7]);
	System.out.println("---liangyl---inputParsm[8]--------------"+inputParsm[8]);
	System.out.println("---liangyl---inputParsm[9]--------------"+inputParsm[9]);
	
	String retCode11 = "";
	String retMsg11 = "";
try{		
%>
	<wtc:service name="sSJKDUpdateChg" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode" retmsg="retMsg" outnum="2">
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
	</wtc:service>
	<wtc:array id="infoRet1"  scope="end"/>
	var infoArray = new Array();
<%
	retCode11 = retCode;
	retMsg11 = retMsg;
}catch(Exception e){
	retCode11 = "444444";
	retMsg11 = "服务未启动或不正常，请联系管理员！";
	%>
		var infoArray = new Array();
	<%
}
%>
var response = new AJAXPacket();
response.data.add("retCode","<%=retCode11 %>");
response.data.add("retMsg","<%=retMsg11 %>");
core.ajax.receivePacket(response);                                                                                                                                                                                                                                                                                                                                                                         
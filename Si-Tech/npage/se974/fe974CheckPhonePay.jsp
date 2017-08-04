<%
/*
* 功能: 
* 版本: 1.0
* 日期: liangyl 2017/05/20 liangyl 关于协助开发手机代付宽带费用功能的函
* 作者: liangyl
* 版权: si-tech
*/
%>

<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ page import="com.sitech.boss.pub.util.*" %>
<%
		System.out.println("===gaopengSeeLog========= fe974CheckPhonePay.jsp ==========");
		
		String regionCode = (String)session.getAttribute("regCode");
		
		String iLoginAccept = request.getParameter("iLoginAccept");
		String iChnSource = request.getParameter("iChnSource");
		String iOpCode =  request.getParameter("iOpCode");
		String iLoginNo = request.getParameter("iLoginNo");
		String iLoginPwd =  request.getParameter("iLoginPwd");
		String iPhoneNo =  request.getParameter("iPhoneNo");
		String iUserPwd =  request.getParameter("iUserPwd");
		
		String iKDPhoneNo =  request.getParameter("iKDPhoneNo");
		String iOfferId =  request.getParameter("iOfferId");
		String iCustOrderId =  WtcUtil.repStr(request.getParameter("iCustOrderId"),"");
		String iScoreMoney =  request.getParameter("iScoreMoney");
		/*密码加密*/
		iUserPwd = Encrypt.encrypt(iUserPwd);
		
		
		System.out.println(iLoginAccept);
		System.out.println(iChnSource);
		System.out.println(iOpCode);
		System.out.println(iLoginNo);
		System.out.println(iLoginPwd);
		System.out.println(iPhoneNo);
		System.out.println(iUserPwd);
		System.out.println(iKDPhoneNo);
		System.out.println(iOfferId);
		System.out.println(iCustOrderId);
		System.out.println(iScoreMoney);
		
		String  inputParsm [] = new String[11];
		inputParsm[0] = iLoginAccept;
		inputParsm[1] = iChnSource;
		inputParsm[2] = iOpCode;
		inputParsm[3] = iLoginNo;
		inputParsm[4] = iLoginPwd;
		inputParsm[5] = iPhoneNo;
		inputParsm[6] = iUserPwd;
		
		inputParsm[7] = iKDPhoneNo;
		inputParsm[8] = iOfferId;
		inputParsm[9] = iCustOrderId;
		inputParsm[10] = iScoreMoney;
		
		
		
		
		
		String retCode11 = "";
		String retMsg11 = "";
		
		
try{		
%>
		<wtc:service name="sKDDFOrderChk" routerKey="region" routerValue="<%=regionCode%>"
					 retcode="retCode" retmsg="retMsg" outnum="3">
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
				
		</wtc:service>
		<wtc:array id="infoRet1"  scope="end"/>
		
			
	var infoArray = new Array();
	
<%
		retCode11 = retCode;
		retMsg11 = retMsg;
		
		}catch(Exception e){
			System.out.println(e);
			retCode11 = "444444";
			retMsg11 = "服务未启动或不正常，请联系管理员！";
			
		}
%>
var response = new AJAXPacket();
response.data.add("retCode","<%=retCode11%>");
response.data.add("retMsg","<%=retMsg11 %>");
core.ajax.receivePacket(response);                                                                                                                                                                                                                                                                                                                                                                         
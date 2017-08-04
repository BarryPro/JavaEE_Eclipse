<%
/********************
 * version v2.0
 * gaopeng 2015/7/8 16:41:51 R_CMI_HLJ_guanjg_2015_2310398@关于哈尔滨申请储备开发校园迎新系统的请示
 * 开发商: si-tech
 ********************/
%>

<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%
		System.out.println("===gaopengSeeLog========= fm275InnetChk.jsp==========");
%>
<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="region" routerValue="01"  id="loginAccept"/>
<%		
		
		String regionCode = (String)session.getAttribute("regCode");
		
		String iLoginAccept = loginAccept;
		String iChnSource = "01";
		String iOpCode =  request.getParameter("iOpCode");
		String iLoginNo = (String)session.getAttribute("workNo");
		String iLoginPwd = (String)session.getAttribute("password");
		String iPhoneNo =  "";
		String iUserPwd =  "";
		String innetIdIccid =  request.getParameter("innetIdIccid");
		String iOfferId =  request.getParameter("iOfferId");
		
		
		String  inputParsm [] = new String[14];
		inputParsm[0] = iLoginAccept;
		inputParsm[1] = iChnSource;
		inputParsm[2] = iOpCode;
		inputParsm[3] = iLoginNo;
		inputParsm[4] = iLoginPwd;
		inputParsm[5] = iPhoneNo;
		inputParsm[6] = iUserPwd;
		inputParsm[7] = "0";
		inputParsm[8] = innetIdIccid;
		inputParsm[9] = iOfferId;
		inputParsm[10] = "";
		inputParsm[11] = "";
		inputParsm[12] = "";
		inputParsm[13] = "";
		
		
		String retCode11 = "";
		String retMsg11 = "";
try{		
%>
		<wtc:service name="sXYYXInnetChk" routerKey="region" routerValue="<%=regionCode%>"
					 retcode="retCode" retmsg="retMsg" outnum="2">
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
		</wtc:service>
		<wtc:array id="infoRet1"  scope="end"/>
	
	
<%
		retCode11 = retCode;
		retMsg11 = retMsg;
		
		}catch(Exception e){
			retCode11 = "444444";
			retMsg11 = "服务未启动或不正常，请联系管理员！";
			%>
				
			<%
		}
%>
var response = new AJAXPacket();
response.data.add("retCode","<%=retCode11 %>");
response.data.add("retMsg","<%=retMsg11 %>");
core.ajax.receivePacket(response);                                                                                                                                                                                                                                                                                                                                                                         
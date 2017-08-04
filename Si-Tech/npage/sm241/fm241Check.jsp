<%@ page contentType= "text/html;charset=gb2312" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ page import="java.util.*"%>
<%
  String workNo = (String)session.getAttribute("workNo");
  String regionCode= (String)session.getAttribute("regCode");
  String password = (String)session.getAttribute("password");
	String cardNo = WtcUtil.repNull((String)request.getParameter("cardNo"));
	String phoneNo = WtcUtil.repNull((String)request.getParameter("phoneNo"));
	String cardStatus="";
	String opCode = WtcUtil.repNull((String)request.getParameter("opCode"));
	String opName = WtcUtil.repNull((String)request.getParameter("opName"));
 
%>
<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="region"  routerValue="<%=regionCode%>"  id="loginAccept" />
<%  
  String  inputParsm [] = new String[18];
	inputParsm[0] = loginAccept;
	inputParsm[1] = "01";
	inputParsm[2] = opCode;
	inputParsm[3] = workNo;
	inputParsm[4] = password;
	inputParsm[5] = phoneNo;
	inputParsm[6] = "";
	inputParsm[7] = cardNo;

	
	

	/*
sD311Qry
*@ 输入参数：
 *@			iLoginAccept				操作流水
 *@			iChnSource					渠道标识
 *@			iOpCode						操作代码
 *@			iLoginNo					操作工号
 *@			iLoginPwd					工号密码
 *@			iPhoneNo					手机号码
 *@			iUserPwd					用户密码
 *@			iCardNo						有价卡序列号
 *@ 返回参数：
 *@			oCardNo						有价卡序列号
 *@			oCardFlag					有价卡状态标识
 *@			oMsisdn						充值的预付费用户手机号
 *@			oTradeTime					充值的交易时间
 *@			oCardKind					有价卡类型
 *@			oCount						冲值卡面额 单位：分
 *@			oAcntStop					终止日期
 *@			oActiveDays					附加有效期

*/
String retCode11 = "";
String retMsg11 = "";
try{
%>
	<wtc:service name="sD311Qry" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode" retmsg="retMsg" outnum="8">
			<wtc:param value="<%=inputParsm[0]%>"/>
			<wtc:param value="<%=inputParsm[1]%>"/>
			<wtc:param value="<%=inputParsm[2]%>"/>
			<wtc:param value="<%=inputParsm[3]%>"/>
			<wtc:param value="<%=inputParsm[4]%>"/>
			<wtc:param value="<%=inputParsm[5]%>"/>
			<wtc:param value="<%=inputParsm[6]%>"/>
			<wtc:param value="<%=inputParsm[7]%>"/>

	</wtc:service>
	<wtc:array id="ret" scope="end"/>
<%
	retCode11 = retCode;
	retMsg11 = retMsg;
	if(retCode.equals("000000")) {
	if(ret.length > 0) {
		 cardStatus = ret[0][1];
	}
	}
	}catch(Exception e){
		retCode11 = "444444";
		retMsg11 = "系统错误请联系管理员！";
	}
%>

	var response = new AJAXPacket();
	response.data.add("retcode","<%=retCode11%>");
	response.data.add("retmsg","<%=retMsg11%>");
	response.data.add("cardStatus","<%=cardStatus%>");

	core.ajax.receivePacket(response);
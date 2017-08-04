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
	String kddangWei =  request.getParameter("kddangWei");
	kddangWei = kddangWei.replaceAll("M", "");
	String  inputParsm [] = new String[8];
	inputParsm[0] = iLoginAccept;
	inputParsm[1] = iChnSource;
	inputParsm[2] = iOpCode;
	inputParsm[3] = iLoginNo;
	inputParsm[4] = iLoginPwd;
	inputParsm[5] = iPhoneNo;
	inputParsm[6] = iUserPwd;
	inputParsm[7] = kddangWei;
	String retCode11 = "";
	String retMsg11 = "";
try{		
%>
	<wtc:service name="sSJKDUpdateQry" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode" retmsg="retMsg" outnum="2">
		<wtc:param value="<%=inputParsm[0]%>"/>
		<wtc:param value="<%=inputParsm[1]%>"/>
		<wtc:param value="<%=inputParsm[2]%>"/>
		<wtc:param value="<%=inputParsm[3]%>"/>
		<wtc:param value="<%=inputParsm[4]%>"/>
		<wtc:param value="<%=inputParsm[5]%>"/>
		<wtc:param value="<%=inputParsm[6]%>"/>
		<wtc:param value="<%=inputParsm[7]%>"/>
	</wtc:service>
	<wtc:array id="infoRet1"  scope="end"/>
	var infoArray = new Array();
<%
	retCode11 = retCode;
	retMsg11 = retMsg;
	if("000000".equals(retCode)){
		for(int i=0;i<infoRet1.length;i++){
		%>
			infoArray[<%=i%>] = new Array();
			<%
			for(int j=0;j<infoRet1[i].length;j++){
				%>
				infoArray[<%=i%>][<%=j%>] = "<%=infoRet1[i][j]%>";
				<%
			}
		}
	}
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
response.data.add("infoArray",infoArray);
core.ajax.receivePacket(response);                                                                                                                                                                                                                                                                                                                                                                         
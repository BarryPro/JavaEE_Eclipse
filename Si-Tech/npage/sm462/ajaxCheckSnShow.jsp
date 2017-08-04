<%@ page contentType="text/html;charset=GB2312"%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
	var retArray = new Array();//定义返回数组
<%

String iLognAccept = WtcUtil.repNull(request.getParameter("iLognAccept"));
String iChnSource = WtcUtil.repNull(request.getParameter("iChnSource"));
String iOpCode = WtcUtil.repNull(request.getParameter("iOpCode"));
String iLoginNo = WtcUtil.repNull(request.getParameter("iLoginNo"));
String iLoginPwd = WtcUtil.repNull(request.getParameter("iLoginPwd"));
String iPhoneNo = WtcUtil.repNull(request.getParameter("iPhoneNo"));
if("kf".equals(iPhoneNo)){
	iPhoneNo="67";
}
else if("ki".equals(iPhoneNo)){
	iPhoneNo="72";
}
else{
	iPhoneNo="";
}

String iUserPwd = (String)session.getAttribute("regCode");
String iOfferId = "";

//8个标准化入参
String paraAray[] = new String[8];
paraAray[0] = iLognAccept;
paraAray[1] = iChnSource;
paraAray[2] = iOpCode;
paraAray[3] = iLoginNo;
paraAray[4] = iLoginPwd;
paraAray[5] = iPhoneNo;
paraAray[6] = iUserPwd;
paraAray[7] = iOfferId;

String serverName = "sFamilyHappyChk";
String retCode="";
String retMsg="";
String vFlag ="";
try{
%>
    <wtc:service name="<%=serverName%>" routerKey="phone" routerValue="<%=iUserPwd%>" retcode="code" retmsg="msg" outnum="1">
<%
			for(int i=0; i<paraAray.length; i++ ){
%>
				<wtc:param value="<%=paraAray[i]%>" />
<%
			}
%>		
	</wtc:service>
    <wtc:array id="serverResult" scope="end"/>
    	
<%
	retCode = code;
	retMsg = msg;
	if("000000".equals(retCode)){
		if(serverResult.length>0){
			vFlag=serverResult[0][0];
		}
	}
}catch(Exception ex){
	retCode = "404040";
	retMsg = "调用服务"+serverName+"出错，请联系管理员";
}
%>
var response = new AJAXPacket();
response.data.add("code","<%=retCode%>");
response.data.add("msg","<%=retMsg%>");
response.data.add("vFlag","<%=vFlag%>")
core.ajax.receivePacket(response);
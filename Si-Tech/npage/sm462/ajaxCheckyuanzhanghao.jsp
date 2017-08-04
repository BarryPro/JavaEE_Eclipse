<%@ page contentType="text/html;charset=GB2312"%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
	var retArray = new Array();//定义返回数组
<%
	String iLognAccept = WtcUtil.repNull(request.getParameter("iLognAccept"));
	String iChnSource = WtcUtil.repNull(request.getParameter("iChnSource"));
	String iOpCode = WtcUtil.repNull(request.getParameter("iOpCode"));
	String iLoginNo = WtcUtil.repNull(request.getParameter("iLoginNo"));
	String iLoginPwd = WtcUtil.repNull(request.getParameter("iLoginPwd"));
	String iPhoneNo = "";
	String iUserPwd = "";
	String iQueryType = WtcUtil.repNull(request.getParameter("iQueryType"));
	String iCfmLoginOld = WtcUtil.repNull(request.getParameter("iCfmLoginOld"));
	String regCode = (String)session.getAttribute("regCode");
	
	//9个标准化入参
	String paraAray[] = new String[9];
	paraAray[0] = iLognAccept;
	paraAray[1] = iChnSource;
	paraAray[2] = iOpCode;
	paraAray[3] = iLoginNo;
	paraAray[4] = iLoginPwd;
	paraAray[5] = iPhoneNo;
	paraAray[6] = iUserPwd;
	paraAray[7] = iQueryType;
	paraAray[8] = iCfmLoginOld;
	String serverName = "sKDCfmNoChk";
	String retCode="";
	String retMsg="";
try{
%>
    <wtc:service name="<%=serverName%>" routerKey="phone" routerValue="<%=regCode%>" retcode="code" retmsg="msg" outnum="25">
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
}catch(Exception ex){
	retCode = "404040";
	retMsg = "调用服务"+serverName+"出错，请联系管理员";
}
%> 	
var response = new AJAXPacket();
response.data.add("code","<%=retCode%>");
response.data.add("msg","<%=retMsg%>");
core.ajax.receivePacket(response);
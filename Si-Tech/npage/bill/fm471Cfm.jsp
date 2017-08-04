<%
/*
* 功能: 
* 版本: 1.0
* 日期: liangyl 2017/04/24 liangyl 一体化 黑龙江移动一体化运营项目计划
* 作者: liangyl
* 版权: si-tech
*/
%>
<%@ page contentType="text/html;charset=GB2312"%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>

<%
	String workNo = (String)session.getAttribute("workNo");
	String password = (String)session.getAttribute("password");
	String regCode = (String)session.getAttribute("regCode");
	
	String opCode = WtcUtil.repStr(request.getParameter("opCode"),"");
	String opName = WtcUtil.repStr(request.getParameter("opName"),"");
	String phoneNo = WtcUtil.repStr(request.getParameter("phoneNo"),"");
	String custName = WtcUtil.repStr(request.getParameter("custName"),"");
	String oaNum = WtcUtil.repStr(request.getParameter("oaNum"),"");
	String yanqiMonth = WtcUtil.repStr(request.getParameter("yanqiMonth"),"");
	String errCode = "";
	String errMsg = "";
	%>
	<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="region" routerValue="<%=regCode%>" id="sysAccept" />
	<%

	String paraAray[] = new String[11];
	paraAray[0] = sysAccept;
    paraAray[1] = "01";
    paraAray[2] = opCode;
    paraAray[3] = workNo;
    paraAray[4] = password;
    paraAray[5] = phoneNo;
    paraAray[6] = "";
    paraAray[7] = oaNum;
 	paraAray[8] = yanqiMonth;
try{
%>
	<wtc:service name="sm471Cfm" routerKey="region" routerValue="<%=regCode%>" retcode="retCode1" retmsg="retMsg1" outnum="3">
		<wtc:param value="<%=paraAray[0]%>" />
		<wtc:param value="<%=paraAray[1]%>" />
		<wtc:param value="<%=paraAray[2]%>" />
		<wtc:param value="<%=paraAray[3]%>" />
		<wtc:param value="<%=paraAray[4]%>" />
		<wtc:param value="<%=paraAray[5]%>" />
		<wtc:param value="<%=paraAray[6]%>" />
		<wtc:param value="<%=paraAray[7]%>" />
		<wtc:param value="<%=paraAray[8]%>" />
	</wtc:service>
	<wtc:array id="result"  scope="end"/>
<%
	errCode = retCode1;
	errMsg = retMsg1;
}catch(Exception ex){
	errCode = "404040";
	errMsg = "调用服务出错，请联系管理员";
}
%>
var response = new AJAXPacket();
response.data.add("errCode","<%=errCode%>");
response.data.add("errMsg","<%=errMsg%>");
core.ajax.receivePacket(response);	
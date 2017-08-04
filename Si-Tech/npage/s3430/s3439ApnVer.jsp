<%@ page contentType="text/html;charset=GB2312"%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ page import="com.sitech.boss.pub.util.Encrypt"%>
<%
	String loginNo = WtcUtil.repNull((String)session.getAttribute("workNo"));
	String regionCode = WtcUtil.repNull((String)session.getAttribute("regCode"));
	String apnNo = request.getParameter("apnNo");
	String grpIdNo = request.getParameter("grpIdNo");

	String[][] result = new String[][]{};
%>
    <wtc:service name="s3439ApnEXC" outnum="7" retmsg="msg" retcode="code" routerKey="region" routerValue="<%=regionCode%>">
		<wtc:param value="<%=grpIdNo%>" />
		<wtc:param value="<%=apnNo%>" />
		<wtc:param value="<%=regionCode%>" />
	</wtc:service>
	<wtc:array id="result_t2" scope="end" />
<%
	result = result_t2;
	System.out.println("# result.length ========== "+result.length);
	String returnCode = code;
	String returnMsg = msg;

%>
var response = new AJAXPacket();
var retType = "";
var retCode = "";
var retMessage = "";

var billType     = "";
var apnId        = "";
var terminalNum  = "";
var usedNum      = "";
var remainNum    = "";
var smCode       = "";
var apnName      = "";

<%
if("000000".equals(returnCode)){
    if(result.length>0){
	%>
	    var billType     = '<%=result[0][0]%>';
        var apnId        = '<%=result[0][1]%>';
        var terminalNum  = '<%=result[0][2]%>';
        var usedNum      = '<%=result[0][3]%>';
        var remainNum    = '<%=result[0][4]%>';
        var smCode       = '<%=result[0][5]%>';
        var apnName      = '<%=result[0][6]%>';
	<%
    }else{
        returnCode = "999999";
        returnMsg = "没有对应的Apn数据！";
    }
}
%>

retType = "s3439ApnVer";
retCode = "<%=returnCode%>";
retMessage = "<%=returnMsg%>";

response.data.add("retType",retType);
response.data.add("retCode",retCode);
response.data.add("retMessage",retMessage);

response.data.add("billType",billType);
response.data.add("apnId",apnId);
response.data.add("terminalNum",terminalNum);
response.data.add("usedNum",usedNum);
response.data.add("remainNum",remainNum);
response.data.add("smCode",smCode);
response.data.add("apnName",apnName);
core.ajax.receivePacket(response);


<%@ page contentType= "text/html;charset=gb2312" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>

<%


//--------------------------
String retType = request.getParameter("retType");
String srv_no = request.getParameter("srv_no");
String region_codeT = WtcUtil.repNull((String)session.getAttribute("regCode"));
String sq1="select to_char(login_accept) from dcustres where phone_no=:srv_no";
    String [] paraIn = new String[2];
    paraIn[0] = sq1;    
    paraIn[1]="srv_no="+srv_no;

String retCode="";
String retMessage="";

String flowNo="0";

%>
    <wtc:service name="TlsPubSelCrm"  routerKey="region" routerValue="<%=region_codeT%>" outnum="2" retcode="retCode2ss" retmsg="retMsg2ss" >
        <wtc:param value="<%=paraIn[0]%>"/>
        <wtc:param value="<%=paraIn[1]%>"/> 
    </wtc:service>
    <wtc:array id="result" scope="end"/>
<%
if(retCode2ss.equals("000000")) {
if(result.length>0) {
	flowNo = result[0][0]; 
	retCode = "000000";
}
else {

	retCode = "000001";
	retMessage = "获得流水号失败！";
	}
}
else {
	retCode = "000001";
	retMessage = "获得流水号失败！";
}
%>

var response = new AJAXPacket();
var retType = "";
var retCode = "";
var retMessage = "";
var flowNo = "";

retType = "<%=retType%>";
retCode = "<%=retCode%>";
retMessage = "<%=retMessage%>";
flowNo = "<%=flowNo%>";
 

response.data.add("retType",retType);
response.data.add("retCode",retCode);
response.data.add("retMessage",retMessage);
response.data.add("flowNo",flowNo);

core.ajax.receivePacket(response);
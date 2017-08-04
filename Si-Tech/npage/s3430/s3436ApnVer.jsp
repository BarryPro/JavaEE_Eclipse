   
<%
/********************
 version v2.0
 ¿ª·¢ÉÌ si-tech
 update hejw@2009-2-24
********************/
%>
<%@ page contentType="text/html;charset=GB2312"%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%
	System.out.println("------------------------------------------------s3436ApnVer.jsp---------------------------------");
	String apnNo = request.getParameter("apnNo");
	String grpIdNo = request.getParameter("grpIdNo");
	String regionCode = (String)session.getAttribute("regCode");
	//String []result = impl.callService("s3436ApnVer",inputPara,"6");
	%>
	
    <wtc:service name="s3436ApnVer" outnum="7" retmsg="msg" retcode="code" routerKey="region" routerValue="<%=regionCode%>">
			<wtc:param value="<%=grpIdNo%>" />
			<wtc:param value="<%=apnNo%>" />	
		</wtc:service>
		<wtc:array id="result_t" scope="end"  />	
	
	<%
	
 
		
	String returnCode = code;
	String returnMsg = msg;
%>   
var response = new AJAXPacket();
var retType = "";
var retCode = "";
var retMessage = "";

var billType        = '<%=result_t[0][0].trim()%>';                               
var apnId         = '<%=result_t[0][1].trim()%>';                               
var terminalNum        = '<%=result_t[0][2].trim()%>';                               
var usedNum       = '<%=result_t[0][3].trim()%>';                               
var remainNum    = '<%=result_t[0][4].trim()%>';                               
var smCode      = '<%=result_t[0][5].trim()%>';


retType = "s3436ApnVer";
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
core.ajax.receivePacket(response);


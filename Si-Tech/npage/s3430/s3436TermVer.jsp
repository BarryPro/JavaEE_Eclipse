   
<%
/********************
 version v2.0
 ¿ª·¢ÉÌ si-tech
 update hejw@2009-2-24
********************/
%>
        

<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ page contentType="text/html;charset=GBK"%>
<%
	System.out.println("------------------------------------------------s3436termVer.jsp---------------------------------");
	String org_code = (String)session.getAttribute("orgCode");
	String smCode = request.getParameter("smCode");
	String grpIdNo = request.getParameter("grpIdNo");
	String apnId = request.getParameter("apnId");
	String oprType = request.getParameter("oprType");
	String terminalNo = request.getParameter("terminalNo");
	String regionCode = (String)session.getAttribute("regCode");

	//String []inputPara = new String[]{terminalNo,oprType,grpIdNo,apnId,smCode,org_code};
	%>
	
    <wtc:service name="s3436TermVer" outnum="10" retmsg="msg" retcode="code" routerKey="region" routerValue="<%=regionCode%>">
			<wtc:param value="<%=terminalNo%>" />
			<wtc:param value="<%=oprType%>" />	
			<wtc:param value="<%=grpIdNo%>" />	
			<wtc:param value="<%=apnId%>" />	
			<wtc:param value="<%=smCode%>" />	
			<wtc:param value="<%=org_code%>" />
		</wtc:service>
		<wtc:array id="result_t2" scope="end" />
	
	<%
	
			for(int iii=0;iii<result_t2.length;iii++){
				for(int jjj=0;jjj<result_t2[iii].length;jjj++){
					System.out.println("---------------------result_t2["+iii+"]["+jjj+"]=-----------------"+result_t2[iii][jjj]);
				}
		}
		
		
	String returnCode = code;
	String returnMsg =msg;
	System.out.println("---------------------------returnCode---------------------s3436termVer.jsp---------------------------------"+returnCode);
%>
var response = new AJAXPacket();
var retType = "";
var retCode = "";
var retMessage = "";
<%if(returnCode.equals("000000")){%>
var terminalId        = '<%=result_t2[0][0].trim()%>';                               
var terminalName         = '<%=result_t2[0][1].trim()%>';                               
var terminalType        = '<%=result_t2[0][2].trim()%>'; 
var terminalTypeName        = '<%=result_t2[0][3].trim()%>';                               
var roamType         = '<%=result_t2[0][4].trim()%>';                               
var roamTypeName        = '<%=result_t2[0][5].trim()%>';     
var ipAddress       = '<%=result_t2[0][6].trim()%>';                               
var internetIp    = '<%=result_t2[0][7].trim()%>';                               
var terminalIp      = '<%=result_t2[0][8].trim()%>';                               
var serviceIp    = '<%=result_t2[0][9].trim()%>';
<%}
else{
%>
var terminalId        = '';                               
var terminalName         = '';                               
var terminalType        = ''; 
var terminalTypeName        = '';                               
var roamType         = '';                               
var roamTypeName        = '';     
var ipAddress       = '';                               
var internetIp    = '';                               
var terminalIp      = '';                               
var serviceIp    = '';
<%}%>
retType = "s3436TermVer";
retCode = "<%=returnCode%>";
retMessage = "<%=returnMsg%>";
response.data.add("retType",retType);
response.data.add("retCode",retCode);
response.data.add("retMessage",retMessage);
response.data.add("terminalId",terminalId);
response.data.add("terminalName",terminalName);
response.data.add("terminalType",terminalType);
response.data.add("terminalTypeName",terminalTypeName);
response.data.add("roamType",roamType);
response.data.add("roamTypeName",roamTypeName);
response.data.add("ipAddress",ipAddress);
response.data.add("internetIp",internetIp);
response.data.add("terminalIp",terminalIp);
response.data.add("serviceIp",serviceIp);
core.ajax.receivePacket(response);

<%System.out.println("---------------OK--------------");%>

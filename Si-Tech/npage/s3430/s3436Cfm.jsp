   
<%
/********************
 version v2.0
 开发商 si-tech
 update hejw@2009-2-24
********************/
%>
        

<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ page contentType="text/html;charset=GBK"%>
<%
System.out.println("------------------------------------------------s3436Cfm.jsp---------------------------------");

    String error_code="";
    String error_msg="";
    String opName = "终端与APN对应";
    String opCode = request.getParameter("opCode");
	String smCode = request.getParameter("smCode");
	String loginNo = (String)session.getAttribute("workNo");
	String loginPasswd = request.getParameter("loginPasswd");
	String org_code = (String)session.getAttribute("orgCode");
    String systemNote      = request.getParameter("systemNote");
	String opNote          = request.getParameter("opNote"); 
    String ipAddr          = request.getRemoteAddr();
	String grpIdNo   = request.getParameter("grpIdNo");
	String apnId   = request.getParameter("apnId");
	String terminalId   = request.getParameter("terminalId");
	String terminalNo   = request.getParameter("terminalNo");
	String terminalType   = request.getParameter("terminalType");
	String roamType   = request.getParameter("roamType");
	String ipAddress   = request.getParameter("ipAddress");
	String internetIp   = request.getParameter("internetIp");
	String terminalIp   = request.getParameter("terminalIp");
	String serviceIp   = request.getParameter("serviceIp");
	String apnNo   = request.getParameter("apnNo");
	String oprTypeValue   = request.getParameter("oprTypeValue");
	String loginAccept=request.getParameter("login_accept");
    String TGrpId=request.getParameter("TGrpId");
    String regionCode = (String)session.getAttribute("regCode");
	
	String loginAcceptPara =  loginAccept;
	String opCodePara=        opCode;         
	String loginNoPara=       loginNo;        
	String loginPasswdPara=   loginPasswd;    
	String org_codePara=      org_code;       
	String systemNotePara=    systemNote;     
	String opNotePara=        opNote;         
	String ipAddrPara=        ipAddr; 
	String grpIdNoPara=        grpIdNo; 
	String apnIdPara=        apnId;
	String apnNoPara=        apnNo;
	String terminalIdPara=        terminalId;
	String terminalNoPara=        terminalNo;
	String terminalTypePara=        terminalType;
	String roamTypePara=        roamType;
	String ipAddressPara=        ipAddress;
	String internetIpPara=        internetIp;
	String terminalIpPara=        terminalIp;
	String serviceIpPara=        serviceIp;
	String oprTypeValuePara=        oprTypeValue;

String inputPara[] = new String[20];

	inputPara[0]=loginAcceptPara;
	inputPara[1]=opCodePara     ;
	inputPara[2]=loginNoPara    ;
	inputPara[3]=loginPasswdPara;
	inputPara[4]=org_codePara   ;
	inputPara[5]=systemNotePara ;
	inputPara[6]=opNotePara     ;
	inputPara[7]=ipAddrPara     ;
	inputPara[8]=grpIdNoPara   ;
	inputPara[9]=apnIdPara   ;
	inputPara[10]=apnNoPara   ;
	inputPara[11]=terminalIdPara   ;
	inputPara[12]=terminalNoPara   ;
	inputPara[13]=terminalTypePara   ;
	inputPara[14]=roamTypePara   ;
	inputPara[15]=ipAddressPara   ;
	inputPara[16]=internetIpPara   ;
	inputPara[17]=terminalIpPara   ;
	inputPara[18]=serviceIpPara   ;
	inputPara[19]=oprTypeValuePara   ;

//	String result = impl.callService("s3436Cfm",inputPara,"1");
	%>
	
    <wtc:service name="s3436Cfm" outnum="1" retmsg="msg1" retcode="code1" routerKey="region" routerValue="<%=regionCode%>">
			<wtc:param value="<%=inputPara[0]%>" />
			<wtc:param value="<%=inputPara[1]%>" />
			<wtc:param value="<%=inputPara[2]%>" />
			<wtc:param value="<%=inputPara[3]%>" />			
			<wtc:param value="<%=inputPara[4]%>" />
			<wtc:param value="<%=inputPara[5]%>" />					
			<wtc:param value="<%=inputPara[6]%>" />	
			<wtc:param value="<%=inputPara[7]%>" />	
			<wtc:param value="<%=inputPara[8]%>" />	
			<wtc:param value="<%=inputPara[9]%>" />	
			<wtc:param value="<%=inputPara[10]%>" />	
			<wtc:param value="<%=inputPara[11]%>" />	
      <wtc:param value="<%=inputPara[12]%>" />
			<wtc:param value="<%=inputPara[13]%>" />
			<wtc:param value="<%=inputPara[14]%>" />
			<wtc:param value="<%=inputPara[15]%>" />
			<wtc:param value="<%=inputPara[16]%>" />
			<wtc:param value="<%=inputPara[17]%>" />
			<wtc:param value="<%=inputPara[18]%>" />
			<wtc:param value="<%=inputPara[19]%>" />
		</wtc:service>
	
	<%
	String errorCode = code1;
    String errorMsg = msg1;
    
	%>

	<%String url = "/npage/contact/onceCnttInfo.jsp?opCode="+opCode+
								 "&retCodeForCntt="+code1+
								 "&retMsgForCntt="+msg1+
	               "&opName="+opName+
     	    			 "&workNo="+loginNo+
     	    			 "&loginAccept="+loginAccept+
     	    			 "&pageActivePhone="+TGrpId+
     	    			 "&opBeginTime="+opBeginTime+
     	    			 "&contactId="+TGrpId+
     	    			 "&contactType=grp";%>
<jsp:include page="<%=url%>" flush="true" />
	
	var response = new AJAXPacket();
	var retType = "";
	var retCode = "";
	var retMessage = "";
	retType = "submit";
	retCode = "<%=errorCode%>";
	retMessage = "<%=errorMsg%>";
	response.data.add("retType",retType);
	response.data.add("loginAccept",<%=loginAccept%>);
	response.data.add("retCode",retCode); 
	response.data.add("retMessage",retMessage);
	core.ajax.receivePacket(response);
	

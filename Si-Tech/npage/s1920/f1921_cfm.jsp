<%
/********************
 version v2.0
 开发商: si-tech
 update hejw@2009-1-13
********************/
%>
<%
  String opName = "手机报业务受理";
  String opCode = "1921";
%>

	
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>

<%
    //get info from session

    String login_no = (String)session.getAttribute("workNo");
    String org_code = (String)session.getAttribute("orgCode");
		String login_passwd = (String)session.getAttribute("password");
		String region_code = (String)session.getAttribute("regCode");
		
		String idType="01";
		String idValue  = request.getParameter("phoneno");
		String optype  = request.getParameter("optype");
		String opcode    = request.getParameter("opCode");//操作码
		String NewPasswd = request.getParameter("NewPasswd");
		String oldPasswd = request.getParameter("confirmPasswd");
		
		
		String printAccept = request.getParameter("printAccept");
		if(optype.equals("03")){
			NewPasswd = request.getParameter("modiPasswd");
			oldPasswd = request.getParameter("NewPasswd");
		}
		
		String HomeProv = request.getParameter("HomeProv");
		String bizType=request.getParameter("busytype");
		String spCode=request.getParameter("spCode");
		if(spCode!=null){
			spCode=spCode.trim();
		}
		String spBizCode=request.getParameter("spBizCode");
		if(spBizCode!=null){
			spBizCode=spBizCode.trim();
		}
		String infocode="";
		String infovalue="";
 
		String value001=request.getParameter("value001");
		String code001=request.getParameter("code001");
		if(value001!=null && !value001.equals("")){
		        infocode+=code001+"|";
		        infovalue+=value001.trim()+"|";
		}
		String value002=request.getParameter("value002");
		String code002=request.getParameter("code002");
		if(value002!=null && !value002.equals("")){
		        infocode+=code002+"|";
		        infovalue+=value002.trim()+"|";
		}
		String value003=request.getParameter("value003");
		String code003=request.getParameter("code003");
		if(value003!=null && !value003.equals("")){
		        infocode+=code003+"|";
		        infovalue+=value003.trim()+"|";
		}
		String value004=request.getParameter("value004");
		String code004=request.getParameter("code004");
		if(value004!=null && !value004.equals("")){
		        infocode+=code004+"|";
		        infovalue+=value004.trim()+"|";
		}
		String value300=request.getParameter("value300");
		String code300=request.getParameter("code300");
		if(value300!=null && !value300.equals("")){
		        infocode+=code300+"|";
		        infovalue+=value300.trim()+"|";
		}
		String value301=request.getParameter("value301");
		String code301=request.getParameter("code301");
		if(value301!=null && !value301.equals("")){
		        infocode+=code301+"|";
		        infovalue+=value301.trim()+"|";
		}
 
	
	//初始话服务所需要的参数
	/*
	String[] paraArray = new String[24];
	int i =0;
  paraArray[i++] = printAccept;
	paraArray[i++] = login_no;
	paraArray[i++] = org_code;
  paraArray[i++] = login_passwd;
	paraArray[i++] = "1921";
	
	paraArray[i++]= idType;
	paraArray[i++] = idValue;		
	paraArray[i++] = "451";
	paraArray[i++] = optype;
	paraArray[i++] = bizType;
	
	paraArray[i++] = spCode;
	paraArray[i++] = spBizCode;
	paraArray[i++] = NewPasswd;
	paraArray[i++] = oldPasswd;
	paraArray[i++] = "";
	paraArray[i++] = "";
	paraArray[i++] = "";
	paraArray[i++] = infocode;
	paraArray[i++] = infovalue;
	
	paraArray[i++] = "08";
	paraArray[i++] = "";
	paraArray[i++] = "";
	paraArray[i++] = "0";
	paraArray[i++] = "1";
	*/
	/*===================================*/

	String[] paraArray = new String[24];
paraArray[0] = printAccept;
paraArray[1] = "01";
paraArray[2] = "1921";
paraArray[3] = login_no;
paraArray[4] = login_passwd;
paraArray[5] = idValue;	
paraArray[6] = "";
paraArray[7] = org_code;
paraArray[8]= idType;
paraArray[9] = optype;
paraArray[10] = bizType;
paraArray[11] = oldPasswd;
paraArray[12] = NewPasswd;
paraArray[13] = spCode;
paraArray[14] = spBizCode;
paraArray[15] = infocode;
paraArray[16] = infovalue;
paraArray[17] = "";
paraArray[18] = "";
paraArray[19] = "";
paraArray[20] = "";
paraArray[21] = "";
paraArray[22] = "08";
paraArray[23] = "1";
	
	for(int k=0;k<paraArray.length;k++){
		System.out.println("----------------------------paraArray["+k+"]=[-------------------------"+paraArray[k]+"]");
	}


	//调用服务
	//String[] ret = impl.callService("sBizReq",paraArray,"2","phone",idValue);

	%>
<wtc:service  name="s9113Cfm"  routerKey="phone" routerValue="<%=idValue%>" retcode="retCode" retmsg="retMsg" outnum="9">
    <wtc:param  value="<%=paraArray[0]%>"/>	
    <wtc:param  value="<%=paraArray[1]%>"/>
    <wtc:param  value="<%=paraArray[2]%>"/>
    <wtc:param  value="<%=paraArray[3]%>"/>
    <wtc:param  value="<%=paraArray[4]%>"/>
    
    <wtc:param  value="<%=paraArray[5]%>"/>
    <wtc:param  value="<%=paraArray[6]%>"/>
    <wtc:param  value="<%=paraArray[7]%>"/>
    <wtc:param  value="<%=paraArray[8]%>"/>
    <wtc:param  value="<%=paraArray[9]%>"/>
    
    <wtc:param  value="<%=paraArray[10]%>"/>
    <wtc:param  value="<%=paraArray[11]%>"/>
    <wtc:param  value="<%=paraArray[12]%>"/>
    <wtc:param  value="<%=paraArray[13]%>"/>
    <wtc:param  value="<%=paraArray[14]%>"/>
    
    <wtc:param  value="<%=paraArray[15]%>"/>
    <wtc:param  value="<%=paraArray[16]%>"/>
    <wtc:param  value="<%=paraArray[17]%>"/>
    <wtc:param  value="<%=paraArray[18]%>"/>
    <wtc:param  value="<%=paraArray[19]%>"/>
    
    <wtc:param  value="<%=paraArray[20]%>"/>
    <wtc:param  value="<%=paraArray[21]%>"/>
    <wtc:param  value="<%=paraArray[22]%>"/>
    <wtc:param  value="<%=paraArray[23]%>"/>
</wtc:service>
	
	<%

	String errCode = retCode;
	String errMsg = retMsg;
	
%>
<%String url ="/npage/contact/upCnttInfo.jsp?opCode="+opCode+
							"&retCodeForCntt="+errCode+
							"&opName="+opName+
							"&workNo="+login_no+
							"&loginAccept="+printAccept+
							"&pageActivePhone="+idValue+
							"&retMsgForCntt="+errMsg+
							"&opBeginTime="+opBeginTime; 
							System.out.println("url:"+url);
							%>
<jsp:include page="<%=url%>" flush="true" />

<%if(!errCode.equals("000000")){%>
<script language="JavaScript">
        rdShowMessageDialog("业务受理失败，原因：<%=errMsg%>!",0);
        history.go(-1);
</script>
<%}
else{
%>
<script language="JavaScript">
        rdShowMessageDialog("业务受理成功!",2);
      	window.location.href="f1921.jsp?activePhone=<%=idValue%>"
</script>
<%}%>

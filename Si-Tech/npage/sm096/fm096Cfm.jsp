<%
/********************
 * version v2.0
 * gaopeng 2014/05/08 15:27:04 关于请贵部配合进行2014年Radius工程相关需求开发的函
 * 开发商: si-tech
 ********************/
%>

<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%
		response.setHeader("Pragma","No-Cache"); 
		response.setHeader("Cache-Control","No-Cache");
		response.setDateHeader("Expires", 0); 
		
		System.out.println("============ fm096Cfm.jsp ==========");
		
		String regionCode = (String)session.getAttribute("regCode");
		
		String iLoginAccept = request.getParameter("iLoginAccept");
		String iChnSource = request.getParameter("iChnSource");
		String iOpCode =  request.getParameter("iOpCode");
		String opName =  request.getParameter("iOpName");
		String opCode = iOpCode;
		String iLoginNo = request.getParameter("iLoginNo");
		String iLoginPwd =  request.getParameter("iLoginPwd");
		String iPhoneNo =  request.getParameter("iPhoneNo");
		String iUserPwd =  request.getParameter("iUserPwd");
		
		java.util.Date sysdate = new java.util.Date();
		java.text.SimpleDateFormat sf1 = new java.text.SimpleDateFormat("yyyyMMddHHmmss");
		String init_time = sf1.format(sysdate);
		System.out.println("gaopengSeeLog===init_time="+init_time);
		
		
		
		String iBiz_type =  request.getParameter("iBiz_type");
		String iSpid =  request.getParameter("iSpid");
		String iBiz_code =  request.getParameter("iBiz_code");
		String iOprCode =  request.getParameter("iOprCode");
		String iEff_date =  request.getParameter("iEff_date");
		iEff_date = init_time;
		
		String iExp_date =  request.getParameter("iExp_date");
		String iOp_time =  request.getParameter("iOp_time");
		iOp_time = init_time;
		
		String iOp_note =  request.getParameter("iOp_note");
		String pwd1 =  request.getParameter("pwd1");
		String pwd2 =  request.getParameter("pwd2");
		

		
		String  inputParsm [] = new String[18];
		inputParsm[0] = iLoginAccept;
		inputParsm[1] = iChnSource;
		inputParsm[2] = iOpCode;
		inputParsm[3] = iLoginNo;
		inputParsm[4] = iLoginPwd;
		inputParsm[5] = iPhoneNo;
		inputParsm[6] = iUserPwd;
		inputParsm[7] = iBiz_type;
		inputParsm[8] = iSpid;
		inputParsm[9] = iBiz_code;
		inputParsm[10] = iOprCode;
		inputParsm[11] = iEff_date;
		inputParsm[12] = iExp_date;
		inputParsm[13] = iOp_time;
		inputParsm[14] = iOp_note;
		inputParsm[15] = iPhoneNo+"@cmcc-edu";
		inputParsm[16] = pwd1;
		inputParsm[17] = pwd2;
		
		System.out.println("gaopengSeeLog=====================inputParsm[0]="+inputParsm[0]);
		System.out.println("gaopengSeeLog=====================inputParsm[1]="+inputParsm[1]);
		System.out.println("gaopengSeeLog=====================inputParsm[2]="+inputParsm[2]);
		System.out.println("gaopengSeeLog=====================inputParsm[3]="+inputParsm[3]);
		System.out.println("gaopengSeeLog=====================inputParsm[4]="+inputParsm[4]);
		System.out.println("gaopengSeeLog=====================inputParsm[5]="+inputParsm[5]);
		System.out.println("gaopengSeeLog=====================inputParsm[6]="+inputParsm[6]);
		System.out.println("gaopengSeeLog=====================inputParsm[7]="+inputParsm[7]);
		System.out.println("gaopengSeeLog=====================inputParsm[8]="+inputParsm[8]);
		System.out.println("gaopengSeeLog=====================inputParsm[9]="+inputParsm[9]);
		System.out.println("gaopengSeeLog=====================inputParsm[10]="+inputParsm[10]);
		System.out.println("gaopengSeeLog=====================inputParsm[11]="+inputParsm[11]);
		System.out.println("gaopengSeeLog=====================inputParsm[12]="+inputParsm[12]);
		System.out.println("gaopengSeeLog=====================inputParsm[13]="+inputParsm[13]);
		System.out.println("gaopengSeeLog=====================inputParsm[14]="+inputParsm[14]);
		System.out.println("gaopengSeeLog=====================inputParsm[15]="+inputParsm[15]);
		System.out.println("gaopengSeeLog=====================inputParsm[16]="+inputParsm[16]);
		System.out.println("gaopengSeeLog=====================inputParsm[17]="+inputParsm[17]);
		
		
		String retCode1 = "";
		String retMsg1 = "";
		
		
		
		
		/*调用 sE474Init 服务 返回 安装联系人姓名、安装联系人电话、安装地址*/
		try{
%>
		<wtc:service name="sProWorkFlowCfm" routerKey="region" routerValue="<%=regionCode%>"
					 retcode="retCode" retmsg="retMsg" outnum="2">
				<wtc:param value="<%=inputParsm[0]%>"/>
				<wtc:param value="<%=inputParsm[1]%>"/>
				<wtc:param value="<%=inputParsm[2]%>"/>
				<wtc:param value="<%=inputParsm[3]%>"/>
				<wtc:param value="<%=inputParsm[4]%>"/>
				<wtc:param value="<%=inputParsm[5]%>"/>
				<wtc:param value="<%=inputParsm[6]%>"/>
				<wtc:param value="<%=inputParsm[7]%>"/>
				<wtc:param value="<%=inputParsm[8]%>"/>
				<wtc:param value="<%=inputParsm[9]%>"/>
				<wtc:param value="<%=inputParsm[10]%>"/>
				<wtc:param value="<%=inputParsm[11]%>"/>
				<wtc:param value="<%=inputParsm[12]%>"/>
				<wtc:param value="<%=inputParsm[13]%>"/>
				<wtc:param value="<%=inputParsm[14]%>"/>
				<wtc:param value="<%=inputParsm[15]%>"/>
				<wtc:param value="<%=inputParsm[16]%>"/>
				<wtc:param value="<%=inputParsm[17]%>"/>
				
		</wtc:service>
		<wtc:array id="ret" scope="end"/>
<%
		
		if("000000".equals(retCode)){
			
			System.out.println("============gaopengSeeLog fm096Cfm.jsp ==========" + ret.length);
			retCode1 = retCode;
			retMsg1 = retMsg;
			if(ret.length > 0 ){
				
				System.out.println("============gaopengSeeLog fm096Cfm.jsp ========== ret[0][0]"+ret[0][0]);
				System.out.println("============gaopengSeeLog fm096Cfm.jsp ========== ret[0][1]"+ret[0][1]);
				System.out.println("============gaopengSeeLog fm096Cfm.jsp ========== ret[0][2]"+ret[0][2]);
				System.out.println("============gaopengSeeLog fm096Cfm.jsp ========== ret[0][3]"+ret[0][3]);
				System.out.println("============gaopengSeeLog fm096Cfm.jsp ========== ret[0][4]"+ret[0][4]);
				System.out.println("============gaopengSeeLog fm096Cfm.jsp ========== ret[0][5]"+ret[0][5]);
				System.out.println("============gaopengSeeLog fm096Cfm.jsp ========== ret[0][6]"+ret[0][6]);
				
			}
		}else{
			System.out.println("==========gaopengSeeLog== fm096Cfm.jsp 失败==========");
			retCode1 = retCode;
			retMsg1 = retMsg;
			System.out.println("==========gaopengSeeLog== fm096Cfm.jsp 失败=========="+retCode1);
			System.out.println("==========gaopengSeeLog== fm096Cfm.jsp 失败=========="+retMsg1);
			
		}
	}catch(Exception e){
	System.out.println("==========gaopengSeeLog== fm096Cfm.jsp 失败=====4444=====");
		retCode1 = "4444";
		retMsg1 = "系统异常~请联系管理员";
	}
	System.out.println("==========gaopengSeeLog== fm096Cfm.jsp end=====retCode1====="+retCode1);
	System.out.println("==========gaopengSeeLog== fm096Cfm.jsp end=====retMsg1====="+retMsg1);
	retMsg1 = retMsg1.replaceAll("\"","");
	retMsg1 = retMsg1.replaceAll(";","");
%>

var response = new AJAXPacket();
	response.data.add("errCode","<%= retCode1 %>");
	response.data.add("errMsg","<%= retMsg1 %>");
	
	
	core.ajax.receivePacket(response);
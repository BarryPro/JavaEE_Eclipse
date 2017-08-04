<%
/********************
     version v2.0
     开发商: si-tech
     4240异地单卡写卡验证AJAX页面，调用s4150Snd(s4150异地客户资料查询接口)
     gaopeng 20130105 改为新版界面，与产品部qucc合作
     ********************/
%> 
<%request.setCharacterEncoding("GBK");%>
<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>

 

<%
	//String errorMsg="系统错误，请与系统管理员联系，谢谢!!";
	//String errorCode="444444";
	//String[][] errCodeMsg = null;

	//String[][] callData = null;
	//String[][] callData1 = null;

	//List al = null;
	//boolean showFlag=false;	//showFlag表示是否有数据可供显示
  //int valid = 1;	//0:正确，1：系统错误，2：业务错误

	//String strArray="var arrMsg = new Array(); ";  //must 
	//String strArray1="var arrMsg1 = new Array(); ";  //must

  String verifyType = request.getParameter("verifyType");
	//String[][] input_paras = new String[1][13];  
	//String[][] recv_num = new String[3][2];
	
	String loginNo 		 = request.getParameter("loginNo"); 	/* 操作工号   */ 
	System.out.println(loginNo);
	String orgCode 		 = request.getParameter("orgCode");	  /* 归属代码   */	
	System.out.println(orgCode);
	String opCode 		 = request.getParameter("opCode");		/* 操作代码   */
	System.out.println(opCode);
	String totalDate 	 = request.getParameter("totalDate");		
	String idType 		 = request.getParameter("IDType");	 
	String phoneNo 		 = request.getParameter("phoneNo");	/*手机号码*/
	System.out.println(opCode);
	String custPWD 		 = request.getParameter("custPWD");	/*客服密码*/
	String cardType 	 = request.getParameter("cardType");/*证件类型*/
	String cardID 		 = request.getParameter("cardID");/*证件ID*/
	String servLevel 		 = request.getParameter("servLevel");/*服务级别*/
	String attendant 		 = request.getParameter("attendant");/*随员人数*/
	String qryType		 = request.getParameter("qryType");
	String beginTime	 = request.getParameter("beginTime");
	String endTime		 = request.getParameter("endTime");
	String testFlag=request.getParameter("test_flag");
	String opNote="机场服务鉴权,手机号:"+phoneNo;
	String loginNoPass 		 = request.getParameter("loginNoPass"); 	/* 工号密码   */ 
	
	String regionCode= (String)session.getAttribute("regCode");
	System.out.println(regionCode+"----gaopeng");
	String PrintAccept = request.getParameter("PrintAccept");
	String  inputParsm [] = new String[12];
		inputParsm[0] = PrintAccept;	//流水    
		inputParsm[1] = "01";       //渠道标识  
		inputParsm[2] = opCode;     //操作代码  
		inputParsm[3] = loginNo;    // 操作工号 
		inputParsm[4] = loginNoPass;    //工号密码  
		inputParsm[5] = phoneNo;    //手机号码  
		inputParsm[6] = custPWD;   //号码密码  
		inputParsm[7] = orgCode;     //工号归属  
		inputParsm[8] = cardType;    //证件类型  
		inputParsm[9] = cardID;  //证件号码  
		inputParsm[10] = servLevel;   //服务级别  
		inputParsm[11] = attendant;		//随员人数 
		
	
 
		String retCode="";
		String retMsg="";
		String endcardcode="";
		String cardcodesql="select a.card_code from dbvipadm.dGrpBigUserMsg a,dgrpmanagermsg b where a.service_no=b.service_no	and a.phone_no='"+phoneNo+"'";
	try{
	%>
	<wtc:service name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>" outnum="1" retcode="retCode21" retmsg="retMsg21">
			<wtc:param value="<%=cardcodesql%>"/>
		</wtc:service>
		<wtc:array id="result21" scope="end"/>
	<wtc:service name="s4228Qry" routerKey="region" routerValue="<%=regionCode%>"
					 retcode="retCode1" retmsg="retMsg1" outnum="25">
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
		</wtc:service>
		<wtc:array id="result12" scope="end"/>
var resultmsg = new Array();	
<%	
retCode=retCode1;
retMsg=retMsg1;
if(result21.length>0){
	endcardcode=result21[0][0];
}
	if(result12.length>0 && "000000".equals(retCode))
	{
	String resultmsgs="var resultmsg = new Array(); ";
	for(int i=0;i<result12.length;i++){
	%>
	resultmsg[<%=i%>]=new Array();
	<%
		for(int j=0;j<11;j++){
%>

resultmsg[<%=i%>][<%=j%>] = "<%=result12[i][j].trim()%>";
<%		
}	
	}
	}
else{
	System.out.println("调用s4150Snd----in-----s4226_prc_id.jsp---失败！");
	System.out.println(retCode);
	System.out.println(retMsg);
}
}
catch(Exception e){
System.out.println("cuocuowa111133");
			retCode= "444444";
			retMsg= "系统异常";
			System.out.println("retMsg="+retMsg);
		}
%>


var response = new AJAXPacket();
response.data.add("verifyType","<%= verifyType %>");
response.data.add("errorCode","<%= retCode %>");
response.data.add("errorMsg","<%= retMsg %>");
response.data.add("endcardcode","<%= endcardcode %>");

<%
if("000000".equals(retCode.trim())){
%>
response.data.add("backArrMsg",resultmsg );
<%
}
else{
%>
response.data.add("backArrMsg","" );
<%
}
%>
core.ajax.receivePacket(response);



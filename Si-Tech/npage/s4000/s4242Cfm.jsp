<%
    /********************
     version v2.0
     开发商: si-tech
     s4242异地写卡结果回传发起调用s4242Snd，写卡成功后调用s4244.jsp进行sim卡激活
     gaopeng
     ********************/
%>
<%request.setCharacterEncoding("GBK");%>
<%@ page contentType= "text/html;charset=GBK" %>
<%@ page import="java.util.ArrayList"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%
String opCode = "g412";
		String opName = "异地单卡写卡";
	ArrayList arrSession = (ArrayList)session.getAttribute("allArr");
	String[][] baseInfoSession = (String[][])arrSession.get(0);
	String[][] otherInfoSession = (String[][])arrSession.get(2);
	String[][] pass = (String[][])arrSession.get(4);
	
	String loginNo = baseInfoSession[0][2];
	String loginName = baseInfoSession[0][3];
	String powerCode= otherInfoSession[0][4];
	String orgCode = baseInfoSession[0][16];
	String ip_Addr = request.getRemoteAddr();
	
	String regionCode = orgCode.substring(0,2);
	String regionName = otherInfoSession[0][5];
	String loginNoPass = pass[0][0];

	String errorMsg="系统错误，请与系统管理员联系，谢谢!!";
	String errorCode="444444";
	String[][] errCodeMsg = null;
	 
	
	
	/*List al = null;*/
	
  	int valid = 1;	//0:正确，1：系统错误，2：业务错误
	String op_code = "4242";
 	 
 	String phoneNo=request.getParameter("phone");
	String IMSI=request.getParameter("IMSI");
	String ICCID=request.getParameter("ICCID");
	String Result=request.getParameter("Result");
	String multflag=request.getParameter("multflag");
	String opNote=request.getParameter("opNote");
	String custPWD=request.getParameter("custPWD");//客户密码
	String cardID=request.getParameter("cardID"); //证件号码
	String cardType=request.getParameter("cardType"); //证件类型

	String tmpBusyAccept=request.getParameter("tmpBusyAccept");
	String ORPSSeq=request.getParameter("loginAccept");
	//added by ludl for chinamobile active transaction begin 0820
  String prov_codetmp  = request.getParameter("prov_code");
	//added by ludl for chinamobile active transaction end 0820


	String  ICCID_temp =ICCID.substring(0,12)+prov_codetmp+ICCID.substring(13,ICCID.length());
	//MyLog.debugLog("ICCID_temp="+ICCID_temp);
	String Name="";
	String Value="";
// begin modified  by ludl
	String testFlag=request.getParameter("test_flag");
		if (testFlag == null || "".equals(testFlag))
	{
		testFlag = "0";
	}
	//String testFlag=request.getParameter("test_flag");
// end modified 20070617 
  //al = f4242Req.doProcess(loginNo,  orgCode,  op_code, phoneNo,testFlag, IMSI,Result, opNote,tmpBusyAccept);
 		String  inputParsm [] = new String[11];
		inputParsm[0] = loginNo;
		inputParsm[1] = orgCode;
		inputParsm[2] = op_code;
		inputParsm[3] = "";
		inputParsm[4] = IMSI;
		inputParsm[5] = Result;
		inputParsm[6] = "";
%>
	<wtc:service name="s4242Snd" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode" retmsg="retMsg" outnum="5">
		<wtc:param value="<%=inputParsm[0]%>"/>
		<wtc:param value="<%=inputParsm[1]%>"/>
		<wtc:param value="<%=inputParsm[2]%>"/>
		<wtc:param value="<%=inputParsm[3]%>"/>
		<wtc:param value="<%=inputParsm[4]%>"/>
		<wtc:param value="<%=inputParsm[5]%>"/>
		<wtc:param value="<%=inputParsm[6]%>"/>
	</wtc:service>
	<wtc:array id="result11" scope="end"/>
<%		
	//System.out.println(result11.length+"---gaopenggaopenggaopenggaopenggaopeng";
  if( result11.length <= 0 )
  {
		valid = 1;
	}
	else if (result11.length>0 && retCode.equals("0000"))
	{
			valid = 0;
	}
  else if(!retCode.equals("0000"))
	{
		valid = 2;
	}
	System.out.println("valid="+valid+"---gaopenggaopenggaopenggaopenggaopeng");
%>
<%if( valid == 1){%>
<script language="JavaScript">
	rdShowMessageDialog("系统错误，请与系统管理员联系，谢谢!!");
	history.go(-1);
</script>
<%}else if( valid == 2){%>
<script language="JavaScript">
	rdShowMessageDialog("<br>错误代码:["+"<%=retCode %>]</br>"+"错误信息:["+"<%=retMsg %>"+"]");
	<%if(multflag.equals("0")){%>	
	window.location.href="s4240.jsp";
	<%}else{%>
	window.location.href="s4246.jsp";
	<%}%>
</script>
<%}else{%>
<script language="JavaScript">
<%if(Result.equals("00")&&multflag.equals("0")){
%>
rdShowMessageDialog("<br>[写卡成功，您现在可以激活sim卡"+"]");

window.location.href="s4244.jsp?phone=<%=phoneNo%>&sSimNo=<%=ICCID_temp%>&sImsiNo=<%=IMSI%>&custPWD=<%=custPWD%>&cardID=<%=cardID%>&cardType=<%=cardType%>";
//location.href="s4244.jsp?phone=<%=phoneNo%>&sSimNo=<%=ICCID_temp%>&sImsiNo=<%=IMSI%>";
<%
System.out.println("--------------------厂商代码" +prov_codetmp);
System.out.println("----------------------------------------------------");
System.out.println("----------------------------------------------------");
System.out.println("----------------------------------------------------");
System.out.println("------------------------ICCID:" + ICCID);
System.out.println("----------------------------------------------------");
System.out.println("----------------------------------------------------");
System.out.println("----------------------------------------------------");
}
else{
%>
rdShowMessageDialog("[<br>写卡失败"+"]");
location.href="s4240.jsp";
<%
}%>
	
	
</script>
<%}%>

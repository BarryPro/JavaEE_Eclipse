<%
/********************
     version v2.0
     开发商: si-tech
     4240写卡申请确认界面，调用s4240Snd(s4240异地写卡发起接口)
     gaopeng 20130105 改为新版界面，与产品部qucc合作
     ********************/
%> 
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ include file="/npage/bill/getMaxAccept.jsp" %>
<%@ page import="com.sitech.boss.s1100.viewBean.*" %>


<!-- **** ningtn add for pos @ 20100408 ******加载建行控件页 BankCtrl ******** -->
<%@ include file="/npage/public/posCCB.jsp" %>
<!-- **** ningtn add for pos @ 20100408 ******加载工行控件页 KeeperClient ******** -->
<%@ include file="/npage/public/posICBC.jsp" %>
<%@ page import="com.sitech.oneboss.common.util.*"%>
<%
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
	
	String sSimNo="";
	String sImsiNo="";
	String KI="";
	String PIN1="";
	String PUK1="";
	String PIN2="";
	String PUK2="";
	String SMSP="";
	
	List al = null;
	
  	int valid = 1;	//0:正确，1：系统错误，2：业务错误
	String op_code = "g412";
 	 
	String phoneNo  =request.getParameter("phoneNo");
	String provHome =request.getParameter("provHome");
	String opNote=request.getParameter("opNote");

	String tmpBusyAccept=request.getParameter("tmpBusyAccept");
	String ORPSSeq=request.getParameter("loginAccept");
	String oName="remote";
	String Value="1111";
	String testFlag=request.getParameter("test_flag");
	String simData="";
	String TmpKI="";
	
	String custPWD=request.getParameter("custPWD");//客户密码
	String cardID=request.getParameter("cardID"); //证件号码
	String cardType=request.getParameter("cardType"); //证件类型
  //al = f4240Req.doProcess(loginNo,  orgCode,  op_code, phoneNo,testFlag, oName,Value, opNote,provHome,ORPSSeq,tmpBusyAccept);

	String  inputParsm [] = new String[11];
		inputParsm[0] = loginNo;
		inputParsm[1] = orgCode;
		inputParsm[2] = op_code;
		inputParsm[3] ="";
		inputParsm[4] = phoneNo;
		inputParsm[5] = ORPSSeq;
		inputParsm[6] = oName;
		inputParsm[7] = Value;
		inputParsm[8] = provHome;
		inputParsm[9] = opNote;
		//inputParsm[4] = testFlag;
		//inputParsm[5] = oName;
		//inputParsm[6] = Value;
		//inputParsm[7] = opNote;
		//inputParsm[8] = provHome;
		//inputParsm[9] = ORPSSeq;
		//inputParsm[10] = tmpBusyAccept;

%>
		<wtc:service name="s4240Snd" routerKey="region" routerValue="<%=regionCode%>"
					 retcode="retCode" retmsg="retMsg" outnum="24">
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
				
				

		</wtc:service>
		<wtc:array id="ret" scope="end"/>



<%
System.out.println("asdasdasdas--------------------"+ret.length);
  if(!"0000".equals(retCode.trim()))
	{
			valid = 2;
			
	}
 else if( ret.length <= 0 )
  {
		valid = 1;
	}
	
	else if(ret.length>0)
	{
	valid = 0;
		/**F4240XmlRspBody bodyRsp=(F4240XmlRspBody)al.get(2);
		if(bodyRsp!=null){
			List cardDataList=bodyRsp.getWriteCardData();
			if(cardDataList!=null){
			WriteCardData cardData=(WriteCardData)cardDataList.get(0);
				if(cardData!=null){
			*/
					/*sSimNo=cardData.getICCID();*/
					sSimNo=ret[0][8].trim();
					System.out.println("gaopengList-------------1-------|"+sSimNo);
					/*MyLog.debugLog("sSimNo=["+sSimNo+"]");*/
					/*sImsiNo=cardData.getIMSI();*/
					sImsiNo=ret[0][6].trim();
					System.out.println("gaopengList-------------2-------|"+sImsiNo);
					/*TmpKI=cardData.getKi();*/
					TmpKI=ret[0][10].trim();
					/*MyLog.debugLog("TmpKI111=["+TmpKI+"]");*/
					System.out.println("gaopengList-------------3-------|"+TmpKI);
					Tools tool=new Tools();
					KI=tool.encrypt(TmpKI);
					/*KI=TmpKI;*/
					/*MyLog.debugLog("KI=["+KI+"]");*/
				System.out.println("gaopengList-------------4-------|"+KI);
                   
					PIN1=ret[0][14].trim();
					System.out.println("gaopengList-------------5-------|"+PIN1);
					PUK1=ret[0][18].trim();
					System.out.println("gaopengList-------------6-------|"+PUK1);
					PIN2=ret[0][16].trim();
					System.out.println("gaopengList-------------7-------|"+PIN2);
					PUK2=ret[0][20].trim();
					System.out.println("gaopengList-------------8-------|"+PUK2);
					SMSP=ret[0][12].trim();
					System.out.println("gaopengList-------------9-------|"+SMSP);
					/*MyLog.debugLog("SMSP=["+SMSP+"]");*/
					simData=sSimNo+","+sImsiNo+","+KI+","+SMSP+","+PIN1+","+PIN2+","+PUK1+","+PUK2;
					System.out.println("asdasdasdas-------------10-------|"+simData);
				/**}
			}*/
		}
		/**
		errCodeMsg = (String[][])al.get(0);
		errorCode = errCodeMsg[0][0];
		*/
		/*MyLog.debugLog("errCodeMsg:"+errCodeMsg+"   errorCode:"+errorCode);*/
		
		
		else
		{			
			valid = 0;
		}
	
	
%>
<%if( valid == 1)
{
%>
<script language="JavaScript">
	rdShowMessageDialog("系统错误，请与系统管理员联系，谢谢!!");
	history.go(-1);
</script>
<%
}
else if( valid == 2)
	{
%>
<script language="JavaScript">
	rdShowMessageDialog("<br>错误代码:["+"<%=retCode %>]</br>"+"错误信息:["+"<%=retMsg %>"+"]");
	//location.href="s4242Cfm.jsp?phone=<%=phoneNo%>&IMSI=<%=sImsiNo%>&Result=11&tmpBusyAccept=<%=tmpBusyAccept%>&multflag=0";
	history.go(-1);
	
</script>
<%}else{%>
<script language="JavaScript">
	location.href="s4240RPS.jsp?phone=<%=phoneNo%>&sImsiNo=<%=sImsiNo%>&sSimNo=<%=sSimNo%>&prov=<%=provHome%>&tmpBusyAccept=<%=tmpBusyAccept%>&simData=<%=simData%>&custPWD=<%=custPWD%>&cardID=<%=cardID%>&cardType=<%=cardType%>";
</script>
<%}%>

<BODY>
<FORM name="frm" METHOD=POST ACTION="">
<INPUT TYPE="hidden" NAME="phone"><BR>
<INPUT TYPE="hidden" NAME="IMSI"><BR>
<INPUT TYPE="hidden" NAME="Result"><BR>
</FORM>
</BODY>









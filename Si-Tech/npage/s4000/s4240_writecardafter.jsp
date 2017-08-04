<%
/*
* 功能: 
* 版本: 1.0
* 日期: liangyl 2017/05/03 liangyl 关于全面恢复省际跨区补卡服务的通知
* 作者: liangyl
* 版权: si-tech
*/
%>
<%@ page contentType= "text/html;charset=gbk" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%
	String regionCode= (String)session.getAttribute("regCode");
	
	String bipCode       = "BIP2B021";//业务代码
	String transCode     = "T2000022";//交易代码
	String loginNo 		 = WtcUtil.repStr(request.getParameter("loginNo"),"");/* 操作工号   */ 
	String orgCode 		 = WtcUtil.repStr(request.getParameter("orgCode"),"");/* 归属代码   */
	String idValue 		 = WtcUtil.repStr(request.getParameter("idValue"),"");//号码
	String seq 	 		 = WtcUtil.repStr(request.getParameter("seq"),"");//操作流水号,可不填
	String myseq 	 		 = WtcUtil.repStr(request.getParameter("myseq"),"");//操作流水号,可不填
	
	String IMSI 	 	 = WtcUtil.repStr(request.getParameter("IMSI"),"");//IMSI
	String writeresult   = WtcUtil.repStr(request.getParameter("writeresult"),"");///写卡验证结果
	String encK   = WtcUtil.repStr(request.getParameter("encK"),"");//用归属省K2puk加密K后的密文
	String encOpc   = WtcUtil.repStr(request.getParameter("encOpc"),"");//用归属省K2puk加密OPc后的密文
	String signature   = WtcUtil.repStr(request.getParameter("signature"),"");//签名
	String localProvCode   = WtcUtil.repStr(request.getParameter("localProvCode"),"");//漫游省省代码
	String bHomeProv   = WtcUtil.repStr(request.getParameter("bHomeProv"),"");//对方省代码
	
	String serviceFee   = WtcUtil.repStr(request.getParameter("serviceFee"),"");//服务费
	String simFee   = WtcUtil.repStr(request.getParameter("simFee"),"0");//sim卡卡费
	String simCardNumber   = WtcUtil.repStr(request.getParameter("simCardNumber"),"");//sim卡序列号
	String bICCID   = WtcUtil.repStr(request.getParameter("bICCID"),"");//新sim卡卡号
	
	System.out.println("liangyl-------"+loginNo);
	System.out.println("liangyl-------"+orgCode);
	System.out.println("liangyl-------"+idValue);
	System.out.println("liangyl-------"+seq);
	System.out.println("liangyl-------"+IMSI);
	System.out.println("liangyl-------"+writeresult);
	System.out.println("liangyl-------"+encK);
	System.out.println("liangyl-------"+encOpc);
	System.out.println("liangyl-------"+signature);
	
	System.out.println("liangyl-------"+localProvCode);
	System.out.println("liangyl-------"+serviceFee);
	System.out.println("liangyl-------"+simFee);
	System.out.println("liangyl-------"+simCardNumber);
	System.out.println("liangyl-------"+bICCID);
	
	
	
	String opNote = "异地单卡写卡操作,"+loginNo+"进行异地写USIM卡结果回传及申请开通";//备注
	
	String  inputParsm [] = new String[14];
	inputParsm[0] = bipCode;
	inputParsm[1] = transCode;
	inputParsm[2] = loginNo;
	inputParsm[3] = orgCode;
	inputParsm[4] = idValue;
	inputParsm[5] = seq;
	inputParsm[6] = IMSI;
	inputParsm[7] = writeresult;
	inputParsm[8] = encK;
	inputParsm[9] = encOpc;
	inputParsm[10] = signature;
	inputParsm[11] = localProvCode;
	inputParsm[12] = serviceFee;
	inputParsm[13] = opNote;
	String retCode1="";
	String retMsg1="";
%>
<wtc:service name="sTSNPubSnd" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode" retmsg="retMsg" outnum="8">
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
</wtc:service>
<wtc:array id="result" scope="end"/>
var resultmsg = new Array();
<%
if(result.length>0 && "000000".equals(retCode)){
	for(int i=0;i<result.length;i++){
	%>
		resultmsg[<%=i%>]=new Array();
	<%
		for(int j=0;j<result[i].length;j++){
			System.out.println("liangyl----------------"+result[i][j]);
	%>
		resultmsg[<%=i%>][<%=j%>] = "<%=result[i][j]%>";
	<%		
		}	
	}
	String  inputParsm1 [] = new String[14];
	inputParsm1[0] = myseq;
	inputParsm1[1] = "01";
	inputParsm1[2] = "g412";
	inputParsm1[3] = loginNo;
	inputParsm1[4] = "";
	inputParsm1[5] = idValue;
	inputParsm1[6] = "";
	inputParsm1[7] = simFee;
	inputParsm1[8] = simCardNumber;
	inputParsm1[9] = "";
	inputParsm1[10] = bICCID;
	inputParsm1[11] = IMSI;
	inputParsm1[12] = seq;
	inputParsm1[13] = bHomeProv;
	%>
	<wtc:service name="sg412Chg" routerKey="region" routerValue="<%=regionCode%>" retcode="retCodeChg" retmsg="retMsgChg" outnum="14">
		<wtc:param value="<%=inputParsm1[0]%>"/>
		<wtc:param value="<%=inputParsm1[1]%>"/>
		<wtc:param value="<%=inputParsm1[2]%>"/>
		<wtc:param value="<%=inputParsm1[3]%>"/>
		<wtc:param value="<%=inputParsm1[4]%>"/>
		<wtc:param value="<%=inputParsm1[5]%>"/>
		<wtc:param value="<%=inputParsm1[6]%>"/>
		<wtc:param value="<%=inputParsm1[7]%>"/>
		<wtc:param value="<%=inputParsm1[8]%>"/>
		<wtc:param value="<%=inputParsm1[9]%>"/>
		<wtc:param value="<%=inputParsm1[10]%>"/>
		<wtc:param value="<%=inputParsm1[11]%>"/>
		<wtc:param value="<%=inputParsm1[12]%>"/>
		<wtc:param value="<%=inputParsm1[13]%>"/>
	</wtc:service>
	<wtc:array id="result" scope="end"/>
	<%
	retCode1=retCodeChg;
	retMsg1=retMsgChg;
}else{
	retCode1=retCode;
	retMsg1=retMsg;
}
%>
var response = new AJAXPacket();
response.data.add("retCode","<%=retCode1%>");
response.data.add("retMsg","<%=retMsg1%>");
response.data.add("resultmsg",resultmsg);
core.ajax.receivePacket(response);
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ page contentType="text/html;charset=GBK"%>
<%
System.out.println("-------------------ajaxGetBillPrt.jsp--------------");
String phoneNo = request.getParameter("phoneNo");
String serOId = request.getParameter("serVId");
String opCode1 = request.getParameter("opCode1Hv");
String opCode2 = request.getParameter("opCode2Hv");
String loginAccept = request.getParameter("loginAcceptHv");
String regionCode = (String)session.getAttribute("regCode");
/* liujian add workNo and password 2012-4-5 15:59:15 begin */
String opCode = request.getParameter("opCode");
String opName = request.getParameter("opName");
String workNo = (String)session.getAttribute("workNo");
String password = (String) session.getAttribute("password");
/* liujian add workNo and password 2012-4-5 15:59:15 end */
String retInfo="";
/**tianyang add for pos**/
String payType = request.getParameter("payType");
String posPay = StrToPrice(request.getParameter("returnMoneyHv"));
System.out.println("---------------posPay-----------"+posPay);
/**tianyang add for pos**/
%>
<wtc:utype name="sReverInfo" id="retVal" scope="end"  routerKey="region" routerValue="<%=regionCode%>">
          <wtc:uparam value="<%=phoneNo%>" type="String"/>
          <wtc:uparam value="<%=serOId%>" type="String"/>
          <wtc:uparam value="<%=opCode1%>" type="String"/>
          <wtc:uparam value="<%=opCode2%>" type="String"/>
          <wtc:uparam value="<%=loginAccept%>" type="LONG"/>
</wtc:utype>
<wtc:utype name="sPMQryUserInfo" id="retUserInfo" scope="end"  routerKey="region" routerValue="<%=regionCode%>">
     <wtc:uparam value="0" type="LONG"/>
     <wtc:uparam value="<%=phoneNo%>" type="STRING"/>
     <wtc:uparam value="<%=workNo%>" type="string"/>
     <wtc:uparam value="<%=password%>" type="string"/>
     <wtc:uparam value="<%=opCode%>" type="string"/>		
</wtc:utype>
<%
   	String retCode11=retVal.getValue(0);
	String retMsg11=retVal.getValue(1);
	StringBuffer logBuffer = new StringBuffer(80);
	WtcUtil.recursivePrint(retVal,1,"2",logBuffer);
	System.out.println(logBuffer.toString());
	String taocLeib = "";
	String taocanMingc = "";
	String czczOffert   = "";
	String czczOffertId = "";
	String czhzOffert = "";
	String czhzOffertId = "";
	String comeFlag = "";
if(retCode11.equals("0")){  
	if(retVal.getSize("2.0")>0){
			czczOffertId  = retVal.getValue("2.0.2");
			czczOffert = retVal.getValue("2.0.2")+"--"+retVal.getValue("2.0.3");
			comeFlag = retVal.getValue("2.0.7");
	}
	String offerIdF3264= "";
  if(retVal.getSize("2.2")>0){
     if(retVal.getSize("2.2.0")>0){
     			offerIdF3264 =retVal.getValue("2.2.0.2");
	         taocanMingc = retVal.getValue("2.2.0.2") +"-->"+ retVal.getValue("2.2.0.3");
           taocLeib  = retVal.getValue("2.2.0.5");
	           }
	         }
	if(retVal.getSize("2.1")>0){
			czhzOffertId = retVal.getValue("2.1.2");
			czhzOffert =retVal.getValue("2.1.2")+"--"+retVal.getValue("2.1.3");
	}
}
%>
    <wtc:service name="sDynSqlCfm" outnum="1" retmsg="msg" retcode="code" routerKey="region" routerValue="<%=regionCode%>">
			<wtc:param value="220" />
			<wtc:param value="<%=czczOffertId%>" />
		</wtc:service>
		<wtc:array id="result_t" scope="end" />
<%
String baoNfee = "";
if(result_t.length>0&&result_t[0][0]!=null){
	baoNfee =result_t[0][0];
}

String retCode =retUserInfo.getValue(0);
String retMsg  =retUserInfo.getValue(1);
String stPMvPhoneNo       = ""; /*手机号码*/
String stPMid_no          = "";  /*用户id*/
String stPMcust_id        = "";  /*客户id*/
String stPMcontract_no    = "";  /*默认帐号*/
String stPMbelong_code    = "";  /*用户归属*/
String stPMsm_code        = "";  /*业务类型代码*/
String stPMsm_name        = "";  /*业务类型名称*/
String stPMsm_kind        = "";  /*c,g,d,e*/
String stPMcust_name      = "";  /*客户名称*/
String stPMuser_passwd    = "";  /*用户密码*/
String stPMrun_code       = "";  /*状态代码*/
String stPMrun_name       = "";  /*状态名称*/
String stPMowner_grade    = "";  /*等级代码*/
String stPMgrade_name     = "";  /*等级名称*/
String stPMowner_type     = "";  /*用户类型代码*/
String stPMtype_name      = "";  /*用户类型名称*/
String stPMcust_address   = "";  /*客户住址*/
String stPMid_type        = "";  /*证件类型*/
String stPMid_name        = "";  /*证件名称*/
String stPMid_iccid       = "";  /*证件号码*/
String stPMcard_type      = "";  /*客户卡类型*/
String stPMcard_name      = "";  /*客户卡类型名称*/
String stPMvip_no         = "";  /*VIP卡号*/
String stPMgrpbig_flag    = "";  /*集团客户标志*/
String stPMgrpbig_name    = "";  /*集团客户名称*/
String stPMbak_field      = "";  /*备用字段*/
String stPMgroup_id       = "";  /*归属标识*/
String stPMcontact_person = "";  /* 联系人  */
String stPMcontact_phone  = "";  /* 联系电话 */
String stPMowner_code     = "";  /* 用户属性 */
String stPMcredit_code    = "";  /* 信用类型 */
String stPMmode_code      = "";  /* 当月基本产品ID*/
String stPMmode_name      = "";  /* 当月基本产品名称*/
String stPMtotalOwe       = "";  /*总欠费*/
String stPMtotalPrepay    = ""; /*总预存*/
String unbillFee          = ""; /*未出帐话费*/
String accountNo          = ""; /*第一个帐户*/
String accountOwe         = ""; /*第一个帐户欠费*/
String openTime           = ""; /*开户时间*/

if(retCode.equals("0"))
{
stPMvPhoneNo       = retUserInfo.getValue("2.0.2.0");   /*手机号码*/
stPMid_no          = retUserInfo.getValue("2.0.2.1");   /*用户id*/
stPMcust_id        = retUserInfo.getValue("2.0.2.2");   /*客户id*/
stPMcontract_no    = retUserInfo.getValue("2.0.2.3");   /*默认帐号*/
stPMbelong_code    = retUserInfo.getValue("2.0.2.4");   /*用户归属*/
stPMsm_code        = retUserInfo.getValue("2.0.2.5");   /*业务类型代码*/
stPMsm_name        = retUserInfo.getValue("2.0.2.6");   /*业务类型名称*/
stPMsm_kind        = retUserInfo.getValue("2.0.2.7");   /*c,g,d,e*/
stPMcust_name      = retUserInfo.getValue("2.0.2.8");   /*客户名称*/
stPMuser_passwd    = retUserInfo.getValue("2.0.2.9");   /*用户密码*/
stPMrun_code       = retUserInfo.getValue("2.0.2.10");  /*状态代码*/
stPMrun_name       = retUserInfo.getValue("2.0.2.11");  /*状态名称*/
stPMowner_grade    = retUserInfo.getValue("2.0.2.12");  /*等级代码*/
stPMgrade_name     = retUserInfo.getValue("2.0.2.13");  /*等级名称*/
stPMowner_type     = retUserInfo.getValue("2.0.2.14");  /*用户类型代码*/
stPMtype_name      = retUserInfo.getValue("2.0.2.15");  /*用户类型名称*/
stPMcust_address   = retUserInfo.getValue("2.0.2.16");  /*客户住址*/
stPMid_type        = retUserInfo.getValue("2.0.2.17");  /*证件类型*/
stPMid_name        = retUserInfo.getValue("2.0.2.18");  /*证件名称*/
stPMid_iccid       = retUserInfo.getValue("2.0.2.19");  /*证件号码*/
stPMcard_type      = retUserInfo.getValue("2.0.2.20");  /*客户卡类型*/
stPMcard_name      = retUserInfo.getValue("2.0.2.21");  /*客户卡类型名称*/
stPMvip_no         = retUserInfo.getValue("2.0.2.22");  /*VIP卡号*/
stPMgrpbig_flag    = retUserInfo.getValue("2.0.2.23");  /*集团客户标志*/
stPMgrpbig_name    = retUserInfo.getValue("2.0.2.24");  /*集团客户名称*/
stPMbak_field      = retUserInfo.getValue("2.0.2.25");  /*备用字段*/
stPMgroup_id       = retUserInfo.getValue("2.0.2.26");  /*归属标识*/
stPMcontact_person = retUserInfo.getValue("2.0.2.27");  /* 联系人  */
stPMcontact_phone  = retUserInfo.getValue("2.0.2.28");  /* 联系电话 */
stPMowner_code     = retUserInfo.getValue("2.0.2.29");  /* 用户属性 */
stPMcredit_code    = retUserInfo.getValue("2.0.2.30");  /* 信用类型 */
stPMmode_code      = retUserInfo.getValue("2.0.2.31");  /* 当月基本产品ID*/
stPMmode_name      = retUserInfo.getValue("2.0.2.32");  /* 当月基本产品名称*/
stPMtotalOwe       = retUserInfo.getValue("2.0.2.33");  /*总欠费*/
stPMtotalPrepay    = retUserInfo.getValue("2.0.2.34");  /*总预存*/
unbillFee          = retUserInfo.getValue("2.0.2.35");  /*未出帐话费*/
accountNo          = retUserInfo.getValue("2.0.2.36");  /*第一个帐户*/
accountOwe         = retUserInfo.getValue("2.0.2.37");  /*第一个帐户欠费*/
openTime           = retUserInfo.getValue("2.0.2.38");  /*开户时间*/
}
%>
<%!
String StrToPrice(String v_value)
{
	if(v_value.indexOf(".")!=-1){
  		v_value = v_value+"00";
  	}
  	else{
  		v_value = v_value+".00";
  	}
  	v_value = v_value.substring(0,v_value.indexOf(".")+3);
  	return v_value;
}
%>
<wtc:utype name="sQUserOfferInst" id="retVal1" scope="end"  routerKey="region" routerValue="<%=regionCode%>">
          <wtc:uparam value="<%=stPMid_no%>" type="LONG"/>
          <wtc:uparam value="99" type="LONG"/>
          <wtc:uparam value="0" type="LONG"/>
          <wtc:uparam value="0" type="LONG"/>
</wtc:utype>
<%
	String beginTime = "";
  String endTime = "";
	int countTempF = 0;
	countTempF = retVal1.getSize("2");
	for(int ij= 0;ij<countTempF;ij++){
		if(retVal1.getValue("2."+ij+".3").equals("10")&&retVal1.getValue("2."+ij+".8").equals("有效")){
			beginTime = retVal1.getValue("2."+ij+".5");
			endTime = retVal1.getValue("2."+ij+".6");
		}
	}

String beginTime1 = "";
String endTime1 = "";
try{
 Date tempDateV1 = new java.text.SimpleDateFormat("yyyyMMddHHmmss").parse(beginTime);
 beginTime1 =new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(tempDateV1).toString();
 Date tempDateV2 = new java.text.SimpleDateFormat("yyyyMMddHHmmss").parse(endTime);
 endTime1 =new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(tempDateV2).toString();
}catch(Exception e){
}
		  	if(unbillFee.indexOf(".")!=-1){
		  		unbillFee = unbillFee+"00";
		  	}else{
		  		unbillFee = unbillFee+".00";
		  		}
		  	unbillFee = unbillFee.substring(0,unbillFee.indexOf(".")+3);
		  	if(stPMtotalPrepay.indexOf(".")!=-1){
		  		stPMtotalPrepay = stPMtotalPrepay+"00";
		  	}else{
		  		stPMtotalPrepay = stPMtotalPrepay+".00";
		  		}
		  	stPMtotalPrepay = stPMtotalPrepay.substring(0,stPMtotalPrepay.indexOf(".")+3);
		  	if(baoNfee.indexOf(".")!=-1){
		  		baoNfee = baoNfee+"00";
		  	}else{
		  		baoNfee = baoNfee+".00";
		  		}
		  	baoNfee = baoNfee.substring(0,baoNfee.indexOf(".")+3);
out.print("var  billArgsObj = new Object();");
if(opCode1.equals("1104") || opCode1.equals("q001")){
/** tianyang update for pos start **/
String cash = "";
if(payType.equals("BX")||payType.equals("BY")){
	cash = StrToPrice("0");
}else{
	cash = StrToPrice(retVal.getValue("2.4.5"));
}
/** tianyang update for pos end **/
String custid = stPMcust_id;
String mobile = stPMvPhoneNo;
String cheque = StrToPrice(retVal.getValue("2.4.6"));
String thework_no = (String)session.getAttribute("workNo");
String openrandom = request.getParameter("openrandom");
String custName = stPMcust_name;
String userid = custid;
String innetFee = StrToPrice(retVal.getValue("2.4.8"));
String handFee = StrToPrice(retVal.getValue("2.4.0"));
String choiceFee = StrToPrice(retVal.getValue("2.4.1"));
String machineFee = StrToPrice(retVal.getValue("2.4.3"));
String simFee = StrToPrice(retVal.getValue("2.4.4"));
String prepayFee = StrToPrice(retVal.getValue("2.4.2"));
String currentPay="";
if(!cash.equals("")&&!cheque.equals(""))
{
 	currentPay = String.valueOf(Double.parseDouble(cash)+Double.parseDouble(cheque));
}else if(cheque.equals("")&&!cash.equals("")){
	 cheque="0.00";
	 currentPay = String.valueOf(Double.parseDouble(cash));
}else if(!cheque.equals("")&&cash.equals("")){
	 cash="0.00";
	 currentPay = String.valueOf(Double.parseDouble(cheque));
}
String yearValue = new java.text.SimpleDateFormat("yyyy",Locale.getDefault()).format(new java.util.Date());
String monthValue = new java.text.SimpleDateFormat("MM",Locale.getDefault()).format(new java.util.Date());
String dayValue=new java.text.SimpleDateFormat("dd",Locale.getDefault()).format(new java.util.Date());
System.out.println("-------------------ajaxGetBillPrt.jsp--------------"+cash);
System.out.println("-------------------ajaxGetBillPrt.jsp--------------"+cheque);
System.out.println("-------------------ajaxGetBillPrt.jsp--------------"+posPay);
out.print("$(billArgsObj).attr(\"10001\",\""+thework_no+"\");");
out.print("$(billArgsObj).attr(\"10002\",\""+yearValue+"\");");
out.print("$(billArgsObj).attr(\"10003\",\""+monthValue+"\");");
out.print("$(billArgsObj).attr(\"10004\",\""+dayValue+"\");");
out.print("$(billArgsObj).attr(\"10005\",\""+custName+"\");");
out.print("$(billArgsObj).attr(\"10006\",\""+opName+"\");");
out.print("$(billArgsObj).attr(\"10008\",\""+mobile+"\");");
out.print("$(billArgsObj).attr(\"10009\",\""+userid+"\");");
out.print("$(billArgsObj).attr(\"10015\",\"-"+currentPay+"\");");
out.print("$(billArgsObj).attr(\"10016\",\"-"+currentPay+"\");");
		String sumtypes1="";
 		String sumtypes2="";
 		String sumtypes3="";
 		
 		if(!cash.equals("0.00")) {
 			System.out.println("-------------------ajaxGetBillPrt.jsp--------------cashPay");
 			sumtypes1="*";
 		}
  	   if(!cheque.equals("0.00") ){
  	   		System.out.println("-------------------ajaxGetBillPrt.jsp--------------checkPay");
 			sumtypes2="*";
 		}
 		if(!posPay.equals("0.00")) {
 			System.out.println("-------------------ajaxGetBillPrt.jsp--------------posPay");
 			sumtypes3="*";

 		} 
out.print("$(billArgsObj).attr(\"10017\",\""+sumtypes1+"\");");
out.print("$(billArgsObj).attr(\"10018\",\""+sumtypes2+"\");");
out.print("$(billArgsObj).attr(\"10019\",\""+sumtypes3+"\");");
if(!(innetFee.equals("0.00"))){
	out.print("$(billArgsObj).attr(\"10020\",\"-"+WtcUtil.formatNumber(innetFee,2)+"\");");
}else{
	out.print("$(billArgsObj).attr(\"10020\",\""+WtcUtil.formatNumber(innetFee,2)+"\");");
}
if(!(handFee.equals("0.00"))){
	out.print("$(billArgsObj).attr(\"10021\",\"-"+WtcUtil.formatNumber(handFee,2)+"\");");
}else{
	out.print("$(billArgsObj).attr(\"10021\",\""+WtcUtil.formatNumber(handFee,2)+"\");");
}
if(!(choiceFee.equals("0.00"))){
	out.print("$(billArgsObj).attr(\"10022\",\"-"+WtcUtil.formatNumber(choiceFee,2)+"\");");
}else{
	out.print("$(billArgsObj).attr(\"10022\",\""+WtcUtil.formatNumber(choiceFee,2)+"\");");
}
if(!(simFee.equals("0.00"))){
	out.print("$(billArgsObj).attr(\"10024\",\"-"+WtcUtil.formatNumber(simFee,2)+"\");");
}else{
	out.print("$(billArgsObj).attr(\"10024\",\""+WtcUtil.formatNumber(simFee,2)+"\");");
}
if(!(prepayFee.equals("0.00"))){
	out.print("$(billArgsObj).attr(\"10025\",\"-"+WtcUtil.formatNumber(prepayFee,2)+"\");");
}else{
	out.print("$(billArgsObj).attr(\"10025\",\""+WtcUtil.formatNumber(prepayFee,2)+"\");");
}
if(!(machineFee.equals("0.00"))){
	out.print("$(billArgsObj).attr(\"10026\",\"-"+WtcUtil.formatNumber(machineFee,2)+"\");");
}else{
	out.print("$(billArgsObj).attr(\"10026\",\""+WtcUtil.formatNumber(machineFee,2)+"\");");
}
out.print("$(billArgsObj).attr(\"10030\",\""+openrandom+"\");");
out.print("$(billArgsObj).attr(\"10031\",\""+thework_no+"\");");
out.print("$(billArgsObj).attr(\"10036\",\""+opCode+"\");");

 }
%>
var response = new AJAXPacket();
response.data.add("retInfo",billArgsObj);
core.ajax.receivePacket(response);
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
String stPMvPhoneNo       = ""; /*�ֻ�����*/
String stPMid_no          = "";  /*�û�id*/
String stPMcust_id        = "";  /*�ͻ�id*/
String stPMcontract_no    = "";  /*Ĭ���ʺ�*/
String stPMbelong_code    = "";  /*�û�����*/
String stPMsm_code        = "";  /*ҵ�����ʹ���*/
String stPMsm_name        = "";  /*ҵ����������*/
String stPMsm_kind        = "";  /*c,g,d,e*/
String stPMcust_name      = "";  /*�ͻ�����*/
String stPMuser_passwd    = "";  /*�û�����*/
String stPMrun_code       = "";  /*״̬����*/
String stPMrun_name       = "";  /*״̬����*/
String stPMowner_grade    = "";  /*�ȼ�����*/
String stPMgrade_name     = "";  /*�ȼ�����*/
String stPMowner_type     = "";  /*�û����ʹ���*/
String stPMtype_name      = "";  /*�û���������*/
String stPMcust_address   = "";  /*�ͻ�סַ*/
String stPMid_type        = "";  /*֤������*/
String stPMid_name        = "";  /*֤������*/
String stPMid_iccid       = "";  /*֤������*/
String stPMcard_type      = "";  /*�ͻ�������*/
String stPMcard_name      = "";  /*�ͻ�����������*/
String stPMvip_no         = "";  /*VIP����*/
String stPMgrpbig_flag    = "";  /*���ſͻ���־*/
String stPMgrpbig_name    = "";  /*���ſͻ�����*/
String stPMbak_field      = "";  /*�����ֶ�*/
String stPMgroup_id       = "";  /*������ʶ*/
String stPMcontact_person = "";  /* ��ϵ��  */
String stPMcontact_phone  = "";  /* ��ϵ�绰 */
String stPMowner_code     = "";  /* �û����� */
String stPMcredit_code    = "";  /* �������� */
String stPMmode_code      = "";  /* ���»�����ƷID*/
String stPMmode_name      = "";  /* ���»�����Ʒ����*/
String stPMtotalOwe       = "";  /*��Ƿ��*/
String stPMtotalPrepay    = ""; /*��Ԥ��*/
String unbillFee          = ""; /*δ���ʻ���*/
String accountNo          = ""; /*��һ���ʻ�*/
String accountOwe         = ""; /*��һ���ʻ�Ƿ��*/
String openTime           = ""; /*����ʱ��*/

if(retCode.equals("0"))
{
stPMvPhoneNo       = retUserInfo.getValue("2.0.2.0");   /*�ֻ�����*/
stPMid_no          = retUserInfo.getValue("2.0.2.1");   /*�û�id*/
stPMcust_id        = retUserInfo.getValue("2.0.2.2");   /*�ͻ�id*/
stPMcontract_no    = retUserInfo.getValue("2.0.2.3");   /*Ĭ���ʺ�*/
stPMbelong_code    = retUserInfo.getValue("2.0.2.4");   /*�û�����*/
stPMsm_code        = retUserInfo.getValue("2.0.2.5");   /*ҵ�����ʹ���*/
stPMsm_name        = retUserInfo.getValue("2.0.2.6");   /*ҵ����������*/
stPMsm_kind        = retUserInfo.getValue("2.0.2.7");   /*c,g,d,e*/
stPMcust_name      = retUserInfo.getValue("2.0.2.8");   /*�ͻ�����*/
stPMuser_passwd    = retUserInfo.getValue("2.0.2.9");   /*�û�����*/
stPMrun_code       = retUserInfo.getValue("2.0.2.10");  /*״̬����*/
stPMrun_name       = retUserInfo.getValue("2.0.2.11");  /*״̬����*/
stPMowner_grade    = retUserInfo.getValue("2.0.2.12");  /*�ȼ�����*/
stPMgrade_name     = retUserInfo.getValue("2.0.2.13");  /*�ȼ�����*/
stPMowner_type     = retUserInfo.getValue("2.0.2.14");  /*�û����ʹ���*/
stPMtype_name      = retUserInfo.getValue("2.0.2.15");  /*�û���������*/
stPMcust_address   = retUserInfo.getValue("2.0.2.16");  /*�ͻ�סַ*/
stPMid_type        = retUserInfo.getValue("2.0.2.17");  /*֤������*/
stPMid_name        = retUserInfo.getValue("2.0.2.18");  /*֤������*/
stPMid_iccid       = retUserInfo.getValue("2.0.2.19");  /*֤������*/
stPMcard_type      = retUserInfo.getValue("2.0.2.20");  /*�ͻ�������*/
stPMcard_name      = retUserInfo.getValue("2.0.2.21");  /*�ͻ�����������*/
stPMvip_no         = retUserInfo.getValue("2.0.2.22");  /*VIP����*/
stPMgrpbig_flag    = retUserInfo.getValue("2.0.2.23");  /*���ſͻ���־*/
stPMgrpbig_name    = retUserInfo.getValue("2.0.2.24");  /*���ſͻ�����*/
stPMbak_field      = retUserInfo.getValue("2.0.2.25");  /*�����ֶ�*/
stPMgroup_id       = retUserInfo.getValue("2.0.2.26");  /*������ʶ*/
stPMcontact_person = retUserInfo.getValue("2.0.2.27");  /* ��ϵ��  */
stPMcontact_phone  = retUserInfo.getValue("2.0.2.28");  /* ��ϵ�绰 */
stPMowner_code     = retUserInfo.getValue("2.0.2.29");  /* �û����� */
stPMcredit_code    = retUserInfo.getValue("2.0.2.30");  /* �������� */
stPMmode_code      = retUserInfo.getValue("2.0.2.31");  /* ���»�����ƷID*/
stPMmode_name      = retUserInfo.getValue("2.0.2.32");  /* ���»�����Ʒ����*/
stPMtotalOwe       = retUserInfo.getValue("2.0.2.33");  /*��Ƿ��*/
stPMtotalPrepay    = retUserInfo.getValue("2.0.2.34");  /*��Ԥ��*/
unbillFee          = retUserInfo.getValue("2.0.2.35");  /*δ���ʻ���*/
accountNo          = retUserInfo.getValue("2.0.2.36");  /*��һ���ʻ�*/
accountOwe         = retUserInfo.getValue("2.0.2.37");  /*��һ���ʻ�Ƿ��*/
openTime           = retUserInfo.getValue("2.0.2.38");  /*����ʱ��*/
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
		if(retVal1.getValue("2."+ij+".3").equals("10")&&retVal1.getValue("2."+ij+".8").equals("��Ч")){
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
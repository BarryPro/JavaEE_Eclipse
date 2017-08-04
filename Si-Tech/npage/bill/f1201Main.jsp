<%
/********************
 *version v2.0
 *开发商: si-tech
 *update by qidp @ 2008-12-23 页面改造,修改样式
 ********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page contentType="text/html;charset=GBK"%>
<%@ page import="com.sitech.boss.pub.util.Encrypt"%>
<%@ page import="java.util.*"%>
<%@ page import="java.text.*" %>
<%
    String opCode = "1201";
    String opName = "随意行包年";

    String loginNo = (String)session.getAttribute("workNo");
    String loginName = (String)session.getAttribute("workName");
    String powerCode= (String)session.getAttribute("powerCode");
    String orgCode = (String)session.getAttribute("orgCode");
    String ip_Addr = (String)session.getAttribute("ip_Addr");
    String regionCode = orgCode.substring(0,2);
    String loginNoPass = (String)session.getAttribute("password");
    String aftertrim = ((String)session.getAttribute("powerRight")).trim();
    System.out.println("---------------随意行-----"+aftertrim);
%>
<%
  String retFlag="",retMsg="";//用于判断页面刚进入时的正确性
/****************由移动号码得到密码、机主姓名、 等信息 s1201Init***********************/
  //SPubCallSvrImpl impl = new SPubCallSvrImpl();
  //ArrayList retList = new ArrayList();
  String[] paraAray1 = new String[4];
  String phoneNo = request.getParameter("srv_no");
  String passwordFromSer="";

  paraAray1[0] = phoneNo;	/* 手机号码   */
  paraAray1[1] = loginNo; 	/* 操作工号   */
  paraAray1[2] = orgCode;	/* 归属代码   */
  paraAray1[3] = "1201";	/* 操作代码   */
  for(int i=0; i<paraAray1.length; i++)
  {
	if( paraAray1[i] == null )
	{
	  paraAray1[i] = "";
	}
  }
  //retList = impl.callFXService("s1201Init", paraAray1, "27","phone",phoneNo);
%>

    <wtc:service name="s1201Init" routerKey="phone" routerValue="<%=phoneNo%>" retcode="s1201InitCode" retmsg="s1201InitMsg" outnum="27">
        <wtc:params value="<%=paraAray1%>"/>
    </wtc:service>
    <wtc:array id="s1201InitArr" scope="end" />

<%
  String  bp_name="",sm_code="",rate_code="",bigCust_flag="",sm_name="",rate_name="",bigCust_name="",next_rate_code="",next_rate_name="",lack_fee="",prepay_fee="",bp_add="",cardId_type="", cardId_no="", cust_id="",cust_belong_code="",group_type_code="",group_type_name="",imain_stream="",next_main_stream="",hand_fee="",favorcode="",card_no="",print_note="";
  //String[][] tempArr= new String[][]{};
  //int errCode = impl.getErrCode();
  //String errMsg = impl.getErrMsg();

  String errCode = s1201InitCode;
  String errMsg = s1201InitMsg;
  if(s1201InitArr == null)
  {
	if(!retFlag.equals("1"))
	{
	   retFlag = "1";
	   retMsg = "s1201Init查询号码基本信息为空!";
    }
  }else{
	if (errCode.equals("000000")){
	  if(!(s1201InitArr[0][3].equals(""))){
	    bp_name = s1201InitArr[0][3];//机主姓名
	  }

	  if(!(s1201InitArr[0][4].equals(""))){
	    bp_add = s1201InitArr[0][4];//客户地址
	  }

	  if(!(s1201InitArr[0][2].equals(""))){
	    passwordFromSer = s1201InitArr[0][2];//密码
	  }

	  if(!(s1201InitArr[0][11].equals(""))){
	    sm_code = s1201InitArr[0][11];//业务类别
	  }

	  if(!(s1201InitArr[0][12].equals(""))){
	    sm_name = s1201InitArr[0][12];//业务类别名称
	  }

	  if(!(s1201InitArr[0][13].equals(""))){
	    hand_fee = s1201InitArr[0][13];//手续费
	  }

	  if(!(s1201InitArr[0][14].equals(""))){
	    favorcode = s1201InitArr[0][14];//优惠代码
	  }

	  if(!(s1201InitArr[0][5].equals(""))){
	    rate_code = s1201InitArr[0][5];//资费代码
	  }

	  if(!(s1201InitArr[0][6].equals(""))){
	    rate_name = s1201InitArr[0][6];//资费名称
	  }

	  if(!(s1201InitArr[0][7].equals(""))){
	    next_rate_code = s1201InitArr[0][7];//下月资费代码
	  }

	  if(!(s1201InitArr[0][8].equals(""))){
	    next_rate_name = s1201InitArr[0][8];//下月资费名称
	  }

	  if(!(s1201InitArr[0][9].equals(""))){
	    bigCust_flag = s1201InitArr[0][9];//大客户标志
	  }

	  if(!(s1201InitArr[0][10].equals(""))){
	    bigCust_name = s1201InitArr[0][10];//大客户名称
	  }

	  if(!(s1201InitArr[0][15].equals(""))){
	    lack_fee = s1201InitArr[0][15];//总欠费
	  }

	  if(!(s1201InitArr[0][16].equals(""))){
	    prepay_fee = s1201InitArr[0][16];//总预交
	  }

	  if(!(s1201InitArr[0][17].equals(""))){
	    cardId_type = s1201InitArr[0][17];//证件类型
	  }

	  if(!(s1201InitArr[0][18].equals(""))){
	    cardId_no = s1201InitArr[0][18];//证件号码
	  }

	  if(!(s1201InitArr[0][19].equals(""))){
	    cust_id = s1201InitArr[0][19];//客户id
	  }

	  if(!(s1201InitArr[0][20].equals(""))){
	    cust_belong_code = s1201InitArr[0][20];//客户归属id
	  }

	  if(!(s1201InitArr[0][21].equals(""))){
	    group_type_code = s1201InitArr[0][21];//集团客户类型
	  }

	  if(!(s1201InitArr[0][22].equals(""))){
	    group_type_name = s1201InitArr[0][22];//集团客户类型名称
	  }

	  if(!(s1201InitArr[0][23].equals(""))){
	    imain_stream = s1201InitArr[0][23];//当前资费开通流水
	  }

	  if(!(s1201InitArr[0][24].equals(""))){
	    next_main_stream = s1201InitArr[0][24];//预约资费开通流水
	  }

	  if(!(s1201InitArr[0][25].equals(""))){
	    print_note = s1201InitArr[0][25];//工单广告词
	  }

	}else{
		if(!retFlag.equals("1"))
	    {
	       retFlag = "1";
	       retMsg = "s1201Init查询号码基本信息失败!<br>" + "errCode: " + errCode + "<br>errMsg: " + errMsg;
        }
	}
  }

////******************得到下拉框数据***************************//
//  comImpl co=new comImpl();
//  //资费代码
//  String sqlNewRateCode  = "";
//  sqlNewRateCode  = "select c.mode_code||'~'||a.pay_type||'~'||round(months_between(a.end_time,a.begin_time)),  c.mode_code||'--'||c.mode_name from sbillmoderelease a,sbillmodecode c where substr(a.group_id,1,2)=c.region_code and a.mode_code=c.mode_code and c.region_code ='" + orgCode.substring(0,2) + "' and a.mode_code in ( select new_mode from cBillBbChg  where region_code='" +  orgCode.substring(0,2) + "' and op_code='1201' and POWER_RIGHT <=" + aftertrim + " and old_mode='" + rate_code + "')";
//  System.out.println("sqlNewRateCode=============" + sqlNewRateCode);
//  ArrayList newRateCodeArr  = co.spubqry32("2",sqlNewRateCode );
//  String[][] newRateCodeStr  = (String[][])newRateCodeArr.get(0);
//  //数据卡类型
//  String sqlCardType  = "";
//  sqlCardType  = "select card_type||'~'||year_fee||'~'||card_name, card_type||'--'||card_name from sDataCardYear " ;
//  ArrayList cardTypeArr  = co.spubqry32("2",sqlCardType );
//  String[][] cardTypeStr  = (String[][])cardTypeArr.get(0);

%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>随意行包年</title>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">

<script language="JavaScript">
  <%if(retFlag.equals("1")){%>
    rdShowMessageDialog("<%=retMsg%>");
    history.go(-1);
  <%}%>

<!--
  //定义应用全局的变量
  var SUCC_CODE	= "0";   		//自己应用程序定义
  var ERROR_CODE  = "1";			//自己应用程序定义
  var YE_SUCC_CODE = "0000";	 	//根据营业系统定义而修改

  var oprType_Add = "a";
  var oprType_Upd = "u";
  var oprType_Del = "d";
  var oprType_Qry = "q";

  var arrContractNo = new Array();//合并合同号
  var arrPayType = new Array();//付费类型

  //core.loadUnit("debug");
  //core.loadUnit("rpccore");

  onload=function()
  {
	  //core.rpc.onreceive = doProcess;
  }
  //---------1------RPC处理函数------------------
  function doProcess(packet){

  	//added by hanfa 20070116 begin
  	var vRetPage=packet.data.findValueByName("rpc_page");

  	if(vRetPage == "querySmcode")
	{
		var errCode = packet.data.findValueByName("errCode");
	    var errMsg = packet.data.findValueByName("errMsg");
		var m_smCode = packet.data.findValueByName("m_smCode");
		self.status="";

		if(errCode == 0)
		{
			document.all.m_smCode.value = m_smCode;
		}else
		{
			rdShowMessageDialog("错误:"+ errCode + "->" + errMsg,0);
			return false;
		}
	}//added by hanfa 20070116 end
	else
	{
		//使用RPC的时候,以下三个变量作为标准使用.
		var errorCode = packet.data.findValueByName("errorCode");
		var errorMsg =  packet.data.findValueByName("errorMsg");
		var verifyType = packet.data.findValueByName("verifyType");
		var bind_cust_name = "";
		arrContractNo = packet.data.findValueByName("arrContractNo");
		arrPayType = packet.data.findValueByName("arrPayType");
		bind_cust_name = packet.data.findValueByName("bind_cust_name");

		self.status="";
		if(verifyType=="confirm"){
		  if( parseInt(errorCode) == 0 ){
			 document.frm.bind_cust_name.value = bind_cust_name;
			 document.frm.ifValid.value="1";
			 rdShowMessageDialog("验证成功!",2);
		  }else{
			document.frm.ifValid.value="0";
			rdShowMessageDialog("错误代码："+errorCode+"错误信息："+errorMsg,0);
			return false;
		  }
	    }
  	}
  }
  /**************/
  function commitRpc()
  {
	if(!checkElement(document.frm.bind_phone_no))
	{
		return false;
	}
	var phoneNo = document.frm.bind_phone_no.value;
	var myPacket = new AJAXPacket("f1203RpcConfirm.jsp");
	myPacket.data.add("verifyType","confirm");
	myPacket.data.add("loginNo","<%=loginNo%>");
	myPacket.data.add("loginNoPass","<%=loginNoPass%>");
	myPacket.data.add("opCode","1201");
	myPacket.data.add("orgCode","<%=orgCode%>");
	myPacket.data.add("phoneNo",phoneNo);
	core.ajax.sendPacket(myPacket);
 	myPacket = null;
  }
  //***
  function frmCfm(){
 	frm.submit();
	return true;
  }
  //***//校验
  function check(){
 	with(document.frm){

	  if(conf_flag.value=="")
	  {
	    rdShowMessageDialog("请选择合户标志!");
	    conf_flag.focus();
	    return false;
	  }

	  if(conf_flag.value=="01")//合户
	  {

	    if(!checkElement(bind_phone_no)) return false;

		if(!(document.frm.ifValid.value=="1"))
		{
			rdShowMessageDialog("请验证绑定手机号码!");
			return false;
		}
	  }

	  if(new_rate_code_1.value==""){
	    rdShowMessageDialog("请选择新资费代码!");
		new_rate_code_1.focus();
		return false;
	  }
	  if(card_type_1.value==""){
	    rdShowMessageDialog("请选择数据卡类型!");
		card_type_1.focus();
		return false;
	  }
	}

	var now_rate_code = "<%=rate_code%>";
    var next_rate_code = "<%=next_rate_code%>";
	var new_rate_code = document.frm.new_rate_code.value;
    if(now_rate_code==next_rate_code && now_rate_code==new_rate_code){
	  rdShowMessageDialog("当前资费、下月资费、新资费三者不能完全相同，请确认!");
	  return false;
	}

	return true;
  }

  //点击下一步按钮时,为下一个页面组织参数
  function setParaForNext(){
    var iOpCode = "1201";//iOpCode
	//iAddStr格式 pay_type|year_fee|prepay_fee|year_month|card_type|card_name|bind_cust_name| 其中card_type、card_name、bind_cust_name用于随E行包年
	var iAddStr = document.frm.pay_type.value + "|" + document.frm.year_fee.value + "|" +  document.frm.year_fee.value + "|" + (Math.round(document.frm.year_month.value)+Math.round(1)) + "|" + document.frm.card_type.value + "|" + document.frm.card_name.value+"~"+document.frm.conf_flag.value + "~" + document.frm.bind_phone_no.value + "~" +  "" + "|" + document.frm.bind_cust_name.value + ""; //iAddStr
	var belong_code = "<%=cust_belong_code%>"; //belong_code
    var i2 =  "<%=cust_id%>"  ; //客户ID
   // var i16 = "<%=rate_code+"--"+rate_name%>";//现主套餐代码（老）
   var i16 = "<%=rate_code%>";
    var ip = document.frm.new_rate_code.value;//申请主套餐代码(新)
    var i1 = document.frm.phoneNo.value;//  手机号码
    var i4 = "<%=bp_name%>";//  客户名称
    var i5 = "<%=bp_add%>";//  客户地址
    var i6 = "<%=cardId_type%>";//   证件类型
    var i7 = "<%=cardId_no%>";//  证件号码
    var ipassword = ""; // 密码
    var group_type = "<%=group_type_code+"--"+group_type_name%>";//集团客户类别
    var ibig_cust = "<%=bigCust_flag+"--"+bigCust_name%>";// 大客户类别：
    var i18 =  "<%=next_rate_code + "--" + next_rate_name%>"; //下月主套餐：
    var i19 =  "<%=hand_fee%>";//   手续费
    var i20 =  "<%=hand_fee%>";  // 最高手续费
    var i8 =   "<%=sm_name%>";  //   业务品牌
    var do_note = document.frm.opNote.value;// 用户备注：
    var favorcode =  "<%=favorcode%>";  // 手续费优惠权限
    var maincash_no = "<%=rate_code%>";//现主套餐代码（老）
    var imain_stream = "<%=imain_stream%>"; //当前主资费开通流水
    var next_main_stream = "<%=next_main_stream%>";//预约主资费开通流水

	var str = "iOpCode="+iOpCode+
		                              "&iAddStr="+iAddStr +
				                      "&belong_code="+belong_code +
				                      "&i2="+i2 +
				                      "&i16="+i16 +
				                      "&ip="+ip +
				                      "&i1="+i1 +
				                      "&i4="+i4 +
				                      "&i5="+i5 +
				                      "&i6="+i6 +
				                      "&i7="+i7 +
				                      "&ipassword="+ipassword +
				                      "&group_type="+group_type +
				                      "&ibig_cust="+ibig_cust +
				                      "&i18="+i18 +
				                      "&i19="+i19 +
				                      "&i20="+i20 +
				                      "&i8="+i8 +
				                      "&do_note="+do_note +
				                      "&favorcode="+favorcode +
				                      "&maincash_no="+maincash_no +
				                      "&imain_stream="+imain_stream +
				                      "&next_main_stream="+next_main_stream;

	//alert(str);
	document.frm.iOpCode.value = iOpCode;
	document.frm.iAddStr.value = iAddStr;
	document.frm.belong_code.value = belong_code;
	document.frm.i2.value = i2;
	document.frm.i16.value = i16;
	document.frm.ip.value = ip;
	document.frm.i1.value = i1;
	document.frm.i4.value = i4;
	document.frm.i5.value = i5;
	document.frm.i6.value = i6;
	document.frm.i7.value = i7;
	document.frm.ipassword.value = ipassword;
	document.frm.group_type.value = group_type;
	document.frm.ibig_cust.value = ibig_cust;
	document.frm.i18.value = i18;
	document.frm.i19.value = i19;
	document.frm.i20.value = i20;
	document.frm.i8.value = i8;
	document.frm.do_note.value = do_note;
	document.frm.favorcode.value = favorcode;
    document.frm.maincash_no.value = maincash_no;
	document.frm.imain_stream.value = imain_stream;
	document.frm.next_main_stream.value = next_main_stream;
	frm.action = "fa270_3_year.jsp";
  }

  /***** 提交前增加品牌转换提示信息 added by hanfa 20070118 begin *****/
  function submitCfm(subButton)
  {
  		if(document.all.smCode.value == "zn" && document.all.m_smCode.value == "gn")
  		{
  			//薛英哲 20070716 R_HLJMob_cuisr_CRM_PD3_2007_226@关于积分清零条件调整的需求 zn->gn 积分不清零
  		}
  		else
  		{
	  		if((document.all.m_smCode.value !="") && (document.all.m_smCode.value != document.all.smCode.value))
	  			rdShowMessageDialog("该操作涉及到品牌变更，您的现有积分（或M值）将于资费生效的次月初清零，请您及时兑换");
  		}
		printCommit(subButton);
  }
  /***** 提交前增加品牌转换提示信息 added by hanfa 20070118 end *****/

  function printCommit(subButton){
	controlButt(subButton);//延时控制按钮的可用性
	//校验
	if(!check()) return false;
	setOpNote();//为备注赋值
	//为下一个页面组织传递参数
	setParaForNext();
    //提交表单
    frmCfm();
	return true;
  }
/**由新资费代码动态得到付款类型、包年周期等信息**/
 function setSomeInfo(){
   var tempStr = document.frm.new_rate_code_1.value;
   var newRateCode = oneTok(tempStr,"~",1);//新资费号码
   var payType =  oneTok(tempStr,"~",2);//付款类型
   var yearMonth =  oneTok(tempStr,"~",3);//包年周期

   document.frm.new_rate_code.value = newRateCode;
   document.frm.pay_type.value = payType;
   document.frm.year_month.value = yearMonth;

   if(document.frm.new_rate_code_1.value != "") //added by hanfa 20070118
   {
   		querySmcode();
   }
   getMidPrompt("10442",codeChg(newRateCode),"ipTd");
   return true;
}
/**由数据卡类型得到包年金额等信息**/
 function setYearFee(){
   var tempStr = document.frm.card_type_1.value;
   prepay_fee="<%=prepay_fee%>";
   var cardType = oneTok(tempStr,"~",1);//数据卡类型
   var shouldYearFee =  oneTok(tempStr,"~",2);//最小付款金额
   var cardName = oneTok(tempStr,"~",3);//数据卡名称
   document.frm.card_type.value = cardType;
   document.frm.year_fee.value = shouldYearFee;
   document.frm.card_name.value = cardName;

   return true;
}
/******为备注赋值********/
function setOpNote(){
	if(document.frm.opNote.value=="")
	{
	  document.frm.opNote.value = "随E;"+document.frm.phoneNo.value+";卡:"+document.frm.card_type.value+";当前:<%=rate_code%>;新:"+document.frm.new_rate_code.value;
	}
	return true;
}
/**由合户标志动态改变绑定手机号行的可见性**/
function controlBindPhoneNoTrView(){
  var conf_flag = document.frm.conf_flag.value;
  if(conf_flag=="00")
  {
    document.all.bindPhoneNoTr.style.display = "none";
  }else if(conf_flag=="01")
  {
    document.all.bindPhoneNoTr.style.display = "";
  }
  return true;
}

  //新增函数：查询资费代码相应的品牌代码 added by hanfa 20070117
  function querySmcode()
  {
	  var myPacket = new AJAXPacket("querySmcode_rpc.jsp","正在获得信息，请稍候......");
	  myPacket.data.add("modeCode",(document.all.new_rate_code.value).trim());
	  core.ajax.sendPacket(myPacket);
	  myPacket = null;
  }

//-->
</script>
</head>


<body>
<form name="frm" method="post">
<%@ include file="/npage/include/header.jsp" %>
<div class="title">
    <div id="title_zi">业务办理</div>
</div>
	<!-- added by hanfa 20070117-->
  	<input type="hidden" name="smCode" value="<%=sm_code%>">
  	<input type="hidden" name="m_smCode" value="">


      <table border="0" cellspacing="0">
		  <tr>
		    <td class="blue">手机号码</td>
            <td>
			  <input name="phoneNo" type="text" id="phoneNo" value="<%=phoneNo%>" class="InputGrey" readonly>
			</td>
		    <td class="blue">机主姓名</td>
            <td>
			  <input name="bp_name" type="text" id="bp_name" value="<%=bp_name%>" class="InputGrey" readonly>
			</td>
          </tr>
          <tr>
		    <td class="blue">业务类型</td>
            <td>
			  <input name="sm_name" type="text" class="InputGrey" id="sm_name" value="<%=sm_code + "--" + sm_name%>" readonly>
			</td>
            <td class="blue">大客户标志</td>
            <td>
			<input name="bigCust_flag" type="text" class="InputGrey" id="bigCust_flag" value="<%=bigCust_flag+"--"+bigCust_name%>" readonly>
			</td>
          </tr>
          <tr>
            <td class="blue">当前主套餐</td>
            <td>
			  <input name="rate_name" type="text" class="InputGrey" id="rate_name" size="30" value="<%=rate_code+"--"+rate_name%>" readonly>
			</td>
			<td class="blue">下月主套餐</td>
            <td>
			  <input name="next_rate_name" type="text" class="InputGrey" id="next_rate_name" size="30"  value="<%=next_rate_code+"--"+next_rate_name%>" readonly>
			</td>
          </tr>
		  <tr>
            <td class="blue">未出帐话费</td>
            <td>
			  <input name="lack_fee" type="text" class="InputGrey" id="lack_fee" value="<%=lack_fee%>" readonly >
            </td>
            <td class="blue">可用预存</td>
            <td>
			  <input name="prepay_fee" type="text" class="InputGrey" id="prepay_fee" value="<%=prepay_fee%>" readonly>
			</td>
          </tr>
		  <tr>
		    <td class="blue">数据卡类型</td>
            <td>
			  <select  name="card_type_1" onChange="setYearFee();">
			    <option value="">--请选择--</option>
                <wtc:qoption name="sPubSelect" outnum="2">
                    <wtc:sql>select card_type||'~'||year_fee||'~'||card_name, card_type||'--'||card_name from sDataCardYear</wtc:sql>
                </wtc:qoption>
              </select>
			  <font class="orange">*</font>
            </td>
            <td class="blue">包年金额</td>
            <td>
			   <input name="year_fee" type="text" id="year_fee"  readonly>
			</td>
          </tr>
		  <tr>
            <td class="blue">新套餐代码</td>
            <td id="ipTd">
			  <select  name="new_rate_code_1" id="new_rate_code_1" class="button" onChange="setSomeInfo();">
			    <option value="">--请选择--</option>
                <wtc:qoption name="sPubSelect" outnum="2">

                    <wtc:sql> select a.offer_id ||'~'|| c.offer_attr_value || '~'|| b.offer_attr_value, a.offer_id ||'--'||a.offer_name from product_offer a, product_offer_attr b, product_offer_attr c where a.offer_id = b.offer_id and b.offer_attr_seq = '5080' and a.offer_id = c.offer_id and c.offer_attr_seq = '5060' and a.offer_id in (select offer_z_id from product_offer_relation c, sregioncode d where c.group_id = d.group_id and d.region_code = '?' and c.op_code = '1201' and c.right_limit <='?' and c.offer_a_id = to_number('?')) </wtc:sql>
                    <wtc:param value="<%=orgCode.substring(0,2)%>"/>
                    <wtc:param value="<%=aftertrim%>"/>
                    <wtc:param value="<%=rate_code%>"/>
                </wtc:qoption>
              </select>
			  <font class="orange">*</font>
            </td>
            <td class="blue">包年周期</td>
            <td>
			  <input name="year_month" type="text" id="year_month"  readonly>
			</td>
          </tr>
		  <tr>
            <td class="blue">合户标志</td>
            <td colspan="3">
			  <select  name="conf_flag" onChange="controlBindPhoneNoTrView();">
			    <option value="">--请选择--</option>
				<option value="00">否</option>
				<option value="01">是</option>
              </select>
			  <font class="orange">*</font>
            </td>
          </tr>
		  <tr id="bindPhoneNoTr" style="display:none">
            <td class="blue">绑定手机号</td>
            <td colspan="3">
			  <input   type="text" size="12" name="bind_phone_no" id="bind_phone_no" v_minlength=1 v_maxlength=11 v_type="mobphone"  v_name="绑定手机号" maxlength="11" index="0" style="ime-mode:disabled" onKeyPress="return isKeyNumberdot(0)">
              <font class="orange">*</font>
			  <input name="phoneValid" type="button" class="b_text" id="phoneValid" style="cursor:hand" onClick="commitRpc()" value="验证"  >
            </td>
          </tr>
          <tr>
            <td class="blue">备注</td>
            <td colspan="3">
             <input name="opNote" type="text" id="opNote" size="60" maxlength="60" readOnly>
            </td>
          </tr>
		  <tr>
            <td colspan="4" id="footer">
                <div align="center">
                <!-- modified by hanfa 20070118
				<input name="next" id="next" type="button" class="button"   value="下一步" onClick="printCommit(this)">
				-->
				<!-- modified by hanfa 20070118 -->
				<input name="next" id="next" type="button" class="b_foot"   value="下一步" onClick="submitCfm(this)">
                <input name="reset" type="reset" class="b_foot" value="清除" >
                <input name="back" onClick="history.go(-1);" type="button" class="b_foot" value="返回">
				</div>
			</td>
          </tr>
      </table>

  <input type="hidden" name="iOpCode">
  <input type="hidden" name="iAddStr">
  <input type="hidden" name="belong_code">
  <input type="hidden" name="i2">
  <input type="hidden" name="i16">
  <input type="hidden" name="ip">
  <input type="hidden" name="i1">
  <input type="hidden" name="i4">
  <input type="hidden" name="i5">
  <input type="hidden" name="i6">
  <input type="hidden" name="i7">
  <input type="hidden" name="ipassword">
  <input type="hidden" name="group_type">
  <input type="hidden" name="ibig_cust">
  <input type="hidden" name="i18">
  <input type="hidden" name="i19">
  <input type="hidden" name="i20">
  <input type="hidden" name="i8">
  <input type="hidden" name="do_note">
  <input type="hidden" name="favorcode">
  <input type="hidden" name="maincash_no">
  <input type="hidden" name="imain_stream">
  <input type="hidden" name="next_main_stream">
  <input type="hidden" name="new_rate_code">
  <input type="hidden" name="pay_type">
  <input type="hidden" name="card_type">
  <input type="hidden" name="card_name">
  <input type="hidden" name="bind_cust_name">

  <input type="hidden" name="print_note" value="<%=print_note%>">
  <input type="hidden" name="ifValid" value="0">
<%@ include file="/npage/include/footer_new.jsp" %>
</form>
</body>
</html>

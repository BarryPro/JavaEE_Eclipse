<%
/********************
 version v2.0
开发商: si-tech
********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<%
  response.setDateHeader("Expires", 0);
%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page contentType="text/html;charset=GBK"%>
<%@ page import="com.sitech.boss.pub.util.Encrypt"%>
<%@ page import="java.util.*"%>
<%
  String opCode = (String)request.getParameter("opCode");
  String opName = (String)request.getParameter("opName");
  String loginNo = (String)session.getAttribute("workNo");
  String loginName = (String)session.getAttribute("workName");
  String powerCode= (String)session.getAttribute("powerCode");
  String orgCode = (String)session.getAttribute("orgCode");
  String ip_Addr = (String)session.getAttribute("ipAddr");
  String regionCode = orgCode.substring(0,2);
  
	/* liujian 安全加固修改 2012-4-6 16:18:13 begin */
//String loginNoPass = (String)session.getAttribute("password");
	String op_strong_pwd = (String) session.getAttribute("password");
  /* liujian 安全加固修改 2012-4-6 16:18:13 end */
  
  String aftertrim = (String)session.getAttribute("powerRight");
%>
<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="region"  routerValue="<%=regionCode%>" id="loginAccept"/>	
<%
  String retFlag="",retMsg="";//用于判断页面刚进入时的正确性
/****************由移动号码得到密码、机主姓名、 包年申请信息等信息 s1259Init***********************/
  String[] paraAray1 = new String[4];
  String phoneNo = request.getParameter("srv_no");
  String broadPhone = request.getParameter("broadPhone");
  String passwordFromSer="";

  paraAray1[0] = phoneNo;	/* 手机号码   */ 
  paraAray1[1] = loginNo; 	/* 操作工号   */
  paraAray1[2] = orgCode;	/* 归属代码   */
  paraAray1[3] = opCode;	/* 操作代码   */
  for(int i=0; i<paraAray1.length; i++)
  {		
	if( paraAray1[i] == null )
	{
	  paraAray1[i] = "";
	}
  }
  
  
  

  System.out.println("-----------------------------paraAray1[3]------------------------"+paraAray1[3]);
  System.out.println("-----------------------------paraAray1[0]------------------------"+paraAray1[0]);
  System.out.println("-----------------------------paraAray1[1]------------------------"+paraAray1[1]);
  System.out.println("-----------------------------paraAray1[2]------------------------"+paraAray1[2]);
  
  
  
%>
<wtc:service name="s1259Init" routerKey="phone" routerValue="<%=phoneNo%>" outnum="42" retmsg="errMsg" retcode="errCode">
			<wtc:param value=""/>
			<wtc:param value=""/>
			<wtc:param value="<%=paraAray1[3]%>"/>
			<wtc:param value="<%=paraAray1[1]%>"/>	
			<wtc:param value="<%=op_strong_pwd%>"/>
			<wtc:param value="<%=paraAray1[0]%>"/>
			<wtc:param value=""/>
			<wtc:param value="<%=paraAray1[2]%>"/>	
			 
</wtc:service>
	<wtc:array id="tempArr" start="0"  length="41" scope="end"/>
<%
		
				
System.out.println("-----------------------------tempArr[0][19]------------------------"+tempArr[0][19]);

  String  bp_name="",sm_code="",rate_code="",bigCust_flag="",sm_name="",rate_name="",bigCust_name="",next_rate_code="",next_rate_name="",lack_fee="",prepay_fee="",bp_add="",cardId_type="", cardId_no="", cust_id="",cust_belong_code="",group_type_code="",group_type_name="",imain_stream="",next_main_stream="",hand_fee="",favorcode="",card_no="",prepay_act_fee="",prepay_year_fee="",begin_time="",end_time="",leave_fee="",before_rate_code="",before_rate_name="",pay_type="",print_note="";
  if(tempArr == null)
  {
	if(!retFlag.equals("1"))
	{
	   retFlag = "1";
	   retMsg = "s1259Init查询号码基本信息为空!<br>" + "errCode: " + errCode + "<br>errMsg: " + errMsg;
    }    
  }else if(!(tempArr == null))
  {
	if (errCode.equals("0")||errCode.equals("000000")){
	    bp_name = tempArr[0][3];//机主姓名
	    bp_add = tempArr[0][4];//客户地址
	    passwordFromSer = tempArr[0][2];//密码
	    sm_code = tempArr[0][11];//业务类别
	    sm_name = tempArr[0][12];//业务类别名称
	    hand_fee = tempArr[0][13];//手续费
	    favorcode = tempArr[0][14];//优惠代码
	    rate_code = tempArr[0][5];//资费代码
	    rate_name = tempArr[0][6];//资费名称
	    next_rate_code = tempArr[0][7];//下月资费代码
	    next_rate_name = tempArr[0][8];//下月资费名称
	    bigCust_flag = tempArr[0][9];//大客户标志
	    bigCust_name = tempArr[0][10];//大客户名称
	    lack_fee = tempArr[0][15];//总欠费
	    prepay_fee = tempArr[0][16];//总预交
	    cardId_type = tempArr[0][17];//证件类型
	    cardId_no = tempArr[0][18];//证件号码
	    cust_id = tempArr[0][19];//客户id
	    cust_belong_code = tempArr[0][20];//客户归属id
	    group_type_code = tempArr[0][21];//集团客户类型
	    group_type_name = tempArr[0][22];//集团客户类型名称
	    imain_stream = tempArr[0][23];//当前资费开通流水
	    next_main_stream = tempArr[0][24];//预约资费开通流水
	    prepay_year_fee = tempArr[0][25];//包年预存款
	    prepay_act_fee = tempArr[0][26];//实交预存款
	    begin_time = tempArr[0][27];//开始时间
	    end_time = tempArr[0][28];//结束时间
	    before_rate_code = tempArr[0][29];//申请包年前资费代码
	    before_rate_name = tempArr[0][30];//申请包年前资费名称
	    pay_type = tempArr[0][32];//付费方式
	    leave_fee = tempArr[0][33];//剩余金额
	    print_note = tempArr[0][38];//工单广告词
	    
	}else{
		if(!retFlag.equals("1"))
	    {
	       retFlag = "1";
	       retMsg = "s1259Init查询号码基本信息失败!<br>" + "errCode: " + errCode + "<br>errMsg: " + errMsg;
        }
	}
  }
  
%>

<%

//********************得到营业员权限，核对密码，并设置优惠权限*****************************//   
   //优惠信息
  String[][] favInfo = (String[][])session.getAttribute("favInfo");   //数据格式为String[0][0]---String[n][0]
  boolean pwrf = true;//a272 密码免验证
  String handFee_Favourable = "readonly";        //a230  手续费
  int infoLen = favInfo.length;
  String tempStr = "";
  for(int i=0;i<infoLen;i++)
  {
    tempStr = (favInfo[i][0]).trim();
    if(tempStr.compareTo("a272") == 0)
    {
      pwrf = true;
    }
	if(tempStr.compareTo(favorcode) == 0)
    {
      handFee_Favourable = "";
    }
  }
  String passTrans=WtcUtil.repNull(request.getParameter("cus_pass")); 
  if(!pwrf)
  {
	   String passFromPage=Encrypt.encrypt(passTrans);
       if(0==Encrypt.checkpwd2(passwordFromSer.trim(),passFromPage))	{
		  if(!retFlag.equals("1"))
	      {
	          retFlag = "1";
	          retMsg = "密码错误!";
          }    
	   }       
  }

%>


<head>
<title>包年续签</title>
<script type="text/javascript" src="../../npage/s3000/js/S3000.js"></script>
<script language="JavaScript" src="<%=request.getContextPath()%>/npage/s1400/pub.js"></script>
 
<script language="JavaScript">
  <%if(retFlag.equals("1")){%>
     rdShowMessageDialog("<%=retMsg%>",0);
    //history.go(-1);
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

  onload=function()
  {		
  	/*getMidPrompt("10442","<%=rate_code%>","old_rate");
  	 getMidPrompt("10442","<%=next_rate_code%>","new_rate");*/		
  } 

  //---------1------RPC处理函数------------------
  function doProcess(packet){
	//使用RPC的时候,以下三个变量作为标准使用.
	var errorCode = packet.data.findValueByName("errorCode");
	var errorMsg =  packet.data.findValueByName("errorMsg");
	var verifyType = packet.data.findValueByName("verifyType");
	var flag_code =  packet.data.findValueByName("flag_code");
	var flag_code_name =  packet.data.findValueByName("flag_code_name");
	var rate_code =  packet.data.findValueByName("rate_code");
	self.status="";
	if(verifyType=="confirm"){
	  if( parseInt(errorCode) == 0 ){
		 //rdShowMessageDialog("信息返回，请确认!");
		 document.frm.flag_code.value=flag_code;
		 document.frm.flag_code_name.value=flag_code_name;
		 document.frm.rate_code.value=rate_code;
		 //alert("document.frm.rate_code.value==="+document.frm.rate_code.value);
		 
    var myPacket = new AJAXPacket("1255Flag.jsp","正在查询客户，请稍候......");
	myPacket.data.add("org_Code",(document.all.org_Code.value).trim());
	myPacket.data.add("new_rate_code",(document.all.new_rate_code.value).trim());
	core.ajax.sendPacket(myPacket);
    myPacket=null;
	
	setTimeout("getFlagCode1();",100);
		 
		 
	  }else{
		rdShowMessageDialog("<br>错误代码："+errorCode+"</br>错误信息："+errorMsg);
		return false;
	  }		
    }	
    
    else if(verifyType=="1295chgSim"){
			var back_flag_code  = packet.data.findValueByName("flag_code");
			document.all.back_flag_code.value = back_flag_code;	
    }
    			
  }
  
  function getFlagCode1(){
	if (document.frm.back_flag_code.value == 2 || document.all.ipTd.colSpan == "1") {
 	document.frm.flag_code.value="";
		 document.frm.flag_code_name.value="";
	}
}
  
  
  /**************/
  function commitRpc()
  {	
	var flag_code = document.frm.flag_code_1.value;
	var myPacket = new AJAXPacket("f1255RpcConfirm.jsp","正在获得小区信息，请稍候......");
	myPacket.data.add("verifyType","confirm");
	myPacket.data.add("flag_code",flag_code);
 	
	core.ajax.sendPacket(myPacket);
 	myPacket=null; 	  		
  }	
  
  //***
  function frmCfm(){
 	frm.submit();
	return true;
  }
  //***//校验
  function check(){
	with(document.frm){
	  if(new_rate_code.value==""){
	    rdShowMessageDialog("请选择新资费代码!");
		new_rate_code.focus();
		return false;
	  }
	  if ( new_rate_code.value!=qry_ofr.value )
	  {
	  	rdShowMessageDialog("新资费代码必须查询!");
	  	new_rate_code.focus();
	  		return false;
	  }
	}
	var now_rate_code = "<%=rate_code%>";
    var next_rate_code = "<%=next_rate_code%>";
	var new_rate_code = document.frm.new_rate_code.value;
    if(now_rate_code==next_rate_code && now_rate_code==new_rate_code){
	  //rdShowMessageDialog("当前资费、下月资费、新资费三者不能完全相同，请确认!");
	  //return false;
	}

	var prepay_fee = document.frm.prepay_fee.value;
	var year_fee = document.frm.year_fee.value;
  if((year_fee-prepay_fee)>0){
  	var showMsg = "<%=sm_code%>" == "kh"?"当前可用预存小于包月月费，请先通过zg62，进行铁通宽带交费!":"包年金额大于当前可用预存，请先通过e006，进行宽带交费!";
 	  rdShowMessageDialog(showMsg);
	  return false;
  }

	return true;
  }

  //点击下一步按钮时,为下一个页面组织参数
  function setParaForNext(){
    var iOpCode = "<%=opCode%>";//iOpCode    pay_type|year_fee|实缴预存款|“” 
	//iAddStr格式 pay_type|year_fee|prepay_fee|year_month|card_type|card_name 其中card_type、card_name用于随E行包年
	var iAddStr = document.frm.pay_type.value + "|" + document.frm.year_fee.value + "|" +  "0" + "|" + document.frm.year_month.value + "|" + "" + "|" + ""; //iAddStr
	var belong_code = "<%=cust_belong_code%>"; //belong_code 
    var i2 =  "<%=cust_id%>"  ; //客户ID
    var i16 = "<%=rate_code+"--"+rate_name%>";//现主套餐代码（老）
    var ip = document.frm.new_rate_code.value;//申请主套餐代码(新)
    var i1 = document.frm.phoneNo.value;//  手机号码
    var i4 = "<%=bp_name%>";//  客户名称
    var i5 = "<%=bp_add%>";//  客户地址
    var i6 = "<%=cardId_type%>";//   证件类型
    var i7 = "<%=cardId_no%>";//  证件号码
    var ipassword = ""; // 密码
    var group_type = "<%=group_type_code+"--"+group_type_name%>";//集团客户类别
    var ibig_cust = "<%=bigCust_flag+"--"+bigCust_name%>";// 大客户类别：
    
    var i18 = "";
    <%if((next_rate_code == null) || "".equals(next_rate_code)){%>
    	i18 =  ""; //下月主套餐：
    <%}else{%>
    	i18 =  "<%=next_rate_code + "--" + next_rate_name%>"; //下月主套餐：
    <%}%>
    var i19 =  "<%=hand_fee%>";//   手续费
    var i20 =  "<%=hand_fee%>";  // 最高手续费
    var i8 =   "<%=sm_name%>";  //   业务品牌
    var do_note = document.frm.opNote.value;// 用户备注：
    var favorcode =  "<%=favorcode%>";  // 手续费优惠权限
    var maincash_no = "<%=rate_code%>";//现主套餐代码（老）
    var imain_stream = "<%=imain_stream%>"; //当前主资费开通流水
    var next_main_stream = "<%=next_main_stream%>";//预约主资费开通流水	
    
	var flag_code = document.frm.flag_code.value; 
    var rate_code = document.frm.rate_code.value;
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
	document.frm.iph.value = ip;
	
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
	frm.action = "f1270_3_year.jsp";
  }

  function printCommit(subButton){
  	var i16 = "<%=rate_code+"--"+rate_name%>";//现主套餐代码（老）
	controlButt(subButton);//延时控制按钮的可用性
	document.frm.iAddRateStr.value = document.frm.rate_code_tmp.value + "$" + document.frm.flag_code.value;
	//alert("document.frm.iAddRateStr.value==="+document.frm.iAddRateStr.value);
	//校验
	if(!check()) return false;
	
	if(document.all.flag_code.value==""&&document.all.xiaoquCode.value=="Y"){
			rdShowMessageDialog("请选择小区代码");
			document.all.flag_code.focus();
			return false;
		}
	setOpNote();//为备注赋值
	//为下一个页面组织传递参数
	setParaForNext();
    //提交表单
    frmCfm();	
	return true;
  }
function codeChg(s)
{
  var str = s.replace(/%/g, "%25").replace(/\+/g, "%2B").replace(/\s/g, "+"); // % + \s
  str = str.replace(/-/g, "%2D").replace(/\*/g, "%2A").replace(/\//g, "%2F"); // - * /
  str = str.replace(/\&/g, "%26").replace(/!/g, "%21").replace(/\=/g, "%3D"); // & ! =
  str = str.replace(/\?/g, "%3F").replace(/:/g, "%3A").replace(/\|/g, "%7C"); // ? : |
  str = str.replace(/\,/g, "%2C").replace(/\./g, "%2E").replace(/#/g, "%23"); // , . #
  return str;
}
/**查询主套餐**/
function getNewRateCode()
{ 

  	//调用公共js得到主套餐代码
    var pageTitle = "资费代码查询";
 

     var fieldName = "资费代码|资费名称|最小金额|包年周期|付费方式|资费描述|有无小区|";
	  var sqlStr = "";
	  
	  //alert("sqlStr|"+sqlStr);
	
    var selType = "S";    //'S'单选；'M'多选
    var retQuence = "7|0|1|2|3|4|5|6|";
    
    var retToField = "new_rate_code|new_rate_name|year_fee|year_month|pay_type|flag_code_1|xiaoquCode|";

    if(!(PubSimpSele(pageTitle,fieldName,sqlStr,selType,retQuence,retToField))) return false;
    //动态改变小区代码的可见性,并调用rpc为小区代码赋值
    //alert("document.frm.xiaoquCode.value|"+document.frm.xiaoquCode.value);
    if(document.frm.xiaoquCode.value=='N')
	{
		document.all.ipTd.colSpan = "3";
    document.all.flagCodeTextTd.style.display = "none";
    document.all.flagCodeTd.style.display = "none";
	  document.frm.flag_code.value="";
		document.frm.flag_code_name.value="";
		document.frm.rate_code.value="";
	}else
	{
		commitRpc();//查询小区代码
		document.all.ipTd.colSpan = "1";
        document.all.flagCodeTextTd.style.display = "";
        document.all.flagCodeTd.style.display = "";
	}
	var rate_code=document.all.new_rate_code.value;
	document.all.qry_ofr.value=document.all.new_rate_code.value;
	getMidPrompt("10442",rate_code,"ipTd");
	
//}
	
}

function changeRateCode()
{
    document.frm.flag_code.value="";
	document.frm.flag_code_name.value="";
	document.frm.rate_code.value="";
}

function getFlagCode()
{ 
  	//调用公共js
    var pageTitle = "资费查询";
    var fieldName = "小区代码|小区名称";//弹出窗口显示的列、列名 
    var sqlStr = "select flag_code,flag_code_name from sofferflagcode where  group_id in (select e.parent_group_id from dChnGroupinfo e,dloginmsg f where e.group_id=f.group_id and f.login_no='<%=loginNo%>') and  offer_id ="+document.frm.new_rate_code.value;
    //var sqlStr ="select a.flag_code, a.flag_code_name,a.rate_code from sRateFlagCode a, sBillModeDetail b where a.region_code=b.region_code and a.rate_code=b.detail_code and b.detail_type='0' and a.region_code='" + codeChg(document.frm.org_Code.value.substring(0,2)) + "' and b.mode_code='" + codeChg(document.frm.new_rate_code.value) + "' order by a.flag_code" ;
    var selType = "S";    //'S'单选；'M'多选
    var retQuence = "0|1";//返回字段
    var retToField = "flag_code|flag_code_name";//返回赋值的域
    
    if(PubSimpSel(pageTitle,fieldName,sqlStr,selType,retQuence,retToField));
    document.all.rate_code_tmp.value = document.all.rate_code.value;
	//alert("document.frm.rate_code.value==="+document.frm.rate_code.value);
	//alert("document.frm.rate_code_tmp.value==="+document.frm.rate_code_tmp.value);
	var flag_code=document.all.flag_code.value;
	getMidPrompt("10442",flag_code,"flagCodeTd");	
}



function PubSimpSele(pageTitle,fieldName,sqlStr,selType,retQuence,retToField)
{
    var path = "fPubSimpSer_e974.jsp?offerId=<%=rate_code%>&newOfferId="+document.all.new_rate_code.value;
    path = path + "&sqlStr=" + sqlStr + "&retQuence=" + retQuence;
    path = path + "&fieldName=" + fieldName + "&pageTitle=" + pageTitle;
    path = path + "&selType=" + selType + "&opCode=<%=opCode%>";  
    retInfo = window.showModalDialog(path,"","dialogWidth:60");
    if(retInfo ==undefined)      
    {   return false;   }
    var chPos_field = retToField.indexOf("|");
    var chPos_retStr;
    var valueStr;
    var obj;
    while(chPos_field > -1)
    {
    	
        obj = retToField.substring(0,chPos_field);
        chPos_retInfo = retInfo.indexOf("|");
        valueStr = retInfo.substring(0,chPos_retInfo);
        document.all(obj).value = valueStr;
        retToField = retToField.substring(chPos_field + 1);
        retInfo = retInfo.substring(chPos_retInfo + 1);
        chPos_field = retToField.indexOf("|");
        
    }
	return true;
}
/******为备注赋值********/
function setOpNote(){
	if(document.frm.opNote.value=="")
	{
	  document.frm.opNote.value = "续签；"+document.frm.phoneNo.value+"；当前:<%=rate_code%>；新套餐:"+document.frm.new_rate_code.value; 
	}
	return true;
}
//-->


</script>
</head>


<body>
<form name="frm" method="post">
<%@ include file="/npage/include/header.jsp" %>
<input type='hidden' id='qry_ofr' name='qry_ofr' value=''>
	<div class="title">
		<div id="title_zi">客户信息</div>
	</div>
      <table cellspacing="0">
		  <tr>
		    <td class="blue">宽带账号</td>
        <td>
        	<input name="broadPhone" id="broadPhone" type="text" 
        	 value="<%=broadPhone%>" readonly="readOnly" class="InputGrey"/>
			  	<input name="phoneNo" type="hidden" id="phoneNo" value="<%=phoneNo%>" /> 
				</td> 
		    <td class="blue">客户姓名</td>
            <td>
			  <input name="bp_name" type="text" class="InputGrey" id="bp_name" value="<%=bp_name%>" readonly>			  
			</td>           
          </tr>
          <tr> 
		    <td class="blue">业务品牌</td>
            <td>
			  <input name="sm_name" type="text" class="InputGrey" id="sm_name" value="<%=sm_code + "--" + sm_name%>" readonly>
			</td>
			<td class="blue">当前主套餐</td>
			<td>
				<input name="rate_name" type="text" class="InputGrey" 
					id="rate_name" size="30" value="<%=rate_code+"--"+rate_name%>" 
					readonly />
			</td>            
			</tr>

			<tr> 
				<td class="blue">可用预存</td>
				<td>
				<input name="prepay_fee" type="text" class="InputGrey" id="prepay_fee" value="<%=prepay_fee%>" readonly>
				</td>
				<td class="blue">当前包年金额</td>
				<td>
					<input name="prepay_year_fee" type="text" class="InputGrey" id="prepay_year_fee"  value="<%=prepay_year_fee%>"  readonly>
				</td>
			</tr>
			<tr>
				<td class="blue">当前包年开始时间</td>
				<td>
					<input name="begin_time" type="text" class="InputGrey" id="begin_time" value="<%=begin_time%>"  readonly>
				</td>
				<td class="blue">当前包年结束时间</td>
				<td>
					<input name="end_time" type="text" class="InputGrey" id="end_time" value="<%=end_time%>" readonly>
				</td> 
			</tr>	

			<tr> 
				<td class="blue">新套餐代码</td>
				<td colspan="3" id="ipTd">
					<input type="text" class="button" name="new_rate_code" id="new_rate_code" onChange="changeRateCode()" size="8" maxlength="8" v_must=1 v_name="新套餐代码" >
					<input type="text" class="button" name="new_rate_name" id="new_rate_name" size="18"  v_name="新套餐名称">
					<font class="orange">*</font>
					&nbsp;&nbsp;
					<input name="newRateCodeQuery" type="button" class="b_text"  style="cursor:hand" onClick="getNewRateCode();" value=查询>
				</td>
				<td id = "flagCodeTextTd" style="display:none" class="blue">小区代码</TD>
				<td id = "flagCodeTd" style="display:none">
					<input type="text" class="button" name="flag_code" size="8" maxlength="10" readonly>
					<input type="text" class="button" name="flag_code_name" size="18" readonly > 
					
					<font class="orange">*</font>
					<input type="hidden" name="rate_code">
					<input type="hidden" name="iAddRateStr">
					<input name="newFlagCodeQuery" type="button" class="b_text"  style="cursor:hand" onClick="getFlagCode()" value=选择>
				</td> 
			</tr>
		  <tr>
		    <td class="blue" style="display:none">包年周期</td>
        <td style="display:none">
			  	<input name="year_month" type="text" class="InputGrey" id="year_month"  readonly>
				</td>
        <td class="blue">包月月费</td>
        <td colspan="3">
			  	<input name="year_fee" type="text" class="InputGrey" id="year_fee"  readonly>
				</td>
      </tr>	
			
			<tr> 
				<td class="blue">备注：</td>
				<td colspan="3">
					<input name="opNote" type="text" class="button" id="opNote" size="60" maxlength="60" onFocus="setOpNote();" readonly> 
				</td>
			</tr>
			<tr> 
				<td colspan="4" id="footer">
					&nbsp; 
					<input name="next" id="next" type="button" class="b_foot"   value="下一步" onClick="printCommit(this)">
					&nbsp; 
					<input name="reset" type="reset" class="b_foot" value="清除" >
					&nbsp; 
					<input name="back" onClick="history.go(-1);" type="button" class="b_foot" value="返回">
					&nbsp; 
				</td>
			</tr>
      </table>
  <input type="hidden" name="iOpCode">
  <input type="hidden" name="iAddStr">
  <input type="hidden" name="belong_code">
  <input type="hidden" name="i2">
  <input type="hidden" name="i16">
  <input type="hidden" name="iph">
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
  <input type="hidden" name="pay_type">
  <input type="hidden" name="flag_code_1">
  <input type="hidden" name="org_Code" value="<%=orgCode%>">
  <input type="hidden" name="back_flag_code" value="">
  <input type="hidden" name="print_note" value="<%=print_note%>">
  <input type="hidden" name="rate_code_tmp" value="">
  <input type="hidden" name="xiaoquCode" value="">
  <input type="hidden" name="geftFlag" value="0">
	<input type="hidden" name ="sm_code" value="<%=sm_code%>"/>
	<input type="hidden" name ="loginAccept" value="<%=loginAccept%>"/>
  
  <%@ include file="/npage/include/footer.jsp" %> 
</form>
</body>
</html>


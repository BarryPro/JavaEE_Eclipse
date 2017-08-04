<%
/********************
 version v2.0
开发商: si-tech
********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html;charset=gb2312"%>
<%@ page import="com.sitech.boss.pub.util.Encrypt"%>
<%@ page import="java.util.*"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%
  String opCode = "1258";
  String opName = "包年取消";	

  String loginNo = (String)session.getAttribute("workNo");
  String loginName = (String)session.getAttribute("workName");
  String powerCode= (String)session.getAttribute("powerCode");
  String orgCode = (String)session.getAttribute("orgCode");
  String ip_Addr = request.getRemoteAddr();  
  String regionCode = orgCode.substring(0,2);
  String loginNoPass = (String)session.getAttribute("password");     
%>
<%
  String retFlag="",retMsg="";//用于判断页面刚进入时的正确性
/****************由移动号码得到密码、机主姓名、 包年申请信息等信息 s1257Init***********************/
  String[] paraAray1 = new String[4];
  String phoneNo = request.getParameter("srv_no");
  String flag = request.getParameter("flag");//1--冲正  2--取消
  String passwordFromSer="";


  paraAray1[0] = phoneNo;		/* 手机号码   */ 
  paraAray1[1] = loginNo; 	/* 操作工号   */
  paraAray1[2] = orgCode;	/* 归属代码   */
  paraAray1[3] = "1258";	/* 操作代码   */
  for(int i=0; i<paraAray1.length; i++)
  {		
	if( paraAray1[i] == null )
	{
	  paraAray1[i] = "";
	}
  }
%>
<wtc:service name="s1257Init" routerKey="phone" routerValue="<%=phoneNo%>" outnum="38" retmsg="errMsg" retcode="errCode">
		<wtc:param value="<%=paraAray1[0]%>"/>
		<wtc:param value="<%=paraAray1[1]%>"/>
		<wtc:param value="<%=paraAray1[2]%>"/>
		<wtc:param value="<%=paraAray1[3]%>"/>			
</wtc:service>
<wtc:array id="tempArr" scope="end" />
<%
  String  bp_name="",sm_code="",family_code="",rate_code="",op_type="2",bigCust_flag="",sm_name="",rate_name="",bigCust_name="",next_rate_code="",next_rate_name="",lack_fee="",prepay_fee="",bp_add="",cardId_type="", cardId_no="", cust_id="",cust_belong_code="",group_type_code="",group_type_name="",imain_stream="",next_main_stream="",hand_fee="",favorcode="",card_no="",prepay_act_fee="",prepay_year_fee="",begin_time="",end_time="",leave_fee="",before_rate_code="",before_rate_name="",pay_type="",old_accept="",contract_no="",print_note="";
  String  breach_fee="",year_fee="";
  if(tempArr == null)
  {
	if(!retFlag.equals("1"))
	{
	   retFlag = "1";
	   retMsg = "s1257Init查询号码基本信息为空!<br>errCode: " + errCode + "<br>errMsg: " + errMsg;
    }    
  }else if(!(tempArr == null))
  {
	if (errCode.equals("0")||errCode.equals("000000") ){
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
	    lack_fee = tempArr[0][15];//未出帐话费
	    prepay_fee = tempArr[0][16];//总预交
	    cardId_type = tempArr[0][17];//证件类型
	    cardId_no = tempArr[0][18];//证件号码
	    cust_id = tempArr[0][19];//客户id
	    cust_belong_code = tempArr[0][20];//客户归属id
	    group_type_code = tempArr[0][21];//集团客户类型
	    group_type_name = tempArr[0][22];//集团客户类型名称
	    imain_stream = tempArr[0][23];//当前资费开通流水
	    next_main_stream = tempArr[0][24];//预约资费开通流水
	    prepay_year_fee = tempArr[0][25];//包年金额
	    prepay_act_fee = tempArr[0][26];//实缴金额  
	    begin_time = tempArr[0][27];//开始时间
	    end_time = tempArr[0][28];//结束时间
	/*  tempArr = (String[][])retList.get(29);
	  if(!(tempArr==null)){
	    before_rate_code = tempArr[0][0];//申请包年前资费代码
	  }

	  tempArr = (String[][])retList.get(30);
	  if(!(tempArr==null)){
	    before_rate_name = tempArr[0][0];//申请包年前资费名称
	  }
	  */
	    leave_fee = tempArr[0][32];//剩余金额
	    pay_type = tempArr[0][33];//付费方式
	    old_accept = tempArr[0][34];//包年流水
	    contract_no = tempArr[0][35];//包年专用账户
	    print_note = tempArr[0][36];//工单广告词
	  leave_fee=String.valueOf((double) Double.parseDouble(leave_fee));
	  year_fee=String.valueOf((double) Double.parseDouble(leave_fee) - Double.parseDouble(lack_fee));
	  breach_fee=String.valueOf((double) Double.parseDouble(year_fee)*3/10);
	  if ((Double.parseDouble(year_fee))<0)
	  {
	  	year_fee="0.00";
	  	breach_fee="0.00";
	  }
	}else{
		if(!retFlag.equals("1"))
	    {
	      retFlag = "1";
	      retMsg = "s1257Init查询号码基本信息失败!<br>errCode:"+errCode+"<br>errMsg:" + errMsg;
        } 	
	}
  }
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
  //******************得到下拉框数据***************************//
  //资费代码
  String sqlNewRateCode = "";  
  sqlNewRateCode = "select a.mode_code||'~'||b.mode_type,a.mode_code||'--'||b.mode_name from sBillModeNormal a, sBillModeCode b where a.region_code=b.region_code and a.mode_code=b.mode_code and  a.region_code='"+orgCode.substring(0,2)+"' and a.sm_code='"+sm_code+"'";
  System.out.println("sqlNewRateCode============="+sqlNewRateCode);
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<title>包年取消</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<script type="text/javascript" src="../../npage/s3000/js/S3000.js"></script>
<script language="JavaScript" src="<%=request.getContextPath()%>/npage/s1400/pub.js"></script>
 
<script language="JavaScript">

  <%if(retFlag.equals("1")){%>
   
    rdShowMessageDialog("<%=retMsg%>",0);
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
   onload=function()
  {	
  	/*getMidPrompt("10442","<%=rate_code%>","old_rate");
  	 getMidPrompt("10442","<%=next_rate_code%>","new_rate");*/	
  } 
  
  //***
  function frmCfm(){
 	frm.submit();
	return true;
  }
  //***//校验
  function check(){
	with(document.frm)
	{
	  if(new_rate_code.value=="")
	  {
	    rdShowMessageDialog("请选择新资费代码!");
		 document.frm.new_rate_code.focus();
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

    if((document.frm.mode_type.value=='Yn20')||(document.frm.mode_type.value=="Yn40"))
	{
	  if(document.frm.flag_code.value=="")
	  {
	    rdShowMessageDialog("请输入关联代码!");
	    document.frm.flag_code.focus();
	    return false;
	  }
	}

	return true;
  }

  //点击下一步按钮时,为下一个页面组织参数
  function setParaForNext(){
    var iOpCode = "1258";//iOpCode    pay_type|year_fee|实缴预存款|“” 
	//iAddStr格式 pay_type|year_fee|prepay_fee|iOldAccept|iContractNo|iOpType  
	var iAddStr = "<%=pay_type%>" +"|" + document.frm.prepay_year_fee.value + "|" + "0" + "|" + "<%=old_accept%>" + "|" + "<%=contract_no%>" + "|" + "C";//iAddStr
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
    var i18 =  "<%=next_rate_code + "--" + next_rate_name%>"; //下月主套餐：
    var i19 =  "<%=hand_fee%>";//   手续费
    var i20 =  "<%=hand_fee%>";  // 最高手续费
    var i8 =   "<%=sm_name%>";  //   业务品牌
    var do_note = document.frm.opNote.value;// 用户备注：
    var favorcode =  "<%=favorcode%>";  // 手续费优惠权限
    var maincash_no = "<%=rate_code%>";//现主套餐代码（老）
    var imain_stream = "<%=imain_stream%>"; //当前主资费开通流水
    var next_main_stream = "<%=next_main_stream%>";//预约主资费开通流水	old_accept,contract_no
	var old_accept = "<%=old_accept%>";//包年流水
	var contract_no = "<%=contract_no%>";//包年专用账户

	/*var str = "iOpCode="+iOpCode+
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
	
	alert(str);*/
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
	frm.action = "f1270_3_year.jsp";
  }

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
/******为备注赋值********/
function setOpNote(){
	if(document.frm.opNote.value=="")
	{
	  document.frm.opNote.value = "取消;"+document.frm.phoneNo.value+";当前:<%=rate_code%>;取消:"+document.frm.new_rate_code.value; 
	}
	return true;
}
/**由新套餐代码动态改变小区代码行的可见性**/
 function setSomeInfo(){
   var tempStr = document.frm.new_rate_code_1.value;
   var new_rate_code,mode_type;
   new_rate_code = oneTokSelf(tempStr,"~",1);//新套餐代码
   mode_type = oneTokSelf(tempStr,"~",2);//套餐类别
   document.frm.new_rate_code.value = new_rate_code;
   document.frm.mode_type.value = mode_type;

	//alert("mode_type = " + mode_type);
	//alert("new_rate_code_1.value = " + document.frm.new_rate_code_1.value);
   if(mode_type=="Yn20")
   {
		document.all.flagCodeTr.style.display = "";
		document.all.flagCodeTextTd.innerText = "集团代码";
		document.frm.flag_code.value="";
        document.frm.flag_code_name.value="";
		document.frm.rate_code.value="";
   }else if(mode_type=="Yn40")
   {
		document.all.flagCodeTr.style.display = "";
		document.all.flagCodeTextTd.innerText = "小区代码";
		document.frm.flag_code.value="";
        document.frm.flag_code_name.value="";
		document.frm.rate_code.value="";
   }else
   {
	    document.all.flagCodeTr.style.display = "none";
		document.frm.flag_code.value="";
        document.frm.flag_code_name.value="";
		document.frm.rate_code.value="";
   }
   getMidPrompt("10442",new_rate_code,"newCode");
   return true; 
}
/**查询关联代码**/
function getFlagCode()
{ 
  	//调用公共js得到银行代码
    var pageTitle = "关联代码查询";
    var fieldName = "关联代码|关联代码名称|二次批价代码|";//弹出窗口显示的列、列名
    var sqlStr ="select a.flag_code, a.flag_code_name, a.rate_code from sRateFlagCode a, sBillModeDetail b where a.region_code=b.region_code and a.rate_code=b.detail_code and b.detail_type='0' and a.region_code='<%=orgCode.substring(0,2)%>' and b.mode_code='" + codeChg(document.frm.new_rate_code.value) + "' order by a.flag_code" ;
	//alert(sqlStr); 
    var selType = "S";    //'S'单选；'M'多选
    var retQuence = "3|0|1|2|";//返回字段
    var retToField = "flag_code|flag_code_name|rate_code|";//返回赋值的域
    
    if(PubSimpSel(pageTitle,fieldName,sqlStr,selType,retQuence,retToField));
	document.frm.iAddRateStr.value = document.frm.rate_code.value + "$" + document.frm.flag_code.value;
}
function PubSimpSel(pageTitle,fieldName,sqlStr,selType,retQuence,retToField)
{
    var path = "<%=request.getContextPath()%>/page/public/fPubSimpSel.jsp";
    path = path + "?sqlStr=" + sqlStr + "&retQuence=" + retQuence;
    path = path + "&fieldName=" + fieldName + "&pageTitle=" + pageTitle;
    path = path + "&selType=" + selType;  
    retInfo = window.showModalDialog(path);
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
//-->
</script>
</head>
<body>
<form name="frm" method="post">
<%@ include file="/npage/include/header.jsp" %>
	<div class="title">
		<div id="title_zi">客户信息</div>
	</div>
      <table cellspacing="0">
		  <tr>
		    <td class="blue">手机号码</td>
            <td>
			  <input name="phoneNo" type="text" class="InputGrey" id="phoneNo" value="<%=phoneNo%>" readonly> 
			</td> 
		    <td class="blue">用户姓名</td>
            <td>
			  <input name="bp_name" type="text" class="InputGrey" id="bp_name" value="<%=bp_name%>" readonly>			  
			</td>           
          </tr>
          <tr> 
		    <td class="blue">证件类型</td>
            <td>
			  <input name="cardId_type" type="text" class="InputGrey" id="cardId_type" value="<%=cardId_type%>" readonly>
			</td>
            <td class="blue">证件号码</td>
            <td>
			  <input name="cardId_no" type="text" class="InputGrey" id="cardId_no" value="<%=cardId_no%>" readonly>
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
            <td id="old_rate">
			  <input name="rate_name" type="text" class="InputGrey" id="rate_name" size="30" value="<%=rate_code+"--"+rate_name%>" readonly>
			</td>
			<td class="blue">下月主套餐</td>
            <td id="new_rate">
			  <input name="next_rate_name" type="text" class="InputGrey" id="next_rate_name" size="30"  value="<%=next_rate_code+"--"+next_rate_name%>" readonly>
			</td>             
          </tr>
		  <tr> 
            <td class="blue">总预存</td>
            <td>
			  <input name="prepay_fee" type="text" class="InputGrey" id="prepay_fee" value="<%=prepay_fee%>" readonly>
			</td>
            <td class="blue">包年金额</td>
            <td>
			   <input name="prepay_year_fee" type="text" class="InputGrey" id="prepay_year_fee"  value="<%=prepay_year_fee%>"  readonly>
			</td>
          </tr>
		  <tr>
            <td class="blue">开始时间</td>
            <td>
			   <input name="begin_time" type="text" class="InputGrey" id="begin_time" value="<%=begin_time%>"  readonly>
			</td>
			<td class="blue">结束时间</td>
            <td>
			  <input name="end_time" type="text" class="InputGrey" id="end_time" value="<%=end_time%>" readonly>
			</td> 
          </tr>		  
		  <tr>
		    <td class="blue">包年期初预存</td>
            <td>
			  <input name="leave_fee" type="text" class="InputGrey" id="leave_fee" value="<%=leave_fee%>" readonly>
			</td> 
            <td class="blue">包年未出帐话费</td>
            <td>
			  <input name="lack_fee" type="text" class="InputGrey" id="lack_fee" value="<%=lack_fee%>" readonly >
            </td>
          </tr>	
		  <tr> 
            <td class="blue">包年当前可用余额</td>
            <td>
			  <input name="year_fee" type="text" class="InputGrey" id="year_fee" value="<%=year_fee%>" readonly >
            </td>
            <td></td>
            <td></td>
            <!--td>违约金:</td>
            <td>
			  <input name="breach_fee" type="text" class="button" id="breach_fee" value="<%=breach_fee%>" readonly>
			</td-->
          </tr>
		  <tr>
            <td class="blue">新套餐代码</td>
			<td id="newCode">
				<select  name="new_rate_code_1" id="new_rate_code_1" class="button"  onChange="setSomeInfo();">
					<option value="">--请选择--</option>
					<wtc:qoption name="sPubSelect" outnum="2">
						<wtc:sql><%=sqlNewRateCode%>
						</wtc:sql>
					</wtc:qoption>
				</select>
				<font class="orange">*</font>
			</td>
            <td></td>
            <td></td>
          </tr>
		  <TR style="display:none" id="flagCodeTr"> 
               <TD class="blue" id="flagCodeTextTd" >小区代码</TD>
			   <TD colspan="3" >
                  <input type="text" class="button" name="flag_code" size="8" maxlength="10" v_must=1  >
			      <input type="text" class="button" name="flag_code_name" size="20" v_must=0 v_name="关联代码名称" v_type="string" >&nbsp;&nbsp;
                  <input type="hidden" name="rate_code">
			      <input type="hidden" name="iAddRateStr">
			      <input name=flagCodeQuery type=button class="button"  style="cursor:hand" onClick="getFlagCode()" value=查询>
               </TD>  
		   </TR>
          <tr> 
            <td class="blue">备注</td>
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
  <input type="hidden" name="mode_type">

  <input type="hidden" name="print_note" value="<%=print_note%>">
   	<%@ include file="/npage/include/footer.jsp" %> 
</form>
</body>
</html>


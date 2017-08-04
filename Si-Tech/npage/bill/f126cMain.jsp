<%
/********************
 version v2.0
开发商: si-tech
********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//Dtd XHTML 1.0 transitional//EN" "http://www.w3.org/tr/xhtml1/Dtd/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%
	request.setCharacterEncoding("GBK");
%>

<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page contentType="text/html;charset=gb2312"%>
<%@ page import="com.sitech.boss.pub.util.Encrypt"%>
<%@ include file="../../page/bill/getMaxAccept.jsp" %>

<%
	String opCode = "126c";
	String opName = "预存话费赠机冲正";	
  String loginNo = (String)session.getAttribute("workNo");
  String loginName = (String)session.getAttribute("workName");  
  String powerCode = (String)session.getAttribute("powerCode");
  String orgCode = (String)session.getAttribute("orgCode");
  String ip_Addr = (String)session.getAttribute("ipAddr");
  String regionCode = (String)session.getAttribute("regCode");
  
  String iLoginNoAccept = request.getParameter("backaccept");  
  
%>
<%
  String retFlag="",retMsg="";//用于判断页面刚进入时的正确性
/****************由移动号码得到密码、机主姓名、 等信息 s126cInitEx***********************/
  //SPubCallSvrImpl impl = new SPubCallSvrImpl();
  //ArrayList retList = new ArrayList();
  String[] paraAray1 = new String[4];
  String phoneNo = request.getParameter("srv_no");
  String passwordFromSer="";
  
  paraAray1[0] = phoneNo;		/* 手机号码   */ 
  paraAray1[1] = loginNo; 	    /* 操作工号   */
  paraAray1[2] = orgCode;	    /* 归属代码   */
  paraAray1[3] = "126c";	    /* 操作代码   */
  
  for(int i=0; i<paraAray1.length; i++)
  {		
	if( paraAray1[i] == null )
	{
	  paraAray1[i] = "";
	}
  }
  
%>
<wtc:service name="s126cInitEx" routerKey="phone" routerValue="<%=phoneNo%>" retcode="errCode" retmsg="errMsg" outnum="38" >
	<wtc:param value="<%=paraAray1[0]%>"/>
	<wtc:param value="<%=paraAray1[1]%>"/>
	<wtc:param value="<%=paraAray1[2]%>"/>
	<wtc:param value="<%=paraAray1[3]%>"/>
</wtc:service>
<wtc:array id="retList" scope="end"/>
<%  
  String  bp_name="",sm_code="",family_code="",rate_code="",bigCust_flag="",sm_name="",rate_name="",bigCust_name="",next_rate_code="",next_rate_name="",lack_fee="",prepay_fee="",bp_add="",cardId_type="", cardId_no="", cust_id="",cust_belong_code="",group_type_code="",group_type_name="",imain_stream="",next_main_stream="",hand_fee="",favorcode="", op_type="",  machine_type="",  order_code="",  should_fee="",  consume_term="",  base_fee="",  free_fee="",  mon_base_fee="",  machine_fee="",new_rate_code="",new_rate_name="",op_name=""; 
  String baseFeeTrView="", machineFeeTrView="",  nextButtonFlag="",  commitButtonFlag="",print_note="";
  //String[][] tempArr= new String[][]{};
  //int errCode = impl.getErrCode();
  //String errMsg = impl.getErrMsg();
  if(retList == null)
  {
	if(!retFlag.equals("1"))
	{
	   retFlag = "1";
	   retMsg = "s126cInitEx查询号码基本信息为空!<br>errCode: " + errCode + "<br>errMsg+" + errMsg;
    }    
  }else if(!(retList == null))
  {
	if (errCode.equals("0")||errCode.equals("000000")){
	  //tempArr = (String[][])retList.get(3);
	  if(!(retList[0][3]==null)){
	    bp_name = retList[0][3];//机主姓名
	  }

	  //tempArr = (String[][])retList.get(4);
	  if(!(retList[0][4]==null)){
	    bp_add = retList[0][4];//客户地址
	  }

	  //tempArr = (String[][])retList.get(2);
	  if(!(retList[0][2]==null)){
	    passwordFromSer = retList[0][2];//密码
	  }

	  //tempArr = (String[][])retList.get(11);
	  if(!(retList[0][11]==null)){
	    sm_code = retList[0][11];//业务类别
	  }

	  //tempArr = (String[][])retList.get(12);
	  if(!(retList[0][12]==null)){
	    sm_name = retList[0][12];//业务类别名称
	  }

	  //tempArr = (String[][])retList.get(13);
	  if(!(retList[0][13]==null)){
	    hand_fee = retList[0][13];//手续费
	  }

	  //tempArr = (String[][])retList.get(14);
	  if(!(retList[0][14]==null)){
	    favorcode = retList[0][14];//优惠代码
	  }

	  //tempArr = (String[][])retList.get(5);
	  if(!(retList[0][5]==null)){
	    rate_code = retList[0][5];//资费代码
	  }

	  //tempArr = (String[][])retList.get(6);
	  if(!(retList[0][6]==null)){
	    rate_name = retList[0][6];//资费名称
	  }

	  //tempArr = (String[][])retList.get(7);
	  if(!(retList[0][7]==null)){
	    next_rate_code = retList[0][7];//下月资费代码
	  }

	  //tempArr = (String[][])retList.get(8);
	  if(!(retList[0][8]==null)){
	    next_rate_name = retList[0][8];//下月资费名称
	  }

	  //tempArr = (String[][])retList.get(9);
	  if(!(retList[0][9]==null)){
	    bigCust_flag = retList[0][9];//大客户标志
	  }

	  //tempArr = (String[][])retList.get(10);
	  if(!(retList[0][10]==null)){
	    bigCust_name = retList[0][10];//大客户名称
	  }

	  //tempArr = (String[][])retList.get(15);
	  if(!(retList[0][15]==null)){
	    lack_fee = retList[0][15];//总欠费
	  }

	  //tempArr = (String[][])retList.get(16);
	  if(!(retList[0][16]==null)){
	    prepay_fee = retList[0][16];//总预交
	  }

	  //tempArr = (String[][])retList.get(17);
	  if(!(retList[0][17]==null)){
	    cardId_type = retList[0][17];//证件类型
	  }

	  //tempArr = (String[][])retList.get(18);
	  if(!(retList[0][18]==null)){
	    cardId_no = retList[0][18];//证件号码
	  }

	  //tempArr = (String[][])retList.get(19);
	  if(!(retList[0][19]==null)){
	    cust_id = retList[0][19];//客户id
	  }

	  //tempArr = (String[][])retList.get(20);
	  if(!(retList[0][20]==null)){
	    cust_belong_code = retList[0][20];//客户归属id
	  }

	  //tempArr = (String[][])retList.get(21);
	  if(!(retList[0][21]==null)){
	    group_type_code = retList[0][21];//集团客户类型
	  }

	  //tempArr = (String[][])retList.get(22);
	  if(!(retList[0][22]==null)){
	    group_type_name = retList[0][22];//集团客户类型名称
	  }

	  //tempArr = (String[][])retList.get(23);
	  if(!(retList[0][23]==null)){
	    imain_stream = retList[0][23];//当前资费开通流水
	  }

	  //tempArr = (String[][])retList.get(24);
	  if(!(retList[0][24]==null)){
	    next_main_stream = retList[0][24];//预约资费开通流水
	  }

	  //tempArr = (String[][])retList.get(25);
	  if(!(retList[0][25]==null)){
	    should_fee = retList[0][25];//预存款金额
	  }

	  //tempArr = (String[][])retList.get(26);
	  if(!(retList[0][26]==null)){
	    base_fee = retList[0][26];//底线金额
	  }

	  //tempArr = (String[][])retList.get(27);
	  if(!(retList[0][27]==null)){
	    free_fee = retList[0][27];//活动预存
	  }

	  //tempArr = (String[][])retList.get(28);
	  if(!(retList[0][28]==null)){
	    mon_base_fee = retList[0][28];//月底线消费
	  }

	  //tempArr = (String[][])retList.get(29);
	  if(!(retList[0][29]==null)){
	    machine_fee = retList[0][29];//机器金额
	  }

	  //tempArr = (String[][])retList.get(30);
	  if(!(retList[0][30]==null)){
	    op_type = retList[0][30];//操作类型
	  }

	  //tempArr = (String[][])retList.get(31);
	  if(!(retList[0][31]==null)){
	    machine_type = retList[0][31];//机器类型
	  }

	  //tempArr = (String[][])retList.get(32);
	  if(!(retList[0][32]==null)){
	    order_code = retList[0][32];//方案名称
	  }

	  //tempArr = (String[][])retList.get(33);
	  if(!(retList[0][33]==null)){
	    new_rate_code = retList[0][33];//新套餐代码
	  }

	  //tempArr = (String[][])retList.get(34);
	  if(!(retList[0][34]==null)){
	    new_rate_name = retList[0][34];//新套餐名称
	  }

	  //tempArr = (String[][])retList.get(35);
	  if(!(retList[0][35]==null)){
	    consume_term = retList[0][35];//消费期限
	  }

	  //tempArr = (String[][])retList.get(36);
	  if(!(retList[0][36]==null)){
	    print_note = retList[0][36];//工单广告
	  }

	  if(op_type.equals("0"))
	  {
		  op_name = "按月扣费";
		  baseFeeTrView="";
		  machineFeeTrView="display:none";
		  nextButtonFlag="";
		  commitButtonFlag="disabled";
	  }else if(op_type.equals("9"))
	  {
		  op_name = "非按月扣费";
		  baseFeeTrView="display:none";
		  machineFeeTrView="";
		  nextButtonFlag="disabled";
		  commitButtonFlag="";
	  }

	}else{
		if(!retFlag.equals("1"))
		{
		   retFlag = "1";
	       retMsg = "s126cInitEx查询号码基本信息失败!<br>errCode: " + errCode + "<br>errMsg: " + errMsg;
		}
	}
  }
//********************得到营业员权限，核对密码，并设置优惠权限*****************************//   
   //优惠信息
  //String[][] favInfo = (String[][])arrSession.get(3);   //数据格式为String[0][0]---String[n][0]
  String[][] favInfo = (String[][])session.getAttribute("favInfo");
  boolean pwrf = false;//a272 密码免验证
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
  /****得到打印流水****/
  String printAccept="";
  printAccept = getMaxAccept(); 
%>

<head>
<title>预存话费赠机冲正</title>


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

   onload=function()
  {		
  } 
  
  //***
  function frmCfm(){
 	frm.submit();
	return true;
  }
  //***//校验
  function check(){
 	with(document.frm){	
	}
	var now_rate_code = "<%=rate_code%>";
    var next_rate_code = "<%=next_rate_code%>";
	var new_rate_code = document.frm.new_rate_code.value;
	if(document.frm.op_type.value=="0" && now_rate_code==next_rate_code && now_rate_code==new_rate_code){
	  rdShowMessageDialog("当前资费、下月资费、新资费三者不能完全相同，请确认!");
	  return false;
	}

	return true;
  }

  //点击下一步按钮时,为下一个页面组织参数
  function setParaForNext(){ 
    var iOpCode = "126c";//iOpCode
	//iAddStr格式 flag,machine_type,order_code,prepay_fee,base_fee,free_fee,consume_term,mon_base_fee,machine_fee
	var iAddStr = document.frm.op_type.value + "|" + document.frm.machine_type.value + "|" +  document.frm.order_code.value + "|" + document.frm.should_fee.value + "|" + document.frm.base_fee.value + "|" + document.frm.free_fee.value + "|" + document.frm.consume_term.value + "|" + document.frm.mon_base_fee.value + "|" + document.frm.machine_fee.value + "|" ; //iAddStr
	var belong_code = "<%=cust_belong_code%>"; //belong_code 
    var i2 =  "<%=cust_id%>"  ; //客户ID
    var i16 = "<%=rate_code+"--"+rate_name%>";//现主套餐代码（老）
    var ip = document.frm.new_rate_code.value;//申请主套餐代码(新)
    var i1 = document.frm.phoneNo.value;//  手机号码
    //var i4 = "<%=bp_name%>";//  客户名称 因为bp_name 中包含'\'等特殊字符时会报javaScript错
    var i5 = "<%=bp_add%>";//  客户地址
    var i6 = "<%=cardId_type%>";//   证件类型
    var i7 = "<%=cardId_no%>";//  证件号码
    var ipassword = ""; // 密码
    var group_type = "<%=group_type_code+"--"+group_type_name%>";//集团客户类别
    var ibig_cust = "<%=bigCust_flag+"--"+bigCust_name%>";// 大客户类别：
    var i18 =  "<%=next_rate_code + "--" + next_rate_name%>"; //下月主套餐：
    var i19 =  "<%=hand_fee%>";//   手续费
    var i20 =  "<%=hand_fee%>";  // 最高手续费
    var i8 =   "<%=sm_code+"--"+sm_name%>";  //   业务品牌
    var do_note = document.frm.opNote.value;// 用户备注：
    var favorcode =  "<%=favorcode%>";  // 手续费优惠权限
    var maincash_no = "<%=rate_code%>";//现主套餐代码（老）
    var imain_stream = "<%=imain_stream%>"; //当前主资费开通流水
    var next_main_stream = "<%=next_main_stream%>";//预约主资费开通流水	
	var beforeOpCode = "126b";//冲正时传送对应申请业务的opCode

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
	//document.frm.i4.value = i4;
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
    document.frm.beforeOpCode.value = beforeOpCode;
	frm.action = "faa270_3.jsp";
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
  function printCommitTwo(subButton){
	controlButt(subButton);//延时控制按钮的可用性
	//校验
	if(!check()) return false;
	setOpNote();//为备注赋值
	//
	frm.action = "fa26cConfirm_1.jsp"
    //打印工单并提交表单
    var ret = showPrtDlg("Detail","确实要进行电子免填单打印吗？","Yes"); 
    if(typeof(ret)!="undefined")
    {
      if((ret=="confirm"))
      {
        if(rdShowConfirmDialog('确认电子免填单吗？如确认,将提交本次业务!')==1)
        {
	      frmCfm();
        }
	  }
	  if(ret=="continueSub")
	  {
        if(rdShowConfirmDialog('确认要提交信息吗？')==1)
        {
	      frmCfm();
        }
	  }
    }
    else
    {
       if(rdShowConfirmDialog('确认要提交信息吗？')==1)
       {
	     frmCfm();
       }
    }	
	return true;
  }

  function showPrtDlg(printType,DlgMessage,submitCfm)
  {  //显示打印对话框 
			var h=210;
			var w=400;
			var t=screen.availHeight/2-h/2;
			var l=screen.availWidth/2-w/2;
			var pType="print";
			var billType="1";  
			var printStr = printInfo(printType);
			
			var mode_code=null;
			var fav_code=null;
			var area_code=null;
			
			var sysAccept = "<%=printAccept%>" ;
			
			var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no"; 
			var path = "<%=request.getContextPath()%>/npage/innet/hljBillPrint_jc.jsp?DlgMsg=" + DlgMessage;
			var path = path + "&mode_code="+mode_code+"&fav_code="+fav_code+"&area_code="+area_code+"&opCode=<%=opCode%>&sysAccept="+sysAccept+"&phoneNo=<%=phoneNo%>&submitCfm=" + submitCfm+"&pType="+pType+"&billType="+billType+ "&printInfo=" + printStr;
			var ret=window.showModalDialog(path,printStr,prop);
			return ret;
			
  }

  function printInfo(printType)
  {
	  var cust_info="";
		var opr_info="";
		var note_info1="";
		var note_info2="";
		var note_info3="";
		var note_info4="";
		
		var retInfo = "";
		
		cust_info+="手机号码："+document.frm.phoneNo.value+"|";
		cust_info+="客户姓名："+document.frm.bp_name.value+"|";
		cust_info+="客户地址："+"<%=bp_add%>"+"|";
		cust_info+="证件号码："+"<%=cardId_no%>"+"|";
		
		opr_info+="业务类型："+"预存话费赠机非按月扣费冲正"+"|";
		opr_info+="业务流水："+"<%=printAccept%>"+"|";
		opr_info+="手机型号："+document.frm.machine_type.value+"|";
		opr_info+="退预存话费："+document.frm.should_fee.value+"元  购机款："+document.frm.machine_fee.value+"元|";
		
		note_info1+="备注："+"<%=print_note%>"+"|";
		
		retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
		retInfo=retInfo.replace(new RegExp("#","gm"),"%23");
    return retInfo;	
	  	  
  }
   /******为备注赋值********/
function setOpNote(){
	if(document.frm.opNote.value=="")
	{
	  document.frm.opNote.value = "冲正;"+document.frm.phoneNo.value+";"+"<%=op_type%>"+";"+document.frm.machine_type.value; 
	}
	return true;
}
//-->
</script>

</head>

<body>
<form name="frm" method="post" onKeyUp="chgFocus(frm)">
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
			<td class="blue">机主姓名</td>
			<td>
			<input name="bp_name" type="text" class="InputGrey" id="bp_name" value="<%=bp_name%>" readonly>			  
			</td>           
		</tr>
		<tr> 
			<td class="blue">业务品牌</td>
			<td>
			<input name="sm_name" type="text" class="InputGrey" id="sm_name" value="<%=sm_code + "--" + sm_name%>" readonly>
			</td>
			<td class="blue">大客户标志</td>
			<td>
			<input name="bigCust_flag" type="text" class="InputGrey" id="bigCust_flag" value="<%=bigCust_flag+"--"+bigCust_name%>" readonly>
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
			<td class="blue">当前主套餐</td>
			<td>
			<input name="rate_name" type="text" class="InputGrey" id="rate_name" size="40" value="<%=rate_code+"--"+rate_name%>" readonly>
			</td>
			<td class="blue">下月主套餐</td>
			<td>
			<input name="next_rate_name" type="text" class="InputGrey" id="next_rate_name" size="40"  value="<%=next_rate_code+"--"+next_rate_name%>" readonly>
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
			<td class="blue">扣费类别</td>
			<td>
			<input name="op_type_1" type="text" class="InputGrey" id="op_type" value="<%=op_type+"--"+op_name%>" readonly>
			</td>
			<td>&nbsp;</td>
			<td>&nbsp;</td>
		</tr>
		<tr>
			<td class="blue">手机类型</td> 
			<td>
			<input name="machine_type" type="text" class="InputGrey" id="machine_type" value="<%=machine_type%>" readonly>
			</td>
			<td class="blue">方案代码</td>
			<td>
			<input name="order_code" type="text" class="InputGrey" id="order_code" size="40" value="<%=order_code%>" readonly>
			</td> 
		</tr>
		<tr>
			<td class="blue">预存款</td>
			<td>
			<input name="should_fee" type="text" class="InputGrey" id="should_fee" value="<%=should_fee%>" readonly>
			</td>
			<td class="blue">消费期限</td>
			<td>
			<input name="consume_term" type="text" class="InputGrey" id="consume_term" value="<%=consume_term%>" readonly>
			</td>  
		</tr>
		<tr style="<%=baseFeeTrView%>"> 
			<td class="blue">底线预存</td>
			<td>
			<input name="base_fee" type="text" class="InputGrey" id="base_fee" value="<%=base_fee%>"  readonly>
			</td>
			<td class="blue">活动预存</td>
			<td>
			<input name="free_fee" type="text" class="InputGrey" id="free_fee" value="<%=free_fee%>"  readonly>
			</td>             
		</tr>
		<tr style="<%=baseFeeTrView%>"> 
			<td class="blue">月底线</td>
			<td>
			<input name="mon_base_fee" type="text" class="InputGrey" id="mon_base_fee" value="<%=mon_base_fee%>"   readonly>
			</td>
			<td class="blue">新套餐代码</td>
			<td>
			<input name="new_rate_code_1" type="text" class="InputGrey" id="new_rate_code_1" size="30" value="<%=new_rate_code + "--" + new_rate_name%>"  readonly>
			</td>            
		</tr>
		<tr style="<%=machineFeeTrView%>">  
			<td class="blue">购机款</td>
			<td>
			<input name="machine_fee" type="text" class="InputGrey" id="machine_fee" value="<%=machine_fee%>"  readonly>
			</td>
			<td>&nbsp;</td>
			<td>&nbsp;</td>            
		</tr>
		<tr> 
			<td class="blue">备注</td>
			<td colspan="3">
			<input name="opNote" type="text" id="opNote" size="60" maxlength="60" onfocus="setOpNote()"> 
			</td>
		</tr>
		<tr> 
			<td colspan="4"> <div align="center"> 
			&nbsp; 
			<input name="next" id="next" type="button" class="b_foot"   value="下一步" onClick="printCommit(this)" <%=nextButtonFlag%>>
			&nbsp; 
			<input name="commit" id="commit" type="button" class="b_foot"   value="确认&打印" onClick="printCommitTwo(this)" <%=commitButtonFlag%>>
			&nbsp; 
			<input name="reset" type="reset" class="b_foot" value="清除" >
			&nbsp; 
			<input name="back" onClick="history.go(-1);" type="button" class="b_foot" value="返回">
			&nbsp; 
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
  <input type="hidden" name="i4" value="<%=bp_name%>">
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
  <input type="hidden" name="beforeOpCode">
  <input type="hidden" name="new_rate_code" value="<%=new_rate_code%>">
  <input type="hidden" name="pay_type">

  <input type="hidden" name="op_type" value="<%=op_type%>">
  <input type="hidden" name="print_note" value="<%=print_note%>">
  <input type="hidden" name="printAccept" value="<%=printAccept%>">
  
  <input type="hidden" name="backaccept" value="<%=iLoginNoAccept%>">
  <%@ include file="/npage/include/footer.jsp" %>
</form>
</body>
</html>
<%
/********************
 version v2.0
 开发商: si-tech
 update zhaohaitao at 2008.11.26
********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html  xmlns="http://www.w3.org/1999/xhtml">
<%@ include file="/npage/include/public_title_name.jsp" %>

<%
  response.setHeader("Pragma","No-cache");
  response.setHeader("Cache-Control","no-cache");
  response.setDateHeader("Expires", 0);
%>

<%@ page contentType="text/html;charset=GBK"%>
<%@ page import="java.util.*"%>
<%@ page import="java.text.*" %>
<%@ include file="../../npage/bill/getMaxAccept.jsp" %>


<%
  String OpCode ="1144";
  String opCode = "1144";
  String opName = "积分换机冲正";

  String loginNo = (String)session.getAttribute("workNo");
  String loginName = (String)session.getAttribute("workName");
  String regionCode = (String)session.getAttribute("regCode");
  
  String orgCode = (String)session.getAttribute("orgCode");
  String groupId = (String)session.getAttribute("groupId");
  String loginNoPass = ((String)session.getAttribute("password")); 
%>
<%
  String retFlag="",retMsg="";
  String[] paraAray1 = new String[8];
  String phoneNo = request.getParameter("srv_no");
  String opcode = request.getParameter("opcode");
  String backaccept= request.getParameter("backaccept");
  String passwordFromSer="";

  paraAray1[0] = phoneNo;		/* 手机号码   */
  paraAray1[1] = opcode; 	    /* 操作代码   */
  paraAray1[2] = loginNo;	    /* 操作工号   */
  paraAray1[3] = backaccept;  
  paraAray1[4] = "01";          /* 渠道       */
  paraAray1[5] = loginNoPass; /* 工号密码   */
  paraAray1[6] = "";          /* 手机密码   */
  paraAray1[7] = "";          /* 新流水   */

  /*****王梅 添加 20060605*****/

  String sqlStr = "";
  String awardName="";
  sqlStr = "select award_name from wawardpay where phone_no ='"+phoneNo+"'"+
		    " and login_accept="+backaccept  ;

  //retArray = callView.sPubSelect("1",sqlStr);
 %>
    <wtc:pubselect name="sPubSelect" routerKey="phone" routerValue="<%=phoneNo%>" retcode="retCodeNo" retmsg="retMsgNo" outnum="1">
    <wtc:sql><%=sqlStr%>
    </wtc:sql>
	</wtc:pubselect>
	<wtc:array id="result" scope="end"/>
 <%
  //result = (String[][])retArray.get(0);
  if(result != null && result.length > 0)
  	awardName = result[0][0];
    System.out.println("awardName="+awardName);

  if(!awardName.equals("")){
 %>
  //rdShowMessageDialog("此用户为已中奖用户，中奖奖品为："<%=awardName%>", 请用户完好无损返回奖品，再继续办理冲正业务！");
   if(rdShowConfirmDialog("此用户为已中奖用户，中奖奖品为：<%=awardName%> 请用户完好无损返回奖品，再继续办理冲正业务！")!=1)
	{
		location='f1143_login.jsp';
	}

	</script>

<%}
  //sunzx add at 20070904
  sqlStr = "select res_info from wawarddata where flag = 'Y' and phone_no = '"+phoneNo+"'"+
		    " and login_accept="+backaccept  ;

  //retArray = callView.sPubSelect("1",sqlStr);
%>
   <wtc:pubselect name="sPubSelect" routerKey="phone" routerValue="<%=phoneNo%>" retcode="retCodeNo2" retmsg="retMsgNo2" outnum="2">
     <wtc:sql><%=sqlStr%>
     </wtc:sql>
     </wtc:pubselect>
   <wtc:array id="result2" scope="end"/>
<%
  if(result2 != null && result2.length > 0)
  {
	  awardName = result2[0][0];
	  System.out.println("awardName2="+awardName);
  	  if(!awardName.equals("")){
%>
		  <script language="JavaScript" >
		  	rdShowMessageDialog("此用户已在促销品统一付奖中进行<%=awardName%>领奖，请进行促销品统一付奖冲正，并确保奖品完好");
			location='f1143_login.jsp';
		  </script>
<%	  }
  }
/*****王梅 添加 20060605*******/

  for(int i=0; i<paraAray1.length; i++)
  {
	if( paraAray1[i] == null )
	{
	  paraAray1[i] = "";
	}
  }
 /* 输出参数： 返回码，返回信息，客户姓名，客户地址，证件类型，证件号码，业务品牌，
 			归属地，当前状态，VIP级别 ，当前积分，用户预存，
 			营销方案名，应付金额，卡金额，卡张数串，赠送话费，销费积分数
 */
  //retList = impl.callFXService("s1142Qry", paraAray1, "24","phone",phoneNo);
%>  
  <wtc:service name="s1142Qry" routerKey="phone" routerValue="<%=phoneNo%>" retcode="retCode1" retmsg="retMsg1" outnum="29" >
	<wtc:param value="<%=paraAray1[7]%>"/>
	<wtc:param value="<%=paraAray1[4]%>"/>
	<wtc:param value="<%=paraAray1[1]%>"/>
	<wtc:param value="<%=paraAray1[2]%>"/>
	<wtc:param value="<%=paraAray1[5]%>"/>
	<wtc:param value="<%=paraAray1[0]%>"/>
	<wtc:param value="<%=paraAray1[6]%>"/>
	<wtc:param value="<%=paraAray1[3]%>"/>
	</wtc:service>
  <wtc:array id="tempArr" scope="end"/>
<%
  String  bp_name="",bp_add="",cardId_type="",cardId_no="",sm_code="",region_name="",run_name="",vip="",posint="",prepay_fee="";
  String sale_name="",sum_money="",scard_money="",card_num="",pay_money="",used_point="",card_money="",type_name="";
  String vspec_name="",vmode_code="",vused_date="",vspec_fee="";
	String payType="",Response_time="",TerminalId="",Rrn="",Request_time="";
  String errCode = retCode1;
  String errMsg = retMsg1;
  if(tempArr == null)
  {
	if(!retFlag.equals("1"))
	{
	   System.out.println("retFlag="+retFlag);
	   retFlag = "1";
	   retMsg = "s12fbInit查询号码基本信息为空!<br>errCode: " + errCode + "<br>errMsg+" + errMsg;
    }
  }else if(!(tempArr == null))
  {
  	System.out.println("errCode="+errCode);
  	System.out.println("errMsg="+errMsg);
  	if(!errCode.equals("000000")){%>
    	<script language="JavaScript">
    	<!--
  	  	rdShowMessageDialog("错误代码：<%=errCode%>错误信息：<%=errMsg%>",0);
  	  	history.go(-1);
  		//-->
        </script>
  <%}
	if (errCode.equals("000000")){

	    bp_name = tempArr[0][2];                //机主姓名
	    System.out.println(bp_name);
	    bp_add = tempArr[0][3];                 //客户地址
	    cardId_type = tempArr[0][4];            //证件类型
	    cardId_no = tempArr[0][5];              //证件号码
	    sm_code = tempArr[0][6];                //业务品牌
	    region_name = tempArr[0][7];            //归属地
	    run_name = tempArr[0][8];               //当前状态
	    vip = tempArr[0][9];                    //ＶＩＰ级别
	    posint = tempArr[0][10];                //当前积分
	    prepay_fee = tempArr[0][11];            //可用预存
	    sale_name = tempArr[0][12];             //营销方案名
	    sum_money = tempArr[0][13];             //应付金额
	    scard_money = tempArr[0][14];           //卡金额串
	    card_num = tempArr[0][15];              //卡张数串
	    pay_money = tempArr[0][16];             //赠送话费
	    used_point = tempArr[0][17];            //消费积分数
	    card_money = tempArr[0][18];            //卡金额
	    type_name = tempArr[0][19];             //卡金额
	    vspec_name = tempArr[0][20];            //数据业务名称
	    vused_date = tempArr[0][21];            //到期时间
	    vspec_fee = tempArr[0][22].trim();      //金额
	    if(vspec_fee.equals("")){vspec_fee="0";}
	    vmode_code = tempArr[0][23];            //金额
	    pay_money=""+(Float.parseFloat(pay_money)-Float.parseFloat(vspec_fee));
	    
			///////<!-- ningtn add for pos start @ 20100414 -->
			if(tempArr[0][24] != null && tempArr[0][24].trim().length() > 0){
				payType = tempArr[0][24].trim();
			}else{
				payType = "0";
			}
			Response_time = tempArr[0][25].trim();
			TerminalId = tempArr[0][26].trim();
			Rrn = tempArr[0][27].trim();
			Request_time = tempArr[0][28].trim();
			
			System.out.println("payType : " + payType);
			System.out.println("Response_time : " + Response_time);
			System.out.println("TerminalId : " + TerminalId);
			System.out.println("Rrn : " + Rrn);
			System.out.println("Request_time : " + Request_time);
			///////<!-- ningtn add for pos end @ 20100414 -->
	}
  }

%>

<%
//******************得到下拉框数据***************************//
String printAccept="";
printAccept = getMaxAccept();
System.out.println(printAccept);
/*
  comImpl co=new comImpl();
  //手机品牌
  String sqlAgentCode = " select  unique a.brand_code,trim(b.brand_name) from sPhoneSalCfg a,sphbrandcode b where a.region_code='" + regionCode + "' and a.sale_type='0' and a.brand_code=b.brand_code and valid_flag='Y'";
  System.out.println("sqlAgentCode====="+sqlAgentCode);
  ArrayList agentCodeArr = co.spubqry32("2",sqlAgentCode);
  String[][] agentCodeStr = (String[][])agentCodeArr.get(0);
  //手机类型
  String sqlPhoneType = "select unique a.type_code,trim(b.type_name), b.brand_code from sPhoneSalCfg a,stypecode b where a.region_code='" + regionCode + "' and  a.type_code=b.type_code and a.brand_code=b.brand_code and valid_flag='Y'";
  System.out.println("sqlPhoneType====="+sqlPhoneType);
  ArrayList phoneTypeArr = co.spubqry32("3",sqlPhoneType);
  String[][] phoneTypeStr = (String[][])phoneTypeArr.get(0);
  //营销代码
  String sqlsaleType = "select unique a.sale_code,trim(a.sale_name), a.brand_code,a.type_code from sPhoneSalCfg a where a.region_code='" + regionCode + "' and a.sale_type='0' and valid_flag='Y'";
  System.out.println("sqlsaleType====="+sqlsaleType);
  ArrayList saleTypeArr = co.spubqry32("4",sqlsaleType);
  String[][] saleTypeStr = (String[][])saleTypeArr.get(0);
 */
%>
<head>
<title>积分换机冲正</title>
<META content="no-cache" http-equiv="Pragma">
<META content="no-cache" http-equiv="Cache-Control">
<META content="0" 	     http-equiv="Expires" >
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<script language=javascript>

  onload=function()
  {

  }
 function doProcess(packet){

 	var retType = packet.data.findValueByName("retType");
    var retCode = packet.data.findValueByName("retCode");
    var retMessage = packet.data.findValueByName("retMessage");

    if(retCode!=0){
    	rdShowConfirmDialog(retMessage);
    	retrun ;
    }
    if(retType == "getcard"){

    	document.all.price.value = packet.data.findValueByName("phonemoney");
    	document.all.card_info.value = packet.data.findValueByName("cardvalue");
    	document.all.pay_money.value = packet.data.findValueByName("prepay_gift");
    	document.all.sum_money.value = packet.data.findValueByName("phonemoney");
    	document.all.card_money.value = packet.data.findValueByName("cardshould");
    	document.all.card_dz.value = packet.data.findValueByName("cardmoney");
    	document.all.cardy.value = packet.data.findValueByName("cardy");
    }
 }
 </script>
<script language="JavaScript">

<!--
  //定义应用全局的变量
  var SUCC_CODE	= "0";   		//自己应用程序定义
  var ERROR_CODE  = "1";			//自己应用程序定义
  var YE_SUCC_CODE = "0000";		//根据营业系统定义而修改

  var oprType_Add = "a";
  var oprType_Upd = "u";
  var oprType_Del = "d";
  var oprType_Qry = "q";

  var arrPhoneType = new Array();//手机型号代码
  var arrPhoneName = new Array();//手机型号名称
  var arrAgentCode = new Array();//代理商代码
  var selectStatus = 0;

  var arrsalecode =new Array();
  var arrsaleName=new Array();
  var arrsalebarnd=new Array();
  var arrsaletype=new Array();

  //***
  function frmCfm(){

		/* ningtn add for pos start @ 20100408 */
		if(document.all.payType.value=="BX")
	  	{
	    		/*set 输入参数*/
					var transerial    = "000000000000";  	                     //交易唯一号 ，将会取消
					var trantype      = "01";                                  //交易类型
					var bMoney        = "<%=sum_money%>";					 							 //缴费金额
					if(bMoney.indexOf(".") == -1) bMoney=bMoney+"00";
					var tranoper      = "<%=loginNo%>";                        //交易操作员
					var orgid         = "<%=groupId%>";                        //营业员归属机构
					var trannum       = "<%=phoneNo%>";                    		 //电话号码
					getSysDate();       /*取boss系统时间*/
					var respstamp     = document.all.Request_time.value;       //提交时间
					var transerialold = "<%=Rrn%>";			                               //原交易唯一号,在缴费时传入空
					var org_code      = "<%=orgCode%>";                        //营业员归属						
					CCBCommon(transerial,trantype,bMoney,tranoper,orgid,trannum,respstamp,transerialold,org_code);
					if(ccbTran=="succ") posSubmitForm();
	  	}
			else if(document.all.payType.value=="BY")
			{
					var transType     = "04";																	/*交易类型 */         
					var bMoney        = "<%=sum_money%>";							          /*交易金额 */         
					if(bMoney.indexOf(".") == -1) bMoney=bMoney+"00";
					var response_time = "<%=Response_time%>";                 /*原交易日期 */       
					var rrn           = "<%=Rrn%>";                           /*原交易系统检索号 */ 
					var instNum       = "";                                   /*分期付款期数 */     
					var terminalId    = "<%=TerminalId%>";                    /*原交易终端号 */
					getSysDate();       //取boss系统时间                                            
					var request_time  = document.all.Request_time.value;      /*交易提交日期 */     
					var workno        = "<%=loginNo%>";                       /*交易操作员 */       
					var orgCode       = "<%=orgCode%>";                       /*营业员归属 */       
					var groupId       = "<%=groupId%>";                       /*营业员归属机构 */   
					var phoneNo       = "<%=phoneNo%>";                   		/*交易缴费号 */       
					var toBeUpdate    = "";						                        /*预留字段 */         
					var posFlag = ICBCCommon(transType,bMoney,response_time,rrn,instNum,terminalId,request_time,workno,orgCode,groupId,phoneNo,toBeUpdate);									
					if(icbcTran=="succ") posSubmitForm();
			}else{
					posSubmitForm();
			}
			/* ningtn add for pos end @ 20100408 */
  }
 //***
  /* ningtn add for pos start @ 20100414 */
	function posSubmitForm(){
		frm.submit();
		return true;
	}
	function getSysDate()
	{
		var myPacket = new AJAXPacket("../s1300/s1300_getSysDate.jsp","正在获得系统时间，请稍候......");
		myPacket.data.add("verifyType","getSysDate");
		core.ajax.sendPacket(myPacket,doSetStsDate);
		myPacket = null;
	}
	function doSetStsDate(packet){
		var verifyType = packet.data.findValueByName("verifyType");
		var sysDate = packet.data.findValueByName("sysDate");
		if(verifyType=="getSysDate"){
			document.all.Request_time.value = sysDate;
			return false;
		}
	}
	function padLeft(str, pad, count)
	{
			while(str.length<count)
			str=pad+str;
			return str;
	}
	function getCardNoPingBi(cardno)
	{
			var cardnopingbi = cardno.substr(0,6);
			for(i=0;i<cardno.length-10;i++)
			{
				cardnopingbi=cardnopingbi+"*";
			}
			cardnopingbi=cardnopingbi+cardno.substr(cardno.length-4,4);
			return cardnopingbi;
	}
	/* ningtn add for pos start @ 20100414 */
 
 function printCommit()
 {
  getAfterPrompt();
  document.frm.confirm.disabled=true; /*diling add for 申告:提交后提交按钮置灰@2012/5/21*/
  with(document.frm){
	opNote.value=phone_no.value+"办理积分换机冲正业务";
	//phone_typename.value=document.all.agent_code.options[document.all.agent_code.selectedIndex].text+document.all.phone_type.options[document.all.phone_type.selectedIndex].text;
  }
 //打印工单并提交表单

  var ret = showPrtDlg("Detail","确实要进行电子免填单打印吗？","Yes");
  if(typeof(ret)!="undefined")
  {
    if((ret=="confirm"))
    {
      if(rdShowConfirmDialog('确认电子免填单吗？')==1)
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
	else{
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

   var pType="subprint";                                         // 打印类型：print 打印 subprint 合并打印
   var billType="1";                                          // 票价类型：1电子免填单、2发票、3收据
   var sysAccept=document.all.login_accept.value;             // 流水号
   var printStr=printInfo(printType);                         //调用printinfo()返回的打印内容
   var mode_code=null;                                        //资费代码
   var fav_code=null;                                         //特服代码
   var area_code=null;                                        //小区代码
   var opCode="1144";                                         //操作代码
   var phoneNo=document.all.phone_no.value;                   //客户电话
       /* ningtn */
    var iccidInfoStr = $("#firstId").val() + "|" + $("#secondId").val();	
		var accInfoStr = $("#accInfoHid1").val() + "|" +$("#accInfoHid2").val()+ "|" +$("#accInfoHid3").val()+ "|" +$("#accInfoHid4").val();
    /* ningtn */
   var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no";
   var path = "<%=request.getContextPath()%>/npage/innet/hljBillPrint_jc_hw.jsp?DlgMsg=" + DlgMessage+ "&submitCfm=" + submitCfm+"&iccidInfo=" + iccidInfoStr + "&accInfoStr="+accInfoStr;
   path+=path+"&mode_code="+mode_code+"&fav_code="+fav_code+"&area_code="+area_code+"&opCode=<%=opCode%>&sysAccept="+sysAccept+"&phoneNo="+phoneNo+"&submitCfm="+submitCfm+"&pType="+pType+"&billType="+billType+ "&printInfo=" + printStr;
   var ret=window.showModalDialog(path,printStr,prop);
   return ret;
}

function printInfo(printType)
{

    var cust_info=""; //客户信息
	var opr_info=""; //操作信息
	var note_info1=""; //备注1
	var note_info2=""; //备注2
	var note_info3=""; //备注3
	var note_info4=""; //备注4
    var retInfo = "";  //打印内容

    cust_info+="手机号码："+document.all.phone_no.value+"|";
	cust_info+="客户姓名："+document.all.cust_name.value+"|";
	cust_info+="客户地址："+document.all.cust_addr.value+"|";
	cust_info+="证件号码："+document.all.cardId_no.value+"|";

	opr_info+="业务类型：积分换机冲正"+"|";
    opr_info+="业务流水："+document.all.login_accept.value+"|";
    opr_info+="手机型号: "+document.all.type_name.value+"|";

	var jkinfo="";
	if(parseInt(document.all.card_money.value,10)==0){
		jkinfo+="退款合计："+document.all.sum_money.value+"元　含：预存话费"+document.all.pay_money.value+"元";
	}else{
		jkinfo+="退款合计："+document.all.sum_money.value+"元　含：预存话费"+document.all.pay_money.value+"元，含"+document.all.cardy.value;
	}
	if(document.all.spec_fee.value!="0"){
		jkinfo+="，"+(document.all.spec_name.value).trim()+" "+parseInt(document.all.spec_fee.value,10)+"元";
	}
	opr_info+=jkinfo+"|";
    note_info1="备注："+document.all.opNote.value+"|";
	//retInfo=cust_info+"#"+opr_info+"#"+note_info1+"#"+note_info2+"#"+note_info3+"#"+note_info4+"#";
	retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
	retInfo=retInfo.replace(new RegExp("#","gm"),"%23");
    return retInfo;
}



//-->
</script>

<script language="JavaScript">
<!--
/****************根据agent_code动态生成phone_type下拉框************************/
 function selectChange(control, controlToPopulate, ItemArray, GroupArray)
 {
   var myEle ;
   var x ;
   // Empty the second drop down box of any choices
   for (var q=controlToPopulate.options.length;q>=0;q--) controlToPopulate.options[q]=null;
   // ADD Default Choice - in case there are no values

   myEle = document.createElement("option") ;
   myEle.value = "";
   myEle.text ="--请选择--";
   controlToPopulate.add(myEle) ;
   for ( x = 0 ; x < ItemArray.length  ; x++ )
   {
      if ( GroupArray[x] == control.value )
      {
        myEle = document.createElement("option") ;
        myEle.value = arrPhoneType[x] ;
        myEle.text = ItemArray[x] ;
        controlToPopulate.add(myEle) ;
      }
   }
 }
 function typechange(){

 	var myEle1 ;
   	var x1 ;
   	for (var q1=document.all.sale_code.options.length;q1>=0;q1--) document.all.sale_code.options[q1]=null;
   	myEle1 = document.createElement("option") ;
    	myEle1.value = "";
        myEle1.text ="--请选择--";
        document.all.sale_code.add(myEle1) ;

   	for ( x1 = 0 ; x1 < arrsaletype.length  ; x1++ )
   	{
      	if ( arrsaletype[x1] == document.all.phone_type.value  && arrsalebarnd[x1] == document.all.agent_code.value)
      	{
        	myEle1 = document.createElement("option") ;
        	myEle1.value = arrsalecode[x1];
        	myEle1.text = arrsaleName[x1];
        	document.all.sale_code.add(myEle1) ;
      	}
   	}
 }
 function salechage(){

	var getNote_Packet = new AJAXPacket("f1141_getcardrpc.jsp","正在获得营销明细，请稍候......");
    getNote_Packet.data.add("retType","getcard");
	getNote_Packet.data.add("saletype","0");
	getNote_Packet.data.add("regionCode","<%=regionCode%>");
	getNote_Packet.data.add("salecode",document.all.sale_code.value);
	core.ajax.sendPacket(getNote_Packet);
	getNote_Packet=null;
 }
/*
 function getSum(){
   with(document.frm){
	   if(!(num.value=="") && !(price.value=="")){
         if(!checkElement("num")) return false;
	     if(!checkElement("price")) return false;
	     sum_money.value = num.value * price.value;
	   }
   }
 }
 */
//-->
</script>
</head>
<body>
<form name="frm" method="post" action="f1144_2.jsp" onKeyUp="chgFocus(frm)">
	<%@ include file="/npage/include/header.jsp" %>

		<div class="title">
			<div id="title_zi">积分换机冲正</div>
		</div>

        <table cellspacing="0">
		  <tr>
            <td class="blue">操作类型</td>
            <td colspan="3">积分换机冲正</td>
          </tr>
          <tr>
            <td class="blue">客户姓名</td>
            <td>
			  <input name="cust_name" value="<%=bp_name%>" type="text" Class="InputGrey" v_must=1 readonly id="cust_name">
            </td>
            <td class="blue">客户地址</td>
            <td>
			  <input name="cust_addr" value="<%=bp_add%>" type="text" Class="InputGrey" v_must=1 readonly id="cust_addr">
            </td>
          </tr>
          <tr>
            <td class="blue">证件类型</td>
            <td>
			  <input name="cardId_type" value="<%=cardId_type%>" type="text" Class="InputGrey" v_must=1 readonly id="cardId_type">
            </td>
            <td class="blue">证件号码</td>
            <td>
			  <input name="cardId_no" value="<%=cardId_no%>" type="text" Class="InputGrey" v_must=1 readonly id="cardId_no">
            </td>
          </tr>
          <tr>
            <td class="blue">业务品牌</td>
            <td>
			  <input name="sm_code" value="<%=sm_code%>" type="text" Class="InputGrey" v_must=1 readonly id="sm_code">
            </td>
            <td class="blue">运行状态</td>
            <td>
			  <input name="run_type" value="<%=run_name%>" type="text" Class="InputGrey" v_must=1 readonly id="run_type">
            </td>
          </tr>
          <tr>
            <td class="blue">当前积分</td>
            <td>
			  <input name="posint" value="<%=posint%>" type="text" Class="InputGrey" v_must=1 readonly id="posint">
            </td>
            <td class="blue">可用预存</td>
            <td>
			  <input name="prepay_fee" value="<%=prepay_fee%>" type="text" Class="InputGrey" v_must=1 readonly id="prepay_fee">
            </td>
          </tr>
          <tr>
            <td class="blue">营销方案</td>
            <td colspan="3">
			  <input type="text" name="sale_code" Class="InputGrey" readonly id="sale_code" value="<%=sale_name%>" >
			</td>
          </tr>
          <tr>
             <td class="blue">赠送卡类金额</td>
             <td>
			  <input name="card_money" type="text" Class="InputGrey" id="card_money" v_type="money" v_must=1 readonly value="<%=card_money%>">
			</td>
            <td class="blue">赠送话费</td>
            <td>
			  <input name="pay_money" type="text" Class="InputGrey" id="pay_money" v_type="0_9" v_must=1 readonly value="<%=pay_money%>">
			</td>
          </tr>
          <tr>
            <td class="blue">赠送卡类信息</td>
            <td colspan="3">
			  <input type="text" name="card_info" Class="InputGrey" id="card_info"  readonly value="<%=card_num%>">
			</td>
          </tr>
          <tr>
            <td class="blue">赠送数据业务</td>
            <td>
			  <input type="text" name="spec_name" Class="InputGrey" id="spec_name" value="<%=vspec_name%>" readonly>
			</td>
            <td class="blue">金额</td>
            <td>
			  <input type="text" name="spec_fee" Class="InputGrey" id="spec_fee"  value="<%=vspec_fee%>" readonly>
			</td>
          </tr>
          <tr>
            <td class="blue">到期时间</td>
            <td >
			  <input name="used_date" type="text" Class="InputGrey" id="used_date"   value="<%=vused_date%>"  readonly>
			</td>
            <td class="blue">套餐代码</td>
            <td>
			  <input name="mode_code" type="text" Class="InputGrey" id="mode_code"   value="<%=vmode_code%>" readonly>
			</td>
          </tr>
          <tr>
            <td class="blue">应付金额</td>
            <td colspan="3">
			  <input name="sum_money" type="text" Class="InputGrey" id="sum_money" readonly value="<%=sum_money%>">
			</td>
          </tr>
          <tr style="display:none">
            <td class="blue">备注</td>
            <td colspan="3">
             <input name="opNote" type="text" id="opNote" value="积分换机冲正">
            </td>
          </tr>
<jsp:include page="/npage/public/hwReadCustCard.jsp">
	<jsp:param name="hwAccept" value="<%=printAccept%>"  />
	<jsp:param name="showBody" value="01"  />
</jsp:include>
          <tr>
            <td colspan="4">
            	<div align="center">
                <input name="confirm" type="button" class="b_foot" index="2" value="确认&打印" onClick="printCommit()">
                <input name="reset" type="reset" class="b_foot" value="清除" >
                <input name="back" onClick="javascript:history.go(-1);" type="button" class="b_foot" value="返回">
                </div>
            </td>
          </tr>
        </table>

    <input type="hidden" name="phone_no" value="<%=phoneNo%>">
    <input type="hidden" name="work_no" value="<%=loginName%>">
    <input type="hidden" name="login_accept" value="<%=printAccept%>">
    <input type="hidden" name="backaccept" value="<%=backaccept%>">
    <input type="hidden" name="card_dz" >
    <input type="hidden" name="used_point" value="0" >
    <input type="hidden" name="point_money" value="0" >
    <input type="hidden" name="opcode" value="<%=opcode%>">
    <input type="hidden" name="sale_type" value="0" >
    <input type="hidden" name="phone_typename" >
    <input type="hidden" name="cardy" value="<%=scard_money%>">
    <input type="hidden" name="type_name" value="<%=type_name%>">
    
    <!-- ningtn add for pos start @ 20100414 -->
			<input type="hidden" name="payType"  value="<%=payType%>" ><!-- 缴费类型 payType=BX 是建行 payType=BY 是工行 -->
			<input type="hidden" name="MerchantNameChs"  value=""><!-- 从此开始以下为银行参数 -->
			<input type="hidden" name="MerchantId"  value="">
			<input type="hidden" name="TerminalId"  value="">
			<input type="hidden" name="IssCode"  value="">
			<input type="hidden" name="AcqCode"  value="">
			<input type="hidden" name="CardNo"  value="">
			<input type="hidden" name="BatchNo"  value="">
			<input type="hidden" name="Response_time"  value="">
			<input type="hidden" name="Rrn"  value="">
			<input type="hidden" name="AuthNo"  value="">
			<input type="hidden" name="TraceNo"  value="">
			<input type="hidden" name="Request_time"  value="">
			<input type="hidden" name="CardNoPingBi"  value="">
			<input type="hidden" name="ExpDate"  value="">
			<input type="hidden" name="Remak"  value="">
			<input type="hidden" name="TC"  value="">
		<!-- ningtn add for pos start @ 20100414 -->
    <%@ include file="/npage/include/footer.jsp" %>
    <%@ include file="../../npage/common/pwd_comm.jsp" %>
</form>
<!-- **** ningtn add for pos @ 20100414 ******加载建行控件页 BankCtrl ******** -->
<%@ include file="/npage/public/posCCB.jsp" %>
<!-- **** ningtn add for pos @ 20100414 ******加载工行控件页 KeeperClient ******** -->
<%@ include file="/npage/public/posICBC.jsp" %>
</body>
<%@ include file="/npage/public/hwObject.jsp" %> 
</html>



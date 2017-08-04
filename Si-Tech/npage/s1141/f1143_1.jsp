<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%
/********************
 version v2.0
开发商: si-tech
********************/
%>

<html  xmlns="http://www.w3.org/1999/xhtml">
<%@ include file="/npage/include/public_title_name.jsp" %>
<%
  response.setHeader("Pragma","No-cache");
  response.setHeader("Cache-Control","no-cache");
  response.setDateHeader("Expires", 0);
%>

<%@ page contentType="text/html;charset=GBK"%>
<%@ page import="java.text.*" %>
<%@ include file="../../npage/bill/getMaxAccept.jsp" %>

<%
  String loginNo = (String)session.getAttribute("workNo");
  String loginName = (String)session.getAttribute("workName");
  String regionCode = (String)session.getAttribute("regCode");

  String opCode = "1143";
  String opName = "积分换机";

  String retFlag="",retmsg="";
  String[] paraAray1 = new String[3];
  String phoneNo = request.getParameter("srv_no");
  String opcode = request.getParameter("opcode");
  String passwordFromSer="";
  
  String groupId = (String)session.getAttribute("groupId");
  String orgCode =(String)session.getAttribute("orgCode");
  String loginPwd    = (String)session.getAttribute("password");
  paraAray1[0] = phoneNo;		/* 手机号码   */
  paraAray1[1] = opcode; 	    /* 操作代码   */
  paraAray1[2] = loginNo;	    /* 操作工号   */

  for(int i=0; i<paraAray1.length; i++)
  {
	if( paraAray1[i] == null )
	{
	  paraAray1[i] = "";

	}
  }
 /* 输出参数： 返回码，返回信息，客户姓名，客户地址，证件类型，证件号码，业务品牌，
 			归属地，当前状态，VIP级别，当前积分,可用预存
 */

  //retList = impl.callFXService("s1141Qry", paraAray1, "14","phone",phoneNo);
%>
  
  <wtc:service name="s1141Qry" routerKey="phone" routerValue="<%=phoneNo%>" retcode="retCode1" retmsg="retMsg1" outnum="14" >

		<wtc:param value=" "/>
		<wtc:param value="01"/>		
		<wtc:param value="<%=paraAray1[1]%>"/>
		<wtc:param value="<%=paraAray1[2]%>"/>
		<wtc:param value="<%=loginPwd%>"/>										
		<wtc:param value="<%=paraAray1[0]%>"/>
		<wtc:param value=""/>
		
	</wtc:service>
	<wtc:array id="tempArr" scope="end"/>

<%
  String  bp_name="",bp_add="",cardId_type="",cardId_no="",sm_code="",region_name="",run_name="",vip="",posint="",prepay_fee="";
  //String[][] tempArr= new String[][]{};
  String errCode = retCode1;
  String errMsg = retMsg1;

  System.out.println("errCode1======"+errCode);
  System.out.println("errMsg1======="+errMsg);
  if(tempArr[0][1]==null)
  {
	if(!retFlag.equals("000001"))
	{
	   System.out.println("retFlag========"+retFlag);
	   retFlag = "000001";
	   retmsg = "s1141Qry查询号码基本信息为空!<br>errCode: " + errCode + "<br>errMsg+" + errMsg;
    }
  }
  else
  {
	if(!errCode.equals("000000")){%>
		<script language="JavaScript">
			rdShowConfirmDialog("错误代码：<%=errCode%>，错误信息：<%=errMsg%>")
			history.go(-1);
		</script>
	<%}
	else
	{

	    bp_name = tempArr[0][2];           //机主姓名
	    bp_add = tempArr[0][3];            //客户地址
	    cardId_type = tempArr[0][4];       //证件类型
	    cardId_no = tempArr[0][5];         //证件号码
	    sm_code = tempArr[0][6];           //业务品牌
	    region_name = tempArr[0][7];       //归属地
	    run_name = tempArr[0][8];          //当前状态
	    vip = tempArr[0][9];               //vip级别
	    posint = tempArr[0][10];           //当前积分
	    prepay_fee = tempArr[0][11];       //可用预存
	    passwordFromSer = tempArr[0][12];  //密码

	}
  }

%>

<%
//******************得到下拉框数据***************************//
String printAccept="";
printAccept = getMaxAccept();
System.out.println("sysAccept==================="+printAccept);
  //手机品牌
  String sqlAgentCode = " select  unique a.brand_code,trim(b.brand_name) from sPhoneSalCfg a,schnresbrand b where a.region_code='" + regionCode + "' and a.sale_type='2' and a.brand_code=b.brand_code and valid_flag='Y' and a.spec_type like 'P%' and is_valid='1'";
  System.out.println("sqlAgentCode====="+sqlAgentCode);
  //ArrayList agentCodeArr = co.spubqry32("2",sqlAgentCode);
 %>
  <wtc:pubselect name="sPubSelect" routerKey="phone" routerValue="<%=phoneNo%>" retcode="retCode2" retmsg="retMsg2" outnum="2">
    <wtc:sql><%=sqlAgentCode%>
    </wtc:sql>
	</wtc:pubselect>
	<wtc:array id="agentCodeArr" scope="end"/>

<%
  System.out.println("errorCode2=========="+retCode2);
  System.out.println("errorMsg2=========="+retMsg2);
  //手机类型
  String sqlPhoneType = "select unique a.type_code,trim(b.res_name), b.brand_code from sPhoneSalCfg a,schnrescode_chnterm b where a.region_code='" + regionCode + "' and  a.type_code=b.res_code and a.brand_code=b.brand_code and valid_flag='Y' and a.sale_type='2' and a.spec_type like 'P%' and is_valid='1'";
  System.out.println("sqlPhoneType====="+sqlPhoneType);
  //ArrayList phoneTypeArr = co.spubqry32("3",sqlPhoneType);
 %>
  <wtc:pubselect name="sPubSelect" routerKey="phone" routerValue="<%=phoneNo%>" retcode="retCode3" retmsg="retMsg3" outnum="3">
    <wtc:sql><%=sqlPhoneType%>
    </wtc:sql>
	</wtc:pubselect>
	<wtc:array id="phoneTypeArr" scope="end"/>
 <%
  System.out.println("errorCode3=========="+retCode3);
  System.out.println("errorMsg3=========="+retMsg3);
  //营销代码
  String sqlsaleType = "select unique a.sale_code,trim(a.sale_name), a.brand_code,a.type_code from sPhoneSalCfg a where a.region_code='" + regionCode + "' and a.sale_type='2' and valid_flag='Y' and a.spec_type like 'P%'";
  System.out.println("sqlsaleType====="+sqlsaleType);
  //ArrayList saleTypeArr = co.spubqry32("4",sqlsaleType);
%>
 <wtc:pubselect name="sPubSelect" routerKey="phone" routerValue="<%=phoneNo%>" retcode="retCode4" retmsg="retMsg4" outnum="4">
    <wtc:sql><%=sqlsaleType%>
    </wtc:sql>
	</wtc:pubselect>
	<wtc:array id="saleTypeArr" scope="end"/>
<%
	System.out.println("errorCode4=========="+retCode4);
    System.out.println("errorMsg4=========="+retMsg4);
%>
<head>
<title>积分换机</title>
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
    	var retResult = packet.data.findValueByName("retResult");

		if(retType == "getcard"){
    		if(retCode!="000000"){
    			return;
    		}

    	document.all.price.value="";
		document.all.price.value = packet.data.findValueByName("phonemoney");
		document.all.card_info.value="";
    	document.all.card_info.value = packet.data.findValueByName("cardvalue");
    	document.all.pay_money.value="";
    	document.all.pay_money.value = packet.data.findValueByName("prepay_gift");
		document.all.card_money.value="";
    	document.all.card_money.value = packet.data.findValueByName("cardshould");
    	document.all.card_dz.value="";
    	document.all.card_dz.value = packet.data.findValueByName("cardmoney");
    	document.all.cardy.value="";
    	document.all.cardy.value = packet.data.findValueByName("cardy");
		document.all.mode_code.value="";
    	document.all.mode_code.value = packet.data.findValueByName("vmode_code");
    	document.all.spec_name.value="";
    	document.all.spec_name.value = packet.data.findValueByName("vspec_name");
    	document.all.spec_fee.value="";
    	document.all.spec_fee.value = (packet.data.findValueByName("vspec_fee")).trim();
    	if(document.all.spec_fee.value==""){document.all.spec_fee.value="0";}
    	document.all.used_date.value = packet.data.findValueByName("vused_date");
    	document.all.card_type.value = packet.data.findValueByName("vcard_type");

    	}else if(retType == "checkAward")
		{
			var retCode = packet.data.findValueByName("retCode");
			var retMessage = packet.data.findValueByName("retMessage");
    		window.status = "";
    		if(retCode!="000000"){
    			rdShowConfirmDialog(retMessage);
    			document.all.need_award.checked = false;
    			document.all.award_flag.value = 0;
    			return ;
    		}
    		document.all.award_flag.value = 1;
    	}else{
			if(retResult == "000000"){
					rdShowMessageDialog("IMEI号校验成功1！",2);
					document.frm.confirm.disabled=false;
					document.frm.IMEINo.readOnly=true;
					return ;

			}else if(retResult == "000001"){
					rdShowMessageDialog("IMEI号校验成功2！",2);
					document.frm.confirm.disabled=false;
					document.frm.IMEINo.readOnly=true;
					return ;

			}else if(retResult == "000003"){
					rdShowMessageDialog("IMEI号不在营业员归属营业厅或IMEI号与业务办理机型不符！");
					document.frm.confirm.disabled=true;
					return false;
			}else{
					rdShowMessageDialog("IMEI号不存在或者已经使用！");
					document.frm.confirm.disabled=true;
					return false;
			}
		}
 }
 function viewConfirm()
{
	if(document.frm.IMEINo.value=="")
	{
		document.frm.confirm.disabled=true;
	}

}
//***IMEI 号码校验
 function checkimeino()
{
	 if (document.frm.IMEINo.value.length == 0) {
      rdShowMessageDialog("IMEI号码不能为空，请重新输入 !!");
      document.frm.IMEINo.focus();
      document.frm.confirm.disabled = true;
	  return false;
     }


	var myPacket = new AJAXPacket("queryimei.jsp","正在校验IMEI信息，请稍候......");
	myPacket.data.add("imei_no",(document.all.IMEINo.value).trim());
	myPacket.data.add("brand_code",(document.all.agent_code.options[document.all.agent_code.selectedIndex].value).trim());
	myPacket.data.add("style_code",(document.all.phone_type.options[document.all.phone_type.selectedIndex].value).trim());
	myPacket.data.add("opcode",(document.all.opcode.value).trim());
	myPacket.data.add("retType","getImei");

	core.ajax.sendPacket(myPacket);
	myPacket=null;
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

<%
  for(int i=0;i<phoneTypeArr.length;i++)
  {
	out.println("arrPhoneType["+i+"]='"+phoneTypeArr[i][0]+"';\n");
	out.println("arrPhoneName["+i+"]='"+phoneTypeArr[i][1]+"';\n");
	out.println("arrAgentCode["+i+"]='"+phoneTypeArr[i][2]+"';\n");
  }
  for(int l=0;l<saleTypeArr.length;l++)
  {
	out.println("arrsalecode["+l+"]='"+saleTypeArr[l][0]+"';\n");
	out.println("arrsaleName["+l+"]='"+saleTypeArr[l][1]+"';\n");
	out.println("arrsalebarnd["+l+"]='"+saleTypeArr[l][2]+"';\n");
	out.println("arrsaletype["+l+"]='"+saleTypeArr[l][3]+"';\n");

  }
%>

  //***
  function frmCfm(){
		///////<!-- ningtn add for pos start @ 20100408 -->
		document.all.payType.value = document.all.payTypeSelect.value;
		if(document.all.payType.value=="BX")
  	{
    		/*set 输入参数*/
				var transerial    = "000000000000";  	                    //交易唯一号 ，将会取消
				var trantype      = "00";         //交易类型
				var bMoney        = document.all.sum_money.value; 				//缴费金额
				if(bMoney.indexOf(".") == -1) bMoney=bMoney+"00";
				var tranoper      = "<%=loginNo%>";                       //交易操作员
				var orgid         = "<%=groupId%>";                       //营业员归属机构
				var trannum       = "<%=phoneNo%>";                       //电话号码
				getSysDate();       /*取boss系统时间*/
				var respstamp     = document.all.Request_time.value;      //提交时间
				var transerialold = "";																		//原交易唯一号,在缴费时传入空
				var org_code      = "<%=orgCode%>";                       //营业员归属						
				CCBCommon(transerial,trantype,bMoney,tranoper,orgid,trannum,respstamp,transerialold,org_code);
				if(ccbTran=="succ") posSubmitForm();
  	}
		else if(document.all.payType.value=="BY")
		{
				var transType     = "05";					/*交易类型 */         
				var bMoney        = document.all.sum_money.value;         /*交易金额 */
				if(bMoney.indexOf(".") == -1) bMoney=bMoney+"00";         
				var response_time = "";                								 		/*原交易日期 */				
				var rrn           = "";                           				/*原交易系统检索号 */ 
				var instNum       = "";                                   /*分期付款期数 */     
				var terminalId    = "";                    								/*原交易终端号 */			
				getSysDate();       																			//取boss系统时间                                            
				var request_time  = document.all.Request_time.value;      /*交易提交日期 */     
				var workno        = "<%=loginNo%>";                        /*交易操作员 */       
				var orgCode       = "<%=orgCode%>";                       /*营业员归属 */       
				var groupId       = "<%=groupId%>";                       /*营业员归属机构 */   
				var phoneNo       = "<%=phoneNo%>";                       /*交易缴费号 */       
				var toBeUpdate    = "";						                        /*预留字段 */         
				var posFlag = ICBCCommon(transType,bMoney,response_time,rrn,instNum,terminalId,request_time,workno,orgCode,groupId,phoneNo,toBeUpdate);									
				if(icbcTran=="succ") posSubmitForm();
		}else{
				posSubmitForm();
		}
		
		//////<!-- ningtn add for pos end @ 20100408 -->
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
  //校验
  //if(!check(frm)) return false;
  with(document.frm){
    if(cust_name.value==""){
	  rdShowMessageDialog("请输入姓名!");
      cust_name.focus();
	  return false;
	}
	if(agent_code.value==""){
	  rdShowMessageDialog("请输入手机品牌!");
      agent_code.focus();
	  return false;
	}
	if(phone_type.value==""){
	  rdShowMessageDialog("请输入手机型号!");
      phone_type.focus();
	  return false;
	}
	if(sale_code.value==""){
	  rdShowMessageDialog("请输入营销代码!");
      sale_code.focus();
	  return false;
	}
	if(used_point.value==""){
	rdShowMessageDialog("请输入消费积分!");
      used_point.focus();
	  return false;
	}
	if (IMEINo.value.length == 0) {
      rdShowMessageDialog("IMEI号码不能为空，请重新输入 !!");
      IMEINo.focus();
      confirm.disabled = true;
	  return false;
     }
	opNote.value=phone_no.value+"办理积分换机业务";
	phone_typename.value=document.all.agent_code.options[document.all.agent_code.selectedIndex].text+document.all.phone_type.options[document.all.phone_type.selectedIndex].text;
  }
  if(!pointchange()) return false;

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

   var pType="subprint";                                      // 打印类型：print 打印 subprint 合并打印
   var billType="1";                                          //  票价类型：1电子免填单、2发票、3收据
   var sysAccept=document.all.login_accept.value;             // 流水号
   var printStr=printInfo(printType);                         //调用printinfo()返回的打印内容
   var mode_code=null;                                        //资费代码
   var fav_code=null;                                         //特服代码
   var area_code=null;                                        //小区代码
   var opCode="1143";                                         //操作代码
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

	opr_info+="业务类型：积分换机"+"|";
    opr_info+="业务流水："+document.all.login_accept.value+"|";
    opr_info+="手机型号: "+document.all.agent_code.options[document.all.agent_code.selectedIndex].text+document.all.phone_type.options[document.all.phone_type.selectedIndex].text+"      IMEI码："+document.frm.IMEINo.value+"|";

	var jkinfo="";
	if(parseInt(document.all.card_money.value,10)==0){
		jkinfo="缴款合计："+document.all.sum_money.value+"元 含:预存话费 "+document.all.pay_money.value+"元";
	}else{
		jkinfo+="缴款合计："+document.all.sum_money.value+"元 含:预存话费 "+document.all.pay_money.value+"元，"+document.all.cardy.value;
	}
	if(document.all.spec_fee.value!="0"){
		jkinfo+="，"+(document.all.spec_name.value).trim()+" "+document.all.spec_fee.value+"元"+"|";
	}
	opr_info+=jkinfo+"|";

	note_info1="备注："+"|";

	//retInfo=cust_info+"#"+opr_info+"#"+note_info1+"#"+note_info2+"#"+note_info3+"#"+note_info4+"#";
	retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
	retInfo=retInfo.replace(new RegExp("#","gm"),"%23");

    if(document.all.award_flag.value == "1")
	{
		retInfo+= "已参与赠送礼品活动"+"|";
	}
	else
	{
		retInfo+= " "+"|";
	}
	//alert(retInfo);
    return retInfo;
}



//-->
</script>

<script language="JavaScript">
<!--
/****************根据agent_code动态生成phone_type下拉框************************/
 function selectChange(control, controlToPopulate, ItemArray, GroupArray)
 {
 	 document.frm.confirm.disabled=true;
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

   document.all.need_award.checked = false;
   document.all.award_flag.value = 0;

 }
 function typechange(){
  document.frm.confirm.disabled=true;
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
   	document.all.need_award.checked = false;
    document.all.award_flag.value = 0;
 }
 function salechage(){

	var getNote_Packet = new AJAXPacket("f1141_getcardrpc.jsp","正在获得营销明细，请稍候......");
  getNote_Packet.data.add("retType","getcard");
	getNote_Packet.data.add("saletype","2");
	getNote_Packet.data.add("regionCode","<%=regionCode%>");
	getNote_Packet.data.add("salecode",document.all.sale_code.value);
	core.ajax.sendPacket(getNote_Packet);
	getNote_Packet=null;
 }

 function checkAward()
 {
 	 if(document.all.phone_type.value == "")
 	 {
 	 	 rdShowConfirmDialog("请先选择机型");
 	 	 document.all.need_award.checked = false;
 	 	 document.all.award_flag.value = 0;
 	 	 return;
 	 }
 	 if(document.all.need_award.checked )
 	 {
 	 	 var packet = new AJAXPacket("phone_getAwardRpc.jsp","正在获得奖品明细，请稍候......");
 	 	 packet.data.add("retType","checkAward");
 	 	 packet.data.add("op_code","1143");
 	 	 packet.data.add("style_code",document.all.phone_type.value );

 	 	 core.ajax.sendPacket(packet);
 	 	 packet=null;

 	 }
 	 document.all.award_flag.value = 0;

 }

 function pointchange(){
 	 with(document.frm){

 		if (used_point.value==""){rdShowConfirmDialog("请输入消费积分");return;}
 		if(parseInt(used_point.value,10)%100 !=0){
 			rdShowConfirmDialog("积分消费必须输入整百数");
 			used_point.value="";
 			return false;
 		}

 		if(parseInt(used_point.value,10)>100000){
 			rdShowConfirmDialog("积分消费不能大于100000");
 			used_point.value="";
 			return false;
 		}

 		if(parseInt(used_point.value,10)>parseInt(point.value,10)){
 			rdShowConfirmDialog("积分消费不能大于当前积分");
 			used_point.value="";
 			return false;
 		}

    point_money.value=parseFloat(used_point.value,10)*(1.5/100);


 		if (price.value==""){price.value="0";}
 		if (card_money.value==""){card_money.value="0";}
 		if (spec_fee.value==""){spec_fee.value="0";}
 		if (pay_money.value==""){pay_money.value="0";}
 		max_money.value=parseFloat(price.value)-parseFloat(card_money.value)-parseFloat(spec_fee.value)-parseFloat(pay_money.value);

 		if(parseFloat(point_money.value)>parseFloat(max_money.value)){
 			rdShowConfirmDialog("积分消费冲抵金额("+point_money.value+")不能大于手机款、赠送话费、预存款和礼包金额的合计("+max_money.value+")");
 			used_point.value="";
 			return false;
 		}

 		sum_money.value=parseFloat(price.value)-parseFloat(point_money.value);
 		return true;
 	}
 }
//-->
</script>
</head>
<body>
<form name="frm" method="post" action="f1143_2.jsp" onKeyUp="chgFocus(frm)">

	<%@ include file="/npage/include/header.jsp" %>

		<div class="title">
			<div id="title_zi">积分换机</div>
		</div>

        <table cellspacing="0">
		  <tr>
            <td class="blue">操作类型</td>
            <td colspan="3">积分换机</td>
          </tr>
          <tr>
            <td class="blue">客户姓名</td>
            <td>
			  <input name="cust_name" value="<%=bp_name%>" type="text" v_must=1 readonly Class="InputGrey" id="cust_name" maxlength="20" >

            </td>
            <td class="blue">客户地址</td>
            <td>
			  <input name="cust_addr" value="<%=bp_add%>" type="text" v_must=1 readonly Class="InputGrey" id="cust_addr" maxlength="30" size="40">
            </td>
          </tr>
            <tr>
            <td class="blue">证件类型</td>
            <td>
			  <input name="cardId_type" value="<%=cardId_type%>" type="text" v_must=1 readonly Class="InputGrey" id="cardId_type" maxlength="20" >

            </td>
            <td class="blue">证件号码</td>
            <td>
			  <input name="cardId_no" value="<%=cardId_no%>" type="text" v_must=1 readonly Class="InputGrey" id="cardId_no" maxlength="20" >

            </td>
            </tr>
            <tr>
            <td class="blue">业务品牌</td>
            <td>
			  <input name="sm_code" value="<%=sm_code%>" type="text" v_must=1 readonly Class="InputGrey" id="sm_code" maxlength="20" >

            </td>
            <td class="blue">运行状态</td>
            <td>
			  <input name="run_type" value="<%=run_name%>" type="text" v_must=1 readonly Class="InputGrey" id="run_type" maxlength="20" >

            </td>
            </tr>
            <tr>
            <td class="blue">当前积分</td>
            <td>
			  <input name="point" value="<%=posint%>" type="text" v_must=1 readonly Class="InputGrey" id="point" maxlength="20" >

            </td>
            <td class="blue">可用预存</td>
            <td>
			  <input name="prepay_fee" value="<%=prepay_fee%>" type="text" v_must=1 readonly Class="InputGrey" id="prepay_fee" maxlength="20" >

            </td>
            </tr>
             <tr>
            <td class="blue">手机品牌</td>
            <td>
			  <SELECT id="agent_code" name="agent_code" v_must=1  onchange="selectChange(this, phone_type, arrPhoneName, arrAgentCode);">
			    <option value ="">--请选择--</option>
                <%for(int i = 0 ; i < agentCodeArr.length ; i ++){%>
                 <option value="<%=agentCodeArr[i][0]%>"><%=agentCodeArr[i][1]%></option>
                <%}%>
        </select>
			  <font class="orange">*</font>
			</td>
	    <td class="blue">手机型号</td>
      <td>
			  <select size=1 name="phone_type" id="phone_type" v_must=1 onchange="typechange()">
        </select>
			  <font class="orange">*</font>
			</td>
      </tr>
      <tr>
        <td class="blue">营销方案</td>
        <td>
			  <select size=1 name="sale_code" id="sale_code" v_must=1 onchange="salechage()">
              </select>
			  <font class="orange">*</font>
			  </td>
			  <td colspan="2" class="blue">是否参与赠礼<input type="checkbox" name="need_award" onclick="checkAward()" />
				<input type="hidden" name="award_flag" value="0" />
		  	</td>
       </tr>

       <tr>
            <td class="blue">购机款</td>
            <td >
			  <input name="price" type="text" id="price" v_type="money" v_must=1   readonly Class="InputGrey">
			</td>
            <td class="blue">赠送话费</td>
            <td>
			  <input name="pay_money" type="text" id="pay_money" v_type="0_9" v_must=1 readonly Class="InputGrey">

			</td>
          </tr>
          <tr>
            <td class="blue" nowrap>赠送卡类金额</td>
            <td colspan="3">
			  <input name="card_money" type="text" id="card_money" v_type="money" v_must=1 readonly Class="InputGrey">
			</td>

          </tr>
           <tr>

            <td class="blue" nowrap>赠送卡类信息</td>
            <td colspan="3">
			  <input type="text" name="card_info"  id="card_info"  readonly Class="InputGrey">
			</td>

          </tr>
          <tr>

            <td class="blue" nowrap>赠送数据业务</td>
            <td>
			  <input type="text" name="spec_name" id="spec_name"  readonly Class="InputGrey">
			</td>
            <td class="blue">金额</td>
            <td>
			  <input type="text" name="spec_fee" id="spec_fee"  readonly Class="InputGrey">
			</td>
          </tr>
          <tr>
            <td class="blue">到期时间</td>
            <td >
			  <input name="used_date" type="text" id="used_date"    readonly Class="InputGrey">

			</td>
            <td class="blue">套餐代码</td>
            <td>
			  <input name="mode_code" type="text" id="mode_code"  readonly Class="InputGrey">

			</td>
          </tr>
          <tr>
          <td class="blue">消费积分</td>
          <td><input type="text" name="used_point" id="used_point" onchange="pointchange()" >
          <font class="orange">*</font>
          </td>
            <td class="blue">应付金额</td>
            <td >
			  <input name="sum_money" type="text" id="sum_money" readonly Class="InputGrey">

			  <input name="max_money" type="hidden" value="" readonly Class="InputGrey">
			</td>
          </tr>
          <!-- ningtn add for pos start @ 20100414 -->
					<TR>
						<TD class="blue">缴费方式</TD>
						<TD colspan="3">
							<select name="payTypeSelect" >
								<option value="0">现金缴费</option>
								<option value="BX">建设银行POS机缴费</option>
								<option value="BY">工商银行POS机缴费</option>
							</select>
						</TD>
					</TR>
					<!-- ningtn add for pos end @ 20100414 -->
         <tr>
			<td class="blue">
				<div align="left">IMEI码</div>
            </TD>
            <TD colspan="3">
				<input name="IMEINo" type="text" v_type="0_9"  maxlength=15 value="" onblur="viewConfirm()">
				<input name="checkimei" class="b_text" type="button" value="校验" onclick="checkimeino()">
                <font class="orange">*</font>
            </TD>
          </TR>
		  <tr id=showHideTr >
			<TD class="blue">
				<div align="left">付机时间</div>
            </TD>
			<TD >
				<input name="payTime" type="text"  value="<%=new java.text.SimpleDateFormat("yyyyMMdd", Locale.getDefault()).format(new java.util.Date())%>">
				(年月日)<font class="orange">*</font>
			</TD>
			<TD class="blue">
				<div align="left">保修时限</div>
			</TD>
			<TD >
				<input name="repairLimit" v_type="date.month" size="10" type="text"  value="12" onblur="viewConfirm()">
				(个月)<font class="orange">*</font>
			</TD>
          </TR>
		  <tr style="display:none">
            <td class="blue">备注</td>
            <td colspan="3">
             <input name="opNote" type="text" id="opNote" size="60" maxlength="60" value="积分换机" >
            </td>
          </tr>
<jsp:include page="/npage/public/hwReadCustCard.jsp">
	<jsp:param name="hwAccept" value="<%=printAccept%>"  />
	<jsp:param name="showBody" value="01"  />
</jsp:include>
          <tr>
            <td colspan="4" id="footer"> <div align="center">
                <input name="confirm" type="button" class="b_foot" index="2" value="确认&打印" onClick="printCommit()" disabled>
                &nbsp;
                <input name="reset" type="reset" class="b_foot" value="清除" onclick="IMEINo.readOnly=false">
                &nbsp;
                <input name="back" onClick="javascript:history.go(-1);" type="button" class="b_foot" value="返回">
                &nbsp; </div></td>
          </tr>
    </table>
    <input type="hidden" name="phone_no" value="<%=phoneNo%>">
    <input type="hidden" name="work_no" value="<%=loginName%>">
    <input type="hidden" name="login_accept" value="<%=printAccept%>">
    <input type="hidden" name="opcode" value="<%=opcode%>">
    <input type="hidden" name="card_dz" >
    <input type="hidden" name="point_money" >
    <input type="hidden" name="sale_type" value="2" >
    <input type="hidden" name="phone_typename" >
    <input type="hidden" name="cardy" >
    <input type="hidden" name="card_type" >
    
    <!-- ningtn add for pos start @ 20100414 -->		
		<input type="hidden" name="payType"  value=""><!-- 缴费类型 payType=BX 是建行 payType=BY 是工行 -->			
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
		<!-- ningtn add for pos end @ 20100414 -->
    <%@ include file="/npage/include/footer.jsp" %>
</form>
<!-- **** ningtn add for pos @ 20100414 ******加载建行控件页 BankCtrl ******** -->
<%@ include file="/npage/public/posCCB.jsp" %>
<!-- **** ningtn add for pos @ 20100414 ******加载工行控件页 KeeperClient ******** -->
<%@ include file="/npage/public/posICBC.jsp" %>
</body>
<%@ include file="/npage/public/hwObject.jsp" %> 
</html>



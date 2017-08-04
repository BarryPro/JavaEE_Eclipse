<%
/********************
 version v2.0
开发商: si-tech
********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%
  response.setHeader("Pragma","No-cache");
  response.setHeader("Cache-Control","no-cache");
  response.setDateHeader("Expires", 0);
  



%>

<%@ page contentType="text/html;charset=gb2312"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ include file="../../npage/bill/getMaxAccept.jsp" %>


<%		

  		String opCode = "7955";
		String opName = "购机赠话费（按月返还）";
	 	String loginName = WtcUtil.repNull((String)session.getAttribute("workName"));	
		String loginNo = WtcUtil.repNull((String)session.getAttribute("workNo"));
		String powerCode= WtcUtil.repNull((String)session.getAttribute("powerCode")); 
		String orgCode = WtcUtil.repNull((String)session.getAttribute("orgCode"));
		String ip_Addr = WtcUtil.repNull((String)session.getAttribute("ipAddr"));
		String regionCode = WtcUtil.repNull((String)session.getAttribute("regCode"));
		String loginNoPass = WtcUtil.repNull((String)session.getAttribute("password"));
		String  groupId = WtcUtil.repNull((String)session.getAttribute("groupId"));
		//增加参数区分网站预约和前台办理wanghyd
		String banlitype =request.getParameter("banlitype");
		  

%>
<%
String retFlag="",retMsg="";

  ArrayList retList = new ArrayList();
  String[] paraAray1 = new String[3];
  String phoneNo = request.getParameter("srv_no");
  String opcode = request.getParameter("opcode");
  String passwordFromSer="";
  
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
%>
<wtc:service name="s1141Qry" routerKey="phone" routerValue="<%=phoneNo%>"  retcode="errCode" retmsg="errMsg"  outnum="14" >
		
		<wtc:param value=" "/>
		<wtc:param value="01"/>		
		<wtc:param value="<%=paraAray1[1]%>"/>
		<wtc:param value="<%=paraAray1[2]%>"/>
		<wtc:param value="<%=loginNoPass%>"/>										
		<wtc:param value="<%=paraAray1[0]%>"/>
		<wtc:param value=""/>	
			
	</wtc:service>
	<wtc:array id="result22222" scope="end" />
<%
  String  bp_name="",bp_add="",cardId_type="",cardId_no="",sm_code="",region_name="",run_name="",vip="",posint="",prepay_fee="";
  String[][] tempArr= new String[][]{};
System.out.println(result22222.length+"|||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||");
  if(result22222.length<=0)
  {
	if(!retFlag.equals("1"))
	{
		System.out.println("retFlag="+retFlag);
	   retFlag = "1";
	   retMsg = "s1141Qry查询号码基本信息为空!<br>errCode: " + errCode + "<br>errMsg+" + errMsg;
    }    
  }
  else
  {
  	System.out.println("errCode="+errCode);
  	System.out.println("errMsg="+errMsg);
	if(!"000000".equals(errCode)){%>
		<script language="JavaScript">
			rdShowMessageDialog("错误代码：<%=errCode%>，错误信息：<%=errMsg%>" ,0);
			history.go(-1);
		</script>
	<%}
	else
	{
	tempArr = result22222;
	 
	  if(!(tempArr==null)){
	    bp_name = tempArr[0][2];//机主姓名
	    System.out.println(bp_name);
	  }
	
	  if(!(tempArr==null)){
	    bp_add = tempArr[0][3];//客户地址
	  }
	 
	  if(!(tempArr==null)){
	    cardId_type = tempArr[0][4];//证件类型
	  }
	 
	  if(!(tempArr==null)){
	    cardId_no = tempArr[0][5];//证件号码
	  }
	
	  if(!(tempArr==null)){
	    sm_code = tempArr[0][6];//业务品牌
	  }
	
	  if(!(tempArr==null)){
	    region_name = tempArr[0][7];//归属地
	  }
	 
	  if(!(tempArr==null)){
	    run_name = tempArr[0][8];//当前状态
	  }
	 
	  if(!(tempArr==null)){
	    vip = tempArr[0][9];//ＶＩＰ级别
	  }
	 
	  if(!(tempArr==null)){
	    posint = tempArr[0][10];//当前积分
	  }
	 
	  if(!(tempArr==null)){
	    prepay_fee = tempArr[0][11];//可用预存
	  }
	 
	  if(!(tempArr==null)){
	    passwordFromSer = tempArr[0][13];  //密码
	  }
	}
  }

%>
 <% 
 String passTrans=request.getParameter("cus_pass"); 
System.out.println("passTrans==="+passTrans);
System.out.println("passwordFromSer==="+passwordFromSer);
 

 %>
<%
//******************得到下拉框数据***************************//
%>
		<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="regioncode" 
			routerValue="<%=regionCode%>"  id="printAccept" />
<%
String exeDate="";
exeDate = getExeDate("1","1141");

  comImpl co=new comImpl();
  //手机品牌
  String sqlAgentCode = " select  unique a.brand_code,trim(b.brand_name) from sPhoneSalCfg a,schnresbrand b where a.region_code='" + regionCode + "' and a.sale_type='17' and a.brand_code=b.brand_code and valid_flag='Y' and a.spec_type like 'P%' and is_valid='1'";
  System.out.println("sqlAgentCode====="+sqlAgentCode);
   %> 
  <wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>" retcode="RetCode1" retmsg="RetMsg1" outnum="2">
	<wtc:sql><%=sqlAgentCode%></wtc:sql>
</wtc:pubselect>
<wtc:array id="agentCodeStr" scope="end" />
   <%  
  //手机类型
  String sqlPhoneType = "select unique a.type_code,trim(b.res_name), b.brand_code from sPhoneSalCfg a,schnrescode_chnterm b where a.region_code='" + regionCode + "' and  a.type_code=b.res_code and sale_type='17' and a.brand_code=b.brand_code and valid_flag='Y' and a.spec_type like 'P%' and is_valid='1'";
  System.out.println("sqlPhoneType====="+sqlPhoneType);
    %> 
  <wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>" retcode="RetCode2" retmsg="RetMsg2" outnum="3">
	<wtc:sql><%=sqlPhoneType%></wtc:sql>
</wtc:pubselect>
<wtc:array id="phoneTypeStr" scope="end" />
   <% 
  //营销代码
  //String sqlsaleType = "select unique a.sale_code,trim(a.sale_name), a.sale_price,a.prepay_gift from sPhoneSalCfg a where a.region_code='" + regionCode + "' and a.sale_type='17' and valid_flag='Y' and a.spec_type like 'P%'";
  String sqlsaleType = "select unique a.sale_code,trim(a.sale_name), a.sale_price,a.prepay_gift,nvl(consume_term,0),trim(op_note) from sPhoneSalCfg a where a.region_code='" + regionCode + "' and a.sale_type='17' and valid_flag='Y' and a.spec_type like 'P%'";
  System.out.println("sqlsaleType====="+sqlsaleType);
      %> 
  <wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>" retcode="RetCode3" retmsg="RetMsg3" outnum="6">
	<wtc:sql><%=sqlsaleType%></wtc:sql>
</wtc:pubselect>
<wtc:array id="saleTypeStr" scope="end" />
 
<%
	/* ningtn 号簿管家需求 */
	String password = (String)session.getAttribute("password");
	String[] paraAray4 = new String[7];
	String[][] tempArr4= new String[][]{};
	paraAray4[0] = printAccept;
	paraAray4[1] = "01";
	paraAray4[2] = opcode;
	paraAray4[3] = loginNo;
	paraAray4[4] = password;
	paraAray4[5] = phoneNo;
	paraAray4[6] = "";
	String showText = "";
	

	%>
<wtc:service name="sAdTermQry" routerKey="phone" routerValue="phoneNo"  retcode="retCode4" retmsg="retMsg4"  outnum="3" >
	<wtc:param value="<%=paraAray4[0]%>"/>
			<wtc:param value="<%=paraAray4[1]%>"/>
		<wtc:param value="<%=paraAray4[2]%>"/>
		<wtc:param value="<%=paraAray4[3]%>"/>
		<wtc:param value="<%=paraAray4[4]%>"/>
		<wtc:param value="<%=paraAray4[5]%>"/>
		<wtc:param value="<%=paraAray4[6]%>"/>
	</wtc:service>
	<wtc:array id="result22223" scope="end" />

<%
	if("000000".equals(retCode4)){
		System.out.println("~~~~调用sAdTermQry成功~~~~");
		tempArr4=result22223;
		if(result22223.length>0){	
			showText = tempArr4[0][2];
		}
	}else{
		System.out.println("~~~~调用sAdTermQry失败~~~~");
%>
			<script language="JavaScript">
				rdShowMessageDialog("错误代码：" + <%=retCode4%> + "，错误信息：" + <%=retMsg4%>,0);
				//rdShowMessageDialog("错误代码：<%=retCode4%>，错误信息：<%=retMsg4%>");
				//history.go(-1);
			</script>
<%
	}
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title><%=opName%></title>
<META content="no-cache" http-equiv="Pragma">
<META content="no-cache" http-equiv="Cache-Control">
<META content="0" 	     http-equiv="Expires" > 


 <script language=javascript>

  onload=function()
  {	
  
  	 
  	 /* ningtn 号簿管家需求 */

	var showtext = "<%=showText%>";
	var showMsgObj = document.getElementById("showMsg");
	if(showtext.length > 0){
		showMsgObj.innerHTML = showtext;
	}

  }
 function doProcess(packet){
 
 		errorCode = packet.data.findValueByName("errorCode");
 		
		errorMsg =  packet.data.findValueByName("errorMsg");
		retType = packet.data.findValueByName("retType");
		/*tianyang add for pos缴费 start*/
		var verifyType = packet.data.findValueByName("verifyType");
		if(verifyType=="getSysDate"){
			retType = "getSysDate";			
		}
		/*tianyang add for pos缴费 end*/
		
		var retResult=packet.data.findValueByName("retResult");;
		self.status="";
		var tmpObj="";
		var i=0;
		var j=0;
		var ret_code=0;
		var tmpstr="";
		
		ret_code =  errorCode;

		if(retType=="getcard"){
			if( ret_code == "000000" ){
			
				  tmpObj = "sale_code" 
				  backArrMsg = packet.data.findValueByName("backArrMsg");
					retResult = packet.data.findValueByName("retResult");
					
				  document.all(tmpObj).options.length=0;
				  document.all(tmpObj).options.length=backArrMsg.length;	
		        for(i=0;i<backArrMsg.length;i++)
			      {
				      document.all(tmpObj).options[i].text=backArrMsg[i][1];
				      document.all(tmpObj).options[i].value=backArrMsg[i][0];
		 	          document.all(tmpObj).options[i].nv2=backArrMsg[i][2];
			          document.all(tmpObj).options[i].nv3=backArrMsg[i][3];
		 	          document.all(tmpObj).options[i].nv4=backArrMsg[i][4];
			          document.all(tmpObj).options[i].nv5=backArrMsg[i][5];
			          //wangdana add for 手机电视 @
			          document.all(tmpObj).options[i].nv6=backArrMsg[i][6];
			          document.all(tmpObj).options[i].nv7=backArrMsg[i][7];
                //begin huangrong add 手机电视功能费，手机电视功能费消费期限，WLAN功能费，WLAN功能费消费期限值的获取
			          document.all(tmpObj).options[i].nv8=backArrMsg[i][8];
			          document.all(tmpObj).options[i].nv9=backArrMsg[i][9];		
			          document.all(tmpObj).options[i].nv10=backArrMsg[i][10];
			          document.all(tmpObj).options[i].nv11=backArrMsg[i][11];	
			          //end huangrong add 手机电视功能费，手机电视功能费消费期限，WLAN功能费，WLAN功能费消费期限值的获取			          	  			          
	          	          
			      }
			}
			else{
			if(ret_code=="44444444"){
			return;
			}else {
				rdShowMessageDialog("取信息错误:"+errorMsg+"!");
				return;	
				}		
			}
			change();
		}else if(retType == "checkAward")
		{
		
				var retCode = packet.data.findValueByName("retCode"); 
				var retMessage = packet.data.findValueByName("retMessage");
			
    		window.status = "";
    		if(retCode!=0){
    	    rdShowMessageDialog(retMessage);
    			document.all.need_award.checked = false;
    			document.all.award_flag.value = 0;
    	
    			return;
    			
    		}
    		document.all.award_flag.value = 1;
    	}
    	/**** tianyang add for pos start ****/
    	else if(retType == "getSysDate")
			{
				var sysDate = packet.data.findValueByName("sysDate");
				document.all.Request_time.value = sysDate;
				return ;
			}
			/**** tianyang add for pos end ****/
    	else{
			if(retResult == "000000"){
					rdShowMessageDialog("IMEI号校验成功1！");
					document.frm.IMEINo.readOnly=true;
					document.frm.confirm.disabled=false;
					return ;

			}else if(retResult == "000001"){
					rdShowMessageDialog("IMEI号校验成功2！");
					document.frm.IMEINo.readOnly=true;
					document.frm.confirm.disabled=false;
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


 function change(){
	with(document.frm){

		price.value=sale_code.options[sale_code.selectedIndex].nv2;
		pay_money.value=sale_code.options[sale_code.selectedIndex].nv3;
		consume_term.value=sale_code.options[sale_code.selectedIndex].nv4;
		chg_flag.value=sale_code.options[sale_code.selectedIndex].nv5;
		TVprice.value=sale_code.options[sale_code.selectedIndex].nv6;
		TVtime.value=sale_code.options[sale_code.selectedIndex].nv7;
    //begin huangrong add 手机电视功能费，手机电视功能费消费期限，WLAN功能费，WLAN功能费消费期限值的获取
		phoneNetPrice.value=sale_code.options[sale_code.selectedIndex].nv8;
		phoneNetTime.value=sale_code.options[sale_code.selectedIndex].nv9;
		wlanPrice.value=sale_code.options[sale_code.selectedIndex].nv10;
		wlanTime.value=sale_code.options[sale_code.selectedIndex].nv11;
		//end huangrong add 手机电视功能费，手机电视功能费消费期限，WLAN功能费，WLAN功能费消费期限值的获取	
		var i=price.value;
		var j=pay_money.value;
		var m=TVprice.value;
		sum_money.value=(parseFloat(i)).toFixed(2);//wangdana
		mach_fee.value=(parseFloat(i)-parseFloat(j)-parseFloat(m)).toFixed(2);
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
  var arrsalePrice=new Array();
  var arrsaleLimit=new Array();
  var arrsaleTerm=new Array();
  var arrsaleChgFlag=new Array();
  var arrsaletype=new Array();
  


 
<%  
  for(int i=0;i<phoneTypeStr.length;i++)
  {
	out.println("arrPhoneType["+i+"]='"+phoneTypeStr[i][0]+"';\n");
	out.println("arrPhoneName["+i+"]='"+phoneTypeStr[i][1]+"';\n");
	out.println("arrAgentCode["+i+"]='"+phoneTypeStr[i][2]+"';\n");
  }  
  for(int l=0;l<saleTypeStr.length;l++)
  {
	out.println("arrsalecode["+l+"]='"+saleTypeStr[l][0]+"';\n");
	out.println("arrsaleName["+l+"]='"+saleTypeStr[l][1]+"';\n");
	out.println("arrsalePrice["+l+"]='"+saleTypeStr[l][2]+"';\n");
	out.println("arrsaleLimit["+l+"]='"+saleTypeStr[l][3]+"';\n");
	out.println("arrsaleTerm["+l+"]='"+saleTypeStr[l][4]+"';\n");
	out.println("arrsaleChgFlag["+l+"]='"+saleTypeStr[l][5]+"';\n");
	
  }  
%>
	
	/*tianyang add POS缴费 start*/
	function getSysDate()
	{		
			var myPacket = new AJAXPacket("../public/pos_getSysDate.jsp","正在获得系统时间，请稍候......");
			myPacket.data.add("verifyType","getSysDate");
			core.ajax.sendPacket(myPacket);
	  	myPacket =null;
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
	function posSubmitForm(){/* POS缴费中 页面提交  start*/
			frm.submit();
			return true;
	}
	/*tianyang add POS缴费 end*/
	
	
  //***
  function frmCfm(){  	
  	//alert(document.all.payType.value);
  	if(document.all.payType.value=="BX")
  	{
    		/*set 输入参数*/
				var transerial    = "000000000000";  	                     //交易唯一号 ，将会取消
				var trantype      = "00";                                  //交易类型
				var bMoney        = document.all.sum_money.value;					 //缴费金额
				var tranoper      = "<%=loginNo%>";                        //交易操作员
				var orgid         = "<%=groupId%>";                        //营业员归属机构
				var trannum       = "<%=phoneNo%>";                    		 //电话号码
				getSysDate();       /*取boss系统时间*/
				var respstamp     = document.all.Request_time.value;       //提交时间
				var transerialold = "";			                               //原交易唯一号,在缴费时传入空
				var org_code      = "<%=orgCode%>";                        //营业员归属						
				CCBCommon(transerial,trantype,bMoney,tranoper,orgid,trannum,respstamp,transerialold,org_code);
				if(ccbTran=="succ") posSubmitForm();
  	}
		else if(document.all.payType.value=="BY")
		{
				var transType     = "05";																	/*交易类型 */         
				var bMoney        = document.all.sum_money.value;         /*交易金额 */         
				var response_time = "";                                   /*原交易日期 */       
				var rrn           = "";                                   /*原交易系统检索号 */ 
				var instNum       = "";                                   /*分期付款期数 */     
				var terminalId    = "";                                   /*原交易终端号 */			
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
     
       var IMEINo = $("#IMEINo").val();
       var agent_code = $("#agent_code").val();
       var phone_type = $("#phone_type").val();
       var Role_Code_add = $("#Role_Code_add").val();
       var opcode = $("#opcode").val();
      // alert(phone_type);
	
	var myPacket = new AJAXPacket("queryimei.jsp","正在校验IMEI信息，请稍候......");
	myPacket.data.add("imei_no",IMEINo);
	myPacket.data.add("brand_code",agent_code);
	myPacket.data.add("style_code",phone_type);
	myPacket.data.add("retType","0");
	myPacket.data.add("opcode",opcode);
	core.ajax.sendPacket(myPacket);
	myPacket =null; 
    
}
 function printCommit()
 { 
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
	if (IMEINo.value.length == 0) {
      rdShowMessageDialog("IMEI号码不能为空，请重新输入 !!");
      IMEINo.focus();
      confirm.disabled = true;
	  return false;
     } 
	 document.all.phone_typename.value=document.all.agent_code.options[document.all.agent_code.selectedIndex].text+document.all.phone_type.options[document.all.phone_type.selectedIndex].text;
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
   var h=180;
   var w=350;
   var t=screen.availHeight/2-h/2;
   var l=screen.availWidth/2-w/2;
   
   var printStr = printInfo(printType);
   
   /*
   var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no"; 
   var path = "<%=request.getContextPath()%>/npage/innet/hljBillPrint_jc.jsp?DlgMsg=" + DlgMessage;
   var path = path + "&printInfo=" + printStr + "&submitCfm=" + submitCfm;
   var ret=window.showModalDialog(path,"",prop);
   return ret;    
   */
   
  var pType="subprint";             				 	//打印类型：print 打印 subprint 合并打印
	var billType="1";              				 			  //票价类型：1电子免填单、2发票、3收据
	var sysAccept =<%=printAccept%>;             	//流水号
	var printStr = printInfo(printType);			 		//调用printinfo()返回的打印内容
	var mode_code=null;           							  //资费代码
	var fav_code=null;                				 		//特服代码
	var area_code=null;             				 		  //小区代码
	var opCode="7955" ;                   			 	//操作代码
	var phoneNo="<%=phoneNo%>";                  //客户电话
	
		var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no";
		var path = "<%=request.getContextPath()%>/npage/innet/hljBillPrint_jc_hw.jsp?DlgMsg=" + DlgMessage;
		path+="&mode_code="+mode_code+
			"&fav_code="+fav_code+"&area_code="+area_code+
			"&opCode=<%=opCode%>&sysAccept="+sysAccept+
			"&phoneNo="+phoneNo+
			"&submitCfm="+submitCfm+"&pType="+
			pType+"&billType="+billType+ "&printInfo=" + printStr;
		var ret=window.showModalDialog(path,printStr,prop);
		return ret;
}

function printInfo(printType)
{
 
  	var cust_info="";  				//客户信息
		var opr_info="";   				//操作信息
		var note_info1=""; 				//备注1
		var note_info2=""; 				//备注2
		var note_info3=""; 				//备注3
		var note_info4=""; 				//备注4
		var retInfo = "";  				//打印内容
 
  
	var month_fee ;
	var pay = document.all.pay_money.value;
	month_fee= Math.round(pay*100/12)/100;
  

//	opr_info+='<%=loginNo%>'+' '+'<%=loginName%>'+"|";
//	opr_info+='<%=new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss", Locale.getDefault()).format(new java.util.Date())%>'+"|";
	cust_info+="手机号码："+document.all.phone_no.value+"|";
	cust_info+="客户姓名："+document.all.cust_name.value+"|";
	cust_info+="客户地址："+document.all.cust_addr.value+"|";
	cust_info+="证件号码："+document.all.cardId_no.value+"|";
	retInfo+=" "+"|";
	retInfo+=" "+"|";
	retInfo+=" "+"|";
	retInfo+=" "+"|";
	retInfo+=" "+"|";
	retInfo+=" "+"|";
	opr_info+="用户品牌："+document.all.sm_code.value+"               业务类型：购机赠话费（按月返还）"+"|";
  	opr_info+="业务流水："+document.all.login_accept.value+"|";
  	opr_info+="手机型号: "+document.all.phone_typename.value+"      IMEI码："+document.frm.IMEINo.value+"|";
 	opr_info+="缴款合计："+document.all.sum_money.value+"元、含赠送话费"+document.all.pay_money.value+"元";

 	/*begin huangrong add 当手机电视功能费，手机上网功能费，WLAN功能费有不为0的时候才展示*/
 	if(document.frm.TVprice.value!="0")
 	{
 		opr_info+="、手机电视功能费"+document.all.TVprice.value+"元";
 	}
 	if(document.frm.phoneNetPrice.value!="0" && document.frm.wlanPrice.value!="0")
 	{
 		opr_info+="、手机上网功能费"+document.all.phoneNetPrice.value+"、WLAN功能费"+document.all.wlanPrice.value+"元";
 	}else
 	{
	 	if(document.frm.phoneNetPrice.value!="0")
	 	{
	 		opr_info+="、手机上网功能费"+document.all.phoneNetPrice.value+"元";
	 	}
	 	if(document.frm.wlanPrice.value!="0")
	 	{
	 		opr_info+="、WLAN功能费"+document.all.wlanPrice.value+"元";
	 	} 		
 	}
 	opr_info+="|";	

 	/*end huangrong add 当手机电视功能费，手机上网功能费，WLAN功能费有不为0的时候才展示*/	


	retInfo+=" "+"|";
	retInfo+=" "+"|";
	retInfo+=" "+"|";
	retInfo+=" "+"|";
	
	
	retInfo+="      备注："+document.all.opNote.value+"|";
  	if(document.all.chg_flag.value == "1")//按月返回，累计下月
	{
		note_info1+="备注：赠送的预存话费分"+document.all.consume_term.value+"个月返还,每月返还1/"+document.all.consume_term.value+",如"+document.all.consume_term.value+"个月内(含购机当月)没有消费完,系统将一次性收回剩余话费。本次活动赠送您的预存款不退不转。如您当前已享受其他优惠的专款，您所发生的费用将优先从其他的优惠专款中支付。赠送的预存款不能用于办理其他专款类业务（如包年、赠机类活动等）。参与手机销售活动所获赠的话费未消费完，不能办理销户业务。"+"|";	
   		note_info1+="提示：赠送的预存话费将在每月1日8时前赠送，如您在话费赠送前是欠费状态，则当日不能使用这部分预存话费，需等到次日凌晨以后方可使用；如果您当日自行缴费，补足欠费，则当日可使用赠送的预存话费。"+"|";
   		note_info1+="业务到期前若申请取消，按违约规定您以优惠价购买的手机将按手机原价补交差额，并按剩余预存款的30%交纳违约金。"+"|";
   		note_info1+="未涉及的资费，按现行的移动电话资费标准执行。本次活动手机适用中国移动业务。在协议有效期内若遇国家资费标准调整，按国家新的资费政策执行。"+"|";
	}
	else if(document.all.chg_flag.value == "2") //拆包
	{
		note_info2+="1、业务有效期12个月（含办理当月），赠送话费每月最多允许使用总额的1/12，办理当月即可开始使用，超额发生的话费请您另行交纳。话费要求18个月（含办理当月）内消费完毕，消费不完，公司将在第19个月的第一天一次性扣除。2、参与手机优惠活动而赠送的话费不退不转，未消费完，不能办理销户业务。业务未结束前，不能重复办理该业务及其他签约类终端营销案。您的预存款账户如同时有其他同类专款，将优先消费其他专款。3、如在本业务到期前申请取消，您需要补交购买手机时的零售价格（零售价格以当时营业厅购机赠礼营销案中手机价格为准）与优惠购买价之间的差额，并交纳申请办理取消业务时剩余预存话费30%的违约金。"+"|";
		note_info2+="特别提示：您本次活动办理的手机号码和手机必须在一起使用，如手机与手机卡分开使，则隔月预存话费不返还。"+"|";
		note_info2+=" "+"|";
		note_info2+=" "+"|";
	}
 	/* ningtn IMEI重新绑定需求*/
 	note_info1 += "如您因手机丢失或人为损坏等个人原因无法使用而造成机卡分离，请到营业厅重新购机，否则将不能继续使用剩余话费。" + " |";
  	if(document.all.award_flag.value == "1")
	{
		note_info3+= "已参与赠送礼品活动"+"|";
	}
	else
	{
		retInfo+= " "+"|";
	}
   	retInfo+=" "+"|";
	retInfo+=" "+"|";
	retInfo+=" "+"|";
	retInfo+=" "+"|";
	retInfo+=" "+"|";
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
        //alert("test "+GroupArray[x]+" and ");
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
 
 	var myEle1 ;
   	var x1 ;
   	for (var q1=document.all.sale_code.options.length;q1>=0;q1--) document.all.sale_code.options[q1]=null;
   	myEle1 = document.createElement("option") ;
    	myEle1.value = "";
        myEle1.text ="--请选择--";
        document.all.sale_code.add(myEle1) ;
   	for ( x1 = 0 ; x1 < arrsaletype.length  ; x1++ )
   	{		//alert(arrsaletype[x1]);
   		//alert(document.all.phone_type.value);
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
		salechage();		
 }
 function salechage(){ 
	var getNote_Packet = new AJAXPacket("f7955_getprepay.jsp","正在获得营销明细，请稍候......");
  getNote_Packet.data.add("retType","getcard");
	getNote_Packet.data.add("agentCode",document.all.agent_code.value);
	getNote_Packet.data.add("phoneType",document.all.phone_type.value);
	getNote_Packet.data.add("saletype","17");
	getNote_Packet.data.add("regionCode","<%=regionCode%>");
	getNote_Packet.data.add("salecode",document.all.sale_code.value);
	core.ajax.sendPacket(getNote_Packet);
	getNote_Packet =null; 
 }


 function checkAward()
 {
 	 if(document.all.phone_type.value == "")
 	 {
 	 	 alert("请先选择机型");
 	 	 document.all.need_award.checked = false;
 	 	 document.all.award_flag.value = 0;
 	 	 return;
 	 }
 	 if(document.all.need_award.checked )
 	 {
 	var packet = new AJAXPacket("phone_getAwardRpc.jsp","正在获得奖品明细，请稍候......");
  packet.data.add("retType","checkAward");
  packet.data.add("op_code","7955");
  packet.data.add("style_code",document.all.phone_type.value);
	core.ajax.sendPacket(packet);
	packet =null; 
 	 }
 	 document.all.award_flag.value = 0;
 	 
 }

//-->
</script>



</head>


<body >
<form name="frm" method="post" action="f7955Cfm.jsp" onKeyUp="chgFocus(frm)">
	<%@ include file="/npage/include/header.jsp" %>  
     <div class="title">
		<div id="title_zi">购机赠话费（按月返还）</div>
	 </div>					
			<div id="showMsg"></div>			
        <table  >
		  <tr > 
            <td class="blue">操作类型：</td>
            <td class="blue">购机赠话费（按月返还）--申请</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
          </tr>
          <tr > 
            <td class="blue">客户姓名:</td>
            <td>
			  <input name="cust_name" value="<%=bp_name%>" type="text"   Class="InputGrey" v_must=1 readonly id="cust_name" maxlength="20" v_name="姓名"> 
			  <font class='orange'>*</font>
            </td>
            <td class="blue">客户地址:</td>
            <td>
			  <input name="cust_addr" value="<%=bp_add%>" type="text"  Class="InputGrey"  v_must=1 readonly id="cust_addr" maxlength="20" > 
			  <font class='orange'>*</font>
            </td>
            </tr>
            <tr > 
            <td class="blue">证件类型:</td>
            <td>
			  <input name="cardId_type" value="<%=cardId_type%>" type="text"  Class="InputGrey" v_must=1 readonly id="cardId_type" maxlength="20" > 
			  <font class='orange'>*</font>
            </td>
            <td class="blue">证件号码:</td>
            <td>
			  <input name="cardId_no" value="<%=cardId_no%>" type="text"  Class="InputGrey" v_must=1 readonly id="cardId_no" maxlength="20" > 
			  <font class='orange'>*</font>
            </td>
            </tr>
            <tr > 
            <td class="blue">业务品牌:</td>
            <td>
			  <input name="sm_code" value="<%=sm_code%>" type="text"  Class="InputGrey" v_must=1 readonly id="sm_code" maxlength="20" > 
			  <font class='orange'>*</font>
            </td>
            <td class="blue">运行状态:</td>
            <td>
			  <input name="run_type" value="<%=run_name%>" type="text"  Class="InputGrey"  v_must=1 readonly id="run_type" maxlength="20" > 
			  <font class='orange'>*</font>
            </td>
            </tr>
            <tr > 
            <td class="blue">VIP级别:</td>
            <td>
			  <input name="vip" value="<%=vip%>" type="text"  v_must=1  Class="InputGrey" readonly id="vip" maxlength="20" > 
			  <font class='orange'>*</font>
            </td>
            <td class="blue">可用预存:</td>
            <td>
			  <input name="prepay_fee" value="<%=prepay_fee%>" type="text"  Class="InputGrey" v_must=1 readonly id="prepay_fee" maxlength="20" > 
			  <font class='orange'>*</font>
            </td>
            </tr>
             <tr > 
            <td class="blue">手机品牌:</td>
            <td>
			  <SELECT id="agent_code" name="agent_code" v_must=1  
			  	onchange="selectChange(this, phone_type, arrPhoneName, arrAgentCode);" v_name="手机代理商">  
			    <option value ="">--请选择--</option>
                <%for(int i = 0 ; i < agentCodeStr.length ; i ++){%>
                <option value="<%=agentCodeStr[i][0]%>"><%=agentCodeStr[i][1]%></option>
                <%}%>
              </select>
			  <font class='orange'>*</font>	
			</td>
	 <td class="blue">手机型号：</td>
            <td>
			  <select size=1 name="phone_type" id="phone_type" v_must=1 v_name="手机型号" onchange="typechange()">	
			  	  
              </select>
			  <font class='orange'>*</font>
			</td>
          </tr>
          <tr > 
         
            <td class="blue">营销方案：
            </td>
            <td>
			  <select size=1 name="sale_code" id="sale_code" v_must=1 v_name="营销代码" onchange="change()">			  
              </select>
			  <font class='orange'>*</font>
			</td>
			<td colspan="2" class="blue">是否参与赠礼<input type="checkbox" name="need_award" onclick="checkAward()" />
				<input type="hidden" name="award_flag" value="0" />
			</td>
            
          </tr>
          <tr > 
            <td  class="blue">购机款：</td>
            <td >
			  <input name="price" type="text"  id="price" v_type="money" v_must=1   Class="InputGrey" readonly v_name="手机价格" >
			  <font class='orange'>*</font>	
			</td>
            <td class="blue">赠送话费：</td>
            <td>
			  <input name="pay_money" type="text"  id="pay_money" v_type="0_9" v_must=1  Class="InputGrey"  v_name="赠送话费" readonly>
			  <font class='orange'>*</font>
			</td>
          </tr>
		  <!--手机电视需求新增 wangdana-->
          <tr > 
            <td class="blue">手机电视功能费：</td>
            <td >
			  <input name="TVprice" type="text"  id="TVprice" v_type="money" v_must=1  Class="InputGrey"  readonly v_name="手机电视功能费" >
			  <font class='orange'>*</font>	
			</td>
            <td class="blue">手机电视消费期限：</td>
            <td>
			  <input name="TVtime" type="text"   id="TVtime" v_type="0_9" v_must=1   Class="InputGrey" v_name="消费时长" readonly>
			  <font class='orange'>*</font>
			</td>
          </tr>
          
					<!--begin huangrong add 上网费，上网费消费月份，WLAN业务费和WLAN业务费消费月份的信息展示 2011-6-29-->
			    <tr> 
			      <td class="blue">手机上网功能费：</td>
			      <td >
						  <input name="phoneNetPrice"  type="text" class="button" id="phoneNetPrice" v_type="money" v_must=1   readonly v_name="手机上网功能费" >
						  <font color="#FF0000">*</font>	
						</td>
			      <td class="blue">手机上网消费期限：</td>
			      <td>
						  <input name="phoneNetTime" type="text"  class="button" id="phoneNetTime" v_type="0_9" v_must=1   v_name="消费时长" readonly>
						  <font color="#FF0000">*</font>
						</td>
			    </tr>            
			    <tr > 
			      <td class="blue">WLAN功能费：</td>
			      <td >
						  <input name="wlanPrice" type="text" class="button" id="wlanPrice" v_type="money" v_must=1   readonly v_name="WLAN业务费" >
						  <font color="#FF0000">*</font>	
						</td>
			      <td class="blue">WLAN消费期限：</td>
			      <td>
						  <input name="wlanTime" type="text"  class="button" id="wlanTime" v_type="0_9" v_must=1   v_name="消费时长" readonly>
						  <font color="#FF0000">*</font>
						</td>
			    </tr>                  
				  <!--end huangrong add 上网费，上网费消费月份，WLAN业务费和WLAN业务费消费月份的信息展示 2011-6-29-->          

          <tr > 
            <td class="blue">应付金额：</td>
            <td >
			  <input name="sum_money" type="text"  id="sum_money"  Class="InputGrey" readonly>
			  <font class='orange'>*</font>
			  <input name="mach_fee" type="hidden"  id="mach_fee"  Class="InputGrey" readonly>
			</td>
            <td class="blue">活动期限：</td>
            <td>
			  <input name="consume_term" type="text"   id="consume_term" v_type="0_9" v_must=1   v_name="活动期限"  Class="InputGrey" readonly>
			  <input name="chg_flag" type="hidden"   id="chg_flag" v_type="0_9" v_must=1  Class="InputGrey" readonly>
			  (个月)<font class='orange'>*</font>
			</td>
          </tr> 
      <!-- tianyang add for pos start -->
			<tr > 
				<td class="blue">缴费方式：
				</td>
				<td>
					<select name="payType" >
						<option value="0">现金缴费</option>
						<option value="BX">建设银行POS机缴费</option>
						<option value="BY">工商银行POS机缴费</option>
					</select>
					<font class='orange'>*</font>
				</td>
				<TD >&nbsp;</TD>
        <TD >&nbsp;</TD>
			</tr>
      <!-- tianyang add for pos end -->
         <TR > 
			<TD  nowrap> 
				<div align="left" class="blue">IMEI码：</div>
            </TD>
            <TD > 
				<input name="IMEINo" id="IMEINo" type="text" v_type="0_9" v_name="IMEI码"  maxlength=15 value="" onblur="viewConfirm()">
				<input name="checkimei" class="b_text" type="button" value="校验" onclick="checkimeino()">
                <font class='orange'>*</font>
            </TD>
			<TD>
			</td>
			<td>
			</td>
          </TR>
		  <TR  id=showHideTr > 
			<TD  nowrap> 
				<div align="left" class="blue">付机时间：</div>
            </TD>
			<TD > 
				<input name="payTime"  type="text" v_name="付机时间"  value="<%=new java.text.SimpleDateFormat("yyyyMMdd", Locale.getDefault()).format(new java.util.Date())%>">
				(年月日)<font class='orange'>*</font>                  
			</TD>
			<TD  nowrap> 
				<div align="left" class="blue">保修时限: </div>
			</TD>
			<TD > 
				<input name="repairLimit" v_type="date.month"  size="10" type="text" v_name="保修时限" value="12" onblur="viewConfirm()">
				(个月)<font class='orange'>*</font>
			</TD>
          </TR>
		  <tr > 
            <td height="32"  class="blue">备注：</td>
            <td colspan="3" height="32">
             <input name="opNote" type="text"  id="opNote" size="60" maxlength="60" value="购机赠话费（按月返还）" > 
            </td>
          </tr>
          <tr > 
            <td colspan="4"> <div align="center"> 
                <input name="confirm" type="button" class="b_foot" index="2" value="确认&打印" onClick="printCommit()" disabled >
                &nbsp; 
                <input name="reset" type="reset" class="b_foot" value="清除" >
                &nbsp; 
                <input name="back" onClick="history.go(-1)" type="button" class="b_foot" value="返回">
                &nbsp; </div></td>
          </tr>
        </table>
  <p>&nbsp;</p>
  <p>&nbsp;</p>
  <p>&nbsp;</p>  
  </td>
  </tr>
  </table>	
  <input type="hidden" name="banlitype" value="<%=banlitype%>">
    <input type="hidden" name="phone_no" value="<%=phoneNo%>">
    <input type="hidden" name="work_no" value="<%=loginName%>">
	<input type="hidden" name="opcode" id="opcode" value="<%=opcode%>">
    <input type="hidden" name="login_accept" value="<%=printAccept%>">
    <input type="hidden" name="card_dz" value="0" >
	<input type="hidden" name="sale_type" value="17" >
    <input type="hidden" name="used_point" value="0" >  
	<input type="hidden" name="point_money" value="0" > 
	<input type="hidden" name="phone_typename" value="" >
	<!-- tianyang add at 20100201 for POS缴费需求*****start*****-->		
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
	<!-- tianyang add at 20100201 for POS缴费需求*****end*******-->
	<%@ include file="/npage/include/footer.jsp" %>
</form>
<!-- **** ningtn add for pos @ 20100430 ******加载建行控件页 BankCtrl ******** -->
<%@ include file="/npage/public/posCCB.jsp" %>
<!-- **** ningtn add for pos @ 20100430 ******加载工行控件页 KeeperClient ******** -->
<%@ include file="/npage/public/posICBC.jsp" %>

</body>
</html>

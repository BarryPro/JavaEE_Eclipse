<%
/********************
 version v2.0
开发商: si-tech
update:yanpx@2008-10-08
********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%
  response.setHeader("Pragma","No-cache");
  response.setHeader("Cache-Control","no-cache");
  response.setDateHeader("Expires", 0);
%>
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="../../npage/bill/getMaxAccept.jsp" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%
	String opCode = "1146";     //模块代码
  String opName = "购机赠礼"; //模块名称

  String loginNo = (String)session.getAttribute("workNo");
  String loginName = (String)session.getAttribute("workName");
  String powerCode= (String)session.getAttribute("powerCode");
  String orgCode = (String)session.getAttribute("orgCode");
  String ip_Addr = (String)session.getAttribute("ipAddr");
  String regionCode = orgCode.substring(0,2);
  String loginNoPass = (String)session.getAttribute("password");
  String op_code=request.getParameter("opCode");
  String groupId = (String)session.getAttribute("groupId");
	String payType="",Response_time="",TerminalId="",Rrn="",Request_time="";
%>
<%
  String retFlag="",retMsg="";
  //SPubCallSvrImpl impl = new SPubCallSvrImpl();
  //ArrayList retList = new ArrayList();
  //String[] paraAray1 = new String[4];
  String phoneNo = request.getParameter("srv_no");
  String opcode = request.getParameter("opcode");
  String backaccept= request.getParameter("backaccept");
  String passwordFromSer="";

  /*liyan add at 20090317*/
  String back_type = request.getParameter("back_type");
  System.out.println("back_type="+back_type);
  String new_opCode = opcode;
  if (back_type.equals("1"))
  {
  		new_opCode = "7971"; //裸机销售冲正
  }
  System.out.println("new_opCode="+new_opCode);
  /*liyan add end at 20090317*/

 // paraAray1[0] = phoneNo;		/* 手机号码   */
 // paraAray1[1] = opcode; 	    /* 操作代码   */
 // paraAray1[2] = loginNo;	    /* 操作工号   */
 // paraAray1[3] = backaccept;

  /*****王梅 添加 20060605*****/
  //ArrayList retArray = new ArrayList();
  //String[][] result = new String[][]{};
  //SPubCallSvrImpl callView = new SPubCallSvrImpl();
  String sqlStr = "";
  String awardName="";
  sqlStr = "select award_name from wawardpay where phone_no ='"+phoneNo+"'"+
		    " and login_accept="+backaccept  ;
	//System.out.println(sqlStr);
%>
<wtc:pubselect name="sPubSelect" outnum="1" retmsg="msg1" retcode="code1" routerKey="region" routerValue="<%=regionCode%>">
	<wtc:sql><%=sqlStr%></wtc:sql>
</wtc:pubselect>
<wtc:array id="retArray" scope="end"/>
<%
System.out.println("**************************1");

  if(retArray!=null&& retArray.length > 0){
  	awardName = retArray[0][0];
  	System.out.println("awardName="+awardName);
  %>
  <script language="JavaScript" >

  //rdShowMessageDialog("此用户为已中奖用户，中奖奖品为："<%=awardName%>", 请用户完好无损返回奖品，再继续办理冲正业务！");
   	if(rdShowConfirmDialog("此用户为已中奖用户，中奖奖品为：<%=awardName%> 请用户完好无损返回奖品，再继续办理冲正业务！")!=1)
		{
			location='f1145_login.jsp?activePhone=<%=phoneNo%>';
		}
	</script>

<%}
  //sunzx add at 20070904
  sqlStr = "select res_info from wawarddata where flag = 'Y' and phone_no = '"+phoneNo+"'"+
		    " and login_accept="+backaccept  ;

  //retArray = callView.sPubSelect("1",sqlStr);
%>
<wtc:pubselect name="sPubSelect" outnum="1" retmsg="msg1" retcode="code1" routerKey="region" routerValue="<%=regionCode%>">
	<wtc:sql><%=sqlStr%></wtc:sql>
</wtc:pubselect>
<wtc:array id="retArray" scope="end"/>
<%
	System.out.println("**************************2");
  if(retArray != null && retArray.length > 0)
  {
  	System.out.println("123");
	  awardName = retArray[0][0];

	  System.out.println("awardName2="+awardName);

  	if(!awardName.equals("")){
%>
		  <script type="text/javascript" src="../../js/common/redialog/redialog.js"></script>
		  <script language="JavaScript" >

		  rdShowMessageDialog("此用户已在促销品统一付奖中进行<%=awardName%>领奖，请进行促销品统一付奖冲正，并确保奖品完好",1);
			location='f1145_login.jsp?activePhone=<%=phoneNo%>';
			</script>
<%	}
	}
	//sunzx add end
/*liyan add at 20090317 将第二个参数opcode改为new_opCode */
%>
<wtc:service  name="s1142Qry" routerKey="phone" routerValue="<%=phoneNo%>" outnum="29"  retcode="errCode" retmsg="errMsg">
	<wtc:param  value=""/>
	<wtc:param  value="01"/>
	<wtc:param  value="<%=new_opCode%>"/>
	<wtc:param  value="<%=loginNo%>"/>
	<wtc:param  value="<%=loginNoPass%>"/>
	<wtc:param  value="<%=phoneNo%>"/>
	<wtc:param  value=""/>
	<wtc:param  value="<%=backaccept%>"/>
</wtc:service>
<wtc:array id="retList" scope="end"/>
<%

 /* 输出参数： 返回码，返回信息，客户姓名，客户地址，证件类型，证件号码，业务品牌，
 			归属地，当前状态，VIP级别 ，当前积分，用户预存，
 			营销方案名，应付金额，卡金额，卡张数串，赠送话费，销费积分数
 */
  String bp_name="",bp_add="",cardId_type="",cardId_no="",sm_code="",region_name="",run_name="",vip="",posint="",prepay_fee="";
  String sale_name="",sum_money="",scard_money="",card_num="",pay_money="",used_point="",card_money="",type_name="";
  String vspec_name="",vmode_code="",vused_date="",vspec_fee="";

	/**
	 for(int i=0;i<retList.length;i++){
	 	for(int m=0;m<retList[i].length;m++){
	 		System.out.println("##################retList["+i+"]["+m+"]--->"+retList[i][m]);
	 	}
	 }
	 */
System.out.println("**************************3");
  if(retList == null)
  {
	if(!retFlag.equals("1"))
	{
		 System.out.println("retFlag="+retFlag);
	   retFlag = "1";
	   retMsg = "s12fbInit查询号码基本信息为空!<br>errCode: " + errCode + "<br>errMsg+" + errMsg;
    }
  }else if(!(retList == null))
  {System.out.println("errCode="+errCode);
  System.out.println("errMsg="+errMsg);
  if(!errCode.equals("000000")&&!errCode.equals("0") ){%>
<script language="JavaScript">
<!--
  	rdShowMessageDialog("错误代码：<%=errCode%>错误信息：<%=errMsg%>");
  	 history.go(-1);
  	//-->
  </script>
  <%}
  System.out.println("**************************4");
	if (errCode.equals("000000")||errCode.equals("0")){
	System.out.println("**************************%%%%%");
	  bp_name =retList[0][2];
	  bp_add = retList[0][3];
	  cardId_type = retList[0][4];
	  cardId_no = retList[0][5];
	  sm_code = retList[0][6];
	  region_name = retList[0][7];
	  run_name = retList[0][8];
	  vip = retList[0][9];
	  posint = retList[0][10];
	  prepay_fee = retList[0][11];
	   sale_name = retList[0][12];
	   sum_money = retList[0][13];
	  scard_money = retList[0][14];
	  card_num = retList[0][15];
	   pay_money = retList[0][16];
	  used_point = retList[0][17];
	  card_money = retList[0][18];
	  type_name = retList[0][19];
	  vspec_name = retList[0][20];
	  vused_date = retList[0][21];
	  vspec_fee = retList[0][22];
	  if(vspec_fee.equals("")){vspec_fee="0";}
	  vmode_code = retList[0][23];

		    ///////<!-- ningtn add for pos start @ 20100520 -->
				if(retList[0][24] != null && retList[0][24].trim().length() > 0){
					payType = retList[0][24].trim();
				}else{
					payType = "0";
				}
				Response_time = retList[0][25].trim();
				TerminalId = retList[0][26].trim();
				Rrn = retList[0][27].trim();
				Request_time = retList[0][28].trim();
				
				System.out.println("payType : " + payType);
				System.out.println("Response_time : " + Response_time);
				System.out.println("TerminalId : " + TerminalId);
				System.out.println("Rrn : " + Rrn);
				System.out.println("Request_time : " + Request_time);
				///////<!-- ningtn add for pos end @ 20100520 -->

	  pay_money=""+(Float.parseFloat(pay_money)-Float.parseFloat(vspec_fee));
	  /*pay_money=""+(Integer.parseInt(pay_money)-Integer.parseInt(vspec_fee));*/
	}else{
		//if(!retFlag.equals("1"))
		//{
		  // retFlag = "1";
	      // retMsg = "s126bInit查询号码基本信息失败!<br>errCode: " + errCode + "<br>errMsg: " + errMsg;
		//}
	}
  }

%>
 <%  //优惠信息//********************得到营业员权限，核对密码，并设置优惠权限*****************************//
  String Handfee_Favourable = "readonly";        //a230  手续费
System.out.println("**************************5");
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
<html>
<head>
<title><%=opName%></title>
<META content="no-cache" http-equiv="Pragma">
<META content="no-cache" http-equiv="Cache-Control">
<META content="0" 	     http-equiv="Expires" >
<meta http-equiv="Content-Type" content="text/html; charset=GBK">


 <script language=javascript>

 function doProcess(packet){

 	var retType = packet.data.findValueByName("retType");
    	var retCode = packet.data.findValueByName("retCode");
    	var retMessage = packet.data.findValueByName("retMessage");

    	if(retCode!=0){
    		rdShowMessageDialog(retMessage);
    		return ;
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




<%
/*
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
	out.println("arrsalebarnd["+l+"]='"+saleTypeStr[l][2]+"';\n");
	out.println("arrsaletype["+l+"]='"+saleTypeStr[l][3]+"';\n");

  }
  */
%>

  //***
  function frmCfm(){
 		/* ningtn add for pos start @ 20100520 */
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
			  /* ningtn add for pos end @ 20100520 */
  }
  /* ningtn add for pos start @ 20100520 */
	function posSubmitForm(){
		frm.submit();
		return true;
	}
	function getSysDate()
	{
		var myPacket = new AJAXPacket("../public/pos_getSysDate.jsp","正在获得系统时间，请稍候......");
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
	/* ningtn add for pos start @ 20100520 */
 //***
 function printCommit()
 {
 	getAfterPrompt();
  //校验
  //if(!check(frm)) return false;

  with(document.frm){

	opNote.value=phone_no.value+"办理"+opNote.value+"业务";
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
	var h=188;
	var w=350;
	var t=screen.availHeight/2-h/2;
	var l=screen.availWidth/2-w/2;
	var pType="subprint";
	var billType="1"; //1免填单 3收据 2发票
	var printStr = printInfo(printType);
	var sysAccept = document.all.login_accept.value;

	var mode_code=null;
	var fav_code=null;
	var area_code=null

	var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no";
	var path = "<%=request.getContextPath()%>/npage/innet/hljBillPrint_jc_hw.jsp?DlgMsg=" + DlgMessage;
	var path = path + "&mode_code="+mode_code+"&fav_code="+fav_code+"&area_code="+area_code+"&opCode=<%=opCode%>&sysAccept="+sysAccept+"&phoneNo=<%=phoneNo%>&submitCfm=" + submitCfm+"&pType="+pType+"&billType="+billType+ "&printInfo=" + printStr ;
	var ret=window.showModalDialog(path,printStr,prop);
	//alert(path);
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

	cust_info+="手机号码：    "+document.all.phone_no.value+"|";
	cust_info+="客户姓名：   "+document.all.cust_name.value+"|";
	cust_info+="客户地址：    "+document.all.cust_addr.value+"|";
	cust_info+="证件号码：   "+document.all.cardId_no.value+"|";

	if (<%=new_opCode%> =="1146")
	{
		opr_info+="业务类型：购机赠礼冲正"+"|";
	}
	else if(<%=new_opCode%> =="7971")
	{
		opr_info+="业务类型：捆绑营销案重新购空机冲正"+"|";
	}
	opr_info+="业务流水："+document.all.login_accept.value+"|";
	opr_info+="手机型号: "+document.all.type_name.value+"|";

	//retInfo+=document.all.work_no.value+' '+'<%=loginName%>'+"|";
	//retInfo+='<%=new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss", Locale.getDefault()).format(new java.util.Date())%>'+"|";
	//retInfo+="用户号码："+document.all.phone_no.value+"|";
	//retInfo+="用户姓名："+document.all.cust_name.value+"|";
	//retInfo+="用户地址："+document.all.cust_addr.value+"|";
	//retInfo+="证件号码："+document.all.cardId_no.value+"|";
	//retInfo+=" "+"|";
	//retInfo+=" "+"|";
	//retInfo+=" "+"|";
	//retInfo+=" "+"|";
	//retInfo+="业务类型：购机赠礼冲正"+"|";
  	//retInfo+="业务流水："+document.all.login_accept.value+"|";
  	//retInfo+="手机型号: "+document.all.type_name.value+"|";

  	//if(parseInt(document.all.card_money.value,10)==0){
  		//retInfo+="退款合计："+document.all.sum_money.value+"元　含：预存话费"+document.all.pay_money.value+"元"+"|";
  	//}else{
  		//retInfo+="退款合计："+document.all.sum_money.value+"元　含：预存话费"+document.all.pay_money.value+"元，含"+document.all.cardy.value+"|";
	//}

	var jkinfo="";
	if(parseInt(document.all.card_money.value,10)==0){
		jkinfo="退款合计："+document.all.sum_money.value+"元 含：预存话费"+document.all.pay_money.value+"元";
	}else{
		jkinfo+="退款合计："+document.all.sum_money.value+"元 含：预存话费"+document.all.pay_money.value+"元，"+document.all.cardy.value;
	}
	if(document.all.spec_fee.value!="0"){
		jkinfo+="，"+(document.all.spec_name.value).trim();
	}
	//retInfo+=jkinfo+"|";
	opr_info+=jkinfo+"|";

	//retInfo+=" "+"|";
	//retInfo+=" "+"|";
	//retInfo+=" "+"|";
	//retInfo+=" "+"|";
	//retInfo+=" "+"|";
	//retInfo+=" "+"|";
	//retInfo+=" "+"|";
	//retInfo+=" "+"|";
	//retInfo+=" "+"|";
	//retInfo+=" "+"|";
	//retInfo+=" "+"|";
	//retInfo+=" "+"|";
	//retInfo+=" "+"|";
	//retInfo+=" "+"|";
	//retInfo+=" "+"|";
	//retInfo+=" "+"|";
	//retInfo+=" "+"|";
	//retInfo+=" "+"|";

	//retInfo+="备注：欢迎您参加'购机赠礼'活动，你的话费预存款在未消费完毕前不能退款。"+"|";
	//retInfo+="哈尔滨地区用户自SIM卡售出日起30天内，由于非人为原因引起的SIM卡损坏或因机卡配合"+"|";
	//retInfo+="引起的SIM无法使用，我公司可为您免费补卡。"+"|";
	note_info1+="备注；"+"|";
	//retInfo = cust_info+"#"+opr_info+"#"+note_info1+"#"+note_info2+"#"+note_info3+"#"+note_info4+"#";
	retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
	retInfo=retInfo.replace(new RegExp("#","gm"),"%23");
	//alert(retInfo)
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
<form name="frm" method="post" action="f1146_2.jsp" onKeyUp="chgFocus(frm)">
<%@ include file="/npage/include/header.jsp" %>
	<div class="title">
		<div id="title_zi">用户信息</div>
	</div>
    <table cellspacing="0" >
		  <tr>
	        <td class="blue">操作类型</td>
	        <td>
	        <% if (new_opCode.equals("1146")){%>
			     购机赠礼冲正
			<% }
			else if (new_opCode.equals("7971")) { %>
				 捆绑营销案重新购空机冲正
			<% } %>
	        </td>
	        <td>&nbsp;</td>
	        <td>&nbsp;</td>
      </tr>
      <tr>
          <td class="blue">客户姓名</td>
          <td>
						  <input name="cust_name" value="<%=bp_name%>" type="text" Class="InputGrey" v_must=1 readonly id="cust_name" maxlength="20" v_name="姓名">
          </td>
          <td class="blue">客户地址</td>
          <td>
						  <input name="cust_addr" value="<%=bp_add%>" type="text" Class="InputGrey" v_must=1 readonly id="cust_addr" maxlength="20" >
          </td>
       </tr>
       <tr>
           <td class="blue">证件类型</td>
           <td>
						  <input name="cardId_type" value="<%=cardId_type%>" type="text" Class="InputGrey" v_must=1 readonly id="cardId_type" maxlength="20" >
           </td>
	         <td class="blue">证件号码</td>
	         <td>
						  <input name="cardId_no" value="<%=cardId_no%>" type="text" Class="InputGrey" v_must=1 readonly id="cardId_no" maxlength="20" >
           </td>
           </tr>
       <tr>
           <td class="blue">业务品牌</td>
           <td>
						  <input name="sm_code" value="<%=sm_code%>" type="text" Class="InputGrey" v_must=1 readonly id="sm_code" maxlength="20" >
           </td>
           <td class="blue">运行状态</td>
			     <td>
						  <input name="run_type" value="<%=run_name%>" type="text" Class="InputGrey" v_must=1 readonly id="run_type" maxlength="20" >
            </td>
      </tr>
      <tr>
            <td class="blue">VIP级别</td>
            <td>
							  <input name="vip" value="<%=vip%>" type="text" Class="InputGrey" v_must=1 readonly id="vip" maxlength="20" >
							  <font class="orange">*</font>
            </td>
            <td class="blue">可用预存</td>
            <td>
							  <input name="prepay_fee" value="<%=prepay_fee%>" type="text" Class="InputGrey" v_must=1 readonly id="prepay_fee" maxlength="20" >
							  <font class="orange">*</font>
            </td>
      </tr>
   </table>
</div>
<div id="Operation_Table">
<div class="title">
<div id="title_zi">业务办理</div>
</div>
   <table cellspacing="0">
      <tr>
            <td class="blue">营销方案 </td>
            <td colspan="3">
							  <input type="text" name="sale_code" size="60" readonly id="sale_code"  v_name="营销代码" value="<%=sale_name%>" >
							  <font class="orange">*</font>
						</td>
      </tr>
       <tr>
             <td class="blue">赠送卡类金额</td>
            <td>
							  <input name="card_money" type="text"  id="card_money" v_type="money" v_must=1   readonly v_name="卡类金额" value="<%=card_money%>" >
							  <font class="orange">*</font>
						</td>
            <td class="blue">赠送话费</td>
            <td>
							  <input name="pay_money" type="text"   id="pay_money" v_type="0_9" v_must=1   v_name="赠送话费" readonly value="<%=pay_money%>">
							  <font class="orange">*</font>
						</td>
       </tr>

        <tr>

            <td class="blue">赠送卡类信息</td>
            <td colspan="3">
			  				<input type="text" name="card_info"  size="80" id="card_info"  readonly v_name="赠送卡类信息" value="<%=card_num%>">
			  				<font class="orange">*</font>
						</td>

        </tr>
        <tr>
            <td class="blue">赠送数据业务</td>
            <td>
			  				<input type="text" name="spec_name"   id="spec_name" value="<%=vspec_name%>" readonly v_name="赠送数据业务" >
							  <font class="orange">*</font>
						</td>
            <td class="blue">金额</td>
            <td>
							  <input type="text" name="spec_fee"   id="spec_fee"  value="<%=vspec_fee%>" readonly v_name="金额" >
							  <font class="orange">*</font>
						</td>
       </tr>
       <tr>
            <td class="blue">到期时间</td>
            <td>
							  <input name="used_date" type="text"  id="used_date"   value="<%=vused_date%>"  readonly v_name="到期时间" >
							  <font class="orange">*</font>
						</td>
            <td>&nbsp;</td>
            <td>
							  <input name="mode_code" type="hidden"   id="mode_code"   value="<%=vmode_code%>"  v_name="套餐代码" readonly>
							  <font class="orange"></font>
						</td>
       </tr>
          <tr>
            <td class="blue">应付金额</td>
            <td>
						  <input name="sum_money" type="text"  id="sum_money" readonly value="<%=sum_money%>">
						  <font class="orange">*</font>
						</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
          </tr>
          <tr>
            <td class="blue" >备注</td>
            <td colspan="3">
            	 <% if (new_opCode.equals("1146")){%>
			     <input name="opNote" type="text"  id="opNote" size="60" maxlength="60" value="购机赠礼冲正" >
			<% }
			else if (new_opCode.equals("7971")) { %>
             <input name="opNote" type="text"  id="opNote" size="60" maxlength="60" value="捆绑营销案重新购空机冲正" >
            <% } %>
            </td>
          </tr>
          <tr>
            <td colspan="4" align="center">
                <input name="confirm" type="button" class="b_foot" index="2" value="确认&打印" onClick="printCommit()">
                <input name="reset" type="reset" class="b_foot" value="清除" >
                <input name="back" onClick="history.go(-1)" type="button" class="b_foot" value="返回">
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
		<input type="hidden" name="op_code" value="<%=op_code%>" >
		<input type="hidden" name="new_opCode" value="<%=new_opCode%>">
		<!-- ningtn add for pos start @ 20100520 -->
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
		<!-- ningtn add for pos start @ 20100520 -->
    <%@ include file="/npage/include/footer.jsp" %>
</form>
</body>
<%@ include file="/npage/public/hwObject.jsp" %> 
<!-- **** ningtn add for pos @ 20100520 ******加载建行控件页 BankCtrl ******** -->
<%@ include file="/npage/public/posCCB.jsp" %>
<!-- **** ningtn add for pos @ 20100520 ******加载工行控件页 KeeperClient ******** -->
<%@ include file="/npage/public/posICBC.jsp" %>
</html>



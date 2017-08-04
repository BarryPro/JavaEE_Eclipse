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
  		String opCode = "7956";
		String opName = "购机赠话费（按月返还）冲正";
	    
	String loginName = WtcUtil.repNull((String)session.getAttribute("workName"));	
	String loginNo = WtcUtil.repNull((String)session.getAttribute("workNo"));
  String powerCode= WtcUtil.repNull((String)session.getAttribute("powerCode")); 
  String orgCode = WtcUtil.repNull((String)session.getAttribute("orgCode"));
  String ip_Addr = WtcUtil.repNull((String)session.getAttribute("ipAddr")); 
  String regionCode = WtcUtil.repNull((String)session.getAttribute("regCode"));
  String loginNoPass = ((String)session.getAttribute("password"));       
  /**** tianyang add for pos start ****/
  String groupId = WtcUtil.repNull((String)session.getAttribute("groupId"));
  System.out.println("groupId="+groupId);
  /**** tianyang add for pos end ****/
  /* ningtn pos 隔日冲正 */
	String cccTime=new java.text.SimpleDateFormat("yyyyMMdd", Locale.getDefault()).format(new java.util.Date());
	/* 是否隔日冲正的标识  -1隔日冲正 ; 0当日冲正 */
	int isNextDay = 999;
%>
<%

String retFlag="",retMsg="";
  ArrayList retList = new ArrayList();
  String[] paraAray1 = new String[8];
  String phoneNo = request.getParameter("srv_no");
  String opcode = request.getParameter("opcode");
  String backaccept = request.getParameter("backaccept");
  String passwordFromSer="";
%>
<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="phone" routerValue="<%=phoneNo%>" id="printAccept"/>
<%
  
  paraAray1[0] = phoneNo;		/* 手机号码   */ 
  paraAray1[1] = opcode; 	    /* 操作代码   */
  paraAray1[2] = loginNo;	    /* 操作工号   */
  paraAray1[3] = backaccept;	    /* 操作流水   */
  paraAray1[4] = "01";          /* 渠道       */
  paraAray1[5] = loginNoPass; /* 工号密码   */
  paraAray1[6] = "";          /* 手机密码   */
  paraAray1[7] = printAccept; /* 新流水   */
/*****王梅 添加 20060605*****/
  ArrayList retArray = new ArrayList();
  String[][] result = new String[][]{};
  String sqlStr = "";
  String awardName="";
  sqlStr = "select award_name from wawardpay where phone_no ='"+phoneNo+"'"+
		    " and login_accept="+backaccept ;
		%>
		<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>" retcode="RetCode1" retmsg="RetMsg1" outnum="1">
	<wtc:sql><%=sqlStr%></wtc:sql>
</wtc:pubselect>
<wtc:array id="result11" scope="end" />
		<%
	if(result11.length>0) {
  result = result11;
  awardName = result[0][0];	
  System.out.println("awardName="+awardName);
  }
  
  

  if(!awardName.equals("")){
  %>
<script type="text/javascript" src="../../js/common/redialog/redialog.js"></script>	
<script language="JavaScript" >


   if(rdShowConfirmDialog("此用户为已中奖用户，中奖奖品为：<%=awardName%> 请用户完好无损返回奖品，再继续办理冲正业务！")!=1)
	{	
		location='f7955_login.jsp?activePhone=<%=paraAray1[0]%>';
	}
	  
	</script>
  
<%}


  /*sunzx add at 20070904  */
  sqlStr = "select res_info from wawarddata where flag = 'Y' and phone_no = '"+phoneNo+"'"+
		    " and login_accept="+backaccept  ;
		

  %>
  	<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>" retcode="RetCode1" retmsg="RetMsg1" outnum="1">
	<wtc:sql><%=sqlStr%></wtc:sql>
</wtc:pubselect>
<wtc:array id="result22" scope="end" />
  <%
  if(result22.length>0)
  {
	  result = result22;
	  awardName = result[0][0];	
	  
	  System.out.println("awardName2="+awardName);
	
	  if(!awardName.equals("")){
%>
		  <script type="text/javascript" src="../../js/common/redialog/redialog.js"></script>	
		  <script language="JavaScript" >
		
		  rdShowMessageDialog("此用户已在促销品统一付奖中进行<%=awardName%>领奖，请进行促销品统一付奖冲正，并确保奖品完好");
			location='f7955_login.jsp?activePhone=<%=paraAray1[0]%>';
			</script>
<%	}
	}
	//sunzx add end

  /*****王梅 添加 20060605*******/
  for(int i=0; i<paraAray1.length; i++)
  {		
	if( paraAray1[i] == null )
	{
	  paraAray1[i] = "";
	  
	}
  }
 /* 输出参数： 返回码，返回信息，客户姓名，客户地址，证件类型，证件号码，业务品牌，
 			归属地，当前状态，VIP级别，当前积分,可用预存
 			上网费，上网费消费月份，WLAN业务费和WLAN业务费消费月份
 			//huangrong update s1142Qry出参的个数 31-->35
 */

  //retList = impl.callFXService("s1142Qry", paraAray1, "31","phone",phoneNo);
  
  %>
  
  <wtc:service name="s1142Qry" routerKey="phone" routerValue="<%=phoneNo%>"  retcode="errCode" retmsg="errMsg"  outnum="35" >
	<wtc:param value="<%=paraAray1[7]%>"/>
	<wtc:param value="<%=paraAray1[4]%>"/>
	<wtc:param value="<%=paraAray1[1]%>"/>
	<wtc:param value="<%=paraAray1[2]%>"/>
	<wtc:param value="<%=paraAray1[5]%>"/>
	<wtc:param value="<%=paraAray1[0]%>"/>
	<wtc:param value="<%=paraAray1[6]%>"/> 
	<wtc:param value="<%=paraAray1[3]%>"/>
	</wtc:service>
	<wtc:array id="result22222" scope="end" />
  
  
  
  
  
  <%
  String bp_name="",bp_add="",cardId_type="",cardId_no="",sm_code="",region_name="",run_name="",vip="",posint="",prepay_fee="",sale_name="",sum_pay="",card_no="",card_num="",limit_pay="",use_point="",card_summoney="",mach="",machine_type="" ;
  String payType="",Response_time="",TerminalId="",Rrn="",Request_time="";
  String TVprice ="",TVtime="";
  String phoneNetPrice="",phoneNetTime="",wlanPrice="",wlanTime="";
  String[][] tempArr= new String[][]{};

   if(result22222.length<=0)
  {
	if(!retFlag.equals("1"))
	{
		System.out.println("retFlag="+retFlag);
	   retFlag = "1";
	   retMsg = "s1142Qry查询号码基本信息为空!<br>errCode: " + errCode + "<br>errMsg+" + errMsg;
    }    
  }else 
  {System.out.println("errCode="+errCode);
  System.out.println("errMsg="+errMsg);
  if(!"000000".equals(errCode)){%>
<script language="JavaScript">
<!--
  	rdShowMessageDialog("错误代码：<%=errCode%>错误信息：<%=errMsg%>",0);
  	 history.go(-1);
  	//-->
  </script>
  <%}
else {
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
	    sale_name = tempArr[0][12];//营销方案名
	  }

	  if(!(tempArr==null)){
	    sum_pay = tempArr[0][13];//应付金额
	  }

	  if(!(tempArr==null)){
	    card_no = tempArr[0][14];//卡金额串
	  }

	  if(!(tempArr==null)){
	    card_num = tempArr[0][15];//卡张数串
	  }

	  if(!(tempArr==null)){
	    limit_pay = tempArr[0][16];//预存话费
	  }

	  if(!(tempArr==null)){
	    use_point = tempArr[0][17];//销费积分数
	  }

	  if(!(tempArr==null)){
	    card_summoney = tempArr[0][18];//卡类总金额
	  }
	 
	  if(!(tempArr==null)){
	    machine_type = tempArr[0][19];//机器类型
	  }
	  
	  /**** tianyang add for pos start ****/

	  if(!(tempArr==null)){
	    payType = tempArr[0][24].trim();
	    System.out.println("------payType------"+payType);
	  }

	  if(!(tempArr==null)){
	    Response_time = tempArr[0][25].trim();
	    System.out.println("------Response_time------"+Response_time);
	  }

	  if(!(tempArr==null)){
	    TerminalId = tempArr[0][26].trim();
	    System.out.println("------TerminalId------"+TerminalId);
	  }

	  if(!(tempArr==null)){
	    Rrn = tempArr[0][27].trim();
	    System.out.println("------Rrn------"+Rrn);
	  }

	  if(!(tempArr==null)){
	    Request_time = tempArr[0][28].trim();
	    System.out.println("------Request_time------"+Request_time);
	  }
	  if(Request_time.length() > 0){
			isNextDay = Request_time.substring(0,8).compareTo(cccTime);
		}else{
			isNextDay = 0;
		}
	  /*wangdana add for 手机电视@20100629*/

	  if(!(tempArr==null)){
	    TVprice = tempArr[0][29];//手机电视费
	    System.out.println("TVprice"+TVprice);
	  }
	  else
	  	{
	  		System.out.println("TVprice erro");
	  		}

	  if(!(tempArr==null)){
	    TVtime = tempArr[0][30];//手机电视消费时长
	    System.out.println(TVtime);
	  }

	  /*begin huangrong add for 上网费，上网费消费月份，WLAN业务费和WLAN业务费消费月份 2011-7-4 */  
	  if(!(tempArr==null)){
	    phoneNetPrice = tempArr[0][31];//手机上网功能费
	    System.out.println("phoneNetPrice"+phoneNetPrice);
	  }
	  else
	  	{
	  		System.out.println("phoneNetPrice erro");
	  		}

	  if(!(tempArr==null)){
	    phoneNetTime = tempArr[0][32];//手机上网功能费消费期限
	    System.out.println(phoneNetTime);
	  }	  
	  
	  if(!(tempArr==null)){
	    wlanPrice = tempArr[0][33];//WLAN功能费
	    System.out.println("wlanPrice"+wlanPrice);
	  }
	  else
	  	{
	  		System.out.println("wlanPrice erro");
	  		}

	  if(!(tempArr==null)){
	    wlanTime = tempArr[0][34];//WLAN功能费消费期限
	    System.out.println(wlanTime);
	  }		   
	  /*end huangrong add for 上网费，上网费消费月份，WLAN业务费和WLAN业务费消费月份 2011-7-4 */	  
	  
	  	  
	  /**** tianyang add for pos end ****/
	    
	  

	double mach_fee=0.00;
	double sum=0.00;
	double limit=0.00;
	double TVfee=0.00;
	double phoneNetfee=0.00;
	double wlanfee=0.00;

	sum=Double.parseDouble(sum_pay);
	System.out.println("sum="+sum);
	limit=Double.parseDouble(limit_pay);
	TVfee=Double.parseDouble(TVprice);

	
	//huangrong add 手机上网功能费和wlan功能费
	phoneNetfee=Double.parseDouble(phoneNetPrice);
	wlanfee=Double.parseDouble(wlanPrice);	
	
	mach_fee=sum-limit-TVfee-phoneNetfee-wlanfee;//huangrong update 增加对手机上网功能费和wlan功能费的扣减；
	System.out.println("mach_fee="+mach_fee);
	//mach =String.valueOf(mach_fee);
	DecimalFormat currencyFormatter = new DecimalFormat("0.00");
	currencyFormatter.format(mach_fee);
	System.out.println("mach_fee="+currencyFormatter.format(mach_fee));
	mach=currencyFormatter.format(mach_fee)+"";
	System.out.println("mach="+mach);
	}
  }

%>
 <%    

// **************得到冲正流水***************//
%>
		<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="regioncode" 
			routerValue="<%=regionCode%>"  id="printAccept" />
			<%
			System.out.println(printAccept);
			%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>购机赠话费（按月返还）</title>
<META content="no-cache" http-equiv="Pragma">
<META content="no-cache" http-equiv="Cache-Control">
<META content="0" 	     http-equiv="Expires" > 

<script language="JavaScript">
<!--
var isNextDay = "<%=isNextDay%>";


	function doProcess(packet){
		/*tianyang add for pos缴费 start*/
		var verifyType = packet.data.findValueByName("verifyType");
		if(verifyType=="getSysDate"){
			retType = "getSysDate";			
		}		
		if(retType == "getSysDate")
		{
			var sysDate = packet.data.findValueByName("sysDate");
			document.all.Request_time.value = sysDate;
			return ;
		}
		/**** tianyang add for pos end ****/
	}



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
  
  function frmCfm(){
	  	if(document.all.payType.value=="BX" && isNextDay == "0")
	  	{
	    		/*set 输入参数*/
					var transerial    = "000000000000";  	                     //交易唯一号 ，将会取消
					var trantype      = "01";                                  //交易类型
					var bMoney        = "<%=sum_pay%>";					 							 //缴费金额
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
			else if(document.all.payType.value=="BY" && isNextDay == "0")
			{
					var transType     = "04";																	/*交易类型 */         
					var bMoney        = "<%=sum_pay%>";							          /*交易金额 */         
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
  }
 //***
 function printCommit()
 { 
  //校验
  //if(!check(frm)) return false;
  
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
   var path = "<%=request.getContextPath()%>/npage/innet/hljPrint.jsp?DlgMsg=" + DlgMessage;
   var path = path + "&printInfo=" + printStr + "&submitCfm=" + submitCfm;
   var ret=window.showModalDialog(path,"",prop);
   return ret;    
   */
   	var pType="subprint";             				 		//打印类型：print 打印 subprint 合并打印
		var billType="1";              				 			//票价类型：1电子免填单、2发票、3收据
		var sysAccept =<%=printAccept%>;             			//流水号
		var printStr = printInfo(printType);			 		//调用printinfo()返回的打印内容
		var mode_code=null;           							//资费代码
		var fav_code=null;                				 		//特服代码
		var area_code=null;             				 		//小区代码
		var opCode="7956" ;                   			 		//操作代码
		var phoneNo="<%=phoneNo%>";                  	 		//客户电话
		var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no";
		var path = "<%=request.getContextPath()%>/npage/innet/hljBillPrint_jc_hw.jsp?DlgMsg=" + DlgMessage;
		path+="&mode_code="+mode_code+
			"&fav_code="+fav_code+"&area_code="+area_code+
			"&opCode=<%=opCode%>&sysAccept="+sysAccept+
			"&phoneNo="+phoneNo+
			"&submitCfm="+submitCfm+"&pType="+
			pType+"&billType="+billType+ "&printInfo=" + printStr;
		var ret=window.showModalDialog(path,"",prop);
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

	//opr_info+='<%=loginNo%>'+' '+'<%=loginName%>'+"|";
//	opr_info+='<%=new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss", Locale.getDefault()).format(new java.util.Date())%>'+"|";
	cust_info+="手机号码："+document.all.phone_no.value+"|";
	cust_info+="客户姓名："+document.all.cust_name.value+"|";
	cust_info+="客户地址："+document.all.cust_addr.value+"|";
	cust_info+="证件号码："+document.all.cardId_no.value+"|";
	retInfo+=" "+"|";
	retInfo+=" "+"|";
	retInfo+=" "+"|";
	retInfo+=" "+"|";
	opr_info+="业务类型：购机赠话费（按月返还）--冲正"+"|";
	opr_info+="业务流水："+document.all.login_accept.value+"|";
	opr_info+="手机型号: "+"<%=machine_type%>"+"|";
	opr_info+="退款合计："+document.all.sum_money.value+"元、含赠送话费"+"<%=limit_pay%>"+"元";

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
	retInfo+=" "+"|";
	retInfo+=" "+"|";
	retInfo+=" "+"|";
	retInfo+=" "+"|";
	retInfo+=" "+"|";
	retInfo+=" "+"|";
	retInfo+=" "+"|";
	retInfo+=" "+"|";
	retInfo+=" "+"|";	
    retInfo=strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);

	retInfo=retInfo.replace(new RegExp("#","gm"),"%23");

  return retInfo;

}


//-->
</script>

</head>
<body>
<form name="frm" method="post" action="f7956Cfm.jsp" >
	<%@ include file="/npage/include/header.jsp" %>  
 <div class="title">
		<div id="title_zi">购机赠话费（按月返还）</div>
	 </div>					
			<div id="showMsg"></div>

        <table >
		  <tr > 
            <td class="blue">操作类型：</td>
            <td class="blue">购机赠话费（按月返还）--冲正</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
          </tr>
          <tr > 
            <td class="blue">客户姓名:</td>
            <td>
			  <input name="cust_name" value="<%=bp_name%>" type="text" v_must=1 readonly id="cust_name" maxlength="20" v_name="姓名" Class="InputGrey" > 
			  <font class='orange'>*</font>
            </td>
            <td class="blue">客户地址:</td>
            <td>
			  <input name="cust_addr" value="<%=bp_add%>" type="text" v_must=1 readonly id="cust_addr" maxlength="20" Class="InputGrey"> 
			   <font class='orange'>*</font>
            </td>
            </tr>
            <tr > 
            <td class="blue">证件类型:</td>
            <td>
			  <input name="cardId_type" value="<%=cardId_type%>" type="text" v_must=1 readonly id="cardId_type" maxlength="20" Class="InputGrey"> 
			  <font class='orange'>*</font>
            </td>
            <td class="blue">证件号码:</td>
            <td>
			  <input name="cardId_no" value="<%=cardId_no%>" type="text"  v_must=1 readonly id="cardId_no" maxlength="20" Class="InputGrey"> 
			   <font class='orange'>*</font>
            </td>
            </tr>
            <tr > 
            <td class="blue">业务品牌:</td>
            <td>
			  <input name="sm_code" value="<%=sm_code%>" type="text"  v_must=1 readonly id="sm_code" maxlength="20" Class="InputGrey"> 
			   <font class='orange'>*</font>
            </td>
            <td class="blue">运行状态:</td>
            <td>
			  <input name="run_type" value="<%=run_name%>" type="text"  v_must=1 readonly id="run_type" maxlength="20" Class="InputGrey"> 
			   <font class='orange'>*</font>
            </td>
            </tr>
            <tr > 
            <td class="blue">VIP级别:</td>
            <td>
			  <input name="vip" value="<%=vip%>" type="text"  v_must=1 readonly id="vip" maxlength="20" Class="InputGrey"> 
			   <font class='orange'>*</font>
            </td>
            <td class="blue">可用预存:</td>
            <td>
			  <input name="prepay_fee" value="<%=prepay_fee%>" type="text"  v_must=1 readonly id="prepay_fee" maxlength="20" Class="InputGrey"> 
			   <font class='orange'>*</font>
            </td>
            </tr>
           <tr > 
            <td class="blue">营销方案：</td>
            <td >
				<input name="sale_name" value="<%=sale_name%>" type="text"  v_must=1 readonly id="sale_name" maxlength="20" size="40" Class="InputGrey"> 
			    <font class='orange'>*</font>
			</td>
			<td class="blue">应退金额：</td>
            <td >
			  <input name="sum_money" type="text"  id="sum_money" value="<%=sum_pay%>" readonly Class="InputGrey">
			   <font class='orange'>*</font>
			</td>            
          </tr>
          <tr > 
            <td class="blue">购机款：</td>
            <td >
			  <input name="price" type="text" id="price" value="<%=mach%>" readonly   Class="InputGrey">
			   <font class='orange'>*</font>	
			</td>
            <td class="blue">赠送话费：</td>
            <td>
			  <input name="limit_pay" type="text"   id="limit_pay" value="<%=limit_pay%>" readonly Class="InputGrey">
			   <font class='orange'>*</font>
			</td>
          </tr>
          
          <!--手机电视需求新增 wangdana-->
          <tr > 
            <td class="blue">手机电视功能费：</td>
            <td >
			  <input name="TVprice" type="text" id="TVprice" value="<%=TVprice%>"   readonly v_name="手机电视功能费" Class="InputGrey">
			  <font class='orange'>*</font>
			</td>
            <td class="blue">手机电视消费期限：</td>
            <td>
			  <input name="TVtime" type="text"  id="TVtime"  value="<%=TVtime%>" v_type="0_9" v_must=1   v_name="消费时长" readonly Class="InputGrey">
			   <font class='orange'>*</font>
			</td>
          </tr>
		<!--begin huangrong add 上网费，上网费消费月份，WLAN业务费和WLAN业务费消费月份的信息展示 2011-6-29-->
    <tr> 
      <td class="blue">手机上网功能费：</td>
      <td >
			  <input name="phoneNetPrice" type="text" class="button" id="phoneNetPrice" value="<%=phoneNetPrice%>"  v_type="money" v_must=1   readonly v_name="上网费" >
			  <font color="#FF0000">*</font>	
			</td>
      <td class="blue">手机上网消费期限：</td>
      <td>
			  <input name="phoneNetTime" type="text"  class="button" id="phoneNetTime" value="<%=phoneNetTime%>"  v_type="0_9" v_must=1   v_name="消费时长" readonly>
			  <font color="#FF0000">*</font>
			</td>
    </tr>  
    <tr> 
      <td class="blue">WLAN功能费：</td>
      <td >
			  <input name="wlanPrice" type="text" class="button" id="wlanPrice"  value="<%=wlanPrice%>"  v_type="money" v_must=1   readonly v_name="WLAN业务费" >
			  <font color="#FF0000">*</font>	
			</td>
      <td class="blue">WLAN消费期限：</td>
      <td>
			  <input name="wlanTime" type="text"  class="button" id="wlanTime" value="<%=wlanTime%>"  v_type="0_9" v_must=1   v_name="消费时长" readonly>
			  <font color="#FF0000">*</font>
			</td>
    </tr>                  
	  <!--end huangrong add 上网费，上网费消费月份，WLAN业务费和WLAN业务费消费月份的信息展示 2011-6-29-->                  
          <tr > 
            
            <td></td>
            <td></td>
          </tr> 
          <tr > 
            <td height="32"  class="blue">备注：</td>
            <td colspan="3" height="32">
             <input name="opNote" type="text"  id="opNote" size="60" maxlength="60" value="购机赠话费（按月返还）--冲正" > 
            </td>
          </tr>
          <tr> 
            <td colspan="4"> <div align="center"> 
                <input name="confirm" type="button" class="b_foot" index="2" value="确认&打印" onClick="printCommit()">
                &nbsp; 
                <input name="reset" type="reset" class="b_foot" value="清除" >
                &nbsp; 
                <input name="back" onClick="window.close()" type="button" class="b_foot" value="关闭">
                &nbsp; </div></td>
          </tr>
        </table>
  <p>&nbsp;</p>
  <p>&nbsp;</p>
  <p>&nbsp;</p>  
  </td>
  </tr>
  </table>	
    <input type="hidden" name="phone_no" value="<%=phoneNo%>">
    <input type="hidden" name="work_no" value="<%=loginName%>">
	<input type="hidden" name="opcode" value="<%=opcode%>">
    <input type="hidden" name="login_accept" value="<%=printAccept%>">
	<input type="hidden" name="backaccept" value="<%=backaccept%>">
    <input type="hidden" name="card_dz" value="0" >
	<input type="hidden" name="sale_type" value="1" >
    <input type="hidden" name="used_point" value="0" >  
	<input type="hidden" name="point_money" value="0" > 
	<input type="hidden" name="machine_type" value="<%=machine_type%>" >
	<!-- tianyang add at 20100201 for POS缴费需求*****start*****-->
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
	<input type="hidden" name="isNextDay"  value="<%=isNextDay%>">
	<!-- tianyang add at 20100201 for POS缴费需求*****end*******-->
	<%@ include file="/npage/include/footer.jsp" %>
</form>
</body>
<!-- **** ningtn add for pos @ 20100430 ******加载建行控件页 BankCtrl ******** -->
<%@ include file="/npage/public/posCCB.jsp" %>
<!-- **** ningtn add for pos @ 20100430 ******加载工行控件页 KeeperClient ******** -->
<%@ include file="/npage/public/posICBC.jsp" %>

</html>

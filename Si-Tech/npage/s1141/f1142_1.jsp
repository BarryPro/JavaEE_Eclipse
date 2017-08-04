<%
/********************
 version v2.0
开发商: si-tech
update:liutong@20080923
********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page contentType="text/html;charset=GBK"%>
<%@ page import="com.sitech.boss.pub.util.Encrypt"%>
<%@ include file="../../npage/bill/getMaxAccept.jsp" %>
<%
  response.setHeader("Pragma","No-cache");
  response.setHeader("Cache-Control","no-cache");
  response.setDateHeader("Expires", 0);
%>

<%
  /**
  ArrayList arrSession = (ArrayList)session.getAttribute("allArr");
  String[][] baseInfoSession = (String[][])arrSession.get(0);
  String[][] otherInfoSession = (String[][])arrSession.get(2);
  String[][] pass = (String[][])arrSession.get(4);

  String loginNo = baseInfoSession[0][2];
  String loginName = baseInfoSession[0][3];
  String powerCode= otherInfoSession[0][4];
  String orgCode = baseInfoSession[0][16];
  String ip_Addr = request.getRemoteAddr();
  String regionCode = orgCode.substring(0,2);
  String regionName = otherInfoSession[0][5];
  String loginNoPass = pass[0][0];
  String dept = otherInfoSession[0][4]+otherInfoSession[0][5]+otherInfoSession[0][6];
  **/
		String opCode = "1142";
		String opName = "预存话费优惠购机冲正";
		String loginNo =(String)session.getAttribute("workNo");
		String loginName =(String)session.getAttribute("workName");
		String orgCode = (String)session.getAttribute("orgCode");
		String regionCode = orgCode.substring(0,2);
		String ip_Addr = (String)session.getAttribute("ipAddr");
		String loginNoPass = (String)session.getAttribute("password");
		String  powerCode= (String)session.getAttribute("powerCode");
		String op_code=request.getParameter("opCode");
		
		String groupId = (String)session.getAttribute("groupId");
		/* ningtn pos 隔日冲正 */
		String cccTime=new java.text.SimpleDateFormat("yyyyMMdd", Locale.getDefault()).format(new java.util.Date());
		/* 是否隔日冲正的标识  -1隔日冲正 ; 0当日冲正 */
		int isNextDay = 999;
%>
<%

		String retFlag="",retMsg="";
		//SPubCallSvrImpl impl = new SPubCallSvrImpl();
		//ArrayList retList = new ArrayList();
		String[] paraAray1 = new String[8];
		String phoneNo = request.getParameter("srv_no");
		String opcode = request.getParameter("opcode");
		String backaccept = request.getParameter("backaccept");
		String passwordFromSer="";

  paraAray1[0] = phoneNo;		/* 手机号码   */
  paraAray1[1] = opcode; 	    /* 操作代码   */
  paraAray1[2] = loginNo;	    /* 操作工号   */
  paraAray1[3] = backaccept;	    /* 操作流水   */
  paraAray1[4] = "";          /* 渠道       */
  paraAray1[5] = loginNoPass; /* 工号密码   */
  paraAray1[6] = "";          /* 手机密码   */
  paraAray1[7] = "";          /* 新操作流水   */
/*****王梅 添加 20060605*****/
  //ArrayList retArray = new ArrayList();
  //String[][] result = new String[][]{};
  //SPubCallSvrImpl callView = new SPubCallSvrImpl();
  String sqlStr = "";
  String awardName="";
  sqlStr = "select award_name from wawardpay where phone_no ='"+phoneNo+"'"+
		    " and login_accept="+backaccept ;

 // retArray = callView.sPubSelect("1",sqlStr);
  //result = (String[][])retArray.get(0);
  //awardName = result[0][0];
%>
			<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>"  retcode="retCode1" retmsg="retMsg1" outnum="1">
			<wtc:sql><%=sqlStr%></wtc:sql>
			</wtc:pubselect>
			<wtc:array id="result1" scope="end" />
<%

         if(retCode1.equals("0")||retCode1.equals("000000")){
            System.out.println("调用服务sPubSelect in f1142_1.jsp 成功@@@@@@@@@@@@@@@@@@@@@@@@@@");
 	        	if(result1.length==0){
 	            }else{
 	        	   awardName = result1[0][0];
 	        	}

 	     	}else{
 	         	System.out.println(retCode1+"    retCode1");
 	     		System.out.println(retMsg1+"    retMsg1");
 			    System.out.println("调用服务sPubSelect in f1142_1.jsp 失败@@@@@@@@@@@@@@@@@@@@@@@@@@");
 			}


  System.out.println("awardName="+awardName);

  if(!awardName.equals("")){
  %>
<script language="JavaScript" >


   if(rdShowConfirmDialog("此用户为已中奖用户，中奖奖品为：<%=awardName%> 请用户完好无损返回奖品，再继续办理冲正业务！")!=1)
	{
		location='f1141_login.jsp?activePhone=<%=phoneNo%>';
	}

	</script>

<%}


  /*sunzx add at 20070904  */
 sqlStr = "select res_info from wawarddata where flag = 'Y' and phone_no = '"+phoneNo+"'"+
		    " and login_accept="+backaccept  ;
/*****
  retArray = callView.sPubSelect("1",sqlStr);
  if(retArray != null && retArray.size() > 0)
  {
	  result = (String[][])retArray.get(0);
	  awardName = result[0][0];

	  System.out.println("awardName2="+awardName);

	  if(!awardName.equals("")){
%>
		  <script type="text/javascript" src="../../js/common/redialog/redialog.js"></script>
		  <script language="JavaScript" >

		  rdShowMessageDialog("此用户已在促销品统一付奖中进行<%=awardName%>领奖，请进行促销品统一付奖冲正，并确保奖品完好");
			location='f1141_login.jsp';
			</script>
<%	}
	}
*****/
//sunzx add end
//liutong add begin
%>
			<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>"  retcode="retCode2" retmsg="retMsg2" outnum="1">
			<wtc:sql><%=sqlStr%></wtc:sql>
			</wtc:pubselect>
			<wtc:array id="result2" scope="end" />
<%

         if(retCode2.equals("0")||retCode2.equals("000000")){
          System.out.println("调用服务sPubSelect in f1142_1.jsp 成功@@@@@@@@@@@@@@@@@@@@@@@@@@");
 	        	if(result2.length==0){
 	            }else{
 	        	   awardName = (result2[0][0]).trim();

 	        	}

 	     	}else{
 	         	System.out.println(retCode2+"    retCode2");
 	     		System.out.println(retMsg2+"    retMsg2");
 				System.out.println("调用服务sPubSelect in f1142_1.jsp 失败@@@@@@@@@@@@@@@@@@@@@@@@@@");
 			}

 if(!awardName.equals("")){
%>
		  <script language="JavaScript" >
		    rdShowMessageDialog("此用户已在促销品统一付奖中进行<%=awardName%>领奖，请进行促销品统一付奖冲正，并确保奖品完好");
			location='f1141_login.jsp?activePhone=<%=phoneNo%>';
			</script>
<%	}
//liutong add end

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
 */

  //retList = impl.callFXService("s1142Qry", paraAray1, "20","phone",phoneNo);
   String  bp_name="",bp_add="",cardId_type="",cardId_no="",sm_code="",region_name="",run_name="",vip="",posint="",prepay_fee="",sale_name="",sum_pay="",card_no="",card_num="",limit_pay="",use_point="",card_summoney="",mach="",machine_type="" ;
   String payType="",Response_time="",TerminalId="",Rrn="",Request_time="" ,TVprice="",TVtime="";
%>
			<wtc:service name="s1142Qry" routerKey="phone" routerValue="<%=phoneNo%>"  retcode="retCode3" retmsg="retMsg3"  outnum="31" >
				<wtc:param value="<%=paraAray1[7]%>"/>
        <wtc:param value="<%=paraAray1[4]%>"/>
      	<wtc:param value="<%=paraAray1[1]%>"/>
      	<wtc:param value="<%=paraAray1[2]%>"/>
      	<wtc:param value="<%=paraAray1[5]%>"/>
      	<wtc:param value="<%=paraAray1[0]%>"/>
      	<wtc:param value="<%=paraAray1[6]%>"/>
      	<wtc:param value="<%=paraAray1[3]%>"/>
			</wtc:service>
			<wtc:array id="result3" scope="end" />
<%
 		 if(retCode3.equals("0")||retCode3.equals("000000")){
          System.out.println("调用服务s1142Qry in f1142_1.jsp 成功@@@@@@@@@@@@@@@@@@@@@@@@@@");
 	        	if(result3.length==0){
 	        		if(!retFlag.equals("1"))
						{
							System.out.println("retFlag="+retFlag);
						   retFlag = "1";
						   retMsg = "s1142Qry查询号码基本信息为空!<br>errCode: " + retCode3 + "<br>errMsg+" + retMsg3;
					    }
 	            }else{
						bp_name = result3[0][2];//机主姓名
						System.out.println(bp_name);
						bp_add = result3[0][3];//客户地址
						cardId_type = result3[0][4];//证件类型
						cardId_no = result3[0][5];//证件号码
						sm_code = result3[0][6];//业务品牌
						region_name = result3[0][7];//归属地
						run_name = result3[0][8];//当前状态
						vip = result3[0][9];//ＶＩＰ级别
						posint = result3[0][10];//当前积分
						prepay_fee = result3[0][11];//可用预存
						sale_name = result3[0][12];//营销方案名
						sum_pay = result3[0][13];//应付金额
						card_no = result3[0][14];//卡金额串
						card_num = result3[0][15];//卡张数串
						limit_pay = result3[0][16];//预存话费
						use_point = result3[0][17];//销费积分数
						card_summoney = result3[0][18];//卡类总金额
						machine_type = result3[0][19];//机器类型

						///////<!-- ningtn add for pos start @ 20100408 -->
						if(result3[0][24] != null && result3[0][24].trim().length() > 0){
							payType = result3[0][24].trim();
						}else{
							payType = "0";
						}
						Response_time = result3[0][25].trim();
						TerminalId = result3[0][26].trim();
						Rrn = result3[0][27].trim();
						Request_time = result3[0][28].trim();
						TVprice = result3[0][29].trim();
						TVtime  = result3[0][30].trim();
						
						System.out.println("payType : " + payType);
						System.out.println("Response_time : " + Response_time);
						System.out.println("TerminalId : " + TerminalId);
						System.out.println("Rrn : " + Rrn);
						System.out.println("Request_time : " + Request_time);
						System.out.println("TVprice : " + TVprice);
						System.out.println("TVtime : " + TVtime);
						if(Request_time.length() > 0){
							isNextDay = Request_time.substring(0,8).compareTo(cccTime);
						}else{
							isNextDay = 0;
						}
						///////<!-- ningtn add for pos end @ 20100408 -->

 	        	    double mach_fee=0.00;
					double sum=0.00;
					double limit=0.00;
					double TVfee=0.00;

					sum=Double.parseDouble(sum_pay);
					System.out.println("sum="+sum);
					limit=Double.parseDouble(limit_pay);
					TVfee=Double.parseDouble(TVprice);
					System.out.println("limit_pay="+limit_pay);
					mach_fee=sum-limit-TVfee;
					System.out.println("mach_fee="+mach_fee);
					//mach =String.valueOf(mach_fee);
					DecimalFormat currencyFormatter = new DecimalFormat("0.00");
					currencyFormatter.format(mach_fee);
					System.out.println("mach_fee="+currencyFormatter.format(mach_fee));
					mach=currencyFormatter.format(mach_fee)+"";
					System.out.println("mach="+mach);

 	        	}

 	     	}else{


 	         	System.out.println(retCode3+"    retCode3");
 	     		System.out.println(retMsg3+"    retMsg3");
 				System.out.println("调用服务s1142Qry in f1142_1.jsp 失败@@@@@@@@@@@@@@@@@@@@@@@@@@");
				%>
				<script language="JavaScript">
				<!--
				rdShowMessageDialog("错误代码：<%=retCode3%>错误信息：<%=retMsg3%>");
				history.go(-1);
				//-->
				</script>
				<%
 			}

%>
 <%  //优惠信息//********************得到营业员权限，核对密码，并设置优惠权限*****************************//

 /**    页面改造  封掉  20080924
  String[][] favInfo = (String[][])arrSession.get(3);   //数据格式为String[0][0]---String[n][0]
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

  }

  String passTrans=Pub_lxd.repNull(request.getParameter("cus_pass"));
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
  ****/
// **************得到冲正流水***************//
String printAccept="";
printAccept = getMaxAccept();
System.out.println(printAccept);
%>

<html>
<head>
<title>预存话费优惠购机</title>
<script language="JavaScript">
		var isNextDay = "<%=isNextDay%>";
<!--
  function frmCfm(){
  	  /* ningtn add for pos start @ 20100408 POS机器 当日冲正，才调用银行接口 */
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
			  /* ningtn add for pos end @ 20100408 */
  }
  
  /* ningtn add for pos start @ 20100408 */
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
	/* ningtn add for pos start @ 20100408 */
 //***
 function printCommit()
 {
  //校验
  //if(!check(frm)) return false;

 //打印工单并提交表单
  getAfterPrompt();
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
	var h=210;
	var w=400;
	var t=screen.availHeight/2-h/2;
	var l=screen.availWidth/2-w/2;
	var pType="subprint";
	var billType="1";
	var sysAccept = document.all.login_accept.value;
	var printStr = printInfo(printType);

	var mode_code=null;
	var fav_code=null;
	var area_code=null;
	/* ningtn */
	var iccidInfoStr = $("#firstId").val() + "|" + $("#secondId").val();	
	var accInfoStr = $("#accInfoHid1").val() + "|" +$("#accInfoHid2").val()+ "|" +$("#accInfoHid3").val()+ "|" +$("#accInfoHid4").val();
	/* ningtn */
	var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no";
	var path = "<%=request.getContextPath()%>/npage/innet/hljBillPrint_jc_hw.jsp?DlgMsg=" + DlgMessage+ "&iccidInfo=" + iccidInfoStr + "&accInfoStr="+accInfoStr;
	var path = path  + "&mode_code="+mode_code+"&fav_code="+fav_code+"&area_code="+area_code+"&opCode=<%=opCode%>&sysAccept="+sysAccept+"&phoneNo=<%=phoneNo%>&submitCfm=" + submitCfm+"&pType="+pType+"&billType="+billType+ "&printInfo=" + printStr;
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

	cust_info+="手机号码：   "+document.all.phone_no.value+"|";
	cust_info+="客户姓名：   "+document.all.cust_name.value+"|";
	cust_info+="客户地址：   "+document.all.cust_addr.value+"|";
	cust_info+="证件号码：   "+document.all.cardId_no.value+"|";

	opr_info+="业务类型：预存话费优惠购机--冲正"+"|";
	opr_info+="业务流水："+document.all.login_accept.value+"|";
	opr_info+="手机型号: "+"<%=machine_type%>"+"|";
	opr_info+="退款合计："+document.all.sum_money.value+"元、含预存话费"+"<%=limit_pay%>"+"元，手机电视功能费"+"<%=TVprice%>"+"元|";

  var retInfo = "";
	//retInfo+='<%=loginNo%>'+' '+'<%=loginName%>'+"|";
	//retInfo+='<%=new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss", Locale.getDefault()).format(new java.util.Date())%>'+"|";
	//retInfo+="用户号码："+document.all.phone_no.value+"|";
	//retInfo+="用户姓名："+document.all.cust_name.value+"|";
	//retInfo+="用户地址："+document.all.cust_addr.value+"|";
	//retInfo+="证件号码："+document.all.cardId_no.value+"|";
	//retInfo+=" "+"|";
	//retInfo+=" "+"|";
	//retInfo+=" "+"|";
	//retInfo+=" "+"|";
	//retInfo+="业务类型：预存话费优惠购机--冲正"+"|";
  	//retInfo+="业务流水："+document.all.login_accept.value+"|";
  	//retInfo+="手机型号: "+"<%=machine_type%>"+"|";
  	//retInfo+="退款合计："+document.all.sum_money.value+"元、含预存话费"+"<%=limit_pay%>"+"元、含手机电视费"+"<%=TVprice%>"+"|";
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
	note_info1+="备注："+"|";
	//retInfo = cust_info+"#"+opr_info+"#"+note_info1+"#"+note_info2+"#"+note_info3+"#"+note_info4+"#";
	retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
	retInfo=retInfo.replace(new RegExp("#","gm"),"%23");
	return retInfo;
}

-->
</script>
</head>
<body>
<form name="frm" method="post" action="f1142Cfm.jsp" onload="init()">
<%@ include file="/npage/include/header.jsp" %>

	<div class="title">
		<div id="title_zi">预存话费优惠购机</div>
	</div>

        <table  cellspacing="0">
		  <tr>
            <td class="blue">操作类型</td>
            <td colspan="3">预存话费优惠购机--冲正</td>
          </tr>
          <tr>
            <td class="blue">客户姓名</td>
            <td>
			  <input name="cust_name" value="<%=bp_name%>" type="text" class="InputGrey" v_must=1 readonly id="cust_name" maxlength="20" v_name="姓名">
			  <font color="red">*</font>
            </td>
            <td class="blue">客户地址</td>
            <td>
			  <input name="cust_addr" value="<%=bp_add%>" type="text" class="InputGrey" v_must=1 readonly id="cust_addr" maxlength="20" >
			  <font color="red">*</font>
            </td>
            </tr>
            <tr>
            <td class="blue">证件类型</td>
            <td>
			  <input name="cardId_type" value="<%=cardId_type%>" type="text" class="InputGrey" v_must=1 readonly id="cardId_type" maxlength="20" >
			  <font color="red">*</font>
            </td>
            <td class="blue">证件号码</td>
            <td>
			  <input name="cardId_no" value="<%=cardId_no%>" type="text" class="InputGrey" v_must=1 readonly id="cardId_no" maxlength="20" >
			  <font color="red">*</font>
            </td>
            </tr>
            <tr>
            <td class="blue">业务品牌</td>
            <td>
			  <input name="sm_code" value="<%=sm_code%>" type="text" class="InputGrey" v_must=1 readonly id="sm_code" maxlength="20" >
			  <font color="red">*</font>
            </td>
            <td class="blue">运行状态:</td>
            <td>
			  <input name="run_type" value="<%=run_name%>" type="text" class="InputGrey" v_must=1 readonly id="run_type" maxlength="20" >
			  <font color="red">*</font>
            </td>
            </tr>
            <tr>
            <td class="blue">VIP级别</td>
            <td>
			  <input name="vip" value="<%=vip%>" type="text" class="InputGrey" v_must=1 readonly id="vip" maxlength="20" >
			  <font color="red">*</font>
            </td>
            <td class="blue">可用预存</td>
            <td>
			  <input name="prepay_fee" value="<%=prepay_fee%>" type="text" class="InputGrey" v_must=1 readonly id="prepay_fee" maxlength="20" >
			  <font color="red">*</font>
            </td>
            </tr>
           <tr>
            <td class="blue">营销方案</td>
            <td >
				<input name="sale_name" value="<%=sale_name%>" type="text" class="InputGrey" v_must=1 readonly id="sale_name" maxlength="20" size="40">
			    <font color="red">*</font>
			</td>
			<td class="blue" >应退金额</td>
            <td >
			  <input name="sum_money" type="text" class="InputGrey" id="sum_money" value="<%=sum_pay%>" readonly>
			  <font color="red">*</font>
			</td>
          </tr> 
          <tr>
            <td  class="blue">购机款</td>
            <td >
			  <input name="price" type="text" class="InputGrey" id="price" value="<%=mach%>" readonly  >
			  <font color="red">*</font>
			</td>
            <td class="blue">预存话费</td>
            <td>
			  <input name="limit_pay" type="text"  class="InputGrey" id="limit_pay" value="<%=limit_pay%>" readonly>
			  <font color="red">*</font>
			</td>
          </tr>
          <!--手机电视需求新增 wangdana-->
          <td  class="blue">手机电视功能费</td>
            <td >
			  <input name="TVprice" type="text" class="InputGrey" id="TVprice" value="<%=TVprice%>" readonly  >
			  <font color="red">*</font>
			</td>
            <td class="blue">手机电视消费期限</td>
            <td>
			  <input name="TVtime" type="text"  class="InputGrey" id="TVtime" value="<%=TVtime%>" readonly>
			  <font color="red">*</font>
			</td>
          </tr>
          
          <tr>
            <td  class="blue">备注</td>
            <td colspan="3" height="32">
             <input name="opNote" type="text" class="button" id="opNote" size="60" maxlength="60" value="预存话费优惠购机--冲正" >
            </td>
          </tr>
        </table>
        <!-- ningtn 2011-7-12 08:33:59 扩大电子工单 -->
<jsp:include page="/npage/public/hwReadCustCard.jsp">
	<jsp:param name="hwAccept" value="<%=printAccept%>"  />
	<jsp:param name="showBody" value="01"  />
</jsp:include>
        <table>
          <tr>
            <td colspan="4" id = "footer"> <div align="center">
                <input name="confirm" type="button" class="b_foot" index="2" value="确认&打印" onClick="printCommit()">
                &nbsp;
                <input name="reset" type="reset" class="b_foot" value="清除" >
                &nbsp;
                <input name="back" onClick="parent.removeTab(<%=op_code%>)" type="button" class="b_foot" value="关闭">
                &nbsp; </div></td>
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
		<input type="hidden" name="op_code" value="<%=op_code%>" >
		<!-- ningtn add for pos start @ 20100408 -->
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
		<!-- ningtn add for pos start @ 20100408 -->
		<%@ include file="/npage/include/footer.jsp" %>
</form>
</body>
<!-- **** ningtn add for pos @ 20100408 ******加载建行控件页 BankCtrl ******** -->
<%@ include file="/npage/public/posCCB.jsp" %>
<!-- **** ningtn add for pos @ 20100408 ******加载工行控件页 KeeperClient ******** -->
<%@ include file="/npage/public/posICBC.jsp" %>
<%@ include file="/npage/public/hwObject.jsp" %>
</html>

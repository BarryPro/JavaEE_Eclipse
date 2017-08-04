<%
  /*
   * 功能: 预存购机-合约冲正 g976
   * 版本: 1.0
   * 日期: 2013/9/2
   * 作者: diling
   * 版权: si-tech
   * update:
  */
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html;charset=gbk"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="java.text.*" %>
<%
	response.setHeader("Pragma","No-cache");
	response.setHeader("Cache-Control","no-cache");
	response.setDateHeader("Expires", 0);

 	String opCode = request.getParameter("opCode");
  String opName = request.getParameter("opName");

  String loginNo = (String)session.getAttribute("workNo");
  String loginName = (String)session.getAttribute("workName");
  String powerCode= (String)session.getAttribute("powerCode");
  String orgCode = (String)session.getAttribute("orgCode");
  String ip_Addr = (String)session.getAttribute("ipAddr");
  String regionCode = orgCode.substring(0,2);
  String loginNoPass = (String)session.getAttribute("password");
  String groupId = (String)session.getAttribute("groupId");
  String regCode = (String)session.getAttribute("regCode");
  
  String retFlag="",retMsg="";
  String phoneNo = request.getParameter("activePhone");
  String backaccept= request.getParameter("backAccept");//冲正流水
  String userpass="";
  String sqlUserPass = " select  unique trim(user_passwd) from dcustmsg  where phone_no='"+phoneNo+"'";
%>
<wtc:pubselect name="TlsPubSelCrm" outnum="1" retmsg="msg1" retcode="code1" routerKey="region" routerValue="<%=regionCode%>">
<wtc:sql><%=sqlUserPass%></wtc:sql>
</wtc:pubselect>
<wtc:array id="userPassStr" scope="end"/>
<%
	if(code1.equals("000000") || code1.equals("0")){
  	if(userPassStr!= null && userPassStr.length > 0){
  		userpass=userPassStr[0][0];
  	}
  }
%>
<wtc:service  name="sg976Qry" routerKey="phone" routerValue="<%=phoneNo%>" outnum="38"  retcode="errCode" retmsg="errMsg">	
	<wtc:param  value="<%=backaccept%>"/>
	<wtc:param  value="01"/>
	<wtc:param  value="<%=opCode%>"/>
	<wtc:param  value="<%=loginNo%>"/>
	<wtc:param  value="<%=loginNoPass%>"/>
	<wtc:param  value="<%=phoneNo%>"/>	
	<wtc:param  value="<%=userpass%>"/>	
</wtc:service>
<wtc:array id="retList" scope="end"/>
<%
 /*
		客户密码，客户姓名，客户地址，oOldMode，当前资费，grpbig_flag，grpbig_name，sm_code，
		sm_name，欠费，可用预存，证件类型，证件号码，id_no，belong_code，销售代码，手机品牌型号
		购机款，话费消费期限，活动预存，月返费，月底线消费，VIP级别，运行状态，手机品牌，
		手机型号，IMIE，营销案名称，附加资费代码,缴费合计,底线预存,手机电视费,手机电视费消费期限
 */
  String us_pass="",bp_name="",bp_add="",ole_mode="",current_fee="",grpbig_flag="",grpbig_name="",sm_code="";
  String sm_name="",temp_buf="",prepay_fee="",cardId_type="",cardId_no="",id_no="",belong_code="",sale_code="",phone_typeno="";
  String mach_price="",consume_Term="",prepay_gift="",prepay_limit="",mon_baseFee="",vip="",run_name="",agent_code="";
  String phone_type="",IMEINo="",sale_name="",OfferID="",payType="",Response_time="",TerminalId="",Rrn="",RequestTime="",CashPay="",basefee="",mobileTVfee="",mobileTVterm="";
  if("000000".equals(errCode)||"0".equals(errCode)){
    if(retList.length>0){
      us_pass =retList[0][0];
  	  bp_name = retList[0][1];	  
  	  bp_add = retList[0][2];
  	  ole_mode = retList[0][3];
  	  current_fee = retList[0][4];
  	  grpbig_flag = retList[0][5];
  	  grpbig_name = retList[0][6];
  	  sm_code = retList[0][7];
  	  sm_name =retList[0][8];  
  	  temp_buf =retList[0][9]; 
  	  prepay_fee =retList[0][10];   
  	  cardId_type =retList[0][11];   
  	  cardId_no = retList[0][12];
  	  id_no = retList[0][13];
  	  belong_code = retList[0][14];
  	  sale_code = retList[0][15]; 
  	  phone_typeno = retList[0][16];
  	  mach_price = retList[0][17]; 
  		consume_Term = retList[0][18];
  		prepay_gift = retList[0][19]; 
  		prepay_limit = retList[0][20]; 
  		mon_baseFee = retList[0][21]; 
  		vip = retList[0][22]; 
  		run_name = retList[0][23]; 
  		agent_code = retList[0][24]; 
  		phone_type = retList[0][25]; 
  		IMEINo = retList[0][26];
  		sale_name = retList[0][27]; 
  		OfferID = retList[0][28];
  		payType = retList[0][29]; 
  		Response_time = retList[0][30]; 
  		TerminalId = retList[0][31]; 
  		Rrn = retList[0][32]; 
  		RequestTime = retList[0][33];
  		CashPay  = retList[0][34];
  		basefee  = retList[0][35];
  		mobileTVfee= retList[0][36];      /* 手机电视费 */
  		mobileTVterm= retList[0][37];     /* 手机电视费消费期限 */	
    }else{
      if(!retFlag.equals("1")){
  	   retFlag = "1";
  	   retMsg = "查询号码基本信息为空!<br>errCode: " + errCode + "<br>errMsg：" + errMsg;
      }
%>
        <SCRIPT language="JavaScript">
        	rdShowMessageDialog("<%=retMsg%>",0);
          window.location.href="/npage/sg975/fg975_login.jsp?activePhone=<%=phoneNo%>&opCode=g976&opName=<%=opName%>";
        </SCRIPT>
<%
    }
  }else{
    retMsg = errMsg;
%>
    <SCRIPT language="JavaScript">
    	rdShowMessageDialog("错误代码：<%=errCode%><br>错误信息：<%=retMsg%>",0);
      window.location.href="/npage/sg975/fg975_login.jsp?activePhone=<%=phoneNo%>&opCode=g976&opName=<%=opName%>";
    </SCRIPT>
<%  
  }
%>
<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="region" routerValue="<%=regionCode%>"  id="printAccept"/>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title><%=opName%></title>
<META content="no-cache" http-equiv="Pragma">
<META content="no-cache" http-equiv="Cache-Control">
<META content="0" 	     http-equiv="Expires" >
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<script type="text/javascript" src="../../npage/s3000/js/S3000.js"></script>
<script language="JavaScript" src="../../npage/s1400/pub.js"></script>
<script language="JavaScript">

<!--
  function frmCfm(){
  	  /* ningtn add for pos start @ 20100430 */
		if(document.all.payType.value=="BX")
	  	{
	    		/*set 输入参数*/
					var transerial    = "000000000000";  	                     //交易唯一号 ，将会取消
					var trantype      = "01";                                  //交易类型
					var bMoney        = "<%=CashPay%>";					 							 //缴费金额
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
					var bMoney        = "<%=CashPay%>";							          /*交易金额 */         
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
			  /* ningtn add for pos end @ 20100430 */
  }
    /* ningtn add for pos start @ 20100430 */
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
	/* ningtn add for pos start @ 20100430 */
 //***
 function printCommit()
 {
  getAfterPrompt();
  
  document.frm.iAddStr.value=document.frm.sale_code.value+"|"+document.all.agent_code.value+"|"+document.all.phone_typeno.value+"|"+document.frm.CashPay.value+"|"+document.frm.prepay_gift.value+"|"+document.frm.prepay_limit.value+"|"+document.frm.mon_baseFee.value+"|"+document.frm.mach_price.value+"|"+document.frm.consume_Term.value+"|"
	 +document.frm.OfferID.value+"|"+document.frm.IMEINo.value+"|"+document.frm.basefee.value+"|"+document.frm.Active_Term.value+"|"+document.frm.basefee.value+"|";
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

	var pType="subprint";             				 		//打印类型：print 打印 subprint 合并打印
	var billType="1";              				 			//票价类型：1电子免填单、2发票、3收据
	var sysAccept =<%=printAccept%>;             			//流水号
	var printStr = printInfo(printType);			 		//调用printinfo()返回的打印内容
	var mode_code=null;           							//资费代码
	var fav_code=null;                				 		//特服代码
	var area_code=null;             				 		//小区代码
	var op_Code="g976" ;                   			 		//操作代码
	var phoneNo="<%=phoneNo%>";                  	 		//客户电话

	var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no";
	var path = "<%=request.getContextPath()%>/npage/innet/hljBillPrint_jc_hw.jsp?DlgMsg=" + DlgMessage+ "&submitCfm=" + submitCfm;
	path+="&mode_code="+mode_code+
		"&fav_code="+fav_code+"&area_code="+area_code+
		"&opCode="+op_Code+"&sysAccept="+sysAccept+
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
	//opr_info+='<%=new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss", Locale.getDefault()).format(new java.util.Date())%>'+"|";
	cust_info+="手机号码："+document.all.phone_no.value+"|";
	cust_info+="客户姓名："+document.all.cust_name.value+"|";
	
	opr_info+="用户品牌："+document.all.sm_name.value+"    办理业务：<%=opName%>"+"|";
  opr_info+="业务流水："+document.all.login_accept.value+"|";
  opr_info+="手机型号："+document.all.phone_type.value+"    IMEI码："+document.all.IMEINo.value+"|";
	opr_info+="应退金额："+document.all.sum_money.value+"元"+"|";
	

  retInfo=strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
	retInfo=retInfo.replace(new RegExp("#","gm"),"%23");
  return retInfo;
}


//-->
</script>
</head>
<body>
<form name="frm" method="post" action="fg976_cfm.jsp" onload="init()">
	<%@ include file="/npage/include/header.jsp" %>
<table cellspacing="0">
	<tr>
		<td class="blue">操作类型</td>
		<td class="blue" colspan="3"><b><%=opName%></b></td>
	</tr>
	<tr>
		<td class="blue">客户姓名</td>
		<td>
			<input name="cust_name" value="<%=bp_name%>" type="text" class="InputGrey" v_must=1 readonly id="cust_name" maxlength="20" >
			<font color="orange">*</font>
		</td>
		<td class="blue">客户地址</td>
		<td>
			<input name="cust_addr" value="<%=bp_add%>" type="text" class="InputGrey" v_must=1 readonly id="cust_addr" maxlength="20" size="40">
			<font color="orange">*</font>
		</td>
	</tr>
	<tr>
		<td class="blue">证件类型</td>
		<td>
			<input name="cardId_type" value="<%=cardId_type%>" type="text" class="InputGrey" v_must=1 readonly id="cardId_type" maxlength="20" >
			<font color="orange">*</font>
		</td>
		<td class="blue">证件号码</td>
		<td>
			<input name="cardId_no" value="<%=cardId_no%>" type="text" class="InputGrey" v_must=1 readonly id="cardId_no" maxlength="20" >
			<font color="orange">*</font>
		</td>
	</tr>
	<tr>
		<td class="blue">业务品牌</td>
		<td>
			<input name="sm_name" value="<%=sm_name%>" type="text" class="InputGrey" v_must=1 readonly id="sm_name" maxlength="20" >
			<font color="orange">*</font>
		</td>
		<td class="blue">运行状态</td>
		<td>
			<input name="run_type" value="<%=run_name%>" type="text" class="InputGrey" v_must=1 readonly id="run_type" maxlength="20" >
			<font color="orange">*</font>
		</td>
	</tr>
	<tr>
		<td class="blue">VIP级别</td>
		<td>
			<input name="vip" value="<%=vip%>" type="text" class="InputGrey" v_must=1 readonly id="vip" maxlength="20" >
			<font color="orange">*</font>
		</td>
		<td class="blue">可用预存</td>
		<td>
			<input name="prepay_fee" value="<%=prepay_fee%>" type="text" class="InputGrey" v_must=1 readonly id="prepay_fee" maxlength="20" >
			<font color="orange">*</font>
		</td>
	</tr>
	<tr>
	<td class="blue">营销方案</td>
	<td>
		<input name="sale_name" value="<%=sale_name%>" type="text" class="InputGrey" v_must=1 readonly id="sale_name" maxlength="20" size="40">
		<font color="orange">*</font>
	</td>	
	<td class="blue">购机款</td>
		<td >
			<input name="mach_price" type="text"  class="InputGrey" id="mach_price" value="<%=mach_price%>" readonly>
			<font color="orange">*</font>
		</td>
	</tr>
	<tr>
		<input name="price" type="hidden" class="button" id="price" value="<%=mach_price%>" readonly v_name="购机款" >
		<td class="blue">底限预存</td>
		<td >
			<input name="basefee" type="text"  class="InputGrey" id="basefee" value="<%=basefee%>" readonly >
			<font color="orange">*</font>
		</td>
		<td class="blue">应退总金额</td>
		<td >
			<input name="sum_money" type="text" class="InputGrey" id="sum_money" value="<%=CashPay%>" readonly>
			<font color="orange">*</font>
		</td>
	</tr>
	<tr>
		<td class="blue">备注</td>
		<td colspan="3">
			<input name="opNote" type="text" class="InputGrey" readOnly id="opNote" size="60" maxlength="60" value="<%=opName%>" >
		</td>
	</tr>
	<tr>
		<td colspan="4" align="center" id="footer">
			<input name="confirm" type="button" class="b_foot" index="2" value="确认&打印" onClick="printCommit()">
			&nbsp;
			<input name="reset" type="reset" class="b_foot" value="清除" >
			&nbsp;
			<input name="back" onClick="removeCurrentTab()" type="button" class="b_foot" value="关闭">
			&nbsp;
		</td>
	</tr>
</table>
		<input type="hidden" name="phone_no" value="<%=phoneNo%>">
		<input type="hidden" name="work_no" value="<%=loginName%>">
		<input type="hidden" name="opCode" value="<%=opCode%>">
		<input type="hidden" name="opName" value="<%=opName%>">
		<input type="hidden" name="login_accept" value="<%=printAccept%>">
		<input type="hidden" name="backaccept" value="<%=backaccept%>">
		<input type="hidden" name="sale_code" value="<%=sale_code%>" >
		<input type="hidden" name="agent_code" value="<%=agent_code%>" >
		<input type="hidden" name="CashPay" value="<%=CashPay%>" >
		<input type="hidden" name="mon_baseFee" value="<%=mon_baseFee%>" >
		<input type="hidden" name="prepay_limit" value="<%=prepay_limit%>" >		
		<input type="hidden" name="prepay_gift" value="<%=prepay_gift%>" >				
		<input type="hidden" name="consume_Term" value="<%=consume_Term%>" >		
		<input type="hidden" name="sm_code" value="<%=sm_code%>" >		
		<input type="hidden" name="IMEINo" value="<%=IMEINo%>" >		
		<input type="hidden" name="iAddStr" value="" >		
		<input type="hidden" name="phone_typeno" value="<%=phone_typeno%>" >	
		<input type="hidden" name="phone_type" value="<%=phone_type%>" >		
		<input type="hidden" name="OfferID" value="<%=OfferID%>" >
		<input type="hidden" name="PhoneFree_Fee" id="PhoneFree_Fee" value="<%=mobileTVfee%>" >		
		<input type="hidden" name="Active_Term" id="Active_Term" value="<%=mobileTVterm%>" >	
		<!-- for pos -->
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
		<!--  for pos -->
	<%@ include file="/npage/include/footer.jsp" %>
</form>
</body>
<%@ include file="/npage/public/posCCB.jsp" %>
<%@ include file="/npage/public/posICBC.jsp" %>
</html>

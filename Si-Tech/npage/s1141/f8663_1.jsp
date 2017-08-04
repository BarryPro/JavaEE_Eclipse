<%
/********************
 version v2.0
开发商: si-tech
update:sunaj@2009-05-13
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
  String opCode = "8663";     
  String opName = "购上网本，赠上网费退货"; 

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
  String phoneNo = request.getParameter("srv_no");
  String opcode = request.getParameter("opcode");
  String backaccept= request.getParameter("backaccept");
  String passwordFromSer="";
  String sqlStr = "";
  String awardName="";
  sqlStr = "select award_name from wawardpay where phone_no ='"+phoneNo+"'"+
		    " and login_accept="+backaccept  ;
%>
<wtc:pubselect name="sPubSelect" outnum="1" retmsg="msg1" retcode="code1" routerKey="region" routerValue="<%=regionCode%>">
	<wtc:sql><%=sqlStr%></wtc:sql>
</wtc:pubselect>
<wtc:array id="retArray" scope="end"/>
<%
  if(retArray!=null&& retArray.length > 0){
  	awardName = retArray[0][0];
  	System.out.println("awardName="+awardName);
  %>
  <script language="JavaScript" >

  //rdShowMessageDialog("此用户为已中奖用户，中奖奖品为："<%=awardName%>", 请用户完好无损返回奖品，再继续办理冲正业务！");
   	if(rdShowConfirmDialog("此用户为已中奖用户，中奖奖品为：<%=awardName%> 请用户完好无损返回奖品，再继续办理冲正业务！")!=1)
		{
			location='f8661_login.jsp?activePhone=<%=phoneNo%>';
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
  if(retArray != null && retArray.length > 0)
  {
	  awardName = retArray[0][0];
  	  if(!awardName.equals("")){
%>
		  <script type="text/javascript" src="../../js/common/redialog/redialog.js"></script>
		  <script language="JavaScript" >

		  rdShowMessageDialog("此用户已在促销品统一付奖中进行<%=awardName%>领奖，请进行促销品统一付奖冲正，并确保奖品完好",1);
			location='f8661_login.jsp?activePhone=<%=phoneNo%>';
			</script>
<%	}
	}
	//sunzx add end
String IMEINo="";
sqlStr="select imei_no from wMachSndOpr where phone_no ='"+phoneNo+"'"+
		    " and login_accept="+backaccept; 
%>
<wtc:pubselect name="sPubSelect" outnum="1" retmsg="msg1" retcode="code1" routerKey="region" routerValue="<%=regionCode%>">
	<wtc:sql><%=sqlStr%></wtc:sql>
</wtc:pubselect>
<wtc:array id="retArray" scope="end"/>
<%
  if(retArray!=null&& retArray.length > 0){
  	IMEINo = retArray[0][0];
  	System.out.println("IMEINo="+IMEINo);
  	}
%>

<wtc:service  name="s8663Qry" routerKey="phone" routerValue="<%=phoneNo%>" outnum="30"  retcode="errCode" retmsg="errMsg">
 	<wtc:param  value="<%=phoneNo%>"/>
	<wtc:param  value="<%=op_code%>"/>
	<wtc:param  value="<%=loginNo%>"/>
	<wtc:param  value="<%=backaccept%>"/>
</wtc:service>
<wtc:array id="retList" scope="end"/>
<%

 /* 输出参数： 返回码，返回信息，客户姓名，客户地址，证件类型，证件号码，业务品牌，
 			归属地，当前状态，VIP级别 ，当前积分，用户预存，
 			营销方案名，应付金额，卡金额，卡张数串，赠送话费，销费积分数
 */
  String bp_name="",bp_add="",cardId_type="",cardId_no="",sm_code="",region_name="",run_name="",vip="",posint="",prepay_fee="";
  String sale_name="",sum_money="",scard_money="",card_num="",pay_money="",used_point="",type_name="";
  String vspec_name="",vmode_code="",vused_date="",vspec_fee="",phone_money="",total_money="",net_fee="";

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
	if (errCode.equals("000000")||errCode.equals("0")){
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
	  pay_money = retList[0][16];  /*预存话费上网费*/ 
	  used_point = retList[0][17];
	  net_fee    = retList[0][18];  /*上网费*/ 
	  type_name = retList[0][19];
	  phone_money = retList[0][20];  /*机款*/ 
	  total_money = retList[0][21];  /*总金额*/ 
	  pay_money=""+Float.parseFloat(pay_money);
	  ///////<!-- ningtn add for pos start @ 20100722 -->
		if(retList[0][22] != null && retList[0][22].trim().length() > 0){
			payType = retList[0][22].trim();
		}else{
			payType = "0";
		}
		Response_time = retList[0][23].trim();
		TerminalId = retList[0][24].trim();
		Rrn = retList[0][25].trim();
		Request_time = retList[0][26].trim();
		
		System.out.println("payType : " + payType);
		System.out.println("Response_time : " + Response_time);
		System.out.println("TerminalId : " + TerminalId);
		System.out.println("Rrn : " + Rrn);
		System.out.println("Request_time : " + Request_time);
		///////<!-- ningtn add for pos end @ 20100722 -->
	}
  }

%>
 <%  //优惠信息//********************得到营业员权限，核对密码，并设置优惠权限*****************************//
  String Handfee_Favourable = "readonly";        //a230  手续费
 %>
<%
//******************得到下拉框数据***************************//
String printAccept="";
printAccept = getMaxAccept();
%>
<html>
<head>
<title><%=opName%></title>
<META content="no-cache" http-equiv="Pragma">
<META content="no-cache" http-equiv="Cache-Control">
<META content="0" 	     http-equiv="Expires" >
<meta http-equiv="Content-Type" content="text/html; charset=GBK">

 <script language=javascript>


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

  var arrPhoneType = new Array();//G3笔记本型号代码
  var arrPhoneName = new Array();//G3笔记本型号名称
  var arrAgentCode = new Array();//代理商代码
  var selectStatus = 0;

  var arrsalecode =new Array();
  var arrsaleName=new Array();
  var arrsalebarnd=new Array();
  var arrsaletype=new Array();

  //***
  function frmCfm(){
		/* ningtn add for pos start @ 20100722 */
		if(document.all.payType.value=="BX")
		{
			/*set 输入参数*/
			var transerial    = "000000000000";  	                  	//交易唯一号 ，将会取消
			var trantype      = "01";                                  	//交易类型
			var bMoney        = "<%=sum_money%>";					 		//缴费金额
			if(bMoney.indexOf(".") == -1) bMoney=bMoney+"00";
			var tranoper      = "<%=loginNo%>";                        	//交易操作员
			var orgid         = "<%=groupId%>";                        	//营业员归属机构
			var trannum       = "<%=phoneNo%>";                    		//电话号码
			getSysDate();       /*取boss系统时间*/
			var respstamp     = document.all.Request_time.value;       	//提交时间
			var transerialold = "<%=Rrn%>";			    				//原交易唯一号,在缴费时传入空
			var org_code      = "<%=orgCode%>";                        	//营业员归属						
			CCBCommon(transerial,trantype,bMoney,tranoper,orgid,trannum,respstamp,transerialold,org_code);
			if(ccbTran=="succ") posSubmitForm();
		}
		else if(document.all.payType.value=="BY")
		{
			var transType     = "04";																	/*交易类型 */         
			var bMoney        = "<%=sum_money%>";							/*交易金额 */         
			if(bMoney.indexOf(".") == -1) bMoney=bMoney+"00";
			var response_time = "<%=Response_time%>";                 	/*原交易日期 */       
			var rrn           = "<%=Rrn%>";                           	/*原交易系统检索号 */ 
			var instNum       = "";                                   	/*分期付款期数 */     
			var terminalId    = "<%=TerminalId%>";                    	/*原交易终端号 */
			getSysDate();       //取boss系统时间                                            
			var request_time  = document.all.Request_time.value;      	/*交易提交日期 */     
			var workno        = "<%=loginNo%>";                       	/*交易操作员 */       
			var orgCode       = "<%=orgCode%>";                       	/*营业员归属 */       
			var groupId       = "<%=groupId%>";                       	/*营业员归属机构 */   
			var phoneNo       = "<%=phoneNo%>";                   		/*交易缴费号 */       
			var toBeUpdate    = "";						          		/*预留字段 */         
			var posFlag = ICBCCommon(transType,bMoney,response_time,rrn,instNum,terminalId,request_time,workno,orgCode,groupId,phoneNo,toBeUpdate);									
			if(icbcTran=="succ") posSubmitForm();
		}else{
			posSubmitForm();
		}
		/* ningtn add for pos end @ 20100722 */
  }
  /* ningtn add for pos start @ 20100722 */
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
 /* ningtn add for pos start @ 20100722 */
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
	var path = "<%=request.getContextPath()%>/npage/innet/hljBillPrint_jc.jsp?DlgMsg=" + DlgMessage;
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

	cust_info+="手机号码：   "+document.all.phone_no.value+"|";
	cust_info+="客户姓名：   "+document.all.cust_name.value+"|";
	cust_info+="客户地址：   "+document.all.cust_addr.value+"|";
	cust_info+="证件号码：   "+document.all.cardId_no.value+"|";

	opr_info+="业务类型：存上网费，赠上网本"+"|";
	
	opr_info+="业务流水："+document.all.login_accept.value+"|";
	opr_info+="上网本品牌型号："+document.all.type_name.value+"|";
    opr_info+="IMEI码： "+"<%=IMEINo%>"+"|";


	var jkinfo="";
	jkinfo="退款合计："+document.all.total_money.value+"元";
    //jkinfo="退款合计："+document.all.total_money.value+"元  含预存话费"+document.all.pay_money.value+"元,上网费"+document.all.net_fee.value;
	
	
	opr_info+=jkinfo+"|";
	note_info1+="备注；"+"|";
	retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
	retInfo=retInfo.replace(new RegExp("#","gm"),"%23");
	return retInfo;
}

//-->
</script>

</head>
<body>
<form name="frm" method="post" action="f8663_2.jsp" onKeyUp="chgFocus(frm)">
<%@ include file="/npage/include/header.jsp" %>
	<div class="title">
		<div id="title_zi">用户信息</div>
	</div>
    <table cellspacing="0" >
		  <tr>
	        <td class="blue">操作类型</td>
	        <td>购上网本，赠上网费退货</td>
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
				<input name="cust_addr" value="<%=bp_add%>" type="text" Class="InputGrey" v_must=1 readonly id="cust_addr" size='50' maxlength="50" >
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
					<input type="text" name="sale_code" size="60" id="sale_code"  v_name="营销代码" value="<%=sale_name%>" readonly>
					<font class="orange">*</font>
			</td>
	</tr>
	<tr>
		    <td class="blue">退话费和上网费</td>
			<td>
					<input type="text" name="pay_money" id="pay_money"  value="<%=pay_money%>" readonly>
			<font class="orange">*</font>
			</td>
            <td class="blue">退笔记本款</td>
            <td>
			  		<input type="text" name="phone_money" id="phone_money" v_name="退购机款" value="<%=phone_money%>" readonly>
			  		<font class="orange">*</font>
			</td>
		</tr>
	<tr>
            <td class="blue">应退金额</td>
            <td>
					<input name="total_money" type="text"  id="total_money" value="<%=total_money%>" readonly>
					<font class="orange">*</font>
			</td>

            <td class="blue" >备注</td>
            <td colspan="3">
			     <input name="opNote" type="text"  id="opNote" size="60" maxlength="60" value="购上网本，赠上网费退货" >
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
	<input type="hidden" name="IMEINo" value="<%=IMEINo%>" >
	<!-- ningtn add for pos start @ 20100722 -->
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
	<!-- ningtn add for pos start @ 20100722 -->
    <%@ include file="/npage/include/footer.jsp" %>
</form>
</body>
<!-- **** ningtn add for pos @ 20100722 ******加载建行控件页 BankCtrl ******** -->
<%@ include file="/npage/public/posCCB.jsp" %>
<!-- **** ningtn add for pos @ 20100722 ******加载工行控件页 KeeperClient ******** -->
<%@ include file="/npage/public/posICBC.jsp" %>
</html>



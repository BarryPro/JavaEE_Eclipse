<%
/********************
 version v2.0
开发商: si-tech
update: sunaj@2010-02-26
********************/
%>
 <!DOCTYPE html PUBLIC "-//W3C//Dtd XHTML 1.0 transitional//EN" "http://www.w3.org/tr/xhtml1/Dtd/xhtml1-transitional.dtd">
<%
  response.setHeader("Pragma","No-cache");
  response.setHeader("Cache-Control","no-cache");
  response.setDateHeader("Expires", 0);
%>

<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="../../npage/bill/getMaxAccept.jsp" %>
<%@ include file="/npage/include/public_title_name.jsp" %>

<%
  String opCode = "8375";     
  String opName = "赠送预存款方案配置";

  String loginNo   = (String)session.getAttribute("workNo");
  String loginName = (String)session.getAttribute("workName");
  String powerCode = (String)session.getAttribute("powerCode");
  String orgCode   = (String)session.getAttribute("orgCode");
  String ipAddr   = (String)session.getAttribute("ipAddr");
  String loginNoPass = (String)session.getAttribute("password");
  String regionCode=orgCode.substring(0,2);
  String sqlStr="";
  int recordNum=0;
  int i=0;
  String printAccept="";
  printAccept = getMaxAccept();

  String  inputParsm [] = new String[1];	
  String prtSql="select lpad(to_char(nvl(max(project_code),0)+1),4,'0') project_code from sactivecode";
  inputParsm[0]=prtSql;
%>
	<wtc:service name="sPubSelect" routerKey="regioncode" routerValue="<%=regionCode%>" retcode="retCode1" retmsg="retMsg1" outnum="1">
	<wtc:param value="<%=inputParsm[0]%>"/>	
	</wtc:service>	
	<wtc:array id="tempArr"  scope="end"/>
<%	
	String project_code=tempArr[0][0];
%>

<head>
<title><%=opName%></title>

<META content="no-cache" http-equiv="Pragma">
<META content="no-cache" http-equiv="Cache-Control">
<META content="0" 	     http-equiv="Expires" >
<meta http-equiv="Content-Type" content="text/html; charset=GBK">

 <script language=javascript>
function checkAward()
{
 	if(document.all.need_award.checked)
 	{
 	 	giftInfo.style.display="";
 	}else{
 		giftInfo.style.display="none";		
 	}
}
//begin huangrong add 外围渠道开展的活动不允许配置赠送礼品 2011-8-22 
function checkChannelConfigure(bing)
{	 

 	if(bing.checked==false)
 	{
 		giveGift.style.display="";
	 	if(document.all.need_award.checked)
	 	{
	 	 	giftInfo.style.display="";
	 	}else{
	 		giftInfo.style.display="none";		
	 	}	 
	
 	}else{
 		giveGift.style.display="none";
 		giftInfo.style.display="none";
 		document.all.need_award.checked=false;
 	}	
 	//判断如果选择的是银行的则弹出选择具体银行的界面，方便用户操作
 	if(bing.checked==true)
 	{
		var prop="dialogHeight:600px; dialogWidth:550px; dialogLeft:400px; dialogTop:200px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no";
		var ret = window.showModalDialog("getBankChannel.jsp","",prop);
		if(ret!=undefined){
			document.all.channelChecked.value = ret;
		}else{
			rdShowMessageDialog("您未选择渠道！");
			bing.checked=false; 
			checkChannelConfigure(bing);  	
		}
 	}
 	if(bing.checked==false)
 	{
 		document.all.channelChecked.value="";
 	}
 	
}
//end huangrong add 外围渠道开展的活动不允许配置赠送礼品 2011-8-22 
function opChange()
{
	if(document.all.projectTypeSel[0].checked==true) 
	{
		document.getElementById('dis1').style.display='';
		document.getElementById('dis2').style.display='none';
		document.getElementById('dis3').style.display='none';
	}else
	{
		document.getElementById('dis1').style.display='none'
		document.getElementById('dis2').style.display='';
		document.getElementById('dis3').style.display='';

		var myPacket = new AJAXPacket("f8375_Seq.jsp","正在获得活动类型序列，请稍候......");
    	core.ajax.sendPacket(myPacket,doAjaxGetMsg);	
	}
}
function doAjaxGetMsg(packet)
{
    var retCode = packet.data.findValueByName("retCode");
   	var retMsg = packet.data.findValueByName("retMsg");
   	var project_type = packet.data.findValueByName("project_type");

    if(retCode!=0)
    {
    	rdShowMessageDialog(retMsg);
    	return false;
    }
	document.all.projectTypeAdd.value = project_type;
}
function pointchange()
{
	if(parseFloat(document.frm.return_fee.value)>0)
	{
		ReturnFee.style.display="";
		ActionCode.style.display="";//huangrong 增加 对经分活动编码文本框的的显隐
	}
	else
	{
		ActionCode.style.display="none";//huangrong 增加 对经分活动编码文本框的的显隐
	}
}
//begin huangrong添加对备注信息的验证 2010-10-21 13:09
function checkset(obj)
{
	if (obj.length>=500)
	{
		rdShowMessageDialog("最多只能填500个汉字",1);
		return;
	}
	if(obj.indexOf(",")!=-1||obj.indexOf("\"")!=-1||obj.indexOf("\n")!=-1)
	{
		rdShowMessageDialog("销售品描述中不能有英文逗号或双引号或回车换行，请重新输入",1);
		document.all.offerComments.focus();
		return false;	
	}
}
//end huangrong添加对备注信息的验证 2010-10-21 13:09
function checkAudit(obj)
{  
	var radio1 = obj.sAudit;
	document.all.OpFlag.value=radio1;
	
	document.getElementById("qryOprInfoFrame").style.display="block";
	document.qryOprInfoFrame.location = "f8375_Audit.jsp?opflag="+radio1;
	document.all.confirm.disabled=false;
}
function check()
{
	with(document.frm)
	{
		if(!forMoney(base_fee)) return false;
		if(!forMoney(free_fee)) return false;
		if(!forMoney(return_fee)) return false;
		if(!forMoney(month_basefee)) return false;
		if(!forMoney(month_consume)) return false;

		if(parseFloat(base_fee.value) < 0 || parseFloat(base_fee.value)  > 30000 )
		{
			rdShowMessageDialog("业务规定底线预存款需要在0元~30000元之间!");
			base_fee.value="";
			return false;	
		}
		if(parseFloat(free_fee.value) < 0 || parseFloat(free_fee.value)  > 5000)
		{
			rdShowMessageDialog("业务规定活动预存款需要在0元~5000元之间!");
			free_fee.value="";
			return false;	
		}
		if(parseFloat(return_fee.value) < 0 || parseFloat(return_fee.value)  > 3000 )
		{
			rdShowMessageDialog("业务规定赠送预存款需要在0元~3000元之间!");
			return_fee.value="1";
			return false;	
		}
		if(parseFloat(month_basefee.value) < 0 || parseFloat(month_basefee.value)  > 2000 )
		{
			rdShowMessageDialog("业务规定每月贡献值需要在0元~2000元之间!");
			month_basefee.value="";
			return false;	
		}
		if(parseFloat(month_consume.value) < 0 || parseFloat(month_consume.value) > 2000 )
		{
			rdShowMessageDialog("业务规定每月最低消费需要在0元~2000元之间!");
			month_consume.value="";
			return false;	
		}
		if(parseInt(base_term.value) < 0 || parseInt(base_term.value) > 50 )
		{
			rdShowMessageDialog("业务规定底线预存款消费期限需要在0月~50个月之间!");
			base_term.value="";
			return false;	
		}
		if(parseInt(return_term.value) < 0 || parseInt(return_term.value) > 50 )
		{
			rdShowMessageDialog("业务规定赠送预存款月数需要在0月~50个月之间!");
			return_term.value="";
			return false;	
		}
		if(parseInt(free_term.value) < 0 || parseInt(free_term.value) > 50 )
		{
			rdShowMessageDialog("业务规定活动预存款消费期限需要在0月~50个月之间!");
			free_term.value="";
			return false;	
		}
		if(parseInt(cash_fee.value) < 0 || parseInt(cash_fee.value) >2000 )
		{
			rdShowMessageDialog("业务规定现金需要在0元~2000元之间!");
			cash_fee.value="";
			return false;	
		}
		if(	(parseFloat(return_fee.value) > 0) && ($("#return_paytype").val() == "T"))
		{
			if(parseInt(return_date.value) <= 3 || parseInt(return_date.value) > 26 )
			{
				rdShowMessageDialog("赠送预存款每月返回日期必须在4日~25日之间!");
				return_date.value="";
				return false;	
			}
		}
		//2012/1/5 wanghfa添加
		if(	(parseFloat(return_fee.value) > 0) && ($("#return_paytype").val() == "DL")) {
			if(parseInt(month_basefee.value.trim()) != 0) {
				rdShowMessageDialog("每月最低消费必须为0！");
				return false;
			} else if (parseInt(return_date.value.trim()) != 0) {
				rdShowMessageDialog("赠送预存款每月返款日期必须为0！");
				return false;
			}
		}
		if (!checkElement(document.getElementById("innetTime"))) {
			return false;
		}
		
		if(parseFloat(base_fee.value) > 0 )
		{
			if(parseInt(base_term.value) <= 0 )
			{
				rdShowMessageDialog("底线预存款大于0时，需要配置相应的底线预存消费期限!");
				base_term.value="";
				return false;	
			}
		}
		if(parseFloat(free_fee.value) > 0 )
		{
			if(parseInt(free_term.value) <= 0 )
			{
				rdShowMessageDialog("活动预存款大于0时，需要配置相应的活动预存消费期限!");
				free_term.value="";
				return false;	
			}
		}
	}
	return true;
}
function printCommit()
{
	if(document.all.projectTypeSel[1].checked==true)
	{
		if(document.frm.projectNameAdd.value.trim().len()==0)
		{
			rdShowMessageDialog("活动名称不能为空!");
			return false;	
		} 
	}
	
	if(document.frm.file_name.value.trim().len()==0){
		rdShowMessageDialog("省公司审批文件名不能为空!");
		return false;	
	}
	if(document.frm.file_no.value.trim().len()==0){
		rdShowMessageDialog("省公司审批文件号不能为空!");
		return false;	
	}
	if(document.frm.audit_name.value.trim().len()==0){
		rdShowMessageDialog("申请人姓名不能为空!");
		return false;	
	}
	if(document.frm.audit_phone.value.trim().len()==0){
		rdShowMessageDialog("申请人电话不能为空!");
		return false;	
	}
	if(document.frm.project_name.value.trim().len()==0){
		rdShowMessageDialog("活动名称不能为空!");
		return false;	
	}
	if(document.frm.base_fee.value.trim().len()==0){
		rdShowMessageDialog("底线预存款不能为空!");
		return false;	
	}
	if(document.frm.base_term.value.trim().len()==0){
		rdShowMessageDialog("底线预存消费期限不能为空!");
		return false;	
	}
	if(document.frm.free_fee.value.trim().len()==0){
		rdShowMessageDialog("活动预存款不能为空!");
		return false;	
	}
	if(document.frm.free_term.value.trim().len()==0){
		rdShowMessageDialog("活动预存消费期限不能为空!");
		return false;	
	}
	if(document.frm.return_fee.value.trim().len()==0){
		rdShowMessageDialog("赠送预存款不能为空!");
		return false;	
	}
	if(document.frm.begin_time.value.trim().len()!=8){
		rdShowMessageDialog("营销开始时间格式不对!");
		document.frm.begin_time.value="";
		return false;	
	}
	if(document.frm.stop_time.value.trim().len()!=8){
		rdShowMessageDialog("营销结束时间格式不对!");
		document.frm.stop_time.value="";
		return false;	
	}
	if(parseInt(document.frm.stop_time.value.trim()) <= parseInt(document.frm.begin_time.value.trim())){
		rdShowMessageDialog("结束时间不可以小于开始时间!");
		return false;	
	}
	if(document.frm.month_basefee.value.trim().len()==0){
		rdShowMessageDialog("每月最低消费不能为空!");
		return false;	
	}
	if(document.frm.month_consume.value.trim().len()==0){
		rdShowMessageDialog("每月最少贡献值不能为空!");
		return false;	
	}
	if(document.frm.consume_mark.value.trim().len()==0){
		rdShowMessageDialog("消费积分不可为空!");
		return false;	
	}
	if(document.frm.return_date.value.trim().len()==0){
		rdShowMessageDialog("赠送预存款返回日期不可为空!");
		return false;	
	}
	//begin  huangrong 添加 验证当每月赠送预存款值大于零时经分活动编码的值不能为空
	if(parseFloat(document.frm.return_fee.value)>0)
	{
		if(document.frm.action_code.value.trim().len()==0){
		rdShowMessageDialog("经分活动编码不能为空!");
		return false;	
		}
	}	
	//end
	//begin  huangrong 添加 验证备注信息的输入的验证 2010-10-21 13:13
	if(document.frm.do_note.value.trim().length>=500)
	{
		rdShowMessageDialog("备注内容最多只能填500个汉字",1);
		return;
	}
	if(document.all.do_note.value.indexOf(",")!=-1||document.all.do_note.value.indexOf("\"")!=-1||document.all.do_note.value.indexOf("\n")!=-1)
	{
		rdShowMessageDialog("备注中不能有英文逗号或英文双引号或空格或回车，请重新输入",1);
		document.all.offerComments.focus();
		return false;	
	}
	//end  huangrong 添加 验证备注信息的输入的验证 2010-10-21 13:13
	
	if ($("#pointOfferIds").attr("checked") && typeof(document.getElementById("offerMsgs").childNodes[0].childNodes[1]) == "undefined") {
		rdShowMessageDialog("如果选择“指定资费办理的配置”，必须配置指定资费！", 1);
		return false;
	}
	
	if(document.frm.work_men.value.trim().len()==0)
	{
		rdShowMessageDialog("请选择审批组!");
		return false;
	}
	if(document.all.need_award.checked)
 	{
		if((document.all.gift_code.value.trim().len()!=6)||(document.all.gift_grade.value.trim().len()!=2))	
		{
			rdShowMessageDialog("促销品方案代码是6位,礼品等级是2位!请重新输入!",0);
			document.getElementById("gift_code").value = "";
			document.getElementById("gift_grade").value = "";
			document.all.gift_code.focus();
			return false;
		}	
	}
	/*begin add 获取底线预存类型、活动预存类型 by diling@2012/2/3*/
	var typeOfBaseFees = document.getElementsByName("typeOfBaseFee");
	var typeOfBaseFeeValue = "";
	for(var i=0;i<typeOfBaseFees.length;i++){
		if(typeOfBaseFees[i].checked){
			typeOfBaseFeeValue = typeOfBaseFees[i].value;
		}
	}
	$("#typeOfBaseFeeValue").val(typeOfBaseFeeValue);
	
	
	var typeOfFreeFees = document.getElementsByName("typeOfFreeFee");
	var typeOfFreeFeeValue = "";
	for(var i=0;i<typeOfFreeFees.length;i++){
		if(typeOfFreeFees[i].checked){
			typeOfFreeFeeValue = typeOfFreeFees[i].value;
		}
	}
	$("#typeOfFreeFeeValue").val(typeOfFreeFeeValue);
	/*end add by diling*/
	
	
	if(!check()) return false;
	document.all.confirm.disabled=true;//防止二次确认	
	frm.submit();
}

// add by wanglma 
function doChange(flag){
    $("#return_date").attr("readonly",false);
    $("#base_fee").attr("readonly",false);
    $("#month_basefee").attr("readonly",false);
    $("#base_term").attr("readonly",false);
	var return_fee = $("#return_fee").val() ;
	if(!forMoney(document.frm.return_fee)) return false;
	if(parseFloat(return_fee) > 0 ){
		if(flag == "CZ"){
			$("#return_date").val("0");
			$("#return_date").attr("readonly",true);
			$("#base_fee").val("0");
			$("#base_fee").attr("readonly",true);
			$("#month_basefee").val("0");
			$("#month_basefee").attr("readonly",true);
			$("#base_term").val("0");
			$("#base_term").attr("readonly",true);
		} else if (flag == "DL") {
			$("#return_date").val("0");
			$("#return_date").attr("readonly",true);
			$("#month_basefee").val("0");
			$("#month_basefee").attr("readonly",true);
		}
	}
   	
}
	function addOffer() {
		var addBool = true;
		if (!checkElement(document.getElementById("offerIdInput"))) {
			return false;
		} else {
			var offerNo = 0;
			var offerId = $("#offerIdInput").val();
			$("input[name=offerId]").each(function() {
				offerNo ++;
				if (this.value == offerId) {
					rdShowMessageDialog("此资费已经添加，不允许重复添加！", 1);
					addBool = false;
				}
			});
			if (addBool == true && offerNo >= 50) {
				rdShowMessageDialog("资费最多添加50个，不允许添加！", 1);
				return false;
			}
		}
		if (addBool) {
			var offerId = $("#offerIdInput").val();
			var getOfferMsgPacket = new AJAXPacket("f8375_getOfferMsg.jsp", "请稍候......");
			getOfferMsgPacket.data.add("offerId", offerId);
			core.ajax.sendPacket(getOfferMsgPacket, doGetOfferMsgPacket);	
			getOfferMsgPacket = null;
		}
	}
	
	function doGetOfferMsgPacket(packet) {
		var retCode = packet.data.findValueByName("retCode");
		var no = packet.data.findValueByName("no");
		var offerId = packet.data.findValueByName("offerId");
		var offerName = packet.data.findValueByName("offerName");
		var offerComments = packet.data.findValueByName("offerComments");
		
		if (retCode == "000000" && no != "0") {
			var trTemp = document.getElementById("offerMsgs").insertRow();
			trTemp.insertCell().innerHTML = "<input type='text' class='InputGrey' name='offerId' value='" + offerId + "' readonly>";
			trTemp.insertCell().innerHTML = "<input type='text' class='InputGrey' name='offerName' value='" + offerName + "' readonly>";
			trTemp.insertCell().innerHTML = offerComments;
			trTemp.insertCell().innerHTML = "<input type='button' class='b_text' name='' id='' value='删除' onclick='deleteOfferRow(this)'/>";
			
		} else {
			rdShowMessageDialog("添加资费错误！资费不是本地市有效的主资费！", 1);
		}
	}
	
	function deleteOfferRow(obj){
		var tableTemp = document.getElementById("offerMsgs");
		tableTemp.deleteRow(obj.parentElement.parentElement.rowIndex);
	}
	
	function displayOfferIds() {
		if ($("#pointOfferIds").attr("checked")) {
			$("#pointOfferIdsDiv").show();
			$("#hasOfferId").val("1");
			//$("#offerIdInputTr").show();
		} else {
			$("#pointOfferIdsDiv").hide();
			$("#hasOfferId").val("0");
			//$("#offerIdInputTr").hide();
		}
	}
	
	/*begin add 每个底线预存类型对一个活动预存类型 by diling@2012/2/3*/
	function chgBaseFee(obj){
		if(obj.value=="CC"){
			$("#typeOfFreeFeeActivity").attr("checked","checked");
			$("#typeOfFreeFeeOwn").attr("checked","");
		}
		if(obj.value=="DP"){
			$("#typeOfFreeFeeActivity").attr("checked","");
			$("#typeOfFreeFeeOwn").attr("checked","checked");
		}
	}
	/*end add by diling*/
</script>
	
</head>
<body>
<form name="frm" method="post" action="f8375_2.jsp" onKeyUp="chgFocus(frm)">
<%@ include file="/npage/include/header.jsp" %>
	<div class="title">
		<div id="title_zi">赠送预存款方案信息</div>
	</div>
  <table  cellspacing="0">
	<tr>
            <td class="blue">活动类型</td>
            <td class="blue">选择已有<input type = 'radio' name='projectTypeSel' checked value="one" onclick="opChange()">&nbsp;&nbsp;
            				新增<input type = 'radio' name='projectTypeSel' value="two" onclick="opChange()"></td>
            <td class="blue" width="70%" id=dis1>
            <select id="projectType" name="projectType" onChange="chkType()">
		    <%	
		    	sqlStr ="select trim(project_type),trim(type_name) from sactivetype where op_code='8379' and region_code='"+regionCode+"'";
		    	String[] inParas1 = new String[2];
		    	inParas1[0] = "select trim(project_type),trim(type_name) from sactivetype where op_code='8379' and region_code=:region_code";
				inParas1[1] = "region_code="+regionCode;
				System.out.println("sqlStr === "+ sqlStr);
			%>
			<wtc:service name="TlsPubSelCrm"  outnum="2" retcode="retCode1" retmsg="regMsg1">
				<wtc:param value="<%=inParas1[0]%>"/>
				<wtc:param value="<%=inParas1[1]%>"/> 
			</wtc:service>
			<wtc:array id="result" scope="end"/>
			<%
				recordNum = result.length;
				for(i=0;i<recordNum;i++)
				{
					out.println("<option class='button' value='" + result[i][0] + "'>" + result[i][0]+"-->"+result[i][1] + "</option>");
				}
			%>
		   </select>
		   </td>
		   <td class="blue" style='display:none' id=dis2>活动类型&nbsp;<input type=text name='projectTypeAdd' class="InputGrey" readonly></td>
		   <td class="blue" style='display:none' id=dis3>类型名称&nbsp;<input type=text name='projectNameAdd' maxlength="30">&nbsp;<font class="orange">*</font></td>
     </tr>
    </table>
<br>
	 <div class="title">
		<div id="title_zi">基本信息</div>
	</div>
	<table cellspacing="0">
	<tr>
            <td class="blue" width="20%">省公司审批文件名</td>
            <td width="30%">
					<input name="file_name" type="text"  id="file_name" maxlength="30" >
					<font class="orange">*</font>
            </td>
            <td class="blue" width="20%">省公司审批文件号</td>
            <td width="30%">
					<input name="file_no" type="text" id="file_no" maxlength="30" >
					<font class="orange">*</font>
            </td>
		</tr>
	<tr>
            <td class="blue">申请人姓名</td>
            <td>
						  <input name="audit_name"  type="text" id="audit_name" maxlength="6">
						  <font class="orange">*</font>
            </td>
            <td class="blue">申请人电话</td>
            <td>
						  <input name="audit_phone" type="text" id="audit_phone" maxlength="15">
						  <font class="orange">*</font>
            </td>
		</tr>
	<tr>
			<td class="blue">活动代码</td>
            <td>
						  <input name="project_code" type="text" id="project_code" value="<%=project_code%>" class="InputGrey" readonly>
						  <font class="orange">*</font>
            </td>
            <td class="blue">活动名称</td>
            <td>
						  <input name="project_name" type="text" id="project_name"  maxlength="30">
						  <font class="orange">*</font>
            </td>
  </tr>
  <!--begin add 底线预存类型 by diling@2012/2/3--> 
	<tr>
	    <td class="blue">底线预存类型</td>
	    <td class="blue" colspan="3">
				<input type = "radio" name="typeOfBaseFee" checked="checked" value="CC" onclick="chgBaseFee(this)" />CC-->底线预存&nbsp;&nbsp;
				<input type = "radio" name="typeOfBaseFee" value="DP" onclick="chgBaseFee(this)" />DP-->自有底线预存
				<input type='hidden' name='typeOfBaseFeeValue' id='typeOfBaseFeeValue' value='' />
	    </td>
	</tr>
	 <!--end add 底线预存类型 --> 
	<tr>
            <td class="blue">底线预存款</td>
            <td>
						  <input name="base_fee" type="text" id="base_fee" >(0~30000元)
						  <font class="orange">*</font>
            </td>
            <td class="blue">底线预存消费期限</td>
            <td>
						  <input name="base_term" type="text" id="base_term" >(0~50月)
						  <font class="orange">*</font>
            </td>
     	</tr>
   <!--begin add 活动预存类型 by diling@2012/2/3--> 
	<tr>
	    <td class="blue">活动预存类型</td>
	    <td class="blue" colspan="3">
				<input type = "radio" name="typeOfFreeFee" id="typeOfFreeFeeActivity" checked="checked" value="CD" disabled  />CD-->活动预存&nbsp;&nbsp;
				<input type = "radio" name="typeOfFreeFee" id="typeOfFreeFeeOwn" value="DQ" disabled />DQ-->自有活动预存
				<input type='hidden' name='typeOfFreeFeeValue' id='typeOfFreeFeeValue' value='' />
	    </td>
	</tr>
	 <!--end add by diling --> 
	<tr>
            <td class="blue">活动预存款</td>
            <td>
						  <input name="free_fee" type="text" id="free_fee" >(0~5000元)
						  <font class="orange">*</font>
            </td>
            <td class="blue">活动预存消费期限</td>
            <td>
						  <input name="free_term" type="text" id="free_term" >(0~50月)
						  <font class="orange">*</font>
            </td>
     	</tr>
	<tr>
			 <td class="blue">每月赠送预存款</td>
            <td>
						  <input name="return_fee" type="text" id="return_fee" onchange="pointchange()">(0~3000元)
						  <font class="orange">*</font>
            </td>
             <td class="blue">赠送预存款月数</td>
            <td>
						  <input name="return_term" type="text" id="return_term" >(0~50月)
						  <font class="orange">*</font>
            </td>
		</tr>
		<tr id="ReturnFee" style="display:none;">
			<td class="blue">赠送预存款专款类型</td>
			<td>
				<SELECT id="return_paytype" name="return_paytype" onchange="doChange(this.value)" >
					<%
					sqlStr = "select pay_type, pay_name from spaytype where pay_type in ('T', 'CZ', 'DL')";
					%>
					<wtc:service name="TlsPubSelCrm"  outnum="2" retcode="retCode1" retmsg="regMsg1">
						<wtc:param value="<%=sqlStr%>"/>
					</wtc:service>
					<wtc:array id="result1" scope="end"/>
					<%
					recordNum = result1.length;
					for(i = 0; i < result1.length; i ++) {
						%>
						<option value="<%=result1[i][0]%>"><%=result1[i][0]%>--<%=result1[i][1]%></option>
						<%
					}
					%>
				</select>
				<font color="orange">*</font>
			</td>
			<td class="blue">赠送预存款每月返款日期</td>
            <td>
						  <input name="return_date"  type="text" type="text" id="return_date" value="0" maxlength="2">(4~25日)
						  <font class="orange">*</font>
            </td>	
         	</tr>
     <!--begin  huangrong 添加对经分活动编码的显示-->   	
      <tr id="ActionCode" style="display:none;">
			<td class="blue">经分活动编码</td>
            <td colspan="3">
						  <input name="action_code"  type="text" id="action_code" value="" maxlength="10" style="ime-mode:disabled" onKeyPress="return isKeyNumberdot(0)" >
						  <font class="orange">*<br/>
						  赠送预存款专款类型为“CZ”并且每月赠送预存款大于0时，赠送预存款每月返款日期，底线预存，每月最低消费，底线预存消费期限必须是0.<br/>
						  赠送预存款专款类型为“DL”并且每月赠送预存款大于0时，赠送预存款每月返款日期，每月最低消费必须是0.<br/>
						  </font>
            </td>	
         	</tr> 
      <!--end-->   	        	
    <tr>
    		<td class="blue">现金</td>
            <td>
						  <input name="cash_fee" type="text" id="cash_fee" >(0~2000元)
						  <font class="orange">*</font>
            </td>
            <td class="blue">消费积分</td>
            <td>
						  <input name="consume_mark"  type="text" type="text" id="consume_mark" >分
						  <font class="orange">*</font>
            </td>
    	</tr>
    <tr>
            <td class="blue">每月最低消费</td>
            <td>
						  <input name="month_basefee" type="text" id="month_basefee" >(0~2000元)
						  <font class="orange">*</font>
            </td>
            <td class="blue">每月最少贡献值</td>
            <td>
						  <input name="month_consume" type="text" id="month_consume" >(0~2000元)
						  <font class="orange">*</font>
            </td>
      	</tr>
	<tr>
		<td class="blue">营销开始时间</td> 
		<td>
			<input name="begin_time" type="text" id="begin_time" maxlength="8">(YYYYMMDD)
			<font class="orange">*</font>
		</td>
		<td class="blue">营销结束时间</td>
		<td>
			<input name="stop_time" type="text" id="stop_time" maxlength="8">(YYYYMMDD)
			<font class="orange">*</font>
		</td>
 	</tr>
	<tr>
		<td class="blue">入网时间</td>
		<td colspan='3'>
			<input type="text" name="innetTime" id="innetTime" value="0" maxlength="10" v_maxlength="10" v_type="int" v_minvalue="0" v_minvalue="9999999999"/>天
		</td>
	</tr>
   <!--begin  huangrong 添加渠道配置  2011-8-22 -->     
  <tr>
					<td class="blue">渠道配置</td>
					<td colspan='3'>
						<input type="checkbox" name="channelConfigure" onclick="checkChannelConfigure(this)"/>					
					</td>
	</tr>
   <!--end  huangrong 添加渠道配置  2011-8-22 -->        	
	<tr>
		<td class="blue">指定资费办理的配置</td>
		<td colspan='3'>
			<input type="checkbox" name="pointOfferIds" id="pointOfferIds" onclick="displayOfferIds()"/>					
		</td>
	</tr>
   <!--begin  huangrong 添加对备注的显示  2010-10-21 13:06-->   	 	
  <tr>
					<td class="blue">免填单备注</td>
					<td colspan='3'>
						<TEXTAREA NAME="do_note" id="do_note" maxlength="500"  COLS="60" ROWS="3" onkeyup="checkset(this.value)"></TEXTAREA>(限填500个字)
					</td>
	</tr>  
   <!--end  huangrong 添加对备注的显示  2010-10-21 13:06-->   
	<tr id="giveGift">
           <td class="blue" >是否参与赠礼</td>
           <td colspan="3">
								<input type="checkbox" name="need_award" onclick="checkAward()" />
			</td>
	</tr>
	<tr id="giftInfo" style="display:none;">
            <td class="blue">促销品方案代码</td>
            <td>
					<input name="gift_code" type="text"  id="gift_code" maxlength="6" >
					<font class="orange">*</font>
            </td>
            <td class="blue">礼品等级</td>
            <td>
					<input name="gift_grade" type="text" id="gift_grade" maxlength="2" >
					<font class="orange">*</font>
            </td>
	</tr>
		<tr>
           <td class="blue" >请选择审批组</td>
           <td colspan="3">
				<input type="radio" name="opFlag" value="one" sAudit="one" onclick="checkAudit(this)">品牌发展团队&nbsp;&nbsp;&nbsp;&nbsp;
				<input type="radio" name="opFlag" value="two" sAudit="two" onclick="checkAudit(this)">增值业务团队
			</td>
	</tr>
	</table>
	<table cellspacing="0">
			<tr>
				<td style="height:0;">
					<iframe frameBorder="0" id="qryOprInfoFrame" align="center" name="qryOprInfoFrame" scrolling="yes" style="height:300px;overflow-y:auto; visibility:inherit; width:100%; z-index:1; display:none;"  onload="document.getElementById('qryOprInfoFrame').style.height=qryOprInfoFrame.document.body.scrollHeight+'px'"></iframe>
				</td>
			</tr>
		</table>
	<div name="pointOfferIdsDiv" id="pointOfferIdsDiv" style="display:none">
		<div class="title">
			<div id="title_zi">指定资费办理的配置</div>
		</div>
		<table>
			<tr>
				<td class="blue">资费代码</td>
				<td colspan="3">
					<input type="text" name="offerIdInput" id="offerIdInput" v_must="1" maxlength="6">
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					<input type="button" class="b_text" onclick="addOffer()" value="添加资费"/>
				</td>
			</tr>
		<table>
	  <table name="offerMsgs" id="offerMsgs">
	  	<tr>
	  		<th width="15%">资费代码</td>
	  		<th width="20%">资费名称</td>
	  		<th width="50%">资费描述</td>
	  		<th width="15%">操作</td>
	  	</tr>
	  </table>
	</div>
<input type="hidden" name="hasOfferId" id="hasOfferId" value="0">

	<table cellspacing="0"> 
	<tr>
            <td colspan="6" align="center" id="footer">
                <input name="confirm" type="button" class="b_foot" index="2" value="确认" onClick="printCommit()" >
                <input name="reset" type="reset" class="b_foot" value="清除" >
                <input name="back" onClick="history.go(-1);" type="button" class="b_foot" value="返回">
            </td>
	</tr>
	</table>
	<input type="hidden" name="giftcodestr" >
	<input type="hidden" name="giftgradestr" >
    <input type="hidden" name="work_men" >
    <input type="hidden" name="work_menname" >
    <input type="hidden" name="login_accept" value="<%=printAccept%>">
    <input type="hidden" name="audit_no"  value="2" type="text" id="audit_no" >
    <input type="hidden" name="award_flag" value="0" />
    <input type="hidden" name="count" >
    <input type="hidden" name="OpFlag" >
    <input type="hidden" name="channelChecked" > <!--huangrong add 存放已选择的银行渠道 2011-8-23-->

	<%@ include file="/npage/include/footer.jsp" %>
</form>
</body>
</html>



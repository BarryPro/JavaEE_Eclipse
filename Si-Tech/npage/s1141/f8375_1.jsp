<%
/********************
 version v2.0
������: si-tech
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
  String opName = "����Ԥ��������";

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
//begin huangrong add ��Χ������չ�Ļ����������������Ʒ 2011-8-22 
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
 	//�ж����ѡ��������е��򵯳�ѡ��������еĽ��棬�����û�����
 	if(bing.checked==true)
 	{
		var prop="dialogHeight:600px; dialogWidth:550px; dialogLeft:400px; dialogTop:200px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no";
		var ret = window.showModalDialog("getBankChannel.jsp","",prop);
		if(ret!=undefined){
			document.all.channelChecked.value = ret;
		}else{
			rdShowMessageDialog("��δѡ��������");
			bing.checked=false; 
			checkChannelConfigure(bing);  	
		}
 	}
 	if(bing.checked==false)
 	{
 		document.all.channelChecked.value="";
 	}
 	
}
//end huangrong add ��Χ������չ�Ļ����������������Ʒ 2011-8-22 
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

		var myPacket = new AJAXPacket("f8375_Seq.jsp","���ڻ�û�������У����Ժ�......");
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
		ActionCode.style.display="";//huangrong ���� �Ծ��ֻ�����ı���ĵ�����
	}
	else
	{
		ActionCode.style.display="none";//huangrong ���� �Ծ��ֻ�����ı���ĵ�����
	}
}
//begin huangrong��ӶԱ�ע��Ϣ����֤ 2010-10-21 13:09
function checkset(obj)
{
	if (obj.length>=500)
	{
		rdShowMessageDialog("���ֻ����500������",1);
		return;
	}
	if(obj.indexOf(",")!=-1||obj.indexOf("\"")!=-1||obj.indexOf("\n")!=-1)
	{
		rdShowMessageDialog("����Ʒ�����в�����Ӣ�Ķ��Ż�˫���Ż�س����У�����������",1);
		document.all.offerComments.focus();
		return false;	
	}
}
//end huangrong��ӶԱ�ע��Ϣ����֤ 2010-10-21 13:09
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
			rdShowMessageDialog("ҵ��涨����Ԥ�����Ҫ��0Ԫ~30000Ԫ֮��!");
			base_fee.value="";
			return false;	
		}
		if(parseFloat(free_fee.value) < 0 || parseFloat(free_fee.value)  > 5000)
		{
			rdShowMessageDialog("ҵ��涨�Ԥ�����Ҫ��0Ԫ~5000Ԫ֮��!");
			free_fee.value="";
			return false;	
		}
		if(parseFloat(return_fee.value) < 0 || parseFloat(return_fee.value)  > 3000 )
		{
			rdShowMessageDialog("ҵ��涨����Ԥ�����Ҫ��0Ԫ~3000Ԫ֮��!");
			return_fee.value="1";
			return false;	
		}
		if(parseFloat(month_basefee.value) < 0 || parseFloat(month_basefee.value)  > 2000 )
		{
			rdShowMessageDialog("ҵ��涨ÿ�¹���ֵ��Ҫ��0Ԫ~2000Ԫ֮��!");
			month_basefee.value="";
			return false;	
		}
		if(parseFloat(month_consume.value) < 0 || parseFloat(month_consume.value) > 2000 )
		{
			rdShowMessageDialog("ҵ��涨ÿ�����������Ҫ��0Ԫ~2000Ԫ֮��!");
			month_consume.value="";
			return false;	
		}
		if(parseInt(base_term.value) < 0 || parseInt(base_term.value) > 50 )
		{
			rdShowMessageDialog("ҵ��涨����Ԥ�������������Ҫ��0��~50����֮��!");
			base_term.value="";
			return false;	
		}
		if(parseInt(return_term.value) < 0 || parseInt(return_term.value) > 50 )
		{
			rdShowMessageDialog("ҵ��涨����Ԥ���������Ҫ��0��~50����֮��!");
			return_term.value="";
			return false;	
		}
		if(parseInt(free_term.value) < 0 || parseInt(free_term.value) > 50 )
		{
			rdShowMessageDialog("ҵ��涨�Ԥ�������������Ҫ��0��~50����֮��!");
			free_term.value="";
			return false;	
		}
		if(parseInt(cash_fee.value) < 0 || parseInt(cash_fee.value) >2000 )
		{
			rdShowMessageDialog("ҵ��涨�ֽ���Ҫ��0Ԫ~2000Ԫ֮��!");
			cash_fee.value="";
			return false;	
		}
		if(	(parseFloat(return_fee.value) > 0) && ($("#return_paytype").val() == "T"))
		{
			if(parseInt(return_date.value) <= 3 || parseInt(return_date.value) > 26 )
			{
				rdShowMessageDialog("����Ԥ���ÿ�·������ڱ�����4��~25��֮��!");
				return_date.value="";
				return false;	
			}
		}
		//2012/1/5 wanghfa���
		if(	(parseFloat(return_fee.value) > 0) && ($("#return_paytype").val() == "DL")) {
			if(parseInt(month_basefee.value.trim()) != 0) {
				rdShowMessageDialog("ÿ��������ѱ���Ϊ0��");
				return false;
			} else if (parseInt(return_date.value.trim()) != 0) {
				rdShowMessageDialog("����Ԥ���ÿ�·������ڱ���Ϊ0��");
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
				rdShowMessageDialog("����Ԥ������0ʱ����Ҫ������Ӧ�ĵ���Ԥ����������!");
				base_term.value="";
				return false;	
			}
		}
		if(parseFloat(free_fee.value) > 0 )
		{
			if(parseInt(free_term.value) <= 0 )
			{
				rdShowMessageDialog("�Ԥ������0ʱ����Ҫ������Ӧ�ĻԤ����������!");
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
			rdShowMessageDialog("����Ʋ���Ϊ��!");
			return false;	
		} 
	}
	
	if(document.frm.file_name.value.trim().len()==0){
		rdShowMessageDialog("ʡ��˾�����ļ�������Ϊ��!");
		return false;	
	}
	if(document.frm.file_no.value.trim().len()==0){
		rdShowMessageDialog("ʡ��˾�����ļ��Ų���Ϊ��!");
		return false;	
	}
	if(document.frm.audit_name.value.trim().len()==0){
		rdShowMessageDialog("��������������Ϊ��!");
		return false;	
	}
	if(document.frm.audit_phone.value.trim().len()==0){
		rdShowMessageDialog("�����˵绰����Ϊ��!");
		return false;	
	}
	if(document.frm.project_name.value.trim().len()==0){
		rdShowMessageDialog("����Ʋ���Ϊ��!");
		return false;	
	}
	if(document.frm.base_fee.value.trim().len()==0){
		rdShowMessageDialog("����Ԥ����Ϊ��!");
		return false;	
	}
	if(document.frm.base_term.value.trim().len()==0){
		rdShowMessageDialog("����Ԥ���������޲���Ϊ��!");
		return false;	
	}
	if(document.frm.free_fee.value.trim().len()==0){
		rdShowMessageDialog("�Ԥ����Ϊ��!");
		return false;	
	}
	if(document.frm.free_term.value.trim().len()==0){
		rdShowMessageDialog("�Ԥ���������޲���Ϊ��!");
		return false;	
	}
	if(document.frm.return_fee.value.trim().len()==0){
		rdShowMessageDialog("����Ԥ����Ϊ��!");
		return false;	
	}
	if(document.frm.begin_time.value.trim().len()!=8){
		rdShowMessageDialog("Ӫ����ʼʱ���ʽ����!");
		document.frm.begin_time.value="";
		return false;	
	}
	if(document.frm.stop_time.value.trim().len()!=8){
		rdShowMessageDialog("Ӫ������ʱ���ʽ����!");
		document.frm.stop_time.value="";
		return false;	
	}
	if(parseInt(document.frm.stop_time.value.trim()) <= parseInt(document.frm.begin_time.value.trim())){
		rdShowMessageDialog("����ʱ�䲻����С�ڿ�ʼʱ��!");
		return false;	
	}
	if(document.frm.month_basefee.value.trim().len()==0){
		rdShowMessageDialog("ÿ��������Ѳ���Ϊ��!");
		return false;	
	}
	if(document.frm.month_consume.value.trim().len()==0){
		rdShowMessageDialog("ÿ�����ٹ���ֵ����Ϊ��!");
		return false;	
	}
	if(document.frm.consume_mark.value.trim().len()==0){
		rdShowMessageDialog("���ѻ��ֲ���Ϊ��!");
		return false;	
	}
	if(document.frm.return_date.value.trim().len()==0){
		rdShowMessageDialog("����Ԥ�������ڲ���Ϊ��!");
		return false;	
	}
	//begin  huangrong ��� ��֤��ÿ������Ԥ���ֵ������ʱ���ֻ�����ֵ����Ϊ��
	if(parseFloat(document.frm.return_fee.value)>0)
	{
		if(document.frm.action_code.value.trim().len()==0){
		rdShowMessageDialog("���ֻ���벻��Ϊ��!");
		return false;	
		}
	}	
	//end
	//begin  huangrong ��� ��֤��ע��Ϣ���������֤ 2010-10-21 13:13
	if(document.frm.do_note.value.trim().length>=500)
	{
		rdShowMessageDialog("��ע�������ֻ����500������",1);
		return;
	}
	if(document.all.do_note.value.indexOf(",")!=-1||document.all.do_note.value.indexOf("\"")!=-1||document.all.do_note.value.indexOf("\n")!=-1)
	{
		rdShowMessageDialog("��ע�в�����Ӣ�Ķ��Ż�Ӣ��˫���Ż�ո��س�������������",1);
		document.all.offerComments.focus();
		return false;	
	}
	//end  huangrong ��� ��֤��ע��Ϣ���������֤ 2010-10-21 13:13
	
	if ($("#pointOfferIds").attr("checked") && typeof(document.getElementById("offerMsgs").childNodes[0].childNodes[1]) == "undefined") {
		rdShowMessageDialog("���ѡ��ָ���ʷѰ�������á�����������ָ���ʷѣ�", 1);
		return false;
	}
	
	if(document.frm.work_men.value.trim().len()==0)
	{
		rdShowMessageDialog("��ѡ��������!");
		return false;
	}
	if(document.all.need_award.checked)
 	{
		if((document.all.gift_code.value.trim().len()!=6)||(document.all.gift_grade.value.trim().len()!=2))	
		{
			rdShowMessageDialog("����Ʒ����������6λ,��Ʒ�ȼ���2λ!����������!",0);
			document.getElementById("gift_code").value = "";
			document.getElementById("gift_grade").value = "";
			document.all.gift_code.focus();
			return false;
		}	
	}
	/*begin add ��ȡ����Ԥ�����͡��Ԥ������ by diling@2012/2/3*/
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
	document.all.confirm.disabled=true;//��ֹ����ȷ��	
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
					rdShowMessageDialog("���ʷ��Ѿ���ӣ��������ظ���ӣ�", 1);
					addBool = false;
				}
			});
			if (addBool == true && offerNo >= 50) {
				rdShowMessageDialog("�ʷ�������50������������ӣ�", 1);
				return false;
			}
		}
		if (addBool) {
			var offerId = $("#offerIdInput").val();
			var getOfferMsgPacket = new AJAXPacket("f8375_getOfferMsg.jsp", "���Ժ�......");
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
			trTemp.insertCell().innerHTML = "<input type='button' class='b_text' name='' id='' value='ɾ��' onclick='deleteOfferRow(this)'/>";
			
		} else {
			rdShowMessageDialog("����ʷѴ����ʷѲ��Ǳ�������Ч�����ʷѣ�", 1);
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
	
	/*begin add ÿ������Ԥ�����Ͷ�һ���Ԥ������ by diling@2012/2/3*/
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
		<div id="title_zi">����Ԥ������Ϣ</div>
	</div>
  <table  cellspacing="0">
	<tr>
            <td class="blue">�����</td>
            <td class="blue">ѡ������<input type = 'radio' name='projectTypeSel' checked value="one" onclick="opChange()">&nbsp;&nbsp;
            				����<input type = 'radio' name='projectTypeSel' value="two" onclick="opChange()"></td>
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
		   <td class="blue" style='display:none' id=dis2>�����&nbsp;<input type=text name='projectTypeAdd' class="InputGrey" readonly></td>
		   <td class="blue" style='display:none' id=dis3>��������&nbsp;<input type=text name='projectNameAdd' maxlength="30">&nbsp;<font class="orange">*</font></td>
     </tr>
    </table>
<br>
	 <div class="title">
		<div id="title_zi">������Ϣ</div>
	</div>
	<table cellspacing="0">
	<tr>
            <td class="blue" width="20%">ʡ��˾�����ļ���</td>
            <td width="30%">
					<input name="file_name" type="text"  id="file_name" maxlength="30" >
					<font class="orange">*</font>
            </td>
            <td class="blue" width="20%">ʡ��˾�����ļ���</td>
            <td width="30%">
					<input name="file_no" type="text" id="file_no" maxlength="30" >
					<font class="orange">*</font>
            </td>
		</tr>
	<tr>
            <td class="blue">����������</td>
            <td>
						  <input name="audit_name"  type="text" id="audit_name" maxlength="6">
						  <font class="orange">*</font>
            </td>
            <td class="blue">�����˵绰</td>
            <td>
						  <input name="audit_phone" type="text" id="audit_phone" maxlength="15">
						  <font class="orange">*</font>
            </td>
		</tr>
	<tr>
			<td class="blue">�����</td>
            <td>
						  <input name="project_code" type="text" id="project_code" value="<%=project_code%>" class="InputGrey" readonly>
						  <font class="orange">*</font>
            </td>
            <td class="blue">�����</td>
            <td>
						  <input name="project_name" type="text" id="project_name"  maxlength="30">
						  <font class="orange">*</font>
            </td>
  </tr>
  <!--begin add ����Ԥ������ by diling@2012/2/3--> 
	<tr>
	    <td class="blue">����Ԥ������</td>
	    <td class="blue" colspan="3">
				<input type = "radio" name="typeOfBaseFee" checked="checked" value="CC" onclick="chgBaseFee(this)" />CC-->����Ԥ��&nbsp;&nbsp;
				<input type = "radio" name="typeOfBaseFee" value="DP" onclick="chgBaseFee(this)" />DP-->���е���Ԥ��
				<input type='hidden' name='typeOfBaseFeeValue' id='typeOfBaseFeeValue' value='' />
	    </td>
	</tr>
	 <!--end add ����Ԥ������ --> 
	<tr>
            <td class="blue">����Ԥ���</td>
            <td>
						  <input name="base_fee" type="text" id="base_fee" >(0~30000Ԫ)
						  <font class="orange">*</font>
            </td>
            <td class="blue">����Ԥ����������</td>
            <td>
						  <input name="base_term" type="text" id="base_term" >(0~50��)
						  <font class="orange">*</font>
            </td>
     	</tr>
   <!--begin add �Ԥ������ by diling@2012/2/3--> 
	<tr>
	    <td class="blue">�Ԥ������</td>
	    <td class="blue" colspan="3">
				<input type = "radio" name="typeOfFreeFee" id="typeOfFreeFeeActivity" checked="checked" value="CD" disabled  />CD-->�Ԥ��&nbsp;&nbsp;
				<input type = "radio" name="typeOfFreeFee" id="typeOfFreeFeeOwn" value="DQ" disabled />DQ-->���лԤ��
				<input type='hidden' name='typeOfFreeFeeValue' id='typeOfFreeFeeValue' value='' />
	    </td>
	</tr>
	 <!--end add by diling --> 
	<tr>
            <td class="blue">�Ԥ���</td>
            <td>
						  <input name="free_fee" type="text" id="free_fee" >(0~5000Ԫ)
						  <font class="orange">*</font>
            </td>
            <td class="blue">�Ԥ����������</td>
            <td>
						  <input name="free_term" type="text" id="free_term" >(0~50��)
						  <font class="orange">*</font>
            </td>
     	</tr>
	<tr>
			 <td class="blue">ÿ������Ԥ���</td>
            <td>
						  <input name="return_fee" type="text" id="return_fee" onchange="pointchange()">(0~3000Ԫ)
						  <font class="orange">*</font>
            </td>
             <td class="blue">����Ԥ�������</td>
            <td>
						  <input name="return_term" type="text" id="return_term" >(0~50��)
						  <font class="orange">*</font>
            </td>
		</tr>
		<tr id="ReturnFee" style="display:none;">
			<td class="blue">����Ԥ���ר������</td>
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
			<td class="blue">����Ԥ���ÿ�·�������</td>
            <td>
						  <input name="return_date"  type="text" type="text" id="return_date" value="0" maxlength="2">(4~25��)
						  <font class="orange">*</font>
            </td>	
         	</tr>
     <!--begin  huangrong ��ӶԾ��ֻ�������ʾ-->   	
      <tr id="ActionCode" style="display:none;">
			<td class="blue">���ֻ����</td>
            <td colspan="3">
						  <input name="action_code"  type="text" id="action_code" value="" maxlength="10" style="ime-mode:disabled" onKeyPress="return isKeyNumberdot(0)" >
						  <font class="orange">*<br/>
						  ����Ԥ���ר������Ϊ��CZ������ÿ������Ԥ������0ʱ������Ԥ���ÿ�·������ڣ�����Ԥ�棬ÿ��������ѣ�����Ԥ���������ޱ�����0.<br/>
						  ����Ԥ���ר������Ϊ��DL������ÿ������Ԥ������0ʱ������Ԥ���ÿ�·������ڣ�ÿ��������ѱ�����0.<br/>
						  </font>
            </td>	
         	</tr> 
      <!--end-->   	        	
    <tr>
    		<td class="blue">�ֽ�</td>
            <td>
						  <input name="cash_fee" type="text" id="cash_fee" >(0~2000Ԫ)
						  <font class="orange">*</font>
            </td>
            <td class="blue">���ѻ���</td>
            <td>
						  <input name="consume_mark"  type="text" type="text" id="consume_mark" >��
						  <font class="orange">*</font>
            </td>
    	</tr>
    <tr>
            <td class="blue">ÿ���������</td>
            <td>
						  <input name="month_basefee" type="text" id="month_basefee" >(0~2000Ԫ)
						  <font class="orange">*</font>
            </td>
            <td class="blue">ÿ�����ٹ���ֵ</td>
            <td>
						  <input name="month_consume" type="text" id="month_consume" >(0~2000Ԫ)
						  <font class="orange">*</font>
            </td>
      	</tr>
	<tr>
		<td class="blue">Ӫ����ʼʱ��</td> 
		<td>
			<input name="begin_time" type="text" id="begin_time" maxlength="8">(YYYYMMDD)
			<font class="orange">*</font>
		</td>
		<td class="blue">Ӫ������ʱ��</td>
		<td>
			<input name="stop_time" type="text" id="stop_time" maxlength="8">(YYYYMMDD)
			<font class="orange">*</font>
		</td>
 	</tr>
	<tr>
		<td class="blue">����ʱ��</td>
		<td colspan='3'>
			<input type="text" name="innetTime" id="innetTime" value="0" maxlength="10" v_maxlength="10" v_type="int" v_minvalue="0" v_minvalue="9999999999"/>��
		</td>
	</tr>
   <!--begin  huangrong �����������  2011-8-22 -->     
  <tr>
					<td class="blue">��������</td>
					<td colspan='3'>
						<input type="checkbox" name="channelConfigure" onclick="checkChannelConfigure(this)"/>					
					</td>
	</tr>
   <!--end  huangrong �����������  2011-8-22 -->        	
	<tr>
		<td class="blue">ָ���ʷѰ��������</td>
		<td colspan='3'>
			<input type="checkbox" name="pointOfferIds" id="pointOfferIds" onclick="displayOfferIds()"/>					
		</td>
	</tr>
   <!--begin  huangrong ��ӶԱ�ע����ʾ  2010-10-21 13:06-->   	 	
  <tr>
					<td class="blue">�����ע</td>
					<td colspan='3'>
						<TEXTAREA NAME="do_note" id="do_note" maxlength="500"  COLS="60" ROWS="3" onkeyup="checkset(this.value)"></TEXTAREA>(����500����)
					</td>
	</tr>  
   <!--end  huangrong ��ӶԱ�ע����ʾ  2010-10-21 13:06-->   
	<tr id="giveGift">
           <td class="blue" >�Ƿ��������</td>
           <td colspan="3">
								<input type="checkbox" name="need_award" onclick="checkAward()" />
			</td>
	</tr>
	<tr id="giftInfo" style="display:none;">
            <td class="blue">����Ʒ��������</td>
            <td>
					<input name="gift_code" type="text"  id="gift_code" maxlength="6" >
					<font class="orange">*</font>
            </td>
            <td class="blue">��Ʒ�ȼ�</td>
            <td>
					<input name="gift_grade" type="text" id="gift_grade" maxlength="2" >
					<font class="orange">*</font>
            </td>
	</tr>
		<tr>
           <td class="blue" >��ѡ��������</td>
           <td colspan="3">
				<input type="radio" name="opFlag" value="one" sAudit="one" onclick="checkAudit(this)">Ʒ�Ʒ�չ�Ŷ�&nbsp;&nbsp;&nbsp;&nbsp;
				<input type="radio" name="opFlag" value="two" sAudit="two" onclick="checkAudit(this)">��ֵҵ���Ŷ�
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
			<div id="title_zi">ָ���ʷѰ��������</div>
		</div>
		<table>
			<tr>
				<td class="blue">�ʷѴ���</td>
				<td colspan="3">
					<input type="text" name="offerIdInput" id="offerIdInput" v_must="1" maxlength="6">
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					<input type="button" class="b_text" onclick="addOffer()" value="����ʷ�"/>
				</td>
			</tr>
		<table>
	  <table name="offerMsgs" id="offerMsgs">
	  	<tr>
	  		<th width="15%">�ʷѴ���</td>
	  		<th width="20%">�ʷ�����</td>
	  		<th width="50%">�ʷ�����</td>
	  		<th width="15%">����</td>
	  	</tr>
	  </table>
	</div>
<input type="hidden" name="hasOfferId" id="hasOfferId" value="0">

	<table cellspacing="0"> 
	<tr>
            <td colspan="6" align="center" id="footer">
                <input name="confirm" type="button" class="b_foot" index="2" value="ȷ��" onClick="printCommit()" >
                <input name="reset" type="reset" class="b_foot" value="���" >
                <input name="back" onClick="history.go(-1);" type="button" class="b_foot" value="����">
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
    <input type="hidden" name="channelChecked" > <!--huangrong add �����ѡ����������� 2011-8-23-->

	<%@ include file="/npage/include/footer.jsp" %>
</form>
</body>
</html>



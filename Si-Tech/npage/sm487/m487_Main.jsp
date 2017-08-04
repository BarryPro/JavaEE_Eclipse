<%
/*
 * 功能: 
 * 版本: 1.0
 * 日期: liangyl 2017/06/06 关于协助开发手机代付宽带费用功能的函
 * 作者: liangyl
 * 版权: si-tech
*/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ include file="../../npage/bill/getMaxAccept.jsp" %>
<%@ include file="../../npage/common/serverip.jsp" %>
<%
	response.setHeader("Pragma","No-Cache"); 
	response.setHeader("Cache-Control","No-Cache");
	response.setDateHeader("Expires", 0); 
	String regionCode = (String)session.getAttribute("regCode");
	String regioncode = regionCode;
	String loginNo = (String)session.getAttribute("workNo");
	String noPass = (String)session.getAttribute("password");
	String serverIp=realip.trim();
	String chnSource="01";
	String phoneNo = request.getParameter("activePhone");
	String phone_no = phoneNo ;
	String opCode = (String)request.getParameter("opCode");		
	String opName = (String)request.getParameter("opName");
//	String broadPhone = request.getParameter("broadPhone");  //宽带账号
	String loginAccept = getMaxAccept();
	String cccTime=new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss", Locale.getDefault()).format(new java.util.Date());
%>
<!--取流水号方法 -->
<wtc:sequence name="TlsPubSelCrm" key="sMaxSysAccept" routerKey="region" routerValue="<%=regionCode%>"  id="seq"/>
<%
	String printAccept = seq;
%>
<%
/*gaopeng 2016/8/29 17:02:32  获取免密权限*/
	boolean pwrf = false;
	String pubOpCode = opCode;
%>
<%@ include file="/npage/public/pubCheckPwdPower.jsp" %>

<%
	String sql = "SELECT code_id FROM pd_unicodedef_dict WHERE code_class = 'C0001'";
%>
<wtc:service name="TlsPubSelCrm"    retcode="retCode" retmsg="retMsg" outnum="1">
	<wtc:param value="<%=sql%>"/>
</wtc:service>
<wtc:array id="retResult" scope="end" />
<%
	String ipAddrM = (String)session.getAttribute("ipAddr");
	String inst = "通过phoneNo[" + phone_no  + "]查询";
	String gCustId = "";
	String custSql = "";
	String custName = "";
	String  inParamsMail [] = new String[2];
    inParamsMail[0] = "select trim(t.cust_id) from dcustmsg t where phone_no =:phoneNo";
    inParamsMail[1] = "phoneNo="+phone_no ;
%>
	<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regioncode%>" retcode="retCode_mail" retmsg="retMessage_mail" outnum="1"> 
		<wtc:param value="<%=inParamsMail[0]%>"/>
		<wtc:param value="<%=inParamsMail[1]%>"/> 
	</wtc:service>  
	<wtc:array id="result_mail"  scope="end"/>
<%
	if("000000".equals(retCode_mail) && result_mail.length > 0){
		gCustId = result_mail[0][0];
	}else{
		%>
		<script language="javascript">
			rdShowMessageDialog("获取客户信息失败！");
			removeCurrentTab();
		</script>
		<%
	}
	String beizhussdese1="根据custid=["+gCustId+"]进行查询";
%>  	
	<wtc:service name="sUserCustInfo" outnum="100" retmsg="msg" retcode="code" routerKey="region" routerValue="<%=regioncode%>">
		<wtc:param value="0" />
		<wtc:param value="01" />	
		<wtc:param value="<%=opCode%>" />	
		<wtc:param value="<%=loginNo%>" />
		<wtc:param value="<%=noPass%>" />
		<wtc:param value="" />
		<wtc:param value="" />
		<wtc:param value="<%=ipAddrM%>" />
		<wtc:param value="<%=beizhussdese1%>" />
		<wtc:param value="<%=gCustId%>" />
	</wtc:service>
	<wtc:array id="result_custInfo" scope="end"/>	
<%	 	
String custiccids = "";
String custAddr = "";
String custiccidtypes = "";
String custditypesnames="";
if(result_custInfo.length>0){
	if(result_custInfo[0][0].equals("01")) {
		custAddr = result_custInfo[0][11];
		custiccids = result_custInfo[0][13];
		custName = result_custInfo[0][5];
		custiccidtypes = result_custInfo[0][12].trim();
	}
}
if("0".equals(custiccidtypes)) {
		custditypesnames="身份证";
  }else if("1".equals(custiccidtypes)) {
  	custditypesnames="军官证";
 	}else if("2".equals(custiccidtypes)) {
 		custditypesnames="军官证";
 	}else if("3".equals(custiccidtypes)) {
 		custditypesnames="港澳通行证";
 	}else if("4".equals(custiccidtypes)) {
 		custditypesnames="警官证";
 	}else if("5".equals(custiccidtypes)) {
 		custditypesnames="台湾通行证";
 	}else if("6".equals(custiccidtypes)) {
 		custditypesnames="外国公民护照";
 	}else if("7".equals(custiccidtypes)) {
 		custditypesnames="其它";
 	}else if("8".equals(custiccidtypes)) {
 		custditypesnames="营业执照";
 	}else if("9".equals(custiccidtypes)) {
 		custditypesnames="护照";
 	}else if("A".equals(custiccidtypes)) {
 		custditypesnames="组织机构代码";
 	}else if("B".equals(custiccidtypes)) {
 		custditypesnames="单位法人证书";
 	}else if("C".equals(custiccidtypes)) {
 		custditypesnames="单位证明";
 	}else if("00".equals(custiccidtypes)) {
 		custditypesnames="身份证";
 	}
%>	

<html>
<head>
<title><%=opName%></title>
<script language="javascript">	
$(document).ready(function(){
	chgOpType();
});
function chgOpType(){
	$("#resultContent").hide();
	$("#resultContent2").hide();
	$("#sinConstants2").empty();
	var opType = $.trim($("#opType").val());
	$("#kdqryBtn").attr("disabled","");
	$("#QryBtn").attr("disabled","disabled");
	$("#dangweiTr").hide();
	$("#kdNo").val("");
	
	if(opType == "a"){
		$("#sinConstants").show();
		$("#sinConstants2").hide();
		
		$("#kdcustName").val("");
		$("#kdNo").attr("readonly","");
		$("#kdNo").attr("class","");
		$("#kdcustName").show();
		$("#kdqryBtn").show();
		$("#kuandaikehuming").text("宽带客户名称");
		$("#dangweiTr").show();
		$("#kdphoneNo").val("");
	}else if(opType == "d"){
		$("#sinConstants2").show();
		$("#kdNo").attr("readonly","readonly");
		$("#kdNo").attr("class","InputGrey");
		$("#kdcustName").hide();
		$("#kdqryBtn").hide();
		$("#kuandaikehuming").text("");
		$("#kdphoneNo").val("");
		doChkOfferId();
	}
}
//宽带号码查询
function go_kdQry(){
	if($("#kdNo").val()==""){
		rdShowMessageDialog("宽带账号不能为空！");
		return false;
	}
	$("#kdcustName").val("");
	$("#kdphoneNo").val("");
	$("#kdNo").attr("readonly","");
	$("#kdNo").attr("class","");
	$("#kdqryBtn").attr("disabled","");
	$("#QryBtn").attr("disabled","disabled");
	var opType = $.trim($("select[name='opType']").find("option:selected").val());
	var kdNo = $.trim($("#kdNo").val());
	var getdataPacket = new AJAXPacket("m487_kdQry.jsp","正在获得数据，请稍候......");
	getdataPacket.data.add("kdNo",kdNo);
	core.ajax.sendPacket(getdataPacket,do_kdQry);
	getdataPacket = null;
}
function do_kdQry(packet){
	var retCode = packet.data.findValueByName("retCode");
	var retMsg = packet.data.findValueByName("retMsg");
	var infoArray = packet.data.findValueByName("infoArray");
	if(retCode == "000000"){
		if(infoArray.length==0){
			rdShowMessageDialog("查询内容为空!",1);
		}
		else{
			$("#kdcustName").val(infoArray[0][0]);
			$("#kdphoneNo").val(infoArray[0][1]);
			$("#kdNo").attr("readonly","readonly");
			$("#kdNo").attr("class","InputGrey");
			$("#kdqryBtn").attr("disabled","disabled");
			$("#QryBtn").attr("disabled","");
		}
	}else{
		rdShowMessageDialog("错误代码："+retCode+",错误信息："+retMsg,1);
	}
}
//资费查询
function doQry(){
	var opType = $.trim($("#opType").val());
	if(opType == "a"){
		var kdNo = $.trim($("#kdNo").val());
		var kddangWei = $("#kddangWei").val();
		if(kddangWei == ""){
			rdShowMessageDialog("请选择带宽档位！");
			return false;
		}
		var getdataPacket = new AJAXPacket("m487_Qry.jsp","正在获得数据，请稍候......");
		var iLoginAccept = "<%=loginAccept%>";
		var iChnSource = "01";
		var iOpCode = "<%=opCode%>";
		var iLoginNo = "<%=loginNo%>";
		var iLoginPwd = "<%=noPass%>";
		var iPhoneNo = "<%=phoneNo%>";
		var iUserPwd = "";
		getdataPacket.data.add("iLoginAccept",iLoginAccept);
		getdataPacket.data.add("iChnSource",iChnSource);
		getdataPacket.data.add("iOpCode",iOpCode);
		getdataPacket.data.add("iLoginNo",iLoginNo);
		getdataPacket.data.add("iLoginPwd",iLoginPwd);
		getdataPacket.data.add("iPhoneNo",iPhoneNo);
		getdataPacket.data.add("iUserPwd",iUserPwd);
		getdataPacket.data.add("kddangWei",kddangWei);
		core.ajax.sendPacket(getdataPacket,doRetRegion);
		getdataPacket = null;
	}else if(opType == "d"){
		/*调用服务 sKDAddOfferChk 校验是否允许退订*/
		doChkOfferId();
	}
}
function doRetRegion(packet){
	var retCode = packet.data.findValueByName("retCode");
	var retMsg = packet.data.findValueByName("retMsg");
	var infoArray = packet.data.findValueByName("infoArray");
	if(retCode == "000000"){
		$("#resultContent").show();
		$("#appendBody").empty();
		var appendTh = 
				"<tr>"
				+"<th width='20%'>选择</th>"
				+"<th width='25%'>资费代码</th>"
				+"<th width='30%'>资费名称</th>"
				+"</tr>";
		$("#appendBody").append(appendTh);	
		for(var i=0;i<infoArray.length;i++){
			var appendStr = "<tr>";
			appendStr += "<td width='20%' align='center' id='cardType'>"+"<input type='radio' name='chkone' value='"+infoArray[i][0]+"'/>"+"</td>"
				+"<td width='25%' align='center' id='cardType'>"+infoArray[i][0]+"</td>"
				+"<td width='30%' align='center' id='cardPrice'>"+infoArray[i][1]+"</td>"
			appendStr +="</tr>";	
			$("#appendBody").append(appendStr);
		}
		if(infoArray.length != 0){
			
		}
			
	}else{
		$("#resultContent").hide();
		$("#appendBody").empty();
		//$("#export").attr("disabled","disabled");
		rdShowMessageDialog("错误代码："+retCode+",错误信息："+retMsg,1);
		//window.location.reload();
	}
}
		
//验证操作
function doChkBtn(){
	var opType = $.trim($("#opType").val());
	/*订购*/
	if(opType == "a"){
		/*准备验证*/
		var chkone = $.trim($("input[name='chkone'][checked]").val());
		if(chkone.length == 0){
			rdShowMessageDialog("请选择需要提速的可选资费！");
			return false;
		}
		doChkOfferId();
		if(chkFlag){
			$("#configBtn").attr("disabled","");
		}else{
			$("#configBtn").attr("disabled","disabled");
		}
	}else if(opType == "d"){
		doChkOfferId();
	}
}

var chkFlag = false;
function doChkOfferId(){
	chkFlag = false;
	var chkone = $.trim($("input[name='chkone'][checked]").val());
	var opType = $.trim($("#opType").val());
	/*ajax start*/
	var getdataPacket = new AJAXPacket("m487_Chk.jsp","正在获得数据，请稍候......");
	
	var iLoginAccept = "<%=loginAccept%>";
	var iChnSource = "01";
	var iOpCode = "<%=opCode%>";
	var iLoginNo = "<%=loginNo%>";
	var iLoginPwd = "<%=noPass%>";
	var iPhoneNo = "<%=phoneNo%>";
	var iUserPwd = "";
	
	getdataPacket.data.add("iLoginAccept",iLoginAccept);
	getdataPacket.data.add("iChnSource",iChnSource);
	getdataPacket.data.add("iOpCode",iOpCode);
	getdataPacket.data.add("iLoginNo",iLoginNo);
	getdataPacket.data.add("iLoginPwd",iLoginPwd);
	getdataPacket.data.add("iPhoneNo",iPhoneNo);
	getdataPacket.data.add("iUserPwd",iUserPwd);
	getdataPacket.data.add("offerId",chkone);
	getdataPacket.data.add("opType",opType);
	getdataPacket.data.add("kdphoneNo",$("#kdphoneNo").val());
	core.ajax.sendPacket(getdataPacket,doRetChk);
	getdataPacket = null;
}
	
function doRetChk(packet){
	var retCode = packet.data.findValueByName("retCode");
	var retMsg = packet.data.findValueByName("retMsg");
	var opType = $.trim($("select[name='opType']").find("option:selected").val());
	if(opType == "a"){
		if(retCode == "000000"){
	//		### 0 宽带号码
	//		### 1 资费代码		
	//		### 2 资费名称	
	//		### 3 资费生效时间		
	//		### 4 资费失效时间		
	//		### 5 旧带宽
	//		### 6 新带宽
	
//	opr_info += "提速宽带账号："+$("#kdNo").val()+"|";
//	opr_info += "提速宽带客户姓名："+$("#kdcustName").val()+"|";
//	opr_info += "当前带宽："+$("#kdNo").val()+"|";
//	opr_info += "提速后带宽："+$("#kddangWei").val()+"|";
	
			/*获取生效时间*/
			var infoArray = packet.data.findValueByName("infoArray");
			var sxsj = infoArray[0][3];
			var dqzfmc = infoArray[0][2];
			var dqzfdk = infoArray[0][5];
			var dqzfdk2 = infoArray[0][6];
			$("#sxsj").val(sxsj);
			$("#dqzfmc").val(dqzfmc);
			$("#dqzfdk").val(dqzfdk);
			$("#dqzfdk2").val(dqzfdk2);
			rdShowMessageDialog("验证成功！",1);
			chkFlag = true;
		}else{
			rdShowMessageDialog("错误代码："+retCode+",错误信息："+retMsg,1);
			chkFlag = false;
		}
	}else if(opType == "d"){
		var infoArray = packet.data.findValueByName("infoArray");
		if(retCode == "000000"){
			$("#resultContent2").show();
			$("#appendBody2").empty();
			var sxsj = infoArray[0][3];
			var dqzfmc = infoArray[0][2];
			var dqzfdk = infoArray[0][5];
			var dqzfdk2 = infoArray[0][6];
			$("#sxsj").val(sxsj);
			$("#dqzfmc").val(dqzfmc);
			$("#dqzfdk").val(dqzfdk);
			$("#dqzfdk2").val(dqzfdk2);
			var appendTh = 
				"<tr>"
				+"<th width='20%'>选择</th>"
				+"<th width='25%'>资费代码</th>"
				+"<th width='30%'>生效时间</th>"
				+"<th width='25%'>失效时间</th>"
				+"</tr>";
			$("#appendBody2").append(appendTh);	
			for(var i=0;i<infoArray.length;i++){
				$("#kdNo").val(infoArray[i][0]);
				$("#kdphoneNo").val(infoArray[i][0]);
				var appendStr = "<tr>";
				appendStr += "<td width='20%' align='center' id='cardType'>"+"<input type='radio' name='chkone' value='"+infoArray[i][1]+"' checked/>"+"</td>"
					+"<td width='25%' align='center' id='cardType'>"+infoArray[i][1]+"</td>"
					+"<td width='30%' align='center' id='cardPrice'>"+infoArray[i][2]+"</td>"
					+"<td width='25%' align='center' id='cardDiscount'>"+infoArray[i][3]+"</td>"
				appendStr +="</tr>";	
				$("#appendBody2").append(appendStr);
			}
		}else{
			rdShowMessageDialog("错误代码："+retCode+",错误信息："+retMsg,1);
			$("#resultContent2").hide();
		}
	}
}
		
//确认操作
function doCfmBtn(){
	if(!printCfm()){
		return false;
	}
	var chkone = $.trim($("input[name='chkone'][checked]").val());
	var opType = $.trim($("#opType").val());
	/*ajax start*/
	var getdataPacket = new AJAXPacket("m487_Cfm.jsp","正在获得数据，请稍候......");
	var iLoginAccept = "<%=loginAccept%>";
	var iChnSource = "01";
	var iOpCode = "<%=opCode%>";
	var iLoginNo = "<%=loginNo%>";
	var iLoginPwd = "<%=noPass%>";
	var iPhoneNo = "<%=phoneNo%>";
	var iUserPwd = "";
	
	getdataPacket.data.add("iLoginAccept",iLoginAccept);
	getdataPacket.data.add("iChnSource",iChnSource);
	getdataPacket.data.add("iOpCode",iOpCode);
	getdataPacket.data.add("iLoginNo",iLoginNo);
	getdataPacket.data.add("iLoginPwd",iLoginPwd);
	getdataPacket.data.add("iPhoneNo",iPhoneNo);
	getdataPacket.data.add("iUserPwd",iUserPwd);
	getdataPacket.data.add("offerId",chkone);
	getdataPacket.data.add("opType",opType);
	getdataPacket.data.add("kdphoneNo",$("#kdphoneNo").val());
	core.ajax.sendPacket(getdataPacket,doRetCfm);
	getdataPacket = null;
}
		
function doRetCfm(packet){
	var retCode = packet.data.findValueByName("retCode");
	var retMsg = packet.data.findValueByName("retMsg");
	if(retCode == "000000"){
		rdShowMessageDialog("操作成功！",1);
		window.location.reload();
	}else{
		rdShowMessageDialog("错误代码："+retCode+",错误信息："+retMsg,1);
		window.location.reload();
	}
}
		
function showPrtDlg(printType,DlgMessage,submitCfm){
	var h=198;
	var w=350;
	var t=screen.availHeight/2-h/2;
	var l=screen.availWidth/2-w/2;
	var pType="subprint";
	var billType="1";
	var sysAccept = "<%=printAccept%>";
	var phone_no = "<%=phone_no%>";
	var mode_code = "";
	
	
	var fav_code = "";
	var area_code = "";
	var printStr = printInfo(printType);
	var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no";
	var path = "<%=request.getContextPath()%>/npage/innet/hljBillPrint_jc_hw.jsp?DlgMsg=" + DlgMessage;
	var path=path+"&mode_code="+mode_code+"&fav_code="+fav_code+"&area_code="+area_code+"&opCode=<%=opCode%>&sysAccept="+sysAccept+"&phoneNo="+phone_no+"&submitCfm="+submitCfm+"&pType="+pType+"&billType="+billType+ "&printInfo=" + printStr;
	var ret=window.showModalDialog(path,printStr,prop);
	return path;
}
function printInfo(printType){
	var retInfo = "";
	var cust_info="";
	var opr_info="";
	var note_info1="";
	var note_info2="";
	var note_info3="";
	var note_info4="";
	cust_info+="手机号码：<%=phone_no%>|";
	cust_info+="客户姓名：<%=custName%>|";
	var cTime = "<%=cccTime%>";
	opr_info += "业务办理名称：手机提速宽带               操作流水:<%=loginAccept%>|";
	opr_info += "办理提速资费名："+$("#dqzfmc").val()+"     资费生效时间："+$("#sxsj").val()+"|";
	opr_info += "提速宽带账号："+$("#kdNo").val()+"|";
	opr_info += "提速宽带客户姓名："+$("#kdcustName").val()+"|";
	opr_info += "当前带宽："+$("#dqzfdk").val()+"M|";
	opr_info += "提速后带宽："+$("#dqzfdk2").val()+"M|";
	retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
	retInfo=retInfo.replace(new RegExp("#","gm"),"%23");
	return retInfo;
}

function printCfm(){
	var opType = $.trim($("#opType").val());
	if(opType == "a"){
		var ret = showPrtDlg("Detail","确实要进行电子免填单打印吗？","Yes");
	}
	if(typeof(ret)!="undefined"){
		if((ret=="confirm")){
			if(rdShowConfirmDialog('确认电子免填单吗？')==1){
				return true;
			}else{
				return false;
			}
		}
		if(ret=="continueSub"){
			if(rdShowConfirmDialog('确认要提交信息吗？')==1){
				return true;
			}else{
				return false;
			}
		}else{
			if(rdShowConfirmDialog('确认要提交信息吗？')==1){
				return true;
			}else{
				return false;
			}
		}
	}
	else{
		if(rdShowConfirmDialog('确认要提交信息吗？')==1){
			return true;
		}else{
			return false;
		}
	}
}
</script>
</head>
<body>
<form action="" method="post" name="frm">
<%@ include file="/npage/include/header.jsp" %>
<div class="title">
	<div id="title_zi"><%=opName%></div>
</div>
<table>
	<tr>
		<td class="blue" width="20%">操作类型</td>
		<td width="30%">
			<select id="opType" name="opType"  onchange="chgOpType();"> 
				<option value="a" selected>订购</option>
				<option value="d" >退订</option>
			</select>	
			
		</td>
		<td class="blue" width="20%"></td>
		<td width="30%"></td>
	</tr>
</table>
<div >
<table id="sinConstants">
	<tr>
		<td class="blue" width="20%">手机号码</td>
		<td width="30%"><input type="text" id="phoneNo" name="phoneNo" value = "<%=phone_no%>" class="InputGrey" readonly/></td>
		<td class="blue" width="20%">手机客户名称</td>
		<td width="30%"><%=custName%></td>
	</tr>
	<tr>
		<td class="blue" width="20%">宽带账号</td>
		<td width="30%"><input type="text" id="kdNo" name="kdNo" value = "" maxlength="20"/></td>
		<td class="blue" width="20%" id="kuandaikehuming">带宽客户名称</td>
		<td width="30%">
			<input type="text" id="kdcustName" name="kdcustName" value = "" class="InputGrey" readonly="readonly"/>
			<input type="hidden" id="kdphoneNo" name="kdphoneNo" value = ""/>
			<input class="b_foot" id="kdqryBtn" name="kdqryBtn"  type="button" value="查询"   onclick="go_kdQry()"/>
		</td>
	</tr>
	<tr id="dangweiTr">
		<td class="blue" width="20%">宽带档位</td>
		<td width="30%" colspan="3">
			<select id="kddangWei" name="kddangWei">
				<%
				for(int i=0;i<retResult.length;i++){
					for(int j=0;j<retResult[i].length;j++){
					%>
						<option value="<%=retResult[i][j]%>"><%=retResult[i][j]%></option>
					<%
					}
				}
				%>
			</select>
		</td>
	</tr>
</table>
<table>
   <tr>
		<td align=center colspan="4" id="footer">
			<input class="b_foot" id="QryBtn" name="QryBtn"  type="button" value="查询" onclick="doQry();" disabled="disabled"/>&nbsp;&nbsp;
			<input class="b_foot" id="resetBtn" name="resetBtn" type="button" value="重置" onclick="javascript:window.location.reload();"/>&nbsp;&nbsp;
			<input class="b_foot" name="close" onclick="removeCurrentTab()" type="button" value="关闭"/>
		</td>
	</tr>
</table>
</div>
<!-- 查询结果列表 -->
<div id="resultContent" style="display:none">
<div class="title">
	<div id="title_zi">查询结果信息列表</div>
</div>
<table id="exportExcel" name="exportExcel">
	<tbody id="appendBody">
		
	
	</tbody>
</table>
<table>
	<tr>
		<td align=center colspan="4" id="footer">
			<input class="b_foot" id="chkBtn" name="chkBtn" type="button" value="验证" onclick="doChkBtn();"/>&nbsp;&nbsp;
			<input class="b_foot" id="configBtn" name="configBtn"  type="button" value="确认" onclick="doCfmBtn();" disabled="disabled"/>&nbsp;&nbsp;
			<input class="b_foot" id="resetBtn" name="resetBtn"  type="button" value="重置"  onclick="javascript:window.location.reload();"/>&nbsp;&nbsp;
			<input class="b_foot" name="close" onclick="removeCurrentTab()" type=button value="关闭"/>
		</td>
	</tr>
</table>
</div>
<!-- 查询结果列表 -->
<div id="resultContent2" style="display:none">
<div class="title">
	<div id="title_zi">查询结果信息列表</div>
</div>
<table id="exportExcel" name="exportExcel">
	<tbody id="appendBody2">
	</tbody>
</table>
<table>
	<tr>
		<td align=center colspan="4" id="footer">
			<input class="b_foot" id="configBtn2" name="configBtn2" type="button" value="确认" onclick="doCfmBtn();"/>&nbsp;&nbsp;
			<input class="b_foot" id="resetBtn" name="resetBtn" type="button" value="重置" onclick="javascript:window.location.reload();"/>&nbsp;&nbsp;
			<input class="b_foot" name="close" onclick="removeCurrentTab()" type=button value="关闭"/>
		</td>
	</tr>
</table>
</div>
<input type="hidden" name="sxsj" id="sxsj" value=""/>
<input type="hidden" name="dqzfmc" id="dqzfmc" value=""/>
<input type="hidden" name="dqzfdk" id="dqzfdk" value=""/>
<input type="hidden" name="dqzfdk2" id="dqzfdk2" value=""/>
<%@ include file="/npage/include/footer.jsp" %> 
</form>
</body>
</html>
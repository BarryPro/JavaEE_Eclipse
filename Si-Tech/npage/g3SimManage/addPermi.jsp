<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType="text/html;charset=GB2312"%>
<%@ include file="/npage/include/public_title_name.jsp" %>

<head>
<%
	 String opName= "新增权限配置";
	 String opCode = (String)request.getParameter("opCode");
	 String regionCode = (String)session.getAttribute("regCode");
String apnName = "jifei.hl";
String apnCode = "0005";
%>		

<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<title>新增权限配置</title>
<script type="text/javascript" src="/njs/extend/My97DatePicker/WdatePicker.js"></script>
<script type="text/javascript" >
	
function getSimNo(){
	if($("#phoneno").val().trim()=="") return ;
	
	var getSimNaPacket = new AJAXPacket("ajaxGetSimNo.jsp","正在执行,请稍后...");	
		getSimNaPacket.data.add("phoneno",$("#phoneno").val().trim());
		core.ajax.sendPacket(getSimNaPacket,doGetSimNo);
		getSimNaPacket = null; 
}
function doGetSimNo(packet){
	var simNo = packet.data.findValueByName("simNo"); 
	if(simNo!=""){
		$("#simno").val(simNo);
	}else{
		rdShowMessageDialog("没有查到sim卡号，请重新输入",0);
		$("#phoneno").val("");
		$("#simno").val("");
	}
}

function checkLoginNo(){
	if($("#loginNo").val().trim()=="") return ;
	var getSimNaPacket = new AJAXPacket("ajaxCheckLoginNo.jsp","正在执行,请稍后...");	
		getSimNaPacket.data.add("loginNo",$("#loginNo").val().trim());
		core.ajax.sendPacket(getSimNaPacket,doCheckLoginNo);
		getSimNaPacket = null; 
}
function doCheckLoginNo(packet){
	var countLoginno = packet.data.findValueByName("countLoginno"); 
	if(countLoginno=="0"){
		rdShowMessageDialog("工号输入错误，请重新输入",0);
		$("#loginNo").val("");
		$("#loginNo").focus();
	}
}
</script>
</head>
<body>
<form method="post" name="frm"  >
	<%@ include file="/npage/include/header_pop.jsp" %>
			<div id="mInput">
				<div class="title">
					<div id="title_zi">新增权限配置</div>
				</div>
				<div class="input">
					<table cellspacing="0">
						<tr>
							
			<td class="blue" width="20%">手机号码</td>
		<td class="blue" width="30%"><input type="text" id="phoneno" name="phoneno" maxLength="11" onblur="getSimNo()">
			<font class="orange">*</font>
			</td>
						 
						  <td class="blue" width="20%">SIM卡号</td>
						 <td width="30%"><input type="text" name="simno" id="simno" readOnly maxlength="32"><font class="orange">*</font> </td>
					
						</tr>
						<tr>
							<td class="blue">工号</td>
						 <td><input type="text" name="loginNo" id="loginNo" maxlength="6"	 	onblur="checkLoginNo()"	><font class="orange">*</font> </td>
							
	 					<td class="blue">IMEI卡号</td>
						 <td><input type="text" name="imeiNo" id="imeiNo"  maxlength="20"  maxlength="32"><font class="orange">*</font> </td>
						</tr>
						<tr>
						 <td class="blue"  >开始时间</td>
						 <td  ><input type="text" id="beginDate"  readOnly onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',autoPickDate:true,onpicked:function(){}})"><font class="orange">*</font> </td>
						 
						 <td class="blue"  >结束时间</td>
						 <td  ><input type="text" id="endDate" readOnly  onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',autoPickDate:true,onpicked:function(){}})"><font class="orange">*</font> </td>
						</tr>
						
						<tr>
									<td class="blue" colspan="4">开通APN站点名称：<%=apnName%></td>
						</tr>
						<tr>
							<td colspan="4" class="blue" style="text-align:center">
								<input class="b_foot" name="add"  id="add"   type=button value="增加" onclick="doAdd()">
							  	&nbsp; 
							  	<input class="b_foot" name="update" id="update" style="display:none" type=button value="修改" onclick="doUpate()">
							  	&nbsp; 
							  	<input class="b_foot" name="third" type=button value="取消" onclick="javascript:window.close();">
							</td>
						</tr>
					</table>
				</div>
			</div>

	<%@ include file="/npage/include/footer_pop.jsp" %>
</form>
<script type="text/javascript">
$(document).ready(function(){
 	$("select").width("150");
	$("input[type='text']").width("150");
});	
function doAdd(){
	mm = /^\w+$/;
	if(document.all.simno.value.trim()!=""){
		if(!mm.test(document.all.simno.value.trim())){
			rdShowMessageDialog("sim卡号输入不正确，请重新输入");
			
			document.all.phoneno.value="";
			document.all.simno.value="";
			return;
		}
	}else{
		rdShowMessageDialog("请输入sim卡号");
		document.all.simno.focus();
		return;
	}
	
	if(document.all.loginNo.value.trim()!=""){
		if(!mm.test(document.all.loginNo.value.trim())){
			rdShowMessageDialog("工号输入不正确，请重新输入");
			document.all.loginNo.focus();
			document.all.loginNo.value="";
			return;
		}
	}else{
		rdShowMessageDialog("请输入工号");
		document.all.loginNo.focus();
		return;
	}
	if(document.all.imeiNo.value.trim()!=""){
		if(!mm.test(document.all.imeiNo.value.trim())){
			rdShowMessageDialog("IMEI号码输入不正确，请重新输入");
			
			document.all.imeiNo.focus();
			document.all.imeiNo.value="";
			return;
		}
	}else{
		rdShowMessageDialog("请输入IMEI号");
		document.all.imeiNo.focus();
		return;
	}
	if(document.all.beginDate.value==""){
		rdShowMessageDialog("请输入开始时间");
		document.all.beginDate.focus();
		return;
	}
	if(document.all.endDate.value==""){
		rdShowMessageDialog("请输入结束时间");
		document.all.endDate.focus();
		return;
	}
	
	if(document.all.endDate.value<document.all.beginDate.value){
		rdShowMessageDialog("结束时间不能小于开始时间，请重新输入");
		document.all.beginDate.focus();
		document.all.beginDate.value="";
		document.all.endDate.value="";
		return;
	}
	var permiPacket = new AJAXPacket("addPermiCfm.jsp","正在执行,请稍后...");
		permiPacket.data.add("simno",     document.all.simno.value.trim());
		permiPacket.data.add("loginNo",     document.all.loginNo.value.trim());
		permiPacket.data.add("beginDate",     document.all.beginDate.value.trim());
		permiPacket.data.add("endDate",     document.all.endDate.value.trim());
		permiPacket.data.add("imeiNo",     document.all.imeiNo.value.trim());
		permiPacket.data.add("phoneno",     document.all.phoneno.value.trim());
		permiPacket.data.add("apnCode",     "<%=apnCode%>");
		permiPacket.data.add("apnName",     "<%=apnName%>");
		permiPacket.data.add("opCode",     "<%=opCode%>");
		core.ajax.sendPacket(permiPacket,doAddCfm);
		permiPacket = null; 
}
function doAddCfm(packet){
	var code = packet.data.findValueByName("code"); 
	var msg = packet.data.findValueByName("msg"); 
	if(code=="000000"){
		rdShowMessageDialog("操作成功",2);
		window.opener.getPermi();
		window.close();
	}else{
		rdShowMessageDialog("操作失败"+code+"："+msg,0);
	}
}
</script> 
</body>
</html>
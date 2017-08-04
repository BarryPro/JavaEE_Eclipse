<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType="text/html;charset=GB2312"%>
<%@ include file="/npage/include/public_title_name.jsp" %>

<head>
<%
	 String opName    = request.getParameter("opName"); 
	 String opCode    = request.getParameter("opCode");
	 String upftpip   = WtcUtil.repNull(request.getParameter("upftpip"));
	 String upftpuser = WtcUtil.repNull(request.getParameter("upftpuser"));
	 String upftppass = WtcUtil.repNull(request.getParameter("upftppass"));
	 
%>
<title>新增配置</title>
<script type="text/javascript" >
 
function twClose(){
	window.location='androidCrmUpgMain.jsp?opCode=<%=opCode%>&opName=<%=opName%>';
}
function doAdd(){
	if( !$("#ftpInfoTr").is(":visible")){
		rdShowMessageDialog( "请保存FTP信息" , 0 );
		return false;
	}
	if($("#apkVersionId").val().trim()==""){
		rdShowMessageDialog( "版本号不能为空" , 0 );
		return false;
	}
	
	var apkFileName = $("#apkfile").val();
	if ( apkFileName == "" ){
		rdShowMessageDialog( "数据文件不能为空！" , 0 );
		return false;
	}
	
	if(apkFileName.indexOf(".")==-1){
		rdShowMessageDialog( "文件格式不正确" , 0 );
		return false;
	}
	
	var fileType = apkFileName.substring(apkFileName.lastIndexOf(".")+1,apkFileName.length);
	if(fileType!="apk"){
		rdShowMessageDialog( "文件格式不正确" , 0 );
		return false;
	}
	

	var memoStr  = $("#apkMemo").val();
	memoStr = memoStr.replace(/\n\r/gi,"<br/>"); 
	memoStr = memoStr.replace(/\n/gi,"<br/>"); 
	memoStr = memoStr.replace(/\r/gi,"<br/>"); 
	
	var cfmpath = "androidCrmUpgAddCfm.jsp?opCode=<%=opCode%>&opName=<%=opName%>"+"&versionId="+$("#versionId").val()+
								"&apkMemo="+memoStr+"&apkVersionId="+$("#apkVersionId").val()+"&mustUpgFlag="+$("#mustUpgFlag").val()+
								"&upftpip="+$("#upFtpIp").val()+
							  "&upftpuser="+$("#upFtpUser").val()+
							  "&upftppass="+$("#upFtpPass").val();
	document.frm.action = cfmpath;	
	
	if($("#upFtpIp").val()==""||$("#upFtpUser").val()==""||$("#upFtpPass").val()==""){
		if(rdShowConfirmDialog("FTP数据不全，确定上传么？")!=1) return;
	}
	document.frm.submit();	
}
function setMustUpgHit(){
	var upgFlag = $("#mustUpgFlag").val();
	if(upgFlag=="0"){
		$("#mustUpgHit").text("客户端必须进行下载更新才能运行。");
	}else if(upgFlag=="1"){
		$("#mustUpgHit").text("客户端有更新提示，但不更新也可以运行。");
	}else{
		$("#mustUpgHit").text("");
	}
}

function updFtpInfo(){
	$("#upFtpInfoTr").show();
	$("#ftpInfoTr").hide();
}

function saveFtpInfo(){
	 if(rdShowConfirmDialog('确认FTP信息输入正确并保存？')!=1) return;
	 setFtpInfo();
}

function setFtpInfo(){
	 $("#show_ftpIp").text($("#upFtpIp").val());
	 $("#show_ftpuser").text($("#upFtpUser").val());
	 $("#show_ftpPass").text($("#upFtpPass").val());
	 $("#upFtpInfoTr").hide();
	 $("#ftpInfoTr").show();
}
$(document).ready(function(){
	if($("#upFtpIp").val()==""&&$("#upFtpUser").val()==""&&$("#upFtpPass").val()==""){
		updFtpInfo();
	}else{
		setFtpInfo();
	}
});
</script>
</head>
<body>
<form method="post" name="frm"   action=""   enctype="multipart/form-data" >
	<%@ include file="/npage/include/header.jsp" %>
				<div class="title">
					<div id="title_zi">安装包上传FTP信息</div>
				</div>
					<table cellspacing="0">
						<tr id="ftpInfoTr">
	 					<td class="blue">上传FTP信息：</td>
						 <td>
						 	 注意：安装包上传到能力平台上，以供智能终端版CRM自动下载更新。若上传失败需要手动上传apk包！<br/>
						 	 <font class="orange">FTP地址：<span id="show_ftpIp"></span></font> <br/>
						 	 <font class="orange">FTP用户：<span id="show_ftpuser"></span></font> <br/>
						 	 <font class="orange">FTP密码：<span id="show_ftpPass"></span></font> <br/>
						 </td>
						 <td width="15">
							<input type="button"  value="修改" class="b_text" onclick="updFtpInfo()" />
						 </td>
						</tr>
 						<tr id="upFtpInfoTr" style="display:none">
 							<td class="blue">FTP地址：
 								<input type="text" id="upFtpIp" value="<%=upftpip%>" />
 							</td>	
 							
 							<td class="blue">FTP用户：
 								<input type="text" id="upFtpUser" value="<%=upftpuser%>" />
 							</td>	
 							<td class="blue">FTP密码：
 								<input type="text" id="upFtpPass" value="<%=upftppass%>" />
 							</td>	
 							<td width="15">
							<input type="button"  value="保存" class="b_text" onclick="saveFtpInfo()" />
						 </td>
 						</tr>
 						
				</table>
				<div class="title">
					<div id="title_zi">新增安装包版本</div>
				</div>
				<table cellspacing="0">
						<tr>
	 					<td class="blue">版本号：</td>
						 <td>
						 	<input type="text" id="apkVersionId" name="apkVersionId" maxlength="10"/> 
						 	<font class="orange">* 此版本号必须与开发人员沟通取得，否则影响android版CRM更新升级！</font> 
						 </td>
						</tr>
						<tr>
	 					<td class="blue">强制客户端更新：</td>
						 <td>
						 	<select id="mustUpgFlag" onchange="setMustUpgHit()">
						 		<option value="-1">--请选择--</option>
						 		<option value="0">是</option>
						 		<option value="1">否</option>
						 	</select>
						 	<font class="orange">*<span id="mustUpgHit"></span></font> 
						 </td>
						</tr>
						<tr>
	 					<td class="blue">版本描述：</td>
						 <td>
						 	<textarea rows="5" cols="50" id="apkMemo" name="apkMemo"></textarea>
						 </td>
						</tr>
				
						<tr>
							<td class="blue">上传文件：</td>
							<td>
								<input type="file" id="apkfile" name="apkfile" size="50" />   
							</td>
						</tr>
						<tr>
							<td  colspan="4" class="blue" style="text-align:center">
								<input class="b_foot" name="add"  id="add"   type=button value="确定" onclick="doAdd()">
							  	&nbsp; 
							  	<input class="b_foot" name="third" type=button value="返回" onclick="twClose()">
							</td>
						</tr>
					</table>

	<%@ include file="/npage/include/footer.jsp" %>
</form>
<script type="text/javascript">
  
</script> 
</body>
</html>
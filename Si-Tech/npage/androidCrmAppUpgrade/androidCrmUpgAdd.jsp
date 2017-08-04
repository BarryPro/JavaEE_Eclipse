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
<title>��������</title>
<script type="text/javascript" >
 
function twClose(){
	window.location='androidCrmUpgMain.jsp?opCode=<%=opCode%>&opName=<%=opName%>';
}
function doAdd(){
	if( !$("#ftpInfoTr").is(":visible")){
		rdShowMessageDialog( "�뱣��FTP��Ϣ" , 0 );
		return false;
	}
	if($("#apkVersionId").val().trim()==""){
		rdShowMessageDialog( "�汾�Ų���Ϊ��" , 0 );
		return false;
	}
	
	var apkFileName = $("#apkfile").val();
	if ( apkFileName == "" ){
		rdShowMessageDialog( "�����ļ�����Ϊ�գ�" , 0 );
		return false;
	}
	
	if(apkFileName.indexOf(".")==-1){
		rdShowMessageDialog( "�ļ���ʽ����ȷ" , 0 );
		return false;
	}
	
	var fileType = apkFileName.substring(apkFileName.lastIndexOf(".")+1,apkFileName.length);
	if(fileType!="apk"){
		rdShowMessageDialog( "�ļ���ʽ����ȷ" , 0 );
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
		if(rdShowConfirmDialog("FTP���ݲ�ȫ��ȷ���ϴ�ô��")!=1) return;
	}
	document.frm.submit();	
}
function setMustUpgHit(){
	var upgFlag = $("#mustUpgFlag").val();
	if(upgFlag=="0"){
		$("#mustUpgHit").text("�ͻ��˱���������ظ��²������С�");
	}else if(upgFlag=="1"){
		$("#mustUpgHit").text("�ͻ����и�����ʾ����������Ҳ�������С�");
	}else{
		$("#mustUpgHit").text("");
	}
}

function updFtpInfo(){
	$("#upFtpInfoTr").show();
	$("#ftpInfoTr").hide();
}

function saveFtpInfo(){
	 if(rdShowConfirmDialog('ȷ��FTP��Ϣ������ȷ�����棿')!=1) return;
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
					<div id="title_zi">��װ���ϴ�FTP��Ϣ</div>
				</div>
					<table cellspacing="0">
						<tr id="ftpInfoTr">
	 					<td class="blue">�ϴ�FTP��Ϣ��</td>
						 <td>
						 	 ע�⣺��װ���ϴ�������ƽ̨�ϣ��Թ������ն˰�CRM�Զ����ظ��¡����ϴ�ʧ����Ҫ�ֶ��ϴ�apk����<br/>
						 	 <font class="orange">FTP��ַ��<span id="show_ftpIp"></span></font> <br/>
						 	 <font class="orange">FTP�û���<span id="show_ftpuser"></span></font> <br/>
						 	 <font class="orange">FTP���룺<span id="show_ftpPass"></span></font> <br/>
						 </td>
						 <td width="15">
							<input type="button"  value="�޸�" class="b_text" onclick="updFtpInfo()" />
						 </td>
						</tr>
 						<tr id="upFtpInfoTr" style="display:none">
 							<td class="blue">FTP��ַ��
 								<input type="text" id="upFtpIp" value="<%=upftpip%>" />
 							</td>	
 							
 							<td class="blue">FTP�û���
 								<input type="text" id="upFtpUser" value="<%=upftpuser%>" />
 							</td>	
 							<td class="blue">FTP���룺
 								<input type="text" id="upFtpPass" value="<%=upftppass%>" />
 							</td>	
 							<td width="15">
							<input type="button"  value="����" class="b_text" onclick="saveFtpInfo()" />
						 </td>
 						</tr>
 						
				</table>
				<div class="title">
					<div id="title_zi">������װ���汾</div>
				</div>
				<table cellspacing="0">
						<tr>
	 					<td class="blue">�汾�ţ�</td>
						 <td>
						 	<input type="text" id="apkVersionId" name="apkVersionId" maxlength="10"/> 
						 	<font class="orange">* �˰汾�ű����뿪����Ա��ͨȡ�ã�����Ӱ��android��CRM����������</font> 
						 </td>
						</tr>
						<tr>
	 					<td class="blue">ǿ�ƿͻ��˸��£�</td>
						 <td>
						 	<select id="mustUpgFlag" onchange="setMustUpgHit()">
						 		<option value="-1">--��ѡ��--</option>
						 		<option value="0">��</option>
						 		<option value="1">��</option>
						 	</select>
						 	<font class="orange">*<span id="mustUpgHit"></span></font> 
						 </td>
						</tr>
						<tr>
	 					<td class="blue">�汾������</td>
						 <td>
						 	<textarea rows="5" cols="50" id="apkMemo" name="apkMemo"></textarea>
						 </td>
						</tr>
				
						<tr>
							<td class="blue">�ϴ��ļ���</td>
							<td>
								<input type="file" id="apkfile" name="apkfile" size="50" />   
							</td>
						</tr>
						<tr>
							<td  colspan="4" class="blue" style="text-align:center">
								<input class="b_foot" name="add"  id="add"   type=button value="ȷ��" onclick="doAdd()">
							  	&nbsp; 
							  	<input class="b_foot" name="third" type=button value="����" onclick="twClose()">
							</td>
						</tr>
					</table>

	<%@ include file="/npage/include/footer.jsp" %>
</form>
<script type="text/javascript">
  
</script> 
</body>
</html>
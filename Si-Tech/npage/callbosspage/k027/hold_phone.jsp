<%@page contentType="text/html;charset=GBK"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<%@ include file="/npage/include/public_title_name.jsp" %>

<html>
	<head>
		<title>ȡ����</title>
		<meta http-equiv="Content-Type" content="text/html; charset=GBK" />
		<link
			href="<%=request.getContextPath()%>/nresources/default/css/portalet.css"
			rel="stylesheet" type="text/css">
		<link
			href="<%=request.getContextPath()%>/nresources/default/css/font_color.css"
			rel="stylesheet" type="text/css">
		<script language="JavaScript"
			src="<%=request.getContextPath()%>/njs/csp/vatmpad.js"></script>

		<style type="text/css">
#call_out_title {
	text-align: left;
	height: 25px;
	width: 100%;
	float: left;
	font-size: 12px;
	line-height: 25px;
	font-weight: bold;
	color: #FFFFFF;
}
</style>

<script type="text/javascript">

var parPhone = window.opener.document.getElementById("Phone");

function loadHoldPhone(){
	// ��ѯ�����б�
	parPhone.QueryHoldListEx();

	// ��ñ���ͨ����
	var num = parPhone.CallIDNum;

	var obj=document.getElementById("hold_phone");
	var caller_phone = window.opener.cCcommonTool.getCaller();
	var called_phone = window.opener.cCcommonTool.getCalled();
	
	if(num != 0){
		for(var i = 0; i < num; i++){
			var callId = parPhone.GetCallIDByIdx(i);
			obj.add(new Option("���У�" + caller_phone + "    " + "���У�" + called_phone, callId)); 
		}
	} else {
		obj.add(new Option("...                  ","ֵ"));
	}
}

function holdPhone(){
	var callId = document.getElementById("hold_phone").value;
	var ret=window.opener.cCcommonTool.GetHoldEx(callId);
	if(ret==0){
	      var arr=new Array("'38'");
		    var oprTypeAll=arr.join(",");
        var oprType="";
		    var sign=0;
		    window.opener.recodeTime(oprTypeAll,oprType,sign,"");
	}
	window.close();
}

function callCancel(){
	window.close();
}

</script>
	</head>
	<BODY onload="javascript:loadHoldPhone()">
		<div class="itemHeader">
			<div id="hold_phone_title">
				ȡ����
			</div>
		</div>
		<table width="100%" cellspacing="0" cellpadding="0" border="0">
			<tbody>
				<tr>
					<td>
						&nbsp;
					</td>
				</tr>
				<tr>
					<td align="center" class="grey" width="100%">
						���ֺ��룺
					</td>
				</tr>
				<tr>
					<td>
						&nbsp;
					</td>
				</tr>
				<tr>
					<td align="center" class="grey" width="100%">
						<select name="hold_phone" id="hold_phone" size="10">
						</select>
					</td>
				</tr>
				<tr>
					<td>
						&nbsp;
					</td>
				</tr>
				<tr>
					<td align="center" class="grey" width="100%">
						<input type="button" name="btnSubmit" value="ȷ��" onClick="holdPhone()" />
						<input type="button" name="btnCancel" value="ȡ��" onClick="callCancel()"/>
					</td>
				</tr>
			</tbody>
		</table>
	</body>
</html>
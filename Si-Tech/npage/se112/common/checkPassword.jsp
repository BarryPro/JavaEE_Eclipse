<script type="text/javascript">
function getPassword(psdEleId) {
	// �Ƚ���������Ϊֻ��
	$("#" + psdEleId).attr("readonly", "readonly");
	// ����������Ϊ��
	$("#" + psdEleId).val("");
	var path = "/npage/common/NumberDialog.jsp";
	var h = 170;
	var w = 470;
	var t = screen.availHeight / 2 - h / 2;
	var l = screen.availWidth / 2 - w / 2;
	var prop = "dialogHeight:" + h + "px; dialogWidth:" + w + "px; dialogLeft:" + l + "px; dialogTop:" + t
			+ "px;toolbar:no; menubar:no; scrollbars:no; resizable:no;location:no;status:no";

	var password = window.showModalDialog(path, "", prop);
	if ("" == password || "undefined" == password || "null" == password || "NULL" == password) {
		password = "";
	} else {
		// Ϊ������ֵ
		$("#" + psdEleId).val(password);
	}
	return password;
}
/**
 * paramΪ�Զ������
 */
function validatePwd(svcNum, password){
	var packet = new AJAXPacket("<%=request.getContextPath()%>/npage/se112/checkPasswordService.jsp","���Ժ�...");
	packet.data.add("phoneNo",svcNum);
	packet.data.add("password",password);
	core.ajax.sendPacketHtml(packet,validatePwdCallBack,true);
	packet = null;
}
function validatePwdCallBack(resp){
	var retStr = $.trim(resp);
	var retArr = retStr.split('|');
	resfun(retArr[0], retArr[1]);
}
</script>
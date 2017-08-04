<script type="text/javascript">
function getPassword(psdEleId) {
	// 先将密码域置为只读
	$("#" + psdEleId).attr("readonly", "readonly");
	// 将密码域置为空
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
		// 为密码域赋值
		$("#" + psdEleId).val(password);
	}
	return password;
}
/**
 * param为自定义参数
 */
function validatePwd(svcNum, password){
	var packet = new AJAXPacket("<%=request.getContextPath()%>/npage/se112/checkPasswordService.jsp","请稍后...");
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
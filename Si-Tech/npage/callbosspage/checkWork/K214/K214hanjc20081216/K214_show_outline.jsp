<%@page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<title></title>
<script>
function closeThisWin(){
	var object_id  = document.getElementById("object_id").value;
	var content_id = document.getElementById("content_id").value;
	if(object_id == ""){
		rdShowMessageDialog('请选择质检对象！', 0);
		return false;
	}
	if(content_id == ""){
		rdShowMessageDialog('请选择考评内容！', 0);
		return false;
	}	
	
	
	var height = 250;
	var width  = 800;
	var top    = (screen.availHeight - height)/2;
	var left   = (screen.availWidth - width)/2;
	var param  = 'toolbar=no,location=no,directories=no,status=yes,menubar=no,scrollbars=yes,resizable=yes,' +
	             'width=' + width + ',height=' + height + ',left= ' + left + ',top=' + top;
window.open('K214_modify_plan_qc_main.jsp?object_id=' +object_id + '&content_id=' + content_id, '', param);
}

function cancel(){
	var object_id      = document.getElementById("object_id");
	var content_id     = document.getElementById("content_id");
	var object_name    = document.getElementById("qc_object");
	var content_name   = document.getElementById("qc_content");	
	object_id.value    = "";
	content_id.value   = "";
	object_name.value  = "";
	content_name.value = "";
}
</script>
</head>

<body>
<table>
	<tr>
		<td>被检测对象类别</td>
		<td>
			<input type="text" name="qc_object" id="qc_object" value=""/>
			<input type="hidden" name="object_id" id="object_id" value=""/>
		</td>
		<td>考评内容</td>
		<td>
			<input type="text" name="qc_content" id="qc_object" value=""/>
			<input type="hidden" name="content_id" id="content_id" value=""/>
		</td>
		<td><input type="button" name="btn_submit" value="确定" class="b_foot" onclick="closeThisWin();"/></td>
		<td><input type="button" name="btn_cancel" value="取消" class="b_foot" onclick="cancel();"/></td>
	</tr>
</talbe>
</body>
</html>

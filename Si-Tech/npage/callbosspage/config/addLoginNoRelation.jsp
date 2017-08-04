<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%
  /*
   * 功能: 工号关系绑定配置-新增绑定关系窗体
　 * 版本: 1.0.0
　 * 日期: 2009/06/07
　 * 作者: donglei
　 * 版权: sitech
   * update:
　 */
%>

<%@ page contentType="text/html;charset=gbk"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%
String boss_login_no =  request.getParameter("boss_login_no");
%>
<html>
<head>
<title>新增工号绑定关系</title>
<script type="text/javascript" src="<%=request.getContextPath()%>/njs/csp/checkWork_dialog.js"></script>
<script language=javascript>
	
/**
  *新增工号绑定关系
  */
function addLoginNoRelation(){
	var boss_login_no   = document.getElementById("boss_login_no").value;
	var kf_login_no     = document.getElementById('kf_login_no').value;
	var login_status     = document.getElementById('login_status').value;
		
	var packet = new AJAXPacket(<%=request.getContextPath()%>"/npage/callbosspage/config/loginNoRelation_rpc.jsp","...");
	packet.data.add("retType","addRelation");
	packet.data.add("boss_login_no",boss_login_no);
	packet.data.add("kf_login_no",kf_login_no);
	packet.data.add("login_status",login_status);
	core.ajax.sendPacket(packet,doProcessAddRelation,true);
	packet=null;
}

/**
  *返回处理函数
  */
function doProcessAddRelation(packet) {
	var retType = packet.data.findValueByName("retType");
	var retCode = packet.data.findValueByName("retCode");

	if (retType == 'addRelation' && retCode == "000000") {
		similarMSNPop("平台工号绑定成功！");		
	  setTimeout("window.opener.document.sitechform.search.click();",1000);	
		setTimeout("closeWin();",1500);	
	} else {
		similarMSNPop("平台工号绑定失败！");
		setTimeout("closeWin();",1000);
	}
}



// 清除表单记录
function cleanValue(){
document.getElementById("kf_login_no").value="";	
}

function closeWin(){
	window.close();
}

function initValue(){
document.getElementById("boss_login_no").value="<%=boss_login_no%>";	
}

</script>
</head>

<body >
<form id=sitechform name=sitechform>
	<div id="Operation_Table">
		<div class="title"><div id="title_zi">增加工号关系绑定配置</div></div>
		<table>
		 <tr>
  				<td class="blue">BOSS工号 </td>
  				<td width="70%">
  					<input id="boss_login_no" name="boss_login_no" size="20" maxlength="6" type="text"  readOnly value="">
	  			</td>
			</tr>
						<tr>
  				<td class="blue">平台工号 </td>
  				<td width="70%">
       <input id="kf_login_no" name="kf_login_no" size="20" type="text" maxlength="6"  value="">
	  			</td>
			</tr>
			<tr>
  				<td class="blue">状态 </td>
  				<td width="70%">
  					<select id="login_status" name="login_status" size="1" onchange="this.value=login_status.options[this.selectedIndex].value;">
  					<option value="Y" selected>正常</option>
            <option value="N" >失效</option>
  					</select>
	  			</td>
			</tr>
			<tr >
  				<td colspan="2" align="center" id="footer">
   					<input name="add" type="button" class="b_text" id="add" value="添加" onClick="addLoginNoRelation()">
   					<input name="clean" type="button" class="b_text" id="clean" value="重设" onClick="cleanValue()">
   					<input name="close" type="button" class="b_text" id="close" value="关闭" onClick="closeWin()">
  				</td>
			</tr>
		</table>
	</div>
</form>
</body>
</html>
<script language=javascript>
initValue();
</script>
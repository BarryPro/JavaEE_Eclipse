<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	
<%
  /*
   * ����: ���Ź�ϵ������-�޸İ󶨹�ϵ����
�� * �汾: 1.0.0
�� * ����: 2008/11/05
�� * ����: 
�� * ��Ȩ: sitech
   * update:
�� */
%>
<%@ page contentType="text/html;charset=gbk"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%
String boss_login_no =  request.getParameter("boss_login_no");
String kf_login_no =  request.getParameter("kf_login_no");
String flag =  request.getParameter("flag");
%>

<head>
<title>�޸Ĺ��Ű󶨹�ϵ</title>
<script type="text/javascript" src="<%=request.getContextPath()%>/njs/csp/checkWork_dialog.js"></script>
<script language=javascript>
	
/**
  *�޸Ĺ��Ź�ϵ
  */
function modifyLoginNoRelation(){
	var boss_login_no   = document.getElementById("boss_login_no").value;
	var kf_login_no     = document.getElementById('kf_login_no').value;
	var login_status     = document.getElementById('login_status').value;
	var packet = new AJAXPacket("loginNoRelation_rpc.jsp","...");
	packet.data.add("retType","modifyRelation");
	packet.data.add("boss_login_no",boss_login_no);
	packet.data.add("kf_login_no",kf_login_no);
	packet.data.add("login_status",login_status);
	core.ajax.sendPacket(packet,doProcessModifyRelation);
	packet=null;
}

/**
  *���ش�����
  */
  
function doProcessModifyRelation(packet) {
	var retType = packet.data.findValueByName("retType");
	var retCode = packet.data.findValueByName("retCode");
	if (retType == 'modifyRelation' && retCode == "000000") {
		rdShowMessageDialog("�󶨹�ϵ�޸ĳɹ���");	
		setTimeout("window.opener.document.sitechform.search.click();",1000);	
		setTimeout("closeWin();",1500);	
	} else {
		rdShowMessageDialog("�󶨹�ϵ�޸�ʧ�ܣ�");
		setTimeout("closeWin();",1000);	
	}
}



// �������¼
function cleanValue(){
document.getElementById("kf_login_no").value="";	
}

function closeWin(){
	window.close();
}

function initValue(){
document.getElementById("boss_login_no").value="<%=boss_login_no%>";	
document.getElementById("kf_login_no").value="<%=kf_login_no%>";	

}
function ajaxLoTis(){
	var sqlV1 = "SELECT COUNT(*) FROM dloginmsgRelation WHERE kf_login_no ='"+document.all.kf_login_no.value.trim()+"'"
 	var packet1 = new AJAXPacket("ajaxGetSqlResult.jsp","���Ժ�...");
		packet1.data.add("sqlV1",sqlV1);
		core.ajax.sendPacket(packet1,doAjaxGetSqlResult);
		packet1 =null;			
 }
 
 function doAjaxGetSqlResult(packet){
 		var error_code = packet.data.findValueByName("code");
		var error_msg =  packet.data.findValueByName("msg");
		var prodCompInfo = packet.data.findValueByName("offerLimitArray");	
		var checkValue = "";
		if(typeof(prodCompInfo[0][0])!="undefined"&&prodCompInfo[0][0]!="null"&&prodCompInfo[0][0]!=null){
				checkValue = prodCompInfo[0][0];
		}
		
		if(checkValue != "0"){
			rdShowMessageDialog("ƽ̨�����ظ�������������");
			document.all.kf_login_no.value = "";
		}
 }
</script>
</head>

<body >
<form id=sitechform name=sitechform>
	<div id="Operation_Table">
		<div class="title"><div id="title_zi">�޸Ĺ��Ź�ϵ������</div></div>
		<table>
		 <tr>
  				<td class="blue">BOSS���� </td>
  				<td width="70%">
  					<input id="boss_login_no" name="boss_login_no" size="20" maxlength="6" type="text"  readOnly value="">
	  			</td>
			</tr>
						<tr>
  				<td class="blue">ƽ̨���� </td>
  				<td width="70%">
       <input id="kf_login_no" name="kf_login_no" size="20" type="text" maxlength="6"  value="" onblur="ajaxLoTis()">
	  			</td>
			</tr>
			<tr>
  				<td class="blue">״̬ </td>
  				<td width="70%">
  					<select id="login_status" name="login_status" size="1" onchange="this.value=login_status.options[this.selectedIndex].value;">
  					<%if(("Y").equals(flag)){%>
  					<option value="Y" selected>����</option>
            <option value="N" >ʧЧ</option>
            <%}else{%>
            <option value="Y" >����</option>
            <option value="N" selected>ʧЧ</option>     
            <%}%>
  					</select>
	  			</td>
			</tr>
			<tr >
  				<td colspan="2" align="center"  id="footer">
   					<input name="add" type="button" class="b_text" id="add" value="�޸�" onClick="modifyLoginNoRelation();">
   					<input name="clean" type="button" class="b_text" id="clean" value="����" onClick="cleanValue()">
   					<input name="close" type="button" class="b_text" id="close" value="�ر�" onClick="closeWin()">
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
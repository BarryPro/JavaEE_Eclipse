<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%
  /*
   * ����: ���������ѯ
   * �汾: 1.0
   * ����: 2011-08-19 
   * ����: wanglma  finally
   * ��Ȩ: si-tech
   * update:
  */
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<script type="text/javascript" src="/npage/public/pubScript.js"></script>	
<head>
	<title>���ű����ѯ</title>
	<%
		String opCode = request.getParameter("opCode");
		String opName = request.getParameter("opName");
		String workNo = (String)session.getAttribute("workNo");
		String regionCode= (String)session.getAttribute("regCode");
	%>
	<script language="JavaScript">
		window.onload = function() {
			changeSelType();
		}
		function changeSelType() {
			var selTypeObj = document.getElementById("selType");
			if (selTypeObj.value == "0") {
				document.getElementById("roleDis").style.display = "none";
				document.getElementById("workNoDis").style.display = "";
			} else if (selTypeObj.value == "1") {
				document.getElementById("workNoDis").style.display = "none";
				document.getElementById("roleDis").style.display = "";
			}
		}
		
		function selectroleAdd() {
			var path = "roletree.jsp?formFlag=form1";
			window.open(path,'_blank','height=600,width=300,scrollbars=yes');
		}
		
		function frmCfm(){
			var chkPacket = new AJAXPacket("fe120_getTab.jsp","��ȴ�������");
			chkPacket.data.add("selType" , document.getElementById("selType").value);
			
			var selTypeObj = document.getElementById("selType");
			if (selTypeObj.value == "0") {
				if($("#selCode").val() == ""){
					rdShowMessageDialog("�������ѯ���룡");
					return false;
				}
				chkPacket.data.add("selCode" , $("#selCode").val());
			} else if (selTypeObj.value == "1") {
				if (document.getElementById("roleCode").value.trim().length == 0) {
					rdShowMessageDialog("��ѡ���ɫ��");
					document.getElementById("selType").value = "0";
					changeSelType();
					return;
				}
				chkPacket.data.add("selCode" , $("#roleCode").val());
			}
			
			core.ajax.sendPacketHtml(chkPacket,showMsg);
			chkPacket =null;
		}
		function showMsg(data){
			$("#showTabdiv").empty().append(data);
			if($("#code").val() != "000000"){
				rdShowMessageDialog("errorCode : "+$("#code").val() +" </br> errorMsg : "+$("#msg").val());
			}
			document.getElementById("selType").value = "0";
			changeSelType();
		}
		
	</script>
<body>
<form name="form1" method="POST" >
	<%@ include file="/npage/include/header.jsp" %>
	<div class="title">
		<div id="title_zi"><%=opName%></div>
	</div>
	<table cellspacing="0">
		<tr>
		   <td class="blue">��ѯ��ʽ</td>
		   <td ><select name="selType" id="selType" onchange="changeSelType()"><option value="0">����</option><option value="1">��ɫ</option></select></td>	
		</tr>
		<tr name="workNoDis" id="workNoDis" style="display:none">
			<td class="blue">����</td>
			<td colspan="3">
				<input type="text" id="selCode" name="selCode" />
			</td>
		</tr>
		<tr name="roleDis" id="roleDis" style="display:none">
			<td class="blue">��ɫ</td>
			<td colspan="3">
				<input name="roleCode" id="roleCode" type=hidden >
				<input name="roleName" v_must=1 v_minlength=1 v_maxlength=100 v_name="��ɫ" readonly Class="InputGrey">
				<input  type="button" name="query_role_parter" onclick="selectroleAdd()" value="��ѯ" class="b_text">
			</td>
		</tr>
	</table>
	<table cellspacing="0">
		<tr>
			<td noWrap id="footer">
			<div align="center">
				<input type="reset" name="query" class="b_foot" value="ȷ��" onclick="frmCfm(this)" />
				&nbsp;
				<input type="button" name="close" class="b_foot" value="�ر�" onClick="removeCurrentTab();">
			</div>
			</td>
		</tr>
	</table>
	<div id="showTabdiv"></div>
	<input type="hidden" name="opCode" value="<%=opCode%>" />
	<input type="hidden" name="opName" value="<%=opName%>" />
	<%@ include file="/npage/include/footer.jsp" %>
</form>
</body>
</html>
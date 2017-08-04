<%
  /*
   * ����: e555��������ת״̬ͬ������
   * �汾: 1.0
   * ����: 20120118
   * ����: wanghfa
   * ��Ȩ: si-tech
  */
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>

<%
	response.setHeader("Pragma","No-Cache"); 
	response.setHeader("Cache-Control","No-Cache");
	response.setDateHeader("Expires", 0); 
	request.setCharacterEncoding("GBK");
	String opCode = "e555";
	String opName = "������ת״̬ͬ������";
	String workNo = (String)session.getAttribute("workNo");
	String password = (String)session.getAttribute("password");
	String regionCode = (String)session.getAttribute("regCode");
%>


<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>������ת״̬ͬ������</title>
<script type=text/javascript>
	onload = function() {
		$("#submitBtn").bind("click", function() {
			queryMsg();
		});
	}
	function controlBtn(flag) {
		$("#submitBtn").attr("disabled", flag);
		$("#backBtn").attr("disabled", flag);
		$("#closeBtn").attr("disabled", flag);
	}
	
	function queryMsg(){
		var pageTitle = "��ѡ��";
		if (!checkElement(document.getElementById("customerNumber"))) {
			return false;
		}
		//var fieldName = "��Ʒ������|��ǰ״̬|��ǰ״̬������|�绰|���ڵ�λ������|״̬ͬ��ʱ��|��ע|";
		var fieldName = "��Ʒ������|EC���ſͻ�����|��Ʒ������|��ǰ״̬|״̬ͬ��ʱ��|��ע|ҵ��չģʽ|";
		var sqlStr = "";
		var selType = "S";    //'S'��ѡ��'M'��ѡ
		var retQuence = "7|0|1|2|3|4|5|6|";
		
		var path = "fPubSel.jsp";
		path = path + "?sqlStr=" + sqlStr + "&retQuence=" + retQuence;
		path = path + "&fieldName=" + fieldName + "&pageTitle=" + pageTitle;
		path = path + "&selType=" + selType + "&customerNumber=" + $("#customerNumber").val();
		path = path + "&toOperate=" + $("#toOperate").val();
		
		retInfo = window.open(path,"newwindow","height=450, width=1000,top=50,left=200,scrollbars=yes, resizable=no,location=no, status=yes");
		return true;
	}
	
	function getProductOrderValue(retInfo){
		//var retToField = "poOrderNumber|stateType|resppersonName|resppersonPhone|resppersonDepartment|syntime|notes|";
		var retToField = "poOrderNumber|customerNumber|poSpecNumber|stateType|syntime|notes|businessMode|";
		if(retInfo == undefined) {
			return false;
		}
		
		var chPos_field = retToField.indexOf("|");
		var chPos_retStr;
		var valueStr;
		var obj;
		while(chPos_field > -1) {
			obj = retToField.substring(0,chPos_field);
			chPos_retInfo = retInfo.indexOf("|");
			valueStr = retInfo.substring(0,chPos_retInfo);
			document.all(obj).value = valueStr;
			retToField = retToField.substring(chPos_field + 1);
			retInfo = retInfo.substring(chPos_retInfo + 1);
			chPos_field = retToField.indexOf("|");
		}
		$("#customerNumber").attr("readOnly",true);
		
		$("#opType").val($("#toOperate").val());
		$("#toOperate").attr("disabled",true);
		$("#submitBtn").val("��һ��");
		
		$("#submitBtn").unbind();
		$("#submitBtn").bind("click", function() {
			controlBtn(true);
			document.frm.action = "fe555_main.jsp";
			document.frm.submit();
		});
	}
</script>

</head>
<body>
<form name="frm" action="" method="post" >
	<input type="hidden" name="opType" id="opType">
	<input type="hidden" name="poOrderNumber" id="poOrderNumber">
	<input type="hidden" name="poSpecNumber" id="poSpecNumber">
	<input type="hidden" name="stateType" id="stateType">
	<input type="hidden" name="resppersonName" id="resppersonName">
	<input type="hidden" name="resppersonPhone" id="resppersonPhone">
	<input type="hidden" name="resppersonDepartment" id="resppersonDepartment">
	<input type="hidden" name="syntime" id="syntime">
	<input type="hidden" name="notes" id="notes">
	<input type="hidden" name="businessMode" id="businessMode">
<%@ include file="/npage/include/header.jsp" %>
<div class="title">
	<div id="title_zi">��Ϣ��ѯ</div>
</div>
<table cellspacing=0>
	<tr>
		<td class="blue" width="20%">EC���ſͻ�����</td>
		<td width="30%">
			<input name="customerNumber" id="customerNumber" v_type="0_9" v_must="1" maxlength="30" value="">
			<font class='orange'>*</font>
		</td>
		<td class="blue" width="20%">��������</td>
		<td width="30%">
			<select name="toOperate" id="toOperate">
				<option value="q">��������״̬��ѯ</option>
				<option value="4">��ʱ��·ȡ������</option>
				<option value="5">���ʡ�ѷ���ͻ��������</option>
				<option value="6">���ʡ��ʵ�������</option>
			</select>
		</td>
	</tr>
	<tr>
		<td colspan="4" align="center" id="footer">
			<input class="b_foot" type=button name="submitBtn" id="submitBtn" value="��ѯ">
			<input class="b_foot" type=button name="backBtn" id="backBtn" value="����" onclick="window.location='fe555.jsp'">
			<input class="b_foot" type=button name="closeBtn" id="closeBtn" value="�ر�" onclick="removeCurrentTab();">
		</td>
	</tr>
</table>
<%@ include file="/npage/include/footer.jsp" %>
</form>
</body>
</html>
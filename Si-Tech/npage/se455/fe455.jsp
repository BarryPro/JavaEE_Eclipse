<%
  /*
   * ����: ʵ�����޸�
   * �汾: 1.0
   * ����: 20111206
   * ����: wanghfa
   * ��Ȩ: si-tech
  */
%>
<!DOCTYPE html PUBLIC "-//W3C//Dtd Xhtml 1.0 transitional//EN" "http://www.w3.org/tr/xhtml1/Dtd/xhtml1-transitional.dtd">
<%@	page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%
  response.setHeader("Pragma","No-Cache"); 
  response.setHeader("Cache-Control","No-Cache");
  response.setDateHeader("Expires", 0); 
  request.setCharacterEncoding("GBK");
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>ʵ�����޸�</title>

<%
	String opCode = request.getParameter("opCode");
	String opName = request.getParameter("opName");;
	String workNo = (String)session.getAttribute("workNo");
	String regionCode = ((String)session.getAttribute("regCode")).substring(0,2);
%>

<META content="MSHTML 5.00.3315.2870" name=GENERATOR>
<script language="javascript">
	onload = function() {
		changeOpType();
		chaOpType();
	}
	
	function changeOpType() {
		var opType = $("input[@name=opType]:checked").val();
		
		if (opType == "singlePhone") {
			$("#singlePhoneType").show();
			$("#multiFileType").hide();
		} else if (opType == "multiFile") {
			$("#singlePhoneType").hide();
			$("#multiFileType").show();
		}
	}
	
	function controlBtn(flag) {
		$("#submitBtn").attr("disabled", flag);
		$("#backBtn").attr("disabled", flag);
		$("#closeBtn").attr("disabled", flag);
	}
	
	function doCfm() {
		var opType = $("input[@name=opType]:checked").val();
		controlBtn(true);
		
		if (opType == "singlePhone") {
			if (!checkElement(document.getElementById("phoneNo"))) {
				controlBtn(false);
				return false;
			}
			document.frm.action = "fe455_cfm.jsp?phoneNo=" + document.getElementById("phoneNo").value + "&trueCode=" + document.getElementById("trueCode").value;
		} else if (opType == "multiFile") {
			if (document.getElementById("fileName").value.length == 0) {
				rdShowMessageDialog("��ѡ���ϴ����ļ���", 1);
				controlBtn(false);
				return false;
			}
			document.frm.action = "fe455_filecfm.jsp";
		}
		
		document.frm.submit();
	}
	
	
	function closeWindow() {
		if(window.opener == undefined) {
			removeCurrentTab();
		} else {
			window.close();
		}
	}
	function chaOpType(){
		var opType = $.trim($("select[name='opType22']").find("option:selected").val());
		if(opType == "1"){
			$("#noContent").html("�ֻ�����");
			$("#phoneNo").attr("maxlength","11");
			$("#MOshow").show();
			$("#KDshow").hide();
		}else {
			$("#noContent").html("�������");
			$("#phoneNo").attr("maxlength","30");
			$("#MOshow").hide();
			$("#KDshow").show();
		}
		
		
	}
</script>
</head>
<body>
<form name="frm" method="POST" ENCTYPE="multipart/form-data">
 	<input type="hidden" name="opCode" id="opCode" value="<%=opCode%>">
 	<input type="hidden" name="opName" id="opName" value="<%=opName%>">
	<%@ include file="/npage/include/header.jsp" %>
	<div class="title">
		<div id="title_zi">ʵ�����޸�</div>
	</div>
<table cellspacing="0">
	<tr>
		<td class="blue" width="30%">��ѡ���޸ķ�ʽ</td>
		<td width="70%">
			<input type="radio" name="opType" value="singlePhone" onclick="changeOpType();" checked>���������޸�
			<input type="radio" name="opType" value="multiFile" onclick="changeOpType();"/>�ϴ��ļ������޸�
		</td>
	</tr>
	<tr>
			<td class="blue" width="30%">��������</td>
			<td>
				<select name="opType22" id="opType22" onchange="chaOpType();">
					<option value="1">�ֻ�����</option>
					<option value="0">�������</option>
				</select>
			</td>
		</tr>
	<tbody id="singlePhoneType" style="display:none">
		<tr>
			<td id="noContent" class="blue" width="30%">�ֻ�����</td>
			<td>
				<input type="text" name="phoneNo" id="phoneNo" maxlength="20" v_maxlength="11" v_must="1" value="" />
			</td>
		</tr>
		<tr>
			<td class="blue" width="30%">ʵ��ѡ��</td>
			<td>
				<select name="trueCode" id="trueCode">
					<option value="1">ʵ��</option>
					<option value="2">׼ʵ��</option>
					<option value="3">��ʵ��</option>
				</select>
			</td>
		</tr>
	</tbody>
	<tbody id="multiFileType" style="display:none">
		<tr>
			<td class="blue" width="20%">�ļ�</td>
			<td width="80%">
				<input type="file" name="fileName" id="fileName" class="button" style='border-style:solid;border-color:#7F9DB9;border-width:1px;font-size:12px;' />
			</td>
		</tr>
		<tr>
			<td class="blue">�ļ�˵��</td>
			<td id="MOshow">
				һ.�������ļ�����Ϊ�ı��ļ�(��׺.txt)</br>
				&nbsp;��.��˳���ֻ����룬ʵ���Ʊ�ʶ��1-ʵ����2-׼ʵ����3-��ʵ����</br>
				&nbsp;��.ÿ��֮��ʹ�ÿո�ָ�</br>
				&nbsp;��.ʾ�����£�</br>
				15888888888 1</br>
				15888888889 3</br>
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			</td>
			<td id="KDshow">
				һ.�������ļ�����Ϊ�ı��ļ�(��׺.txt)</br>
				&nbsp;��.��˳�򣺿�����룬ʵ���Ʊ�ʶ��1-ʵ����2-׼ʵ����3-��ʵ����</br>
				&nbsp;��.ÿ��֮��ʹ�ÿո�ָ�</br>
				&nbsp;��.ʾ�����£�</br>
				ttkd201602222222 1</br>
				ysbn201602220101 3</br>
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			</td>
		</tr>
	</tbody>
	<tr>
		<td colspan="3" align="center" id="footer">
			<input class="b_foot" type=button name="submitBtn" id="submitBtn" value="ȷ��" onClick="doCfm()">    
			<input class="b_foot" type=button name="closeBtn" id="closeBtn" value="�ر�" onClick="removeCurrentTab();">
		</td>
	</tr>
</table>
<%@ include file="/npage/include/footer_simple.jsp" %>
</form>
</body>
</html>

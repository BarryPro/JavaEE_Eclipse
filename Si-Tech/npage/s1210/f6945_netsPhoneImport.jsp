<% 
  /*
   * ����: ��������������� 
�� * �汾: v1.00
�� * ����: 2012-6-18 14:11:20
�� * ����: liujian
�� * ��Ȩ: sitech
   * �޸���ʷ
   * �޸�����      �޸���      �޸�Ŀ��
   *  
  */
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<html>
<META http-equiv=Content-Type content="text/html; charset=GBK">
<head>
<title>���������������</title>

<%
String opCode = "e884";
String opName = "���������������";

String work_no = (String) session.getAttribute("workNo");
String loginNoPass = (String)session.getAttribute("password");
String org_code = (String) session.getAttribute("orgCode");
String regionCode = org_code.substring(0, 2);

%>

<script language=javascript>
$(function() {
	//Ĭ��ʮ��
	for(var j=1;j<11;j++) {
		$('#importTbody').append(trHtmlSmt(j));			
	}
	
	$('select[id^="opType_"]').change(function() {
		var $this = $(this);
		var _id = $this.attr('id');
		var no = '';
		if(_id.indexOf('_')+1 < _id.length) {
			no = _id.substring(_id.indexOf('_')+1,_id.length);
		}
		if(no) {
			var intNo = parseInt(no);
			if(intNo != 1) {
				var mNo = intNo - 1;
				if(!$('#phoneNo_'+mNo).parent().parent().attr('disabled')) {
					$this.val('');
					rdShowMessageDialog("��һ����δ��ӣ��밴˳����ӣ�");
					return false;
				}	
			}	
			var selectHtml = new Array();
			if($this.val() == 'A') {
				  $('#delayType_' + no).empty();
					selectHtml.push('<option value="N">��ͣ7��</option>');
					selectHtml.push('<option value="T">���ڹ�ͣ</option>');
					$('#delayType_' + no).append(selectHtml.join(''));
			}else if($this.val() == 'U') {
				  $('#delayType_' + no).empty();
					selectHtml.push('<option value="Y">����7��</option>');
					selectHtml.push('<option value="N">��ͣ7��</option>');
					selectHtml.push('<option value="T">���ڹ�ͣ</option>');
					selectHtml.push('<option value="F">�����ָ�</option>');
					$('#delayType_' + no).append(selectHtml.join(''));
			}
		}
	});
	$('select[id^="delayType_"]').change(function() {
		var $this = $(this);
		var _id = $this.attr('id');
		var no = '';
		if(_id.indexOf('_')+1 < _id.length) {
			no = _id.substring(_id.indexOf('_')+1,_id.length);
		}
		if(no) {
			var intNo = parseInt(no);
			if(intNo != 1) {
				var mNo = intNo - 1;
				if(!$('#phoneNo_'+mNo).parent().parent().attr('disabled')) {
					$this.val('');
					rdShowMessageDialog("��һ����δ��ӣ��밴˳����ӣ�");
					return false;
				}	
			}	
		}
	});
});	

function trHtmlSmt(s) {
	var i = s;
	var htmlSmt = new Array();	
	htmlSmt.push('<tr>');
	htmlSmt.push('	<td align="center" class="blue">');
	htmlSmt.push('		<input class="button" type="text" name="phoneNo" id="phoneNo_' + i + '" value="" size="15" maxlength="11" onKeyPress="return isKeyNumberdot(0)" onKeyDown="if(event.keyCode==13) check_HidPwd();">');
	htmlSmt.push('	</td>');
	htmlSmt.push('	<td align="center" class="blue">');
	htmlSmt.push('	    <select name="opType" id="opType_' + i + '" class="button" style="width:200px">');
	htmlSmt.push('	    	<option value="" selected>��ѡ��</option>');
	htmlSmt.push('	    	<option value="A">���Ϊ����������û�</option>');
	htmlSmt.push('	    	<option value="U">�޸ĸ��û������������ʱ��</option>');
	htmlSmt.push('	    </select>');
	htmlSmt.push('	</td>');
	htmlSmt.push('	<td align="center" class="blue">');
	htmlSmt.push('	    <select name="delayType" id="delayType_' + i + '" class="button" >');
	htmlSmt.push('	    	<option value="" selected>��ѡ��</option>');
	htmlSmt.push('	    </select>');
	htmlSmt.push('	</td>');
	htmlSmt.push('	<td align="center" class="blue">');
	htmlSmt.push('	   	<input class="b_text" type="button" name="onAdd" value="���" onclick="addRecord(this,' + i + ')">');
	htmlSmt.push('	</td>');
	htmlSmt.push('</tr>');
	return 	htmlSmt.join('');
}

function addRecord(k,i) {
	var $this = $(k);
	var phoneNo = $('#phoneNo_' + i).val();
	var opType = $('#opType_' + i).val();
	var delayType = $('#delayType_' + i).val();
	if(phoneNo== '' || phoneNo.length < 11) {
		rdShowMessageDialog("������11λ�ֻ����룡");
		return false;
	}
	if(opType == "") {
		rdShowMessageDialog("��ѡ�����/�޸ı�־��");
		return false;
	}
	if(delayType == "") {
		rdShowMessageDialog("��ѡ�����ڱ�־��");
		return false;
	}
	
	$('#iCodeStr' + i).val(phoneNo+"|"+delayType+"|"+opType);
	$this.parent().parent().attr('disabled','disabled');
} 

function confirm() {
	var hasRecord = false;
	$('#importTbody').find('tr').each(function() {
		var $this = $(this);	
		if(!$this.attr('disabled')) {
			rdShowMessageDialog("�������һ����¼��");
			return false;
		}else {
			hasRecord = true;
			return false;
		}
	});
	if(hasRecord) {
		frm.submit();
	}
}

function resetInput() {
		$('input[name="phoneNo"]').val("");
		$('select[name="opType"]').val("");
		$('select[name="delayType"]').empty();
		$('select[name="delayType"]').append('<option value="" selected>��ѡ��</option>');
	//	$('select[name="delayType"]').val("");
		$('tr').removeAttr('disabled');
}
</script>

</head>
<body>
<form name="frm" method="POST" action="fe884ImpCfm.jsp">
<%@ include file="/npage/include/header.jsp" %>

<div class="title">
    <div id="title_zi">�û���Ϣ</div>
</div>
<table cellspacing="0" >
	<thead>
		<tr>
			<td align="center" class="blue" width="20%" nowrap>�ֻ�����</td>
		    <td align="center" class="blue" width="20%" nowrap>���/�޸ı�־</td>
		    <td align="center" class="blue" width="20%" nowrap>���ڱ�־</td>
		    <td align="center" class="blue" width="20%" nowrap>��Ӳ���</td>
		</tr>
	</thead>
	<tbody id="importTbody">
			
	</tbody>
    <tr>
        <td colspan="5" id="footer">
            <input class="b_foot" type="button" name="b_add" value="ȷ��" onClick="confirm();">
            &nbsp;
            <input class="b_foot" type="button" name="b_again" value="����" onClick="resetInput();">
            &nbsp;
            <input class="b_foot" type="button" name="b_back" value="����" onClick="location='s6945Login.jsp'">
            &nbsp;
            <input class="b_foot" type="button" name="b_close" value="�ر�" onClick="removeCurrentTab();">
        </td>
    </tr>
</table>
<input type="hidden" name="opCode1" value="<%=opCode%>">
<input type="hidden" name="opName1" value="<%=opName%>">
<input type="hidden" id="iCodeStr1" name="iCodeStr1" value="">
<input type="hidden" id="iCodeStr2" name="iCodeStr2" value="">
<input type="hidden" id="iCodeStr3" name="iCodeStr3" value="">
<input type="hidden" id="iCodeStr4" name="iCodeStr4" value="">
<input type="hidden" id="iCodeStr5" name="iCodeStr5" value="">
<input type="hidden" id="iCodeStr6" name="iCodeStr6" value="">
<input type="hidden" id="iCodeStr7" name="iCodeStr7" value="">
<input type="hidden" id="iCodeStr8" name="iCodeStr8" value="">
<input type="hidden" id="iCodeStr9" name="iCodeStr9" value="">
<input type="hidden" id="iCodeStr10" name="iCodeStr10" value="">

    <%@ include file="/npage/include/footer.jsp" %>
</form>
</body>
</html>
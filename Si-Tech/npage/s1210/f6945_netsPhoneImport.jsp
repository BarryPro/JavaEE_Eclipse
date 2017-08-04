<% 
  /*
   * 功能: 网间号码批量导入 
　 * 版本: v1.00
　 * 日期: 2012-6-18 14:11:20
　 * 作者: liujian
　 * 版权: sitech
   * 修改历史
   * 修改日期      修改人      修改目的
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
<title>网间号码批量导入</title>

<%
String opCode = "e884";
String opName = "网间号码批量导入";

String work_no = (String) session.getAttribute("workNo");
String loginNoPass = (String)session.getAttribute("password");
String org_code = (String) session.getAttribute("orgCode");
String regionCode = org_code.substring(0, 2);

%>

<script language=javascript>
$(function() {
	//默认十行
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
					rdShowMessageDialog("上一条还未添加，请按顺序添加！");
					return false;
				}	
			}	
			var selectHtml = new Array();
			if($this.val() == 'A') {
				  $('#delayType_' + no).empty();
					selectHtml.push('<option value="N">关停7天</option>');
					selectHtml.push('<option value="T">长期关停</option>');
					$('#delayType_' + no).append(selectHtml.join(''));
			}else if($this.val() == 'U') {
				  $('#delayType_' + no).empty();
					selectHtml.push('<option value="Y">延期7天</option>');
					selectHtml.push('<option value="N">关停7天</option>');
					selectHtml.push('<option value="T">长期关停</option>');
					selectHtml.push('<option value="F">立即恢复</option>');
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
					rdShowMessageDialog("上一条还未添加，请按顺序添加！");
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
	htmlSmt.push('	    	<option value="" selected>请选择</option>');
	htmlSmt.push('	    	<option value="A">添加为网间黑名单用户</option>');
	htmlSmt.push('	    	<option value="U">修改该用户的网间黑名单时间</option>');
	htmlSmt.push('	    </select>');
	htmlSmt.push('	</td>');
	htmlSmt.push('	<td align="center" class="blue">');
	htmlSmt.push('	    <select name="delayType" id="delayType_' + i + '" class="button" >');
	htmlSmt.push('	    	<option value="" selected>请选择</option>');
	htmlSmt.push('	    </select>');
	htmlSmt.push('	</td>');
	htmlSmt.push('	<td align="center" class="blue">');
	htmlSmt.push('	   	<input class="b_text" type="button" name="onAdd" value="添加" onclick="addRecord(this,' + i + ')">');
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
		rdShowMessageDialog("请输入11位手机号码！");
		return false;
	}
	if(opType == "") {
		rdShowMessageDialog("请选择添加/修改标志！");
		return false;
	}
	if(delayType == "") {
		rdShowMessageDialog("请选择延期标志！");
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
			rdShowMessageDialog("请先添加一条记录！");
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
		$('select[name="delayType"]').append('<option value="" selected>请选择</option>');
	//	$('select[name="delayType"]').val("");
		$('tr').removeAttr('disabled');
}
</script>

</head>
<body>
<form name="frm" method="POST" action="fe884ImpCfm.jsp">
<%@ include file="/npage/include/header.jsp" %>

<div class="title">
    <div id="title_zi">用户信息</div>
</div>
<table cellspacing="0" >
	<thead>
		<tr>
			<td align="center" class="blue" width="20%" nowrap>手机号码</td>
		    <td align="center" class="blue" width="20%" nowrap>添加/修改标志</td>
		    <td align="center" class="blue" width="20%" nowrap>延期标志</td>
		    <td align="center" class="blue" width="20%" nowrap>添加操作</td>
		</tr>
	</thead>
	<tbody id="importTbody">
			
	</tbody>
    <tr>
        <td colspan="5" id="footer">
            <input class="b_foot" type="button" name="b_add" value="确认" onClick="confirm();">
            &nbsp;
            <input class="b_foot" type="button" name="b_again" value="重置" onClick="resetInput();">
            &nbsp;
            <input class="b_foot" type="button" name="b_back" value="返回" onClick="location='s6945Login.jsp'">
            &nbsp;
            <input class="b_foot" type="button" name="b_close" value="关闭" onClick="removeCurrentTab();">
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
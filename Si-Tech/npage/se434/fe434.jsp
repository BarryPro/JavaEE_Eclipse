<%
    /********************
     version v2.0
     开发商: si-tech
     *
     *create:wanghfa@2011-11-23 手机与CA卡
     *
     ********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<%@ page contentType="text/html; charset=GB2312" %>
<%@ include file="/npage/include/public_title_name.jsp" %>

<html>
<head>
<title>手机与CA卡绑定</title>
<META content="MSHTML 5.00.3315.2870" name=GENERATOR>
<%
	String opCode = WtcUtil.repStr(request.getParameter("opCode"), "");
	String opName = WtcUtil.repStr(request.getParameter("opName"), "");
	System.out.println("=========wanghfa========= fe434.jsp " + opCode + ", " + opName);

%>

<script language="JavaScript">
	var opCode = '<%=opCode%>';
	//页面初始化
	$(function() {
			//查询用户信息
			$('#userInfo').css('display','block');
			$('#bindInfo').css('display','none');
	})
	
	//查询用户信息
	function userSearch() {
			var ci = $('#card_id').val();
			var ui = $('#user_id').val();
			if(ci == null || ci == "") {
				rdShowMessageDialog("智能卡号不能为空!");
				return false;
			}
			if(ui == null || ui == "") {
				rdShowMessageDialog("广电用户编号不能为空!");
				return false;
			}
			//展示用户绑定详细信息
			$('#userInfo').css('display','block');
			$('#bindInfo').css('display','none');
			//AJAX
			var getdataPacket = new AJAXPacket("fe434_fe435_do.jsp","正在获得信息，请稍候......");
			var _data = getdataPacket.data;
			_data.add("opCode","<%=opCode%>");
			_data.add("phone","<%=activePhone%>");
			_data.add("note",$('#note').val());
			_data.add("user_id",$('#user_id').val());
			_data.add("card_id",$('#card_id').val());
			_data.add("method","searchUserInfo");
			core.ajax.sendPacket(getdataPacket);
			getdataPacket = null;
	}
	function doProcess(getdataPacket) {
			var _data = getdataPacket.data;
			var retCode = _data.findValueByName("retcode");
			var retMsg = _data.findValueByName("retmsg");
			if(retCode == "000000") {
					var user_id = _data.findValueByName("user_id");
					var card_id = _data.findValueByName("card_id");
					var user_name = _data.findValueByName("name");
					var addr = _data.findValueByName("addr");
					var id_type = _data.findValueByName("id_type");
					var id_iccid = _data.findValueByName("id_iccid");
					$('#bind_card_id').val(card_id);
					$('#bind_user_id').val(user_id);
					$('#bind_id_iccid').val(id_iccid);
					$('#bind_user_name').val(user_name);
					$('#bind_addr').val(addr);
					$('#bind_id_type').val(id_type);
					$('#bind_card_id').val(card_id);
					$('#userInfo').css('display','none');
					$('#bindInfo').css('display','block');
			}else {
				rdShowMessageDialog("错误代码：" + retCode + "，错误信息：" + retMsg,0);
				return false;
			}
	}
	
	//CA卡绑定
	function bindCA() {
		//AJAX
		var getdataPacket = new AJAXPacket("fe434_fe435_do.jsp","正在获得信息，请稍候......");
		var _data = getdataPacket.data;
		_data.add("opCode","<%=opCode%>");
		_data.add("phone",$('#bind_activePhone').val());
		_data.add("note",$('#bind_note').val());
		_data.add("user_id",$('#bind_user_id').val());
		_data.add("card_id",$('#bind_card_id').val());
		_data.add("addr",$('#bind_addr').val());
		_data.add("id_type",$('#bind_id_type').val());
		_data.add("id_iccid",$('#bind_id_iccid').val());
		_data.add("user_name",$('#bind_user_name').val());
		_data.add("method","bindCA");
		core.ajax.sendPacket(getdataPacket,bindProcess);
		getdataPacket = null;
	}
	function bindProcess(getdataPacket) {
		var _data = getdataPacket.data;
		var retCode = _data.findValueByName("retcode");
		var retMsg = _data.findValueByName("retmsg");
		if(retCode == "000000"){
			rdShowMessageDialog("操作成功！");
			$('#user_id').val('');
			$('#card_id').val('');
			$('#userInfo').css('display','block');
			$('#bindInfo').css('display','none');
		}else{
			rdShowMessageDialog("错误代码：" + retCode + "，错误信息：" + retMsg,0);
			return false;
		}
	}
</script>
</head>
<body>

<form name="frm" method="POST">
<%@ include file="/npage/include/header.jsp" %>
<div class="title">
	<div name="title_zi" id="title_zi"><%=opName%></div>
</div>
<table cellspacing="0" id="userInfo" style="display:none">
	<tr>
      <td class="blue">手机号码 </td>
      <td  colspan="3">
      		<input type="text" maxlength="11" name="activePhone" id="activePhone" value="<%=activePhone%>" class="InputGrey" readonly />
      </td>
   </tr>
   <tr>
   		<td class="blue">智能卡号 </td>
      <td>
          <input type="text" name="card_id" id="card_id" v_must=1 v_type="string" size="20" maxlength="20" onkeyup="value=value.replace(/[^\w\/]/ig,'')" onblur = "checkElement(this)"/>
          <font class="orange">*</font>
      </td>
      <td class="blue">广电用户编号 </td>
      <td>
          <input type="text" name="user_id" id="user_id"  v_must=1 v_type="string"  size="20" maxlength="20" onkeyup="value=value.replace(/[^\w\/]/ig,'')" onblur = "checkElement(this)"/>
          <font class="orange">*</font>
      </td> 
   </tr>
   <tr>
      <td class=blue>备注 </td>
      <td colspan="3">
          <input class="InputGrey" name="note" id="note" size="60" readonly />
      </td>
  </tr>
  <tr id="footer">
      <td colspan="4">
          <input class="b_foot" name="sure"  id="sure"  type=button value="查询"  onclick="userSearch()" />
          <input class="b_foot" name="reset1"  onClick="" type=reset value="清除" />
          <input class="b_foot" name="close"  onClick="removeCurrentTab();" type=button value="关闭" />
      </td>
  </tr>
</table>

<table cellspacing="0" id="bindInfo" style="display:none">
	<tr>
			<td class="blue">移动客户名称 </td>
      <td>
          <input type="text" name="bind_user_name" id="bind_user_name" size="20" maxlength="20" class="InputGrey" value="" readonly />
      </td>
      <td class="blue">手机号码 </td>
      <td>
      		<input type="text" maxlength="11" name="bind_activePhone" id="bind_activePhone" value="<%=activePhone%>" class="InputGrey" readonly />
      </td>
  </tr>
  <tr>
      <td class="blue">证件类型 </td>
      <td>
          <input type="text" name="bind_id_type" id="bind_id_type" class="InputGrey" readonly />
      </td>
      <td class="blue">身份证号码 </td>
      <td>
          <input type="text" name="bind_id_iccid" id="bind_id_iccid" class="InputGrey" readonly />
      </td>
   </tr>
   <tr>    
      <td class="blue">智能卡号 </td>
      <td>
          <input type="text" name="bind_card_id" id="bind_card_id" class="InputGrey" readonly />
      </td>
  
      <td class="blue">广电用户编号 </td>
      <td>
          <input type="text" name="bind_user_id" id="bind_user_id" class="InputGrey" readonly />
      </td> 
   </tr>
   <tr> 
     <td class="blue">客户地址 </td>
      <td colspan="3">
          <input type="text" name="bind_addr" id="bind_addr" class="InputGrey" readonly />
      </td>
   </tr>
   <tr> 
      <td class=blue>备注 </td>
      <td colspan="3">
          <input class="InputGrey" name="bind_note" id="bind_note" maxlength="30" size="60" readonly />
      </td>
   </tr>
   <tr id="footer">
      <td colspan="4">
          <input class="b_foot" name="bind"  id="bind"  type=button value="绑定"  onclick="bindCA()" />
          <input class="b_foot" name="goback"  id="goback"  type=button value="回退"  onclick="javascript:history.go(-1);" />
          <input class="b_foot" name="close"  onClick="removeCurrentTab();" type=button value="关闭" />
      </td>
  </tr>
</table>
<%@ include file="/npage/include/footer_simple.jsp" %> 
</form>
</body>
</html>

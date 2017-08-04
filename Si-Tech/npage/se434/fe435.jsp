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
<%
	String opCode = WtcUtil.repStr(request.getParameter("opCode"), "");
	String opName = WtcUtil.repStr(request.getParameter("opName"), "");
	System.out.println("=========wanghfa========= fe435.jsp " + opCode + ", " + opName);

%>

<head>
<title>手机与CA卡解除绑定</title>
<META content="MSHTML 5.00.3315.2870" name=GENERATOR>


<script language="JavaScript">
	var opCode = '<%=opCode%>';
	//页面初始化
	$(function() {
		var getdataPacket = new AJAXPacket("fe434_fe435_do.jsp","正在获得信息，请稍候......");
		var _data = getdataPacket.data;
		_data.add("opCode","<%=opCode%>");
		_data.add("note",$('#bind_note').val());
		_data.add("phone",$('#activePhone').val());
		_data.add("method","searchBindInfo");
		core.ajax.sendPacket(getdataPacket,searchProcess);
		getdataPacket = null;
	})
	function searchProcess(getdataPacket) {
		var _data = getdataPacket.data;
		var retCode = _data.findValueByName("retcode");
		var retMsg = _data.findValueByName("retmsg");
		
		if(retCode == "000000") {
				var user_id = _data.findValueByName("user_id");
				var card_id = _data.findValueByName("card_id");
				var user_name = _data.findValueByName("userName");
				var addr = _data.findValueByName("addr");
				var id_type = _data.findValueByName("id_type");
				var id_iccid = _data.findValueByName("id_iccid");
				$('#card_id').val(card_id);
				$('#user_id').val(user_id);
				$('#iccid').val(id_iccid);
				$('#user_name').val(user_name);
				$('#addr').val(addr);
				$('#icc_type').val(id_type);
				$('#card_id').val(card_id);
		}else {
			rdShowMessageDialog("错误代码：" + retCode + "，错误信息：" + retMsg,0);
			//$('#unbind').attr('disabled',true);
			return false;
		}
	}
	//AC卡接触绑定
	function unbindCA() {
		var getdataPacket = new AJAXPacket("fe434_fe435_do.jsp","正在获得信息，请稍候......");
		var _data = getdataPacket.data;
		_data.add("opCode","<%=opCode%>");
		_data.add("note",$('#note').val());
		_data.add("user_id",$('#user_id').val());
		_data.add("phone",$('#activePhone').val());
		_data.add("method","unbindCA");
		core.ajax.sendPacket(getdataPacket);
		getdataPacket = null;
	}
	function doProcess(getdataPacket) {
		var _data = getdataPacket.data;
		var retCode = _data.findValueByName("retcode");
		var retMsg = _data.findValueByName("retmsg");
		if(retCode == "000000"){
			rdShowMessageDialog("操作成功！");
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
<table cellspacing="0">
	<tr>
			<td class="blue">移动客户名称 </td>
      <td>
          <input type="text" name="user_name" id="user_name" size="20" maxlength="20" class="InputGrey" readonly />
      </td>
      <td class="blue">手机号码 </td>
      <td>
      		<input type="text" maxlength="11" name="activePhone" id="activePhone" value="<%=activePhone%>" class="InputGrey" readonly />
      </td>
  </tr>
  
  <tr>
      <td class="blue">证件类型 </td>
      <td>
          <input type="text" name="icc_type" id="icc_type" class="InputGrey" readonly />
      </td>
      <td class="blue">身份证号码 </td>
      <td>
          <input type="text" name="iccid" id="iccid" class="InputGrey"  readonly />
      </td>
   </tr>     
   <tr>    
      <td class="blue">智能卡号 </td>
      <td>
          <input type="text" name="bind_card_id" id="card_id" class="InputGrey" readonly />
      </td>
  
      <td class="blue">广电用户编号 </td>
      <td>
          <input type="text" name="bind_user_id" id="user_id" class="InputGrey" readonly />
      </td> 
   </tr>
   <tr> 
     <td class="blue">客户地址 </td>
      <td colspan="3">
          <input type="text" name="addr" id="addr" class="InputGrey" readonly />
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
          <input class="b_foot" name="unbind"  id="unbind"  type=button value="解绑定"  onclick="unbindCA();" />
          <input class="b_foot" name="close"  onClick="removeCurrentTab();" type=button value="关闭" />
      </td>
  </tr>
</table>
<%@ include file="/npage/include/footer_simple.jsp" %> 
</form>
</body>
</html>

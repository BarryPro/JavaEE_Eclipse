<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<head>
	<title>签约号码登记</title>
	<%
		String opCode = "e156";
		String opName = "签约号码登记";
		String workNo = (String)session.getAttribute("workNo");
		String regionCode= (String)session.getAttribute("regCode");
		
		%>
		<script language="javascript">
				function save1(){
			if(!check(document.frm)){
				return false;
			}	
			var phoneNo = $("#phoneNo").val();
			var iAgentPhone = $("#iAgentPhone").val();
			var getdataPacket = new AJAXPacket("fe156_save.jsp","正在保存，请稍候......");
			getdataPacket.data.add("phoneNo",phoneNo);
			getdataPacket.data.add("OpCode","<%=opCode%>");
			getdataPacket.data.add("iAgentPhone",iAgentPhone);
			core.ajax.sendPacket(getdataPacket);
			getdataPacket = null;
		}
			function doProcess(packet){
			var retCode = packet.data.findValueByName("retcode");
			var retMsg = packet.data.findValueByName("retmsg");
			if(retCode == "000000"){
        rdShowMessageDialog("保存成功",2);        
        initPage();
			}else{
				rdShowMessageDialog("错误代码：" + retCode + "，错误信息：" + retMsg,0);
				return false;
			}
		}
					function initPage(){
			$("#phoneNo").text("");
      $("#iAgentPhone").text("");
		}
		</script>
	</head>
<body>
		<form name="frm" method="POST" action="">
	<%@ include file="/npage/include/header.jsp" %>
		<div class="title">
		<div id="title_zi">签约号码登记</div>
	</div>
	<table cellspacing="0">
	
		<tr id="showMsg">
			<td class="blue" width="25%">签约号码</td>
			<td>
							<input type="text" id="phoneNo" name="phoneNo"  v_must="1" 
						v_type="mobphone" maxlength="11" onblur="checkElement(this)" readOnly  Class="InputGrey" value ="<%=activePhone%>"/>
			<font class="orange">*</font>
	</td>
		</tr>
			<tr>
			<td class="blue" width="25%">渠道业主号码</td>
			<td>
				<input type="text" id="iAgentPhone" name="iAgentPhone"   
						v_type="mobphone" maxlength="11" onblur="checkElement(this)" />
			</td>
		</tr>
			
	</table>
	<table cellspacing="0">
		<tr>
			<td noWrap id="footer">
			<div align="center">
				<input type="reset" name="query" class="b_foot" value="保存" onclick="save1()" />
				&nbsp;
				<input type="button" name="close" class="b_foot" value="关闭" onClick="removeCurrentTab();">
			</div>
			</td>
		</tr>
	</table>
		<%@ include file="/npage/include/footer.jsp" %>
</form>
</body>
</html>
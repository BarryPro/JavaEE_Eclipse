<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%
/********************
version v1.0
开发商: si-tech
ningtn 2012-8-6 11:28:41
********************/
%>
<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%
		response.setHeader("Pragma","No-Cache"); 
		response.setHeader("Cache-Control","No-Cache");
		response.setDateHeader("Expires", 0); 
    
 		String opCode = "e977";
 		String opName = "临时解除身份证入网号码数量限制";
 		
 		String regionCode= (String)session.getAttribute("regCode");
                      
%>

<html>
<head>
	<title>临时解除身份证入网号码数量限制</title>
	<script language="javascript">
		function feifa1(textName){
			if(textName.value != ""){
				if((textName.value.indexOf("~")) != -1 || (textName.value.indexOf("|")) != -1 || (textName.value.indexOf(";")) != -1){
					rdShowMessageDialog("不允许输入非法字符，请重新输入！");
					textName.value = "";
					textName.focus();
					return;
				}
			}
		}
		function doCfm(subButton){
			if(!check(document.form1)){
				return false;
			}
			var openType = $.trim($("select[name='openType']").find("option:selected").val());
			var custName = $.trim($("#custName").val());
		 
			
			/* 按钮延迟 */
			controlButt(subButton);
			/* 事后提醒 */
			getAfterPrompt();
			var idTypeVal = $("#idType").val();
			var idIccidVal = $("#idIccid").val();
			var openNumVal = $("#openNum").val();
			var getdataPacket = new AJAXPacket("fe977Cfm.jsp","正在获得数据，请稍候......");
			getdataPacket.data.add("idType",idTypeVal);
			getdataPacket.data.add("idIccid",idIccidVal);
			getdataPacket.data.add("openNum",openNumVal);
			
			getdataPacket.data.add("openType",openType);
			getdataPacket.data.add("custName",custName);
			
			core.ajax.sendPacket(getdataPacket,doCfmBack);
			getdataPacket = null;
		}
		function doCfmBack(packet){
			retCode = packet.data.findValueByName("retcode");
			retMsg = packet.data.findValueByName("retmsg");
			if(retCode == "000000"){
				rdShowMessageDialog("操作成功","2");
			}else{
				rdShowMessageDialog(retCode+":"+retMsg,"0");
			}
			window.location.href="/npage/se977/fe977Main.jsp";
		}
		
	</script>
</head>
<body>
<form action="" method="post" name="form1">
	<%@ include file="/npage/include/header.jsp" %>
	<div class="title">
		<div id="title_zi">临时解除身份证入网号码数量限制</div>
	</div>
	<table>
		<tr>
			<td class="blue">证件类型</td>
			<td>
				<select name="idType" id="idType">
					<wtc:qoption name="sPubSelect" outnum="2">
					<wtc:sql>
							select trim(ID_TYPE), ID_NAME from sIdType a where  a.id_type   in ('8','9','A','B','C') order by id_type					
					</wtc:sql>
					</wtc:qoption>
				</select>
			</td>
			<td class="blue">证件号码</td>
			<td>
				<input type="text" name="idIccid" id="idIccid" maxlength="20"
					onBlur="feifa1(this);" v_must="1" />
				<font class="orange">*</font>
			</td>
		</tr>
		<tr>
			<td class="blue">开户类型</td>
			<td>
				<select name="openType" id="openType"   >
					<option value="0">宽带开户</option>
					<option value="1">手机号码开户</option>
				</select>
			</td>
			<td class="blue">&nbsp;</td>
			<td>
				<span id="sp_show_custname2">
					&nbsp;
				<input type="hidden" name="custName" id="custName"  />
				</span>
			</td>
		</tr>
		<tr>
			<td class="blue">申请开户个数</td>
			<td colspan="3">
				<input type="text" name="openNum" id="openNum" 
					size="8" readonly="readOnly" value="1" class="InputGrey"/>
			</td>
		</tr>
	</table>
	<table>
		<tr > 
			<td id="footer">
			<input name="confirm" type="button" class="b_foot" value="确定" onClick="doCfm(this)" />
			&nbsp; 
			<input name="reset" type="reset" class="b_foot" value="清除" />
			&nbsp; 
			<input name="back" onClick="removeCurrentTab();" type="button" class="b_foot" value="关闭" />
			</td>
		</tr>
	</table>
	<!-- 隐藏表单部分，为下一页面传参用 -->
	<input type="hidden" name="opCode" id="opCode" />
	<input type="hidden" name="opName" id="opName" />
	
	<%@ include file="/npage/include/footer.jsp" %> 
</form>
</body>
</html>

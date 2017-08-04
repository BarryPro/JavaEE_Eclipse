<%
  /*
   * 功能:双跨融合V网成员套餐受理@查询界面
   * 版本: 1.0
   * 日期: 2013/11/21 16:11:37
   * 作者: gaopeng
   * 版权: si-tech
  */
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%
		response.setHeader("Pragma","No-Cache"); 
		response.setHeader("Cache-Control","No-Cache");
		response.setDateHeader("Expires", 0); 
		
		String loginAccept = (String)request.getParameter("loginAccept");
		String iChnSource = (String)request.getParameter("iChnSource");
		String iOpCode = (String)request.getParameter("iOpCode");
		String iOpName = (String)request.getParameter("iOpName");
		String workNo = (String)request.getParameter("iLoginNo");
		String noPassWord = (String)request.getParameter("iLoginPwd");
		String iPhoneNo = (String)request.getParameter("iPhoneNo");
		String iUserPwd = (String)request.getParameter("iUserPwd");
		String iKdNo = (String)request.getParameter("iKdNo");
		
		
		
		String opCode = iOpCode;
		String opName = iOpName;
		 
%>

	

<html>
<head>
	<title></title>
	<script language="javascript">
		$(document).ready(function(){
			
		});
		
				/*2015/04/15 10:40:56 gaopeng 关于在CRM增加手机积分兑换宽带产品功能的需求 是否使用积分的显隐方法*/
		function ifUseIntegralBtn(){
			var ifUseIntegral = $("#ifUseIntegral").attr("checked");
			if(ifUseIntegral == true){
				$("#IntegralFiled").show();
				
			}else{
				$("#IntegralFiled").hide();
			}
		}
		
		/*2015/04/15 10:40:56 gaopeng 关于在CRM增加手机积分兑换宽带产品功能的需求 获取当前可用积分的方法*/
		function getIntegral(){
			
			var ifUseIntegral = $("input[name='ifUseIntegral']").attr("checked");
			
			if(ifUseIntegral){
			
				var iPhoneNo = $.trim($("#intePhoneNo").val());
				var iUserPwd = $.trim($("#intePassWord").val());
				
				if(iPhoneNo.length == 0){
					rdShowMessageDialog("请输入手机号码！",1);
					return false;
				}
				if(iUserPwd.length == 0){
					rdShowMessageDialog("请输入服务密码！",1);
					return false;
				}
				
				var getdataPacket = new AJAXPacket("/npage/public/fGetIntegral.jsp","正在获得数据，请稍候......");
				var iLoginAccept = "<%=loginAccept%>";
				var iChnSource = "01";
				var iOpCode = "<%=opCode%>";
				var iLoginNo = "<%=workNo%>";
				var iLoginPwd = "<%=noPassWord%>";
				
				
				getdataPacket.data.add("iLoginAccept",iLoginAccept);
				getdataPacket.data.add("iChnSource",iChnSource);
				getdataPacket.data.add("iOpCode",iOpCode);
				getdataPacket.data.add("iLoginNo",iLoginNo);
				getdataPacket.data.add("iLoginPwd",iLoginPwd);
				getdataPacket.data.add("iPhoneNo",iPhoneNo);
				getdataPacket.data.add("iUserPwd",iUserPwd);
				
				core.ajax.sendPacket(getdataPacket,doRetInte);
				getdataPacket = null;
			}
			
		}
		function doRetInte(packet){
				var retCode = packet.data.findValueByName("retCode");
				var retMsg = packet.data.findValueByName("retMsg");
				var inteCustName = packet.data.findValueByName("custName");
				var inteNumber = packet.data.findValueByName("integralNum");
				var maxIntegralNum = packet.data.findValueByName("maxIntegralNum");
				
				if(retCode == "000000"){
					rdShowMessageDialog("校验成功！",2);
					$("#intePhoneNo").attr("class","InputGrey");
					$("#intePhoneNo").attr("readonly","readonly");
					$("#intePassWord").attr("class","InputGrey");
					$("#intePassWord").attr("readonly","readonly");
					
					$("#inteCustName").val(inteCustName);
					$("#inteCustName").attr("class","InputGrey");
					$("#inteCustName").attr("readonly","readonly");
					$("#inteNumber").val(inteNumber);
					$("#inteNumber").attr("class","InputGrey");
					$("#inteNumber").attr("readonly","readonly");
					$("#maxIntegralNum").val(maxIntegralNum);
					
				}else{
					rdShowMessageDialog("错误代码："+retCode+",错误信息："+retMsg,1);
					
				}
		}
		
		
		
		var globalIngegralFlag = false;
		/*公共方法 校验输入的积分值 必须是100的倍数 100积分抵扣1块钱*/
		function checkIngegralNum(){
			var integralNumObj = $("#inteUseNum")[0];
			if(!checkElement(integralNumObj)){
				return false;
			}
			var integralNum = $.trim(integralNumObj.value);
			if(integralNum.length == 0){
				rdShowMessageDialog("请输入的积分值！",1);
				integralNumObj.value = "";
				
				return false;
			}
			if((Number(integralNum) % 100) != 0){
				rdShowMessageDialog("输入的积分值必须是100的倍数！",1);
				integralNumObj.value = "";
				
				return false;
			}
			/*抵扣的金额*/
			var integralMoney = Number(Number(integralNum) / 100);
			var maxIntegralNum = Number($.trim($("#maxIntegralNum").val()));
			if(integralMoney > maxIntegralNum){
				rdShowMessageDialog("抵扣金额不能超过最大金额！",1);
				integralNumObj.value = "";
				
				return false;
			}
			$("#intePrice").val(integralMoney);
			$("#intePrice").attr("class","InputGrey");
			$("#intePrice").attr("readonly","readonly");
			globalIngegralFlag = true;
			
		}
		var confirmFlag= false;

		/*赋值给父页面*/
		function giveOpenerVal(){
			
			var intePhoneNo = "";
			var intePassWord = "";
			var inteCustName = "";
			var inteNumber = "";
			var inteUseNum = "";
			var intePrice = "";
			var retVal = "";
			
			/*是否使用积分标识*/
			var ifUseIntegral = $("input[name='ifUseIntegral']").attr("checked");
			if(ifUseIntegral){
				if(!globalIngegralFlag){
					 rdShowMessageDialog("请先校验服务密码，并输入抵扣积分！",0);
			     return false;
				}
				/*这里进行返回父页面显示值*/
				intePhoneNo = $.trim($("#intePhoneNo").val());
				intePassWord = $.trim($("#intePassWord").val());
				inteCustName = $.trim($("#inteCustName").val());
				inteNumber = $.trim($("#inteNumber").val());
				inteUseNum = $.trim($("#inteUseNum").val());
				intePrice = $.trim($("#intePrice").val());
				
				/*父页面返回值*/
				retVal = ifUseIntegral+"|"+intePhoneNo+"|"+intePassWord+"|"+inteCustName+"|"+inteNumber+"|"+inteUseNum+"|"+intePrice;
				
			}else{
				
				retVal = "false"+"|"+"a"+"|"+"b"+"|"+"c"+"|"+"d"+"|"+"e"+"|"+"f";
			}
			
			confirmFlag = true;
			
			window.returnValue = retVal;
			window.close();
			
		}
		function myClose(){
			if(!confirmFlag){
				window.returnValue = "false"+"|"+"a"+"|"+"b"+"|"+"c"+"|"+"d"+"|"+"e"+"|"+"f";
				window.close();
			}
		}
	</script>
	</head>
<body onbeforeunload = "myClose();">
	<form action="" method="post" name="form_i146Qry" id="form_i146Qry">
	<%@ include file="/npage/include/header.jsp" %>
	<div>
		<div>
	<table >
		<tr>
		<td  class="blue" width="20%">是否使用积分</td>
		<td colspan="5">
			<input type="checkbox" name="ifUseIntegral" id="ifUseIntegral" value="" onclick="ifUseIntegralBtn();"/>
		</td>	
		</tr>
		<tbody id="IntegralFiled" style="display:none">
		<tr >
			<td  class="blue">手机号码</td>
			<td ><input type="text" name="intePhoneNo" id="intePhoneNo" value=""/><font class="orange">*</font></td>	
			<td  class="blue">服务密码</td>
			<td >
				<input type="password" name="intePassWord" id="intePassWord" value=""/><font class="orange">*</font>
				<input type="button" class="b_text" name="inteValide" id="inteValide" value="校验" onclick="getIntegral();"/>
			</td>
			<td  class="blue">客户名称</td>
			<td ><input type="text" name="inteCustName" id="inteCustName" value="" class="InputGrey" readonly/></td>
		</tr>
		<tr >
			<td class="blue">当前可用积分</td>
			<td><input type="text" name="inteNumber" id="inteNumber" value="" class="InputGrey" readonly/></td>	
			<td class="blue">积分值</td>
			<td><input type="text" name="inteUseNum" id="inteUseNum" v_type="0_9" onblur="checkIngegralNum();" value=""/><font class="orange">*</font></td>
			<td class="blue">抵扣金额</td>
			<td><input type="text" name="intePrice" id="intePrice" value="" class="InputGrey" readonly/></td>
			<!--隐藏域 存储最大抵扣金额 -->
			<input type="hidden" name="maxIntegralNum" id="maxIntegralNum" value="" />
		</tr>
		</tbody>
	</table>
		<div>
	<table cellSpacing=0>
					<tr>
						<td id="footer">
							<input  name="submitr"  class="b_foot" type="button" value="确认" onclick="giveOpenerVal()" id="Button1">&nbsp;&nbsp;
							<input  name="back1"  class="b_foot" type="button" value=关闭 id="Button2" onclick="window.returnValue='false|a|b|c|d|e|f';window.close();">
						</td>
					</tr>
	</table>
</div>
	<%@ include file="/npage/include/footer.jsp" %>
</form>
</body>

</html>

<%
  /*
   * ����:˫���ں�V����Ա�ײ�����@��ѯ����
   * �汾: 1.0
   * ����: 2013/11/21 16:11:37
   * ����: gaopeng
   * ��Ȩ: si-tech
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
		
				/*2015/04/15 10:40:56 gaopeng ������CRM�����ֻ����ֶһ������Ʒ���ܵ����� �Ƿ�ʹ�û��ֵ���������*/
		function ifUseIntegralBtn(){
			var ifUseIntegral = $("#ifUseIntegral").attr("checked");
			if(ifUseIntegral == true){
				$("#IntegralFiled").show();
				
			}else{
				$("#IntegralFiled").hide();
			}
		}
		
		/*2015/04/15 10:40:56 gaopeng ������CRM�����ֻ����ֶһ������Ʒ���ܵ����� ��ȡ��ǰ���û��ֵķ���*/
		function getIntegral(){
			
			var ifUseIntegral = $("input[name='ifUseIntegral']").attr("checked");
			
			if(ifUseIntegral){
			
				var iPhoneNo = $.trim($("#intePhoneNo").val());
				var iUserPwd = $.trim($("#intePassWord").val());
				
				if(iPhoneNo.length == 0){
					rdShowMessageDialog("�������ֻ����룡",1);
					return false;
				}
				if(iUserPwd.length == 0){
					rdShowMessageDialog("������������룡",1);
					return false;
				}
				
				var getdataPacket = new AJAXPacket("/npage/public/fGetIntegral.jsp","���ڻ�����ݣ����Ժ�......");
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
					rdShowMessageDialog("У��ɹ���",2);
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
					rdShowMessageDialog("������룺"+retCode+",������Ϣ��"+retMsg,1);
					
				}
		}
		
		
		
		var globalIngegralFlag = false;
		/*�������� У������Ļ���ֵ ������100�ı��� 100���ֵֿ�1��Ǯ*/
		function checkIngegralNum(){
			var integralNumObj = $("#inteUseNum")[0];
			if(!checkElement(integralNumObj)){
				return false;
			}
			var integralNum = $.trim(integralNumObj.value);
			if(integralNum.length == 0){
				rdShowMessageDialog("������Ļ���ֵ��",1);
				integralNumObj.value = "";
				
				return false;
			}
			if((Number(integralNum) % 100) != 0){
				rdShowMessageDialog("����Ļ���ֵ������100�ı�����",1);
				integralNumObj.value = "";
				
				return false;
			}
			/*�ֿ۵Ľ��*/
			var integralMoney = Number(Number(integralNum) / 100);
			var maxIntegralNum = Number($.trim($("#maxIntegralNum").val()));
			if(integralMoney > maxIntegralNum){
				rdShowMessageDialog("�ֿ۽��ܳ�������",1);
				integralNumObj.value = "";
				
				return false;
			}
			$("#intePrice").val(integralMoney);
			$("#intePrice").attr("class","InputGrey");
			$("#intePrice").attr("readonly","readonly");
			globalIngegralFlag = true;
			
		}
		var confirmFlag= false;

		/*��ֵ����ҳ��*/
		function giveOpenerVal(){
			
			var intePhoneNo = "";
			var intePassWord = "";
			var inteCustName = "";
			var inteNumber = "";
			var inteUseNum = "";
			var intePrice = "";
			var retVal = "";
			
			/*�Ƿ�ʹ�û��ֱ�ʶ*/
			var ifUseIntegral = $("input[name='ifUseIntegral']").attr("checked");
			if(ifUseIntegral){
				if(!globalIngegralFlag){
					 rdShowMessageDialog("����У��������룬������ֿۻ��֣�",0);
			     return false;
				}
				/*������з��ظ�ҳ����ʾֵ*/
				intePhoneNo = $.trim($("#intePhoneNo").val());
				intePassWord = $.trim($("#intePassWord").val());
				inteCustName = $.trim($("#inteCustName").val());
				inteNumber = $.trim($("#inteNumber").val());
				inteUseNum = $.trim($("#inteUseNum").val());
				intePrice = $.trim($("#intePrice").val());
				
				/*��ҳ�淵��ֵ*/
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
		<td  class="blue" width="20%">�Ƿ�ʹ�û���</td>
		<td colspan="5">
			<input type="checkbox" name="ifUseIntegral" id="ifUseIntegral" value="" onclick="ifUseIntegralBtn();"/>
		</td>	
		</tr>
		<tbody id="IntegralFiled" style="display:none">
		<tr >
			<td  class="blue">�ֻ�����</td>
			<td ><input type="text" name="intePhoneNo" id="intePhoneNo" value=""/><font class="orange">*</font></td>	
			<td  class="blue">��������</td>
			<td >
				<input type="password" name="intePassWord" id="intePassWord" value=""/><font class="orange">*</font>
				<input type="button" class="b_text" name="inteValide" id="inteValide" value="У��" onclick="getIntegral();"/>
			</td>
			<td  class="blue">�ͻ�����</td>
			<td ><input type="text" name="inteCustName" id="inteCustName" value="" class="InputGrey" readonly/></td>
		</tr>
		<tr >
			<td class="blue">��ǰ���û���</td>
			<td><input type="text" name="inteNumber" id="inteNumber" value="" class="InputGrey" readonly/></td>	
			<td class="blue">����ֵ</td>
			<td><input type="text" name="inteUseNum" id="inteUseNum" v_type="0_9" onblur="checkIngegralNum();" value=""/><font class="orange">*</font></td>
			<td class="blue">�ֿ۽��</td>
			<td><input type="text" name="intePrice" id="intePrice" value="" class="InputGrey" readonly/></td>
			<!--������ �洢���ֿ۽�� -->
			<input type="hidden" name="maxIntegralNum" id="maxIntegralNum" value="" />
		</tr>
		</tbody>
	</table>
		<div>
	<table cellSpacing=0>
					<tr>
						<td id="footer">
							<input  name="submitr"  class="b_foot" type="button" value="ȷ��" onclick="giveOpenerVal()" id="Button1">&nbsp;&nbsp;
							<input  name="back1"  class="b_foot" type="button" value=�ر� id="Button2" onclick="window.returnValue='false|a|b|c|d|e|f';window.close();">
						</td>
					</tr>
	</table>
</div>
	<%@ include file="/npage/include/footer.jsp" %>
</form>
</body>

</html>

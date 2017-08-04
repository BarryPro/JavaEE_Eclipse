<%
  /*
   * 功能:双跨融合V网成员套餐受理
   * 版本: 1.0
   * 日期: 2013/11/21 16:11:37
   * 作者: gaopeng
   * 版权: si-tech
  */
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ include file="/npage/bill/getMaxAccept.jsp" %>
<%
		response.setHeader("Pragma","No-Cache"); 
		response.setHeader("Cache-Control","No-Cache");
		response.setDateHeader("Expires", 0); 
    String regionCode = (String)session.getAttribute("regCode");
    String loginNo = (String)session.getAttribute("workNo");
 		String noPass = (String)session.getAttribute("password");
 		String groupID = (String)session.getAttribute("groupId");
 		String opCode = (String)request.getParameter("opCode");
		String opName = (String)request.getParameter("opName");
		String phoneNo = (String)request.getParameter("activePhone");
		
 		String loginAccept = getMaxAccept();
	
%>

<html>
<head>
	<title><%=opName%></title>
	<script language="javascript" type="text/javascript" src="/npage/public/knockout-2.0.0.js" ></script>
	<script language="javascript">
		/*查询集团信息flag*/
		var qryFlag = false;
		/*校验手机号码flag*/
		var checkUnitPhoneFlag = false;
		$(document).ready(function(){
			
		});
		
		/*window.open展示集团编码、集团名称和订购关系编码*/
		function sSKUnitQryFunc(){
			
			/*集团编码*/
			var unitCode = $("input[name='unitCode']").val();
			unitCode = $.trim(unitCode);
			/*产品订购关系编码*/
			var productCode = $("input[name='productCode']").val();
			productCode = $.trim(productCode);
			
			if(unitCode.length == 0  &&  productCode.length == 0){
				
				rdShowMessageDialog("集团编码、产品订购关系编码至少需要输入一项！",1);
				return false;
				
			}
			
			/*拼接入参*/
			var path = "/npage/si146/fUnitQry.jsp";
		  path += "?iLoginAccept=<%=loginAccept%>";
		  path += "&iChnSource=01";
		  path += "&iOpCode=<%=opCode%>";
		  path += "&iOpName=<%=opName%>";
		  path += "&iLoginNo=<%=loginNo%>";
		  path += "&iLoginPwd=<%=noPass%>";
		  path += "&iPhoneNo=";
		  path += "&iUserPwd=";
		  path += "&iRegionCode=<%=regionCode%>";
		  path += "&iUnitId="+unitCode;
		  path += "&iProductId="+productCode;
		  /*打开*/
		  //alert(path);
		  window.open(path,"newwindow","height=450, width=800,top=50,left=200,scrollbars=yes, resizable=no,location=no, status=yes");
			
		}
		
		//下一步方法
		function nextStep()
		{
			if(!qryFlag){
				rdShowMessageDialog("请选择集团信息！",1);
				return false;
			}
			if(qryFlag){
				/*置灰与置无效*/
				$("input[name='unitCode']").attr("readonly","readonly");
				$("input[name='productCode']").attr("readonly","readonly");
				$("#submitr").attr("disabled","disabled");
				$("input[name='qryBtn']").attr("disabled","disabled");
				/*展示手机号码校验功能*/
				$("#nextArea").show();
				
			}
		}
		/*校验手机号码方法，校验成功后直接返回列表*/
		function checkUnitPhone(){
			
			if(!checkElement(document.all.unitPhoneNo)){
				return false;
			}
			
			var getdataPacket = new AJAXPacket("/npage/si146/fUnitPhoneCheck.jsp","正在获得数据，请稍候......");
			
			var iLoginAccept = "<%=loginAccept%>";
			var iChnSource = "01";
			var iOpCode = "<%=opCode%>";
			var iLoginNo = "<%=loginNo%>";
			var iLoginPwd = "<%=noPass%>";
			var iPhoneNo = $.trim($("input[name='unitPhoneNo']").val());
			var iUserPwd = "";
			var iProductId = $("input[name='productCode']").val();
			var iOprType = $("input[name='opFlag'][checked]").val();
			
			getdataPacket.data.add("iLoginAccept",iLoginAccept);
			getdataPacket.data.add("iChnSource",iChnSource);
			getdataPacket.data.add("iOpCode",iOpCode);
			getdataPacket.data.add("iLoginNo",iLoginNo);
			getdataPacket.data.add("iLoginPwd",iLoginPwd);
			getdataPacket.data.add("iPhoneNo",iPhoneNo);
			getdataPacket.data.add("iUserPwd",iUserPwd);
			getdataPacket.data.add("iProductId",iProductId);
			getdataPacket.data.add("iOprType",iOprType);
			
			core.ajax.sendPacket(getdataPacket);
			getdataPacket = null;
				
		}
		function doProcess(packet){
		
			var retCode = packet.data.findValueByName("retCode");
			var retMsg = packet.data.findValueByName("retMsg");
			var oOfferIdNow = packet.data.findValueByName("oOfferIdNow");
			var oOfferNameNow = packet.data.findValueByName("oOfferNameNow");
			$("input[name='oOfferIdNow']").val(oOfferIdNow);
			var retArray = packet.data.findValueByName("retArray");
			if(retCode == "000000"){
				/*获取当前选择的操作类型，如果不是删除，则展示要删除的资费*/
				var opType =  $("input[name='opFlag'][checked]").val();
				
				
				rdShowMessageDialog("校验成功！",2);
				checkUnitPhoneFlag = true;
				
				/*拼接option*/
				var selHead = "<select name='offerId' style='width:250px'>";
				var optionDefault = "<option value='&&'>--请选择--</option>";
				var selFoot = "</select>";
				/*如果为修改时或者删除时，把当前生效的选中*/
				if(opType == "2" || opType == "3"){
					optionDefault += "<option value='"+oOfferIdNow+"' selected>"+oOfferIdNow+"-->"+oOfferNameNow+"</option>";
				}
				for(var i=0;i<retArray.length;i++){
						optionDefault += "<option value='"+retArray[i][0]+"'>"+retArray[i][0]+"-->"+retArray[i][1]+"</option>";
				}
				var markDiv=$("#tdappendSome"); 
				//清空原有表格
				markDiv.empty();
				markDiv.append(selHead+optionDefault+selFoot);
				/*删除时，可选下拉列表无效即不可选择*/
				if(opType == "3"){
					$("select[name='offerId']").attr("disabled","disabled");
				}
				
				$("input[name='opFlag']").each(function(){
					$(this).attr("disabled","disabled");
				});
				$("input[name='unitPhoneNo']").attr("readonly","readonly");
				$("#subBtn").attr("disabled","");
				
			}else{
				rdShowMessageDialog("错误代码："+retCode+",错误信息："+retMsg,1);
				checkUnitPhoneFlag = false;
				$("input[name='opFlag']").each(function(){
					$(this).attr("disabled","");
				});
				$("input[name='unitPhoneNo']").attr("readonly","");
				$("#subBtn").attr("disabled","");
				return false;
			}
			
		}
		/*确认服务方法*/
		function doSubmitBtn(){
			if(!checkUnitPhoneFlag){
				rdShowMessageDialog("请先校验手机号码！",1);
				return false;
			}
			var selVal = $("select[name='offerId']").find("option:selected").val();
			if(selVal == "&&"){
				rdShowMessageDialog("请选择资费！",1);
				return false;
			}
				var getdataPacket = new AJAXPacket("/npage/si146/fi146Cfm.jsp","正在获得数据，请稍候......");
			
			var iLoginAccept = "<%=loginAccept%>";
			var iChnSource = "01";
			var iOpCode = "<%=opCode%>";
			var iLoginNo = "<%=loginNo%>";
			var iLoginPwd = "<%=noPass%>";
			var iPhoneNo = $.trim($("input[name='unitPhoneNo']").val());
			var iUserPwd = "";
			var iProductId = $("input[name='productCode']").val();
			var iOprType = $("input[name='opFlag'][checked]").val();
			var iOfferId = $("select[name='offerId']").find("option:selected").val();
			
			getdataPacket.data.add("iLoginAccept",iLoginAccept);
			getdataPacket.data.add("iChnSource",iChnSource);
			getdataPacket.data.add("iOpCode",iOpCode);
			getdataPacket.data.add("iLoginNo",iLoginNo);
			getdataPacket.data.add("iLoginPwd",iLoginPwd);
			getdataPacket.data.add("iPhoneNo",iPhoneNo);
			getdataPacket.data.add("iUserPwd",iUserPwd);
			getdataPacket.data.add("iProductId",iProductId);
			getdataPacket.data.add("iOprType",iOprType);
			if(iOprType == "1" || iOprType == "3"){
				getdataPacket.data.add("iOfferId",iOfferId);
				getdataPacket.data.add("iOfferIdNew","");
			}else if(iOprType == "2"){
				getdataPacket.data.add("iOfferId",$("input[name='oOfferIdNow']").val());
				getdataPacket.data.add("iOfferIdNew",iOfferId);
			}
			core.ajax.sendPacket(getdataPacket,retConf);
			getdataPacket = null;
			
		}
	function retConf(packet){
		var retCode = packet.data.findValueByName("retCode");
		var retMsg = packet.data.findValueByName("retMsg");
		if(retCode == "000000"){
			rdShowMessageDialog("双跨融合V网成员套餐受理成功！",2);
			window.location.href = "/npage/si146/fi146Main.jsp?opCode=<%=opCode%>&opName=<%=opName%>";
		}else{
			rdShowMessageDialog("错误代码："+retCode+",错误信息："+retMsg,1);
			window.location.href = "/npage/si146/fi146Main.jsp?opCode=<%=opCode%>&opName=<%=opName%>";
		}
	}
		
	</script>
	</head>
<body>
	<form action="" method="post" name="form_i146" id="form_i146">
	<%@ include file="/npage/include/header.jsp" %>
	<div class="title">
		<div id="title_zi"><%=opName%></div>
	</div>
	<div>
	<table >
		<tr>
			<td width="20%" class="blue">操作类型</td>
			<td width="80%" colspan="3">
				<input type="radio" name="opFlag" value="1" checked/>订购&nbsp;&nbsp;&nbsp;
				<input type="radio" name="opFlag" value="2" />修改&nbsp;&nbsp;&nbsp;
				<input type="radio" name="opFlag" value="3" />删除
			</td>
		</tr>
		<tr>
			<td width="20%" class="blue">集团编码</td>
			<td width="30%">
				<input type="text" id="unitCode" name="unitCode" value=""/>
				&nbsp;&nbsp
				<input type="button" class="b_text" name="qryBtn" onclick = "sSKUnitQryFunc();" value="查询"/>
			</td>
			<td width="20%" class="blue">产品订购关系编码</td>
			<td width="30%">
				<input type="text" id="productCode" name="productCode" value=""/>
			</td>
		</tr>
		
	
	</table>
	
	
	<table cellSpacing=0>
					<tr>
						<td id="footer">
							<input  name="submitr"  class="b_foot" type="button" value="下一步" onclick="nextStep()" id="submitr" disabled="disabled">&nbsp;&nbsp;
							<input  name="resetsd"  class="b_foot" type="button" value="重置" onclick="window.location.href = '/npage/si146/fi146Main.jsp?opCode=<%=opCode%>&opName=<%=opName%>';" id="Button3">&nbsp;&nbsp;
							<input  name="back1"  class="b_foot" type="button" value=关闭 id="Button2" onclick="removeCurrentTab()">
						</td>
					</tr>
	</table>
</div>
<div id = "nextArea" style="display:none;">
		<div class="title">
			<div id="title_zi">手机号码校验</div>
		</div>
		
		<table>
			<tr>
				<td width="20%" class="blue">手机号码</td>
				<td width="30%">
					<input type="text" name="unitPhoneNo" value="" v_must = "1"  v_type = "phone" maxlength="11"/>&nbsp;&nbsp;<input type="button" class="b_text" name="checkUnitPoneBtn" value="校验" onclick="checkUnitPhone();"/>
				</td>
				<td width="20%" class="blue">可选资费</td>
				<td id="tdappendSome" width="30%" >
					<select name="offerId" style='width:150px'>
						<option value="&&">--请选择--</option>	
					</select>
				</td>
			</tr>
		</table>
		<table cellSpacing=0>
					<tr>
						<td id="footer">
							<input  name="subBtn"  class="b_foot" type="button" value="确认" onclick="doSubmitBtn()" id="subBtn" disabled="disabled">&nbsp;&nbsp;
						</td>
					</tr>
		</table>
		<!-- 当前有效的offerId -->
		<input type="hidden" name="oOfferIdNow" value=""/>
</div>

	<%@ include file="/npage/include/footer.jsp" %>
</form>
</body>

</html>

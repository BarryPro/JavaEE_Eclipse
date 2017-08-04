<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/se112/public_title_name.jsp"%>
<%@ include file="/npage/se112/footer.jsp"%>
<%@page import="com.sitech.crmpd.core.bean.MapBean"%>
<%@page import="java.util.*"%>
<%@page import="com.sitech.crmpd.core.util.SiUtil"%>
<%
	String phoneNo = request.getParameter("phoneNo");
	String imeiCode = request.getParameter("imeiCode");
	String loginNo = (String)session.getAttribute("workNo"); 
	String password = (String)session.getAttribute("password"); 
	String group_id = (String)session.getAttribute("groupId");
	System.out.println("**********************workNo*************" + loginNo);
 %>	

<html>
	<head>
	<title></title>
	</head>
	<body>
		<div id="operation">
		<form method="post" name="frm4938" action="">
				<div id="operation_table">
					 <div class="title">
						<div class="text">
							电子终端选择方式
						</div>
					</div>
					<div class="input">
						<table>
						<tr>
							<th>是否使用</th>
							<td>
								<select id="state" onchange="useResult(this.value)">
									<option value="10">是</option>
									<option value="20">否</option>
								</select>
							</td>
						</tr>
						</table>
						<div id="div_msg" >
							<table>
								<tr>
									<th>增加兑换码</th>
									<td>
										<input type="button" class="b_text" name="verify3" id="verify3" onclick="addRow()" value="增加一条"/>
										<font style="color:red"><b>*</b></font>
									</td>
								</tr>
							</table>
							<table id="resTable">
							  <tr>
								<th>兑换码</th>
								<th>操作</th>
							  </tr>
							</table>
							<table>
								<tr>
									<th>验证兑换码</th>
									<td>
										<input type="button" class="b_text" name="verify" id="verify" onclick="checkImei()" value="验证"/>
										<font style="color:red"><b>*</b>点此验证按钮之前，请完成添加兑换码，验证通过后将不能增加、删除、修改兑换码</font>
										<div id="td1" align="left">
									</td>
								</tr>
							</table>
							<table>
							 <tr>
								<th id="show_mi">短信验证码</th>
								<td>
									<input type="text" name="domCode" value="" id="domCode"  />
									<input type="button" class="b_text" name="verify2" id="verify2"  disabled="disabled"  onclick="chkrMsgCode()" value="验证"/>
									<font style="color:red"><b>*</b></font>
									<div id="td2" align="left">
								</td>
							 </tr>
						    </table>
					  </div>
						
					</div>
					<div id="operation_button">
						 <input type="button" class="b_foot"  disabled="disabled"  value="确定" id="btnSubmit"
							name="btnSubmit" onclick="btnRsSubmit()" />
						<input type="button" class="b_foot" value="关闭" id="btnCancel"
							name="btnCancel" onclick="closeWin()" />
					</div>
				</div>
			</form>
		</div>
	</body>
	<script type="text/javascript">
	
	
	 function addRow() {  //到增加记录页面
        var rowTab = document.getElementById("resTable");
        
        if(rowTab.rows.length >= 11){
			showDialog("兑换码最多添加10个!",0);
		 	return false;	
		}
        
        var tr1 =  rowTab.insertRow();
        tr1.align="center";
        
        var td1 = document.createElement("td");
        	td1.align="center";
            td1.innerHTML= "<input type='text' name = 'card_code'  value='' onkeyup='checkRow(this);'/>";
            
        var td2 = document.createElement("td");
        	td2.align="center";
            td2.innerHTML="<input type='button' name = 'delete_mode'  value='删除' class='b_text' onclick='removeRow(this)' />";
        
        tr1.appendChild(td1);
        tr1.appendChild(td2);
    }
	
	
	function removeRow(obj){
		var tab = obj.parentNode.parentNode.parentNode.parentNode;
		tab.deleteRow(obj.parentNode.parentNode.rowIndex);
	}
	
	function checkRow(obj){
		obj.value=obj.value.replace(/[^\.\d]/g,'');
		if(obj.value.split('.').length>2){
		  obj.value=obj.value.split('.')[0]+'.'+obj.value.split('.')[1];
		}
	}
	
	function useResult(state){
		if(state == "20"){
			document.getElementById("div_msg").style.display="none";
			$("#btnSubmit").attr("disabled",false);
		}
		if(state == "10"){
			document.getElementById("div_msg").style.display="block";
			$("#btnSubmit").attr("disabled",true);
			$("#verify2").attr("disabled",true);
			$("#verify").attr("disabled",false);
			var td1 = document.getElementById("td1");
	 		td1.innerHTML=trim("");
			var td2 = document.getElementById("td2");
	 		td2.innerHTML=trim("");
	 		$("#domCode").val("");
		}
	}
	
	function chkrCard(){
		var stringCodeStr ="";
		var split = "";
		var stringCode = document.getElementsByName("card_code");
		
		if(stringCode.length == 0){
			showDialog("请点击'增加一条'按钮以增加兑换码输入框，再点击'验证'按钮!",0);
		 	return false;	
		}
		
		for(var j =0;j<stringCode.length;j++){
			if(stringCode[j].value == ""){
				showDialog("添加的第"+(j+1)+"个兑换码,不能为空，请填写!",0);
		 		return false;
			}
			stringCodeStr = stringCodeStr + split + stringCode[j].value;
			split = "|";
		}
		
		var sPacket = new AJAXPacket("sm285Check.jsp","请稍候......");
		sPacket.data.add("StringCode",stringCodeStr);
		sPacket.data.add("loginNo","<%=loginNo%>");
		sPacket.data.add("phoneNo","<%=phoneNo%>");
		sPacket.data.add("password","<%=password%>");
		sPacket.data.add("group_id","<%=group_id%>");
		core.ajax.sendPacket(sPacket,doserviceChkrCard);
		sPacket = null;
	}
	
	function doserviceChkrCard(packet){
		var RETURN_CODE = packet.data.findValueByName("RETURN_CODE");
		var RETURN_MSG = packet.data.findValueByName("RETURN_MSG");
		
		var oRanPassFlag = packet.data.findValueByName("oRanPassFlag");
		var oEffFlag = packet.data.findValueByName("oEffFlag");
		var oConvertMoney = packet.data.findValueByName("oConvertMoney");
		var oErrStringCode = packet.data.findValueByName("oErrStringCode");
		var oErrMsg = packet.data.findValueByName("oErrMsg");
		if(trim(RETURN_CODE)=="000000"&&"Y"==oEffFlag&&"N"==oRanPassFlag){
			var td1 = document.getElementById("td1");
	 		td1.innerHTML=trim("兑换金额："+oConvertMoney/100+"元");
	 		$("#verify").attr("disabled",true);
	 		$("#verify3").attr("disabled",true);
			$("input[name='delete_mode']").attr("disabled",true); 
			$("input[name='card_code']").attr("readonly",true);
			$("#verify2").attr("disabled",false); 
		}else if(trim(RETURN_CODE)!="000000"){
			var td1 = document.getElementById("td1");
	 		td1.innerHTML=trim(RETURN_MSG);
		}else{
			var td1 = document.getElementById("td1");
	 		td1.innerHTML=trim(oErrStringCode+"，"+oErrMsg);
		}
	}
	
	function chkrMsgCode(){
		var domCode = $("#domCode").val();
		var sPacket = new AJAXPacket("sPassCheck.jsp","请稍候......");
		sPacket.data.add("domCode",domCode);
		sPacket.data.add("loginNo","<%=loginNo%>");
		sPacket.data.add("phoneNo","<%=phoneNo%>");
		sPacket.data.add("password","<%=password%>");
		core.ajax.sendPacket(sPacket,doserviceChkrMsgCode);
		sPacket = null;
		
	}
	function doserviceChkrMsgCode(packet){
		var RETURN_CODE = packet.data.findValueByName("RETURN_CODE");
		var RETURN_MSG = packet.data.findValueByName("RETURN_MSG");
		if(trim(RETURN_CODE)=="000000"){
			var td2 = document.getElementById("td2");
	 		td2.innerHTML=trim(RETURN_MSG);
	 		$("#verify2").attr("disabled",true);
	 		$("#btnSubmit").attr("disabled",false);
		}else{
			$("#verify2").attr("disabled",false);
			var td2 = document.getElementById("td2");
	 		td2.innerHTML=trim(RETURN_MSG);
		}
	}
	
	function checkImei(){
		if(""=="<%=imeiCode%>"){
			showDialog("请先进行imei校验！",0);
			return false;
		}
		var sPacket = new AJAXPacket("heBaoResValid.jsp","请稍候......");
		sPacket.data.add("imeiCode","<%=imeiCode%>");
		core.ajax.sendPacket(sPacket,doserviceChkrImei);
		sPacket = null;
	}
	function doserviceChkrImei(packet){
		var RETURN_CODE = packet.data.findValueByName("RETURN_CODE");
		var RETURN_MSG = packet.data.findValueByName("RETURN_MSG");
		if(trim(RETURN_CODE)=="00000111"){
			chkrCard();
		}else{
			showDialog("全网通不允许处理本次业务!",0);
			return false;
		}
	}
	
	function closeWin(){
		closeDivWin();
	}
	
	function btnRsSubmit(){
		//兑换码录入		
		var state = $("#state").val();
		var stringCodeStr ="";
		var split = "";
		if(state == 10){
			var stringCode = document.getElementsByName("card_code");
			for(var j =0;j<stringCode.length;j++){
				stringCodeStr = stringCodeStr + split + stringCode[j].value;
				split = "|";
			}
		}
		parent.saveCardTypeCode(stringCodeStr);	
		parent.cardCode_Checkfuc();
		closeDivWin();
	}
	
	</script>
</html>
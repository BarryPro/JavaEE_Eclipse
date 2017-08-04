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
							�����ն�ѡ��ʽ
						</div>
					</div>
					<div class="input">
						<table>
						<tr>
							<th>�Ƿ�ʹ��</th>
							<td>
								<select id="state" onchange="useResult(this.value)">
									<option value="10">��</option>
									<option value="20">��</option>
								</select>
							</td>
						</tr>
						</table>
						<div id="div_msg" >
							<table>
								<tr>
									<th>���Ӷһ���</th>
									<td>
										<input type="button" class="b_text" name="verify3" id="verify3" onclick="addRow()" value="����һ��"/>
										<font style="color:red"><b>*</b></font>
									</td>
								</tr>
							</table>
							<table id="resTable">
							  <tr>
								<th>�һ���</th>
								<th>����</th>
							  </tr>
							</table>
							<table>
								<tr>
									<th>��֤�һ���</th>
									<td>
										<input type="button" class="b_text" name="verify" id="verify" onclick="checkImei()" value="��֤"/>
										<font style="color:red"><b>*</b>�����֤��ť֮ǰ���������Ӷһ��룬��֤ͨ���󽫲������ӡ�ɾ�����޸Ķһ���</font>
										<div id="td1" align="left">
									</td>
								</tr>
							</table>
							<table>
							 <tr>
								<th id="show_mi">������֤��</th>
								<td>
									<input type="text" name="domCode" value="" id="domCode"  />
									<input type="button" class="b_text" name="verify2" id="verify2"  disabled="disabled"  onclick="chkrMsgCode()" value="��֤"/>
									<font style="color:red"><b>*</b></font>
									<div id="td2" align="left">
								</td>
							 </tr>
						    </table>
					  </div>
						
					</div>
					<div id="operation_button">
						 <input type="button" class="b_foot"  disabled="disabled"  value="ȷ��" id="btnSubmit"
							name="btnSubmit" onclick="btnRsSubmit()" />
						<input type="button" class="b_foot" value="�ر�" id="btnCancel"
							name="btnCancel" onclick="closeWin()" />
					</div>
				</div>
			</form>
		</div>
	</body>
	<script type="text/javascript">
	
	
	 function addRow() {  //�����Ӽ�¼ҳ��
        var rowTab = document.getElementById("resTable");
        
        if(rowTab.rows.length >= 11){
			showDialog("�һ���������10��!",0);
		 	return false;	
		}
        
        var tr1 =  rowTab.insertRow();
        tr1.align="center";
        
        var td1 = document.createElement("td");
        	td1.align="center";
            td1.innerHTML= "<input type='text' name = 'card_code'  value='' onkeyup='checkRow(this);'/>";
            
        var td2 = document.createElement("td");
        	td2.align="center";
            td2.innerHTML="<input type='button' name = 'delete_mode'  value='ɾ��' class='b_text' onclick='removeRow(this)' />";
        
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
			showDialog("����'����һ��'��ť�����Ӷһ���������ٵ��'��֤'��ť!",0);
		 	return false;	
		}
		
		for(var j =0;j<stringCode.length;j++){
			if(stringCode[j].value == ""){
				showDialog("��ӵĵ�"+(j+1)+"���һ���,����Ϊ�գ�����д!",0);
		 		return false;
			}
			stringCodeStr = stringCodeStr + split + stringCode[j].value;
			split = "|";
		}
		
		var sPacket = new AJAXPacket("sm285Check.jsp","���Ժ�......");
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
	 		td1.innerHTML=trim("�һ���"+oConvertMoney/100+"Ԫ");
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
	 		td1.innerHTML=trim(oErrStringCode+"��"+oErrMsg);
		}
	}
	
	function chkrMsgCode(){
		var domCode = $("#domCode").val();
		var sPacket = new AJAXPacket("sPassCheck.jsp","���Ժ�......");
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
			showDialog("���Ƚ���imeiУ�飡",0);
			return false;
		}
		var sPacket = new AJAXPacket("heBaoResValid.jsp","���Ժ�......");
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
			showDialog("ȫ��ͨ����������ҵ��!",0);
			return false;
		}
	}
	
	function closeWin(){
		closeDivWin();
	}
	
	function btnRsSubmit(){
		//�һ���¼��		
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
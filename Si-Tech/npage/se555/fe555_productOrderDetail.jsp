<%
  /*
   * ����: e555��������ת״̬ͬ������
   * �汾: 1.0
   * ����: 20120118
   * ����: wanghfa
   * ��Ȩ: si-tech
  */
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd>
<HTML xmlns="http://www.w3.org/1999/xhtml">
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page contentType="text/html; charset=GBK" %>
<%
	response.setHeader("Pragma","No-Cache");
	response.setHeader("Cache-Control","No-Cache");
	response.setDateHeader("Expires", 0);
	String path = request.getRealPath("/npage/tmp/");

	String opCode = "e555";
	String opName = "������ת״̬ͬ������";
	String workNo = (String)session.getAttribute("workNo");
	String password = (String)session.getAttribute("password");
	String regionCode = (String)session.getAttribute("regCode");
	String businessMode = request.getParameter("businessMode");
	String productId = request.getParameter("productId");
	String opType = request.getParameter("opType");
	String disabledStr = "";
	String inputGreyStr = "";
	String readOnlyStr = "";
	if ("q".equals(opType) || "4".equals(opType) || "5".equals(opType) || "6".equals(opType)) {
		disabledStr = "disabled";
		inputGreyStr = "InputGrey";
		readOnlyStr = "readOnly";
	}
%>
<wtc:service name="sStaProdInfoQry" routerKey="region" 
		routerValue="<%=regionCode%>"  retcode="retCode1" retmsg="retMsg1" outnum="18">
	<wtc:param value="0"/>
	<wtc:param value="01"/>
	<wtc:param value="e555"/>
	<wtc:param value="<%=workNo%>"/>
	<wtc:param value="<%=password%>"/>
	<wtc:param value=""/>
	<wtc:param value=""/>
	<wtc:param value="<%=productId%>"/>
</wtc:service>
<wtc:array id="result1" start="0" length="7" scope="end"/>
<wtc:array id="result2" start="7" length="3" scope="end"/>
<wtc:array id="result3" start="10" length="3" scope="end"/>
<wtc:array id="result4" start="13" length="3" scope="end"/>
<wtc:array id="result5" start="16" length="2" scope="end"/>
<%
if (!"000000".equals(retCode1)) {
	%>
	<script type="text/javascript">
		rdShowMessageDialog("sStaProdInfoQry�����ѯ����<%=retCode1%>��<%=retMsg1%>��", 0);
		window.close();
	</script>
	<%
	return;
} else {
%>
<HEAD>
<base target="_self"/>
<title>������ת״̬ͬ������</title>
<script language="javascript" type="text/javascript" src="json2.js"></script>
<script language="javascript" type="text/javascript" src="fe555_mainScript.js"></script>
<script type="text/javascript">
	var productOrderInfo;
	
	onload = function() {
		if (typeof(window.dialogArguments) != "undefined") {
			//alert("ȡҳ�����");
			productOrderInfo = window.dialogArguments;
		} else {
			//alert("ȡ�������");
			productOrderInfo = new ProductOrderInfo();
			productOrderInfo.productId = "<%=result1[0][0]%>";
			productOrderInfo.circuitCode = "<%=result1[0][1]%>";
			productOrderInfo.result = "<%=result1[0][2]%>";
			productOrderInfo.reason = "<%=result1[0][3]%>";
			productOrderInfo.customContact = "<%=result1[0][4]%>";
			productOrderInfo.customContactPhone = "<%=result1[0][5]%>";
			productOrderInfo.planCompTime = "<%=result1[0][6]%>";
			productOrderInfo.provCustMags = new Array();
			productOrderInfo.custInfos = new Array();
			productOrderInfo.dealInfos = new Array();
			productOrderInfo.prodInfoModifies = new Array();
			
			<%
			for (int i = 0; i < result2.length; i ++) {
			
			System.out.println("result2.length="+result2.length);
			System.out.println("result2[i][0]="+result2[i][0]);
			
				%>
				productOrderInfo.addProvCustMag("<%=result2[i][0]%>", "<%=result2[i][1]%>", "<%=result2[i][2]%>");
				<%
			}
			for (int i = 0; i < result3.length; i ++) {
				%>
				productOrderInfo.addCustInfos("<%=result3[i][0]%>", "<%=result3[i][1]%>", "<%=result3[i][2]%>");
				<%
			}
			for (int i = 0; i < result4.length; i ++) {
				%>
				productOrderInfo.addDealInfos("<%=result4[i][0]%>", "<%=result4[i][1]%>", "<%=result4[i][2]%>", "");
				<%
			}
			for (int i = 0; i < result5.length; i ++) {
				%>
				productOrderInfo.addProdInfoModify("<%=result5[i][0]%>", "<%=result5[i][1]%>");
				<%
			}
			%>
		}
		if ("<%=opType%>" == "q") {
			unInput("productId");
			unInput("circuitCode");
			$("#result").attr("disabled",true);
			$("#reason").attr("disabled",true);
			unInput("customContact");
			unInput("customContactPhone");
			unInput("planCompTime");
		} else if ("<%=opType%>" == "4") {
			unInput("productId");
			$("#result").attr("disabled",true);
			unInput("customContact");
			unInput("customContactPhone");
			unInput("planCompTime");
		} else if ("<%=opType%>" == "5") {
			unInput("productId");
			$("#result").attr("disabled",true);
			$("#reason").attr("disabled",true);
			unInput("customContact");
			unInput("customContactPhone");
			unInput("planCompTime");
			$("#addprovCustMagRowBtn").attr("disabled", false);
		} else if ("<%=opType%>" == "6") {
			unInput("productId");
			unInput("circuitCode");
			$("#result").attr("disabled",true);
			$("#reason").attr("disabled",true);
			unInput("customContact");
			unInput("customContactPhone");
			unInput("planCompTime");
			$("#addCustInfoRowBtn").attr("disabled", false);
			$("#addDealInfoRowBtn").attr("disabled", false);
		}
		
		//չʾ��Ʒ������Ϣ
		$("#productId").val(productOrderInfo.productId);
		$("#circuitCode").val(productOrderInfo.circuitCode);
		$("#result").val(productOrderInfo.result);
		$("#reason").val(productOrderInfo.reason);
		$("#customContact").val(productOrderInfo.customContact);
		$("#customContactPhone").val(productOrderInfo.customContactPhone);
		$("#planCompTime").val(productOrderInfo.planCompTime);
		
		var trTemp;
		//չʾ��Ʒ��Ӧ�Ŀͻ�����
		for (var a = 0; a < productOrderInfo.provCustMags.length; a ++) {
			
			if ("<%=opType%>" == "5" && productOrderInfo.provCustMags[a].magType == "2") {
				trTemp = document.getElementById("provCustMagMsg").children[0].insertRow();
				trTemp.insertCell().innerHTML = "<select name='magType'><!--option value='1'>A�˿ͻ�����</option--><option value='2'>Z�˿ͻ�����</option></select>";
				document.getElementsByName("magType")[a].value = productOrderInfo.provCustMags[a].magType;
				trTemp.insertCell().innerHTML = "<input type='text' name='magName' value='"+productOrderInfo.provCustMags[a].magName+"' v_must='1' maxlength='64' v_type='string' v_maxlength='64'/>";
				trTemp.insertCell().innerHTML = "<input type='text' name='magPhone' value='"+productOrderInfo.provCustMags[a].magPhone+"' v_must='1' maxlength='64' v_type='string' v_maxlength='64'/>";
				trTemp.insertCell().innerHTML = "<input type='button' class='b_text' name='' id='' value='ɾ��' onclick='deleteOfferRow(\"provCustMagMsg\",this)'/>";
			} else {
				trTemp = document.getElementById("provCustMagMsg").children[0].insertRow();
				trTemp.insertCell().innerHTML = "<select name='magType' <%=disabledStr%>><option value='1'>A�˿ͻ�����</option><option value='2'>Z�˿ͻ�����</option></select>";
				document.getElementsByName("magType")[a].value = productOrderInfo.provCustMags[a].magType;
				trTemp.insertCell().innerHTML = "<input type='text' name='magName' value='"+productOrderInfo.provCustMags[a].magName+"' v_must='1' maxlength='64' v_type='string' v_maxlength='64' class='<%=inputGreyStr%>' <%=readOnlyStr%>/>";
				trTemp.insertCell().innerHTML = "<input type='text' name='magPhone' value='"+productOrderInfo.provCustMags[a].magPhone+"' v_must='1' maxlength='64' v_type='string' v_maxlength='64' class='<%=inputGreyStr%>' <%=readOnlyStr%>/>";
				trTemp.insertCell().innerHTML = "<input type='button' class='b_text' name='' id='' value='ɾ��' onclick='deleteOfferRow(\"provCustMagMsg\",this)' <%=disabledStr%>/>";
			}
		}
		//չʾ��Ʒ�����漰�Ŀͻ���Ϣ
		if ("<%=opType%>" == "6") {
			for (var a = 0; a < productOrderInfo.custInfos.length; a ++) {
				trTemp = document.getElementById("custInfoMsg").children[0].insertRow();
				trTemp.insertCell().innerHTML = "<select name='custType'><option value='1'>A�˿ͻ�</option><option value='2'>Z�˿ͻ�</option></select>";
				document.getElementsByName("custType")[a].value = productOrderInfo.custInfos[a].custType;
				trTemp.insertCell().innerHTML = "<input type='text' name='custCode' value='"+productOrderInfo.custInfos[a].custCode+"' v_must='1' maxlength='30' v_type='string' v_maxlength='30' />";
				trTemp.insertCell().innerHTML = "<input type='text' name='custName' value='"+productOrderInfo.custInfos[a].custName+"' maxlength='256' v_type='string' v_maxlength='256' />";
				trTemp.insertCell().innerHTML = "<input type='button' class='b_text' name='' id='' value='ɾ��' onclick='deleteOfferRow(\"custInfoMsg\", this)' />";
			}
		} else {
			for (var a = 0; a < productOrderInfo.custInfos.length; a ++) {
				trTemp = document.getElementById("custInfoMsg").children[0].insertRow();
				trTemp.insertCell().innerHTML = "<select name='custType' <%=disabledStr%>><option value='1'>A�˿ͻ�</option><option value='2'>Z�˿ͻ�</option></select>";
				document.getElementsByName("custType")[a].value = productOrderInfo.custInfos[a].custType;
				trTemp.insertCell().innerHTML = "<input type='text' name='custCode' value='"+productOrderInfo.custInfos[a].custCode+"' v_must='1' maxlength='30' v_type='string' v_maxlength='30' class='<%=inputGreyStr%>' <%=readOnlyStr%>/>";
				trTemp.insertCell().innerHTML = "<input type='text' name='custName' value='"+productOrderInfo.custInfos[a].custName+"' maxlength='256' v_type='string' v_maxlength='256' class='<%=inputGreyStr%>' <%=readOnlyStr%>/>";
				trTemp.insertCell().innerHTML = "<input type='button' class='b_text' name='' id='' value='ɾ��' onclick='deleteOfferRow(\"custInfoMsg\", this)' <%=disabledStr%>/>";
			}
		}
		//չʾ��Ʒ��ʵ���
		if ("<%=opType%>" == "6") {
			for (var a = 0; a < productOrderInfo.dealInfos.length; a ++) {
				trTemp = document.getElementById("dealInfoMsg").children[0].insertRow();
				trTemp.insertCell().innerHTML = "<select name='dealSide'><option value='1'>A��</option><option value='2'>Z��</option></select>";
				document.getElementsByName("dealSide")[a].value = productOrderInfo.dealInfos[a].dealSide;
				trTemp.insertCell().innerHTML = "<input type='text' name='dealDatail' value='"+productOrderInfo.dealInfos[a].dealDatail+"' v_must='1' maxlength='1000' v_type='string' v_maxlength='1000' />";
				trTemp.insertCell().innerHTML = "<input type='text' name='attachment' value='"+productOrderInfo.dealInfos[a].attachment+"' maxlength='128' v_type='string' v_maxlength='128' class='<%=inputGreyStr%>' <%=readOnlyStr%>/>"
					 + "<input type='hidden' name='attachmentFile' value='"+productOrderInfo.dealInfos[a].attachmentFile+"'/>";
				//	 + "<input type='hidden' name='attachmentLocalFile' value='"+productOrderInfo.dealInfos[a].attachmentLocalFile+"'/>";
				//	 + "<input type='hidden' name='attachment' value='"+productOrderInfo.dealInfos[a].attachment+"'/>";
				//trTemp.insertCell().innerHTML = "<input type='text' name='attachment' value='"+productOrderInfo.dealInfos[a].attachment+"' maxlength='128' v_type='string' v_maxlength='128' />";
				trTemp.insertCell().innerHTML = "<input type='button' class='b_text' name='' id='' value='ɾ��' onclick='deleteOfferRow(\"dealInfoMsg\", this)' />";
			}
		} else {
			for (var a = 0; a < productOrderInfo.dealInfos.length; a ++) {
				trTemp = document.getElementById("dealInfoMsg").children[0].insertRow();
				trTemp.insertCell().innerHTML = "<select name='dealSide' <%=disabledStr%>><option value='1'>A��</option><option value='2'>Z��</option></select>";
				document.getElementsByName("dealSide")[a].value = productOrderInfo.dealInfos[a].dealSide;
				trTemp.insertCell().innerHTML = "<input type='text' name='dealDatail' value='"+productOrderInfo.dealInfos[a].dealDatail+"' v_must='1' maxlength='1000' v_type='string' v_maxlength='1000' class='<%=inputGreyStr%>' <%=readOnlyStr%>/>";
				trTemp.insertCell().innerHTML = "<input type='text' name='attachment' value='"+productOrderInfo.dealInfos[a].attachment+"' maxlength='128' v_type='string' v_maxlength='128' class='<%=inputGreyStr%>' <%=readOnlyStr%>/>";
				trTemp.insertCell().innerHTML = "<input type='button' class='b_text' name='' id='' value='ɾ��' onclick='deleteOfferRow(\"dealInfoMsg\", this)' <%=disabledStr%>/>";
			}
		}
		//չʾ��Ʒ��Ϣ����
		for (var a = 0; a < productOrderInfo.prodInfoModifies.length; a ++) {
			trTemp = document.getElementById("prodInfoModifyMsg").children[0].insertRow();
			trTemp.insertCell().innerHTML = "<select name='modiType' <%=disabledStr%>><option value='1'>��·����</option><option value='2'>A�˿ͻ�����</option><option value='3'>Z�˿ͻ�����</option><option value='4'>�ͻ�����</option></select>";
			document.getElementsByName("modiType")[a].value = productOrderInfo.prodInfoModifies[a].modiType;
			trTemp.insertCell().innerHTML = "<input type='text' name='modiValue' value='"+productOrderInfo.prodInfoModifies[a].modiValue+"' maxlength='128' v_type='string' v_maxlength='128' class='<%=inputGreyStr%>' <%=readOnlyStr%>/>";
			trTemp.insertCell().innerHTML = "<input type='button' class='b_text' name='' id='' value='ɾ��' onclick='deleteOfferRow(\"prodInfoModifyMsg\", this)' <%=disabledStr%>/>";
		}
	}
	function deleteOfferRow(msgId, obj) {
		var tableTemp = document.getElementById(msgId).children[0];
		tableTemp.deleteRow(obj.parentElement.parentElement.rowIndex);
	}
	function addOfferRow(msgId) {
		var trTemp = document.getElementById(msgId).children[0].insertRow();
		if (msgId == "provCustMagMsg") {	//��Ʒ��Ӧ�Ŀͻ�����
			trTemp.insertCell().innerHTML = "<select name='magType'><!--option value='1'>A�˿ͻ�����</option--><option value=''>�ͻ�����</option><option value='2'>Z�˿ͻ�����</option></select>";
			trTemp.insertCell().innerHTML = "<input type='text' name='magName' value='' v_must='1' maxlength='64' v_type='string' v_maxlength='64'/>";
			trTemp.insertCell().innerHTML = "<input type='text' name='magPhone' value='' v_must='1' maxlength='64' v_type='string' v_maxlength='64'/>";
			trTemp.insertCell().innerHTML = "<input type='button' class='b_text' name='' id='' value='ɾ��' onclick='deleteOfferRow(\"provCustMagMsg\",this)'/>";
		} else if (msgId == "custInfoMsg") {	//��Ʒ�����漰�Ŀͻ���Ϣ
			trTemp.insertCell().innerHTML = "<select name='custType'><!--option value='1'>A�˿ͻ�</option--><option value='2'>Z�˿ͻ�</option></select>";
			trTemp.insertCell().innerHTML = "<input type='text' name='custCode' value='' v_must='1' maxlength='30' v_type='string' v_maxlength='30' />";
			trTemp.insertCell().innerHTML = "<input type='text' name='custName' value='' maxlength='256' v_type='string' v_maxlength='256' />";
			trTemp.insertCell().innerHTML = "<input type='button' class='b_text' name='' id='' value='ɾ��' onclick='deleteOfferRow(\"custInfoMsg\", this)' />";
		} else if (msgId == "dealInfoMsg") {	//��Ʒ��ʵ���
			/*
			trTemp.insertCell().innerHTML = "<select name='dealSide'><option value='1'>A��</option><option value='2'>Z��</option></select>";
			trTemp.insertCell().innerHTML = "<input type='text' name='dealDatail' value='' v_must='1' maxlength='1000' v_type='string' v_maxlength='1000' />";
			trTemp.insertCell().innerHTML = "<input type='file' name='attachmentLocalFile' value=''/>"
				 + "<input type='hidden' name='attachmentFile' value=''/>"
				 + "<input type='hidden' name='attachment' value=''/>";
			//trTemp.insertCell().innerHTML = "<input type='text' name='attachment' value='' maxlength='128' v_type='string' v_maxlength='128' />";
			trTemp.insertCell().innerHTML = "<input type='button' class='b_text' name='' id='' value='ɾ��' onclick='deleteOfferRow(\"dealInfoMsg\", this)' />";
			*/
			var getAcceptNamePacket = new AJAXPacket("ajax_getAcceptName.jsp","���ڻ�����ݣ����Ժ�......");
			getAcceptNamePacket.data.add("msgId", msgId);
			core.ajax.sendPacket(getAcceptNamePacket, doGetAcceptName);
			getAcceptNamePacket = null;
		}
	}
	
	function doGetAcceptName(packet) {
		var msgId = packet.data.findValueByName("msgId");
		var acceptName = packet.data.findValueByName("acceptName");
		
		var trTemp = document.getElementById(msgId).children[0].insertRow();
		trTemp.insertCell().innerHTML = "<select name='dealSide'><!--option value='1'>A��</option--><option value='2'>Z��</option></select>";
		trTemp.insertCell().innerHTML = "<input type='text' name='dealDatail' value='' v_must='1' maxlength='1000' v_type='string' v_maxlength='1000' />";
		trTemp.insertCell().innerHTML = "<input type='file' name='attachmentLocalFile' value=''/>"
			 + "<input type='hidden' name='attachmentFile' value='" + acceptName + "'/>"
			 + "<input type='hidden' name='attachment' value=''/>";
		//trTemp.insertCell().innerHTML = "<input type='text' name='attachment' value='' maxlength='128' v_type='string' v_maxlength='128' />";
		trTemp.insertCell().innerHTML = "<input type='button' class='b_text' name='' id='' value='ɾ��' onclick='deleteOfferRow(\"dealInfoMsg\", this)' />";
	}
	
	function unInput(eleId){
		$("#"+eleId).attr("class", "InputGrey");
		$("#"+eleId).attr("readonly", true);
	}
	
	function checkTextArea() {
		if (document.getElementById("reason").length > 500) {
			rdShowMessageDialog("����״̬ԭ���������ֻ����500�����֣�",1);
			return;
		}
		/*
		if(obj.indexOf(",")!=-1||obj.indexOf("\"")!=-1||obj.indexOf("\n")!=-1) {
			rdShowMessageDialog("����״̬ԭ������������Ӣ�Ķ��Ż�˫���Ż�س����У�����������",1);
			document.all.offerComments.focus();
			return false;	
		}
		*/
	}
	
	function cfm() {
		if ("<%=opType%>" == "q") {
		} else if ("<%=opType%>" == "4") {
			if (!checkElement(document.getElementById("circuitCode"))) {
				rdShowMessageDialog("��·������д����", 1);
				return;
			}
			if (document.getElementById("reason").value.length > 500) {
				rdShowMessageDialog("����״̬ԭ���������ֻ����500�����֣�",1);
				return;
			}
			
			//��Ʒ������Ϣ
			productOrderInfo.circuitCode = $("#circuitCode").val();
			productOrderInfo.reason = $("#reason").val();
		} else if ("<%=opType%>" == "5") {
			if (!checkElement(document.getElementById("circuitCode"))) {
				rdShowMessageDialog("��·������д����", 1);
				return;
			} else if (document.getElementsByName("magType").length == 0) {
				rdShowMessageDialog("����Ҫ��һ����Ʒ��Ӧ�Ŀͻ�����", 1);
				return;
			}
			for (var a = 0; a < document.getElementsByName("magType").length; a ++) {
				if (!checkElement(document.getElementsByName("magName")[a])) {
					//rdShowMessageDialog("��д����", 1);
					return false;
				} else if (!checkElement(document.getElementsByName("magPhone")[a])) {
					return false;
				}
			}
			
			//��Ʒ������Ϣ
			productOrderInfo.circuitCode = $("#circuitCode").val();
			//������Ϣ
			//��Ʒ��Ӧ�Ŀͻ�����
			productOrderInfo.provCustMags = new Array();
			for (var a = 0; a < document.getElementsByName("magType").length; a ++) {
				var vProvCustMag = new ProvCustMag();
				vProvCustMag.magType = document.getElementsByName("magType")[a].value;
				vProvCustMag.magName = document.getElementsByName("magName")[a].value;
				vProvCustMag.magPhone = document.getElementsByName("magPhone")[a].value;
				productOrderInfo.provCustMags[productOrderInfo.provCustMags.length] = vProvCustMag;
				//productOrderInfo.addProvCustMag(document.getElementsByName("magType")[a].value, document.getElementsByName("magName")[a].value, document.getElementsByName("magPhone")[a].value);
			}
		} else if ("<%=opType%>" == "6") {
			if (("<%=businessMode%>" == "2" || "<%=businessMode%>" == "4") && document.getElementsByName("custType").length == 0) {
				rdShowMessageDialog("��Ʒ�����漰�Ŀͻ���Ϣ����Ҫ��һ����", 1);
				return false;
			}
			for (var a = 0; a < document.getElementsByName("custType").length; a ++) {
				if (!checkElement(document.getElementsByName("custCode")[a])) {
					//rdShowMessageDialog("��д����", 1);
					return false;
				} else if (!checkElement(document.getElementsByName("custName")[a])) {
					return false;
				}
			}
			for (var a = 0; a < document.getElementsByName("dealSide").length; a ++) {
				/*var filePath;
				if (document.getElementsByName("attachmentLocalFile")[a].value.indexOf("\\") != -1) {
					filePath = document.getElementsByName("attachmentLocalFile")[a].value.split("\\");
				} else {
					filePath = document.getElementsByName("attachmentLocalFile")[a].value.split("/");
				}*/
				//document.getElementsByName("attachment")[a].value = filePath[filePath.length-1];
				if (!checkElement(document.getElementsByName("dealDatail")[a])) {
					//rdShowMessageDialog("��д����", 1);
					return false;
				} else if (!checkElement(document.getElementsByName("attachment")[a])) {
					return false;
				}
			}
			
			//��Ʒ������Ϣ
			//������Ϣ
			//��Ʒ�����漰�Ŀͻ���Ϣ
			productOrderInfo.custInfos = new Array();
			for (var a = 0; a < document.getElementsByName("custType").length; a ++) {
				var vCustInfo = new CustInfo();
				vCustInfo.custType = document.getElementsByName("custType")[a].value;
				vCustInfo.custCode = document.getElementsByName("custCode")[a].value;
				vCustInfo.custName = document.getElementsByName("custName")[a].value;
				productOrderInfo.custInfos[productOrderInfo.custInfos.length] = vCustInfo;
			}
			//��Ʒ��ʵ���
			productOrderInfo.dealInfos = new Array();
			for (var a = 0; a < document.getElementsByName("dealSide").length; a ++) {
				var vDealInfo = new DealInfo();
				vDealInfo.dealSide = document.getElementsByName("dealSide")[a].value;
				vDealInfo.dealDatail = document.getElementsByName("dealDatail")[a].value;
				vDealInfo.attachment = document.getElementsByName("attachment")[a].value;
				vDealInfo.attachmentFile = document.getElementsByName("attachmentFile")[a].value;
				//vDealInfo.attachmentLocalFile = document.getElementsByName("attachmentLocalFile")[a].value;
				productOrderInfo.dealInfos[productOrderInfo.dealInfos.length] = vDealInfo;
			}
		} else {
		}
		

		var jsonText = JSON.stringify(productOrderInfo, function(key,value){
			return value;
		});
		//alert(jsonText);
		
		var attachmentValue;
		var attachmentFileValue;
		var attachmentLocalFileValue;
		var uploadBool;
		for (var a = 0; a < document.getElementsByName("attachmentLocalFile").length; a ++) {
			attachmentFileValue = document.getElementsByName("attachmentFile")[a].value;
			attachmentLocalFileValue = document.getElementsByName("attachmentLocalFile")[a].value;
			if (attachmentLocalFileValue != "") {
				uploadBool = true;
				attachmentValue = attachmentLocalFileValue.substring((attachmentLocalFileValue.lastIndexOf("\\")+1), attachmentLocalFileValue.length);
				/*attachmentFileValue = attachmentFileValue;*/
				attachmentFileValue = "<%=path%>/" + attachmentFileValue + attachmentLocalFileValue.substring(attachmentLocalFileValue.lastIndexOf("."), attachmentLocalFileValue.length);
				//alert("attachmentValue = " + attachmentValue);
				//alert("attachmentFileValue = " + attachmentFileValue);
				document.getElementsByName("attachment")[a].value = attachmentValue;
				document.getElementsByName("attachmentFile")[a].value = attachmentFileValue;
				productOrderInfo.dealInfos[a].attachment = attachmentValue;
				productOrderInfo.dealInfos[a].attachmentFile = attachmentFileValue;
		    //attachmentSuccess(a, attachmentValue, attachmentFileValue);
		    //document.frm.target="uploadFrame";
		    
			}
		}
		window.returnValue = productOrderInfo;
		if (uploadBool) {
	    document.frm.encoding="multipart/form-data";
			document.frm.action="fe555_upload.jsp";
			document.frm.submit();
	    
	    return true;
		}
		
		window.close();
	}
	
	function test(i, attachmentFileValue) {
		productOrderInfo.dealInfos[i].attachmentFile = attachmentFileValue;
	}
	var no = 0;
	function attachmentSuccess(vNo, vAttachment, vAttachmentFile) {
		for (var a = 0; a < productOrderInfo.dealInfos.length; a ++) {
			if (productOrderInfo.dealInfos[a].attachmentFile == "" && no == vNo) {
				//document.getElementsByName("attachment")[a].value = vAttachment;
				//document.getElementsByName("attachmentFile")[a].value = vAttachmentFile;
				productOrderInfo.dealInfos[a].attachment = vAttachment;
				productOrderInfo.dealInfos[a].attachmentFile = vAttachmentFile;
				
				no ++;
			}
		}
		for (var a = 0; a < document.getElementsByName("attachmentFile").length; a ++) {
			if (document.getElementsByName("attachmentFile")[a].value == "") {
				return false;
			}
		}
		var jsonText = JSON.stringify(productOrderInfo, function(key,value){
			return value;
		});
		//opener.test();
		//alert(jsonText);
		window.returnValue = productOrderInfo;
		//window.close();
	}
</script>
</HEAD>
<%
}
%>
<BODY>
<%@ include file="/npage/include/header.jsp" %>
<form name="frm" action="" method="post">
<div class="title">
	<div id="title_zi">��Ʒ������Ϣ</div>
</div>
<table>
	<tr>
		<td class="blue" width="20%">
			��Ʒ������
		</td>
		<td colspan="3">
			<input type="text" name="productId" id="productId" size="20" v_must="1" maxlength="20" v_type='string' v_maxlength="20" readOnly>
		</td>
	</tr>
	<tr>
		<td class="blue" width="20%">
			��·����
		</td>
		<td colspan="3">
			<input type="text" name="circuitCode" id="circuitCode" size="30" maxlength="128" v_type='string' v_maxlength="128">
		</td>
	</tr>
	<tr>
		<td class="blue" width="20%">
			����״̬��ɽ��
		</td>
		<td colspan="3">
			<select name="result" id="result">
				<option value="">-δѡ��-</option>
				<option value="1">�ѳɹ����</option>
				<option value="2">δ�ɹ����</option>
			</select>
		</td>
	</tr>
	<tr>
		<td class="blue" width="20%">
			����״̬ԭ������
		</td>
		<td colspan="3">
			<textarea name="reason" id="reason" maxlength="1000" v_must="1" v_type="string" v_maxlength="1000" cols="60" rows="3"></textarea>(����500����)
			<!--input name="reason" id="reason" maxlength="1000" v_type="string" v_maxlength="1000"-->
		</td>
	</tr>
	<tr>
		<td class="blue" width="20%">
			�ͻ���ϵ��
		</td>
		<td width="30%">
			<input type="text" name="customContact" id="customContact" maxlength="64" v_type="string" v_maxlength="64">
		</td>
		<td class="blue" width="20%">
			�ͻ���ϵ��ʽ
		</td>
		<td width="30%">
			<input type="text" name="customContactPhone" id="customContactPhone" maxlength="64" v_type="string" v_maxlength="64">
		</td>
	</tr>
	<tr>
		<td class="blue" width="20%">
			��ɻ���Ԥ����ɴ�״̬��ʱ��
		</td>
		<td colspan="3">
			<input type="text" name="planCompTime" id="planCompTime" maxlength="14" v_maxlength="14" v_type="yyyyMMddHHmmss">
		</td>
	</tr>
</table>
<br/>
<div class="title">
	<div id="title_zi">
		��Ʒ��Ӧ�Ŀͻ�����
		<!--img id="provCustMagMsg_switch" state="close" src="../../../nresources/default/images/jian.gif" style='cursor:hand' width="15" height="15"-->
		&nbsp;&nbsp;&nbsp;&nbsp;
		<input type='button' class='b_text' name='addprovCustMagRowBtn' id='addprovCustMagRowBtn' value='���' onclick="addOfferRow('provCustMagMsg')" <%=disabledStr%>/>
	</div>
</div>
<div name="provCustMagMsg" id="provCustMagMsg">
	<table>
		<tr>
			<th width="20%">�ͻ���������</th>
			<th width="30%">����</th>
			<th width="30%">�绰</th>
			<th width="20%">����</th>
		</tr>
	</table>
</div>
<br/>
<div class="title">
	<div id="title_zi">
		��Ʒ�����漰�Ŀͻ���Ϣ
		<!--img id="custInfoMsg_switch" state="close" src="../../../nresources/default/images/jian.gif" style='cursor:hand' width="15" height="15"-->
		&nbsp;&nbsp;&nbsp;&nbsp;
		<input type='button' class='b_text' name='addCustInfoRowBtn' id='addCustInfoRowBtn' value='���' onclick="addOfferRow('custInfoMsg')" <%=disabledStr%>/>
	</div>
</div>
<div name="custInfoMsg" id="custInfoMsg">
	<table>
		<tr>
			<th width="20%">�ͻ�����</th>
			<th width="30%">�ͻ�����(���ű��)</th>
			<th width="30%">�ͻ�����</th>
			<th width="20%">����</th>
		</tr>
	</table>
</div>
<br/>
<div class="title">
	<div id="title_zi">
		��Ʒ��ʵ���
		<!--img id="dealInfoMsg_switch" state="close" src="../../../nresources/default/images/jian.gif" style='cursor:hand' width="15" height="15"-->
		&nbsp;&nbsp;&nbsp;&nbsp;
		<input type='button' class='b_text' name='addDealInfoRowBtn' id='addDealInfoRowBtn' value='���' onclick="addOfferRow('dealInfoMsg')" <%=disabledStr%>/>
	</div>
</div>
<div name="dealInfoMsg" id="dealInfoMsg">
	<table>
		<tr>
			<th width="20%">��Ʒ��ʵ��</th>
			<th width="30%">��ǰ״̬����˵��</th>
			<th width="30%">��ǰ״̬�漰����</th>
			<th width="20%">����</th>
		</tr>
	</table>
</div>
<br/>
<div class="title">
	<div id="title_zi">
		��Ʒ��Ϣ����
		<!--img id="prodInfoModifyMsg_switch" state="close" src="../../../nresources/default/images/jian.gif" style='cursor:hand' width="15" height="15"-->
	</div>
</div>
<div name="prodInfoModifyMsg" id="prodInfoModifyMsg">
	<table>
		<tr>
			<th width="20%">�����Ĳ�Ʒ��Ϣ���</th>
			<th width="30%">�������ֵ</th>
			<th width="20%">����</th>
		</tr>
	</table>
</div>
<table>
	<tr>
		<td align="center" id="footer" colspan="4">
			<input class="b_foot" id="confirm" type=button value="ȷ��" onClick="cfm();">
			<input class="b_foot" id="closebtn" type=button value="�ر�" onClick="window.close()">
		</td>
	</tr>
</table>
</form>
<%@ include file="/npage/include/footer.jsp" %>
</BODY>
</HTML>

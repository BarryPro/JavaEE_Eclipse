<%
  /*
   * ����: �ͻ�����
�� * �汾: 1.0
�� * ����: 2010/03/16
�� * ����: tangsong
�� * ��Ȩ: sitech
 ��*/
%>
 
<%@ page contentType="text/html;charset=gb2312" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<html>
<head>
    <title>�ͻ���������</title>
    <script type="text/javascript">
    	window.onload=function() {
 				getHJLS(); //��ȡ������ˮ��
 				getKHDS(); //��ȡ�ͻ�����
    		TJWLChange(); //��ʼҵ������Ϊ�ƽ��ҵ������
    		sendMsgAble(); //�趨���Ͷ��Ű�ť���û򲻿���
    	}
    	//��ȡ������ˮ��
    	function getHJLS() {
    		//����ʹ��,�Զ���һ����ˮ��
    		//var contactId = "1324241114546dfaef";
    		
    		<!--tangsong��ǰд�� var contactId = window.opener.opener.document.getElementById("contactId").value;-->
    		var contactId = "<%=request.getParameter("contactId")%>";
    		if(contactId!='null')
    		{
    		//alert(contactId);
    		document.detainform.HJLS.value = contactId;
    		}
    	}
    	//��ȡ�ͻ�����
    	function getKHDS() {
    		var chkInfoPacket = new AJAXPacket("<%=request.getContextPath()%>/npage/callbosspage/customerDetain/getOptions.jsp","���ڸ�������,���Ժ�...");
    		var selectSql = "SELECT REGION_CODE, REGION_NAME FROM SCALLREGIONCODE";
    		chkInfoPacket.data.add("selectSql", selectSql);
    		chkInfoPacket.data.add("option_value", "REGION_CODE");
    		chkInfoPacket.data.add("option_description", "REGION_NAME");
		    core.ajax.sendPacket(chkInfoPacket, setOptions_KHDS);
				chkInfoPacket = null;
    	}
    	function setOptions_KHDS(packet) {
    		var optionsHtml = packet.data.findValueByName("optionsHtml");
				var selectHtml = "<select name='KHDS' id='KHDS'><option value='-1'>---��ѡ�����---</option>" + optionsHtml + "</select>";
    		td_KHDS.innerHTML = selectHtml;
    	}
    	//�����б��������ƽ����� --> ҵ������
    	function TJWLChange() {
    		var selectHTML_TJ = "<select name='ZXZT'><option value='1'>����</option><option value='2' selected='selected'>������</option></select>";
    		var selectHTML_WL = "<select name='ZXZT'><option value='1'>�ɹ�</option><option value='2' selected='selected'>���ɹ�</option></select>";

    		var typeID = document.detainform.TJWL.value;
    		if (typeID == "1") {
    			td_ZXZT.innerHTML = selectHTML_TJ;
    		} else {
    			td_ZXZT.innerHTML = selectHTML_WL;
    		}
    		
    		var chkInfoPacket = new AJAXPacket("<%=request.getContextPath()%>/npage/callbosspage/customerDetain/getOptions.jsp","���ڸ�������,���Ժ�...");
    		var selectSql = "SELECT ID, MSGINFO FROM BUSINESSTYPE WHERE TYPEID = " + typeID;
    		chkInfoPacket.data.add("selectSql", selectSql);
    		chkInfoPacket.data.add("option_value", "ID");
    		chkInfoPacket.data.add("option_description", "MSGINFO");
		    core.ajax.sendPacket(chkInfoPacket, setOptions_YWLX);
				chkInfoPacket = null;
				YWLXChange();
    	}
    	function setOptions_YWLX(packet) {
    		var optionsHtml = packet.data.findValueByName("optionsHtml");
				var selectHtml = "<select name='YWLX' id='YWLX' onchange='YWLXChange()'>"+optionsHtml+"</select>";
    		td_YWLX.innerHTML = selectHtml;
    	}
    	//�����б�������ҵ������(ѡ����������) --> ����ԭ���
    	function YWLXChange() {
				if (document.detainform.YWLX.value == "19") {
					document.getElementById("tr_1").style.display = "none";
					document.getElementById("tr_2").style.display = "";
					document.getElementById("tr_3").style.display = "";
					document.getElementById("tr_4").style.display = "";
					document.getElementById("tr_5").style.display = "";
					getXHYY();
				} else {
					document.getElementById("tr_1").style.display = "";
					document.getElementById("tr_2").style.display = "none";
					document.getElementById("tr_3").style.display = "none";
					document.getElementById("tr_4").style.display = "none";
					document.getElementById("tr_5").style.display = "none";
				}
    	}
    	
    	//��ȡ����ԭ��
    	function getXHYY() {
    		var chkInfoPacket = new AJAXPacket("<%=request.getContextPath()%>/npage/callbosspage/customerDetain/getOptions.jsp","���ڸ�������,���Ժ�...");
    		var selectSql = "SELECT ID, MSGINFO FROM CANCELREASON";
    		chkInfoPacket.data.add("selectSql", selectSql);
    		chkInfoPacket.data.add("option_value", "ID");
    		chkInfoPacket.data.add("option_description", "MSGINFO");
		    core.ajax.sendPacket(chkInfoPacket, setOptions_XHYY);
				chkInfoPacket = null;
    	}
    	function setOptions_XHYY(packet) {
    		var optionsHtml = packet.data.findValueByName("optionsHtml");
				var selectHtml = "<select name='XHYY' id='XHYY'>" + optionsHtml + "</select>";
    		span_XHYY.innerHTML = selectHtml;
    	}
    	
    	//�ύ��
    	function dosubmit() {
    		var chkInfoPacket = new AJAXPacket("<%=request.getContextPath()%>/npage/callbosspage/customerDetain/customerDetain_do.jsp","���ڴ򿪿ͻ���������ҳ��,���Ժ�...");
    		chkInfoPacket.data.add("HJLS", document.detainform.HJLS.value);
    		chkInfoPacket.data.add("KHDS", document.detainform.KHDS.value);
    		chkInfoPacket.data.add("TJWL", document.detainform.TJWL.value);
    		chkInfoPacket.data.add("YWLX", document.detainform.YWLX.value);
    		chkInfoPacket.data.add("BZ", document.detainform.BZ.value);
    		chkInfoPacket.data.add("DXNR", document.detainform.DXNR.value);
    		
    		if (document.detainform.YWLX.value == "19") {
    			//ҵ������Ϊ��������ʱ
    			chkInfoPacket.data.add("ZXZT", "");
	    		chkInfoPacket.data.add("XHYY", document.detainform.XHYY.value);
	    		chkInfoPacket.data.add("XHJG", document.detainform.XHJG.value);
	    		chkInfoPacket.data.add("SFDKH", document.detainform.SFDKH.value);
	    		chkInfoPacket.data.add("XFQK", document.detainform.XFQK.value);
    		} else {
    			//ҵ�����Ͳ�Ϊ��������ʱ
    			chkInfoPacket.data.add("ZXZT", document.detainform.ZXZT.value);
	    		chkInfoPacket.data.add("XHYY", "");
	    		chkInfoPacket.data.add("XHJG", "");
	    		chkInfoPacket.data.add("SFDKH", "");
	    		chkInfoPacket.data.add("XFQK", "");
    		}

		    core.ajax.sendPacket(chkInfoPacket, submitResult);
				chkInfoPacket = null;
    	}
    	
    	function sendMsgAble() {
    		//var user_phone = window.opener.document.getElementById("userPhone").value;
    		var user_phone = "<%=request.getParameter("userPhone")%>";
    		if (user_phone == "") {
    			document.getElementById("sendMsgBtn").disabled = "disabled";
    		} else {
    			document.getElementById("sendMsgBtn").disabled = "";
    		}
    	}
    	function sendMsg() {
    		if (document.detainform.DXNR.value == "") {
    			rdShowMessageDialog('�������ݲ���Ϊ�գ�');
    			return;
    		}
    		//����ʹ��
    		//var user_phone='13679136441';
			//	var user_phone = window.opener.document.getElementById("userPhone").value;
			  var user_phone = "<%=request.getParameter("userPhone")%>";
				var mypacket = new AJAXPacket("<%=request.getContextPath()%>/npage/callbosspage/K083/K083_msgSend_rpc.jsp","���ڷ��Ͷ��ţ����Ժ�......");
				mypacket.data.add("user_phone",user_phone);
				mypacket.data.add("msg_content",encodeMsg());
				mypacket.data.add("con_id",document.detainform.HJLS.value);
				core.ajax.sendPacket(mypacket,doProcess,true);
				mypacket = null;
    	}
			function encodeMsg(){
				var msg_content = document.detainform.DXNR.value;
				msg_content = msg_content.replace(/\+/g,"%2B");
				return msg_content;
			}
			function doProcess(packet){
				var retCode = packet.data.findValueByName("scucc_flag");
				if(retCode=="1"){
					rdShowMessageDialog("���ͳɹ���", 2);   
				} else if(retCode=="0"){
					rdShowMessageDialog("����ʧ�ܣ�");    
				}
			}
			
    	function submitResult(packet) {
    		var result = packet.data.findValueByName("result");
				if(result=="success"){
					rdShowMessageDialog("�ύ�ɹ���", 2);
					window.close();
				} else{
					rdShowMessageDialog("�ύʧ�ܣ����������Ƿ�Ϸ�,��ע�����Ͷ������ݵȱ�ѡ�ֶβ���Ϊ�գ�");
				}
    	}
    </script>
    
    <style type="text/css">
    	body {
    		background-color:white;
    	}
    	#header {
    		width:98%; border:#9DA9BE solid 1px; height:30px;
    		line-height:30px; vertical-align:middle;
    		margin:5px; padding-left:10px;
    	}
    	#header p {
    		color:#B56035; font-weight:bold; font-size:12px;
    	}
    	#content {
    		width:98%;
    	}
    	#content table {
    		width:98%;
    	}
    	.td_key {
    		width:10%; text-align:left;
    	}
    	select {
    		width:150px;
    	}
    </style>
</head>
<body>
	<div id="header">
		<p>�ͻ���������</p>
	</div>
	
	<div id="content">
		<form name="detainform" id="detainform" method="post">
			<table style="font-size:12px">
				<tr>
					<td class="td_key">������ˮ</td>
					<td><input type="text" name="HJLS" id="HJLS" style="width:152px;" /></td>
				</tr>
				<tr>
					<td class="td_key">�ͻ�����</td>
					<td colspan="2" id="td_KHDS">
						<select name="KHDS" id="KHDS">
							<option value="-1">---��ѡ�����---</option>
						</select></td>
				</tr>
				<tr>
					<td class="td_key">�ƽ�����</td>
					<td colspan="2">
						<select name="TJWL" id="TJWL" onchange="TJWLChange()">
							<option value="1">�ƽ�</option>
							<option value="2">����</option>
						</select>
					</td>
				</tr>
				<tr>
					<td class="td_key">ҵ������</td>
					<td colspan="2" id="td_YWLX">
						<select name="YWLX" id="YWLX" onchange="YWLXChange()"></select>
					</td>
				</tr>
				<tr id="tr_1">
					<td class="td_key">ִ��״̬</td>
					<td colspan="2" id="td_ZXZT">
						<select name="ZXZT">
							<option value="1">����</option>
							<option value="2" selected='selected'>������</option>
						</select></td>
				</tr>
				<tr id="tr_2">
						<td class="td_key">����ԭ��</td>
						<td colspan="2" id="td_ZXZT">
							<span id="span_XHYY">
							<select name="XHYY" id="XHYY"></select>
						</span>
						</td>
				</tr>
				<tr id="tr_3">
						<td class="td_key">���Ž��</td>
						<td colspan="2">
							<select name="XHJG">
								<option value="1">�ɹ�</option>
								<option value="2">ʧ��</option>
							</select>
						</td>
				</tr>
				<tr id="tr_4">
						<td class="td_key">�Ƿ��ͻ�</td>
						<td colspan="2">
						<select name="SFDKH">
							<option value="1">��</option>
							<option value="2">��</option>
						</select>
						<td>
				</tr>
				<tr id="tr_5">
						<td class="td_key">�û��������</td>
						<td colspan="2">	
							<select name="XFQK">
								<option value="1">�߶�</option>
								<option value="2">�ж�</option>
								<option value="3">�Ͷ�</option>
							</select>
						</td>
					</tr>
				<tr>
					<td class="td_key">��ע</td>
					<td colspan="2">
						<textarea  name="BZ" style="width:70%;height:100px;"></textarea></td>
				</tr>
				<tr>
					<td class="td_key">���Ͷ�������</td>
					<td style="width:50%">
						<textarea name="DXNR" id="NXNR" style="width:100%;height:100px;"></textarea></td>
					<td style="text-align:left;padding-left:10px;">
						<button id="sendMsgBtn" onclick="sendMsg()" class="b_foot">����</button></td>
				</tr>
				<tr>
					<td colspan="3" style="padding-left:10px;">
						<input type="button" value="ȷ��" onClick="dosubmit()" class="b_foot"/>
						<input type="reset" value="����" class="b_foot"/>
					</td>
				</tr>
			</table>
		</form>
	</div>
</body>
</html>
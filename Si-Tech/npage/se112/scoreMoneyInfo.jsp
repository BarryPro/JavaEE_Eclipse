<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/se112/public_title_name.jsp"%>
<%@ include file="/npage/se112/footer.jsp"%>
<%@page import="com.sitech.crmpd.core.bean.MapBean"%>
<%@page import="java.util.*"%>
	

<%
	String phoneNo = (String)request.getParameter("svcNum");
	String meansId = (String)request.getParameter("meansId");
	String scornMoney = (String)request.getParameter("scornMoney");
	int scoreValue = Integer.parseInt(scornMoney)*84;
 %>	

 <%	
	
 %>
<html>
	<head>
	<title></title>
	</head>
	<body>
		<div id="operation">
		<form method="post" name="frm1147" action="">
				
				<div id="operation_table">
					 <div class="title">
						<div class="text">
							�Ͱ�����ȯ��Ϣ
						</div>
					</div>
					<div class="input">
						<table id='table_score'>
							<tr><th>���ý��</th><th>�ϼ����ͻ���ֵ</th><th>�Ƿ�����</th><th>����</th><th>����</th></tr>
							
							<tr>
								<td><%=scornMoney %></td>
								<td><%=scoreValue %></td>
								<td><select id="gift_type" name="gift_type" onchange="getGiftType();"><option value='0'>��ѡ��</option><option value='1'>�����û�</option><option value='2'>�����û�</option></select></td>
								<td><input  readonly="readonly" id='hid_gift_code' value=''/></td>
								<td><input type="button" class="b_foot" value="ȷ�϶���" id="sms_push" name="sms_push" onclick="smsPush()" /></td>
							</tr>
						</table>
					</div>
					<div id="operation_button"><!-- disabled="disabled" -->
						<input type="button" class="b_foot"  disabled="disabled" value="ȷ��" id="btnSubmit"
							name="btnSubmit" onclick="btnRsSubmit()" />
						<input type="button" class="b_foot" value="�ر�" id="btnCancel"
							name="btnCancel" onclick="closeWin()" />
					</div>
				</div>
			</form>
		</div>
	</body>
	<script type="text/javascript">
	
	
	var gGiftCode = "";
	var gFlag = "";
	function getGiftType(){
		var gift_type = $("#gift_type").val();
		if(gift_type == "1"){
			$("#hid_gift_code").attr("readonly",false);
		}else{
			$("#hid_gift_code").val("");
			$("#hid_gift_code").attr("readonly",true);
		}
	}
	function smsPush(){
		
		var gift_type = $("#gift_type").val();
		var hid_gift_code = $("#hid_gift_code").val();
		var hid_feevalue = $("#hid_feevalue_Str").val();
		if(gift_type == "0"){
			showDialog("��ѡ���Ƿ�����ѡ��",1);
			return ;
		}
		if(gift_type == "1"){//����
			if(hid_gift_code==""||null==hid_gift_code||"N/A"==hid_gift_code){
				showDialog("�����û�����봮��",1);
				return ;
			}
		}

		var myPacket = null;
		myPacket = new AJAXPacket("wsMktGiftSMSPush.jsp","���Ժ�...");
		myPacket.data.add("SUM_MONEY","<%=scornMoney %>");
		myPacket.data.add("PHONE_NO","<%=phoneNo%>");
		myPacket.data.add("GIFT_CODE",hid_gift_code);
		myPacket.data.add("OP_FLAG","0");//OP_FLAG����״��ʾ 0��ֻ�·����� 1��У��ִ֮ǰ�Ƿ��·�������
		myPacket.data.add("MEANS_ID","<%=meansId%>");
		core.ajax.sendPacket(myPacket,setSmsPush);
		myPacket =null;

	}
	
	function setSmsPush(packet){
		var RETURN_CODE = packet.data.findValueByName("RETURN_CODE");
		var RETURN_MSG = packet.data.findValueByName("RETURN_MSG");
		var GIFTCODE = packet.data.findValueByName("GIFTCODE");
		var FLAG = packet.data.findValueByName("FLAG");
		 if(trim(RETURN_CODE)!="000000"){
			showDialog(RETURN_MSG,0);
			return false;
		}else{
			$("#sms_push").attr("disabled", "disabled");
			$("#btnSubmit").attr("disabled", "");
		} 
		gGiftCode = GIFTCODE;
		gFlag = FLAG;
	}
	
	function btnRsSubmit(){
		var myPacket = null;
		myPacket = new AJAXPacket("wsMktGiftSMSPush.jsp","���Ժ�...");
		myPacket.data.add("SUM_MONEY","");
		myPacket.data.add("PHONE_NO","<%=phoneNo%>");
		myPacket.data.add("GIFT_CODE","");
		myPacket.data.add("OP_FLAG","1");//OP_FLAG����״��ʾ 0��ֻ�·����� 1��У��ִ֮ǰ�Ƿ��·�������
		myPacket.data.add("MEANS_ID","<%=meansId%>");
		core.ajax.sendPacket(myPacket,checkSmsPush);
		myPacket =null;
	}
	
	function checkSmsPush(packet){
		var RETURN_CODE = packet.data.findValueByName("RETURN_CODE");
		var RETURN_MSG = packet.data.findValueByName("RETURN_MSG");
		 if(trim(RETURN_CODE)!="000000"){
				showDialog(RETURN_MSG,0);
				return false;
		}
		 
			var score_Value ="<%=scoreValue%>";
			var gPrintInfo = " ���ͻ���ֵ��"+score_Value;
			var deductMoney = "<%=scornMoney%>";
			parent.buildScoreValueXml(score_Value,gGiftCode,gFlag,deductMoney,"");
			
			parent.document.getElementById("H42_show<%=meansId%>").innerHTML = gPrintInfo;
			parent.templet_Checkfuc();
			closeDivWin();
	}
	
	function closeWin(){
		closeDivWin();
	}
	</script>
</html>
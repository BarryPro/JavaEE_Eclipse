<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/se112/public_title_name.jsp"%>
<%@ include file="/npage/se112/footer.jsp"%>
<%@page import="com.sitech.crmpd.core.bean.MapBean"%>
<%@page import="java.util.*"%>
	

<%
	String phoneNo = (String)request.getParameter("svcNum");
	String meansId = (String)request.getParameter("meansId");
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
							�Ͱ�����ȯ��Ϣ(��)
						</div>
					</div>
					<div class="input">
					    <table id='table_score'>
							<tr>
							 <th>����������룺</th>
							 <td><input type="text" id='giftCode' value=''/>
							 <input type="button" class="b_text" name="verifyRes" id="verifyRes" onclick="chkCode()" value="��֤"/>
							 <font style="color:red"><b>*</b></font><div id="td1" align="left"></td>
							</tr>
							<tr>
							<th>�������</th>
							<td><input type="text" id='scoreMoney' value='' readonly="readonly"/></td>
							</tr>
							<tr>
							<th>�ϼ����ͻ���ֵ��</th>
							<td><input type="text" id='scoreValue' value='' readonly="readonly"/></td>
							</tr>
							</table>
							<input type="hidden" id='befBusiid' value=''/>
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
	
    function chkCode(){
		var giftCode = $("#giftCode").val();
		if(giftCode == ""){
			showDialog("�����������",1);
			return ;
		}
		var myPacket = null;
		myPacket = new AJAXPacket("getScoreMoney.jsp","���Ժ�...");
		myPacket.data.add("GIFT_CODE",giftCode);
		myPacket.data.add("PHONE_NO","<%=phoneNo%>");
		core.ajax.sendPacket(myPacket,setCode);
		myPacket =null;

	}
	
	function setCode(packet){
		var RETURN_CODE = packet.data.findValueByName("RETURN_CODE");
		var RETURN_MSG = packet.data.findValueByName("RETURN_MSG");
		var SCORE_MONEY = packet.data.findValueByName("GIFT_MONEY");
		var BEF_BUSIID = packet.data.findValueByName("BUSI_ID");
		 if(trim(RETURN_CODE)!="000000"){
			showDialog(RETURN_MSG,0);
			return false;
		}else{
			var SCORE_VALUE = parseFloat(SCORE_MONEY)*84;
			$("#scoreMoney").val(SCORE_MONEY);
			$("#scoreValue").val(SCORE_VALUE);
			$("#befBusiid").val(BEF_BUSIID);
			$("#btnSubmit").attr("disabled", "");
	 		$("#giftCode").attr("readonly",true);
		} 
	}

	function btnRsSubmit(){
		var giftCode = $("#giftCode").val();
		var scoreMoney = $("#scoreMoney").val();
		var scoreValue = $("#scoreValue").val();
		var befBusiid = $("#befBusiid").val();
		var gPrintInfo = "������:"+giftCode+"����������:"+scoreMoney+"Ԫ�����ͻ���ֵ��"+scoreValue;
		parent.buildScoreValueXml(scoreValue,giftCode,"ZZZX",scoreMoney,befBusiid);
		parent.document.getElementById("H56_show<%=meansId%>").innerHTML = gPrintInfo;
		parent.saveScoreFee(scoreMoney);
		parent.H56_Checkfuc();
		closeDivWin();
	}
	
	function closeWin(){
		closeDivWin();
	}
	</script>
</html>
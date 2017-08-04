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
							和包电子券信息
						</div>
					</div>
					<div class="input">
						<table id='table_score'>
							<tr><th>配置金额</th><th>合计赠送积分值</th><th>是否有码</th><th>串码</th><th>操作</th></tr>
							
							<tr>
								<td><%=scornMoney %></td>
								<td><%=scoreValue %></td>
								<td><select id="gift_type" name="gift_type" onchange="getGiftType();"><option value='0'>请选择</option><option value='1'>有码用户</option><option value='2'>无码用户</option></select></td>
								<td><input  readonly="readonly" id='hid_gift_code' value=''/></td>
								<td><input type="button" class="b_foot" value="确认短信" id="sms_push" name="sms_push" onclick="smsPush()" /></td>
							</tr>
						</table>
					</div>
					<div id="operation_button"><!-- disabled="disabled" -->
						<input type="button" class="b_foot"  disabled="disabled" value="确定" id="btnSubmit"
							name="btnSubmit" onclick="btnRsSubmit()" />
						<input type="button" class="b_foot" value="关闭" id="btnCancel"
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
			showDialog("请选择是否有码选项",1);
			return ;
		}
		if(gift_type == "1"){//有码
			if(hid_gift_code==""||null==hid_gift_code||"N/A"==hid_gift_code){
				showDialog("有码用户请出入串码",1);
				return ;
			}
		}

		var myPacket = null;
		myPacket = new AJAXPacket("wsMktGiftSMSPush.jsp","请稍后...");
		myPacket.data.add("SUM_MONEY","<%=scornMoney %>");
		myPacket.data.add("PHONE_NO","<%=phoneNo%>");
		myPacket.data.add("GIFT_CODE",hid_gift_code);
		myPacket.data.add("OP_FLAG","0");//OP_FLAG操作状标示 0：只下发短信 1：校验执之前是否下发过短信
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
		myPacket = new AJAXPacket("wsMktGiftSMSPush.jsp","请稍后...");
		myPacket.data.add("SUM_MONEY","");
		myPacket.data.add("PHONE_NO","<%=phoneNo%>");
		myPacket.data.add("GIFT_CODE","");
		myPacket.data.add("OP_FLAG","1");//OP_FLAG操作状标示 0：只下发短信 1：校验执之前是否下发过短信
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
			var gPrintInfo = " 赠送积分值："+score_Value;
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
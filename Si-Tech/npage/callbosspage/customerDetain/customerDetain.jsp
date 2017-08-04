<%
  /*
   * 功能: 客户挽留
　 * 版本: 1.0
　 * 日期: 2010/03/16
　 * 作者: tangsong
　 * 版权: sitech
 　*/
%>
 
<%@ page contentType="text/html;charset=gb2312" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<html>
<head>
    <title>客户挽留增加</title>
    <script type="text/javascript">
    	window.onload=function() {
 				getHJLS(); //获取呼叫流水号
 				getKHDS(); //获取客户地市
    		TJWLChange(); //初始业务类型为推介的业务类型
    		sendMsgAble(); //设定发送短信按钮可用或不可用
    	}
    	//获取呼叫流水号
    	function getHJLS() {
    		//测试使用,自定义一个流水号
    		//var contactId = "1324241114546dfaef";
    		
    		<!--tangsong以前写的 var contactId = window.opener.opener.document.getElementById("contactId").value;-->
    		var contactId = "<%=request.getParameter("contactId")%>";
    		if(contactId!='null')
    		{
    		//alert(contactId);
    		document.detainform.HJLS.value = contactId;
    		}
    	}
    	//获取客户地市
    	function getKHDS() {
    		var chkInfoPacket = new AJAXPacket("<%=request.getContextPath()%>/npage/callbosspage/customerDetain/getOptions.jsp","正在更新数据,请稍候...");
    		var selectSql = "SELECT REGION_CODE, REGION_NAME FROM SCALLREGIONCODE";
    		chkInfoPacket.data.add("selectSql", selectSql);
    		chkInfoPacket.data.add("option_value", "REGION_CODE");
    		chkInfoPacket.data.add("option_description", "REGION_NAME");
		    core.ajax.sendPacket(chkInfoPacket, setOptions_KHDS);
				chkInfoPacket = null;
    	}
    	function setOptions_KHDS(packet) {
    		var optionsHtml = packet.data.findValueByName("optionsHtml");
				var selectHtml = "<select name='KHDS' id='KHDS'><option value='-1'>---请选择地市---</option>" + optionsHtml + "</select>";
    		td_KHDS.innerHTML = selectHtml;
    	}
    	//下拉列表联动：推介挽留 --> 业务类型
    	function TJWLChange() {
    		var selectHTML_TJ = "<select name='ZXZT'><option value='1'>办理</option><option value='2' selected='selected'>不办理</option></select>";
    		var selectHTML_WL = "<select name='ZXZT'><option value='1'>成功</option><option value='2' selected='selected'>不成功</option></select>";

    		var typeID = document.detainform.TJWL.value;
    		if (typeID == "1") {
    			td_ZXZT.innerHTML = selectHTML_TJ;
    		} else {
    			td_ZXZT.innerHTML = selectHTML_WL;
    		}
    		
    		var chkInfoPacket = new AJAXPacket("<%=request.getContextPath()%>/npage/callbosspage/customerDetain/getOptions.jsp","正在更新数据,请稍候...");
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
    	//下拉列表联动：业务类型(选择销号挽留) --> 销号原因等
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
    	
    	//获取销号原因
    	function getXHYY() {
    		var chkInfoPacket = new AJAXPacket("<%=request.getContextPath()%>/npage/callbosspage/customerDetain/getOptions.jsp","正在更新数据,请稍候...");
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
    	
    	//提交表单
    	function dosubmit() {
    		var chkInfoPacket = new AJAXPacket("<%=request.getContextPath()%>/npage/callbosspage/customerDetain/customerDetain_do.jsp","正在打开客户挽留增加页面,请稍候...");
    		chkInfoPacket.data.add("HJLS", document.detainform.HJLS.value);
    		chkInfoPacket.data.add("KHDS", document.detainform.KHDS.value);
    		chkInfoPacket.data.add("TJWL", document.detainform.TJWL.value);
    		chkInfoPacket.data.add("YWLX", document.detainform.YWLX.value);
    		chkInfoPacket.data.add("BZ", document.detainform.BZ.value);
    		chkInfoPacket.data.add("DXNR", document.detainform.DXNR.value);
    		
    		if (document.detainform.YWLX.value == "19") {
    			//业务类型为销号挽留时
    			chkInfoPacket.data.add("ZXZT", "");
	    		chkInfoPacket.data.add("XHYY", document.detainform.XHYY.value);
	    		chkInfoPacket.data.add("XHJG", document.detainform.XHJG.value);
	    		chkInfoPacket.data.add("SFDKH", document.detainform.SFDKH.value);
	    		chkInfoPacket.data.add("XFQK", document.detainform.XFQK.value);
    		} else {
    			//业务类型不为销号挽留时
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
    			rdShowMessageDialog('短信内容不能为空！');
    			return;
    		}
    		//测试使用
    		//var user_phone='13679136441';
			//	var user_phone = window.opener.document.getElementById("userPhone").value;
			  var user_phone = "<%=request.getParameter("userPhone")%>";
				var mypacket = new AJAXPacket("<%=request.getContextPath()%>/npage/callbosspage/K083/K083_msgSend_rpc.jsp","正在发送短信，请稍候......");
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
					rdShowMessageDialog("发送成功！", 2);   
				} else if(retCode=="0"){
					rdShowMessageDialog("发送失败！");    
				}
			}
			
    	function submitResult(packet) {
    		var result = packet.data.findValueByName("result");
				if(result=="success"){
					rdShowMessageDialog("提交成功！", 2);
					window.close();
				} else{
					rdShowMessageDialog("提交失败，请检查数据是否合法,备注、发送短信内容等必选字段不能为空！");
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
		<p>客户挽留增加</p>
	</div>
	
	<div id="content">
		<form name="detainform" id="detainform" method="post">
			<table style="font-size:12px">
				<tr>
					<td class="td_key">呼叫流水</td>
					<td><input type="text" name="HJLS" id="HJLS" style="width:152px;" /></td>
				</tr>
				<tr>
					<td class="td_key">客户地市</td>
					<td colspan="2" id="td_KHDS">
						<select name="KHDS" id="KHDS">
							<option value="-1">---请选择地市---</option>
						</select></td>
				</tr>
				<tr>
					<td class="td_key">推介挽留</td>
					<td colspan="2">
						<select name="TJWL" id="TJWL" onchange="TJWLChange()">
							<option value="1">推介</option>
							<option value="2">挽留</option>
						</select>
					</td>
				</tr>
				<tr>
					<td class="td_key">业务类型</td>
					<td colspan="2" id="td_YWLX">
						<select name="YWLX" id="YWLX" onchange="YWLXChange()"></select>
					</td>
				</tr>
				<tr id="tr_1">
					<td class="td_key">执行状态</td>
					<td colspan="2" id="td_ZXZT">
						<select name="ZXZT">
							<option value="1">办理</option>
							<option value="2" selected='selected'>不办理</option>
						</select></td>
				</tr>
				<tr id="tr_2">
						<td class="td_key">销号原因</td>
						<td colspan="2" id="td_ZXZT">
							<span id="span_XHYY">
							<select name="XHYY" id="XHYY"></select>
						</span>
						</td>
				</tr>
				<tr id="tr_3">
						<td class="td_key">销号结果</td>
						<td colspan="2">
							<select name="XHJG">
								<option value="1">成功</option>
								<option value="2">失败</option>
							</select>
						</td>
				</tr>
				<tr id="tr_4">
						<td class="td_key">是否大客户</td>
						<td colspan="2">
						<select name="SFDKH">
							<option value="1">是</option>
							<option value="2">否</option>
						</select>
						<td>
				</tr>
				<tr id="tr_5">
						<td class="td_key">用户消费情况</td>
						<td colspan="2">	
							<select name="XFQK">
								<option value="1">高端</option>
								<option value="2">中端</option>
								<option value="3">低端</option>
							</select>
						</td>
					</tr>
				<tr>
					<td class="td_key">备注</td>
					<td colspan="2">
						<textarea  name="BZ" style="width:70%;height:100px;"></textarea></td>
				</tr>
				<tr>
					<td class="td_key">发送短信内容</td>
					<td style="width:50%">
						<textarea name="DXNR" id="NXNR" style="width:100%;height:100px;"></textarea></td>
					<td style="text-align:left;padding-left:10px;">
						<button id="sendMsgBtn" onclick="sendMsg()" class="b_foot">发送</button></td>
				</tr>
				<tr>
					<td colspan="3" style="padding-left:10px;">
						<input type="button" value="确定" onClick="dosubmit()" class="b_foot"/>
						<input type="reset" value="重置" class="b_foot"/>
					</td>
				</tr>
			</table>
		</form>
	</div>
</body>
</html>
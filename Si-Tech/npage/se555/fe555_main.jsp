<%
  /*
   * 功能: e555·工单流转状态同步管理
   * 版本: 1.0
   * 日期: 20120118
   * 作者: wanghfa
   * 版权: si-tech
  */
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>

<%
	response.setHeader("Pragma","No-Cache"); 
	response.setHeader("Cache-Control","No-Cache");
	response.setDateHeader("Expires", 0); 
	request.setCharacterEncoding("GBK");
	String opCode = "e555";
	String opName = "工单流转状态同步管理";
	String workNo = (String)session.getAttribute("workNo");
	String password = (String)session.getAttribute("password");
	String regionCode = (String)session.getAttribute("regCode");
	
	String opType = request.getParameter("opType");
	String poOrderNumber = request.getParameter("poOrderNumber");
	/*
	String customerNumber = request.getParameter("customerNumber");
	String businessMode = request.getParameter("businessMode");
	String stateType = request.getParameter("stateType");
	String stateTypeText = "";
	*/
	
	String customerNumber = "";
	String poSpecNumber = "";
	String stateType = "";
	String stateTypeText = "";
	String syntime = "";
	String notes = "";
	String businessMode = "";
%>
	<wtc:service name="sStaPOInfoQry" routerKey="region" routerValue="<%=regionCode%>"
			retcode="retCode1" retmsg="retMsg1" outnum="10">
		<wtc:param value="0"/>
		<wtc:param value="01"/>
		<wtc:param value="e555"/>
		<wtc:param value="<%=workNo%>"/>
		<wtc:param value="<%=password%>"/>
		<wtc:param value=""/>
		<wtc:param value=""/>
		<wtc:param value="<%=poOrderNumber%>"/>	<!--商品订单号-->
	</wtc:service>
	<wtc:array id="retArr1" start="0" length="7" scope="end"/>
	<wtc:array id="retArr2" start="7" length="3" scope="end"/>
<%
	if (!"000000".equals(retCode1) || retArr1.length == 0) {
		%>
			<script language="javascript">
				rdShowMessageDialog("查询错误sStaPOListQry：<%=retCode1%>,<%=retMsg1%>.");
				history.go(-1);
			</script>
		<%
		return;
	} else {
		customerNumber = retArr1[0][1];
		poSpecNumber = retArr1[0][2];
		stateType = retArr1[0][3];
		syntime = retArr1[0][4];
		notes = retArr1[0][5];
		businessMode = retArr1[0][6];
		System.out.println("====wanghfa==== retArr2.length = " + retArr2.length);
	}
	
	
	if ("1".equals(stateType)) {
		stateTypeText = "工单已送网络部处理";
	} else if ("2".equals(stateType)) {
		stateTypeText = "网络部工单处理中";
	} else if ("3".equals(stateType)) {
		stateTypeText = "超时电路反馈";
	} else if ("4".equals(stateType)) {
		stateTypeText = "超时电路取消申请";
	} else if ("5".equals(stateType)) {
		stateTypeText = "配合省已分配客户经理配合";
	} else if ("6".equals(stateType)) {
		stateTypeText = "配合省落实情况反馈";
	} else if ("7".equals(stateType)) {
		stateTypeText = "电路拆除结果反馈";
	} else if ("8".equals(stateType)) {
		stateTypeText = "工单已送网络部和国际公司处理";
	} else if ("9".equals(stateType)) {
		stateTypeText = "工单已送绿色通道省和国际公司处理";
	} else if ("10".equals(stateType)) {
		stateTypeText = "已送领导初审";
	} else if ("11".equals(stateType)) {
		stateTypeText = "已送资费管理员审批";
	} else if ("12".equals(stateType)) {
		stateTypeText = "已送配合省确认";
	} else if ("13".equals(stateType)) {
		stateTypeText = "已送配合省开通";
	} else if ("14".equals(stateType)) {
		stateTypeText = "已送领导终审";
	} else if ("15".equals(stateType)) {
		stateTypeText = "网络部一干施工完成";
	}else {
		stateTypeText = "未知状态";
	}
%>


<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>工单流转状态同步管理</title>
<script language="javascript" type="text/javascript" src="json2.js"></script>
<script language="javascript" type="text/javascript" src="fe555_mainScript.js"></script>
<script type=text/javascript>
	var stateSynInfo;
	var productOrderInfos = new Array();
	onload = function() {
		if ("<%=opType%>" == "q") {
			$("#submitBtn").hide();
		} else {
			$("#submitBtn").bind("click", function() {
				cfm();
			});
		}
		
		$("#resppersonMsg_switch").bind('click', function() {
			if (this.state == "open") {
				$("#resppersonMsg").hide();
				$("#resppersonMsg_switch").attr({src: "../../../nresources/default/images/jia.gif"});
				this.state = "close";
			} else if (this.state == "close") {
				$("#resppersonMsg").show();
				$("#resppersonMsg_switch").attr({src: "../../../nresources/default/images/jian.gif"});
				this.state = "open";
			}
		});
		$("#productOrderMsg_switch").bind('click', function() {
			if (this.state == "open") {
				$("#productOrderMsg").hide();
				$("#productOrderMsg_switch").attr({src: "../../../nresources/default/images/jia.gif"});
				this.state = "close";
			} else if (this.state == "close") {
				var getProductOrderPacket = new AJAXPacket("ajax_getProductOrder.jsp","正在获得数据，请稍候......");
				getProductOrderPacket.data.add("poOrderNumber", $("#poOrderNumber").val());
				getProductOrderPacket.data.add("opType", $("#opType").val());
				core.ajax.sendPacketHtml(getProductOrderPacket, doGetProductOrderPacket, true);
				getProductOrderPacket = null;

				$("#productOrderMsg").show();
				$("#productOrderMsg_switch").attr({src: "../../../nresources/default/images/jian.gif"});
				this.state = "open";
			}
		});

		stateSynInfo = new StateSynInfo();
		stateSynInfo.poOrderNumber = "<%=poOrderNumber%>";
		stateSynInfo.stateType = "<%=stateType%>";
		<%
		for (int i = 0; i < retArr2.length; i ++) {
			%>
			stateSynInfo.addRespPerson("<%=retArr2[i][0]%>", "<%=retArr2[i][1]%>", "<%=retArr2[i][2]%>");
			<%
		}
		%>
		stateSynInfo.customerNumber = "<%=customerNumber%>";
		stateSynInfo.poSpecNumber = "<%=poSpecNumber%>";
		stateSynInfo.synTime = "<%=syntime%>";
		stateSynInfo.notes = "<%=notes%>";
		
		if ("<%=opType%>" == "q") {
			unInput("notes");
			unInput("syntime");
			/*unInput("resppersonName");
			unInput("resppersonPhone");
			unInput("resppersonDepartment");*/
		} else if ("<%=opType%>" == "4" || "<%=opType%>" == "5" || "<%=opType%>" == "6") {
			unInput("notes");
			unInput("syntime");
			/*unInput("resppersonName");
			unInput("resppersonPhone");
			unInput("resppersonDepartment");*/
		}
		$("#customerNumber").val("<%=customerNumber%>");
		$("#poSpecNumber").val(stateSynInfo.poSpecNumber);
		$("#opType").val("<%=opType%>");	//非报文节点
		$("#opTypeDis").val("<%=opType%>");	//非报文节点
		$("#poOrderNumber").val(stateSynInfo.poOrderNumber);
		$("#stateType").val(stateSynInfo.stateType);
		$("#stateTypeText").val("<%=stateTypeText%>");	//非报文节点
		$("#syntime").val(stateSynInfo.synTime);
		$("#notes").val(stateSynInfo.notes);
		
		var trTemp;
		for (var a = 0; a < stateSynInfo.respPersons.length; a ++) {
			trTemp = document.getElementById("resppersonMsg").children[0].insertRow();
			trTemp.insertCell().innerHTML = "<input type='text' name='resppersonName' value='" + stateSynInfo.respPersons[a].name + "' class='InputGrey' readOnly>";
			trTemp.insertCell().innerHTML = "<input type='text' name='resppersonPhone' value='" + stateSynInfo.respPersons[a].phone + "' class='InputGrey' readOnly>";
			trTemp.insertCell().innerHTML = "<input type='text' name='resppersonDepartment' value='" + stateSynInfo.respPersons[a].department + "' size='60' class='InputGrey' readOnly>";
		}
	}
	function doGetProductOrderPacket(data) {
		$("#productOrders").empty();
		$("#productOrders").append(data);
		$("tr[name=productOrder]").each(function() {
			//alert(this.p_productId);
		});
	}
	function unInput(eleId){
		$("#"+eleId).attr("class", "InputGrey");
		$("#"+eleId).attr("readOnly", true);
	}
	function productOrderDetail(obj) {
		var productId = obj.innerHTML;
		var productOrderInfo;
		for (var a = 0; a < productOrderInfos.length; a ++) {
			if (productOrderInfos[a].productId == productId) {
				productOrderInfo = productOrderInfos[a];
			}
		}
		
		var retInfo = window.showModalDialog (
			"fe555_productOrderDetail.jsp?businessMode=" + $("#businessMode").val() + "&productId=" + productId + "&opType=<%=opType%>",
			productOrderInfo,
			'dialogHeight:550px; dialogWidth:750px;scrollbars:yes;resizable:no;location:no;status:no'
		);
		
		if (typeof(retInfo) != "undefined") {
			var modifyBool = false;
			for (var a = 0; a < productOrderInfos.length; a ++) {
				if (productOrderInfos[a].productId == retInfo.productId) {
					productOrderInfos[a] = retInfo;
					modifyBool = true;
				}
			}
			if (modifyBool == false) {
				productOrderInfos[productOrderInfos.length] = retInfo;
			}
		}
		var jsonText = JSON.stringify(retInfo, function(key,value){
			return value;
		});
		//alert(jsonText);
	}
	
	function controlBtn(flag) {
		$("#submitBtn").attr("disabled", flag);
		$("#backBtn").attr("disabled", flag);
		$("#closeBtn").attr("disabled", flag);
	}
	function cfm() {
		controlBtn(true);
		if (!check(document.frm)) {
			controlBtn(false);
			return false;
		}
		var checkBool = true;
		
		if ("<%=opType%>" == "4" || "<%=opType%>" == "5" || "<%=opType%>" == "6") {
			var selectNo = 0;
			var findBool;
			$("input[@name=productOrderDetailSelect]:checked").each(function() {
				selectNo ++;
				findBool = false;
				for (var a = 0; a < productOrderInfos.length; a ++) {
					if (productOrderInfos[a].productId == this.value) {
						stateSynInfo.productOrderInfos[stateSynInfo.productOrderInfos.length] = productOrderInfos[a];
						findBool = true;
						
					}
				}
				
				if (!findBool) {
					rdShowMessageDialog("尚未修改订单号为" + this.value + "的产品信息！", 1);
					checkBool = false;
				}
			});
			
			if (selectNo == 0) {
				rdShowMessageDialog("至少选择一个产品信息！", 1);
				checkBool = false;
			}
			
			if (checkBool && rdShowConfirmDialog("确认要提交服务吗？") == 1) {
				var jsonText = JSON.stringify(stateSynInfo);
				$("#jsonText").val(jsonText);
				//alert(jsonText);
				document.frm.action = "fe555_cfm.jsp";
				document.frm.submit();
				return;
			} else {
				controlBtn(false);
				return false;
			}
		} else {
			if (rdShowConfirmDialog("确认要提交服务吗？") == 1) {
				var jsonText = JSON.stringify(stateSynInfo);
				$("#jsonText").val(jsonText);
				//alert(jsonText);
				document.frm.action = "fe555_cfm.jsp";
				document.frm.submit();
				return;
			} else {
				controlBtn(false);
				return false;
			}
		}
	}
	
	function doGetUploadFile(data) {
		//alert(data);
		$("#uploadFileDiv").empty();
		$("#uploadFileDiv").append(data);
	}
</script>

</head>
<body>
<form name="frm" action="" method="post" >
<input type="hidden" name="jsonText" id="jsonText" >
<input type="hidden" name="businessMode" id="businessMode" value="<%=businessMode%>">
<div name="uploadFileDiv" id="uploadFileDiv" >
</div>

<%@ include file="/npage/include/header.jsp" %>
<div class="title">
	<div id="title_zi">工单流转状态基本信息</div>
</div>
<table cellspacing=0>
	<tr>
		<td class="blue" width="20%">EC集团客户编码</td>
		<td width="30%">
			<input name="customerNumber" id="customerNumber" v_type="0_9" v_must="1" maxlength="30" class="InputGrey" readOnly>
		</td>
		<td class="blue" width="20%">操作类型</td>
		<td width="30%">
			<input type="hidden" name="opType" id="opType">
			<select name="opTypeDis" id="opTypeDis" disabled=true>
				<option value="q">工单流程状态查询</option>
				<option value="4">超时电路取消申请</option>
				<option value="5">配合省分配客户经理配合</option>
				<option value="6">配合省落实情况反馈</option>
			</select>
		</td>
	</tr>
	<tr>
		<td class="blue" width="20%">商品订单号</td>
		<td width="30%">
			<input name="poOrderNumber" id="poOrderNumber" v_type="string" size="20" v_must="1" maxlength="16" v_maxlength="16" class="InputGrey" readOnly>
		</td>
		<td class="blue" width="20%">商品规格编码</td>
		<td width="30%">
			<input name="poSpecNumber" id="poSpecNumber" class="InputGrey" readOnly>
		</td>
	</tr>
	<tr>
		<td class="blue" width="20%">当前状态</td>
		<td width="30%">
			<input name="stateTypeText" id="stateTypeText" size="40" class="InputGrey" readOnly>
			<input type="hidden" name="stateType" id="stateType">
		</td>
		<td class="blue" width="20%">状态同步时间</td>
		<td width="30%">
			<input name="syntime" id="syntime" size="16" v_must="1" maxlength="14" v_maxlength="14">
		</td>
	</tr>
	<tr>
		<td class="blue" width="20%">备注</td>
		<td colspan="3">
			<input name="notes" id="notes" size="40" maxlength="1000" v_maxlength="1000">
		</td>
	</tr>
</table>
<br/>
<div class="title">
	<div id="title_zi">
		当前状态负责人信息
		<img id="resppersonMsg_switch" state="open" src="../../../nresources/default/images/jian.gif" style='cursor:hand' width="15" height="15">
	</div>
</div>
<div name="resppersonMsg" id="resppersonMsg">
	<table>
		<tr>
			<th width="20%">当前状态负责人</th>
			<th width="20%">电话</th>
			<th width="60%">所在单位及部门</th>
		</tr>
	</table>
</div>
<br/>
<div class="title">
	<div id="title_zi">
		产品信息列表
		<img id="productOrderMsg_switch" state="close" src="../../../nresources/default/images/jia.gif" style='cursor:hand' width="15" height="15">
	</div>
</div>
<div name="productOrderMsg" id="productOrderMsg" style="display:none">
	<table>
		<tr>
			<th width="10%">选择</th>
			<th width="30%">产品订单号</th>
			<th width="20%">电路代号</th>
			<th width="20%">所处状态完成结果</th>
			<!--th width="10%">所处状态原因描述</th-->
			<th width="20%">客户联系人</th>
			<!--th width="10%">客户联系方式</th-->
			<!--th width="10%">完成或者预计完成此状态的时间</th-->
		</tr>
		<tbody id="productOrders" name="productOrders"></tbody>
	</table>
</div>
<table>
	<tr>
		<td colspan="4" align="center" id="footer">
			<input class="b_foot" type=button name="submitBtn" id="submitBtn" value="确定">
			<input class="b_foot" type=button name="backBtn" id="backBtn" value="返回" onclick="window.location='fe555.jsp'">
			<input class="b_foot" type=button name="closeBtn" id="closeBtn" value="关闭" onclick="removeCurrentTab();">
		</td>
	</tr>
</table>
<%@ include file="/npage/include/footer.jsp" %>
</form>
</body>
</html>
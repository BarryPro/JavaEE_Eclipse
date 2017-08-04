<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%
/********************
 version v3.0
开发商: si-tech
********************/
%>
<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ include file="../../npage/bill/getMaxAccept.jsp" %>
<%
		response.setHeader("Pragma","No-Cache"); 
		response.setHeader("Cache-Control","No-Cache");
		response.setDateHeader("Expires", 0); 
		String regionCode= (String)session.getAttribute("regCode");
 		String work_no = (String)session.getAttribute("workNo");
 		String password = (String)session.getAttribute("password");
		String opCode = request.getParameter("opCode");
 		String opName = request.getParameter("opName");
 		String operPhoneNo = request.getParameter("parentPhone");
 		String familyCode = request.getParameter("familyCode");
 		String familyName = request.getParameter("familyName");
 		String backAccept = request.getParameter("backAccept");
 		String belongGroupId = request.getParameter("belongGroupId");
 		String cccTime=new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss", Locale.getDefault()).format(new java.util.Date());
 		String printName = "";
 		System.out.println("------------liujian---------------familyCode=" + familyCode);
 		System.out.println("------------liujian---------------familyName=" + familyName);
 		System.out.println("------------liujian---------------opCode=" + opCode);
 		if("e283".equals(opCode)){
 			printName = "幸福家庭成员业务退订";
 		}else if("e284".equals(opCode)){
 			printName = "幸福家庭业务退订";
 		}else if("e285".equals(opCode)){
 			printName = "幸福家庭签约送礼冲正";
 		}
 		
 		String tableTitleStr = "";
 		if("e875".equals(opCode)){
 			tableTitleStr = "需要订购可选资费";
 		}else if("e880".equals(opCode)){
 			tableTitleStr = "需要退订资费";
 		}else if("e881".equals(opCode)){
 			tableTitleStr = "需要冲正资费";
 		}
 		
 		String printAccept="";
%>
	<wtc:sequence name="TlsPubSelCrm" key="sMaxSysAccept" routerKey="region" 
		 routerValue="<%=regionCode%>"  id="seq"/>
<%
		printAccept = seq;
%>
		<wtc:service name="sFamSelCheck" routerKey="region" routerValue="<%=regionCode%>" 
			retmsg="msg0" retcode="code0" outnum="7">
			<wtc:param value="<%=printAccept%>"/>
			<wtc:param value="01"/>
			<wtc:param value="<%=opCode%>"/>
			<wtc:param value="<%=work_no%>"/>
			<wtc:param value="<%=password%>"/>
			<wtc:param value="<%=operPhoneNo%>"/>
			<wtc:param value=""/>
			<wtc:param value="2"/>
			<wtc:param value="<%=familyCode%>"/>
		</wtc:service>
		<wtc:array id="result0" scope="end" />
<%
	if(!code0.equals("000000")){
		System.out.println("----- fe280Quir.jsp ---- 查询出错" + code0 + msg0);
%>
			<script language="JavaScript">
				rdShowMessageDialog("没有查询到家庭角色信息" + "<%=code0%>" + "<%=msg0%>");
				window.location="fe280.jsp?activePhone=<%=operPhoneNo%>";
			</script>
<%
	}
	String[][] familyMemberList = new String[][]{};
	String prodCode = "";
	String parentPhone ="";
	String parentCustName = "";
	String parentMembRoleId = "";
	boolean selfFlag = true;
%>
		<wtc:service name="sFamSelCheck" routerKey="region" routerValue="<%=regionCode%>" 
			retmsg="msg1" retcode="code1" outnum="15">
			<wtc:param value="<%=printAccept%>"/>
			<wtc:param value="01"/>
			<wtc:param value="<%=opCode%>"/>
			<wtc:param value="<%=work_no%>"/>
			<wtc:param value="<%=password%>"/>
			<wtc:param value="<%=operPhoneNo%>"/>
			<wtc:param value=""/>
			<wtc:param value="3"/>
			<wtc:param value="<%=familyCode%>"/>
		</wtc:service>
		<wtc:array id="result1" scope="end" />
<%
		System.out.println("========== ningtn ====" + code1 + " | " + result1.length);
		String mainOfferName = "";
		String mainOfferComments = "";
		for(int i = 0; i < result1.length; i++){
			if("M".equals(result1[i][1])){
				mainOfferName = result1[i][13];
				mainOfferComments = result1[i][14];
			}
		}
		if("000000".equals(code1)){
			familyMemberList = result1;
			for(int i = 0; i < familyMemberList.length; i++){
				if(familyMemberList[i][1].equals("M")){
					prodCode = familyMemberList[i][8];
					parentPhone = familyMemberList[i][3];
					parentCustName = familyMemberList[i][9];
					parentMembRoleId = familyMemberList[i][0];
				}
			}
			if(parentPhone.equals(operPhoneNo)){
				selfFlag = true;
			}else{
				selfFlag = false;
			}
		}else{
%>
			<script language="JavaScript">
				rdShowMessageDialog("没有查询到家庭角色信息" + "<%=code1%>" + "<%=msg1%>");
				window.location="fe280.jsp?activePhone=<%=operPhoneNo%>";
			</script>
<%
		}
%>
<html>
<head>
	<title>家庭产品变更</title>
	<script language="javascript" type="text/javascript" src="json2.js"></script>
	<script language="javascript" type="text/javascript" src="fe280PubScript.js"></script>
	<script language="javascript">
		
		var familyRoleList = new FamRoleList();
	//	var famOffer = new FamOffer();
		var famBusiArray = new Array();
		var hideArr = new Array();
		function nextStep(subButton){
			if("<%=opCode%>" == "e284"){
				if(!checkElement(document.form1.machFee)){
					return false;
				}	
			}
			/* 按钮延迟 */
			controlButt(subButton);
			/* 事后提醒 */
			getAfterPrompt();
			
			/* 拼装报文 */
			setJSONText();
			getPrintInfo();
			/* 打印免填单&提交页面 */
			printCommit('<%=opCode%>');
		}
		
		function getPrintInfo(){
				/**********
				获取免填单打印信息
				包括资费名称和资费描述
				调用服务sFamSelCheck，其中
				7   查询类型         iQryType 传 7 
				9   产品代码         iProdCode必须传
				*/
			var famProdInfoObj = $("#familyProdInfo");
			var getdataPacket = new AJAXPacket("fe280PubGetMsg.jsp","正在获得数据，请稍候......");
			getdataPacket.data.add("opCode","<%=opCode%>");
			getdataPacket.data.add("phoneNo","<%=parentPhone%>");
			getdataPacket.data.add("famCode","<%=familyCode%>");
			getdataPacket.data.add("prodCode",famProdInfoObj.val());
			getdataPacket.data.add("outNum","3");
	      <%if("e875".equals(opCode) ||"e880".equals(opCode) || "e881".equals(opCode)){ %>
			getdataPacket.data.add("queryType","8");
	      <%} else {%>
	        getdataPacket.data.add("queryType","7");
	      <%}%>
			core.ajax.sendPacket(getdataPacket,doPrintInfoBack);
			getdataPacket = null;
		}
		function doPrintInfoBack(packet){
			var retCode = packet.data.findValueByName("retcode");
			var retMsg = packet.data.findValueByName("retmsg");
			var result = packet.data.findValueByName("result");
			if(retCode == "000000"){
				$("#pubPrtOfferId").val(result[0][0]);
				$("#pubPrtOfferName").val(result[0][1]);
				$("#pubPrtOfferComments").val(result[0][2]);
			}
		}
		
		function getNote(){
			var returnStr = "";
			var opCode = "<%=opCode%>";
			var roleObj;
			
			if(opCode == "e875"){
				returnStr += "1、客户必须先办理亲情网，才可以办理无限畅打。" + "|";
				returnStr += "2、客户办理业务当月生效。" + "|";
				returnStr += "3、客户取消业务下月生效。" + "|";
				returnStr += "4、加入无限畅打的费用由无限畅打申请人的承担。" + "|";
				returnStr += "5、组建人取消无限畅打业务后，所有成员不再享受业务优惠。" + "|";
			}else if(opCode == "e880"){
				returnStr += "1、移动手机号码退订无限畅打套餐后，自次月起将不再享受无限畅打业务优惠资费。" + "|";
				returnStr += "2、组建人取消无限畅打业务后，组内无限畅打业务不再享受优惠。" + "|";
			}else if(opCode == "e881") {
				returnStr += "" + "|";
			}
			
			return returnStr;
		}
		function goBack(){
			location="fe280.jsp?activePhone=<%=operPhoneNo%>";
		}
		function deleteMember(rownum,checkObj){
			/* 这里要调用公共校验函数 */
			
			
			var selectedMembRoleId = $("#memberRoleId_" + rownum).val();
			var addFlag = 0;
			if($(checkObj).attr("checked") == undefined){
				addFlag = 1;
			}else{
				addFlag = -1;
			}
			setSelectedNum(selectedMembRoleId,addFlag);
			ctrlfamilyMemberList();
			ctrlConfirmBtn();
		}
		
		function ctrlfamilyMemberList(){
			/* 当某个成员已添加数量等于角色最小数时，删除选项置灰 */
			var resule0Obj = $("input[id^='memRoleId_']");
			$.each(resule0Obj,function(i,n){
				//var unselectedNum = getunselectedMemNum(n.value);
				//var rownum = n.id.substr(10,11);
				//$("#familyRoleTab tr:eq(" + ( i + 1 ) + ") td:eq(3)").html();
				/*获取配置的家庭成员数量最小值*/
				var membMinNum = $("#familyRoleTab tr:eq("+(i + 1)+") td:eq(2)").html().trim();
				/* 获取家庭成员数量 */
				var membNum = $("#familyRoleTab tr:eq("+(i + 1)+") td:eq(3)").html().trim();
				if(membMinNum == membNum){
					setDisableByMembId(n.value,0);
				}else{
					setDisableByMembId(n.value,1);
				}
			});
		}
		function ctrlConfirmBtn(){
			var checkObj = $("input[name='delMember']");
			/* 可用标识 false不可用    true可用 */
			var availableFlag = false;
			$.each(checkObj,function(i,n){
				if($(n).attr("checked") != undefined){
					availableFlag = true;
				}
			});
			if(availableFlag){
				$("#confirm").removeAttr("disabled");
			}else{
				$("#confirm").attr("disabled","true");
			}
		}
		function getunselectedMemNum(memberRoleId){
			/* 根据memberRoleId获取没有选中的成员数量，即家庭中存在成员数量 */
			var returnNum = 0;
			var memberListObj = $("input[id^='memberRoleId_'][value='" + memberRoleId + "']");
			$.each(memberListObj,function(i,n){
				var rownum = n.name.substr(13,14);
				var delmemberStr = "#delMember_" + rownum;
				if($(delmemberStr).attr("checked") == undefined){
					returnNum++;
				}
			});
			return returnNum;
		}
		function setDisableByMembId(memberRoleId , styleFlag){
			/* 根据memberRoleId把未选中行置成可用不可用
					styleFlag 1 可用   0 不可用
			*/
			var delMemberObj = $("input[name='delMember'][value='" + memberRoleId + "']");
			$.each(delMemberObj,function(i,n){
				if($(n).attr("checked") == undefined){
					if(styleFlag == "0"){
						$(n).attr("disabled","true");
					}else if(styleFlag == "1"){
						$(n).removeAttr("disabled");
					}
				}
			});
		}
		function setSelectedNum(memberRoleId,addFlag){
			/* 根据memberRoleId 调整已添加数量
					addFlag  1 加1	-1  减1
			 */
			/* 获取所在行号 */
			var resule0Obj = $("input[id^='memRoleId_']");
			var rowNum = 0;
			$.each(resule0Obj,function(i,n){
				if(n.value == memberRoleId){
					rowNum = n.id.substr(10,11);
					var tdObj = $("#familyRoleTab tr:eq(" + ( i + 1 ) + ") td:eq(3)");
					var nowNum = tdObj.html();
					var resultNum = parseInt(nowNum) + parseInt(addFlag);
					tdObj.html("" + resultNum);
				}
			});
		}
		function setJSONText(){
			
			familyRoleList = new FamRoleList();
			
			familyRoleList.setCreate_accept("<%=printAccept%>");
			familyRoleList.setBack_accept("<%=backAccept%>");
			familyRoleList.setChnsource("01");
			familyRoleList.setopCode("<%=opCode%>");
			familyRoleList.setLoginNo("<%=work_no%>");
			familyRoleList.setPassword("<%=password%>");
			familyRoleList.setPhone_no_master("<%=parentPhone%>")
			familyRoleList.setOp_note("<%=work_no%>" + "做" + "<%=opName%>" + "操作");
			familyRoleList.setProd_code($("#familyProdInfo").val());
			familyRoleList.setFamily_code("<%=familyCode%>");
			
			var checkObj = $("input[name='delMember']");
			var famRole = new FamRole();
			var business = new Business();
			var rowNum = "";
			$.each(checkObj,function(i,n){
				if($(n).attr("checked") != undefined){
					rowNum = n.id.substr(10,11);
					var memberRoleIdVal = $("#memberRoleId_"+rowNum).val();
					var phoneNoVal = $("#phoneNo_"+rowNum).val();
					var familyRoleVal = $("#familyRole_"+rowNum).val();
					var memberRoleNameVal = $("#memberRoleName_"+rowNum).val();
					var payTypeVal = $("#payType_"+rowNum).val();
					
					if(!strInArr(phoneNoVal,hideArr)){
						famRole = new FamRole();
						famRole.setPhone(phoneNoVal);
						famRole.setRoleId(familyRoleVal);
						famRole.setRoleName(memberRoleNameVal);
						famRole.setMembId(memberRoleIdVal);
						famRole.setPay_type(payTypeVal);
						/* 在这里需要拼接business对象 */
						famRole = createBusiness(famRole,phoneNoVal,memberRoleIdVal,familyRoleVal,payTypeVal);
						
						familyRoleList.addFamRole(famRole);
					}
				}
			});
			familyRoleList.setPay_money($("#prepayFeeHide").val());
			var myJSONText = JSON.stringify(familyRoleList,function(key,value){
				return value;
				});
			//alert(myJSONText);
			$("#myJSONText").val(myJSONText);
		}
		
		function createBusiness(famRole,phoneNo,memberRoleId,familyRole,payType){
			var business = new Business();
			for(var i = 0; i < famBusiArray.length; i++){
				if("<%=opCode%>" == "e283" && i == (famBusiArray.length-1)) {
					$("#minorOfferName").val(famBusiArray[i][9]);
					$("#minorOfferComment").val(famBusiArray[i][10]);
				}
				if(famBusiArray[i][3] == phoneNo){
					business = new Business();
					business.setBusitype(famBusiArray[i][6]);
					business.setBusinessId(famBusiArray[i][5]);
					business.setOper("07");
					if("<%=opCode%>" == "e284" && famBusiArray[i][0] == "70001"){
						$("#prepayFeeHide").val($("#machFee").val());
						business.setMach_fee($("#machFee").val());
					}
					/*liujian add*/
				
					
					/*liujian 注释结束*/
					if("<%=opCode%>" == "e285" && memberRoleId == "70001"){
						/* 查询一下预存款金额，冲正时打印发票用 */
						var msgPacket = new AJAXPacket("getPrepayFee.jsp","正在获取数据，请稍候......");
						msgPacket.data.add("phoneNo","<%=operPhoneNo%>");
						msgPacket.data.add("opCode","<%=opCode%>");
						msgPacket.data.add("backAccept","<%=backAccept%>");
						msgPacket.data.add("famCode",familyRole);
						msgPacket.data.add("memRoleId",memberRoleId);
						core.ajax.sendPacket(msgPacket, doSetPrepayfee);
					}
					famRole.addBusiness(business);
				}
			}
			return famRole;
		}
		function doSetPrepayfee(packet){
			var retcode = packet.data.findValueByName("retcode");
			var prepayFee = packet.data.findValueByName("prepayFee");
			$("#homeEasyHide").val("1");
			$("#prepayFeeHide").val(prepayFee);
		}
		function doPubGetInfoBack(packet){
			var retCode = packet.data.findValueByName("retcode");
			var retMsg = packet.data.findValueByName("retmsg");
			var custName = packet.data.findValueByName("custName");
			var smName = packet.data.findValueByName("smName");
			var offerName = packet.data.findValueByName("offerName"); //指定资费名称
			var offerComment = packet.data.findValueByName("offerComment"); //指定资费描述
			
			$("#smName").val(smName);
			$("#custName").val(custName);
			/*liujian  注释开始*/
			/*
			if("<%=opCode%>" != "e283"){
				$("#mainOfferComment").val(offerComment);
			}*/
			/*liujian  注释结束*/
		}
		function getFamBusiMsg(){
			var msgPacket = new AJAXPacket("fe280PubGetMsg.jsp","正在获取数据，请稍候......");
			msgPacket.data.add("phoneNo","<%=parentPhone%>");
			msgPacket.data.add("opCode","<%=opCode%>");
			msgPacket.data.add("prodCode","<%=prodCode%>");
			msgPacket.data.add("memRoleId","<%=parentMembRoleId%>");
			msgPacket.data.add("queryType","5");
			msgPacket.data.add("famCode","<%=familyCode%>");
			msgPacket.data.add("outNum","11");
			core.ajax.sendPacket(msgPacket, doFamBusiMsgBack);
		}
		function doFamBusiMsgBack(packet){
			var retCode = packet.data.findValueByName("retcode");
			var retMsg = packet.data.findValueByName("retmsg");
			var result = packet.data.findValueByName("result");
			if(retCode != "000000"){
				rdShowMessageDialog("没有查询到家庭角色业务信息" + retCode + retMsg);
				window.location="fe280.jsp?activePhone=<%=operPhoneNo%>";
			}else{
				famBusiArray = result;
			}
		}
		function setLastTDHide(){
			/* 藏起来一列 */
			$("#familyMemberList tr").each(function(){
				$(this).find("th:eq(6)").hide();
				$(this).find("td:eq(6)").hide();
			});
			var checkObj = $("input[name='delMember']");
			$.each(checkObj,function(i,n){
				$(n).attr("checked","true");
			});
			$("#confirm").removeAttr("disabled");
		}
		$(document).ready(function(){
			
			var prodCode = "<%=prodCode%>";
			$("#familyProdInfo option[value='" + prodCode + "']").attr("selected","selected");
			$("#familyProdInfo").attr("disabled","true")
			
			ctrlfamilyMemberList();
			getFamBusiMsg();
			var opCodeVal = "<%=opCode%>";
			if(opCodeVal == "e284"){
				setLastTDHide();
				$("#machFeeTab").show();
			}
			if(opCodeVal == "e875" || opCodeVal == "e880" || opCodeVal == "e881"){
				setLastTDHide();
			}
			
			var getdataPacket = new AJAXPacket("pubGetCustInfo.jsp","正在获得数据，请稍候......");
			getdataPacket.data.add("phoneNo","<%=operPhoneNo%>");
			core.ajax.sendPacket(getdataPacket,doPubGetInfoBack,true);
			getdataPacket = null;
			
			//liuijan add 已经推出的成员不可以再次被选择
			$('.delete_memeber_70004_1').attr("disabled","true");
			setExpMemberHide();
		});
		
		function setExpMemberHide(){
			/***将失效时间不等于家长失效时间的成员资费代码、资费名称隐藏*/
			var parentExpDate = "";
			var parentRowNum = 0;
			$.each($("input[id^='familyRole_']"),function(i,n){
				if($(this).val() == "M"){
					parentRowNum = i;
				}
			});
			parentExpDate = $("#expDate_"+parentRowNum).text();
			$.each($("#familyMemberList tr:gt(0)"),function(i,n){
				if($(this).find("td:eq(5)").text() != parentExpDate){
					$(this).find("td:gt(6)").empty();
					hideArr[hideArr.length] = $(this).find("td:eq(2)").text();
				}
			});
		}
		
		function strInArr(str,arr){
			var inFlag = false;
			$.each(arr,function(i,n){
				if(str == n){
					inFlag = true;
				}
			});
			return inFlag;
		}
	</script>
</head>
<body>
<form action="" method="post" name="form1">
		<%@ include file="/npage/include/header.jsp" %>
	<div class="title">
		<div id="title_zi">家庭产品变更</div>
	</div>
	<table cellspacing="0">
		<tr>
			<td class="blue">家庭产品信息</td>
			<td>
				<select id="familyProdInfo" name="familyProdInfo" onchange="changeProd()">
					<option value ="">--请选择--</option>
					<wtc:qoption name="TlsPubSelCrm" outnum="2">
						<wtc:sql>
							SELECT prod_code, prod_name
							  FROM sfamilyprodinfo
							 WHERE family_code = '?' AND GROUP_ID = '?'
						</wtc:sql>
						<wtc:param value="<%=familyCode%>"/>
						<wtc:param value="<%=belongGroupId%>"/>
					</wtc:qoption>
				</select>
			</td>
		</tr>
	</table>
	<div class="title">
		<div id="title_zi">家庭现有成员列表</div>
	</div>
	<table cellspacing="0" id="familyRoleTab">
		<tr>
			<th>角色名称</th>
			<th>角色最大数量</th>
			<th>角色最小数量</th>
			<th>已添加数量</th>
			<th>付费方式</th>
		</tr>
		<%
			for(int i = 0; i < result0.length; i++){
		%>
		<tr>
			<input type="hidden" id="memRoleId_<%=i%>" value="<%=result0[i][0]%>" />
			<td><%=result0[i][2]%></td>
			<td><%=result0[i][3]%></td>
			<td><%=result0[i][4]%></td>
			<td>
				<%=result0[i][6]%>
			</td>
			<td><%=result0[i][5]%></td>
		</tr>
		<%
			}
		%>
	</table>
	<div class="title">
		<div id="title_zi">家庭现有成员列表</div>
	</div>
	<table id="familyMemberList">
		<tr>
			<th>家庭代码</th>
			<th>家庭名称</th>
			<th>手机号码</th>
			<th>角色名称</th>
			<th>生效时间</th>
			<th>失效时间</th>
			<th>操作</th>
			<th><%=tableTitleStr%></th>
		</tr>
		<%
			for(int i = 0; i < familyMemberList.length; i++){
				if(selfFlag || familyMemberList[i][3].equals(operPhoneNo)){
		%>
		<tr id="row_0">
			<input type="hidden" name="memberRoleId_<%=i%>" id="memberRoleId_<%=i%>" value="<%=familyMemberList[i][0]%>"/>
			<input type="hidden" name="phoneNo_<%=i%>" id="phoneNo_<%=i%>" value="<%=familyMemberList[i][3]%>"/>
			<input type="hidden" id="familyRole_<%=i%>" name="familyRole_<%=i%>" value="<%=familyMemberList[i][1]%>" />
			<input type="hidden" id="memberRoleName_<%=i%>" name="memberRoleName_<%=i%>" value="<%=familyMemberList[i][2]%>" />
			<input type="hidden" id="payType_<%=i%>" name="payType_<%=i%>" value="<%=familyMemberList[i][6]%>" />
			<td width="10%"><%=familyCode%></td>
			<td><%=familyName%></td>
			<td><%=familyMemberList[i][3]%></td>
			<td><%=familyMemberList[i][2]%></td>
			<td><%=familyMemberList[i][4]%></td>
			<td><span id="expDate_<%=i%>"><%=familyMemberList[i][5]%></span></td>
			<td>
				<input type="checkbox" name="delMember" id="delMember_<%=i%>" class="delete_memeber_<%=familyMemberList[i][0]%>_<%=familyMemberList[i][10]%>"
				  onclick="deleteMember(<%=i%>,this)" value="<%=familyMemberList[i][0]%>" />
			</td>
			<td>
				<input type="checkbox" checked="checked" disabled />
				<span id="memberRoleOfferId_<%=i%>"><%=familyMemberList[i][12]%><span>
					-
				<%=familyMemberList[i][13]%>
				<input type="hidden" value="<%=familyMemberList[i][14]%>" />
			</td>
		</tr>
		<%
				}
			}
		%>
	</table>
	<table id="machFeeTab" style="display:none;">
		<tr>
			<td class="blue" width="10%">补收款</td>
			<td>
				<input type="text" id="machFee" name="machFee" v_type="money" v_must="1" />
				<font class="orange">*</font>
			</td>
		</tr>
	</table>
	<input type="hidden" name="opCode" id="opCode" value="<%=opCode%>" />
	<input type="hidden" name="opName" id="opName" value="<%=opName%>" />
	<input type="hidden" id="myJSONText" name="myJSONText" />
	<input type="hidden" id="printAccept" name="printAccept" value="<%=printAccept%>" />
	<input type="hidden" id="parentPhone" name="parentPhone" value="<%=parentPhone%>" />
	<input type="hidden" id="parentCustName" name="parentCustName" value="<%=parentCustName%>" />
	<input type="hidden" id="operPhoneNo" name="operPhoneNo" value="<%=operPhoneNo%>" />
	<input type="hidden" name="checkFlag" id="checkFlag" />
	<input type="hidden" name="custName" id="custName" />
	<input type="hidden" name="homeEasyHide" id="homeEasyHide" value="0" />
	<input type="hidden" name="brandAndResHide" id="brandAndResHide" />
	<input type="hidden" name="homeEasyPhoneHide" id="homeEasyPhoneHide" />
	<input type="hidden" name="imeiHide" id="imeiHide" />
	<input type="hidden" name="prepayFeeHide" id="prepayFeeHide" />
	<input type="hidden" name="reqContextPath" id="reqContextPath" value="<%=request.getContextPath()%>" />
	<input type="hidden" name="mainOfferComment" id="mainOfferComment" value="<%=mainOfferComments%>" />
	<input type="hidden" name="minorOfferComment" id="minorOfferComment" value="" />
	<input type="hidden" name="familyName" id="familyName" value="<%=familyName%>" />
	<input type="hidden" name="smName" id="smName" />
	<input type="hidden" name="printName" id="printName" value="<%=printName%>" />
	<input type="hidden" name="cccTime" id="cccTime" value="<%=cccTime%>" />
	<input type="hidden" name="mainOfferName" id="mainOfferName" value="<%=mainOfferName%>" />
	<input type="hidden" name="minorOfferName" id="minorOfferName" value="" />
	<input type="hidden" name="pubPrtOfferId" id="pubPrtOfferId" value="" />
	<input type="hidden" name="pubPrtOfferName" id="pubPrtOfferName" value="" />
	<input type="hidden" name="pubPrtOfferComments" id="pubPrtOfferComments" value="" />
	<table>
		<tr > 
			<td id="footer"> <div align="center"> 
			<input name="confirm" id="confirm" type="button" class="b_foot" 
			 value="确认" onClick="nextStep(this)" disabled />
			&nbsp; 
			<input name="reset" type="reset" class="b_foot" value="清除" />
			&nbsp; 
			<input name="reset" type="button" class="b_foot" value="返回" onclick="goBack()" />
			&nbsp; 
			<input name="back" onClick="removeCurrentTab();" type="button" class="b_foot" value="关闭" />
			&nbsp; </div>
			</td>
		</tr>
	</table>
	<%@ include file="/npage/include/footer.jsp" %> 
</form>
<%@ include file="/npage/include/pubLightBox.jsp" %>
</body>
</html>

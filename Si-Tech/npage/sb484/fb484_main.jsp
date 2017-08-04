<%
    /********************
     version v2.0
     开发商: si-tech
     *
     *create:wanghfa@2010-9-6 TD固话重新购机
     *
     ********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<%@ page contentType="text/html; charset=GB2312" %>
<%@ include file="/npage/include/public_title_name.jsp" %>

<html>
<head>
<title>TD固话重新购机</title>
<META content="MSHTML 5.00.3315.2870" name=GENERATOR>
<%
	String opCode = WtcUtil.repStr(request.getParameter("opCode"), "");
	String opName = WtcUtil.repStr(request.getParameter("opName"), "");
	System.out.println("===wanghfa===" + opCode + opName);
	String regionCode = (String)session.getAttribute("regCode");
	String workNo = (String)session.getAttribute("workNo");
	String noPass = (String)session.getAttribute("password");
	String groupId =(String)session.getAttribute("groupId");
	
	String result[][] = new String[1][38];
	String saleType = "";
	String oldOpCode = "";
	
%>
	<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="phone" routerValue="<%=activePhone%>" id="loginAccept"/>
	
	<wtc:service name="sB484Qry" routerKey="phone" routerValue="<%=activePhone%>" retcode="retCode1" retmsg="retMsg1" outnum="38">			
		<wtc:param value="<%=loginAccept%>"/>
		<wtc:param value="<%=opCode%>"/>
		<wtc:param value="<%=workNo%>"/>
		<wtc:param value="<%=activePhone%>"/>
		<wtc:param value="01"/>
		<wtc:param value="<%=noPass%>"/>
		<wtc:param value=""/>
	</wtc:service>
	<wtc:array id="result1"  scope="end"/>
<%
	System.out.println("==========wanghfa==================== sB484Qry " + retCode1 + "," + retMsg1);
	if (!(retCode1.equals("000000") && result1.length > 0)) {
%>
		<script language="JavaScript">
			rdShowMessageDialog("sB484Qry：<%=retCode1%><%=retMsg1%>", 0);	//0是X,1是!,2是对号
			history.go(-1);
		</script>
<%
	} else {
		for (int i = 0; i < result1[0].length; i ++) {
			System.out.println("==========wanghfa==================== result[0]["+i+"] = " + result1[0][i]);
			result[0][i] = result1[0][i];
		}
		saleType = result[0][29];
		oldOpCode = result[0][30];
		//oldOpCode = "7671";	//测试用
	}
%>

<script language=javascript>
	window.onload = function() {
		changeOp();
	}
	
	function changeOp() {
		document.getElementById("submitB").disabled = true;
		getBrandCodeInfo();
	}
	
	//检查IMEI码
	function checkImeiCode() {
		var imeiCodeObj = document.getElementById("imeiCode");
		
		if (imeiCodeObj.value.length == 0) {
			rdShowMessageDialog("IMEI码不能为空，请重新输入。", 1);
			imeiCodeObj.focus();
			return;
		}
		
		var checkImeiPacket = new AJAXPacket("/npage/s1141/queryimei.jsp", "正在校验IMEI信息，请稍候......");
		
		checkImeiPacket.data.add("imei_no", document.getElementById("imeiCode").value);
		checkImeiPacket.data.add("brand_code", document.getElementById("brandCode").options[document.getElementById("brandCode").selectedIndex].value);
		checkImeiPacket.data.add("style_code", document.getElementById("phoneType").options[document.getElementById("phoneType").selectedIndex].value);
		checkImeiPacket.data.add("opcode", "<%=opCode%>");
		checkImeiPacket.data.add("retType","0");
		
		core.ajax.sendPacket(checkImeiPacket, doCheckImeiCode);
		checkImeiPacket=null;
	}
	
	function doCheckImeiCode(packet) {
		var retType=packet.data.findValueByName("retType");
		var retResult=packet.data.findValueByName("retResult");
		
		if(retResult == "000000"){
			rdShowMessageDialog("IMEI号校验成功！", 2);
			document.getElementById("imeiCodeT").value = document.getElementById("imeiCode").value;
			document.getElementById("submitB").disabled = false;
			
			document.getElementById("brandCode").disabled = true;
			document.getElementById("phoneType").disabled = true;
			document.getElementById("saleCode").disabled = true;
			
			document.getElementById("imeiCode").disabled = true;
			document.getElementById("checkIcBtn").disabled = true;
			document.getElementById("changeIcBtn").style.display = "";
			
			
			return;
		} else if (retResult == "000003") {
			rdShowMessageDialog("IMEI号不在营业员归属营业厅或IMEI号与业务办理机型不符！", 1);
			document.getElementById("submitB").disabled = true;
			return;
		} else {
			rdShowMessageDialog("IMEI号不存在或者已经使用！", 1);
			document.getElementById("submitB").disabled = true;
			return;
		}
	}
	
	function changeImeiCode() {
		document.getElementById("submitB").disabled = true;
		
		document.getElementById("brandCode").disabled = false;
		document.getElementById("phoneType").disabled = false;
		document.getElementById("saleCode").disabled = false;
		
		document.getElementById("imeiCode").disabled = false;
		document.getElementById("checkIcBtn").disabled = false;
		document.getElementById("changeIcBtn").style.display = "none";
	}
	
	//获取手机品牌信息
	function getBrandCodeInfo() {
		var getBcInfoPacket = new AJAXPacket("fb484_ajaxGetBrandCodeInfo.jsp", "正在获取手机品牌信息，请稍候......");
 		getBcInfoPacket.data.add("regionCode", "<%=regionCode%>");
		getBcInfoPacket.data.add("saleType", "<%=saleType%>");
		
		core.ajax.sendPacketHtml(getBcInfoPacket, doGetBcInfo, true);
		getBcInfoPacket = null;
	}
	
	function doGetBcInfo(data) {
		//alert(data);
		$("#brandCode").empty().append(data);
	}
	
	//获取手机型号信息
	function getPhoneTypeInfo() {
		var getPtInfoPacket = new AJAXPacket("fb484_ajaxGetPhoneTypeInfo.jsp", "正在获取手机型号信息，请稍候......");
		getPtInfoPacket.data.add("regionCode", "<%=regionCode%>");
		getPtInfoPacket.data.add("saleType", "<%=saleType%>");
		getPtInfoPacket.data.add("brandCode", document.getElementById("brandCode").value);
		
		core.ajax.sendPacketHtml(getPtInfoPacket, doGetPtInfo, true);
		getBcInfoPacket = null;
	}
	
	function doGetPtInfo(data) {
		//alert(data);
		$("#phoneType").empty().append(data);
	}
	
	function getPhoneTypeInfoNull() {
		$("#phoneType").empty().append("<option value = '0'>--请选择TD固话品牌--</option>");
	}
	
	//获取营销代码信息
	function getSaleCodeInfo() {
		var getScInfoPacket = new AJAXPacket("fb484_ajaxGetSaleCodeInfo.jsp", "正在获取营销代码信息，请稍候......");
		getScInfoPacket.data.add("regionCode", "<%=regionCode%>");
		getScInfoPacket.data.add("saleType", "<%=saleType%>");
		getScInfoPacket.data.add("brandCode", document.getElementById("brandCode").value);
		getScInfoPacket.data.add("phoneType", document.getElementById("phoneType").value);
		
		core.ajax.sendPacketHtml(getScInfoPacket, doGetScInfo, true);
		getScInfoPacket = null;
	}
	
	function doGetScInfo(data) {
		//alert(data);
		$("#saleCode").empty().append(data);
	}
	
	function getSaleCodeInfoNull() {
		$("#saleCode").empty().append("<option value = '0'>--请选择TD固话--</option>");
	}
	
	//获取营销明细
	function getSaleInfo() {
<%
		if (!"7671".equals(oldOpCode)) {
%>
			document.getElementById("Price").value = "......";
			document.getElementById("Base_Fee").value = "......";
			document.getElementById("Consume_Term").value = "......";
			document.getElementById("Free_Fee").value = "......";
			document.getElementById("Active_Term").value = "......";
			document.getElementById("Sale_Price").value = "......";
			
			var getSaleInfoPacket = new AJAXPacket("fb484_ajaxGetSaleInfo.jsp", "正在获取营销明细信息，请稍候......");
			getSaleInfoPacket.data.add("regionCode", "<%=regionCode%>");
			getSaleInfoPacket.data.add("saleType", "<%=saleType%>");
			getSaleInfoPacket.data.add("saleCode", document.getElementById("saleCode").options[document.getElementById("saleCode").selectedIndex].value);
			
			core.ajax.sendPacket(getSaleInfoPacket, doGetSaleInfo, true);
			getBcInfoPacket = null;
<%
		} else {
%>
			document.getElementById("Sale_Price").value = "......";
			document.getElementById("Price").value = "......";
			document.getElementById("Base_Fee2").value = "......";
			document.getElementById("Free_Fee2").value = "......";
			document.getElementById("Consume_Term2").value = "......";
			document.getElementById("Phone_Fee").value = "......";
			document.getElementById("Active_Term2").value = "......";
			
			var getSaleInfoPacket = new AJAXPacket("fb484_ajaxGetSaleInfo7671.jsp", "正在获取营销明细信息，请稍候......");
			getSaleInfoPacket.data.add("regionCode", "<%=regionCode%>");
			getSaleInfoPacket.data.add("saleType", "<%=saleType%>");
			getSaleInfoPacket.data.add("saleCode", document.getElementById("saleCode").options[document.getElementById("saleCode").selectedIndex].value);
			
			core.ajax.sendPacket(getSaleInfoPacket, doGetSaleInfo7671, true);
			getBcInfoPacket = null;
<%
		}
%>
	}
	
	function doGetSaleInfo(packet) {
		var salePhone = packet.data.findValueByName("salePhone");
		var saleBase = packet.data.findValueByName("saleBase");
		var saleConsumeTerm = packet.data.findValueByName("saleConsumeTerm");
		var saleFree = packet.data.findValueByName("saleFree");
		var saleActiveTerm = packet.data.findValueByName("saleActiveTerm");
		var saleMonBase = packet.data.findValueByName("saleMonBase");			//
		var saleAllGiftPrice = packet.data.findValueByName("saleAllGiftPrice");	//
		var saleSalePrice = packet.data.findValueByName("saleSalePrice");
		var saleCode = packet.data.findValueByName("saleCode");
		var saleMarketPrice = packet.data.findValueByName("saleMarketPrice");	//
		
		document.getElementById("Price").value = salePhone;
		document.getElementById("Base_Fee").value = saleBase;
		document.getElementById("Consume_Term").value = saleConsumeTerm;
		document.getElementById("Free_Fee").value = saleFree;
		document.getElementById("Active_Term").value = saleActiveTerm;
		//document.getElementById("All_Gift_Price").value = saleMonBase;		//
		//document.getElementById("Mon_Base_Fee").value = saleAllGiftPrice;	//
		document.getElementById("Sale_Price").value = saleSalePrice;
		document.getElementById("Market_Price").value = saleMarketPrice;
	}
	
	function doGetSaleInfo7671(packet) {
		var Sale_Price = packet.data.findValueByName("Sale_Price");
		var Price = packet.data.findValueByName("Price");
		var Base_Fee2 = packet.data.findValueByName("Base_Fee2");
		var Free_Fee2 = packet.data.findValueByName("Free_Fee2");
		var Consume_Term2 = packet.data.findValueByName("Consume_Term2");
		var Phone_Fee = packet.data.findValueByName("Phone_Fee");
		var Active_Term2 = packet.data.findValueByName("Active_Term2");
		var saleCode = packet.data.findValueByName("saleCode");
		
		document.getElementById("Sale_Price").value = Sale_Price;
		document.getElementById("Price").value = Price;
		document.getElementById("Base_Fee2").value = Base_Fee2;
		document.getElementById("Free_Fee2").value = Free_Fee2;
		document.getElementById("Consume_Term2").value = Consume_Term2;
		document.getElementById("Phone_Fee").value = Phone_Fee;
		document.getElementById("Active_Term2").value = Active_Term2;
	}
	
	function getSaleInfoNull() {
<%
		if (!"7671".equals(oldOpCode)) {
%>
			document.getElementById("Price").value = "";
			document.getElementById("Base_Fee").value = "";
			document.getElementById("Consume_Term").value = "";
			document.getElementById("Free_Fee").value = "";
			document.getElementById("Active_Term").value = "";
			document.getElementById("Sale_Price").value = "";
<%
		} else {
%>
			document.getElementById("Sale_Price").value = "";
			document.getElementById("Price").value = "";
			document.getElementById("Base_Fee2").value = "";
			document.getElementById("Free_Fee2").value = "";
			document.getElementById("Consume_Term2").value = "";
			document.getElementById("Phone_Fee").value = "";
			document.getElementById("Active_Term2").value = "";
<%
		}
%>
	}
	
	//获取主资费信息
/*	function getModeCodeInfo() {
		var getMcPacket = new AJAXPacket("fb484_ajaxGetModeCodeInfo.jsp", "正在获取主资费信息，请稍候......");
		getMcPacket.data.add("regionCode", "<%=regionCode%>");
		getMcPacket.data.add("saleType", "<%=saleType%>");
		getMcPacket.data.add("saleCode", document.getElementById("saleCode").value);
		
		core.ajax.sendPacketHtml(getMcPacket, doGetMcInfo, true);
		getMcPacket = null;
	}
	
	function doGetMcInfo(data) {
		//alert(data);
		$("#newModeCode").empty().append(data);
	}
	
	function getModeCodeInfoNull() {
		$("#newModeCode").empty().append("<option value = '0'>--请选择营销方案--</option>");
	}
	

	function getFlagCode()
	{
		var qryAreaPacket = new AJAXPacket("/npage/bill/qryAreaFlag.jsp", "正在查询客户，请稍候......");
		qryAreaPacket.data.add("orgCode", "<%=regionCode%>");
		qryAreaPacket.data.add("modeCode", document.getElementById("newModeCode").value);
		
		core.ajax.sendPacket(qryAreaPacket, doQryAreaPacket);
		qryAreaPacket=null;
	}
	
	function doQryAreaPacket(packet) {
		var retCode = packet.data.findValueByName("retCode");
		var retMsg = packet.data.findValueByName("retMsg");
		var areaFlag = packet.data.findValueByName("area_flag");
		
		if(retCode == 000000) {
		    if(parseInt(areaFlag)>0) {
				//调用公共js
				var pageTitle = "资费查询";
				var fieldName = "小区代码|小区名称|二批代码";//弹出窗口显示的列、列名
				var sqlStr = "select a.flag_code, a.flag_code_name from sofferflagcode a, sregioncode b where a.offer_id = '" + document.getElementById("newModeCode").value + "' and a.group_id = b.group_id and b.region_code = '" + "<%=regionCode%>" + "' order by a.flag_code";
				
				var selType = "S";    //'S'单选；'M'多选
				var retQuence = "0|1|2";//返回字段
				var retToField = "flagCode|flagCodeName|rateCode";//返回赋值的域
				
				if(PubSimpSel(pageTitle,fieldName,sqlStr,selType,retQuence,retToField));
		    }
		} else {
			rdShowMessageDialog("错误:"+ retCode + "->" + retMsg, 1);
			return;
		}
	}
*/
	
	function changeSelect(obj) {
		var changeName = obj.id;
		
		if (changeName == "brandCode") {
			document.getElementById("brandName").value = document.getElementById("brandCode").options[document.getElementById("brandCode").selectedIndex].text;
			var selectObj = document.getElementById("phoneType");
			
			if (obj.options[obj.selectedIndex].value == "0") {
				getPhoneTypeInfoNull();
			} else {
				selectObj.options[selectObj.selectedIndex].text = "正在获取手机型号......";
				getPhoneTypeInfo();
			}
			getSaleCodeInfoNull();
			getSaleInfoNull();
		} else if (changeName == "phoneType") {
			document.getElementById("phoneTypeName").value = document.getElementById("phoneType").options[document.getElementById("phoneType").selectedIndex].text;
			var selectObj = document.getElementById("saleCode");
			
			if (obj.options[obj.selectedIndex].value == "0") {
				getSaleCodeInfoNull();
			} else {
				selectObj.options[selectObj.selectedIndex].text = "正在获取营销代码......";
				getSaleCodeInfo();
			}
			
			getSaleInfoNull();
		} else if (changeName == "saleCode") {
			if (obj.options[obj.selectedIndex].value == "0") {
				getSaleInfoNull();
			} else {
				getSaleInfo();
			}
		}
	}
	
	function submitt() {
		//getAfterPrompt();	//事后提醒
		document.getElementById("opNote").value = "<%=workNo%>为<%=activePhone%>办理<%=opName%>，saleType："
			+ document.getElementById("saleType").value;

		buttonSub = document.getElementById("submitB");
		buttonSub.disabled = "true";
		
		if (document.getElementById("brandCode").value == "0") {
			rdShowMessageDialog("请选择TD固话品牌型号，及相应的营销方案！", 1);
			return;
		} else if (document.getElementById("phoneType").value == "0") {
			rdShowMessageDialog("请选择TD固话型号，及相应的营销方案！", 1);
			return;
		} else if (document.getElementById("saleCode").value == "0") {
			rdShowMessageDialog("请选择营销方案！", 1);
			return;
		}
		
<%
		if (!"7671".equals(oldOpCode)) {
%>
		document.getElementById("addStr").value = document.getElementById("saleCode").value + "|"
			+ document.getElementById("brandCode").options[document.getElementById("brandCode").selectedIndex].text + "|"
			+ document.getElementById("phoneType").options[document.getElementById("phoneType").selectedIndex].text + "|"
			+ document.getElementById("Sale_Price").value + "|"
			+ document.getElementById("Base_Fee").value + "|"
			+ document.getElementById("Consume_Term").value + "|"
			+ document.getElementById("Free_fee").value + "|"
			+ document.getElementById("Active_Term").value + "|"
			+ document.getElementById("Price").value+"|"
			+ document.getElementById("Market_Price").value + "|"
			+ document.getElementById("imeiCode").value;
<%
		} else {
%>
		document.getElementById("addStr").value = document.getElementById("saleCode").value + "|"
			+ document.getElementById("brandCode").options[document.getElementById("brandCode").selectedIndex].text + "|"
			+ document.getElementById("Sale_Price").value + "|"
			+ document.getElementById("Base_Fee2").value + "|"
			+ document.getElementById("Free_fee2").value + "|"
			+ document.getElementById("phoneType").options[document.getElementById("phoneType").selectedIndex].text + "|"
			+ document.getElementById("Price").value+"|"
			+ document.getElementById("Consume_Term2").value + "|"
			+ document.getElementById("Active_Term2").value + "|"
			+ document.getElementById("imeiCodeT").value + "|"
			+ document.getElementById("secondPhone").value + "|"
			+ document.getElementById("Phone_Fee_zero").value + "|"
			+ document.getElementById("awardFlag").value + "|";
<%		
		}
%>
		
		var ret = showPrtDlg("Detail", "确实要进行电子免填单打印吗？","Yes");	//打印免填单
		
		if(typeof(ret) != "undefined"){
			if (rdShowConfirmDialog("确认要进行此项服务吗？") == 1) {
				frm.action = "fb484_cfm.jsp";
				frm.submit();
			} else {
				buttonSub.disabled = "";
			}
		} else {
			if (rdShowConfirmDialog("确认要进行此项服务吗？") == 1) {
				frm.action = "fb484_cfm.jsp";
				frm.submit();
			} else {
				buttonSub.disabled = "";
			}
		}
	}
	
	//显示打印对话框
	function showPrtDlg(printType,DlgMessage,submitCfm)
	{
		var h=210;
		var w=400;
		var t=screen.availHeight/2-h/2;
		var l=screen.availWidth/2-w/2;
		
<%
		if (!"7671".equals(oldOpCode)) {
%>
			var printStr = printInfo();
<%		
		} else {
%>
			var printStr = printInfo7671();
<%		
		}
%>
		
		var pType="subprint";              // 打印类型：print 打印 subprint 合并打印
		var billType="1";               //  票价类型：1电子免填单、2发票、3收据
		var sysAccept="<%=loginAccept%>";               // 流水号
		var mode_code=null;               //资费代码
		var fav_code=null;                 //特服代码
		var area_code=null;             //小区代码
		var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no";
	
		var path = "<%=request.getContextPath()%>/npage/innet/hljBillPrint_jc.jsp?DlgMsg=" + DlgMessage+ "&submitCfm=" + submitCfm;
		path=path+"&mode_code="+mode_code+"&fav_code="+fav_code+"&area_code="+area_code+"&opCode=<%=opCode%>&sysAccept="+sysAccept+"&phoneNo=<%=activePhone%>&pType="+pType+"&billType="+billType+ "&printInfo=" + printStr.trim();
		
		var ret=window.showModalDialog(path.trim(),printStr,prop);
		return ret;
	}
	
	function printInfo() {
		var beginTime="<%=new java.text.SimpleDateFormat("yyyy-MM-dd", Locale.getDefault()).format(new java.util.Date())%>";
		var retInfo = "";
	    var cust_info = "";
	    var opr_info = "";
	    var note_info1 = "";
	    var note_info2 = "";
	    var note_info3 = "";
	    var note_info4 = "";

		/********基本信息类**********/
		cust_info+="手机号码："+document.getElementById("activePhone").value+"|";
		cust_info+="客户姓名："+document.getElementById("custName").value+"|";
		cust_info+="客户地址：<%=result[0][2]%>|";
		cust_info+="证件号码：<%=result[0][14]%>|";
	
		/********受理类**********/
		opr_info+="业务类型：<%=opName%>"+"|";
		opr_info+="操作流水：<%=loginAccept%>|";
		opr_info+="购机信息：品牌 "+document.getElementById("brandCode").options[document.getElementById("brandCode").selectedIndex].text
			+ "，型号 "+document.getElementById("phoneType").options[document.getElementById("phoneType").selectedIndex].text
			+ "，捆绑IMEI "+document.getElementById("imeiCode").value + "|";
		opr_info+="赠送话费："+document.getElementById("Base_Fee").value + "元，分"
			+ parseInt(document.getElementById("Consume_Term").value) + "个月赠送，"
			+ parseInt(document.getElementById("Consume_Term").value) + "个月消费完毕。|";
		if(document.getElementById("Free_fee").value > 0)
		{
			opr_info+="赠送上网费："+document.getElementById("Free_fee").value+"元，|";
		}
		opr_info+="业务执行时间："+beginTime+"|";
		
		/**********描述类*********/

		note_info3+=" "+"|";
		note_info4+="备注：<%=workNo%>为<%=activePhone%>办理<%=opName%>|";
		
	    retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
	    retInfo=retInfo.replace(new RegExp("#","gm"),"%23");
	    return retInfo;
	}

	function printInfo7671() {
		var beginTime="<%=new java.text.SimpleDateFormat("yyyy-MM-dd", Locale.getDefault()).format(new java.util.Date())%>";
		var retInfo = "";
	    var cust_info = "";
	    var opr_info = "";
	    var note_info1 = "";
	    var note_info2 = "";
	    var note_info3 = "";
	    var note_info4 = "";
		
		/********基本信息类**********/
		cust_info+="手机号码："+document.getElementById("activePhone").value+"|";
		cust_info+="客户姓名："+document.getElementById("custName").value+"|";
		cust_info+="客户地址：<%=result[0][2]%>|";
		cust_info+="证件号码：<%=result[0][14]%>|";
		
		/********受理类**********/
		opr_info += "业务类型：<%=opName%>"+"|";
		opr_info += "操作流水：<%=loginAccept%>|";
		opr_info += "固话卡月赠送费用：" + (parseFloat(document.getElementById("Price").value) / parseFloat(document.getElementById("Consume_Term2").value)).toFixed(2)
			+ "元，底限预存：" + (parseFloat(document.getElementById("Base_Fee2").value)).toFixed(2) + "元，活动预存："
			+ (parseFloat(document.getElementById("Free_Fee2").value)).toFixed(2) + "元，" + parseInt(document.getElementById("Consume_Term2").value)
			+ "个月消费完毕|";
		opr_info += "手机卡月赠送费用" + (parseFloat(document.getElementById("Phone_Fee").value)/parseFloat(document.getElementById("Active_Term2").value)).toFixed(2)
			+ "元，分" + parseInt(document.getElementById("Active_Term2").value) + "个月赠送，"
			+ parseInt(document.getElementById("Active_Term2").value) + "个月消费完毕|";
			
		note_info1 += "备注：<%=workNo%>为<%=activePhone%>办理<%=opName%>|";
		
	    retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
	    retInfo = retInfo.replace(new RegExp("#","gm"),"%23");
	    return retInfo;
	}
	
</script>
</head>
<body>

<form name="frm" method="POST">
<input type="hidden" name="opCode" id="opCode" value="<%=opCode%>">
<input type="hidden" name="opName" id="opName" value="<%=opName%>">
<input type="hidden" name="userPwd" id="userPwd" value="<%=result[0][0]%>">
<input type="hidden" name="opNote" id="opNote" value="">
<input type="hidden" name="saleType" id="saleType" value="<%=saleType%>">
<input type="hidden" name="loginAccept" id="loginAccept" value="<%=loginAccept%>">
<input type="hidden" name="oldOpCode" id="oldOpCode" value="<%=oldOpCode%>">
<input type="hidden" name="Market_Price" id="Market_Price" value="0">
<input type="hidden" name="addStr" id="addStr" value="">

<input type="hidden" name="custAddr" id="custAddr" value="<%=result[0][2]%>">
<input type="hidden" name="brandName" id="brandName" value="">
<input type="hidden" name="phoneTypeName" id="phoneTypeName" value="">

<input type="hidden" name="idNo" id="idNo" value="<%=result[0][15]%>">
<input type="hidden" name="imeiCodeT" id="imeiCodeT" value="">
<input type="hidden" name="secondPhone" id="secondPhone" value="">
<input type="hidden" name="awardFlag" id="awardFlag" value="0" >
<input type="hidden" name="Phone_Fee_zero" id="awardFlag" value="0" >


<%@ include file="/npage/include/header.jsp" %>
<div class="title">
	<div id="title_zi">机主信息</div>
</div>
<table cellspacing="0">
	<tr>
		<td class="blue" width="20%">
			电话号码
		</td>
		<td width="30%">
			<input type="text" name="activePhone" id="activePhone" value="<%=activePhone%>" v_must="1" class="InputGrey" readonly>
		</td>
		<td class="blue"width="20%">
			机主姓名
		</td>
		<td width="30%">
			<input type="text" name="custName" id="custName" size="40" value="<%=result[0][1]%>" v_must="1" class="InputGrey" readonly>
		</td>
	</tr>
	<tr>
		<td class="blue">
			业务品牌
		</td>
		<td>
			<input name="oSmName" id="oSmName" type="text" class="InputGrey" value="<%=result[0][10]%>" readonly>
		</td>
		<td class="blue">
			资费名称
		</td>
		<td>
			<input name="oModeName" id="oModeName" type="text" class="InputGrey" value="<%=result[0][4]%>" readonly>
		</td>
	</tr>
	<tr>
		<td class="blue">
			账号预存
		</td>
		<td>
			<input name="" id="" type="text" class="InputGrey" value="<%=result[0][11]%>" readonly>
		</td>
		<td class="blue">
			营销代码
		</td>
		<td>
			<input name="oSaleCode" id="oSaleCode" type="text" class="InputGrey" value="<%=result[0][19]%>" readonly>
		</td>
	</tr>
	<tr>
		<td class="blue">
			TD固话品牌、型号
		</td>
		<td>
			<input name="oPhone" id="oPhone" type="text" class="InputGrey" value="<%=result[0][20]%>" readonly>
		</td>
<%
		if (!"7671".equals(oldOpCode)) {
%>
			<td class="blue">
				购机款
			</td>
			<td>
				<input name="" id="" type="text" class="InputGrey" value="<%=result[0][21]%>" readonly>
			</td>
<%
		} else {
%>
			<td class="blue">
				固话卡款
			</td>
			<td>
				<input type="text" class="InputGrey" name="Fixed_Fee" id="Fixed_Fee" value="<%=result[0][35]%>" readonly>
			</td>
<%
		}
%>
		</td>
	</tr>
	<tr>
		<td class="blue">
			赠送话费
		</td>
		<td>
			<input name="" id="" type="text" class="InputGrey" value="<%=result[0][22]%>" readonly>
		</td>
		<td class="blue">
			话费消费期限
		</td>
		<td>
			<input name="" id="" type="text" class="InputGrey" value="<%=result[0][23]%>" readonly>
		</td>
	</tr>
	<tr>
		<td class="blue">
			赠送上网费
		</td>
		<td>
			<input name="" id="" type="text" class="InputGrey" value="<%=result[0][24]%>" readonly>
		</td>
		<td class="blue">
			上网费消费期限
		</td>
		<td>
			<input name="" id="" type="text" class="InputGrey" value="<%=result[0][25]%>" readonly>
		</td>
	</tr>
	<tr>
<%
	if (!"7671".equals(oldOpCode)) {
%>
		<td class="blue">
			预存总金额
		</td>
		<td>
			<input name="" id="" type="text" class="InputGrey" value="<%=result[0][26]%>" readonly>
		</td>
<%
	} else {
%>
		<td class="blue">
			预存总金额
		</td>
		<td>
			<input name="" id="" type="text" class="InputGrey" value="<%=result[0][37]%>" readonly>
		</td>
<%
	}
%>
		<td class="blue">
		</td>
		<td>
		</td>
	</tr>
	<tr>
		<td class="blue">
			办理时间
		</td>
		<td>
			<input name="" id="" type="text" class="InputGrey" value="<%=result[0][27]%>" readonly>
		</td>
		<td class="blue">
			结束时间
		</td>
		<td>
			<input name="oStopTime" id="oStopTime" type="text" class="InputGrey" value="<%=result[0][28]%>" readonly>
		</td>
	</tr>
</table>

<div class="title">
	<div id="title_zi">营销方案</div>
</div>
<table cellspacing="0">
	<tr>
		<td class="blue" width="20%">
			TD固话品牌
		</td>
		<td width="30%">
			<SELECT id="brandCode" name="brandCode" v_must=1 v_name="TD固话品牌" onchange="changeSelect(this);">
				<option value = "0">--正在读取，请等待--</option>
			</select>
			<font class="orange">*</font>
		</td>
		<td class="blue" width="20%">
			TD固话类型
		</td>
		<td width="30%">
			<select size=1 name="phoneType" id="phoneType" v_name="手机型号" onchange="changeSelect(this);">
				<option value ="0">--请选择TD固话品牌--</option>
			</select>
			<font class="orange">*</font>
		</td>
	</tr>
	<tr>
		<td class="blue">
			营销方案
		</td>
		<td>
			<SELECT id="saleCode" name="saleCode" v_must=1 v_name="营销代码" onchange="changeSelect(this);">
				<option value = "0">--请选择TD固话--</option>
			</select>
			<font class="orange">*</font>
		</td>
		<td class="blue">
			购TD固话费
		</td>
		<td>
			<input type="text" name="Price" id="Price" value="" class="InputGrey" readonly>
		</td>
	</tr>
	
	
<%
	if (!"7671".equals(oldOpCode)) {
%>
		<tr>
			<td class="blue">
				赠送话费
			</td>
			<td>
				<input type="text" name="Base_Fee" id="Base_Fee" value="" class="InputGrey" readonly>
			</td>
			<td class="blue">
				话费消费期限
			</td>
			<td>
				<input type="text" name="Consume_Term" id="Consume_Term" value="" class="InputGrey" readonly>
			</td>
		</tr>
		<tr>
			<td class="blue">
				赠上网费
			</td>
			<td>
				<input type="text" name="Free_fee" id="Free_fee" value="" class="InputGrey" readonly>
			</td>
			<td class="blue">
				上网费消费期限
			</td>
			<td>
				<input type="text" name="Active_Term" id="Active_Term" value="" class="InputGrey" readonly>
			</td>
		</tr>
<%
	} else {
%>
		<tr>
			<td class="blue">
				底限预存
			</td>
			<td>
				<input name="Base_Fee2" type="text" class="InputGrey" id="Base_Fee2" value="" readonly>
			</td>
			<td class="blue">
				活动预存
			</td>
			<td>
				<input name="Free_Fee2" type="text" class="InputGrey" id="Free_Fee2" value="" readonly>
			</td>
		</tr>
		<tr>
			<td class="blue">
				固话卡消费期限
			</td>
			<td>
				<input name="Consume_Term2" type="text" class="InputGrey" id="Consume_Term2" value="" readonly>
			</td>
			<td class="blue">
				赠手机卡话费
			</td>
			<td>
				<input name="Phone_Fee" type="text" class="InputGrey" id="Phone_Fee" readonly>
			</td>
		</tr>
		<tr>
			<td class="blue">
				手机卡话费消费期限
			</td>
			<td colspan="3">
				<input name="Active_Term2" type="text" class="InputGrey" id="Active_Term2" value="" readonly>
			</td>
		</tr>
<%
	}
%>
	
	
</table>
<div class="title">
	<div id="title_zi">重新购机</div>
</div>
<table>
	<tr>
		<td class="blue">
			应收金额
		</td>
		<td>
			<input type="text" name="Sale_Price" id="Sale_Price" value="" class="InputGrey" readonly>
		</td>
		<td class="blue">
			缴费方式
		</td>
		<td>
			<select name="payType" >
				<option value="0">现金缴费</option>
			</select>
		</td>
	</tr>
	<tr>
		<td class="blue">
			IMEI码
		</td>
		<td colspan="3">
			<input type="text" name="imeiCode" id="imeiCode" v_type="0_9" maxlength="20" v_maxlength="20" value="">&nbsp;&nbsp;
			<input type="button" name="checkIcBtn" id="checkIcBtn" value="资源校验" class="b_text" style="" onClick="checkImeiCode();">
			<input type="button" name="changeIcBtn" id="changeIcBtn" value="修改信息" class="b_text" style="display:none" onClick="changeImeiCode();">
			<font class="orange">*</font>
		</td>
	</tr>
	<tr>
		<td class="blue">
			购机时间
		</td>
		<td width="30%">
			<input name="payTime" type="text" v_name="购机时间"  value="<%=new java.text.SimpleDateFormat("yyyyMMdd", Locale.getDefault()).format(new java.util.Date())%>">
			(年月日)<font color="orange">*</font>
		</td>
		<td class="blue">
			保修时限
		</td>
		<td>
			<input name="repairLimit" v_type="date.month"  size="10" type="text" value="12">
			(个月)<font color="orange">*</font>
		</td>
	</tr>
</table>

<table cellspacing="0">
	<tr>
	    <td colspan="3" id="footer">
	      <input class="b_foot" type=button name="submitB" id="submitB" disabled="true" value="确定" onClick="submitt();">
	      <input class="b_foot" type=button name="closeB" value="关闭" onClick="removeCurrentTab();">
	    </td>
	</tr>
</table>
<%@ include file="/npage/include/footer_simple.jsp" %>
</form>
</body>
</html>

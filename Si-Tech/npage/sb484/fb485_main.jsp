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
<title>TD固话重新购机冲正</title>
<META content="MSHTML 5.00.3315.2870" name=GENERATOR>
<%
	String backAccept = WtcUtil.repStr(request.getParameter("backAccept"), "");
	String opCode = WtcUtil.repStr(request.getParameter("opCode"), "");
	String opName = WtcUtil.repStr(request.getParameter("opName"), "");
	System.out.println("===wanghfa===" + opCode + opName);
	
	String workNo = (String)session.getAttribute("workNo");
	String noPass = (String)session.getAttribute("password");
	String regionCode = (String)session.getAttribute("regCode");
	String saleType = "";
	
	String result[][] = new String[1][41];
	
	System.out.println("==========wanghfa====sB485Qry=======0========= backAccept = " + backAccept);
	System.out.println("==========wanghfa====sB485Qry=======1========= opCode = " + opCode);
	System.out.println("==========wanghfa====sB485Qry=======2========= workNo = " + workNo);
	System.out.println("==========wanghfa====sB485Qry=======3========= activePhone = " + activePhone);
	System.out.println("==========wanghfa====sB485Qry=======4========= 渠道 = 01");
	System.out.println("==========wanghfa====sB485Qry=======5========= noPass = " + noPass);
	System.out.println("==========wanghfa====sB485Qry=======6========= 用户密码 = ");
%>
	
	<wtc:service name="sB485Qry" routerKey="phone" routerValue="<%=activePhone%>" retcode="retCode1" retmsg="retMsg1" outnum="36">			
		<wtc:param value="<%=backAccept%>"/>
		<wtc:param value="<%=opCode%>"/>
		<wtc:param value="<%=workNo%>"/>
		<wtc:param value="<%=activePhone%>"/>
		<wtc:param value="01"/>
		<wtc:param value="<%=noPass%>"/>
		<wtc:param value=""/>
	</wtc:service>
	<wtc:array id="result1"  scope="end"/>
<%
	System.out.println("==========wanghfa==================== sB485Qry " + retCode1 + "," + retMsg1);
	if (retCode1.equals("B48427") || retCode1.equals("B48432") || retCode1.equals("B48423")) {
%>
		<script language="JavaScript">
			rdShowMessageDialog("<%=retCode1%><%=retMsg1%>", 1);
			history.go(-1);
		</script>
<%
	} else if (!retCode1.equals("000000")) {
%>
		<script language="JavaScript">
			rdShowMessageDialog("sB485Qry：<%=retCode1%><%=retMsg1%>", 0);
			history.go(-1);
		</script>
<%
	} else {
		for (int i = 0; i < result1[0].length; i ++) {
			System.out.println("==========wanghfa==================== result[0]["+i+"] = " + result1[0][i]);
			result[0][i] = result1[0][i];
		}
		saleType = result[0][28];
	}
%>

<%
	String imeiCode="";
	String sqlStr="select imei_no from wMachSndOprhis where phone_no ='"+activePhone+"'"+
		    " and login_accept="+backAccept;
	String[] inParamA = new String[2];
	inParamA[0] = "select imei_no from wMachSndOprhis where phone_no =:phone_no and login_accept=:login_accept" ;
	inParamA[1] = "phone_no=" + activePhone + ",login_accept=" + backAccept;
%>
	<wtc:service name="TlsPubSelCrm" routerKey="phone" routerValue="<%=activePhone%>" retcode="retCode2" retmsg="retMsg2" outnum="1">
	<wtc:param value="<%=inParamA[0]%>"/>
	<wtc:param value="<%=inParamA[1]%>"/>
	</wtc:service>
	<wtc:array id="retArray"  scope="end"/>
<%
  if(retCode2.equals("000000") && retArray.length>0)
  {
	if(retArray!=null&& retArray.length > 0){
  	imeiCode = retArray[0][0];
  	System.out.println("imeiCode = " + imeiCode);
  	}
  }
%>

<script language=javascript>
	window.onload = function() {
		//getSaleInfo();
	}
	//获取营销明细
	function getSaleInfo() {
		document.getElementById("Price").value = "......";
		document.getElementById("Base_Fee").value = "......";
		document.getElementById("Consume_Term").value = "......";
		document.getElementById("Free_Fee").value = "......";
		document.getElementById("Active_Term").value = "......";
		document.getElementById("Sale_Price").value = "......";
		
/*
		alert("<%=regionCode%>");
		alert("<%=saleType%>");
		alert(document.getElementById("saleCode").value);
*/
<%
		if (!"36".equals(saleType)) {
%>
			var getSaleInfoPacket = new AJAXPacket("fb484_ajaxGetSaleInfo.jsp", "正在获取营销明细信息，请稍候......");
			getSaleInfoPacket.data.add("regionCode", "<%=regionCode%>");
			getSaleInfoPacket.data.add("saleType", "<%=saleType%>");
			getSaleInfoPacket.data.add("saleCode", document.getElementById("saleCode").value);
			
			core.ajax.sendPacket(getSaleInfoPacket, doGetSaleInfo, true);
			getBcInfoPacket = null;
<%
		} else {
%>
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
	
	
	function submitt() {
		//getAfterPrompt();	//事后提醒
		document.getElementById("opNote").value = "<%=workNo%>为<%=activePhone%>办理<%=opName%>，saleType："
			+ document.getElementById("saleType").value;

		buttonSub = document.getElementById("submitB");
		buttonSub.disabled = "true";
		
<%
	if (!"36".equals(saleType)) {
%>
		document.getElementById("addStr").value = document.getElementById("saleCode").value + "|"
			+ document.getElementById("brandCode").value + "|"
			+ document.getElementById("phoneType").value + "|"
			+ document.getElementById("Sale_Price1").value + "|"
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
		document.getElementById("addStr").value = document.getElementById("saleCode").value + "|" //document.getElementById("backaccept").value + "|"
			+ document.getElementById("Sale_Price2").value + "|"
			+ document.getElementById("Base_Fee2").value + "|"
			+ document.getElementById("Free_Fee2").value + "|"
			+ document.getElementById("Fixed_Fee").value + "|"
			+ document.getElementById("Consume_Term2").value + "|"
			+ document.getElementById("phoneFee").value + "|"
			+ document.getElementById("oPhone").value + "|"
			+ document.getElementById("oSecondPhone").value + "|"
			+ document.getElementById("Active_Term2").value + "|"
			+ "|";
<%
	}
%>
		var ret = showPrtDlg("Detail", "确实要进行电子免填单打印吗？","Yes");	//打印免填单
		
		if(typeof(ret) != "undefined"){
			if (rdShowConfirmDialog("确认要进行此项服务吗？") == 1) {
				frm.action = "fb485_cfm.jsp";
				frm.submit();
			}
			buttonSub.disabled = "";
		} else {
			if (rdShowConfirmDialog("确认要进行此项服务吗？") == 1) {
				frm.action = "fb485_cfm.jsp";
				frm.submit();
			}
			//buttonSub.disabled = "";
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
		if (!"36".equals(saleType)) {
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
		var sysAccept="<%=backAccept%>";               // 流水号
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
		opr_info += "业务类型：<%=opName%>"+"|";
		opr_info += "冲正流水：<%=backAccept%>|";
		opr_info += "购机信息：品牌 " + document.getElementById("brandCode").value
			+ "，型号 " + document.getElementById("phoneType").value + "|";
		opr_info += "赠送话费" + parseFloat(document.getElementById("Base_Fee").value).toFixed(2) + "元，分"
			+ parseInt(document.getElementById("Consume_Term").value) + "个月赠送，"
			+ parseInt(document.getElementById("Consume_Term").value) + "个月消费完毕。|";
		if(parseInt(document.getElementById("Free_fee")).value > 0)
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
		opr_info += "冲正流水：<%=backAccept%>|";
		if (parseFloat(document.getElementById("Price").value) > 0) {
			opr_info += "固话卡月赠送费用：" + (parseFloat(document.getElementById("Price").value) / parseFloat(document.getElementById("Consume_Term2").value)).toFixed(2)
				+ "元，底限预存：" + (parseFloat(document.getElementById("Base_Fee2").value)).toFixed(2) + "元，活动预存："
				+ (parseFloat(document.getElementById("Free_Fee2").value)).toFixed(2) + "元，" + parseInt(document.getElementById("Consume_Term2").value)
				+ "个月消费完毕|";
		}
		if (parseFloat(document.getElementById("phoneFee").value) > 0) {
			opr_info += "手机卡月赠送费用" + (parseFloat(document.getElementById("phoneFee").value)/parseFloat(document.getElementById("Active_Term2").value)).toFixed(2)
				+ "元，分" + parseInt(document.getElementById("Active_Term2").value) + "个月赠送，"
				+ parseInt(document.getElementById("Active_Term2").value) + "个月消费完毕|";
		}
		
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
<input type="hidden" name="addStr" id="addStr" value="">
<input type="hidden" name="backAccept" id="backAccept" value="<%=backAccept%>">
<input type="hidden" name="brandCode" id="brandCode" value="<%=result[0][35]%>".trim()>
<input type="hidden" name="phoneType" id="phoneType" value="<%=result[0][34]%>".trim()>
<input type="hidden" name="Market_Price" id="Market_Price" value="0">
<input type="hidden" name="imeiCode" id="imeiCode" value="<%=imeiCode%>">
<input type="hidden" name="opNote" id="opNote" value="无">
<input type="hidden" name="saleType" id="saleType" value="<%=saleType%>">
<input type="hidden" name="oSecondPhone" id="oSecondPhone" value="00000000000">
<input type="hidden" name="payType" id="payType" value="0">
<input type="hidden" name="Price" id="Price" value="0">
<input type="hidden" name="payTypeT" id="payTypeT" value="0">

<input type="hidden" name="idNo" id="idNo" value="<%=result[0][15]%>">


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
			<input name="" id="" type="text" class="InputGrey" value="<%=result[0][12]%>" readonly>
		</td>
		<td class="blue">
			营销代码
		</td>
		<td>
			<input name="saleCode" id="saleCode" type="text" class="InputGrey" value="<%=result[0][19]%>" readonly>
		</td>
	</tr>
	<tr>
		<td class="blue">
			TD固话品牌、型号
		</td>
		<td>
			<input name="oPhone" id="oPhone" type="text" class="InputGrey" value="<%=result[0][20]%>" readonly>
		</td>
		<td class="blue">
			办理时间
		</td>
		<td>
			<input name="" id="" type="text" class="InputGrey" value="<%=result[0][27]%>" readonly>
		</td>
	</tr>
</table>





<div class="title">
	<div id="title_zi">营销方案</div>
</div>

<table>
<%
	if (!"36".equals(saleType)) {
%>
		<tr>
			<td class="blue">
				赠送话费
			</td>
			<td>
				<input type="text" name="Base_Fee" id="Base_Fee" value="<%=result[0][22]%>" class="InputGrey" readonly>
			</td>
			<td class="blue">
				话费消费期限
			</td>
			<td>
				<input type="text" name="Consume_Term" id="Consume_Term" value="<%=result[0][23]%>" class="InputGrey" readonly>
			</td>
		</tr>
		<tr>
			<td class="blue">
				赠上网费
			</td>
			<td>
				<input type="text" name="Free_fee" id="Free_fee" value="<%=result[0][24]%>" class="InputGrey" readonly>
			</td>
			<td class="blue">
				上网费消费期限
			</td>
			<td>
				<input type="text" name="Active_Term" id="Active_Term" value="<%=result[0][25]%>" class="InputGrey" readonly>
			</td>
		</tr>
		<tr>
			<td class="blue">
				购机款
			</td>
			<td>
				<input name="" id="" type="text" class="InputGrey" value="<%=result[0][21]%>" readonly>
			</td>
			<td class="blue">
				预存总金额
			</td>
			<td>
				<input name="Sale_Price1" id="Sale_Price1" type="text" class="InputGrey" value="<%=result[0][26]%>" readonly>
			</td>
		</tr>
<%
	} else {
%>
		<tr>
			<td class="blue">
				赠送手机卡话费
			</td>
			<td>
				<input type="text" name="phoneFee" id="phoneFee" value="<%=result[0][22]%>" class="InputGrey" readonly>
			</td>
			<td class="blue">
				手机卡话费消费期限
			</td>
			<td>
				<input type="text" name="Active_Term2" id="Active_Term2" value="<%=result[0][23]%>" class="InputGrey" readonly>
			</td>
		</tr>
		<tr>
			<td class="blue">
				固话卡款
			</td>
			<td>
				<input type="text" class="InputGrey" name="Fixed_Fee" id="Fixed_Fee" value="<%=result[0][31]%>" readonly>
			</td>
			<td class="blue">
				底限预存
			</td>
			<td>
				<input type="text" class="InputGrey" name="Base_Fee2" id="Base_Fee2" value="<%=result[0][29]%>" readonly>
			</td>
		</tr>
		<tr>
			<td class="blue">
				活动预存
			</td>
			<td>
				<input type="text" class="InputGrey" name="Free_Fee2" id="Free_Fee2" value="<%=result[0][30]%>" readonly>
			</td>
			<td class="blue">
				固话卡消费期限
			</td>
			<td>
				<input type="text" class="InputGrey" name="Consume_Term2" id="Consume_Term2" value="<%=result[0][32]%>" readonly>
			</td>
		</tr>
		<tr>
			<td class="blue">
				预存总金额
			</td>
			<td colspan="3">
				<input name="Sale_Price2" id="Sale_Price2" type="text" class="InputGrey" value="<%=result[0][33]%>" readonly>
			</td>
		</tr>
<%
	}
%>
	<tr>
		<td class="blue">
			缴费方式
		</td>
		<td colspan="3">
			<select name="payType" disabled="true">
				<option value="0">现金缴费</option>
			</select>
		</td>
	</tr>
</table>

<table cellspacing="0">
	<tr>
	    <td colspan="3" id="footer">
	      <input class="b_foot" type=button name="submitB" id="submitB" value="确定" onClick="submitt();">
	      <input class="b_foot" type=button name="closeB" value="关闭" onClick="removeCurrentTab();">
	    </td>
	</tr>
</table>

<%@ include file="/npage/include/footer_simple.jsp" %>
</form>
</body>
</html>

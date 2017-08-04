<%
    /********************
     version v2.0
     ������: si-tech
     *
     *create:wanghfa@2010-9-6 TD�̻����¹���
     *
     ********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<%@ page contentType="text/html; charset=GB2312" %>
<%@ include file="/npage/include/public_title_name.jsp" %>

<html>
<head>
<title>TD�̻����¹���</title>
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
			rdShowMessageDialog("sB484Qry��<%=retCode1%><%=retMsg1%>", 0);	//0��X,1��!,2�ǶԺ�
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
		//oldOpCode = "7671";	//������
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
	
	//���IMEI��
	function checkImeiCode() {
		var imeiCodeObj = document.getElementById("imeiCode");
		
		if (imeiCodeObj.value.length == 0) {
			rdShowMessageDialog("IMEI�벻��Ϊ�գ����������롣", 1);
			imeiCodeObj.focus();
			return;
		}
		
		var checkImeiPacket = new AJAXPacket("/npage/s1141/queryimei.jsp", "����У��IMEI��Ϣ�����Ժ�......");
		
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
			rdShowMessageDialog("IMEI��У��ɹ���", 2);
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
			rdShowMessageDialog("IMEI�Ų���ӪҵԱ����Ӫҵ����IMEI����ҵ�������Ͳ�����", 1);
			document.getElementById("submitB").disabled = true;
			return;
		} else {
			rdShowMessageDialog("IMEI�Ų����ڻ����Ѿ�ʹ�ã�", 1);
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
	
	//��ȡ�ֻ�Ʒ����Ϣ
	function getBrandCodeInfo() {
		var getBcInfoPacket = new AJAXPacket("fb484_ajaxGetBrandCodeInfo.jsp", "���ڻ�ȡ�ֻ�Ʒ����Ϣ�����Ժ�......");
 		getBcInfoPacket.data.add("regionCode", "<%=regionCode%>");
		getBcInfoPacket.data.add("saleType", "<%=saleType%>");
		
		core.ajax.sendPacketHtml(getBcInfoPacket, doGetBcInfo, true);
		getBcInfoPacket = null;
	}
	
	function doGetBcInfo(data) {
		//alert(data);
		$("#brandCode").empty().append(data);
	}
	
	//��ȡ�ֻ��ͺ���Ϣ
	function getPhoneTypeInfo() {
		var getPtInfoPacket = new AJAXPacket("fb484_ajaxGetPhoneTypeInfo.jsp", "���ڻ�ȡ�ֻ��ͺ���Ϣ�����Ժ�......");
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
		$("#phoneType").empty().append("<option value = '0'>--��ѡ��TD�̻�Ʒ��--</option>");
	}
	
	//��ȡӪ��������Ϣ
	function getSaleCodeInfo() {
		var getScInfoPacket = new AJAXPacket("fb484_ajaxGetSaleCodeInfo.jsp", "���ڻ�ȡӪ��������Ϣ�����Ժ�......");
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
		$("#saleCode").empty().append("<option value = '0'>--��ѡ��TD�̻�--</option>");
	}
	
	//��ȡӪ����ϸ
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
			
			var getSaleInfoPacket = new AJAXPacket("fb484_ajaxGetSaleInfo.jsp", "���ڻ�ȡӪ����ϸ��Ϣ�����Ժ�......");
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
			
			var getSaleInfoPacket = new AJAXPacket("fb484_ajaxGetSaleInfo7671.jsp", "���ڻ�ȡӪ����ϸ��Ϣ�����Ժ�......");
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
	
	//��ȡ���ʷ���Ϣ
/*	function getModeCodeInfo() {
		var getMcPacket = new AJAXPacket("fb484_ajaxGetModeCodeInfo.jsp", "���ڻ�ȡ���ʷ���Ϣ�����Ժ�......");
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
		$("#newModeCode").empty().append("<option value = '0'>--��ѡ��Ӫ������--</option>");
	}
	

	function getFlagCode()
	{
		var qryAreaPacket = new AJAXPacket("/npage/bill/qryAreaFlag.jsp", "���ڲ�ѯ�ͻ������Ժ�......");
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
				//���ù���js
				var pageTitle = "�ʷѲ�ѯ";
				var fieldName = "С������|С������|��������";//����������ʾ���С�����
				var sqlStr = "select a.flag_code, a.flag_code_name from sofferflagcode a, sregioncode b where a.offer_id = '" + document.getElementById("newModeCode").value + "' and a.group_id = b.group_id and b.region_code = '" + "<%=regionCode%>" + "' order by a.flag_code";
				
				var selType = "S";    //'S'��ѡ��'M'��ѡ
				var retQuence = "0|1|2";//�����ֶ�
				var retToField = "flagCode|flagCodeName|rateCode";//���ظ�ֵ����
				
				if(PubSimpSel(pageTitle,fieldName,sqlStr,selType,retQuence,retToField));
		    }
		} else {
			rdShowMessageDialog("����:"+ retCode + "->" + retMsg, 1);
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
				selectObj.options[selectObj.selectedIndex].text = "���ڻ�ȡ�ֻ��ͺ�......";
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
				selectObj.options[selectObj.selectedIndex].text = "���ڻ�ȡӪ������......";
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
		//getAfterPrompt();	//�º�����
		document.getElementById("opNote").value = "<%=workNo%>Ϊ<%=activePhone%>����<%=opName%>��saleType��"
			+ document.getElementById("saleType").value;

		buttonSub = document.getElementById("submitB");
		buttonSub.disabled = "true";
		
		if (document.getElementById("brandCode").value == "0") {
			rdShowMessageDialog("��ѡ��TD�̻�Ʒ���ͺţ�����Ӧ��Ӫ��������", 1);
			return;
		} else if (document.getElementById("phoneType").value == "0") {
			rdShowMessageDialog("��ѡ��TD�̻��ͺţ�����Ӧ��Ӫ��������", 1);
			return;
		} else if (document.getElementById("saleCode").value == "0") {
			rdShowMessageDialog("��ѡ��Ӫ��������", 1);
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
		
		var ret = showPrtDlg("Detail", "ȷʵҪ���е��������ӡ��","Yes");	//��ӡ���
		
		if(typeof(ret) != "undefined"){
			if (rdShowConfirmDialog("ȷ��Ҫ���д��������") == 1) {
				frm.action = "fb484_cfm.jsp";
				frm.submit();
			} else {
				buttonSub.disabled = "";
			}
		} else {
			if (rdShowConfirmDialog("ȷ��Ҫ���д��������") == 1) {
				frm.action = "fb484_cfm.jsp";
				frm.submit();
			} else {
				buttonSub.disabled = "";
			}
		}
	}
	
	//��ʾ��ӡ�Ի���
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
		
		var pType="subprint";              // ��ӡ���ͣ�print ��ӡ subprint �ϲ���ӡ
		var billType="1";               //  Ʊ�����ͣ�1���������2��Ʊ��3�վ�
		var sysAccept="<%=loginAccept%>";               // ��ˮ��
		var mode_code=null;               //�ʷѴ���
		var fav_code=null;                 //�ط�����
		var area_code=null;             //С������
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

		/********������Ϣ��**********/
		cust_info+="�ֻ����룺"+document.getElementById("activePhone").value+"|";
		cust_info+="�ͻ�������"+document.getElementById("custName").value+"|";
		cust_info+="�ͻ���ַ��<%=result[0][2]%>|";
		cust_info+="֤�����룺<%=result[0][14]%>|";
	
		/********������**********/
		opr_info+="ҵ�����ͣ�<%=opName%>"+"|";
		opr_info+="������ˮ��<%=loginAccept%>|";
		opr_info+="������Ϣ��Ʒ�� "+document.getElementById("brandCode").options[document.getElementById("brandCode").selectedIndex].text
			+ "���ͺ� "+document.getElementById("phoneType").options[document.getElementById("phoneType").selectedIndex].text
			+ "������IMEI "+document.getElementById("imeiCode").value + "|";
		opr_info+="���ͻ��ѣ�"+document.getElementById("Base_Fee").value + "Ԫ����"
			+ parseInt(document.getElementById("Consume_Term").value) + "�������ͣ�"
			+ parseInt(document.getElementById("Consume_Term").value) + "����������ϡ�|";
		if(document.getElementById("Free_fee").value > 0)
		{
			opr_info+="���������ѣ�"+document.getElementById("Free_fee").value+"Ԫ��|";
		}
		opr_info+="ҵ��ִ��ʱ�䣺"+beginTime+"|";
		
		/**********������*********/

		note_info3+=" "+"|";
		note_info4+="��ע��<%=workNo%>Ϊ<%=activePhone%>����<%=opName%>|";
		
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
		
		/********������Ϣ��**********/
		cust_info+="�ֻ����룺"+document.getElementById("activePhone").value+"|";
		cust_info+="�ͻ�������"+document.getElementById("custName").value+"|";
		cust_info+="�ͻ���ַ��<%=result[0][2]%>|";
		cust_info+="֤�����룺<%=result[0][14]%>|";
		
		/********������**********/
		opr_info += "ҵ�����ͣ�<%=opName%>"+"|";
		opr_info += "������ˮ��<%=loginAccept%>|";
		opr_info += "�̻��������ͷ��ã�" + (parseFloat(document.getElementById("Price").value) / parseFloat(document.getElementById("Consume_Term2").value)).toFixed(2)
			+ "Ԫ������Ԥ�棺" + (parseFloat(document.getElementById("Base_Fee2").value)).toFixed(2) + "Ԫ���Ԥ�棺"
			+ (parseFloat(document.getElementById("Free_Fee2").value)).toFixed(2) + "Ԫ��" + parseInt(document.getElementById("Consume_Term2").value)
			+ "�����������|";
		opr_info += "�ֻ��������ͷ���" + (parseFloat(document.getElementById("Phone_Fee").value)/parseFloat(document.getElementById("Active_Term2").value)).toFixed(2)
			+ "Ԫ����" + parseInt(document.getElementById("Active_Term2").value) + "�������ͣ�"
			+ parseInt(document.getElementById("Active_Term2").value) + "�����������|";
			
		note_info1 += "��ע��<%=workNo%>Ϊ<%=activePhone%>����<%=opName%>|";
		
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
	<div id="title_zi">������Ϣ</div>
</div>
<table cellspacing="0">
	<tr>
		<td class="blue" width="20%">
			�绰����
		</td>
		<td width="30%">
			<input type="text" name="activePhone" id="activePhone" value="<%=activePhone%>" v_must="1" class="InputGrey" readonly>
		</td>
		<td class="blue"width="20%">
			��������
		</td>
		<td width="30%">
			<input type="text" name="custName" id="custName" size="40" value="<%=result[0][1]%>" v_must="1" class="InputGrey" readonly>
		</td>
	</tr>
	<tr>
		<td class="blue">
			ҵ��Ʒ��
		</td>
		<td>
			<input name="oSmName" id="oSmName" type="text" class="InputGrey" value="<%=result[0][10]%>" readonly>
		</td>
		<td class="blue">
			�ʷ�����
		</td>
		<td>
			<input name="oModeName" id="oModeName" type="text" class="InputGrey" value="<%=result[0][4]%>" readonly>
		</td>
	</tr>
	<tr>
		<td class="blue">
			�˺�Ԥ��
		</td>
		<td>
			<input name="" id="" type="text" class="InputGrey" value="<%=result[0][11]%>" readonly>
		</td>
		<td class="blue">
			Ӫ������
		</td>
		<td>
			<input name="oSaleCode" id="oSaleCode" type="text" class="InputGrey" value="<%=result[0][19]%>" readonly>
		</td>
	</tr>
	<tr>
		<td class="blue">
			TD�̻�Ʒ�ơ��ͺ�
		</td>
		<td>
			<input name="oPhone" id="oPhone" type="text" class="InputGrey" value="<%=result[0][20]%>" readonly>
		</td>
<%
		if (!"7671".equals(oldOpCode)) {
%>
			<td class="blue">
				������
			</td>
			<td>
				<input name="" id="" type="text" class="InputGrey" value="<%=result[0][21]%>" readonly>
			</td>
<%
		} else {
%>
			<td class="blue">
				�̻�����
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
			���ͻ���
		</td>
		<td>
			<input name="" id="" type="text" class="InputGrey" value="<%=result[0][22]%>" readonly>
		</td>
		<td class="blue">
			������������
		</td>
		<td>
			<input name="" id="" type="text" class="InputGrey" value="<%=result[0][23]%>" readonly>
		</td>
	</tr>
	<tr>
		<td class="blue">
			����������
		</td>
		<td>
			<input name="" id="" type="text" class="InputGrey" value="<%=result[0][24]%>" readonly>
		</td>
		<td class="blue">
			��������������
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
			Ԥ���ܽ��
		</td>
		<td>
			<input name="" id="" type="text" class="InputGrey" value="<%=result[0][26]%>" readonly>
		</td>
<%
	} else {
%>
		<td class="blue">
			Ԥ���ܽ��
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
			����ʱ��
		</td>
		<td>
			<input name="" id="" type="text" class="InputGrey" value="<%=result[0][27]%>" readonly>
		</td>
		<td class="blue">
			����ʱ��
		</td>
		<td>
			<input name="oStopTime" id="oStopTime" type="text" class="InputGrey" value="<%=result[0][28]%>" readonly>
		</td>
	</tr>
</table>

<div class="title">
	<div id="title_zi">Ӫ������</div>
</div>
<table cellspacing="0">
	<tr>
		<td class="blue" width="20%">
			TD�̻�Ʒ��
		</td>
		<td width="30%">
			<SELECT id="brandCode" name="brandCode" v_must=1 v_name="TD�̻�Ʒ��" onchange="changeSelect(this);">
				<option value = "0">--���ڶ�ȡ����ȴ�--</option>
			</select>
			<font class="orange">*</font>
		</td>
		<td class="blue" width="20%">
			TD�̻�����
		</td>
		<td width="30%">
			<select size=1 name="phoneType" id="phoneType" v_name="�ֻ��ͺ�" onchange="changeSelect(this);">
				<option value ="0">--��ѡ��TD�̻�Ʒ��--</option>
			</select>
			<font class="orange">*</font>
		</td>
	</tr>
	<tr>
		<td class="blue">
			Ӫ������
		</td>
		<td>
			<SELECT id="saleCode" name="saleCode" v_must=1 v_name="Ӫ������" onchange="changeSelect(this);">
				<option value = "0">--��ѡ��TD�̻�--</option>
			</select>
			<font class="orange">*</font>
		</td>
		<td class="blue">
			��TD�̻���
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
				���ͻ���
			</td>
			<td>
				<input type="text" name="Base_Fee" id="Base_Fee" value="" class="InputGrey" readonly>
			</td>
			<td class="blue">
				������������
			</td>
			<td>
				<input type="text" name="Consume_Term" id="Consume_Term" value="" class="InputGrey" readonly>
			</td>
		</tr>
		<tr>
			<td class="blue">
				��������
			</td>
			<td>
				<input type="text" name="Free_fee" id="Free_fee" value="" class="InputGrey" readonly>
			</td>
			<td class="blue">
				��������������
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
				����Ԥ��
			</td>
			<td>
				<input name="Base_Fee2" type="text" class="InputGrey" id="Base_Fee2" value="" readonly>
			</td>
			<td class="blue">
				�Ԥ��
			</td>
			<td>
				<input name="Free_Fee2" type="text" class="InputGrey" id="Free_Fee2" value="" readonly>
			</td>
		</tr>
		<tr>
			<td class="blue">
				�̻�����������
			</td>
			<td>
				<input name="Consume_Term2" type="text" class="InputGrey" id="Consume_Term2" value="" readonly>
			</td>
			<td class="blue">
				���ֻ�������
			</td>
			<td>
				<input name="Phone_Fee" type="text" class="InputGrey" id="Phone_Fee" readonly>
			</td>
		</tr>
		<tr>
			<td class="blue">
				�ֻ���������������
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
	<div id="title_zi">���¹���</div>
</div>
<table>
	<tr>
		<td class="blue">
			Ӧ�ս��
		</td>
		<td>
			<input type="text" name="Sale_Price" id="Sale_Price" value="" class="InputGrey" readonly>
		</td>
		<td class="blue">
			�ɷѷ�ʽ
		</td>
		<td>
			<select name="payType" >
				<option value="0">�ֽ�ɷ�</option>
			</select>
		</td>
	</tr>
	<tr>
		<td class="blue">
			IMEI��
		</td>
		<td colspan="3">
			<input type="text" name="imeiCode" id="imeiCode" v_type="0_9" maxlength="20" v_maxlength="20" value="">&nbsp;&nbsp;
			<input type="button" name="checkIcBtn" id="checkIcBtn" value="��ԴУ��" class="b_text" style="" onClick="checkImeiCode();">
			<input type="button" name="changeIcBtn" id="changeIcBtn" value="�޸���Ϣ" class="b_text" style="display:none" onClick="changeImeiCode();">
			<font class="orange">*</font>
		</td>
	</tr>
	<tr>
		<td class="blue">
			����ʱ��
		</td>
		<td width="30%">
			<input name="payTime" type="text" v_name="����ʱ��"  value="<%=new java.text.SimpleDateFormat("yyyyMMdd", Locale.getDefault()).format(new java.util.Date())%>">
			(������)<font color="orange">*</font>
		</td>
		<td class="blue">
			����ʱ��
		</td>
		<td>
			<input name="repairLimit" v_type="date.month"  size="10" type="text" value="12">
			(����)<font color="orange">*</font>
		</td>
	</tr>
</table>

<table cellspacing="0">
	<tr>
	    <td colspan="3" id="footer">
	      <input class="b_foot" type=button name="submitB" id="submitB" disabled="true" value="ȷ��" onClick="submitt();">
	      <input class="b_foot" type=button name="closeB" value="�ر�" onClick="removeCurrentTab();">
	    </td>
	</tr>
</table>
<%@ include file="/npage/include/footer_simple.jsp" %>
</form>
</body>
</html>

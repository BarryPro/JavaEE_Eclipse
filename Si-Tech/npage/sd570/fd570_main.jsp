<%
/********************
 version v2.0
 ������: si-tech
 ģ��: ���ּ�ͥ
 create by wanghfa 2011/5/16
********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html  xmlns="http://www.w3.org/1999/xhtml">

<%
  response.setHeader("Pragma","No-Cache"); 
  response.setHeader("Cache-Control","No-Cache");
  response.setDateHeader("Expires", 0); 
  request.setCharacterEncoding("GBK");
%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ include file="/npage/common/pwd_comm.jsp" %>
<%@ page contentType="text/html;charset=GBK"%>
<%@ page import="java.util.*"%>
<%@ page import="java.text.*" %>
<%
  String opCode = request.getParameter("opCode");
  String opName = request.getParameter("opName");
  String comboType = request.getParameter("comboType");
  String workNo = (String)session.getAttribute("workNo");
  String password = (String)session.getAttribute("password");
  String ipAddr = (String)session.getAttribute("ipAddr");
	String regionCode = (String)session.getAttribute("regCode");			//����
  
  System.out.println("====fd570_main.jsp====wanghfa==== opCode = " + opCode);
  System.out.println("====fd570_main.jsp====wanghfa==== opName = " + opName);

	String result[][] = new String[2][16];
	
	String saleType = "42";
%>
	<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="phone" routerValue="<%=activePhone%>" id="printAccept"/>
<%
	System.out.println("====wanghfa=====sOfferQry====0====== loginAccept = 0");
	System.out.println("====wanghfa=====sOfferQry====1====== iChnSource = 01");
	System.out.println("====wanghfa=====sOfferQry====2====== inOpCode = " + opCode);
	System.out.println("====wanghfa=====sOfferQry====3====== inLoginNo = " + workNo);
	System.out.println("====wanghfa=====sOfferQry====4====== iLoginPwd= " + password);
	System.out.println("====wanghfa=====sOfferQry====5====== inPhone = " + activePhone);
	System.out.println("====wanghfa=====sOfferQry====6====== inUserPwd = ");
	System.out.println("====wanghfa=====sOfferQry====7====== iFamilyType = " + comboType);
%>
	
	<wtc:service name="sOfferQry" routerKey="phone" routerValue="<%=activePhone%>" retcode="retCode1" retmsg="retMsg1" outnum="16">
		<wtc:param value="0"/>
		<wtc:param value="01"/>
		<wtc:param value="<%=opCode%>"/>
		<wtc:param value="<%=workNo%>"/>
		<wtc:param value="<%=password%>"/>
		<wtc:param value="<%=activePhone%>"/>
		<wtc:param value=""/>
		<wtc:param value="<%=comboType%>"/>
	</wtc:service>
	<wtc:array id="result1"  scope="end"/>
<%
	System.out.println("====wanghfa=====sOfferQry : " + retCode1 + "," + retMsg1);
	
	if (!retCode1.equals("000000")) {
%>
		<script language="JavaScript">
			rdShowMessageDialog("sOfferQry���룺<%=retCode1%>����Ϣ��<%=retMsg1%>",0);
			history.go(-1);
		</script>
<%
	} else {
		System.out.println("====wanghfa=====sOfferQry result1.length = " + result1.length);
		if (result1.length > 0) {
			for (int j = 0; j < result1[0].length; j ++) {
				System.out.println("====wanghfa=====sOfferQry==== result1[0]["+j+"] = " + result1[0][j]);
				result[0][j] = result1[0][j];
			}
		}
	}
	System.out.println("====wanghfa====fd570_main.jsp====sd570Init====0==== inLoginAccept = 0");
	System.out.println("====wanghfa====fd570_main.jsp====sd570Init====1==== iChnSource = 01");
	System.out.println("====wanghfa====fd570_main.jsp====sd570Init====2==== inOpCode = " + opCode);
	System.out.println("====wanghfa====fd570_main.jsp====sd570Init====3==== inLoginNo = " + workNo);
	System.out.println("====wanghfa====fd570_main.jsp====sd570Init====4==== iLoginPwd = " + password);
	System.out.println("====wanghfa====fd570_main.jsp====sd570Init====5==== inPhone = " + activePhone);
	System.out.println("====wanghfa====fd570_main.jsp====sd570Init====6==== inUserPwd = ");
	System.out.println("====wanghfa====fd570_main.jsp====sd570Init====7==== IPhoneType = 0");
	System.out.println("====wanghfa====fd570_main.jsp====sd570Init====8==== iIpAddr = " + ipAddr);
	System.out.println("====wanghfa====fd570_main.jsp====sd570Init====9==== iFamilyType = " + comboType);
	System.out.println("====wanghfa====fd570_main.jsp====sd570Init===10==== iNewOfferid = " + result[0][0]);
	%>
		<wtc:service name="sd570Init" routerKey="phone" routerValue="<%=activePhone%>" retcode="retCode2" retmsg="retMsg2" outnum="12">
			<wtc:param value="0"/>
			<wtc:param value="01"/>
			<wtc:param value="<%=opCode%>"/>
			<wtc:param value="<%=workNo%>"/>
			<wtc:param value="<%=password%>"/>
			<wtc:param value="<%=activePhone%>"/>
			<wtc:param value=""/>
			<wtc:param value="0"/>
			<wtc:param value="<%=ipAddr%>"/>
			<wtc:param value="<%=comboType%>"/>
			<wtc:param value="<%=result[0][0]%>"/>
		</wtc:service>
		<wtc:array id="result2"  scope="end"/>
	<%
	System.out.println("====wanghfa====fd570_main.jsp====sd570Init==== " + retCode2 + "," + retMsg2);
	
	if (!retCode2.equals("000000")) {
%>
		<script language="JavaScript">
			rdShowMessageDialog("sd570Init���룺<%=retCode2%>����Ϣ��<%=retMsg2%>",0);
			history.go(-1);
		</script>
<%
	} else {
		System.out.println("====wanghfa====fd570_main.jsp====sd570Init==== result2.length = " + result2.length);
		if (result.length > 0) {
			for (int j = 0; j < result2[0].length; j ++) {
				System.out.println("====wanghfa====fd570_main.jsp====sd570Init==== result2[0]["+j+"] = " + result2[0][j]);
				result[1][j] = result2[0][j];
			}
		}
	}

%>
<%
  //�ֻ�Ʒ��
  String sqlBrandCode = "select  unique a.brand_code,trim(b.brand_name) from dphoneSaleCode a,schnresbrand b where a.region_code='" + regionCode + "' and a.sale_type='" + saleType +"' and a.brand_code=b.brand_code and a.valid_flag='Y' and spec_type = '" + comboType + "'";
  String[] inParamBrandCode = new String[2];
  inParamBrandCode[0] = "select  unique a.brand_code,trim(b.brand_name) from dphoneSaleCode a,schnresbrand b where a.region_code=:region_code and a.sale_type='" + saleType +"' and a.brand_code=b.brand_code and a.valid_flag='Y' and spec_type = '" + comboType + "'";
  inParamBrandCode[1] = "region_code=" + regionCode;
  System.out.println("sqlBrandCode=====" + sqlBrandCode);
%>
	<wtc:service name="TlsPubSelCrm" routerKey="phone" routerValue="<%=activePhone%>" retcode="retCodeBrandCode" retmsg="retMsgBrandCode" outnum="2">
		<wtc:param value="<%=inParamBrandCode[0]%>"/>
	<wtc:param value="<%=inParamBrandCode[1]%>"/>
	</wtc:service>
	<wtc:array id="resultBrandCode"  scope="end"/>
<%
	System.out.println("=======fb480_main.jsp======wanghfa======== TlsPubSelCrm �ֻ�Ʒ�Ʋ�ѯ��" + retCodeBrandCode + ", " + retMsgBrandCode);
	if ("000000".equals(retCodeBrandCode)) {
		for (int i = 0; i < resultBrandCode.length; i ++) {
			System.out.println("====fb480_main.jsp====wanghfa==== brandCode=" + resultBrandCode[i][0] + ", brandName=" + resultBrandCode[i][1]);
		}
	}
%>

<%
//�ֻ�����
	String sqlPhoneType = "select unique a.type_code,trim(b.res_name), b.brand_code from dphoneSaleCode a,schnrescode_chnterm b where a.region_code='" + regionCode + "' and  a.type_code=b.res_code and a.brand_code=b.brand_code and a.sale_type='" + saleType +"' and a.valid_flag='Y' and spec_type = '" + comboType + "'";
	String[] inParamPhoneType = new String[2];
	inParamPhoneType[0] = "select unique a.type_code,trim(b.res_name), b.brand_code from dphoneSaleCode a,schnrescode_chnterm b where a.region_code=:region_code and  a.type_code=b.res_code and a.brand_code=b.brand_code and a.sale_type='" + saleType +"'and a.valid_flag='Y' and spec_type = '" + comboType + "'";
	inParamPhoneType[1] = "region_code=" + regionCode;
	System.out.println("sqlPhoneType=====" + sqlPhoneType);
%>
	<wtc:service name="TlsPubSelCrm" routerKey="phone" routerValue="<%=activePhone%>" retcode="retCodePhoneType" retmsg="retMsgPhoneType" outnum="3">
	<wtc:param value="<%=inParamPhoneType[0]%>"/>
	<wtc:param value="<%=inParamPhoneType[1]%>"/>
	</wtc:service>
	<wtc:array id="resultPhoneType"  scope="end"/>
<%
	System.out.println("=======fb480_main.jsp======wanghfa======== TlsPubSelCrm �ֻ����Ͳ�ѯ��" + retCodePhoneType + ", " + retMsgPhoneType);
	if ("000000".equals(retCodePhoneType)) {
		for (int i = 0; i < resultPhoneType.length; i ++) {
			System.out.println("====fb480_main.jsp====wanghfa==== phoneType=" + resultPhoneType[i][0] + ", phoneName=" + resultPhoneType[i][1] + ", phoneCode=" + resultPhoneType[i][2]);
		}
	}
%>

<%
//Ӫ������
	String sqlSaleType = "select unique trim(a.sale_code),trim(a.sale_name), a.brand_code,a.type_code from dphoneSaleCode a where a.region_code='" + regionCode + "' and a.sale_type='" + saleType +"' and a.valid_flag='Y' and spec_type = '" + comboType + "'";
	String[] inParamSaleType = new String[2];
	inParamSaleType[0] = "select unique trim(a.sale_code),trim(a.sale_name), a.brand_code,a.type_code from dphoneSaleCode a where a.region_code=:region_code and a.sale_type='" + saleType +"' and a.valid_flag='Y' and spec_type = '" + comboType + "'";
	inParamSaleType[1] = "region_code=" + regionCode;
	System.out.println("sqlSaleType====="+sqlSaleType);
%>
	<wtc:service name="TlsPubSelCrm" routerKey="phone" routerValue="<%=activePhone%>" retcode="retCodeSaleType" retmsg="retMsgSaleType" outnum="4">
	<wtc:param value="<%=inParamSaleType[0]%>"/>
	<wtc:param value="<%=inParamSaleType[1]%>"/>
	</wtc:service>
	<wtc:array id="resultSaleType"  scope="end"/>
<%
	System.out.println("=======fb480_main.jsp======wanghfa======== TlsPubSelCrm Ӫ�������ѯ��" + retCodeSaleType + ", " + retMsgSaleType);
	if ("000000".equals(retCodeSaleType)) {
		for (int i = 0; i < resultSaleType.length; i ++) {
			System.out.println("====fb480_main.jsp====wanghfa=====saleCode=" + resultSaleType[i][0] + ", saleName=" + resultSaleType[i][1] + ", phoneBrand=" + resultSaleType[i][2] + ", phoneType=" + resultSaleType[i][3]);
		}
	}
%>

<%
//Ӫ����ϸ
	String sqlSaleInfo = "select to_char(to_number(sale_price)-to_number(prepay_gift)-to_number(prepay_limit)),prepay_gift,to_char(consume_term),prepay_limit,to_char(active_term),mon_base_fee,all_gift_price,sale_price,trim(sale_code),market_price from dphoneSaleCode  where region_code='" + regionCode + "' and sale_type='" + saleType +"' and valid_flag='Y' and spec_type = '" + comboType + "'";
	String[] inParamSaleInfo = new String[2];
	inParamSaleInfo[0] = "select to_char(to_number(sale_price)-to_number(prepay_gift)-to_number(prepay_limit)),prepay_gift,to_char(consume_term),prepay_limit,to_char(active_term),mon_base_fee,all_gift_price,sale_price,trim(sale_code),market_price from dphoneSaleCode where region_code=:region_code and sale_type='" + saleType +"' and valid_flag='Y' and spec_type = '" + comboType + "'";
	inParamSaleInfo[1] = "region_code=" + regionCode;
	System.out.println("sqlSaleInfo=====" + sqlSaleInfo);
%>
	<wtc:service name="TlsPubSelCrm" routerKey="phone" routerValue="<%=activePhone%>" retcode="retCodeSaleInfo" retmsg="retMsgSaleInfo" outnum="12">
	<wtc:param value="<%=inParamSaleInfo[0]%>"/>
	<wtc:param value="<%=inParamSaleInfo[1]%>"/>
	</wtc:service>
	<wtc:array id="resultSaleInfo"  scope="end"/>
<%
	System.out.println("=======fb480_main.jsp======wanghfa======== TlsPubSelCrm Ӫ����ϸ��ѯ��" + retCodeSaleInfo + ", " + retMsgSaleInfo);
	if ("000000".equals(retCodeSaleInfo)) {
		for (int i = 0; i < resultSaleInfo.length; i ++) {
			System.out.println("====fb480_main.jsp====wanghfa===== (�û��ɷѺϼ�-�Ԥ��-����������)salePhone=" + resultSaleInfo[i][0] + ", �Ԥ��saleBase=" + resultSaleInfo[i][1] + ", �Ԥ�淵���·�saleConsumeTerm=" + resultSaleInfo[i][2] + ", ����������saleFree=" + resultSaleInfo[i][3] + ", �����ѷ����·�saleActiveTerm=" + resultSaleInfo[i][4] + ", ����Ԥ��saleMonBase=" + resultSaleInfo[i][5] + ", saleAllGiftPrice=" + resultSaleInfo[i][6] + ", �û��ɷѺϼ�saleSalePrice=" + resultSaleInfo[i][7] + ", saleCode=" + resultSaleInfo[i][8] + ", TD�̻��г���saleMarketPrice=" + resultSaleInfo[i][9]);
		}
	}

%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>���ּ�ͥ</title>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">

<script language=javascript>
	var flagTD = "true";
	var arrBrandCode = new Array();//�ֻ�Ʒ�ƴ���
	var arrBrandName = new Array();//�ֻ�Ʒ������
<%
	for (int a = 0; a < resultBrandCode.length; a ++) {
%>
		arrBrandCode[<%=a%>] = "<%=resultBrandCode[a][0]%>";
		arrBrandName[<%=a%>] = "<%=resultBrandCode[a][1]%>";
<%
	}
%>
	var arrPhoneType = new Array();//�ֻ��ͺŴ���
	var arrPhoneName = new Array();//�ֻ��ͺ�����
	var arrPhoneBrandCode = new Array();//�ֻ�Ʒ�ƴ���
<%
	for (int a = 0; a < resultPhoneType.length; a ++) {
%>
		arrPhoneType[<%=a%>] = "<%=resultPhoneType[a][0]%>";
		arrPhoneName[<%=a%>] = "<%=resultPhoneType[a][1]%>";
		arrPhoneBrandCode[<%=a%>] = "<%=resultPhoneType[a][2]%>";
<%
	}
%>
	var arrSaleCode = new Array();//Ӫ������
	var arrSaleName = new Array();//Ӫ������
	var arrSalePhoneBrand = new Array();//�ֻ�Ʒ�ƴ���
	var arrSalePhoneType = new Array();//�ֻ��ͺŴ���
<%
	for (int a = 0; a < resultSaleType.length; a ++) {
%>
		arrSaleCode[<%=a%>] = "<%=resultSaleType[a][0]%>";
		arrSaleName[<%=a%>] = "<%=resultSaleType[a][1]%>";
		arrSalePhoneBrand[<%=a%>] = "<%=resultSaleType[a][2]%>";
		arrSalePhoneType[<%=a%>] = "<%=resultSaleType[a][3]%>";
<%
	}
%>
	var arrdetphone=new Array();		//��TD�̻���
	var arrdetbase=new Array();			//���ͻ���
	var arrdetconsumeterm=new Array();	//������������
	var arrdetfree=new Array();			//��������
	var arrdetactiveterm=new Array();	//��������������
	var arrdetsaleprice=new Array();	//Ӧ�ս��
	var arrdetsalecode=new Array();		//Ӫ������
	var arrdetmonbase=new Array();		//����Ԥ�棨���أ�
<%
	for (int a = 0; a < resultSaleInfo.length; a ++) {
%>
		arrdetphone[<%=a%>] = "<%=resultSaleInfo[a][0]%>";
		arrdetbase[<%=a%>] = "<%=resultSaleInfo[a][1]%>";
		arrdetconsumeterm[<%=a%>] = "<%=resultSaleInfo[a][2]%>";
		arrdetfree[<%=a%>] = "<%=resultSaleInfo[a][3]%>";
		arrdetactiveterm[<%=a%>] = "<%=resultSaleInfo[a][4]%>";
		arrdetmonbase[<%=a%>] = "<%=resultSaleInfo[a][5]%>";
		arrdetsaleprice[<%=a%>] = "<%=resultSaleInfo[a][7]%>";
		arrdetsalecode[<%=a%>] = "<%=resultSaleInfo[a][8]%>";
<%
	}
%>
	window.onload = function() {
		tdChange();
		getBrandCode();
	}
	
	function getBrandCode() {
		document.getElementById("brandCode").options.length = 0;
		
		var optionI = document.createElement("option");
		optionI.value = "0";
		optionI.text = "--��ѡ��--";
		document.getElementById("brandCode").add(optionI);
		
		for (var i = 1; i <= arrBrandCode.length; i ++) {
			var optionI = document.createElement("option");
			optionI.value = arrBrandCode[i-1];
			optionI.text = arrBrandName[i-1];
			
			document.getElementById("brandCode").add(optionI);
		}
		getPhoneType();
	}
	
	function getPhoneType() {
		document.getElementById("phoneType").options.length = 0;
		
		var optionI = document.createElement("option");
		optionI.value = "0";
		optionI.text = "--��ѡ��--";
		document.getElementById("phoneType").add(optionI);
		
		for (var i = 1; i <= arrPhoneType.length; i ++) {
			var brandCodeObj = document.getElementById("brandCode");
			if (arrPhoneBrandCode[i - 1] == brandCodeObj.options[brandCodeObj.selectedIndex].value) {
				var optionI = document.createElement("option");
				optionI.value = arrPhoneType[i - 1];
				optionI.text = arrPhoneName[i - 1];
				document.getElementById("phoneType").add(optionI);
			}
		}
		getSaleCode();
		//getSaleInfo();
	}
	
	function getSaleCode() {
		document.getElementById("saleCode").options.length = 0;
		
		var optionI = document.createElement("option");
		optionI.value = "0";
		optionI.text = "--��ѡ��--";
		document.getElementById("saleCode").add(optionI);
		
		for (var i = 1; i <= arrSaleCode.length; i ++) {
			var brandCodeObj = document.getElementById("brandCode");
			var phoneTypeObj = document.getElementById("phoneType");
			
			if (arrSalePhoneBrand[i - 1] == brandCodeObj.options[brandCodeObj.selectedIndex].value && arrSalePhoneType[i - 1] == phoneTypeObj.options[phoneTypeObj.selectedIndex].value) {
				var optionI = document.createElement("option");
				optionI.value = arrSaleCode[i - 1];
				optionI.text = arrSaleName[i - 1];
				
				document.getElementById("saleCode").add(optionI);
			}
		}
		//getModeCode('mModeCode');
	}
	
	function showSaleInfo(saleCode, brandName, phoneType) {
		var saleCode;
		var saleName;
		if (typeof(brandName) == "undefined") {
			brandName = document.getElementById("brandCode").options[document.getElementById("brandCode").selectedIndex].text;
			phoneType = document.getElementById("phoneType").options[document.getElementById("phoneType").selectedIndex].text;
		}
		//saleName = document.getElementById("saleCode").options[document.getElementById("saleCode").selectedIndex].text;
		
		for (var i = 0; i < arrdetsalecode.length; i ++) {
			if (arrdetsalecode[i] == saleCode) {
				var valSaleInfo = new Array();
				valSaleInfo[0] = arrdetphone[i];
				valSaleInfo[1] = arrdetbase[i];
				valSaleInfo[2] = arrdetconsumeterm[i];
				valSaleInfo[3] = arrdetfree[i];
				valSaleInfo[4] = arrdetactiveterm[i];
				valSaleInfo[5] = arrdetsaleprice[i];
				valSaleInfo[6] = arrdetsalecode[i];
				
				var retV = showModalDialog("mdialog_showSaleInfo.jsp?opCode=<%=opCode%>&opName=<%=opName%>&brandName="+brandName+"&phoneType="+phoneType+"&valSaleInfo="+valSaleInfo, null, "dialogWidth=600px;dialogHeight=300px");
				return;
			}
		}
	}
	
	function tdChange() {
		if (document.getElementsByName("tdFlag")[0].checked) {
			document.getElementById("newTDDiv").style.display = "none";
			document.getElementById("tdAdd").disabled = false;
		} else if (document.getElementsByName("tdFlag")[1].checked) {
			document.getElementById("newTDDiv").style.display = "";
			if (document.getElementById("imeiCode").disabled == true) {
				document.getElementById("tdAdd").disabled = false;
			} else {
				document.getElementById("tdAdd").disabled = true;
			}
		}
	}
	
	function check147SuperTD(phoneNo){
		var phoneHead = phoneNo.substring(0,3);
		var check_Packet = new AJAXPacket("/npage/bill/check147SuperTD.jsp","���ڽ���У�飬���Ժ�......");
		check_Packet.data.add("phoneNo",phoneNo);
		core.ajax.sendPacket(check_Packet,getResult,false);
		check_Packet=null;
	}
	function check157SuperTD(phoneNo){
		var phoneHead = phoneNo.substring(0,3);
		var check_Packet = new AJAXPacket("/npage/bill/check157SuperTD.jsp","���ڽ���У�飬���Ժ�......");
		check_Packet.data.add("phoneNo",phoneNo);
		core.ajax.sendPacket(check_Packet,getResult,false);
		check_Packet=null;
	}
	function check184SuperTD(phoneNo){
		var phoneHead = phoneNo.substring(0,3);
		var check_Packet = new AJAXPacket("/npage/bill/check184SuperTD.jsp","���ڽ���У�飬���Ժ�......");
		check_Packet.data.add("phoneNo",phoneNo);
		core.ajax.sendPacket(check_Packet,getResult,false);
		check_Packet=null;
	}
	function getResult(packet){
		var result = packet.data.findValueByName("result");
		if("false"==result){
			flagTD = "false";
		}else{
			flagTD = "true";
		}
	}

	function checkTd() {
		var tdPhoneObj = document.getElementById("tdPhone");
		//var tdPhonePwdObj = document.getElementById("tdPhonePwd");
		var phoneHead = tdPhoneObj.value.substring(0,3);
		
		if (typeof(document.getElementById("tdPhoneMsg").childNodes[0].childNodes[1]) != "undefined") {
			rdShowMessageDialog("��ǰҵ�����ֻ�������һ��TD�̻����û���", 1);
			return false;
		} else if (checkElement(tdPhoneObj) == false) {
			rdShowMessageDialog("������TD�̻����룡", 1);
			tdPhoneObj.focus();
			return false;
		} else if (tdPhoneObj.value.trim().length != 11) {
			rdShowMessageDialog("������11λ��TD�̻��绰���룡", 1);
			tdPhoneObj.focus();
			return false;
		//} else if (tdPhonePwdObj.value.length != 6) {
		//	rdShowMessageDialog("������6λTD�̻����룡", 1);
		//	tdPhonePwdObj.focus();
		//	return false;
		} 
			if(phoneHead == '147'){
				check147SuperTD(tdPhoneObj.value);
				if(flagTD == "false"){
				rdShowMessageDialog("147�Ŷ�ֻ��TD����������ܰ����ҵ��", 1);
				return false;
			}
			}
			if(phoneHead == '157'){
				check157SuperTD(tdPhoneObj.value);
				if(flagTD == "false"){
				rdShowMessageDialog("157�Ŷ�ֻ��TD����������ܰ����ҵ��", 1);
				return false;
			}
			}
			if(phoneHead == '184'){
				check184SuperTD(tdPhoneObj.value);
				if(flagTD == "false"){
				rdShowMessageDialog("184�Ŷ�ֻ��TD����������ܰ����ҵ��", 1);
				return false;
			}
			}
			 else{
				rdShowMessageDialog("ֻ��147��157��184�Ŷ�TD����������ܰ����ҵ��", 1);
				return false;
			}
		
		getTdMsg();
	}
	
	function getTdMsg() {
		var retV = showModalDialog("mdialog_phoneDetail.jsp?opCode=<%=opCode%>&opName=<%=opName%>&phoneNo=" 
			+ document.getElementById("tdPhone").value + "&phoneType=1&comboType=<%=comboType%>&newOfferId=<%=result[0][4]%>", 
			document, "dialogWidth=600px;dialogHeight=300px");
		if (retV == "n") {
			return false;
		} else if (retV.split("|")[0] == "n") {
			rdShowMessageDialog(retV.split("|")[1], 0);
			return false;
		} else if (retV.split("|")[0] == "y") {
			var trTemp = document.getElementById("tdPhoneMsg").insertRow();
			trTemp.insertCell().innerHTML = "<input type='button' class='b_text' name='' id='' value='ɾ��' onclick='deleteTdRow(this)'/>";
			trTemp.insertCell().innerHTML = "<input type='text' class='InputGrey' name='tdCustName' id='tdCustName' value='" + retV.split("|")[1] + "' readonly>" 
				+ "<input type='hidden' name='tdBrandName' id='tdBrandName' value='" 
				+ document.getElementById("brandCode").options[document.getElementById("brandCode").selectedIndex].text + "' />" 
				+ "<input type='hidden' name='tdPhoneTypeName' id='tdPhoneTypeName' value='" 
				+ document.getElementById("phoneType").options[document.getElementById("phoneType").selectedIndex].text + "' />";
			trTemp.insertCell().innerHTML = "<input type='text' class='InputGrey' name='tdUserPhone' id='tdUserPhone' value='" + retV.split("|")[2] + "' readonly>";
			trTemp.insertCell().innerHTML = retV.split("|")[3];
			document.getElementById("tdCustAddr").value = retV.split("|")[4];
			
			var saleStr = "";
			var tdUserMsg = retV.split("|")[1] + "|" + retV.split("|")[2] + "|" + retV.split("|")[4];
			
			if (document.getElementsByName("tdFlag")[0].checked) {
				saleStr += "0|";
				tdUserMsg += "|0";
				trTemp.insertCell().innerHTML = "��";
				trTemp.insertCell().innerHTML = "��";
				trTemp.insertCell().innerHTML = "0" 
					+ "<input type='hidden' name='saleStr' id='saleStr' value='" + saleStr + "' />" 
					+ "<input type='hidden' name='tdUserMsg' value='" + tdUserMsg + "' />";
			} else if (document.getElementsByName("tdFlag")[1].checked) {
				saleStr += "1";
				trTemp.insertCell().innerHTML = "��";
				trTemp.insertCell().innerHTML = document.getElementById("saleCode").options[document.getElementById("saleCode").selectedIndex].text 
					+ "&nbsp;<input type='button' name='' id='' value='Ӫ����ϸ' class='b_text' onClick=\"showSaleInfo('" 
					+ document.getElementById("saleCode").value + "', '" 
					+ document.getElementById("brandCode").options[document.getElementById("brandCode").selectedIndex].text + "', '" 
					+ document.getElementById("phoneType").options[document.getElementById("phoneType").selectedIndex].text + "');\" >";
				
				saleStr += "|" + document.getElementById("saleCode").value;
				saleStr += "|" + document.getElementById("imeiCode").value;
				saleStr += "|" + document.getElementById("brandCode").options[document.getElementById("brandCode").selectedIndex].text;
				saleStr += "|" + document.getElementById("phoneType").options[document.getElementById("phoneType").selectedIndex].text;
				
				for (var i = 0; i < arrdetsalecode.length; i ++) {
					if (arrdetsalecode[i] == document.getElementById("saleCode").value) {
						saleStr += "|" + arrdetsaleprice[i];
						saleStr += "|" + arrdetconsumeterm[i];
						tdUserMsg += "|" + arrdetsaleprice[i];
						tdUserMsg += "|" + document.getElementById("brandCode").options[document.getElementById("brandCode").selectedIndex].text;
						tdUserMsg += "|" + document.getElementById("phoneType").options[document.getElementById("phoneType").selectedIndex].text;
						tdUserMsg += "|" + document.getElementById("imeiCode").value;
						
						trTemp.insertCell().innerHTML = "<input type='text' class='InputGrey' name='salePrice' id='salePrice' value='" + arrdetsaleprice[i] + "' readonly>" 
							+ "<input type='hidden' name='saleStr' value='" + saleStr + "' />" 
							+ "<input type='hidden' name='tdUserMsg' value='" + tdUserMsg + "' />";
						
					}
				}
			}
			
			document.getElementById("tdPhone").value = "";
			document.getElementsByName("tdFlag")[0].checked = true;
			tdChange();
			getBrandCode();
			document.getElementById("imeiCode").value = "";
			document.getElementById("brandCode").disabled = false;
			document.getElementById("phoneType").disabled = false;
			document.getElementById("saleCode").disabled = false;
			document.getElementById("imeiCode").disabled = false;
		}
	}
	
	function checkGsm() {
		var gsmPhoneObj = document.getElementById("gsmPhone");
		
		if (typeof(document.getElementById("gsmPhoneMsg").childNodes[0].childNodes[1]) != "undefined") {
			rdShowMessageDialog("��ǰҵ�����ֻ�������һ��GSM�����û���", 1);
			return false;
		} else if (checkElement(gsmPhoneObj) == false) {
			rdShowMessageDialog("������GSM�����û����룡", 1);
			gsmPhoneObj.focus();
			return false;
		} else if (gsmPhoneObj.value.trim().length != 11) {
			rdShowMessageDialog("������11λ��GSM�绰���룡", 1);
			gsmPhoneObj.focus();
			return false;
		} else if (gsmPhoneObj.value == document.getElementById("activePhone").value) {
			rdShowMessageDialog("GSM�����û����벻�������û�������ͬ��", 1);
			gsmPhoneObj.focus();
			return false;
		}
			getGsmMsg();

	}
	
	function getGsmMsg() {
		var retV = showModalDialog("mdialog_phoneDetail.jsp?opCode=<%=opCode%>&opName=<%=opName%>&phoneNo=" 
			+ document.getElementById("gsmPhone").value + "&phoneType=2&comboType=<%=comboType%>&newOfferId=<%=result[0][8]%>", 
			document, "dialogWidth=600px;dialogHeight=300px");
		if (retV == "n") {
			return false;
		} else if (retV.split("|")[0] == "n") {
			rdShowMessageDialog(retV.split("|")[1], 1);
			return false;
		} else if (retV.split("|")[0] == "y") {
			var trTemp = document.getElementById("gsmPhoneMsg").insertRow();
			trTemp.insertCell().innerHTML = "<input type='button' class='b_text' name='' id='' value='ɾ��' onclick='deleteGsmRow(this)'/>";
			trTemp.insertCell().innerHTML = "<input type='text' class='InputGrey' name='gsmCustName' id='gsmCustName' value='" + retV.split("|")[1] + "' readonly>";
			trTemp.insertCell().innerHTML = "<input type='text' class='InputGrey' name='gsmUserPhone' id='gsmUserPhone' value='" + retV.split("|")[2] + "' readonly>";
			trTemp.insertCell().innerHTML = retV.split("|")[3];
			
			document.getElementById("gsmPhone").value = "";
		}
	}
	
	function deleteTdRow(obj){
		var tableTemp = document.getElementById("tdPhoneMsg");
		tableTemp.deleteRow(obj.parentElement.parentElement.rowIndex);
	}
	
	function deleteGsmRow(obj){
		var tableTemp = document.getElementById("gsmPhoneMsg");
		tableTemp.deleteRow(obj.parentElement.parentElement.rowIndex);
	}
	
	//���IMEI��
	function checkImeiCode() {	//mImeiCode  mCheckImeiCode
		var imeiCode = document.getElementById("imeiCode");
		var brandCodeObj = document.getElementById("brandCode");
		var phoneTypeObj = document.getElementById("phoneType");
		
		var checkImeiPacket = new AJAXPacket("/npage/s1141/queryimei.jsp", "����У��IMEI��Ϣ�����Ժ�......");
		
		checkImeiPacket.data.add("imei_no", document.getElementById("imeiCode").value);
		checkImeiPacket.data.add("brand_code", brandCodeObj.value);
		checkImeiPacket.data.add("style_code", phoneTypeObj.value);
		checkImeiPacket.data.add("opcode", "d570");
		checkImeiPacket.data.add("retType","0");
		
		core.ajax.sendPacket(checkImeiPacket, doCheckImeiCode);
		checkImeiPacket=null;
	}
	
	function doCheckImeiCode(packet) {
		var retType=packet.data.findValueByName("retType");
		var retResult=packet.data.findValueByName("retResult");
		
		if(retResult == "000000"){
			rdShowMessageDialog("IMEI��У��ɹ���", 2);
			document.getElementById("tdAdd").disabled = false;
			document.getElementById("brandCode").disabled = true;
			document.getElementById("phoneType").disabled = true;
			document.getElementById("saleCode").disabled = true;
			document.getElementById("imeiCode").disabled = true;
			return;
		} else if (retResult == "000003") {
			rdShowMessageDialog("IMEI�Ų���ӪҵԱ����Ӫҵ����IMEI����ҵ�������Ͳ�����", 1);
			document.getElementById("tdAdd").disabled = true;
			return;
		} else {
			rdShowMessageDialog("IMEI�Ų����ڻ����Ѿ�ʹ�ã�", 1);
			document.getElementById("tdAdd").disabled = true;
			return;
		}
	}
	
	
	function submitt() {
		var buttonSub = document.getElementById("submitB");
		buttonSub.disabled = true;
		
		if (typeof(document.getElementById("tdPhoneMsg").childNodes[0].childNodes[1]) == "undefined") {
			rdShowMessageDialog("��¼��Ҫ�����TD�̻����û���", 1);
			document.getElementById("tdPhone").focus();
			buttonSub.disabled = false;
			return;
		} else if ("<%=comboType%>" == "B" && typeof(document.getElementById("gsmPhoneMsg").childNodes[0].childNodes[1]) == "undefined") {
			rdShowMessageDialog("��¼��Ҫ�����GSM�����û���", 1);
			document.getElementById("gsmPhone").focus();
			buttonSub.disabled = false;
			return;
		}
		
		var tdUserPhoneArr = new Array();
		var gsmUserPhoneArr = new Array();
		var tdMOfferIdStr = new Array();
		var tdAOfferIdStr = new Array();
		var gsmMOfferIdStr = new Array();
		var gsmAOfferIdStr = new Array();
		var saleStrStr = new Array();
		var tdUserMsgStr = "";
		
		for (var i = 0; i < document.getElementsByName("tdUserPhone").length; i ++) {
			tdUserPhoneArr[i] = document.getElementsByName("tdUserPhone")[i].value;
			tdMOfferIdStr[i] = document.getElementById("tdMOfferId").value;
			tdAOfferIdStr[i] = document.getElementById("tdAOfferId").value;
			saleStrStr[i] = document.getElementsByName("saleStr")[i].value;
			if (tdUserMsgStr == "") {
				tdUserMsgStr += document.getElementsByName("tdUserMsg")[i].value;
			} else {
				tdUserMsgStr += "~" + document.getElementsByName("tdUserMsg")[i].value;
			}
		}
		for (var i = 0; i < document.getElementsByName("gsmUserPhone").length; i ++) {
			gsmUserPhoneArr[i] = document.getElementsByName("gsmUserPhone")[i].value;
			gsmMOfferIdStr[i] = document.getElementById("gsmMOfferId").value;
			gsmAOfferIdStr[i] = document.getElementById("gsmAOfferId").value;
		}
		document.getElementById("tdUserPhoneStr").value = tdUserPhoneArr;
		document.getElementById("gsmUserPhoneStr").value = gsmUserPhoneArr;
		document.getElementById("tdMOfferIdStr").value = tdMOfferIdStr;
		document.getElementById("tdAOfferIdStr").value = tdAOfferIdStr;
		document.getElementById("gsmMOfferIdStr").value = gsmMOfferIdStr;
		document.getElementById("gsmAOfferIdStr").value = gsmAOfferIdStr;
		document.getElementById("saleStrStr").value = saleStrStr;
		document.getElementById("tdUserMsgStr").value = tdUserMsgStr;

		var ret = showPrtDlg("Detail", "ȷʵҪ���е��������ӡ��","Yes");	//��ӡ���
		
		if(typeof(ret) != "undefined"){
			if (rdShowConfirmDialog("ȷ��Ҫ���д��������") == 1) {
				frm.submit();
			} else {
				buttonSub.disabled = false;
			}
		} else {
			if (rdShowConfirmDialog("ȷ��Ҫ���д��������") == 1) {
				frm.submit();
			} else {
				buttonSub.disabled = false;
			}
		}
	}
	
	function showPrtDlg(printType, DlgMessage, submitCfm)
	{  //��ʾ��ӡ�Ի���
		var h = 210;
		var w = 400;
		var t = screen.availHeight / 2 - h / 2;
		var l = screen.availWidth / 2 - w / 2;
		
		var pType = "subprint";
		var billType = "1";
		var sysAccept = "<%=printAccept%>";
		var printStr  =  printInfo(printType);
		var mode_code = null;
		var fav_code = null;
		var area_code = null;
		var opCode = "<%=opCode%>";
		var saleFlag = document.getElementsByName("saleStr")[0].value.split("|")[0];
		var phoneNo = document.getElementById("activePhone").value;
		
		var prop = "dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no";
		var path = "hljBillPrint_jc_d570.jsp?DlgMsg=" + DlgMessage + "&submitCfm=" + submitCfm;
		path = path + "&mode_code="+mode_code+"&fav_code="+fav_code+"&area_code="+area_code+"&opCode="+opCode+"&saleFlag="+saleFlag+"&sysAccept="+sysAccept+"&phoneNo="+phoneNo+"&submitCfm="+submitCfm+"&pType="+pType+"&billType="+billType+ "&printInfo=" + printStr;
		
		var ret=window.showModalDialog(path,printStr,prop);
		return ret;
	}
	
	function printInfo(printType)
	{
		var retInfo = "";
		var cust_info="";
		var opr_info="";
		var note_info1="";
		var note_info2="";
		var note_info3="";
		//var note_info4="";
		
		cust_info+="�ֻ����룺" + document.getElementById("activePhone").value + "|";
		cust_info+="�ͻ�������" + document.getElementById("custName").value + "|";
		//cust_info+="֤�����룺" + document.getElementById("idCardNo").value + "|";
		//cust_info+="�ͻ���ַ��" + document.getElementById("custAddr").value + "|";
		
		var money = "";
		if ("<%=comboType%>" == "A") {
			money = "68";
		} else if ("<%=comboType%>" == "B") {
			money = "98";
		} else if ("<%=comboType%>" == "C") {
			money = "28";
		}
		opr_info += "ҵ������: �����ּ�ͥ�ײ�" + money + "Ԫ�ײ�|";
		
		var saleStrObj = document.getElementsByName("saleStr")[0];
		if (saleStrObj.value.split("|")[0] == "1") {
			opr_info += "Ԥ��" + saleStrObj.value.split("|")[5] 
				+ "Ԫ����TD�̻�һ�����ֻ����·�" 
				+ (parseInt(saleStrObj.value.split("|")[5]) / parseInt(saleStrObj.value.split("|")[6])) + "Ԫ��|";
		}
		opr_info += "���ּ�ͥ�����ֻ����룺" + document.getElementById("activePhone").value + "|";
		opr_info += "���ּ�ͥTD�̻����룺" + document.getElementById("tdUserPhoneStr").value + "|";
		if ("<%=comboType%>" == "B") {
			opr_info += "���ּ�ͥ�����ֻ����룺" + document.getElementById("gsmUserPhoneStr").value + "|";
		}
		opr_info += "���ּ�ͥ" + money + "Ԫ�ʷ�������<%=result[0][12]%>|";
		if (saleStrObj.value.split("|")[0] == "0") {
			opr_info += "����TD�̻�������ʹ�ã����Զ����Ϊ�����ʷѣ������Ե�Ӫҵ�������ԭ�ʷѣ����°��������Ч��|";
		}

		document.getElementById("opNote").value = "����<%=workNo%>Ϊ<%=activePhone%>�û�����<%=opName%>��";
		
		note_info1 += "��ע��" + "|";

/*
		note_info1 += "1�������������ͻ������ּ�ͥ���¼���Ч�������ͻ����°����ּ�ͥ�ײ�������Ч����ͥ��Ա�Ż��ʷѼ���ͥ��ͳһ���ѹ�ϵ�뻶�ּ�ͥ�ײ���Ч����һ�¡�" + "|";
		note_info1 += "2��Ԥ���·�����δ����ͻ�����ȡ�����ּ�ͥ�ײͣ����ܰ����ɢ��ͥ��" + "|";
		note_info1 += "3�������ּ�ͥ�ײ͵������ͻ�Ƿ�Ѻ��ͥ�����пͻ�����ͣ����" + "|";
		note_info1 += "4���������԰������Ӹ������룬����������԰����˳���ͥ������ʷѣ����ּ�ͥ�ڱ������TD�̻����롣" + "|";
		note_info1 += "5�����������԰����ɢ��ͥ����ɢ��ͥ���ͥ���ֻ��ͻ�Ʒ��Ϊ�����ԣ��ʷѱ�׼Ϊ��0Ԫ���⣬5Ԫ������ʾ����ѡ��������ͨ��������0.25Ԫ/���ӵ����µ�������10Ԫ�����߰������з��ã����������Żݵ���Ŀ��������ʷѱ�׼ͬ��׼�ʷѡ�TD�̻��ʷѱ�׼Ϊ��0Ԫ���⣬5Ԫ������ʾ����ѡ��������ͨ��������0.25Ԫ/���ӵ����µ�������10Ԫ�����߰������з��ã����������Żݵ���Ŀ��������ʷѱ�׼ͬ��׼�ʷѡ�" + "|";
		note_info2 += "�ʷ�������" + "|";
		note_info2 += "<%=result[0][12]%>" + "|";
		
/*
		if ("<%=comboType%>" == "A") {
			note_info2 += "���ּ�ͥ68Ԫ�ײͣ���ͥ�ڲ�����1���ֻ�+1��TD�̻�����ͥͳһ�ʵ���ͳһ���ѣ����ں��ֻ���TD�̻�������ʾ���ܡ�TD�̻����幦�ܡ���ͥ�ڲ�ͨ����ѣ�����ͥ���к�һ360���ӣ������ֻ�180���ӣ�TD�̻�180���ӣ����������ְ��ճ��к�һ0.15Ԫÿ���ӣ��������ձ�׼��ȡ��" + "|";
		} else if ("<%=comboType%>" == "B") {
			note_info2 += "���ּ�ͥ98Ԫ�ײͣ���ͥ�ڲ�����2���ֻ�+1��TD�̻�����ͥͳһ�ʵ���ͳһ���ѣ����ں��ֻ���TD�̻�������ʾ���ܡ�TD�̻����幦�ܣ���ͥ�ڲ�ͨ����ѣ�����ͥ���к�һ600���ӣ�������������180���ӣ���������120���ӣ�TD�̻�300���ӣ����������ְ��ճ��к�һ0.15Ԫÿ���ӣ��������ձ�׼��ȡ��" + "|";
		} else if ("<%=comboType%>" == "C") {
			note_info2 += "���ּ�ͥ28Ԫ�ײͣ���ͥ�ڲ�����1���ֻ�+1��TD�̻�����ͥͳһ�ʵ���ͳһ���ѡ����ں��ֻ���TD�̻�������ʾ���ܡ�TD�̻����幦�ܡ���ͥ�ڲ�ͨ����ѣ�����ͥ���к�һ260���ӣ�TD�̻�260���ӣ����������ְ��ճ��к�һ0.15Ԫÿ���ӣ��������ձ�׼��ȡ��" + "|";
		}
*/

		retInfo = strcat(cust_info, opr_info, note_info1, note_info2, note_info3);//, note_info4);
		retInfo = retInfo.replace(new RegExp("#","gm"), "%23");
		return retInfo;
	}

</script>
</head>
<body>

<form name="frm" method="POST" action="fd570_cfm.jsp">
<input type="hidden" name="saleType" id="saleType" value="<%=saleType%>">
<input type="hidden" name="opCode" id="opCode" value="d570">
<input type="hidden" name="opName" id="opName" value="�������ּ�ͥ">
<input type="hidden" name="opNote" id="opNote" value="">
<input type="hidden" name="printAccept" id="printAccept" value="<%=printAccept%>">
<input type="hidden" name="tdCustAddr" id="tdCustAddr" value="">
<input type="hidden" name="comboType" id="comboType" value="<%=comboType%>">
<input type="hidden" name="tdUserPhoneStr" id="tdUserPhoneStr" value="">
<input type="hidden" name="gsmUserPhoneStr" id="gsmUserPhoneStr" value="">
<input type="hidden" name="mOfferId" id="mOfferId" value="<%=result[0][0]%>">
<input type="hidden" name="aOfferId" id="aOfferId" value="<%=result[0][2]%>">
<input type="hidden" name="tdMOfferId" id="tdMOfferId" value="<%=result[0][4]%>">
<input type="hidden" name="tdAOfferId" id="tdAOfferId" value="<%=result[0][6]%>">
<input type="hidden" name="tdMOfferIdStr" id="tdMOfferIdStr" value="">
<input type="hidden" name="tdAOfferIdStr" id="tdAOfferIdStr" value="">
<input type="hidden" name="gsmMOfferId" id="gsmMOfferId" value="<%=result[0][8]%>">
<input type="hidden" name="gsmAOfferId" id="gsmAOfferId" value="<%=result[0][10]%>">
<input type="hidden" name="gsmMOfferIdStr" id="gsmMOfferIdStr" value="">
<input type="hidden" name="gsmAOfferIdStr" id="gsmAOfferIdStr" value="">
<input type="hidden" name="saleStrStr" id="saleStrStr" value="">
<input type="hidden" name="tdUserMsgStr" id="tdUserMsgStr" value="">
<input type="hidden" name="mainFamProdId" id="mainFamProdId" value="<%=result[0][13]%>">
<input type="hidden" name="tdFamProdId" id="tdFamProdId" value="<%=result[0][14]%>">
<input type="hidden" name="gsmFamProdId" id="gsmFamProdId" value="<%=result[0][15]%>">


<div id="Main">
		<div id="Operation_Title">
			<div class="icon"></div>
				<B><font face="Arial">d570</font>���������ּ�ͥ</B>
		</div>
   <DIV id="Operation_Table"> 

<div class="title">
	<div id="title_zi">���û���Ϣ</div>
</div>
<table>
	<tr>
		<td class="blue" width="20%">
			�绰����
		</td>
		<td width="30%">
			<input type="text" name="activePhone" id="activePhone" value="<%=activePhone%>" v_must="1" class="InputGrey" readonly>
		</td>
		<td class="blue"width="20%">
			�ͻ�����
		</td>
		<td width="30%">
			<input type="text" name="custName" id="custName" size="40" value="<%=result[1][2]%>" v_must="1" class="InputGrey" readonly>
		</td>
	</tr>
	<tr>
		<td class="blue" width="20%">
			�ͻ���ַ
		</td>
		<td colspan="3">
			<input name="custAddr" id="custAddr" type="text" size="60" class="InputGrey" value="<%=result[1][3]%>" readonly>
		</td>
	</tr>
	<!--tr>
		<td class="blue" width="20%">
			�ͻ�������
		</td>
		<td width="30%">
			<input name="smName" id="smName" type="text" class="InputGrey" value="<%=result[1][7]%>" readonly>
		</td>
		<td class="blue" width="20%">
			�ͻ�����
		</td>
		<td width="30%">
			<input type="text" name="idCardNo" id="idCardNo" size="40" value="<%=result[1][9]%>" v_must="1" class="InputGrey" readonly>
		</td>
	</tr-->
	<tr>
		<td class="blue" width="20%">
			Ʒ������
		</td>
		<td width="30%">
			<input name="smName" id="smName" type="text" class="InputGrey" value="<%=result[1][6]%>" readonly>
		</td>
		<td class="blue" width="20%">
			<%=result[1][4]%>
		</td>
		<td width="30%">
			<input type="text" name="idCardNo" id="idCardNo" size="40" value="<%=result[1][5]%>" v_must="1" class="InputGrey" readonly>
		</td>
	</tr>
	<tr>
		<td class="blue" width="20%">
			��ǰ����
		</td>
		<td width="30%">
			<input name="smName" id="smName" type="text" class="InputGrey" value="<%=result[1][10]%>" readonly>
		</td>
		<td class="blue" width="20%">
			��ǰ���
		</td>
		<td width="30%">
			<input type="text" name="idCardNo" id="idCardNo" value="<%=result[1][11]%>" v_must="1" class="InputGrey" readonly>
		</td>
	</tr>
	<tr>
		<td class="blue" width="20%">
			��ǰ���ʷ�
		</td>
		<td width="30%">
			<input name="mainFee" id="mainFee" type="text" class="InputGrey" size="40" value="<%=result[1][0]%>--<%=result[1][1]%>" readonly>
		</td>
		<td class="blue">
			�����ײ�����
		</td>
		<td>
			<input name="combo" id="combo" type="text" class="InputGrey" size="40" value="�����л��ּ�ͥ<%=comboType%>���ײ�" readonly>
		</td>
	</tr>
	<tr>
		<td class="blue" width="20%">
			�������ʷ�
		</td>
		<td width="30%">
			<input name="" id="" type="text" class="InputGrey" size="40" value="<%=result[0][0]%>--<%=result[0][1]%>" readonly>
		</td>
		<td class="blue" width="20%">
			�������ʷ�
		</td>
		<td width="30%">
			<input name="" id="" type="text" class="InputGrey" size="40" value="<%=result[0][2]%>--<%=result[0][3]%>" readonly>
		</td>
	</tr>
</table>
<br/>

<div class="title">
	<div id="title_zi">���û���TD�̻�����Ϣ</div>
</div>
<table>
	<tr>
		<td class="blue" width="20%">
			TD�̻�����
		</td>
		<td colspan="3">
			<input type="text" name="tdPhone" id="tdPhone" maxlength="11" v_maxlength="11" v_must="1" value="" />
		</td>
		<!--td class="blue" width="20%">
			TD�̻�����
		</td>
		<td width="30%">
			<jsp:include page="/npage/common/pwd_one_new.jsp">
				<jsp:param name="width1" value="16%"/>
				<jsp:param name="width2" value="34%"/>
				<jsp:param name="pname" value="tdPhonePwd"/>
				<jsp:param name="pwd" value=""/>
			</jsp:include>
		</td-->
	</tr>
	<tr>
		<td class="blue" width="20%">
			�������ʷ�
		</td>
		<td width="30%">
			<input name="" id="" type="text" class="InputGrey" size="40" value="<%=result[0][4]%>--<%=result[0][5]%>" readonly>
		</td>
		<td class="blue" width="20%">
			�������ʷ�
		</td>
		<td width="30%">
			<input name="" id="" type="text" class="InputGrey" size="40" value="<%=result[0][6]%>--<%=result[0][7]%>" readonly>
		</td>
	</tr>
	<tr>
		<td class="blue">��ѡ��</td>
		<td colspan="3">
			<input type="radio" name="tdFlag" id="tdFlag" value="haveTD" onclick="tdChange()" checked>�û�����TD�̻�&nbsp;&nbsp;
			<input type="radio" name="tdFlag" id="tdFlag" value="newTD" onclick="tdChange()">��������TD�̻�Ӫ����&nbsp;&nbsp;
		</td>
	</tr>
</table>

<div name="newTDDiv" id="newTDDiv" style="display:none">
	<table>
		<tr>
			<td class="blue" width="20%">
				TD�̻�Ʒ��
			</td>
			<td width="30%">
				<select name="brandCode" id="brandCode" onchange="getPhoneType();">
				</select>
				<font color="orange">*</font>
			</td>
			<td class="blue" width="20%">
				TD�̻��ͺ�
			</td>
			<td width="30%">
				<select name="phoneType" id="phoneType" onchange="getSaleCode();">
				</select>
			</td>
		</tr>
		<tr>
			<td class="blue">
				Ӫ��������
			</td>
			<td>
				<select name="saleCode" id="saleCode" onchange="">
				</select>
				<input type="button" name="showSaleInfoBtn" id="showSaleInfoBtn" value="Ӫ����ϸ" class="b_text" onClick="showSaleInfo(document.getElementById('saleCode').value);">
			</td>
			<td class="blue">
				IMEI��У��
			</td>
			<td>
				<input type="text" name="imeiCode" id="imeiCode" maxlength="20" v_maxlength="20" v_must="1" value="" onblur="checkElement(this);"><font class="orange">*</font>
				<input type="button" name="checkImeiCodeBtn" id="checkImeiCodeBtn" value="IMEI��У��" class="b_text" onClick="checkImeiCode();">
			</td>
		</tr>
	</table>
</div>
<table>
	<tr>
		<td width="100%" align="center">
			<input type="button" class="b_text" name="tdAdd" id="tdAdd" value="У��&����" onclick="checkTd()"/>
		</td>
	</tr>
</table>

<div class="title">
	<div id="title_zi">��¼��TD�̻����û�</div>
</div>
<table name="tdPhoneMsg" id="tdPhoneMsg">
	<tr>
		<th width="5%">����</th>
		<th width="10%">�ͻ�����</th>
		<th width="15%">�绰����</th>
		<th width="25%">��ǰ���ʷ�</th>
		<th width="10%">�Ƿ����Ӫ����</th>
		<th width="25%">Ӫ��������</th>
		<th width="10%">Ӧ�ս��</th>
	</tr>
</table>
<%
if ("B".equals(comboType)) {
%>
<br/>
	<div class="title">
		<div id="title_zi">���û���GSM����Ϣ</div>
	</div>
	<table>
		<tr>
			<td class="blue" width="20%">
				�绰����
			</td>
			<td colspan="3">
				<input type="text" name="gsmPhone" id="gsmPhone" maxlength="11" v_maxlength="11" v_must="1" value="" />
			</td>
			<!--td class="blue" width="20%">
				TD�̻�����
			</td>
			<td width="30%">
				<jsp:include page="/npage/common/pwd_one_new.jsp">
					<jsp:param name="width1" value="16%"/>
					<jsp:param name="width2" value="34%"/>
					<jsp:param name="pname" value="gsmPhonePwd"/>
					<jsp:param name="pwd" value=""/>
				</jsp:include>
			</td-->
		</tr>
	<tr>
		<td class="blue" width="20%">
			�������ʷ�
		</td>
		<td width="30%">
			<input name="" id="" type="text" class="InputGrey" size="40" value="<%=result[0][8]%>--<%=result[0][9]%>" readonly>
		</td>
		<td class="blue" width="20%">
			�������ʷ�
		</td>
		<td width="30%">
			<input name="" id="" type="text" class="InputGrey" size="40" value="<%=result[0][10]%>--<%=result[0][11]%>" readonly>
		</td>
	</tr>
	</table>
	<table>
		<tr>
			<td width="100%" align="center">
				<input type="button" class="b_text" value="У��&����" onclick="checkGsm()" />
			</td>
		</tr>
	</table>
	<div class="title">
		<div id="title_zi">��¼��GSM���û�</div>
	</div>
	<table name="gsmPhoneMsg" id="gsmPhoneMsg">
		<tr>
			<th width="5%">����</th>
			<th width="10%">�ͻ�����</th>
			<th width="15%">�绰����</th>
			<th width="70%">��ǰ���ʷ�</th>
		</tr>
	</table>
<%
}
%>

<table>
	<tr>
		<td colspan="3" id="footer">
			<input class="b_foot" type=button name="submitB" id="submitB" value="ȷ��" onClick="submitt();">
			<input class="b_foot" type=button name="" id="" value="����" onClick="window.location = 'fd570.jsp?activePhone=<%=activePhone%>&opCode=d570&opName=�������ּ�ͥ';">
			<input class="b_foot" type=button name="" value="�ر�" onClick="parent.removeTab('d570')">
		</td>
	</tr>
</table>
</DIV>
</DIV>

</form>
</body>
</html>

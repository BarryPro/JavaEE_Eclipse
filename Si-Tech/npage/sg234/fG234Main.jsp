<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%
String opCode = request.getParameter("opCode");
String opName = request.getParameter("opName");
String orgCode = (String)session.getAttribute("orgCode");
String regionCode = orgCode.substring(0,2);
String dateStr2 =  new java.text.SimpleDateFormat("yyyyMMdd").format(new java.util.Date());
String broadPhone = request.getParameter("broadPhone");

String workNo = (String) session.getAttribute("workNo");
String nopass = (String) session.getAttribute("password");
String iChnSource = "01";
String iUserPwd = "";
String[][] favInfo = (String[][])session.getAttribute("favInfo");

int favFlag = 1;
String org_codeT = orgCode;
String region_codeT = org_codeT.substring(0, 2);
String feeSql = "select function_code, hand_fee ,region_code,favour_code "
	+"from sNewFunctionFee where region_code = '" + region_codeT 
	+ "' and function_code in ('g234' , 'g235')";
%>
<!--�����ѵĲ�ѯ-->
<wtc:pubselect name="sPubSelect" outnum="4"
	routerKey="phone" routerValue="<%=activePhone%>" >
	<wtc:sql><%=feeSql%></wtc:sql>
</wtc:pubselect>
<wtc:array id="fee" scope="end" />
<%
String workSql = "select count(*) from shighlogin "
	+"where login_no = '" + workNo + "' and op_code in ('g234','g235')";
%>
<!--�߶��û��Ĳ�ѯ-->
<wtc:pubselect name="sPubSelect" outnum="2"
	routerKey="phone" routerValue="<%=activePhone%>" >
	<wtc:sql><%=workSql%></wtc:sql>
</wtc:pubselect>
<wtc:array id="higflagArr" scope="end" />
<%
String higflag="";
if(higflagArr!=null&&higflagArr.length>0)
{
	higflag = higflagArr[0][0];
}

//��ѯ �������ű�� �������ſͻ�����
String getGrpInfoSql = "SELECT to_char(c.unit_id), c.unit_name FROM dimscustmsg a, dcustmsg b, dgrpcustmsg c where a.id_no = b.id_no and b.cust_id = c.cust_id and a.phone_no =:phone_no";
String getGrpInfoSqlParam = "phone_no=" + activePhone; 
%>

<wtc:service name="TlsPubSelCrm" outnum="2" retcode="getGrpInfoCode" retmsg="getGrpInfoMsg">
		<wtc:param value="<%=getGrpInfoSql%>"/>
		<wtc:param value="<%=getGrpInfoSqlParam%>"/>
</wtc:service>

<wtc:array id="grpResult" scope="end" />
	
<%
	String grpUnitCode = "";
	String grpUnitName = "";
	if("000000".equals(getGrpInfoCode) && grpResult.length > 0){
		grpUnitCode = grpResult[0][0];
		grpUnitName = grpResult[0][1];
	}
	
	/**
	System.out.println("zhouby grpUnitCode " + grpResult[0][0]);
	System.out.println("zhouby grpUnitName " + grpResult[0][1]);
	*/
%>
			
<HEAD>
<TITLE>��ͣ����ͣ�ָ���Ԥ��������</TITLE>
<script language="javascript" type="text/javascript" src="/npage/public/knockout-2.0.0.js" >
</script>
<script language="javascript">
var printFlag = 9;//�û����۱�ʶ
var flag = 0;//��ѯ�û���Ϣ�ɹ�����ʶ
function doProcess(packet) 
{
	var backString = packet.data.findValueByName("backString");
	var cfmFlag = packet.data.findValueByName("flag");

	if (cfmFlag == 1) 
	{
		var errMsg = packet.data.findValueByName("errMsg");
		var errCode = packet.data.findValueByName("errCode");
		var errCodeInt = parseInt(errCode, 10);
		if (errCodeInt == 0) 
		{
			rdShowMessageDialog("�����ɹ���",2);
			document.frm.backLoginAccept.value = backString[0][0];
			document.frm.phoneNo.value="<%=activePhone%>";
			document.frm.smName.value = "";
			document.frm.customPass.value = "";
			document.frm.userId.value = "";
			document.frm.runName.value = "";
			document.frm.gradeName.value = "";
			document.frm.totalPrepay.value = "";
			document.frm.totalOwe.value = "";
			document.frm.custName.value = "";
			document.frm.factPay.value = "0";
			document.frm.remark.value = "";
			document.frm.cardType.value = "";
			document.frm.idCardNo.value = "";
			document.frm.custAddress.value = "";
			document.frm.backPrepay.value = "";
			document.frm.iccName.value = "";
			document.frm.iccNo.value = "";
			document.frm.innerTime.value = "";
			document.frm.backDate.value = "";
			document.frm.remark.value = "";
			document.frm.asNotes.value = "";
			document.frm.productName.value = "";
			document.frm.loginAccept.value = "";  
			flag = 0;
			resett();
		} 
		else 
		{
			rdShowMessageDialog(errCode + ":" + errMsg);
			document.frm.vConID.value = "";
			document.frm.vPhoneNo.value = "";
			document.frm.productName.value = "";
			resett();
			return;
		}
	}
	/*�û���Ϣ��ѯʧ��*/
	if (cfmFlag == 9) 
	{
		var errCode = packet.data.findValueByName("errCode");
		var errMsg = packet.data.findValueByName("errMsg");
		rdShowMessageDialog(errCode + " : " + errMsg);
		if(errCode != "000000")
		{
			window.location="fG234Main.jsp?activePhone=<%=activePhone%>"
				+"&opCode=<%=opCode%>&opName=<%=opName%>";
		}
		var ii = 0 ;
		for (ii = 0; ii < document.frm.radiobutton.length; ii ++) 
		{
			document.all.radiobutton[ii].disabled = false;
		}
		flag = 0;
		return;
	}
	/*�û���Ϣ����ʾ*/
	if (cfmFlag == 0) 
	{	
		var errMsg = packet.data.findValueByName("errMsg");
		var errCode = packet.data.findValueByName("errCode");
		var phoneNo=packet.data.findValueByName("phoneNo");
		var errCodeInt = parseInt(errCode, 10);
		document.frm.userId.value = backString[0][0];
		document.frm.smName.value = backString[0][2];
		document.frm.custName.value = backString[0][3];
		document.frm.customPass.value = backString[0][4];
		document.frm.runName.value = backString[0][6];
		
		document.frm.gradeName.value = backString[0][8]; 
		document.frm.custAddress.value = backString[0][11];
		document.frm.iccName.value = backString[0][13];
		document.frm.idCardNo.value = backString[0][14];
		document.frm.iccNo.value = backString[0][14];
		
		document.frm.cardType.value = backString[0][15];
		document.frm.totalOwe.value = backString[0][16];  
		document.frm.totalPrepay.value = backString[0][17];
		document.frm.backPrepay.value = backString[0][20];
		document.frm.lxPrepay.value = backString[0][21];
		
		document.frm.innerTime.value = backString[0][22];
		document.frm.backDate.value = backString[0][23];     
		document.frm.phoneNo.value=phoneNo;
		if (document.frm.cardType.value.indexOf("�и߶��û�", 0) >= 0) 
		{
			rdShowMessageDialog("���û����и߶��û���");
		}
		if (document.frm.cardType.value.indexOf("�и߶��û�", 0) >= 0 
			&& <%=higflag%> ==0 && document.frm.opCode.value == "b544")
		{
			rdShowMessageDialog("���û����и߶��û�,�˹���û������Ȩ�ޣ�");
			return;
		}
		
		document.frm.noBack.value = backString[0][24];
		document.frm.productName.value = backString[0][25];
		document.frm.loginAccept.value = backString[0][26];
		document.frm.cfmLogin.value = backString[0][27];
		document.frm.IMPU.value = backString[0][31]+"|"+backString[0][32];
		document.frm.IMPI.value = backString[0][28];
		document.frm.groupId.value = backString[0][33];
		document.frm.groupName.value = backString[0][34];
		document.frm.factPay.disabled = false;
		flag = 1;
		
		if (errCode == 0) 
		{
			if (document.frm.favFlag.value == 1) 
			{
				document.frm.submit.disabled = false;
			}
		}
		if (errCode != 0) 
		{
			if (errCode == 121350) 
			{
				rdShowMessageDialog(errCodeInt + " : " + errMsg);
				if (rdShowConfirmDialog('ȷ��Ҫ�������ű����') != 1) 
				{
					return;
				}
				if (document.frm.favFlag.value == 1) 
				{
					document.frm.submit.disabled = false;
				}
			}
			else if (errCode == 1206) 
			{
				rdShowMessageDialog(errCodeInt + " : " + errMsg);
				if (rdShowConfirmDialog('ȷ��Ҫ�������ű����') != 1) 
				{
					return;
				}
				if (document.frm.favFlag.value == 1) 
				{
					document.frm.submit.disabled = false;
				}
			}
			else 
			{
				if (errCode == 1201) 
				{
					errMsg = "�Ҳ����÷������";
				}
				if (errCode == 1202) 
				{
					errMsg = "��״̬��������";
				}
				if (errCode == 1203) {
				errMsg = "�˺��벻������ز���";
				}
				if (errCode == 1204) {
				errMsg = "��ҵ�����Ͳ����������";
				}
				if (errCode == 1007) {
				errMsg = "Ƿ��״̬��������";
				}
				if (errCode == 1008) {
				errMsg = "Ƿ��״̬��������";
				}
				if (errCode == 1207) {
				errMsg = "���û��Ѿ�����";
				}
				
				rdShowMessageDialog(errCodeInt + " : " + errMsg);
				var ii = 0 ;
				for (ii = 0; ii < document.frm.radiobutton.length; ii ++) {
				document.all.radiobutton[ii].disabled = false;
				}
				
				document.frm.smName.value = "";
				document.frm.customPass.value = "";
				document.frm.userId.value = "";
				document.frm.runName.value = "";
				document.frm.gradeName.value = "";
				document.frm.totalPrepay.value = "";
				document.frm.totalOwe.value = "";
				document.frm.custName.value = "";
				document.frm.remark.value = "";
				document.frm.factPay.value = "";
				document.frm.cardType.value = "";
				document.frm.idCardNo.value = "";
				document.frm.custAddress.value = "";
				document.frm.backPrepay.value = "";
				document.frm.lxPrepay.value = "";
				document.frm.noBack.value = "";
				document.frm.iccName.value = "";
				document.frm.iccNo.value = "";
				document.frm.innerTime.value = "";
				document.frm.remark.value = "";
				document.frm.asNotes.value = "";
				document.frm.productName.value = "";
				document.frm.loginAccept.value = "";
				flag = 0;
			}
		}
		/** bingId Ϊ63ʱ�������Ʒ�ƣ�����ѯ����Դ��Ϣ
		var bindVal = backString[0][29];
		$("#bindId").val(bindVal);
		**/
	}
}

/*********�û���Ϣ�Ĳ�ѯ****************/
function submitt() 
{
	for (var i = 0; i < document.frm.radiobutton.length; i++)
	{
		if (document.frm.radiobutton[i].checked)
		{
			document.all.radioValue.value = document.frm.radiobutton[i].value;
			document.all.radioIndex.value=document.frm.radiobutton[i].index;
		}
	}
	var allInfo = "";
	var radioK = 0;

	for (radioK = 0; radioK < document.frm.radiobutton.length; radioK++) 
	{
		if (document.frm.radiobutton[radioK].checked) 
		{
			allInfo = document.frm.radiobutton[radioK].value;
		}
	}
	if (allInfo == "") 
	{
		rdShowMessageDialog("��ѡ���������!");
		return;
	}

    var ii = 0 ;
    for (ii = 0; ii < document.frm.radiobutton.length; ii ++) {
        document.all.radiobutton[ii].disabled = true;
    }
	/*��ȡ�û���Ϣ*/
	if(document.all.phoneNo.value != "")
	{
		var myPacket = new AJAXPacket("fG234MainAjax.jsp", "�����ύ�����Ժ�......");
		myPacket.data.add("iChnSource", document.frm.iChnSource.value);
		myPacket.data.add("opCode", document.frm.opCode.value);
		myPacket.data.add("workNo", document.frm.workNo.value);
		myPacket.data.add("phoneNo", document.frm.phoneNo.value);
		myPacket.data.add("iUserPwd ", document.frm.iUserPwd.value);    
		core.ajax.sendPacket(myPacket);
		myPacket=null;
	}
	else
	{
		rdShowMessageDialog("��ѯ�û���Ϣʧ�ܣ�",0);
		return false;
	}
}
/******** ���������ʱ���ӻ�����ʾ��Ϣ *********/
function formSubmitCfm()
{
	//getAfterPrompt();

	submitCfm();
}

/**********ҳ����ύ***************/
function submitCfm() 
{	
		var op_code=document.frm.opCode.value;
		getAfterPrompt(op_code);			
		
    if (flag == 1) {
        if (document.frm.remark.value.length == 0) {
            document.frm.remark.value = document.frm.sysRemark.value;
            var opCode=$("input[@name=radiobutton][@checked]").val();
						document.frm.remark.value = "�û�����" + document.frm.phoneNo.value + "�û�����" + document.frm.custName.value + "����" + document.frm.remark.value + "��";
        }
        
        if(document.frm.asNotes.value.trim().len()==0){
        		document.frm.asNotes.value=document.frm.remark.value;
        }
        if (!forMoney(document.frm.handFee)) {
            return;
        }
        if (!forMoney(document.frm.factPay)) {
            return;
        }
        if (parseFloat(document.frm.factPay.value) > parseFloat(document.frm.handFeeT.value)) {
            rdShowMessageDialog("�����Ѳ��ܴ���" + document.frm.handFeeT.value);
            return;
        }

		if(!printCommit())
		{
			return false;
		}
		if (printFlag != 1 && printFlag != 2) 
		{
			return;
		}

		document.frm.submit.disabled = true;
		var vPhoneNo = document.frm.phoneNo.value;
			
		var myPacket = new AJAXPacket("fG234Cfm.jsp", "�����ύ�����Ժ�......");
		myPacket.data.add("opCode", document.frm.opCode.value);
		myPacket.data.add("iChnSource", $("#iChnSource").val());
		myPacket.data.add("radioIndex", document.frm.radioIndex.value);
		myPacket.data.add("phoneNo", document.frm.phoneNo.value); 
		myPacket.data.add("iUserPwd", $("#iUserPwd").val()); 
		myPacket.data.add("cfmLogin", document.frm.cfmLogin.value);
		myPacket.data.add("cfmPwdOld", "");
		myPacket.data.add("cfmPwdNew", "");
		myPacket.data.add("workNo", document.frm.workNo.value);
		myPacket.data.add("loginAccept", document.frm.loginAccept.value);
		myPacket.data.add("vPhoneNo", document.frm.vPhoneNo.value);
		myPacket.data.add("vConID", document.frm.vConID.value);
		myPacket.data.add("backPrepay", document.frm.backPrepay.value);
		myPacket.data.add("orgCode", document.frm.orgCode.value);
		myPacket.data.add("handFee", document.frm.handFee.value);
		myPacket.data.add("factPay", document.frm.factPay.value);
		myPacket.data.add("sysRemark", document.frm.sysRemark.value);
		myPacket.data.add("ipAdd", $("#ipAdd").val());
		myPacket.data.add("construct_request", $("#construct_request").val());
		myPacket.data.add("appointTime", $("#appointTime").val());
		myPacket.data.add("portCodeOld", $("#portCodeOld").val());
		myPacket.data.add("deviceCodeOld", $("#deviceCodeOld").val());
		myPacket.data.add("ipAddressOld", $("#ipAddressOld").val());
		myPacket.data.add("deviceInAddressOld", $("#deviceInAddressOld").val());
		myPacket.data.add("cctIdOld", $("#cctIdOld").val());
		
		core.ajax.sendPacket(myPacket);
		myPacket=null;
		/*
		if (printFlag == 2) 
		{
			var vEvalValue = GetEvalReq(1);
			if (vEvalValue == 4) 
			{
				rdShowMessageDialog("�û�δ��������!");
			}
			var vEvalPacket = new AJAXPacket("../../npage/public/evalCfm.jsp?vEvalValue=" + vEvalValue, "�����ύ�û���������ۣ����Ժ�......");
			vEvalPacket.data.add("vLoginAccept", document.frm.loginAccept.value);
			vEvalPacket.data.add("vOpCoce", document.frm.opCode.value);
			vEvalPacket.data.add("vLoginNo", document.frm.workNo.value);
			vEvalPacket.data.add("vPhoneNo", vPhoneNo);
			core.ajax.sendPacket(vEvalPacket);
			vEvalPacket=null;
		}
		*/
	}
	else
	{
		rdShowMessageDialog("���Ȳ�ѯ�û���Ϣ��");
	}
}
/******ҳ�������*********/
function resett(){
	  window.location="fG234Main.jsp?activePhone=<%=activePhone%>&opCode=<%=opCode%>&opName=<%=opName%>";
	  /*
    printFlag = 9;
    document.frm.customPass.value = "";
    document.frm.userId.value = "";
    document.frm.runName.value = "";
    document.frm.gradeName.value = "";
    document.frm.totalPrepay.value = "";
    document.frm.totalOwe.value = "";
    document.frm.custName.value = "";
    document.frm.smName.value = "";
    document.frm.backPrepay.value = "";
    document.frm.lxPrepay.value = "";
    document.frm.noBack.value = "";
    document.frm.iccName.value = "";
    document.frm.iccNo.value = "";
    document.frm.innerTime.value = "";
    document.frm.asNotes.value = "";
    document.frm.productName.value = "";
     //�û�����Դ��Ϣ������ 
    document.frm.cfmLogin.value = "";
    document.frm.deviceTypeOld.value = "";
    document.frm.deviceCodeOld.value = "";
    document.frm.deviceInAddressOld.value = "";
    document.frm.factoryOld.value = "";
    document.frm.portTypeOld.value = "";
    document.frm.portCodeOld.value = "";
    document.frm.ipAddressOld.value = "";
    document.frm.modelOld.value = "";
    
    //ʩ����Ϣ������
    document.frm.construct_request.value = "";
    document.frm.appointTime.value = "";
    
    document.frm.IMPU.value="";
    document.frm.IMPI.value="";
    var ii = 0 ;
    for (ii = 0; ii < document.frm.radiobutton.length; ii ++) 
    {
        document.all.radiobutton[ii].disabled = false;
        document.all.radiobutton[ii].checked = false;
    }

    document.frm.submit.disabled = true;
    document.frm.cardType.value = "";
    document.frm.idCardNo.value = "";
    document.frm.custAddress.value = "";
    flag = 0;
    */
}
/****����ת������ѯ��ȷ���˺�****/
function getByPhone(formField) 
{
	if (document.frm.vPhoneNo.value == document.frm.phoneNo.value)
	{
		rdShowMessageDialog("ת����벻���ڷ��������ͬ�������²�����");
		document.frm.vPhoneNo.value = "";
		document.frm.vPhoneNo.focus();
		return false;
	}
	document.all.vConID.value = "";
	
	var pageTitle = "�ʻ���Ϣ��ѯ";
	var fieldName = "ת���ʻ�|ת���ʻ�����";
	var selType = "S";    //'S'��ѡ��'M'��ѡ
	var retQuence = "0";
	var retToField = "vConID";
	var sqlStr = "select a.contract_no, a.bank_cust "
		+"from dConMsg a, dCustMsg b, dConUserMsg c "
		+"where a.contract_no = c.contract_no and   b.id_no = c.id_no "
		+"and   b.phone_no  = '" + formField.value + "'";
	PubSimpSel(pageTitle, fieldName, sqlStr, selType, retQuence, retToField);
	if (document.all.vConID.value == "")
	{
		return false;
	}        
}

/*****��ʾ�Ų�ѯ********/
function beforePrompt(){
	var op_code=$("input[@name=radiobutton][@checked]").val();
	var packet = new AJAXPacket("/npage/include/getBeforePrompt.jsp","���Ժ�...");
	packet.data.add("opCode" ,op_code);
	core.ajax.sendPacketHtml(packet,doGetBeforePrompt,true);//�첽
	packet =null;
}
function doGetBeforePrompt(data)
{
	$('#wait').hide();
	$('#beforePrompt').html(data);
}
/*****ע�������ѯ********/
function getAfterPrompt(op_code)
{
	var packet = new AJAXPacket("/npage/include/getAfterPrompt.jsp","���Ժ�...");
	packet.data.add("opCode" ,op_code);
  core.ajax.sendPacket(packet,doGetAfterPrompt,false);//ͬ��
	packet =null;
}
function doGetAfterPrompt(packet)
{
	var retCode = packet.data.findValueByName("retCode"); 
	var retMsg = packet.data.findValueByName("retMsg"); 
	if(retCode=="000000")
	{
		promtFrame(retMsg);
	}
}
/*�û���Ϣ�Ĳ�ѯ*/
function clickRadio()
{
	var opCode=$("input[@name=radiobutton][@checked]").val();

	if(opCode == "g234")
	{
		modInit.noBackVsb(false);
		modInit.bakVsb(false);
		modInit.opCodeVal("g234");
		modInit.hdFeeVal("0");
		modInit.hdFeeTVal("0");
		modInit.fctPayVal("0");			
		modInit.sysRemark("IMS�̻�Ԥ����Centrex��");			
	}
	else if (opCode == "g326")
	{
		modInit.noBackVsb(false);
		modInit.bakVsb(false);
		modInit.opCodeVal("g326");
		modInit.hdFeeVal("0");
		modInit.hdFeeTVal("0");
		modInit.fctPayVal("0");			
		modInit.sysRemark("IMS�̻�Ԥ���ָ���Centrex��");			
	}
	else if(opCode == "g235")
	{
		modInit.noBackVsb(true);
		modInit.bakVsb(true);
		modInit.opCodeVal("g235");
		modInit.hdFeeVal("0");
		modInit.hdFeeTVal("0");
		modInit.fctPayVal("0");			
		modInit.sysRemark("IMS�̻�������Centrex��");	
	}
	else if(opCode == "m128")
	{
		modInit.noBackVsb(false);
		modInit.bakVsb(false);
		modInit.opCodeVal("m128");
		modInit.hdFeeVal("0");
		modInit.hdFeeTVal("0");
		modInit.fctPayVal("0");			
		modInit.sysRemark("centrex��ͣ");	
	}
	else if(opCode == "m129")
	{
		modInit.noBackVsb(false);
		modInit.bakVsb(false);
		modInit.opCodeVal("m129");
		modInit.hdFeeVal("0");
		modInit.hdFeeTVal("0");
		modInit.fctPayVal("0");			
		modInit.sysRemark("centrex��ͣ�ָ�");	
	}
	
	submitt();
}
</script>
</HEAD>
<body>
<FORM action="" method=post name="frm" id="frm">
	<%@ include file="/npage/include/header.jsp" %>
	<!--BUSУ�鷵�ش���-->
	<input type="hidden" name="bFCode" value="1">
	<input type="hidden" name="bFMsg" value="1">
	<div id="Operation_Table"> 
	<div class="title">
		<div id="title_zi">��ѡ���������</div>
	</div>
	<table cellspacing="0">
		<tr>
			<td class="blue" nowrap>��������</td>
			<!--�̻�ҵ��Ԥ��
			<td>
				<input type="radio" name="radiobutton" index="1" value=""
					onclick="clickRadio();" >��ͣ
			</td>-->
			<td>
				<input type="radio" name="radiobutton" index="5" value="g326"
				onclick="clickRadio();">Ԥ���ָ�
			</td>
			
			<td>
				<input type="radio" name="radiobutton" index="3" value="g234"
				onclick="clickRadio();">Ԥ��
			</td>
			<td>
				<input type="radio" name="radiobutton" index="4" value="g235"
				onclick="clickRadio();">����
			</td>
			<td>
				<input type="radio" name="radiobutton" index="1" value="m128"
				onclick="clickRadio();">centrex��ͣ
			</td>
			<td>
				<input type="radio" name="radiobutton" index="2" value="m129"
				onclick="clickRadio();">centrex��ͣ�ָ�
			</td>
		</tr>
	</table>
	<div class="title">
		<div id="title_zi">�û���Ϣ</div>
	</div>
	<table cellspacing="0">
		<tr>
			<td  class="blue">�������</td>
			<td colspan=5>
				<input id=Text2 type=text size=17 name="phoneNo" 
					value="<%=activePhone%>"  class="InputGrey" readonly >
			</td>
		</tr>
		<tr>
		<td class="blue" width="20%" nowrap>�û�ID</td>
		<td width="21%">
			<input id=Text2 type=text 
				size=17 name=userId class="InputGrey" readonly>
		</td>
		<td class="blue" width="12%" nowrap>��ǰ״̬</td>
		<td width="21%">
			<input type=text size=17 
				name=runName class="InputGrey" readonly>
		</td>
		<td class="blue" width="16%" nowrap>����</td>
		<td>
			<input type=text size=17 name=gradeName class="InputGrey" readonly>
		</td>
		</tr>
		<tr>
			<td class="blue">��ǰԤ��</td>
			<td>
				<input id=Text2 type=text size=17 name=totalPrepay class="InputGrey" readonly>
			</td>
			<td class="blue">��ǰǷ��</td>
			<td>
				<input id=Text2 type=text size=17 name=totalOwe class="InputGrey" readonly>
			</td>
			<td class="blue" nowrap>��ͻ���־</td>
			<td>
				<input type=text size=15 name=cardType class="InputGrey" readonly>
			</td>
		</tr>
		<tr>
			<td class="blue"> ֤������</td>
			<td>
				<input id=Text2 type=text size=17 name=iccName class="InputGrey" readonly>
			</td>
			<td class="blue">֤������</td>
			<td>
				<input id=Text2 type=text size=17 name=iccNo class="InputGrey" readonly>
			</td>
			<td class="blue">����ʱ��</td>
			<td width="19%" colspan=2>
				<input id=Text2 type=text size=25 name=innerTime class="InputGrey" readonly>
			</td>
		</tr>		
		<tr>
			<td class="blue">IMPI</td>
			<td>
				<input type=text size=40 name=IMPI style='width:250px' class="InputGrey" readonly>
			</td>
			<td class="blue">IMPU</td>
			<td colspan='4'>
				<input type=text size=80 name=IMPU  style='width:400px' class="InputGrey" readonly>
			</td>
		</tr>		
		<tr>
			<td class="blue"> �ͻ�����</td>
			<td>
				<input type=text size=17 name=custName id="custName" class="InputGrey" readonly>
			</td>
			<td class="blue"> ��Ʒ����</td>
			<td colspan='4'>
				<input type=text size=17 name=productName class="InputGrey" readonly>
			</td>
			<!--
			<td class="blue">�����½�˻�</td>
			<td>
				<input type=text size=17 name=cfmLogin id="cfmLogin" class="InputGrey" readonly>
			</td>
			-->
		</tr>
		<tr id=backDiv data-bind="visible:bakVsb">
			<td class="blue">ת�����</td>
			<td>
				<input type=text maxlength="11" size=17 name=vPhoneNo>
				<input class="b_text" type="button" name="qCustIdByPhone" value="��ѯ" onClick="getByPhone(vPhoneNo)">
			</td>
			<td class="blue">ת���ʻ�</td>
			<td width="19%" colspan=4>
				<input type=text size=17 name=vConID class="InputGrey" readonly>
			</td>
		</tr>
		<tr id=noBackDiv data-bind="visible:noBackVsb">
			<td class="blue">������Ԥ��</td>
			<td>
				<input id=Text2 type=text size=17 name=noBack class="InputGrey" readonly>
			</td>
			<td class="blue">����Ԥ��</td>
			<td>
				<input id=Text2 type=text size=17 name=backPrepay id="backPrepay" class="InputGrey" readonly>
			</td>
			<td class="blue">��Ϣ</td>
			<td width="19%" colspan=2>
				<input id=Text2 type=text size=17 name=lxPrepay class="InputGrey" readonly>
			</td>
		</tr>
		<!--
		<tr id="userOldResDiv1" style=display:none>
			<td  class="blue">�豸����</td>
			<td>
				<input id="deviceTypeOld" name="deviceTypeOld" readonly>
			</td>
			<td  class="blue">�豸����</td>  
			<td> 
				<input id="deviceCodeOld" name="deviceCodeOld"  readonly> 
			</td> 
			<td  class="blue">�豸��װ��ַ</td>  
			<td> 
				<input id="deviceInAddressOld" name="deviceInAddressOld"  readonly> 
				<input type="hidden" id="factoryOld" name="factoryOld" >
			</td> 
		</tr>
		<tr id="userOldResDiv2" style=display:none>
			<td  class="blue"> �˿�����</td>
			<td>
				<input id="portTypeOld" name="portTypeOld" readonly>
			</td>
			<td class="blue"> �˿ڱ���</td>  
			<td> 
				<input id="portCodeOld" name="portCodeOld" readonly> 
			</td>  
			<td class="blue" >ip��ַ</td>
			<td>
				<input id="ipAddressOld" name="ipAddressOld" readonly>
				<input type="hidden" id="modelOld" name="modelOld" >
			</td>	  	 
		</tr>
		<tr id=constructDiv style="display:none">
			<td class="blue">ʩ��Ҫ��</td>
			<td colspan=2>
				<input type="text" name="construct_request" id="construct_request"  maxlength=80>
			</td>
			<td class="blue" >ԤԼʱ��</td>
			<td colspan=2>
					<input type="text" name="appointTime" id="appointTime"  v_format="yyyyMMdd" class="required"><font class="orange">*(��ʽYYYYMMDD)</font>
			</td>
		</tr>	
		-->
		<tr>
			<td class="blue">������</td>
			<td>
				<input type="text" size=17 name=handFee id="handFee" data-bind="value:hdFeeVal"
					readonly class="InputGrey" v_type=float v_name="������" index="7">
			</td>
			<td class="blue">ʵ��</td>
			<td colspan="3">
				<input id="factPay" type=text size=17 name="factPay" index="8" 
					disabled v_type="money" data-bind="value:fctPayVal"/>
			</td>
		</tr>	
		<tr>
			<td class="blue">����ID</td>
			<td>
				<input type="text" size="17" name="groupId" id="groupId" class="InputGrey" readonly />
			</td>
			<td class="blue">��������</td>
			<td colspan='4'>
				<input type="text" size="17" name="groupName" id="groupName" class="InputGrey" readonly />
			</td>
		</tr>		
		<tr>
			<td class="blue">ϵͳ��ע</td>
			<td colspan="5">
				<input id=Text3 type=text size=80 name=remark value="">
			</td>
		</tr>
		<tr>
			<td class="blue">�û���ע</td>
			<td colspan="5">
				<input id=Text2 type=text size=80 name=asNotes maxlength=60 onkeyup="value=value.replace(/[@#$%!^&*()<>?|]/g,'');" index="9">
			</td>
		</tr>   
	</table>
	
	<table cellSpacing="0">
		<tbody>
		<tr>
			<td id="footer">
				<input class="b_foot" name=submit type=button value="ȷ��" 
					index="10" onclick="formSubmitCfm()" disabled>
				<input class="b_foot" name=back type='button' value="���" onclick="resett()">
				<input class="b_foot" name=back type=button value="�ر�" onclick="parent.removeTab('<%=opCode%>')">
				&nbsp;&nbsp;
			</td>
		</tr>
		</tbody>
	</table>
	<input type=hidden name=opCode data-bind="value:opCodeVal">
	<!--��ʱ���ص���Ϣ,Ϊ���˿���Ԥ�� b-->
	<input type=hidden name="cfmLogin" id="cfmLogin">
	<input type=hidden name="deviceTypeOld" id="deviceTypeOld" >
	<input type=hidden name="deviceCodeOld" id="deviceCodeOld" > 
	<input type=hidden name="deviceInAddressOld" id="deviceInAddressOld"> 
	<input type=hidden name="factoryOld" id="factoryOld" >
	<input type=hidden name="portTypeOld" id="portTypeOld">
	<input type=hidden name="portCodeOld" id="portCodeOld" readonly> 
	<input type=hidden name="ipAddressOld" id="ipAddressOld"readonly>
	<input type=hidden name="modelOld" id="modelOld">
	<input type=hidden name="construct_request" id="construct_request">
	<input type=hidden name="appointTime" id="appointTime">
	<!--��ʱ���ص���Ϣ,Ϊ���˿���Ԥ�� e-->
	<input type=hidden name=workNo value=<%=workNo%>>
	<input type=hidden name=noPass value=<%=nopass%>>
	<input type=hidden name=orgCode value=<%=orgCode%>>
	<input type=hidden name=iChnSource id="iChnSource" value=<%=iChnSource%>>  <!--������ʶ-->
	<input type=hidden name=iUserPwd id="iUserPwd" value=<%=iUserPwd%>>  <!--�������� -->
	<input type=hidden name=sysRemark value="����ۺϱ��" data-bind='value:sysRemark'>
	<input type=hidden name=ipAdd id="ipAdd" value="<%=request.getRemoteAddr()%>">
	<input type=hidden name=handFeeT data-bind="value:hdFeeTVal"><!--������-->
	<input type=hidden name=customPass><!--�û�����-->
	<input type=hidden name=idCardNo><!--֤������-->
	<input type=hidden name=custAddress id="custAddress">
	<input type=hidden name=backLoginAccept><!--�����ɹ�����ˮ��-->
	<input type=hidden name=backDate>
	<input type=hidden name=favFlag value="<%=favFlag%>">
	<input type=hidden name=loginAccept id="loginAccept"><!--������ˮ��-->
	<input type=hidden name=smName>
	<input type=hidden name=cctIdOld id="cctIdOld"><!--���žֱ���-->
	<input type=hidden name=isConstruct value="1"><!--�Ƿ�ʩ����־-->
	<input type="hidden" name="radioValue" value=""><!--ѡ���opcode-->
	<input type="hidden" name="radioIndex" value=""><!--ѡ��Ĳ�����˳���-->
	<input type="hidden" name="bindId" id="bindId" value="">
	<div id="relationArea" style="display:none"></div>
	<div id="wait" style="display:none">
		<img  src="/nresources/default/images/blue-loading.gif" />
	</div>
	<div id="beforePrompt"></div>    
	</div>   
	<%@ include file="/npage/include/footer_simple.jsp" %>
 
</FORM>

<OBJECT classid="clsid:2F593576-E694-46B5-BF4F-9F23C1020642" height=1 id=evalControl width=1>
</OBJECT>
</BODY>
</HTML>
<script>
/*���������ӡ**/
function printCommit()
{
	var ret = showPrtDlg("Detail", "ȷʵҪ���е��������ӡ��", "Yes");

	var iRetrun = showEvalConfirmDialog('ȷ��Ҫ���д��������');
	if (iRetrun == 1 || 2 == iRetrun)
	{
		printFlag = 1;
		return true;	
	}
	else
	{
		return false;	
	}	
	
	/*
	if (iRetrun == 1)
	{
		if (document.frm.cardType.value.indexOf("�и߶��û�", 0) >= 0
			&& document.frm.opCode.value == "b544") 
		{
			if (rdShowConfirmDialog('���û����и߶��û���ȷ��Ҫ������') == 1) 
			{
				printFlag = 1;
				return true;
			}
		} 
		else 
		{
			printFlag = 1;
			return true;
		}
	} 
	else if (iRetrun == 2)
	{ 
		if (document.frm.cardType.value.indexOf("�и߶��û�", 0) >= 0 
			&& document.frm.opCode.value == "b544") 
		{
			if (rdShowConfirmDialog('���û����и߶��û���ȷ��Ҫ������') == 1) 
			{
				printFlag = 2;
				return true;
			}
		} 
		else
		{
			printFlag = 2;
			return true;
		}
	}
	else
	{
		return false;
	}*/
}
function showPrtDlg(printType, DlgMessage, submitCfn)
{  //��ʾ��ӡ�Ի��� 
	var h=210;
	var w=400;
    var t = screen.availHeight / 2 - h / 2;
    var l = screen.availWidth / 2 - w / 2;
    var opCode=$("input[@name=radiobutton][@checked]").val();
	var pType="subprint";
	var billType="1";
	var mode_code=null;
	var fav_code=null;
	var area_code=null;
	var sysAccept = document.frm.loginAccept.value;
    var printStr = printInfo(printType);
    var iRetrun = 0;
    var prop = "dialogHeight:" + h + "px; dialogWidth:" + w + "px; dialogLeft:" + l + "px; dialogTop:" + t + "px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no"
	var path = "<%=request.getContextPath()%>/npage/innet/hljBillPrint_jc_hw.jsp?DlgMsg=" + DlgMessage;
    var path = path  + "&mode_code="+mode_code+"&fav_code="+fav_code+"&area_code="+area_code+"&opCode="+opCode+"&sysAccept="+sysAccept+"&phoneNo=<%=activePhone%>&submitCfm=" + submitCfn+"&pType="+pType+"&billType="+billType+ "&printInfo=" + printStr;
    var ret = window.showModalDialog(path, printStr, prop);
}
function printInfo(printType)
{
	var retInfo = "";
	if (printType == "Detail")
	{
		var cust_info="";
		var opr_info="";
		var note_info1="";
		var note_info2="";
		var note_info3="";
		var note_info4="";        
		var opCode=$("input[@name=radiobutton][@checked]").val();
		if(opCode == 'g326'){
			cust_info += "���룺<%=activePhone%>" + "|";
		} else {
			cust_info += "�û����룺<%=activePhone%>" + "|";
		}
		cust_info += "�ͻ�������" + document.all.custName.value + "|";
		cust_info += "�ͻ���ַ��" + document.frm.custAddress.value + "|";
		cust_info += "֤�����룺" + document.frm.idCardNo.value + "|";
		cust_info += "�������ű�ţ�<%=grpUnitCode%>|";
		cust_info += "�������ſͻ����ƣ�<%=grpUnitName%>|";

		opr_info += "�û�Ʒ�ƣ�" + document.frm.smName.value +"    ����ҵ��"+document.frm.sysRemark.value+"|";
		opr_info += "������ˮ��" + document.frm.loginAccept.value +"|";
		
		for (var i = 0; i < document.frm.radiobutton.length; i ++)
		{
			if (document.all.radiobutton[i].checked)
			{
				var radio1 = document.all.radiobutton[i].value;
				if (radio1 == "g234")
				{	
					opr_info += "�û��ʷѣ�"+ document.frm.productName.value + "|";
				}
			}
		}
		
		note_info1 += "��ע��"+"|";
		//retInfo = cust_info+"#"+opr_info+"#"+note_info1+"#"+note_info2+"#"+note_info3+"#"+note_info4+"#";
		retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
		retInfo=retInfo.replace(new RegExp("#","gm"),"%23");
	}
    return retInfo;
}
/*
function printBill() {
        var infoStr = "";
        infoStr += " " + "|";
        infoStr += '<%=new java.text.SimpleDateFormat("yyyy", Locale.getDefault()).format(new java.util.Date())%>' + "|";
        infoStr += '<%=new java.text.SimpleDateFormat("MM", Locale.getDefault()).format(new java.util.Date())%>' + "|";
        infoStr += '<%=new java.text.SimpleDateFormat("dd", Locale.getDefault()).format(new java.util.Date())%>' + "|";
        infoStr += document.frm.phoneNo.value + "|";//�ƶ�����                                                                                                    
        infoStr += "" + "|";//��ͬ����                                                          
        infoStr += document.frm.custName.value + "|";//�û�����                                                
        infoStr += document.frm.custAddress.value + "|";//�û���ַ  
        infoStr += "�ֽ�" + "|";
        infoStr += document.frm.handFee.value + "|";
        infoStr += document.frm.sysRemark.value + "��*�����ѣ�" + document.frm.handFee.value + "*��ˮ�ţ�" + document.frm.backLoginAccept.value + "|";
	      //rdShowMessageDialog("-"+infoStr+"-");
        location.href = "chkPrint.jsp?retInfo=" + infoStr + "&dirtPage=fG234Main.jsp";
}*/

/*
function showBroadBill(printType,DlgMessage,submitCfm){
	var printInfo = "";
	var prtLoginAccept = $("#loginAccept").val();
	var custName = $("#custName").val();
	var cashPay = $("#factPay").val();
	var broadNo = $("#cfmLogin").val();
	var printStr = "";
	var opName = "";
	if(document.frm.opCode.value == "b540"){
		printStr = "��ͣ�����ѣ�";
		opName = "���ҵ����ͣ";
	}else if(document.frm.opCode.value == "b541"){
		printStr = "���������ѣ�";
		opName = "���ҵ����ͣ�ָ�";
	}else{
		printStr = "�˷ѽ�";
		opName = "�������";
		cashPay = document.frm.backPrepay.value;
	}
	printInfo += "<%=new java.text.SimpleDateFormat("yyyy",Locale.getDefault()).format(new java.util.Date())%>" + "|";
	printInfo += "<%=new java.text.SimpleDateFormat("MM",Locale.getDefault()).format(new java.util.Date())%>" + "|";
	printInfo += "<%=new java.text.SimpleDateFormat("dd",Locale.getDefault()).format(new java.util.Date())%>" + "|";
	printInfo += prtLoginAccept + "|";
	printInfo += custName + "|";
	printInfo += " " + "|";
	printInfo += " " + "|";
	printInfo += broadNo + "|";
	printInfo += " " + "|";
	printInfo += cashPay + "|";
	printInfo += cashPay + "|";
	printInfo += opName + "|";
	printInfo += printStr + cashPay + "Ԫ" + "~";
	printInfo += "�ͷ����ߣ�10050" + "~";
	printInfo += "��ַ��http://www.10050.net" + "|";
	
	var h=210;
	var w=400;
	var t=screen.availHeight/2-h/2;
	var l=screen.availWidth/2-w/2;
	var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no" 
	var path = "/npage/public/pubBillPrintBroad.jsp?dlgMsg=" + "��Ʊ��ӡ";
	var loginAccept = prtLoginAccept;
	var path = path + "&infoStr="+printInfo+"&loginAccept="+loginAccept+"&opCode=<%=opCode%>&submitCfm=submitCfm&phoneNo=<%=activePhone%>";
	var ret = window.showModalDialog(path,"",prop);
}
*/
/*
function printTwoBill() {
	var infoStr = "";
	infoStr += " " + "|";
	if (document.frm.backPrepay.value.length == 0) {
	 document.frm.backPrepay.value = 0;
	}
	if (document.frm.lxPrepay.value.length == 0) {
	 document.frm.lxPrepay.value = 0;
	}
	infoStr += '<%=new java.text.SimpleDateFormat("yyyy", Locale.getDefault()).format(new java.util.Date())%>' + "|";
	infoStr += '<%=new java.text.SimpleDateFormat("MM", Locale.getDefault()).format(new java.util.Date())%>' + "|";
	infoStr += '<%=new java.text.SimpleDateFormat("dd", Locale.getDefault()).format(new java.util.Date())%>' + "|";
	infoStr += document.frm.phoneNo.value + "|";//�ƶ�����                                                                                                    
	infoStr += document.frm.backPrepay.value + "*" + document.frm.lxPrepay.value + "*" + document.frm.noBack.value + "|";//��ͬ����                                                          
	infoStr += document.frm.custName.value + "|";//�û�����                                                
	infoStr += document.frm.custAddress.value + "|";//�û���ַ  
	infoStr += "�ֽ�" + "|";
	infoStr += document.frm.handFee.value + "|";
	infoStr += document.frm.sysRemark.value + "��*�����ѣ�" + document.frm.handFee.value + "*��ˮ�ţ�" + document.frm.backLoginAccept.value + "|";
	location.href = "chkTwoPrint.jsp?retInfo=" + infoStr + "&dirtPage=fG234Main.jsp&activePhone=<%=activePhone%>&opCode=<%=opCode%>&opName=<%=opName%>";
}
function printTwoBillZero() {
    var infoStr = "";
    infoStr += " " + "|";
    if (document.frm.backPrepay.value.length == 0) {
        document.frm.backPrepay.value = 0;
    }
    if (document.frm.lxPrepay.value.length == 0) {
        document.frm.lxPrepay.value = 0;
    }
    infoStr += '<%=new java.text.SimpleDateFormat("yyyy", Locale.getDefault()).format(new java.util.Date())%>' + "|";
    infoStr += '<%=new java.text.SimpleDateFormat("MM", Locale.getDefault()).format(new java.util.Date())%>' + "|";
    infoStr += '<%=new java.text.SimpleDateFormat("dd", Locale.getDefault()).format(new java.util.Date())%>' + "|";
    infoStr += document.frm.phoneNo.value + "|";//�ƶ�����                                                                                                    
    infoStr += document.frm.backPrepay.value + "*" + document.frm.lxPrepay.value + "*" + document.frm.noBack.value + "|";//��ͬ����                                                           
    infoStr += document.frm.custName.value + "|";//�û�����                                                
    infoStr += document.frm.custAddress.value + "|";//�û���ַ  
    infoStr += "�ֽ�" + "|";
    infoStr += document.frm.handFee.value + "|";
    infoStr += document.frm.sysRemark.value + "��*�����ѣ�" + document.frm.handFee.value + "*��ˮ�ţ�" + document.frm.backLoginAccept.value + "|";
    location.href = "chkTwoPrintZero.jsp?retInfo=" + infoStr + "&dirtPage=fG234Main.jsp&activePhone=<%=activePhone%>&opCode=<%=opCode%>&opName=<%=opName%>";
}*/
/*
function printThreeBill() {
    var infoStr = "";
    infoStr += document.frm.remark.value + "|";
    infoStr += '<%=new java.text.SimpleDateFormat("yyyy", Locale.getDefault()).format(new java.util.Date())%>' + "|";
    infoStr += '<%=new java.text.SimpleDateFormat("MM", Locale.getDefault()).format(new java.util.Date())%>' + "|";
    infoStr += '<%=new java.text.SimpleDateFormat("dd", Locale.getDefault()).format(new java.util.Date())%>' + "|";
    infoStr += document.frm.phoneNo.value + "|";//�ƶ�����                                                                                                    
    infoStr += document.frm.backPrepay.value + "|";//����Ԥ��                                                          
    infoStr += document.frm.custName.value + "|";//�û�����                                                
    infoStr += document.frm.custAddress.value + "|";//�û���ַ  
    infoStr += document.frm.idCardNo.value + "|";//֤������
    infoStr += document.frm.handFee.value + "|";
    infoStr += document.frm.sysRemark.value + "��*�����ѣ�" + document.frm.handFee.value + "*��ˮ�ţ�" + document.frm.backLoginAccept.value + "|";
		//infoStr+=document.frm.backDate.value+"|";
    //rdShowMessageDialog(document.frm.backDate.value);
    location.href = "chkThreePrint.jsp?backDate=" + document.frm.backDate.value + "&retInfo=" + infoStr + "&dirtPage=fG234Main.jsp&activePhone=<%=activePhone%>&opCode=<%=opCode%>&opName=<%=opName%>";
}
function printThreeBillZero() {
    var infoStr = "";
    infoStr += document.frm.remark.value + "|";
    infoStr += '<%=new java.text.SimpleDateFormat("yyyy", Locale.getDefault()).format(new java.util.Date())%>' + "|";
    infoStr += '<%=new java.text.SimpleDateFormat("MM", Locale.getDefault()).format(new java.util.Date())%>' + "|";
    infoStr += '<%=new java.text.SimpleDateFormat("dd", Locale.getDefault()).format(new java.util.Date())%>' + "|";
    infoStr += document.frm.phoneNo.value + "|";//�ƶ�����                                                                                                    
    infoStr += document.frm.backPrepay.value + "|";//����Ԥ��                                                          
    infoStr += document.frm.custName.value + "|";//�û�����                                                
    infoStr += document.frm.custAddress.value + "|";//�û���ַ  
    infoStr += document.frm.idCardNo.value + "|";//֤������
    infoStr += document.frm.handFee.value + "|";
    infoStr += document.frm.sysRemark.value + "��*�����ѣ�" + document.frm.handFee.value + "*��ˮ�ţ�" + document.frm.backLoginAccept.value + "|";
    //infoStr+=document.frm.backDate.value+"|";
    //rdShowMessageDialog(document.frm.backDate.value);
    location.href = "chkThreePrintZero.jsp?backDate=" + document.frm.backDate.value + "&retInfo=" + infoStr + "&dirtPage=fG234Main.jsp&activePhone=<%=activePhone%>&opCode=<%=opCode%>&opName=<%=opName%>";
}*/
var modInit = {
	noBackVsb : ko.observable(false),
	bakVsb : ko.observable(false),
	opCodeVal : ko.observable("<%=opCode%>"),
	hdFeeVal : ko.observable("0"),
	hdFeeTVal : ko.observable("0"),
	fctPayVal : ko.observable("0"),
	sysRemark : ko.observable("<%=opName%>")
};
ko.applyBindings(modInit);
</script>


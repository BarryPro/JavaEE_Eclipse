<%
/********************
 version v2.0
 ������: si-tech
 ����: dujl
********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html  xmlns="http://www.w3.org/1999/xhtml">

<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page contentType="text/html;charset=GBK"%>
<%@ page language="java" import="java.sql.*" %>
<%@ page import="java.util.*"%>
<%@ page import="java.io.*"%>

<%
	/* liujian ��ȫ�ӹ��޸� 2012-4-6 16:18:13 begin */
	String op_strong_pwd = (String) session.getAttribute("password");
  /* liujian ��ȫ�ӹ��޸� 2012-4-6 16:18:13 end */
	String opCode = request.getParameter("opCode");
	String opName = request.getParameter("opName");
	String iPhoneNo = request.getParameter("phoneNo");
	String sale_kind=request.getParameter("sale_kind");
	String phoneTy=request.getParameter("sale_kind");
	String main_phone=request.getParameter("main_phoneno");
	String aftertrim = (String)session.getAttribute("powerRight");
	String emId=WtcUtil.repStr(request.getParameter("emId"),"");
	String oaNum=WtcUtil.repStr(request.getParameter("oaNum"),"");
	String useType=WtcUtil.repStr(request.getParameter("useType"),"");
	String useRange=WtcUtil.repStr(request.getParameter("useRange"),"");
	String sale_name="";
	String phone_ty="";
	if(phoneTy.equals("0"))
	{
		sale_name="���Ժ�";
		phone_ty="Yn10";
	}else
	{
		useType="";
		useRange="";
		sale_name="�����";
		phone_ty="YnB0";
	}

	String loginNo = (String)session.getAttribute("workNo");
	String orgCode = (String)session.getAttribute("orgCode");
	String orgCode1 = orgCode.substring(0,2);
	String orgCode2 = orgCode.substring(2,4);
	String regionCode = (String)session.getAttribute("regCode");

  /*begin update �����С�ʡ�б�־��չʾ���������ĵ������ƺ͡�ʡ��˾�������� by diling@2012/5/15 
  	StringBuffer  insql = new StringBuffer();
	insql.append("select a.type_code, nvl(b.region_name,'ʡ��˾') ");
	insql.append("  from sUseCenter a,sregioncode b ");
	insql.append(" where a.USE_FLAG = 'Y' ");
	insql.append(" and a.type_code=b.region_code(+) ");
	insql.append(" group by a.type_code,nvl(b.region_name,'ʡ��˾') ");
	insql.append(" order by a.type_code ");
	System.out.println("insql====="+insql);*/
	String insql = "select a.type_code, nvl(b.region_name,'ʡ��˾') from sUseCenter a,sregioncode b,sUseUnit c  where a.type_code=b.region_code(+) and a.type_code='"+regionCode+"' and a.unit_code = c.unit_code group by a.type_code, nvl(b.region_name,'ʡ��˾')";
  /*end update by diling*/

	StringBuffer  appsql = new StringBuffer();
	appsql.append("select level_code,level_name ");
	appsql.append("  from sUseLevel ");
	appsql.append(" where USE_FLAG = 'Y' ");
	System.out.println("appsql====="+appsql);
%>

<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>"  retcode="retCode1" retmsg="retMsg1" outnum="2">
<wtc:sql><%=insql%></wtc:sql>
</wtc:pubselect>
<wtc:array id="result" scope="end" />

<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>"  retcode="retCode1" retmsg="retMsg1" outnum="2">
<wtc:sql><%=appsql%></wtc:sql>
</wtc:pubselect>
<wtc:array id="result1" scope="end" />

<%
    String retFlag="",retMsg="";
    String  bp_name="",sm_code="",rate_code="",bigCust_flag="",sm_name="";
    String  rate_name="",bigCust_name="",next_rate_code="",next_rate_name="",lack_fee="";
    String  prepay_fee="",bp_add="",cardId_type="", cardId_no="", cust_id="",cust_belong_code="";
    String  group_type_code="",group_type_name="",imain_stream="",next_main_stream="",hand_fee="";
    String  favorcode="",print_note="",contract_flag="",high_flag="",passwordFromSer="";

    String iOpCode = request.getParameter("opcode");
    String cus_pass = request.getParameter("cus_pass");

	String  inputParsm [] = new String[4];
	inputParsm[0] = iPhoneNo;
	inputParsm[1] = loginNo;
	inputParsm[2] = orgCode;
	inputParsm[3] = iOpCode;
	System.out.println("phoneNO === "+ iPhoneNo);
%>
	<wtc:service name="s126bInit" routerKey="phone" routerValue="<%=iPhoneNo%>" retcode="retCode2" retmsg="retMsg2" outnum="29">			
		<wtc:param value=""/>
		<wtc:param value="01"/>
		<wtc:param value="<%=iOpCode%>"/>
		<wtc:param value="<%=loginNo%>"/>
		<wtc:param value="<%=op_strong_pwd%>"/>
		<wtc:param value="<%=iPhoneNo%>"/>
		<wtc:param value=""/>
		<wtc:param value="<%=inputParsm[2]%>"/>
	</wtc:service>
	<wtc:array id="tempArr"  scope="end"/>
<%
	String errCode = retCode2;
	String errMsg = retMsg2;

	if(tempArr.length==0)
	{
	   retFlag = "1";
	   retMsg = "s126bInit��ѯ���������ϢΪ��!<br>errCode: " + errCode + "<br>errMsg+" + errMsg;
	}
	else if(errCode.equals("000000") && tempArr.length>0)
	{
	    bp_name = tempArr[0][3];           //��������
	    bp_add = tempArr[0][4];            //�ͻ���ַ
	    passwordFromSer = tempArr[0][2];  //����
	    sm_code = tempArr[0][11];         //ҵ�����
	    sm_name = tempArr[0][12];        //ҵ���������
	    hand_fee = tempArr[0][13];      //������
	    favorcode = tempArr[0][14];     //�Żݴ���
	    rate_code = tempArr[0][5];     //�ʷѴ���
	    rate_name = tempArr[0][6];    //�ʷ�����
	    next_rate_code = tempArr[0][7];//�����ʷѴ���
	    next_rate_name = tempArr[0][8];//�����ʷ�����
	    bigCust_flag = tempArr[0][9];//��ͻ���־
	    bigCust_name = tempArr[0][10];//��ͻ�����
	    lack_fee = tempArr[0][15];//��Ƿ��
	    prepay_fee = tempArr[0][16];//��Ԥ��
	    cardId_type = tempArr[0][17];//֤������
	    cardId_no = tempArr[0][18];//֤������
	    cust_id = tempArr[0][19];//�ͻ�id
	    cust_belong_code = tempArr[0][20];//�ͻ�����id
	    group_type_code = tempArr[0][21];//���ſͻ�����
	    group_type_name = tempArr[0][22];//���ſͻ���������
	    imain_stream = tempArr[0][23];//��ǰ�ʷѿ�ͨ��ˮ
	    next_main_stream = tempArr[0][24];//ԤԼ�ʷѿ�ͨ��ˮ
	    print_note = tempArr[0][25];//�������
	    contract_flag = tempArr[0][27];//�Ƿ������˻�
	    high_flag = tempArr[0][28];//�Ƿ��и߶��û�

	 }else
	 {
%>
		<script language="JavaScript">
			rdShowMessageDialog("������룺<%=errCode%>��������Ϣ��<%=errMsg%>",0);
			history.go(-1);
		</script>
<%	 }
%>
<%
//******************�õ�����������***************************//
//�����ʷ�
/*
**String sqlmodecode = "select a.new_mode,b.mode_name from cBillBBChg a,sBillModeCode b  where a.region_code='" + orgCode1 + "' and a.district_code in ('" + orgCode2 + "','99') and a.op_code='4264' and a.OLD_MODE ='" + rate_code + "'  and b.region_code=a.region_code and b.mode_type='" + phone_ty + "' and b.mode_code=a.new_mode and a.POWER_RIGHT <= '"+aftertrim+"' and b.POWER_RIGHT <= '"+aftertrim+"' and b.start_time<=sysdate and b.stop_time>sysdate order by a.new_mode";
**/
String sqlmodecode = "select a.offer_z_id, b.offer_name from product_offer_relation a, product_offer b where a.offer_z_id = b.offer_id and a.op_code = '4264' and a.offer_a_id = to_number('" + rate_code + "') and b.offer_attr_type = '" + phone_ty + "' and a.right_limit <= "+aftertrim+" and b.exp_date > sysdate order by a.offer_z_id ";
System.out.println("sqlmodecode====="+sqlmodecode);
%>
<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>"  retcode="retCode1" retmsg="retMsg1" outnum="2">
<wtc:sql><%=sqlmodecode%></wtc:sql>
</wtc:pubselect>
<wtc:array id="modecodeStr" scope="end"/>

<head>
<title>������Ժ�ת��</title>
<META content=no-cache http-equiv=Pragma>
<META content=no-cache http-equiv=Cache-Control>
<META content="MSHTML 5.00.3315.2870" name=GENERATOR>
<style>
.nodisp{
	display: none;
}
</style>
<script language="JavaScript">
var page = null;
<!--
onload=function()
{
	document.all.phoneNo.focus();
	self.status="";
	chg_application();
}

//--------1---------doProcess����----------------

function doProcess(packet)
{
	self.status="";
	var vRetPage=packet.data.findValueByName("rpc_page");
	var retCode = packet.data.findValueByName("retCode");
	var retMsg =  packet.data.findValueByName("retMsg");
	var rpc_flag = packet.data.findValueByName("rpc_flag");

	if(retCode != "000000")
	{
		rdShowMessageDialog(retMsg);
		return;
	}
	if(rpc_flag == "chg_type")
	{
		var code = packet.data.findValueByName("code");
		var text =  packet.data.findValueByName("text");
		fillSelect(document.all.useUnit,code,text);
	}
	else if(rpc_flag == "chg_unit")
	{
		var code = packet.data.findValueByName("code");
		var text =  packet.data.findValueByName("text");
		fillSelect(document.all.useDepartment,code,text);
	}
	else if(rpc_flag == "chg_department")
	{
		var code = packet.data.findValueByName("code");
		var text =  packet.data.findValueByName("text");
		fillSelect(document.all.useCenter,code,text);
	}
	else if(rpc_flag == "chg_application")
	{
		var code = packet.data.findValueByName("code");
		var text =  packet.data.findValueByName("text");
		fillSelect(document.all.useApplication,code,text);
	}

	if(vRetPage == "qryAreaFlag")
	{
		var retCode = packet.data.findValueByName("retCode");
		var retMsg = packet.data.findValueByName("retMsg");
		var area_flag = packet.data.findValueByName("area_flag");

		if(retCode == 000000)
		{
		    if(parseInt(area_flag)>0)
		    {
				document.all.flagCodeTr.style.display="";
				getFlagCode();
		    }
		}
		else
		{
			rdShowMessageDialog("����:"+ retCode + "->" + retMsg);
			return;
		}
	}
}

  //--------2---------��֤��ťר�ú���-------------
function formCommit()
{
	var value = $('select[name="useApplication"]').val();
	if ((value == '3005' || value == '3010') && page.sale_kind){
			var values = {};
			if ($('#enum-message').is(':checked')){
					var opposite_codes = document.getElementsByName('code-opposite');
					for (var i = 0; i < opposite_codes.length; i++){
							if(!checkElement(opposite_codes[i])){
									return false;
							}
							var v = opposite_codes[i].value.trim();
							if (v != ''){
									if (values[v]){//����Ƿ��Ѿ�����
											rdShowMessageDialog('�Զ˺��벻���ظ�����ɾ���ظ����ݣ�');
											return false;
									}
									values[v] = 'true';//��������
							}
					}
			}
			if ($('#enum-gprs').is(':checked')){
					var apn_codes = document.getElementsByName('code-apn');
					for (var i = 0; i < apn_codes.length; i++){
							if(!checkElement(apn_codes[i])){
									return false;
							}
					}
			}
			
			if ($('#enum-voice').is(':checked')){
					var base_station = document.getElementById('base-station');
					var pattern = /^[A-Za-z0-9]+$/;
					if(!checkElement(base_station)){
							return false;
					}
					
					var neighborhood = document.getElementById('neighborhood');
					if(!checkElement(neighborhood)){
							return false;
					}
					
					//��֤�������
					if (!pattern.test(base_station.value.trim())){
							rdShowMessageDialog('��վֻ����8λ���ڵ���ĸ���������');
							return false;
					}
					if (!pattern.test(neighborhood.value.trim())){
							rdShowMessageDialog('С��ֻ����8λ���ڵ���ĸ���������');
							return false;
					}
			}
	}
	
	if(document.all.warningMoney.value=="")
	{
		rdShowMessageDialog("������澯���!")
		document.all.warningMoney.focus();
		return false;
	}
	if(document.all.limitMoney.value=="")
	{
		rdShowMessageDialog("������Ԥ���޶�!")
		document.all.limitMoney.focus();
		return false;
	}
	if(document.all.endTime.value.trim()=="")
	{
		rdShowMessageDialog("���������ʱ��!")
		document.all.endTime.focus();
		return false;
	}
	if(document.all.typeCode.value=="")
	{
		rdShowMessageDialog("������ʡ�б�־!")
		document.all.typeCode.focus();
		return false;
	}
	if(document.all.useUnit.value=="")
	{
		rdShowMessageDialog("������ʹ�õ�λ!")
		document.all.useUnit.focus();
		return false;
	}
	if(document.all.useDepartment.value=="")
	{
		rdShowMessageDialog("������ʹ�ò���!")
		document.all.useDepartment.focus();
		return false;
	}
	if(document.all.useCenter.value=="")
	{
		rdShowMessageDialog("������ʹ������!")
		document.all.useCenter.focus();
		return false;
	}
	if(document.all.useApplication.value=="")
	{
		rdShowMessageDialog("������ʹ����;!")
		document.all.useApplication.focus();
		return false;
	}
	if(document.all.useLevel.value=="")
	{
		rdShowMessageDialog("�����뼶��!")
		document.all.useLevel.focus();
		return false;
	}
	if(document.all.New_Mode_Code.value=="")
	{
		rdShowMessageDialog("�����������ʷ�!")
		document.all.New_Mode_Code.focus();
		return false;
	}
	if(document.all.opNote.value.trim()=="")
	{
		rdShowMessageDialog("�����뱸ע!")
		document.all.opNote.focus();
		return false;
	}
	frmCfm();
}

function frmCfm()
{
	document.frm.iAddStr.value=<%=phoneTy%>+"|"+document.frm.warningMoney.value+"|"+document.frm.endTime.value+"|"+document.frm.limitMoney.value+"|"+document.frm.typeCode.value+"|"+document.frm.useUnit.value+"|"+document.frm.useDepartment.value+"|"
 							+document.frm.useCenter.value+"|"+document.frm.useApplication.value+"|"+document.frm.useLevel.value+"|"+document.frm.oCustName.value+"|"+document.frm.opNote.value+"|<%=oaNum%>|<%=useType%>|<%=useRange%>|<%=emId%>";
	if(document.all.New_Mode_Code.value=="")
	{
		rdShowMessageDialog("�����������ʷѴ���!")
		document.all.New_Mode_Code.focus();
		return false;
	}
	document.frm.i1.value = document.frm.phoneNo.value;
	document.frm.ip.value = document.frm.New_Mode_Code.value;
	
	var monitorValue = page.setupMonitorValues();
	document.frm.monitorValue.value = monitorValue;
	frm.submit();
}

function getFlagCode1()
{
	document.all.commit.disabled=false;
	if (document.frm.back_flag_code.value == 2)
	{
	  	document.all.flagCodeTextTd.style.display = "";
		document.all.flagCodeTd.style.display = "";
	}
}

function getFlagCode()
{
  	//���ù���js
    var pageTitle = "�ʷѲ�ѯ";
    var fieldName = "С������|С������|��������";//����������ʾ���С�����
    /*
    **var sqlStr ="select a.flag_code, a.flag_code_name,a.rate_code from sRateFlagCode a, sBillModeDetail b where a.region_code=b.region_code and a.rate_code=b.detail_code and b.detail_type='0' and a.region_code='" + document.frm.orgCode.value.substring(0,2) + "' and b.mode_code='" + document.frm.New_Mode_Code.value + "' order by a.flag_code" ;
	**/
	var sqlStr = "select a.flag_code, a.flag_code_name from sofferflagcode a, sregioncode b where a.offer_id = to_number('" + document.frm.New_Mode_Code.value + "') and a.group_id = b.group_id and b.region_code = '" + document.frm.orgCode.value.substring(0,2) + "' order by a.flag_code";
    var selType = "S";    //'S'��ѡ��'M'��ѡ
    var retQuence = "0|1";//�����ֶ�
    var retToField = "flag_code|flag_code_name";//���ظ�ֵ����

    if(PubSimpSel(pageTitle,fieldName,sqlStr,selType,retQuence,retToField));
}

// ʡ�б�־--��λ
function typechange()
{
	if(document.all.typeCode.value != "")
	{
		var sqlParam = document.all.typeCode.value+"|"+document.all.typeCode.value + "|";
		var rpc_flag = "chg_type";
		var sql = "90000232";
		sendRpc(sqlParam,rpc_flag,sql);
	}
	document.all.useUnit.value = "";
	document.all.useDepartment.value = "";
	document.all.useCenter.value = "";
}

// ��λ--����
function unitchange()
{
	if(document.all.useUnit.value != "")
	{
		var sqlParam = document.all.typeCode.value+"|"+document.all.useUnit.value + "|";
		var rpc_flag = "chg_unit";
		var sql = "90000233";
		sendRpc(sqlParam,rpc_flag,sql);
	}
	document.all.useCenter.length = 1;
	document.all.useDepartment.value = "";
	document.all.useCenter.value = "";
}

// ����--����
function chg_department()
{
	if(document.all.useDepartment.value != "")
	{
		var sqlParam = document.all.typeCode.value+"|"+document.all.useUnit.value+"|"+document.all.useDepartment.value + "|";
		var rpc_flag = "chg_department";
		var sql = "90000234";
		sendRpc(sqlParam,rpc_flag,sql);
	}
}

// ��;
function chg_application()
{
	if(document.all.phoneType.value != "")
	{
		var sqlParam = <%=phoneTy%> + "|";
		var rpc_flag = "chg_application";
		var sql = "90000235";
		sendRpc(sqlParam,rpc_flag,sql);
	}
}

function sendRpc(sqlParam,rpc_flag,sql)
{
	var myPacket = new AJAXPacket("/npage/s9387/rpc_select.jsp","���ڻ�ȡ��Ϣ�����Ժ�......");
	myPacket.data.add("sql",sql);
	myPacket.data.add("sqlParam",sqlParam);
	myPacket.data.add("rpc_flag", rpc_flag);
	core.ajax.sendPacket(myPacket);
	myPacket=null;
}

function fillSelect(obj,code,text)
{
	obj.length=0;
	var option0 = new Option("--��ѡ��--","");
	obj.add(option0);
	for(var i=0; i<code.length; i++)
	{
		var option1 = new Option(text[i],code[i]);
        obj.add(option1);
	}
}

//-->

//zhouby 2012-12-11
function Page(){
		this.sale_kind = ('<%=sale_kind%>' == '0')? true: false;
		this.init();
}

Page.prototype.init = function(){
		var self = this;
		
		$('#enum-message').click(function(e){
			 	e.stopPropagation();
			  
				if ($(this).is(':checked')){
						$('#opposite-code').show();
				} else {
						$('#opposite-code, .ErrorTip').hide();
				}
		});
		
		$('#enum-gprs').click(function(e){
				e.stopPropagation();
				
				if ($(this).is(':checked')){
						$('#apn-code').show();
				} else {
						$('#apn-code, .ErrorTip').hide();
				}
		});
		
		$('#enum-voice').click(function(e){
				e.stopPropagation();
				
				if ($(this).is(':checked')){
						$('#voice-info').show();
				} else {
						$('#voice-info, .ErrorTip').hide();
				}
		});
		
		$('select[name="useApplication"]').change(function(e){
				e.stopPropagation();
				
				var value = $(this).val();
				if ((value == '3005' || value == '3010') && self.sale_kind){
						$('#monitor-pattern').show();
				} else {
						$('#opposite-code, .ErrorTip, #monitor-pattern, #apn-code, #voice-info').hide();
						$('#enum-message, #enum-gprs, #enum-voice').attr('checked', false);
				}
		});
		
		var value = $('select[name="useApplication"]').val();
		if ((value == '3005' || value == '3010') && self.sale_kind){
				$('#monitor-pattern').show();
		}else {
				$('#opposite-code, .ErrorTip, #monitor-pattern, #apn-code, #voice-info').hide();
				$('#enum-message, #enum-gprs, #enum-voice').attr('checked', false);
		}
}

Page.prototype.setupMonitorValues = function(){
		var array = [];
		var value = $('select[name="useApplication"]').val();
		if ((value == '3005' || value == '3010') && page.sale_kind){
				if ($('#enum-message').is(':checked')){
						var opposite_codes = document.getElementsByName('code-opposite');
						for (var i = 0; i < opposite_codes.length; i++){
								var code = opposite_codes[i].value.trim();
								if(code != ''){
										var t = this.setupValue('01', i, code);
										array.push(t);
								}
						}
				}
				if ($('#enum-gprs').is(':checked')){
						var apn_codes = document.getElementsByName('code-apn');
						for (var i = 0; i < apn_codes.length; i++){
								var code = apn_codes[i].value.trim();
								if(code != ''){
										var t = this.setupValue('02', i, code);
										array.push(t);
								}
						}
				}
				if ($('#enum-voice').is(':checked')){
						var base_station = document.getElementById('base-station');
						var code = base_station.value.trim();
						if(code != ''){
								var t = this.setupValue('03', 0, code);
								array.push(t);
						}
						
						var neighborhood = document.getElementById('neighborhood');
						var code = neighborhood.value.trim();
						if(code != ''){
								var t = this.setupValue('04', 0, code);
								array.push(t);
						}
				}
		}
		return array.join(',');
}

/**
	* ע�⣺ index����ֵ���͵�
  */
Page.prototype.setupValue = function(type, index, code){
		var array = [];
		index += 1;//������±��0��ʼ������̨Ҫ���±��1��ʼ
		if (type == '01'){//�������
				array.push('01');
				array.push('dx00' + index);
				array.push(code);
		} else if (type == '02'){
				array.push('02');
				array.push('gprs00' + index);
				array.push(code);
		} else if (type == '03'){
				array.push('03');
				array.push('jz00' + index);
				array.push(code);
		} else if (type == '04'){
				array.push('04');
				array.push('xq00' + index);
				array.push(code);
		}
		return array.join('~');
}

$(function(){
		page = new Page();
});
</script>
</head>
<body>
	<form name="frm" method="post" action="f1270_3.jsp" onKeyUp="chgFocus(frm)">
		<input name="monitorValue" type="hidden"/>
		<%@ include file="/npage/include/header.jsp" %>   
		<div class="title">
			<div id="title_zi"><%=opName%></div>
		</div>
		<input name="oSmCode" type="hidden" class="button" id="oSmCode" value="<%=sm_code%>">
	  	<input type="hidden" name="m_smCode" value="">
		<input type="hidden" name="opName" value="<%=opName%>">
		<input name="oModeCode" type="hidden" class="button" id="oModeCode" value="<%=rate_code%>">
		<input type="hidden" name="back_flag_code" value="">
		<input type="hidden" name="Gift_Code" value="">
	<table cellspacing="0">
		<tr>
			<td class="blue" width="14%">�ֻ�����</td>
            <td>
				<input class="InputGrey"  type="text" v_must="1" v_type="mobphone" v_must=1 name="phoneNo" value="<%=iPhoneNo%>" id="phoneNo" v_name="�ֻ�����" onBlur="if(this.value!=''){if(checkElement(document.all.phoneNo)==false){return false;}}" maxlength=11 index="3" readonly >
			</td>
			<td class="blue">��������</td>
			<td>
				<input name="oCustName" type="text" class="InputGrey" id="oCustName" value="<%=bp_name%>" readonly>
			</td>
		</tr>
		<tr>
			<td class="blue">ҵ��Ʒ��</td>
            <td>
				<input name="oSmName" type="text" class="InputGrey" id="oSmName" value="<%=sm_name%>" readonly>
			</td>
            <td class="blue">�ʷ�����</td>
            <td>
				<input name="oModeName" type="text" class="InputGrey" id="oModeName" value="<%=rate_name%>" readonly>
			</td>
		</tr>
		<tr>
			<td class="blue">�ʺ�Ԥ��</td>
            <td>
				<input name="oPrepayFee" type="text" class="InputGrey" id="oPrepayFee" value="<%=prepay_fee%>" readonly>
			</td>
            <td class="blue">��ǰ����</td>
            <td>
				<input name="oMarkPoint" type="text" class="InputGrey" id="oMarkPoint" value="<%=print_note%>" readonly>
			</td>
		</tr>
		<tr>
			<td class="blue">��������</td>
			<td><input name="phoneType" class="InputGrey" type="text" v_name="��������"  value="<%=sale_name%>" >
			</td>
			<td class="blue">�澯���</td>
			<td><input name="warningMoney" class="button" type="text" v_name="�澯���" maxlength="17" value="" onKeyPress="return isKeyNumberdot(1)" onKeyDown="if(event.keyCode==13) doprint();"></td>
		</tr>
		<tr>
			<td class="blue">�����޶�</td>
			<td><input name="limitMoney" class="button" type="text" v_name="Ԥ���޶�" maxlength="17" value="" onKeyPress="return isKeyNumberdot(1)" onKeyDown="if(event.keyCode==13) doprint();"></td>
			<td class="blue">����ʱ��</td>
			<td><input name="endTime" class="button" type="text" v_name="����ʱ��"  value="" >(YYYYMMDD)</td>
		</tr>
		<tr>
			<td class="blue">ʡ�б�־</td>
			<td>
				<select name="typeCode" id="typeCode" v_name="ʡ�б�־" onchange="typechange()">
					<option value="" selected>--��ѡ��--</option>
					<option value="99">ʡ��˾</option>
		      		<option value="<%=result[0][0]%>"><%=result[0][1]%></option>
	    		</select>
			</td>
			<td class="blue">ʹ�õ�λ</td>
			<td>
				<select name="useUnit" id="useUnit" v_name="ʹ�õ�λ" onchange="unitchange()">
					<option value="">--��ѡ��--</option>
				</select>
			</td>
		</tr>
		<tr>
			<td class="blue">ʹ�ò���</td>
			<td>
				<select name="useDepartment" id="useDepartment" v_name="ʹ�ò���" onchange="chg_department()">
					<option value="">--��ѡ��--</option>
				</select>
			</td>
			<td class="blue">ʹ������</td>
			<td>
				<select name="useCenter" id="useCenter" v_name="ʹ������" >
					<option value="">--��ѡ��--</option>
				</select>
			</td>
		</tr>
		<tr>
			<td class="blue">ʹ����;</td>
			<td>
				<select name="useApplication" id="useApplication" v_name="ʹ����;" >
					<option value="">--��ѡ��--</option>
				</select>
			</td>
			<td class="blue">����</td>
			<td>
				<select name="useLevel" id="useLevel" v_name="����" >
					<option value="">--��ѡ��--</option>
					<%for (int i = 0; i < result1.length; i++) {%>
	      			<option value="<%=result1[i][0]%>"><%=result1[i][1]%>
	      			</option>
	    			<%}%>
				</select>
			</td>
		</tr>
		<tr>
			<td class="blue">�����ʷ�</td>
            <td id="ipTd" colspan="3">
				<select name="New_Mode_Code" id="New_Mode_Code" v_name="�����ʷ�" >
					<option value="">--��ѡ��--</option>
					<%for (int i = 0; i < modecodeStr.length; i++) {%>
	      			<option value="<%=modecodeStr[i][0]%>"><%=modecodeStr[i][1]%>
	      			</option>
	    			<%}%>
				</select>
			</td>
		</tr>

    <tr id="monitor-pattern" class="nodisp">
		  <td class="blue" width="12%">���ģʽ</td>
		  <td colspan="3">
		 	  <label>
		 	    <input type="checkbox" id="enum-message">����</input>
		   	</label>
		   	<label>
		   	  <input type="checkbox" id="enum-gprs">GPRS</input>
		   	</label>
		   	<label>
		   	  <input type="checkbox" id="enum-voice">����</input>
		   	</label>
		  </td>
		</tr>
		 
		<tr id="opposite-code" class="nodisp">
		  <td class="blue">�Զ˺���</td>
		  <td colspan="3">
		  	<input type="text" v_maxlength="20" v_type="0_9" name="code-opposite" value=""/>
		   	<input type="text" v_maxlength="20" v_type="0_9" name="code-opposite" value=""/>
		   	<input type="text" v_maxlength="20" v_type="0_9" name="code-opposite" value=""/>
		   	<input type="text" v_maxlength="20" v_type="0_9" name="code-opposite" value=""/>
		   	<input type="text" v_maxlength="20" v_type="0_9" name="code-opposite" value=""/>
		  </td>
		</tr>		
		 
		<tr id="apn-code" class="nodisp">
		  <td class="blue">APN����ڵ�</td>
		  <td colspan="3">
		    <input type="text" v_maxlength="20" v_type="string" name="code-apn" value=""/>
		  </td>
		</tr>
		
		<tr id="voice-info" class="nodisp">
		  <td class="blue">��վ</td>
		  <td>
		    <input type="text" v_maxlength="8" v_type="string" name="base-station" id="base-station" value=""/>
		  </td>
		  <td class="blue">С��</td>
		  <td>
		    <input type="text" v_maxlength="8" v_type="string" name="neighborhood" id="neighborhood" value=""/>
		  </td>
		</tr>
		
		<tr>
			<td class="blue">��ע</td>
			<td colspan="3">
				<input name="opNote" type="text" class="button" id="o	pNote" value="" size="40" maxlength="60">
			</td>
		</tr>
		<tr id="flagCodeTr" style="display:none">
		    <TD class="blue">С������</TD>
			  <TD colspan="3">
				    <input type="hidden" size="17" name="rate_code" id="rate_code" readonly>
           			<input type="text" class="InputGrey" name="flag_code" size="8" maxlength="10" readonly>
			      <input type="text" class="InputGrey" name="flag_code_name" size="18" readonly >&nbsp;&nbsp;
			      <input name="newFlagCodeQuery" type="button" class="b_text"  style="cursor:hand" onClick="getFlagCode()" value=ѡ��>
       		 </TD>
      	</tr>
		<tr>
			<td id="footer" colspan="4">
				<div align="center">
                &nbsp;
				<input name="commit" id="commit" type="button" class="b_foot"   value="ȷ��" onClick="formCommit();"  >
                &nbsp;
                <input class="b_foot" name="goback"  onClick="history.go(-1)" type=button value="����">
                &nbsp;
                <input name="close" onClick="removeCurrentTab();" type="button" class="b_foot" value="�ر�">
                &nbsp;
				</div>
			</td>
		</tr>
	</table>

<div name="licl" id="licl">
			<input type="hidden" name="iOpCode" value="4264">
			<input type="hidden" name="loginNo" value="<%=loginNo%>">
			<input type="hidden" name="orgCode" value="<%=orgCode%>">
			<!--���²�����Ϊ��f1270_3.jsp������Ĳ���
			i2:�ͻ�ID
			i16:��ǰ���ײʹ���
			ip:�������ײʹ���
			belong_code:belong_code
			print_note:��������
			iAddStr:

			i1:�ֻ�����
			i4:�ͻ�����
			i5:�ͻ���ַ
			i6:֤������
			i7:֤������
			i8:ҵ��Ʒ��

			ipassword:����
			group_type:���ſͻ����
			ibig_cust:��ͻ����
			do_note:�û���ע
			favorcode:�������Ż�Ȩ��
			maincash_no:�����ײʹ��루�ϣ�
			imain_stream:��ǰ���ʷѿ�ͨ��ˮ
			next_main_stream:ԤԼ���ʷѿ�ͨ��ˮ

			i18:�������ײ�
			i19:������
			i20:���������
			-->
			<input type="hidden" name="i2" value="<%=cust_id%>">
			<input type="hidden" name="i16" value="<%=rate_code%>">
			<input type="hidden" name="ip" value="">

			<input type="hidden" name="belong_code" value="<%=cust_belong_code%>">
			<input type="hidden" name="print_note" value="<%=print_note%>">
			<input type="hidden" name="iAddStr" value="">

			<input type="hidden" name="i1" value="">
			<input type="hidden" name="i4" value="<%=bp_name%>">
			<input type="hidden" name="i5" value="<%=bp_add%>">
			<input type="hidden" name="i6" value="<%=cardId_type%>">
			<input type="hidden" name="i7" value="<%=cardId_no%>">
			<input type="hidden" name="i8" value="<%=sm_code%>--<%=sm_name%>">
			<input type="hidden" name="i9" value="<%=contract_flag%>">

			<input type="hidden" name="ipassword" value="">
			<input type="hidden" name="group_type" value="<%=group_type_code%>--<%=group_type_name%>">
			<input type="hidden" name="ibig_cust" value="<%=bigCust_flag%>--<%=bigCust_name%>">
			<input type="hidden" name="do_note" value="">
			<input type="hidden" name="favorcode" value="<%=favorcode%>">
			<input type="hidden" name="maincash_no" value="<%=rate_code%>">
			<input type="hidden" name="imain_stream" value="<%=imain_stream%>">
			<input type="hidden" name="next_main_stream" value="<%=next_main_stream%>">

			<input type="hidden" name="i18" value="<%=next_rate_code%>--<%=next_rate_name%>">
			<input type="hidden" name="i19" value="<%=hand_fee%>">
			<input type="hidden" name="i20" value="<%=hand_fee%>">
			<input type="hidden" name="cus_pass" value="<%=cus_pass%>">
				
				
			<input type="hidden" name="mode_type" value="">
			<input type="hidden" name="New_Mode_Name" value="�����ʷ�����">
			<input type="hidden" name="return_page" value="/npage/bill/f4264_login.jsp">		
			<input type="hidden" name="sale_kind" value="<%=sale_kind%>">	
			<input type="hidden" name="main_phoneno" value="<%=main_phone%>">		
</div>
<%@ include file="/npage/include/footer.jsp" %>
</form>
</body>
</html>

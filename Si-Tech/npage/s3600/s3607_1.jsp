<!DOCTYPE html PUBLIC "-//W3C//Dtd Xhtml 1.0 transitional//EN" "http://www.w3.org/tr/xhtml1/Dtd/xhtml1-transitional.dtd">
<%
/********************
 version v2.0
 ������: si-tech
 update hejw@2009-1-20
********************/
%>
<%
  String opCode = "3607";
  String opName = "BOSS��VPMN������Ա����";
%>
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>     
<%@ page import="org.apache.log4j.Logger"%>
<%@ page import="com.sitech.boss.pub.*" %>
<%@ include file="../../include/remark.htm" %>


<%
	Logger logger = Logger.getLogger("s3607_1.jsp");
	
	String ipAddress = (String)session.getAttribute("ipAddr");
	String loginNo = (String)session.getAttribute("workNo");
	String workname = (String)session.getAttribute("workName");
	String orgCode = (String)session.getAttribute("orgCode");
	String loginPwd  = (String)session.getAttribute("password");
	String regionCode = (String)session.getAttribute("regCode");
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<HEAD>
	<TITLE>BOSS��VPMN������Ա�û�����</TITLE>
</HEAD>
<SCRIPT type=text/javascript>
	
//����
function ajaxSubmit(){
	$.ajax({
		type: "POST",
		url: "s3607_2.jsp",
		beforeSend:function(XMLHttpRequest){
				loading();
			},

			data:"loginAccept="+document.frm.loginAccept.value+"&"+
           "opCode="+document.frm.opCode.value+"&"+
           "loginNo="+document.frm.loginNo.value+"&"+
           "loginPwd="+document.frm.loginPwd.value+"&"+
           "orgCode="+document.frm.orgCode.value+"&"+
           "sysNote="+document.frm.sysNote.value+"&"+
           "opNote="+document.frm.opNote.value+"&"+
           "ipAddress="+document.frm.ipAddress.value+"&"+
           "phoneNo="+document.frm.phoneNo.value+"&"+
           "grpIdNo="+document.frm.grpIdNo.value+"&"+
           "grpOutNo="+document.frm.grpOutNo.value+"&"+
           "unitId="+document.frm.unitId.value,
           
		success: function(data, textStatus){
			$("body").html(data);
			$("body").html();
	  	}
	});
}

function OpCodeChange()
{
	if (document.frm.opCode.value == "3607")
	{
		document.frm.sysNote.value="BOSS��VPMN������Ա�û�����";
		document.frm.opNote.value="BOSS��VPMN������Ա�û�����";
	}
	else if (document.frm.opCode.value == "3604")
	{
		document.frm.sysNote.value="BOSS��VPMN��Ա�û�����";
		document.frm.opNote.value="BOSS��VPMN��Ա�û�����";
	}
	else if (document.frm.opCode.value == "3605")
	{
		document.frm.sysNote.value="BOSS��VPMN��Ա�û��ײͱ��";
		document.frm.opNote.value="BOSS��VPMN��Ա�û��ײͱ��";
	}
	ChgCurrStep("custQuery");
}

function ChgCurrStep(currStep)
{
	if (currStep == "custQuery")
	{
		document.frm.custQuery.disabled = false;
		document.frm.chkGrpPwd.disabled = true;
		//document.frm.qryPhone.disabled = true;
		//document.frm.chkUserPwd.disabled = true;
		document.frm.doSubmit.disabled = false;
	}
	else if (currStep == "chkGrpPwd")
	{
		document.frm.custQuery.disabled = false;
		document.frm.chkGrpPwd.disabled = false;
		//document.frm.qryPhone.disabled = true;
		//document.frm.chkUserPwd.disabled = true;
		document.frm.doSubmit.disabled = false;
	}
	else if (currStep == "qryPhone")
	{
		document.frm.custQuery.disabled = false;
		document.frm.chkGrpPwd.disabled = false;
		//document.frm.qryPhone.disabled = false;
		//document.frm.chkUserPwd.disabled = true;
		document.frm.doSubmit.disabled = false;
	}
	else if (currStep == "chkUserPwd")
	{
		document.frm.custQuery.disabled = false;
		document.frm.chkGrpPwd.disabled = false;
		//document.frm.qryPhone.disabled = false;
		//document.frm.chkUserPwd.disabled = false;
		document.frm.doSubmit.disabled = false;
	}
	else if (currStep == "doSubmit")
	{
		document.frm.custQuery.disabled = false;
		document.frm.chkGrpPwd.disabled = false;
		//document.frm.qryPhone.disabled = false;
		//document.frm.chkUserPwd.disabled = false;
		document.frm.doSubmit.disabled = false;
	}
}

function doProcess(packet)
{
	var retType = packet.data.findValueByName("retType");
	var retCode = packet.data.findValueByName("retCode");
	var retMessage = packet.data.findValueByName("retMessage");
	self.status="";
	if(retType == "checkPwd") //���ſͻ�����У
	{
		if(retCode == "000000")
		{
			var retResult = packet.data.findValueByName("retResult");
			if (retResult == "false")
			{
				ChgCurrStep("chkGrpPwd");
				frm.grpPwd.value = "";
				frm.grpPwd.focus();
				rdShowMessageDialog(retMessage);
				return false;
			}
			else
			{
				ChgCurrStep("qryPhone");
				rdShowMessageDialog("�ͻ�����У��ɹ���");
			}
		}
		else
		{
			rdShowMessageDialog(retMessage+retCode,0);
			return false;
		}
	}

	if(retType == "chkUserPwd") //�����û�����У
	{
		if(retCode == "0")
		{
			var retResult = packet.data.findValueByName("retResult");
			var retMessage = packet.data.findValueByName("retMessage");
			if (retResult == "false")
			{
				ChgCurrStep("chkUserPwd");
				rdShowMessageDialog(retMessage,0);
				frm.userPwd.value = "";
				frm.userPwd.focus();
				return false;
			}
			else
			{
				ChgCurrStep("doSubmit");
				rdShowMessageDialog("�û�����У��ɹ���");
			}
		}
		else
		{
			rdShowMessageDialog("�û�����У�����������У�飡");
			return false;
		}
	}

	//ȡ��ˮ
	if(retType == "getSysAccept")
	{
		if(retCode == "000000")
		{
			var sysAccept = packet.data.findValueByName("sysAccept");
			document.frm.loginAccept.value=sysAccept;
			showPrtDlg("Detail","ȷʵҪ��ӡ���������","Yes");
			if (rdShowConfirmDialog("�Ƿ��ύȷ�ϲ�����")==1)
			{
//				page = "s3607_2.jsp";
//				frm.action=page;
//				frm.method="post";
//				frm.submit();
					//return true;
					ajaxSubmit();
			}
			else return false;
		}
		else
		{
			rdShowMessageDialog("��ѯ��ˮ����,�����»�ȡ��");
			return false;
		}
	}
	if(retType == "QryPhoneInfo") //���ſͻ�����У
	{
		if(retCode == "000000")
		{
			var retResult = packet.data.findValueByName("retResult");
			var retMessage = packet.data.findValueByName("retMessage");
			if (retResult == "false")
			{
				rdShowMessageDialog(retMessage,0);
				frm.grpPwd.value = "";
				frm.grpPwd.focus();
				ChgCurrStep("qryPhone");
				return false;
			}
			else
			{
				document.frm.idNo.value=packet.data.findValueByName("idNo");
				document.frm.smCode.value=packet.data.findValueByName("smCode");
				document.frm.smName.value=packet.data.findValueByName("smName");
				document.frm.userName.value=packet.data.findValueByName("custName");
				//document.frm.userPwd.value=packet.data.findValueByName("userPwd");
				document.frm.mainRate.value=packet.data.findValueByName("mainRate");
				document.frm.mainRateName.value=packet.data.findValueByName("mainRateName");
				ChgCurrStep("chkUserPwd");
				rdShowMessageDialog("ȡ�û���Ϣ�ɹ���");
			}
		}
		else
		{
			rdShowMessageDialog(retMessage+retCode,0);
			return false;
		}
	}
}


//���ù������棬���м��ſͻ�ѡ��
function getInfo_Cust()
{
	var pageTitle = "���ſͻ�ѡ��";
	var fieldName = "֤������|���ſͻ�ID|�����û�ID|�����û�����|����ID|���Ų�Ʒ����|��Ա�趨����|��Ա�趨��������|";
	var sqlStr = "";
	var selType = "S";    //'S'��ѡ��'M'��ѡ
	var retQuence = "8|0|1|2|3|4|5|6|7|";
	var retToField = "idIccid|custId|grpIdNo|grpOutNo|unitId|unitName|mainRate|mainRateName|";
	var custId = document.frm.custId.value;

	if(document.frm.idIccid.value == "" &&
	document.frm.custId.value == "" &&
	document.frm.unitId.value == "" &&
	document.frm.grpOutNo.value == "")
	{
		rdShowMessageDialog("���������֤�š��ͻ�ID������ID�����û���Ž��в�ѯ��",0);
		document.frm.idIccid.focus();
		return false;
	}

	if(document.frm.custId.value != "" && forNonNegInt(frm.custId) == false)
	{
		frm.custId.value = "";
		rdShowMessageDialog("���������֣�",0);
		return false;
	}

	if(document.frm.unitId.value != "" && forNonNegInt(frm.unitId) == false)
	{
		frm.unitId.value = "";
		rdShowMessageDialog("���������֣�",0);
		return false;
	}

	if(document.frm.grpOutNo.value == "0")
	{
		frm.grpOutNo.value = "";
		rdShowMessageDialog("�����û���Ų���Ϊ0��",0);
		return false;
	}

	PubSimpSelCust(pageTitle,fieldName,sqlStr,selType,retQuence,retToField);
}

function PubSimpSelCust(pageTitle,fieldName,sqlStr,selType,retQuence,retToField)
{
	var path = "/npage/s3600/fpubgrpusr_sel.jsp";
	path = path + "?sqlStr=" + sqlStr + "&retQuence=" + retQuence;
	path = path + "&fieldName=" + fieldName + "&pageTitle=" + pageTitle;
	path = path + "&selType=" + selType+"&idIccid=" + document.all.idIccid.value;
	path = path + "&custId=" + document.all.custId.value;
	path = path + "&unitId=" + document.all.unitId.value;
	path = path + "&grpOutNo=" + document.all.grpOutNo.value;
	path = path + "&regionCode=" + document.all.regionCode.value;

	retInfo = window.open(path,"newwindow","height=450, width=830,top=50,left=100,scrollbars=yes, resizable=no,location=no, status=yes");

	return true;
}

function getvaluecust(retInfo)
{
	var retToField = "idIccid|custId|grpIdNo|grpOutNo|unitId|unitName|mainRate|mainRateName|";
	if(retInfo ==undefined)      
	{
		ChgCurrStep("custQuery");
		return false;
	}
	
	var chPos_field = retToField.indexOf("|");
	var chPos_retStr;
	var valueStr;
	var obj;
	while(chPos_field > -1)
	{
		obj = retToField.substring(0,chPos_field);
		chPos_retInfo = retInfo.indexOf("|");
		valueStr = retInfo.substring(0,chPos_retInfo);
		document.all(obj).value = valueStr;
		retToField = retToField.substring(chPos_field + 1);
		retInfo = retInfo.substring(chPos_retInfo + 1);
		chPos_field = retToField.indexOf("|");
	}
	ChgCurrStep("chkGrpPwd");
}

function check_HidPwd()
{
	var grpIdNo = document.frm.grpIdNo.value;
	var inPwd = document.frm.grpPwd.value;
	var checkPwd_Packet = new AJAXPacket("/npage/s3600/pubCheckPwd.jsp","���ڽ�������У�飬���Ժ�......");
	checkPwd_Packet.data.add("retType","checkPwd");
	checkPwd_Packet.data.add("GRP_ID",grpIdNo);
	checkPwd_Packet.data.add("inPwd",inPwd);
	core.ajax.sendPacket(checkPwd_Packet);
	checkPwd_Packet = null;
}

function ChkUserPwd()
{
	var checkPwd_Packet = new AJAXPacket("/npage/s3600/pubCheckPwd.jsp","���ڽ�������У�飬���Ժ�......");
	checkPwd_Packet.data.add("retType","chkUserPwd");
	checkPwd_Packet.data.add("ID_NO",document.frm.idNo.value);
	checkPwd_Packet.data.add("inPwd",document.frm.userPwd.value);
	core.ajax.sendPacket(checkPwd_Packet);
	checkPwd_Packet = null;
}

function QryPhoneInfo()
{
	if (checkElement("phoneNo"))
	{
		document.frm.phoneNo.focus();
	}
	var checkPwd_Packet = new AJAXPacket("/npage/s3600/getPhoneInfo.jsp","���ڽ�������У�飬���Ժ�......");
	checkPwd_Packet.data.add("retType","QryPhoneInfo");
	checkPwd_Packet.data.add("loginNo","<%=loginNo%>");
	checkPwd_Packet.data.add("phoneNo",document.frm.phoneNo.value);
	checkPwd_Packet.data.add("opCode",document.frm.opCode.value);
	checkPwd_Packet.data.add("grpIdNo",document.frm.grpIdNo.value);
	core.ajax.sendPacket(checkPwd_Packet);
	checkPwd_Packet = null;
}

//��ӡ��Ϣ
	 function printInfo(printType)
	 { 
		var retInfo = "";
		//var tmpOpCode=document.all.opCode.value;
		//if (tmpOpCode=="3605")
		//{
			retInfo+='<%=workname%>'+"|";
  		retInfo+='<%=new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(Calendar.getInstance().getTime())%>'+"|";
  		retInfo+="֤������:"+document.frm.idIccid.value+"|";
  		retInfo+="���ű���:"+document.frm.grpOutNo.value+"|";
  	 	retInfo+=""+"|";
    	retInfo+=""+"|";
    	retInfo+=""+"|";
    	retInfo+=""+"|";
    	retInfo+=""+"|";
    	retInfo+=""+"|";
    	retInfo+=""+"|";
    	retInfo+=""+"|";
    	retInfo+=""+"|";
    	retInfo+=""+"|";
    	retInfo+=""+"|";
    	retInfo+=""+"|";
    	retInfo+=""+"|";
    	retInfo+=""+"|";
    	retInfo+=""+"|";
    	retInfo+=""+"|";
    	retInfo+="����ҵ��"+"BOSS��VPMN��Ա�û�����"+"|";
    	retInfo+="�����ֻ�����:"+(document.all.phoneNo.value).replace(/\|/g,",")+"|";  
    	retInfo+="��Ա�趨����"+document.frm.mainRate.value+"->"+document.frm.mainRateName.value+"|";
    	retInfo+="��ˮ"+document.frm.loginAccept.value+"|";
    	retInfo+=""+"|";
    	retInfo+=""+"|";
    	retInfo+=""+"|";
    	retInfo+=""+"|";
    	retInfo+=document.frm.sysNote.value+"|";
    	retInfo+=document.all.simBell.value+"|";
    	retInfo+=""+"|";
		 return retInfo;
	 //}
	 }

//��ʾ��ӡ�Ի���
function showPrtDlg(printType,DlgMessage,submitCfm)
{
	var h=180;
	var w=350;
	var t=screen.availHeight/2-h/2;
	var l=screen.availWidth/2-w/2;
	var printStr = printInfo(printType);
	//wuxy alter 20090512 �������з�ӳ����
	//alert(printStr);
	if(printStr == "failed")
	{
		return false;
	}
	var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no"
	var path = "/npage/innet/hljBillPrint.jsp?DlgMsg=" + DlgMessage;
	var path = path + "&printInfo=" + printStr + "&submitCfm=" + submitCfm;
	var ret=window.showModalDialog(path,printStr,prop);
}


function QryNewRate()
{
    var pageTitle = "���ŷ�����Ϣ��ѯ";
    var fieldName = "���ŷ��ʴ���|���ŷ�������|";

	if (document.frm.grpIdNo.value == "")
	{
		alert("���Ŵ��벻��Ϊ�գ�");
		return false;
	}
	var sqlStr =	 "SELECT b.mode_code, b.mode_name"
				+"  FROM dGrpUserMsgAdd a, sBillModeCode b"
				+" WHERE trim(a.field_value) = b.mode_code"
				+"   AND id_no = " + document.frm.grpIdNo.value
				+"   AND b.region_code = '" + "<%=regionCode%>" + "'"
				+"   AND a.field_code = any('10000', '10001')"
				+" ORDER BY b.mode_code";
    
    var selType = "S";    //'S'��ѡ��'M'��ѡ
    var retQuence = "2|0|1|";
    var retToField = "newRate|newRateName|";
    PubSimpSel(pageTitle,fieldName,sqlStr,selType,retQuence,retToField);
}


function PubSimpSel(pageTitle,fieldName,sqlStr,selType,retQuence,retToField)
{
	var path = "/npage/public/fPubSimpSel.jsp";
	path = path + "?sqlStr=" + sqlStr + "&retQuence=" + retQuence;
	path = path + "&fieldName=" + fieldName + "&pageTitle=" + pageTitle;
	path = path + "&selType=" + selType;
	var retInfo = window.showModalDialog(path);
	//window.open(path);
	if(typeof(retInfo)=="undefined")
	{
		return false;
	}
	var chPos_field = retToField.indexOf("|");
	var chPos_retStr;
	var valueStr;
	var obj;
	//alert(retInfo);
	while(chPos_field > -1)
	{
		obj = retToField.substring(0,chPos_field);
		//alert(obj);
		chPos_retInfo = retInfo.indexOf("|");
		valueStr = retInfo.substring(0,chPos_retInfo);
		document.all(obj).value = valueStr;
		retToField = retToField.substring(chPos_field + 1);
		retInfo = retInfo.substring(chPos_retInfo + 1);
		chPos_field = retToField.indexOf("|");
	}
}

//ȡ��ˮ
function getSysAccept()
{
	var getSysAccept_Packet = new AJAXPacket("pubSysAccept.jsp","�������ɲ�����ˮ�����Ժ�......");
	getSysAccept_Packet.data.add("retType","getSysAccept");
	core.ajax.sendPacket(getSysAccept_Packet);
	getSysAccept_Packet =null;
}

function refMain()
{
	getAfterPrompt();
	if(  document.frm.grpIdNo.value == "" )
	{
		rdShowMessageDialog("�����û�ID����Ϊ��!!");
		document.frm.idIccid.select();
		return false;
	}
	
	if (document.frm.opCode.value == "3605")
	{
		if (document.frm.newRate.value == document.frm.mainRate.value ||document.frm.newRate.value=="")
		{
			rdShowMessageDialog("�·��ʲ���Ϊ�գ��¾ɷ���Ҳ������ͬ!");
			document.frm.newRate.focus();
			return false;
		}
	}
	getSysAccept();
	//wuxy alter 20090826 ������ȷ����ȡ�����ύ����
	//ajaxSubmit();
}

</script>
<BODY>
	<FORM action="" method="post" name="frm" >
		<%@ include file="/npage/include/header.jsp" %>

		<input type="hidden" name="loginAccept"  value="0"> <!-- ������ˮ�� -->
		<input type="hidden" name="loginNo"  value="<%=loginNo%>">
		<input type="hidden" name="loginPwd"  value="<%=loginPwd%>">
		<input type="hidden" name="orgCode"  value="<%=orgCode%>">
		<input type="hidden" name="ipAddress"  value="<%=ipAddress%>">
		<input type="hidden" name="regionCode"  value="<%=regionCode%>">
		<input type="hidden" name="unitName"  >
			<div class="title">
	   	<div id="title_zi">BOSS��VPMN��Ա�û��������������ײͱ��</div>
			</div>
<TABLE cellSpacing="0">
	<TR>
		<TD class="blue">
			<div align="left">��������</div>
		</TD>
		<TD colspan="3">
			<SELECT name="opCode"  id="opCode" onChange="OpCodeChange()">
				<option value="3607">������Ա����</option>
			</SELECT>
			<font class="orange">*</font>
		</TD>
	</TR>
							<TR>
								<TD  class="blue">
									<div align="left">���֤���ʷѴ���</div>
								</TD>
								<TD>
									<input name="idIccid"  id="idIccid" size="24" maxlength="18" v_type="string" v_must=1 v_name="���֤��" index="1" value="">
									<input name=custQuery type=button id="custQuery"  onMouseUp="getInfo_Cust();" onKeyUp="if(event.keyCode==13)getInfo_Cust();" style="cursorhand" value=��ѯ class="b_text">
									<font class="orange">*</font>
								</TD>
								<TD  class="blue">���ſͻ�ID</TD>
								<TD>
									<input  type="text" name="custId" size="20" maxlength="18" v_type="0_9" v_must=1 v_name="�ͻ�ID" index="2" value="">
									<font class="orange">*</font>
								</TD>
							</TR>
							<TR>
								<TD class="blue">
									<div align="left">����ID</div>
								</TD>
								<TD>
									<input name=unitId  id="unitId" size="24" maxlength="10" v_type="0_9" v_must=1 v_name="����ID" index="3" value="">
									<font class="orange">*</font>
								</TD>
								<TD class="blue">�����û����</TD>
								<TD>
									<input  name="grpOutNo" size="20" v_must=1 v_type=string v_name="�����û����" index="4" value="">
									<font class="orange">*</font>
								</TD>
							</TR>
							<TR>
								<TD class="blue">�����û�ID</TD>
								<TD>
									<input  name="grpIdNo" size="20" readonly v_must=1 v_type=string v_name="�����û�ID" index="4" value="" class="InputGrey">
									<font class="orange">*</font>
								</TD>
								<TD class="blue">���ſͻ�����</TD>
								<TD>
									<jsp:include page="/npage/common/pwd_1.jsp">
									<jsp:param name="width1" value="16%"  />
									<jsp:param name="width2" value="34%"  />
									<jsp:param name="pname" value="grpPwd"  />
									<jsp:param name="pwd" value=""  />
									</jsp:include>

									<input name=chkGrpPwd type=button onClick="check_HidPwd();"  style="cursorhand" id="chkGrpPwd" value=У�� class="b_text">
									<font class="orange">*</font>
								</TD>
							</TR>
														<TR>
								<TD  class="blue">��Ա�趨����</TD>
								<TD>
									<input name="mainRate"  type="text" v_must=1 v_maxlength=8 v_type="string" v_name="��Ա�趨����" index="8" value="" readonly class="InputGrey">
									<font class="orange">*</font>
								</TD>
								<TD  class="blue">��Ա�趨��������</TD>
								<TD>
									<input name="mainRateName"  type="text" v_must=1 v_maxlength=8 v_type="string" v_name="��Ա�趨��������" index="8" value="" readonly class="InputGrey">
									<font class="orange">*</font>
								</TD>
							</TR>
							<TR>
								<TD class="blue">�ֻ�����</TD>
								<TD colspan="3">
								<textarea cols=30 rows=8 name="phoneNo" style="overflow:auto" v_must=1 v_minlength="11" v_maxlength="15" v_type="string" v_name="�ֻ�����" index="8"></textarea>
								<br>ע���������ֻ�����ʱ,����"|"��Ϊ�ָ�<br>
								��,�������һ������Ҳ����"|"��Ϊ����.<br>
								���磺13900000000|<br>
								&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;13900000001|<br>
								</TD>
							</TR>

							<TR>
								<TD  class="blue">��ע��Ϣ</TD>
								<TD colspan="3">
									<input  name="opNote" size="60" value="BOSS��VPMN��Ա�û�����" class="InputGrey" readonly >

									<input  name="sysNote" size="60" value="BOSS��VPMN��Ա�û�����" type="hidden">

								</TD>
							</TR>
						
							<TR>
								<TD align=center id="footer" colspan="4">
									<input  name="doSubmit"  type=button value="ȷ��" onclick="refMain()" class="b_foot">
									<input  name="reset1"  onClick="" type=reset value="���" class="b_foot">
									<input  name="kkkk"  onClick="removeCurrentTab()" type=button value="�ر�" class="b_foot">
								</TD>
							</TR>
						</TABLE>


		<%@ include file="/npage/include/footer.jsp" %>
	</FORM>
<script language="JavaScript">
	document.frm.idIccid.focus();
	ChgCurrStep("custQuery");
	OpCodeChange();
</script>
</BODY>
</HTML>

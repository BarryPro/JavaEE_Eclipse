<!DOCTYPE html PUBLIC "-//W3C//Dtd Xhtml 1.0 transitional//EN" "http://www.w3.org/tr/xhtml1/Dtd/xhtml1-transitional.dtd">
<%
  /*
   * ����:��ʵ���û����ÿͻ���Ϣ����
   * �汾: 1.0
   * ����: 2009/10/26
   * ����: gaolw
   * ��Ȩ: si-tech
  */
%>
<%@	page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ include file="/npage/bill/getMaxAccept.jsp" %>
<%@ page import="java.util.*" %>
<%@ page import="java.io.*"%>

<%
	response.setHeader("Pragma","No-Cache"); 
	response.setHeader("Cache-Control","No-Cache");
	response.setDateHeader("Expires", 0); 
 
	String opCode = "6839";
	String opName = "��ʵ���û����ÿͻ���Ϣ����";
	String dateStr = new java.text.SimpleDateFormat("yyyyMM").format(new java.util.Date());
	String orgCode =(String)session.getAttribute("orgCode");
	String regionCode = orgCode.substring(0,2);
	String groupId = (String)session.getAttribute("groupId");
	
	String zphoneNo = (String)request.getParameter("activePhone");
	
	String vLoginAccept="";
	vLoginAccept = getMaxAccept();
%>

<html xmlns="http://www.w3.org/1999/xhtml">
<HEAD>
<script language="JavaScript">

var oprType_Add = "A";
var oprType_Upd = "U";
var oprType_Qry = "Q";


onload=function()
{		
	init();
}

function init()
{
	chg_opType();
	document.all.tPhoneNo.value = '<%=zphoneNo%>';
}	


function chg_opType()
{
	resetJsp();
	with(document.frm6839)
	{
		var op_type = opType[opType.selectedIndex].value;

		if( op_type == oprType_Add )
		{ 
			showA0.style.display="";
			showA.style.display="";
			showAU2.style.display="";
			showAU3.style.display="";
			showAU4.style.display="";
			showAU5.style.display="";
			showA1.style.display="";
			tCustName.disabled=true;
			tCustRunName.disabled=true;
			confirm.disabled=true;
			
			showU.style.display="none";
			showU1.style.display="none";
			showQ.style.display="none";
			showQ1.style.display="none";
			oprDiv.style.display="none";
		}
		else if(op_type == oprType_Upd)
		{ 
			showU.style.display="";
			showA.style.display="";
			showAU2.style.display="";
			showAU3.style.display="";
			showAU4.style.display="";
			showAU5.style.display="";
			showU1.style.display="";
			confirm1.disabled=true;
			
			showA0.style.display="none";
			//showA.style.display="none";
			showQ.style.display="none";
			showQ1.style.display="none";
			showA1.style.display="none";
			oprDiv.style.display="none";
		}
		else
		{
			showQ.style.display="";
			showQ1.style.display="";
			oprDiv.style.display="";
			
			showA0.style.display="none";
			showA.style.display="none";
			showAU2.style.display="none";
			showAU3.style.display="none";
			showAU4.style.display="none";
			showAU5.style.display="none";
			showU.style.display="none";
			showU1.style.display="none";
			showA1.style.display="none";
	  }
	}
}	

function resetJsp()
{
var op_type = document.frm6839.opType[document.frm6839.opType.selectedIndex].value;
	if( op_type == oprType_Add )
	{	
		document.frm6839.tPhoneNo.value = "";
		document.frm6839.tCustName.value = "";
		document.frm6839.tCustRunName.value = "";	
		document.frm6839.tCustName1.value = "";
		document.frm6839.idType.value = -1;
		document.frm6839.idIccid.value = "";	
		document.frm6839.tContactPhone.value = "";
		document.frm6839.contactMail.value = "";
		document.frm6839.tContactAddr.value = "";
	}	
	else if(op_type == oprType_Upd)
	{
		document.frm6839.tPhoneNo1.value = "";
		document.frm6839.tCustName1.value = "";
		document.frm6839.idType.value = -1;
		document.frm6839.idIccid.value = "";	
		document.frm6839.tContactPhone.value = "";
		document.frm6839.contactMail.value = "";
		document.frm6839.tContactAddr.value = "";
	}
	else
	{
		document.frm6839.tPhoneNo2.value = "";
	}
}
	

function commitJspQry()
{
	var op_type = document.frm6839.opType[document.frm6839.opType.selectedIndex].value;

	if( op_type == oprType_Upd ||op_type == oprType_Add )
	{
		
		rdShowMessageDialog("���ӻ��޸Ĳ������ܵ����ѯ,����ȷ��!");
		return false;					
	}
	if
	( !judge_valid() )
	{
		return false;
	}
	
	var tPhoneNo2 = document.frm6839.tPhoneNo2.value;
	
	
	document.getElementById("qryOprInfoFrame").style.display="block"; 
	document.qryOprInfoFrame.location = "f6839getqry.jsp?tPhoneNo2="+tPhoneNo2;
}

function judge_valid()
{
	with(document.frm6839){
	var op_type = document.frm6839.opType[document.frm6839.opType.selectedIndex].value;
	if(op_type == oprType_Add){
		if(tPhoneNo.value == ""){
  				rdShowMessageDialog("�������ֻ����룡");
  				tPhoneNo.focus();
  				return false;
			}
			if(tCustName.value == ""){
  				rdShowMessageDialog("�ͻ�����Ϊ�գ������ֻ������Ĳ�ѯ��ť��");
  				return false;
			}
			if(tCustRunName.value == ""){
  				rdShowMessageDialog("�ͻ�״̬Ϊ�գ������ֻ������Ĳ�ѯ��ť��");
  				return false;
			}
			if(tCustName1.value == ""){
  				rdShowMessageDialog("������ͻ�ʵ����");
  				tCustName1.focus();
  				return false;
			}
			if(idType.value == -1){
  				rdShowMessageDialog("��ѡ��֤�����ͣ�");
  				idType.focus();
  				return false;
			}
			if(idIccid.value == ""){
  				rdShowMessageDialog("������֤�����룡");
  				idIccid.focus();
  				return false;
			}
			if(tContactAddr.value == ""){
  				rdShowMessageDialog("��������ϵ�˵�ַ��");
  				tContactAddr.focus();
  				return false;
			}
		}
		else if(op_type == oprType_Upd)
		{
			if(tPhoneNo1.value == ""){
  				rdShowMessageDialog("�������ֻ����룡");
  				tPhoneNo.focus();
  				return false;
			}
			if(tCustName1.value == ""){
  				rdShowMessageDialog("������ͻ�ʵ����");
  				tCustName1.focus();
  				return false;
			}
			if(idType.value == -1){
  				rdShowMessageDialog("��ѡ��֤�����ͣ�");
  				idType.focus();
  				return false;
			}
			if(idIccid.value == ""){
  				rdShowMessageDialog("������֤�����룡");
  				idIccid.focus();
  				return false;
			}
			if(tContactAddr.value == ""){
  				rdShowMessageDialog("��������ϵ�˵�ַ��");
  				tContactAddr.focus();
  				return false;
			}
		}
		else
		{
			if(tPhoneNo2.value == 0){
	  			rdShowMessageDialog("�������ֻ����룡");
	  			tPhoneNo1.focus();
	  			return false;
			}
		}
	return true
	}
}
//У��email
function emailCheck() {
	var strEmail = document.frm6839.contactMail.value;
	if (strEmail.search(/^\w+((-\w+)|(\.\w+))*\@[A-Za-z0-9]+((\.|-)[A-Za-z0-9]+)*\.[A-Za-z0-9]+$/) != -1)
	{
	  rdShowMessageDialog("У��ɹ�!",2);	
		return true;
	}
	else{
		rdShowMessageDialog("�����ʼ���ʽ���󣡵����ʼ���ַ������� ( @ �� . )����ȷ��ʽ���£���XXX@XXX.XXX��");
		document.frm6839.contactMail.value = "";
	  document.frm6839.contactMail.focus();
	  return false;
	}
}


//   copy from common_util.js
function rpc_chkX(x_type,x_no,chk_kind)
{
  var obj_type=document.all(x_type);
  var obj_no=document.all(x_no);
  var idname="";
  
  if(obj_type.type=="text")
  {
    idname=(obj_type.value).trim();
  }
  else if(obj_type.type=="select-one")
  {
    idname=(obj_type.options[obj_type.selectedIndex].text).trim();  
  }

  if((obj_no.value).trim().length>0)
  {
		if((obj_no.value).trim().length<5)
		{   
		  rdShowMessageDialog("֤�����볤����������5λ����");
		  obj_no.focus();
		  return false;
		}
		else
		{
	      if(idname=="���֤")
		  {
	        if(checkElement(obj_no)==false) 
	        return false;
		  }
		  document.frm6839.confirm.disabled=false;
		  document.frm6839.confirm1.disabled=false;
		}
  }
  else 
	return;
  var myPacket = new AJAXPacket("/npage/innet/chkX.jsp","������֤��������Ϣ�����Ժ�......");
	  myPacket.data.add("retType","chkX");
	  myPacket.data.add("retObj",x_no);
	  myPacket.data.add("x_idType",getX_idno(idname));
	  myPacket.data.add("x_idNo",obj_no.value);
	  myPacket.data.add("x_chkKind",chk_kind);
	  core.ajax.sendPacket(myPacket);
	  myPacket=null;
  
}

function getX_idno(xx)
{
  if(xx==null) return "0";
  
  if(xx=="���֤") return "0";
  else if(xx=="����֤") return "1";
  else if(xx=="��ʻ֤") return "2";
  else if(xx=="����֤") return "4";
  else if(xx=="ѧ��֤") return "5";
  else if(xx=="��λ") return "6";
  else if(xx=="У԰") return "7";
  else if(xx=="Ӫҵִ��") return "8";
  else return "0";
}

function phoneNoQry()
{
	if(document.all.tPhoneNo.value != "" )
	{ 
		var myPacket = new AJAXPacket("f6839_getInfo.jsp","���ڻ�ȡ��Ϣ�����Ժ�......");
		myPacket.data.add("tPhoneNo",document.all.tPhoneNo.value);
		core.ajax.sendPacket(myPacket);
		myPacket=null;
	}
	else
	{
		rdShowMessageDialog("��ѡ�����ֻ����룡");
		document.all.tPhoneNo.focus();
		return false;
	}
}
function phoneNoUQry()
{
	if(document.all.tPhoneNo1.value != "" )
	{ 
		var myPacket = new AJAXPacket("f6839_getInfoUp.jsp","���ڻ�ȡ��Ϣ�����Ժ�......");
		myPacket.data.add("tPhoneNo1",document.all.tPhoneNo1.value);
		core.ajax.sendPacket(myPacket);
		myPacket=null;
	}
	else
	{
		rdShowMessageDialog("��ѡ�����ֻ����룡");
		document.all.tPhoneNo1.focus();
		return false;
	}
}

// �ж�rpc_select��Ǩ��
function doProcess(packet)
{ 
	var retType = packet.data.findValueByName("retType");
	var rpc_flag = packet.data.findValueByName("rpc_flag");
	self.status="";
	
	if(retType=="chkX")
	{ 
		var retCode = packet.data.findValueByName("retCode"); 
    var retMessage = packet.data.findValueByName("retMessage"); 
    if(retCode != "000000")
	  { 
			document.frm6839.confirm.disabled=true;
		  document.frm6839.confirm1.disabled=true;
			rdShowMessageDialog(retMessage);
			document.frm6839.idIccid.focus();
			return;
	  }
    var retObj = packet.data.findValueByName("retObj");
		if(retCode == "000000"){
				rdShowMessageDialog("У��ɹ�!",2);			
			}else if(retCode=="100001"){
				retMessage = retCode + "��"+retMessage;	
				rdShowMessageDialog(retMessage);		 
				return true;
    	}else{
				retMessage = "����" + retCode + "��"+retMessage;			 
				rdShowMessageDialog(retMessage,0);
				document.all(retObj).focus();
				return false;
			}
	}
	else if(rpc_flag == "1")
	{
		var retCode0 = packet.data.findValueByName("retCode0");
		var retMsg =  packet.data.findValueByName("retMsg");
		var retCode1 = packet.data.findValueByName("retCode1");
		var retMsg1 = packet.data.findValueByName("retMsg1");
		if(retCode0 != "000000")
		{ 
			rdShowMessageDialog(retMsg);
			return;
		}
		if(retCode1 != "000000")
		{ 
			rdShowMessageDialog(retMsg1);
			return;
		}
		rdShowMessageDialog("���û�Ϊ��Ч�û���");
		
		resetJsp();
		return;
	}
	else if(rpc_flag == "2")
	{
		var retCode0 = packet.data.findValueByName("retCode0");
		var retMsg =  packet.data.findValueByName("retMsg");	
		var retCode1 = packet.data.findValueByName("retCode1");
		var retMsg1 = packet.data.findValueByName("retMsg1");
		if(retCode0 != "000000")
		{ 
			rdShowMessageDialog(retMsg);
			return;
		}
		if(retCode1 != "000000")
		{ 
			rdShowMessageDialog(retMsg1);
			return;
		}
		
		var custName = packet.data.findValueByName("custName");
		var runName = packet.data.findValueByName("runName");
		var idNo = packet.data.findValueByName("idNo");
		var custId = packet.data.findValueByName("custId");
		document.frm6839.tCustName.value = custName;
		document.frm6839.tCustRunName.value = runName;
		document.frm6839.idNo.value = idNo;
		document.frm6839.custId.value = custId;
	}
	else if(rpc_flag == "3")
	{
		var retCode0 = packet.data.findValueByName("retCode0");
		var retMsg =  packet.data.findValueByName("retMsg");	
		var retCode1 = packet.data.findValueByName("retCode1");
		var retMsg1 = packet.data.findValueByName("retMsg1");
		if(retCode0 != "000000")
		{ 
			rdShowMessageDialog(retMsg);
			return;
		}
		if(retCode1 != "000000")
		{ 
			rdShowMessageDialog(retMsg1);
			return;
		}
    rdShowMessageDialog("���ֻ������ڱ���ʵ���ͻ���Ϣ�������м�¼����ѡ���޸Ĳ�����");
		
		resetJsp();
		return;
	}
	else if(rpc_flag == "4")
	{
		var retCode0 = packet.data.findValueByName("retCode0");
		var retMsg =  packet.data.findValueByName("retMsg");
		if(retCode0 != "000000")
		{ 
			rdShowMessageDialog(retMsg);
			return;
		}
		rdShowMessageDialog("���û�Ϊ��Ч�û�����ʵ���ͻ���Ϣ���в����ڸ��û���");
		
		resetJsp();
		return;
	}
	else if(rpc_flag == "5")
	{ 
		var retCode0 = packet.data.findValueByName("retCode0");
		var retMsg =  packet.data.findValueByName("retMsg");
		if(retCode0 != "000000")
		{ 
			rdShowMessageDialog(retMsg);
			return;
		}
		
		var custName = packet.data.findValueByName("custName");
		var idType = packet.data.findValueByName("idType");
		var idiccid = packet.data.findValueByName("idiccid");
		var idAddr = packet.data.findValueByName("idAddr");
		var contactphone = packet.data.findValueByName("contactphone");
		var contactemail = packet.data.findValueByName("contactemail");
		var idName = packet.data.findValueByName("idName");
		var idNo = packet.data.findValueByName("idNo");
		var custName1 = packet.data.findValueByName("custName1");
		var runName1 = packet.data.findValueByName("runName1");
		
		document.frm6839.tCustName1.value = custName;
		document.frm6839.idType.value = idType+"|"+idName;
		document.frm6839.idIccid.value = idiccid;
		document.frm6839.tContactPhone.value = contactphone;
		document.frm6839.contactMail.value = contactemail;
		document.frm6839.tContactAddr.value = idAddr;
		document.frm6839.idNo.value = idNo;
		document.frm6839.tCustName.value = custName1;
		document.frm6839.tCustRunName.value = runName1;
	}
}

function change_idType()
{		
    var Str = document.frm6839.idType.value;
    if(Str.indexOf("���֤") > -1)
    {   document.frm6839.idIccid.v_type = "idcard";   }
    else
    {   document.frm6839.idIccid.v_type = "string";   }
}

function feifa(textName)
{
	if(textName.value != "")
	{
		if((textName.value.indexOf("~")) != -1 || (textName.value.indexOf("|")) != -1 || (textName.value.indexOf(";")) != -1)
		{
			rdShowMessageDialog("����������Ƿ��ַ������������룡");
			textName.value = "";
			textName.focus();
 	  		return;
		}
	}
}

//�����������
function printCommit()
{ getAfterPrompt();
	var op_type = document.frm6839.opType[document.frm6839.opType.selectedIndex].value;

	if(op_type == oprType_Qry)
	{
		rdShowMessageDialog("��ѯ�������ܵ��ȷ�ϣ�������ѯ!");
		return false;
	}
	if( !judge_valid() )
	{
		return false;
	}
	var ret = showPrtDlg("Detail","ȷʵҪ���е��������ӡ��","Yes"); 
	if(typeof(ret)!="undefined")
	{
		if((ret=="confirm"))
		{
			if(rdShowConfirmDialog('ȷ�ϵ��������')==1)
			{
				doCfm();
			}
		}
		if(ret=="continueSub")
		{
			if(rdShowConfirmDialog('ȷ��Ҫ�ύ��Ϣ��')==1)
			{
				doCfm();
			}
		}
	}
	else
	{
		if(rdShowConfirmDialog('ȷ��Ҫ�ύ��Ϣ��')==1)
		{
			doCfm();
		}
	}
}

function doCfm()
{ 
	frm6839.action="f6839Cfm.jsp";
	frm6839.submit();
}

function showPrtDlg(printType,DlgMessage,submitCfm)
{  //��ʾ��ӡ�Ի��� 
	var h=210;
	var w=400;
	var t=screen.availHeight/2-h/2;
	var l=screen.availWidth/2-w/2;
	var pType="subprint";
	var billType="1";  
	var printStr = printInfo(printType);
   
	var mode_code=null;
	var fav_code=null;
	var area_code=null;
	var activePhone = null;
	if(document.frm6839.opType[document.frm6839.opType.selectedIndex].value=="A"){
		activePhone = document.frm6839.tPhoneNo.value;
	}else if (document.frm6839.opType[document.frm6839.opType.selectedIndex].value=="U") {
		activePhone = document.frm6839.tPhoneNo1.value;
	}
	
	
	var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no"; 
	var path = "<%=request.getContextPath()%>/npage/innet/hljBillPrint_jc.jsp?DlgMsg=" + DlgMessage;
	path = path  + "&mode_code="+mode_code+"&fav_code="+fav_code+"&area_code="+area_code+"&opCode=<%=opCode%>&sysAccept=<%=vLoginAccept%>&phoneNo="+activePhone+"&submitCfm=" + submitCfm+"&pType="+pType+"&billType="+billType+ "&printInfo=" + printStr;
	var ret=window.showModalDialog(path,printStr,prop);
	return ret;
}

function printInfo(printType)
{
		var cust_info="";
		var opr_info="";
		var note_info1="";
		var note_info2="";
		var note_info3="";
		var note_info4="";
		
		var retInfo = "";
		
		if(document.frm6839.opType[document.frm6839.opType.selectedIndex].value=="A"){
			var idicType = document.all.idType.value.split("|");
			var idicType1 = idicType[1];
			
			cust_info+="�ֻ����룺"+document.all.tPhoneNo.value+"|";
			cust_info+="�ͻ�������"+document.all.tCustName.value+"|";
			
			opr_info+="�������ݣ����ÿͻ���Ϣ¼��"+"|";
			opr_info+="������ˮ��<%=vLoginAccept%>"+"|";
			opr_info+="�ͻ�ʵ����"+document.all.tCustName1.value+"|";
			opr_info+="֤�����ͣ�"+idicType1+"|";
			opr_info+="֤�����룺"+document.all.idIccid.value+"|";
			opr_info+="��ϵ�˵绰��"+document.all.tContactPhone.value+"|";
			opr_info+="��ϵ��E_MAIL��"+document.all.contactMail.value+"|";
			opr_info+="��ϵ�˵�ַ��"+document.all.tContactAddr.value+"|";
			
			note_info1+="��ע�����ӷ�ʵ���û����ÿͻ���Ϣ����"+"|";
	  }else if (document.frm6839.opType[document.frm6839.opType.selectedIndex].value=="U") {
			var idicType = document.all.idType.value.split("|");
			var idicType1 = idicType[1];
			
			cust_info+="�ֻ����룺"+document.all.tPhoneNo1.value+"|";
			cust_info+="�ͻ�������"+document.all.tCustName.value+"|";
			
			opr_info+="�������ݣ����ÿͻ���Ϣ�޸�"+"|";
			opr_info+="������ˮ��<%=vLoginAccept%>"+"|";
			opr_info+="�ͻ�ʵ����"+document.all.tCustName1.value+"|";
			opr_info+="֤�����ͣ�"+idicType1+"|";
			opr_info+="֤�����룺"+document.all.idIccid.value+"|";
			opr_info+="��ϵ�˵绰��"+document.all.tContactPhone.value+"|";
			opr_info+="��ϵ��E_MAIL��"+document.all.contactMail.value+"|";
			opr_info+="��ϵ�˵�ַ��"+document.all.tContactAddr.value+"|";	
			
			note_info1+="��ע���޸ķ�ʵ���û����ÿͻ���Ϣ����"+"|";
	  }
		
		
			
		retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
		retInfo=retInfo.replace(new RegExp("#","gm"),"%23");
    return retInfo;
}

</script> 
 
<title>��ʵ���û����ÿͻ���Ϣ����</title>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
</head>
<BODY>
<form  method="post" name="frm6839"  >
	<input type="hidden" name="opCode" value="<%=opCode%>">
	<input type="hidden" name="opName" value="<%=opName%>">
	<%@ include file="/npage/include/header.jsp" %>
	<div class="title">
		<div id="title_zi">��ʵ���û����ÿͻ���Ϣ����</div>
	</div>
<table cellspacing="0">             
		<tr> 
			<td class="blue" nowrap width="15%">��������</td>
			<td colspan='3'> 
				<select name="opType" class="button" id="opType" onChange="chg_opType()">
					<option value="A" selected>����</option>
					<option value="U">�޸�</option>
					<option value="Q" >��ѯ</option>
				</select> 
			</td>
		</tr>
		<tr id="showA0" > 
	    <td nowrap class=blue>�ֻ�����</td>
	    <td nowrap colspan='3'> 
        <input type="text"  name="tPhoneNo" v_must="1" v_type="0_9" maxlength="15" style="ime-mode:disabled" onKeyPress="return isKeyNumberdot(0)" >
        <font class="orange">*</font>
        <input type="button" name="bPhoneNoQry" class="b_text" value="��ѯ" onclick="phoneNoQry()" >
	    </td>
		</tr>
		<tr id="showU" > 
	    <td nowrap class=blue>�ֻ�����</td>
	    <td nowrap colspan='3'> 
        <input type="text" name="tPhoneNo1" v_must=1 v_type="0_9" maxlength=15 style="ime-mode:disabled" onKeyPress="return isKeyNumberdot(0)">
        <font class="orange">*</font>
        <input type="button" name="bPhoneNoQry" class="b_text" value="��ѯ" onclick="phoneNoUQry()" >
	    </td>
		</tr>
		<tr id="showA" > 
		  <td nowrap class=blue>�ͻ�����</td>
		  <td nowrap> 
		  	<input type="text" name="tCustName" v_must=1   maxlength=60 >
		  </td>
		  <td nowrap class=blue>�ͻ�״̬</td>
		  <td nowrap> 
		  	<input type="text" name="tCustRunName" v_must=1   maxlength=12 >
		  </td>
		</tr>
		<tr id="showAU2" >
			<td class=blue nowrap>�ͻ�ʵ��</td>
			<td nowrap colspan='3'> 
			    <input type="text" name="tCustName1" v_must=1   maxlength=60 >
			    <font class="orange">*</font>
			</td>
		</tr>
   <tr id="showAU3" >
				<td class=blue nowrap>֤������</td>
				<td nowrap> 
				  <select align="left" name="idType" onChange="change_idType()" width=50 index="10">
				  	<option value="-1">--��ѡ��--</option>
<%
      //�õ��������
      String sqlStr3 ="select trim(ID_TYPE), ID_NAME,ID_NAME from sIdType order by id_type";           
%>
			<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>"  retcode="retCode3" retmsg="retMsg3" outnum="3">
			<wtc:sql><%=sqlStr3%></wtc:sql>
			</wtc:pubselect>
			<wtc:array id="result3" scope="end"/> 
<%
      if(retCode3.equals("000000")){
     
      System.out.println("���÷���ɹ���");
              int recordNum3 = result3.length;                  
                for(int i=0;i<recordNum3;i++){
                       out.println("<option class='button' value='" + result3[i][0] + "|" + result3[i][2] + "'>" + result3[i][1] + "</option>");
                }
      
       }else{
    	 System.out.println("***********************************************************************");
         System.out.println("���÷���ʧ�ܣ�");
    	   
    	}              
               
           
%>
		    </select>
		  </td>
		  <td class=blue nowrap>֤������</td>
		  <td nowrap> 
		    <input type="text" name="idIccid"  id="idIccid" v_must=1 v_minlength=5 v_maxlength=20 v_type="string" onChange="change_idType()" maxlength="20"  index="11" value="" onblur="if(checkElement(this));feifa(this);">
		    <input type="button" name="idCheck" class="b_text" value="��֤" onclick="rpc_chkX('idType','idIccid','A')" >
		    <font class=orange>*</font>
		  </td>
		</tr>     
		<tr id="showAU4" >
		    <td class=blue nowrap>��ϵ�˵绰</td>
		    <td nowrap> 
		    	<input type="text" name="tContactPhone" v_must=1 v_type="0_9" maxlength=15 style="ime-mode:disabled" onKeyPress="return isKeyNumberdot(0)">
		    </td>
		    <td class=blue nowrap>��ϵ��E_MAIL</td>
		    <td nowrap> 
		        <input name="contactMail" class="button" v_must=0 v_type="email" v_name="��ϵ��E_MAIL" maxlength="30"  index="24" >            
		        <input type="button" name="MailCheck" class="b_text" value="��֤" onclick="emailCheck()" >
		    </td>
		</tr>
		<tr id="showAU5" >
			<td class=blue nowrap>��ϵ�˵�ַ</td>
			<td nowrap colspan='3'> 
			    <input type="text" name="tContactAddr" v_must=1   maxlength=60 >
			    <font class="orange">*</font>
			</td>
		</tr>
		
		<!--��ѯ-->
		<tr id="showQ" > 
	    <td nowrap class=blue>�ֻ�����</td>
	    <td nowrap colspan='3'> 
        <input type="text" name="tPhoneNo2" v_must=1 v_type="0_9" maxlength=15 style="ime-mode:disabled" onKeyPress="return isKeyNumberdot(0)">
        <font class="orange">*</font>
	    </td>
		</tr>

	<tr id="showA1"> 
		<td align="center" id="footer" colspan="4"> 
			<input type="button" name="confirm" class="b_foot" value="ȷ��&��ӡ" onclick="printCommit()">
			&nbsp;
			<input type="button" name="querry"  class="b_foot" value="��ѯ" onclick="commitJspQry()">
			&nbsp;
			<input type="button" name="reset" class="b_foot" value="���" onclick="resetJsp()">
		</td>
	</tr>
	<tr id="showU1"> 
		<td align="center" id="footer" colspan="4"> 
			<input type="button" name="confirm1" class="b_foot" value="ȷ��&��ӡ" onclick="printCommit()">
			&nbsp;
			<input type="button" name="querry1"  class="b_foot" value="��ѯ" onclick="commitJspQry()">
			&nbsp;
			<input type="button" name="reset1" class="b_foot" value="���" onclick="resetJsp()">
		</td>
	</tr>
	<tr id="showQ1"> 
		<td align="center" id="footer" colspan="4"> 
			<input type="button" name="querry1"  class="b_foot" value="��ѯ" onclick="commitJspQry()">
			&nbsp;
			<input type="button" name="reset1" class="b_foot" value="���" onclick="resetJsp()">
		</td>
	</tr>
</table>
  <input type="hidden" name="idNo" value="">
	<input type="hidden" name="custId" value="">
	<input type="hidden" name="vLoginAccept" value="<%=vLoginAccept%>">
<div id="oprDiv">
	<table cellspacing="0">
		<tr>
			<td style="height:0;">
				<iframe frameBorder="0" id="qryOprInfoFrame" align="center" name="qryOprInfoFrame" scrolling="yes" style="height:300px;overflow-y:auto; visibility:inherit; width:100%; z-index:1; display:none;"  onload="document.getElementById('qryOprInfoFrame').style.height=qryOprInfoFrame.document.body.scrollHeight+'px'"></iframe>
			</td>
		</tr>
	</table>
</div>
	 <%@ include file="/npage/include/footer.jsp" %>
</form>
</BODY>
</HTML>
<%
/********************
 version v2.0
 ������: si-tech
 update hejw@2009-1-16
********************/
%> 

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

	
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>  
<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>
<%@ page import="org.apache.log4j.Logger"%>
<%@ page import="com.sitech.boss.pub.*" %>
<%@ page import="java.util.StringTokenizer"%>
<%@ page import="com.sitech.boss.s1900.config.productCfg" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.GregorianCalendar" %>

<%@ include file="../../include/remark.htm" %>

<%
	String opCode = request.getParameter("opCode");
	String opName = request.getParameter("opName");
	String flag ="";
	String flag1 ="";
	String flag2 ="";
	if(opCode.equals("3702")){
		flag="selected";
	}else if(opCode.equals("3704")){
		flag1="selected";	
	}else{
	  flag2="selected";
	}
%>


<%
Logger logger = Logger.getLogger("s3702.jsp");

String ipAddress = (String)session.getAttribute("ipAddr");
String loginNo = (String)session.getAttribute("workNo");
String workname = (String)session.getAttribute("workName");
String orgCode = (String)session.getAttribute("orgCode");
String loginPwd  = (String)session.getAttribute("password");
String regionCode = (String)session.getAttribute("regCode");


Date date = new Date();
SimpleDateFormat df = new SimpleDateFormat("yyyyMM");
GregorianCalendar gc = new GregorianCalendar();
gc.setTime(date); 
gc.add(2,1);
gc.set(gc.get(gc.YEAR),gc.get(gc.MONTH),gc.get(gc.DATE));
String beginDate=df.format(gc.getTime())+"01";
gc.add(1,1);
String endDate=df.format(gc.getTime())+"01";
System.out.println("xxxxxxxxxxxxxxxx"+beginDate);
System.out.println("xxxxxxxxxxxxxxxx"+endDate);

String dateStr = new java.text.SimpleDateFormat("yyyyMMdd").format(new java.util.Date());//wuxy add 20090207

%>
<html xmlns="http://www.w3.org/1999/xhtml">
<HEAD>
	<TITLE>ͳһ���ѳ�Ա����</TITLE>
</HEAD>
<SCRIPT type=text/javascript>

//����
function ajaxSubmit(){
	$.ajax({
		type: "POST",
		url: "s3702_2.jsp",
		beforeSend:function(XMLHttpRequest){
				loading();
			},
		data:"opCode="+document.frm.opCode.value+"&"+
		"opName="+document.frm.opName.value+"&"+
		"loginAccept="+document.frm.loginAccept.value+"&"+
		"loginNo="+document.frm.loginNo.value+"&"+
		"loginPwd="+document.frm.loginPwd.value+"&"+
		"orgCode="+document.frm.orgCode.value+"&"+
		"sysNote="+document.frm.sysNote.value+"&"+
		"opNote="+document.frm.opNote.value+"&"+
		"ipAddress="+document.frm.ipAddress.value+"&"+
		"phoneNo="+document.frm.phoneNo.value+"&"+
		"grpIdNo="+document.frm.grpIdNo.value+"&"+
		"grpOutNo="+document.frm.grpOutNo.value+"&"+
		"unitId="+document.frm.unitId.value+"&"+
		"allPayFlag="+document.frm.allPayFlag.value+"&"+
		"allFlag="+document.frm.allFlag.value+"&"+
		"cycleMoney="+document.frm.cycleMoney.value+"&"+
		"beginDate="+document.frm.beginDate.value+"&"+
		"endDate="+document.frm.endDate.value,
	
		success: function(data, textStatus){
			$("body").html(data);
			$("body").html();
	  	}
	});
}

function OpCodeChange()
{
	if (document.frm.opCode.value == "3702")
	{
		document.frm.sysNote.value="����BOSS�Ż�������Ա�û�����";
		document.frm.opNote.value="����BOSS�Ż�������Ա�û�����";
		document.all.allPayFlag.value="1";
		changePayFlag();
		document.all.line_0.style.display="";
		document.frm.opName.value="ͳһ���ѳ�Ա����";
		getBeforePrompt(document.frm.opCode.value);
		var a=document.all.allPayFlag;
		var b=document.all.allFlag;
		a.remove(0);
		b.remove(0);
		a.remove(1);
		b.remove(1);
		var   o1=document.createElement('option');   
  	o1.text="ͳ��";   
 		o1.value="1";   
  	a.add(o1); 
  	var   o2=document.createElement('option');   
  	o2.text="����Ŀ��ͳ��";   
 		o2.value="0";   
  	a.add(o2); 
		
  	
	  var  p1=document.createElement('option');   
  	p1.text="�����";   
 		p1.value="0";  
 		b.add(p1);
 		var  p2=document.createElement('option');   
  	p2.text="ȫ���";   
 		p2.value="1";  
 		b.add(p2);
	}
	else if (document.frm.opCode.value == "3704")
	{
		document.frm.sysNote.value="����BOSS�Żݳ�Ա�û�����";
		document.frm.opNote.value="����BOSS�Żݳ�Ա�û�����";
		document.all.allPayFlag.value="0";
		changePayFlag();
		document.all.line_0.style.display="none";
		document.frm.opName.value="ͳһ���ѳ�Ա����(ɾ��) ";
		getBeforePrompt(document.frm.opCode.value);
	}
	else if (document.frm.opCode.value == "3605")
	{
		document.frm.sysNote.value="BOSS��VPMN��Ա�û��ײͱ��";
		document.frm.opNote.value="BOSS��VPMN��Ա�û��ײͱ��";
		document.frm.opName.value="BOSS��VPMN��Ա����(�ײͱ��)";
		getBeforePrompt(document.frm.opCode.value);
	}else if(document.frm.opCode.value == "3318"){
		document.frm.sysNote.value="����BOSS�Ż�������Ա�û�����";
		document.frm.opNote.value="����BOSS�Ż�������Ա�û�����";
		document.all.allPayFlag.value="1";
		changePayFlag();
		document.all.line_0.style.display="";
		document.frm.opName.value="ͳһ���ѳ�Ա����";
		getBeforePrompt(document.frm.opCode.value);
		var a=document.all.allPayFlag;
		//a.remove(0);
		a.remove(1);
		var b=document.all.allFlag;
		//b.remove(0);
		b.remove(1);
		//var   o1=document.createElement('option');   
  	//o1.text="ͳ��";   
 		//o1.value="1";   
  	//a.add(o1); 
	  //var  p1=document.createElement('option');   
  	//p1.text="�����";   
 		//p1.value="0";  
 		//b.add(p1);
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
		//document.frm.doSubmit.disabled = false;
	}
	else if (currStep == "chkGrpPwd")
	{
		document.frm.custQuery.disabled = false;
		document.frm.chkGrpPwd.disabled = false;
		//document.frm.qryPhone.disabled = true;
		//document.frm.chkUserPwd.disabled = true;
		//document.frm.doSubmit.disabled = false;
	}
	else if (currStep == "qryPhone")
	{
		document.frm.custQuery.disabled = false;
		document.frm.chkGrpPwd.disabled = false;
		//document.frm.qryPhone.disabled = false;
		//document.frm.chkUserPwd.disabled = true;
		//document.frm.doSubmit.disabled = false;
	}
	else if (currStep == "chkUserPwd")
	{
		document.frm.custQuery.disabled = false;
		document.frm.chkGrpPwd.disabled = false;
		//document.frm.qryPhone.disabled = false;
		//document.frm.chkUserPwd.disabled = false;
		//document.frm.doSubmit.disabled = false;
	}
	else if (currStep == "doSubmit")
	{
		document.frm.custQuery.disabled = false;
		document.frm.chkGrpPwd.disabled = false;
		//document.frm.qryPhone.disabled = false;
		//document.frm.chkUserPwd.disabled = false;
		//document.frm.doSubmit.disabled = false;
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
				rdShowMessageDialog("�ͻ�����У��ɹ���",2);
				document.all.doSubmit.disabled=false;
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
				document.all.doSubmit.disabled=false;
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
				 //return true;
				 ajaxSubmit()
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
	var fieldName = "֤������|���ſͻ�ID|���Ų�ƷID|�����û�����|���ű��|���Ų�Ʒ����|��������|";
	var sqlStr = "";
	var selType = "S";    //'S'��ѡ��'M'��ѡ
	var retQuence = "7|0|1|2|3|4|5|6|";
	var retToField = "idIccid|custId|grpIdNo|grpOutNo|unitId|smName|grpName|";
	var custId = document.frm.custId.value;

	if(document.frm.idIccid.value == "" &&
	document.frm.custId.value == "" &&
	document.frm.unitId.value == "" &&
	document.frm.grpOutNo.value == "")
	{
		rdShowMessageDialog("������֤�����롢���ſͻ��ͻ�ID�����ű�Ż����û���Ž��в�ѯ��",0);
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
	var path = "/npage/s3700/fpubgrpusr_sel3702.jsp";
	path = path + "?sqlStr=" + sqlStr + "&retQuence=" + retQuence;
	path = path + "&fieldName=" + fieldName + "&pageTitle=" + pageTitle;
	path = path + "&selType=" + selType+"&idIccid=" + document.all.idIccid.value;
	path = path + "&custId=" + document.all.custId.value;
	path = path + "&unitId=" + document.all.unitId.value;
	path = path + "&grpOutNo=" + document.all.grpOutNo.value;

	retInfo = window.open(path,"newwindow","height=450, width=830,top=50,left=100,scrollbars=yes, resizable=no,location=no, status=yes");

	return true;
}

function getvaluecust(retInfo)
{
	var retToField = "idIccid|custId|grpIdNo|grpOutNo|unitId|smName|grpName|";
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
	checkPwd_Packet =null;
}

//��ӡ��Ϣ
	 function printInfo(printType)
	 { 
		var retInfo = "";
		var tmpOpCode=document.all.opCode.value;
		if (tmpOpCode=="3702" || tmpOpCode=="3704")
		{
			retInfo+='<%=workname%>'+"|";
    		retInfo+='<%=new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss", Locale.getDefault()).format(new java.util.Date())%>'+"|";
    		retInfo+="���֤��:"+document.frm.idIccid.value+"|";
    		retInfo+="�û�����:"+document.frm.grpName.value+"|";
    		retInfo+="�����û�����:"+document.frm.grpOutNo.value+"|";
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
    	retInfo+="ҵ������"+document.frm.opCode.options[document.frm.opCode.selectedIndex].text+"|";
    	retInfo+="��ˮ"+document.frm.loginAccept.value+"|";
    	retInfo+=""+"|";
    	retInfo+=""+"|";
    	retInfo+=""+"|";
    	retInfo+=""+"|";
    	retInfo+=""+"|";
    	retInfo+=""+"|";
    	retInfo+=document.frm.sysNote.value+"|";
    	retInfo+=document.all.simBell.value+"|";
		 return retInfo;
	 }
	 }

//��ʾ��ӡ�Ի���
function showPrtDlg(printType,DlgMessage,submitCfm)
{
	var h=163;
	var w=375;
	var t=screen.availHeight/2-h/2;
	var l=screen.availWidth/2-w/2;
	var printStr = printInfo(printType);
	if(printStr == "failed")
	{
		return false;
	}
	var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no"
	var path = "/npage/innet/hljPrint.jsp?DlgMsg=" + DlgMessage;
	var path = path + "&printInfo=" + printStr + "&submitCfm=" + submitCfm;
	var ret=window.showModalDialog(path,"",prop);
}


function QryNewRate()
{
    var pageTitle = "���ŷ�����Ϣ��ѯ";
    var fieldName = "���ŷ��ʴ���|���ŷ�������|";

	if (document.frm.grpIdNo.value == "")
	{
		rdShowMessageDialog("���Ŵ��벻��Ϊ�գ�");
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
	getSysAccept_Packet = null;
}

function refMain()
{
	getAfterPrompt(document.frm.opCode.value);
	if (document.frm.opCode.value=="3702"||document.frm.opCode.value=="3318")
		if (document.frm.allPayFlag.value == "1")
		{
			if (document.frm.cycleMoney.value == "")
			{
				rdShowMessageDialog("�����붨����");
				document.frm.cycleMoney.focus();
				return false;
			}
			if (!forMoney(document.frm.cycleMoney))
			{
				document.frm.cycleMoney.focus();
				return false;
			}
			if (document.frm.beginDate.value == "" || document.frm.endDate.value == "")
			{
				rdShowMessageDialog("�����뿪ʼ���ںͽ�������");
				document.frm.allFlag.focus();
				return false;
			}
			if (!forDate(document.all.beginDate))
			{
					document.all.beginDate.focus();
					return false;
			}
			if (!forDate(document.all.endDate))
			{
					document.all.endDate.focus();
					return false;
			}
			
			//wuxy add 20090207 �������ƿ�ʼ���ڱ�ѡ���ڵ�ǰ����
			if(parseInt(document.all.yearmonth.value)>parseInt(document.all.beginDate.value))
			{
				rdShowMessageDialog("��ʼ����Ӧ���ڵ��ڵ�ǰ����"+document.all.yearmonth.value,0);
				return false;
			}
			
			if(document.all.beginDate.value>document.all.endDate.value)
			{
				rdShowMessageDialog("��ʼ���ڲ�����Ƚ���������");
				document.all.beginDate.focus();
				return false;
			}
		}
	
	if(  document.frm.phoneNo.value == "" )
	{
		rdShowMessageDialog("�������ֻ�����");
		document.frm.phoneNo.focus();
		return false;
	}
	
	if(  document.frm.grpIdNo.value == "" )
	{
		rdShowMessageDialog("���Ų�ƷID����Ϊ��!!");
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
	//wuxy alter 20090826 Ϊ���ȷ����ȡ�����ύ����
	//ajaxSubmit();
	
}

function changeFlag(){
	if(document.all.allFlag.value=="1"){
		document.all.line_111.style.display="none";
		document.all.cycleMoney.value="0";
	}
	else{
		document.all.line_111.style.display="";
		document.all.cycleMoney.value="";
	}
}

function changePayFlag(){
	if(document.all.allPayFlag.value=="0")
	{
		document.all.line_111.style.display="none";
		document.all.line_1.style.display="none";
		document.all.line_2.style.display="none";
	}
	else
	{
		document.all.line_111.style.display="";
		document.all.line_1.style.display="";
		document.all.line_2.style.display="";
	}
}
	function getBeforePrompt(opCode)
	{
		var packet = new AJAXPacket("/npage/include/getBeforePrompt.jsp","���Ժ�...");
		packet.data.add("opCode" ,opCode);
	  core.ajax.sendPacketHtml(packet,doGetBeforePrompt,true);//�첽
		packet =null;
	}
	
	function doGetBeforePrompt(data)
	{
		$('#wait').hide();
		$('#beforePrompt').html(data);
	}
	
	function getAfterPrompt(opCode)
	{
		var packet = new AJAXPacket("/npage/include/getAfterPrompt.jsp","���Ժ�...");
		packet.data.add("opCode" ,opCode);
	  core.ajax.sendPacket(packet,doGetAfterPrompt,false);//ͬ��
		packet =null;
	}
	
	function doGetAfterPrompt(packet)
	{
    var retCode = packet.data.findValueByName("retCode"); 
    var retMsg = packet.data.findValueByName("retMsg"); 
    if(retCode=="000000"){
    	promtFrame(retMsg);
    }
	}
</script>
<BODY onload="getBeforePrompt(<%=opCode%>)">
	<div id ="loadpage"></div>
	<FORM action="" method="post" name="frm" >
		<%@ include file="/npage/include/header.jsp" %>
		<input type="hidden" name="loginAccept"  value="0"> <!-- ������ˮ�� -->
		<input type="hidden" name="loginNo"  value="<%=loginNo%>">
		<input type="hidden" name="loginPwd"  value="<%=loginPwd%>">
		<input type="hidden" name="smName"  value="">
		<input type="hidden" name="grpName"  value="">
		<input type="hidden" name="orgCode"  value="<%=orgCode%>">
		<input type="hidden" name="ipAddress"  value="<%=ipAddress%>">
		<input type="hidden" name="opName"  value="<%=opName%>">
			<input type="hidden" name="yearmonth"  value="<%=dateStr%>"><!-- wuxy add 20090207 -->
	<div class="title">
		<div id="title_zi">ͳһ���ѳ�Ա����</div>
	</div>
	<div id="results"></div>
						<TABLE cellSpacing="0">
							<TR>
								<TD class="blue">
									<div align="left">��������</div>
								</TD>
								<TD colspan="3">
									<SELECT name="opCode"  id="opCode" onChange="OpCodeChange()">
										<option value="3702" <%=flag%>>������Ա����</option>
										<option value="3318" <%=flag2%>>������Ա�޸�(ͳ����)</option>
										<option value="3704" <%=flag1%>>������Ա����</option>
									</SELECT>
									<font class="orange">*</font>
								</TD>
							</TR>
							<TR>
								<TD  class="blue">
									<div align="left">֤������</div>
								</TD>
								<TD>
									<input name="idIccid"  id="idIccid" size="24" maxlength="18" v_type="string" v_must=1  index="1" value="">
									<input name=custQuery type=button id="custQuery"  onMouseUp="getInfo_Cust();" onKeyUp="if(event.keyCode==13)getInfo_Cust();" style="cursorhand" value=��ѯ class="b_text">
									<font class="orange">*</font>
								</TD>
								<TD  class="blue">���ſͻ�ID</TD>
								<TD>
									<input  type="text" name="custId" size="20" maxlength="18" v_type="0_9" v_must=1  index="2" value="">
									<font class="orange">*</font>
								</TD>
							</TR>
							<TR>
								<TD class="blue">
									<div align="left">���ű��</div>
								</TD>
								<TD>
									<input name=unitId  id="unitId" size="24" maxlength="10" v_type="0_9" v_must=1  index="3" value="">
									<font class="orange">*</font>
								</TD>
								<TD class="blue">�����û����</TD>
								<TD>
									<input  name="grpOutNo" size="20" v_must=1 v_type=string  index="4" value="">
									<font class="orange">*</font>
								</TD>
							</TR>
							<TR>
								<TD class="blue">���Ų�ƷID</TD>
								<TD COLSPAN="1">
									<input  name="grpIdNo" size="20" readonly v_must=1 v_type=string  index="4" value="">
									<font class="orange">*</font>
								</TD>
								<TD class="blue">���ſͻ�����</TD>
								<TD colspan="1">
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
								<TD class="blue">�ֻ�����</TD>
								<TD colspan="1">
								<textarea cols=30 rows=8 name="phoneNo" style="overflow:auto" v_must=1 v_minlength="11" v_maxlength="15" v_type="string"  index="8"></textarea>
								

								</TD>
								<TD><br>ע���������ֻ�����ʱ,����"|"��Ϊ�ָ�<br>
								��,�������һ������Ҳ����"|"��Ϊ����.<br>
								���磺13900000000|<br>
								&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;13900000001|<br></TD>
								<TD>&nbsp;</TD>
								
							</TR>
            <TR id="line_0"> 		
			    <TD class="blue">ͳ����־</TD>
	            <TD  colspan=3>	              	
	            	<select name="allPayFlag" onchange="changePayFlag()">	 
	              	<!--<option value="0">ͳ��</option> -->
	              	<option value="1">����Ŀ���</option>
	              	</select>&nbsp;<font class="orange">*</font>
	            </TD>
	          </TR> 
            <TR id="line_1"> 		
			    <TD class="blue">ȫ���־</TD>
	            <TD colspan=3>	              	
	            	<select name="allFlag" onchange="changeFlag()">
	            			<!--<option value="0">�����</option>  -->
	              		<option value="1">ȫ���</option>           		
	              	</select>&nbsp;<font class="orange">*</font>
	            </TD>
	          </TR> 
	         <TR id="line_111">    	              
	            <TD class="blue">������</TD>
	            <TD colspan=3>
	              	<input type="text"  v_type="money"  v_must="1" v_minlength="1" v_maxlength="14"   name="cycleMoney" maxlength="14">&nbsp;<font class="orange">*</font>
	            </TD>
	         </TR>
	         
	         <TR id="line_2"> 
				<TD class="blue">��ʼ����</TD>
	            <TD height = 20>
	              	<input type="text"  name="beginDate" maxlength="8" value="<%=dateStr%>" v_type="date"  v_must="1" v_format="yyyyMMdd">
	              	&nbsp;(��ʽ:yyyymmdd)&nbsp;<font class="orange">*</font>            	
	            </TD> 			
			    <TD class="blue">��������</TD>
	            <TD height = 20>
	              	<input type="text" name="endDate" maxlength="8" value="<%=endDate%>" v_type="date"  v_must="1"  v_format="yyyyMMdd">
	              	&nbsp;(��ʽ:yyyymmdd)&nbsp;<font class="orange">*</font>  
	            </TD> 		            	              
	         </TR>
									<input  name="sysNote" size="60" value="BOSSͳһ�Żݳ�Ա����" readonly type="hidden"> 
							<TR>
								<TD  class="blue">�û���ע</TD>
								<TD colspan="3">
									<input  name="opNote" size="60" value="BOSSͳһ�Żݳ�Ա����" class="InputGrey">
								</TD>
							</TR>
						</TABLE>
						<TABLE cellSpacing="0">
							<TR>
								<TD align=center>
									<input name="doSubmit" type=button value="ȷ��" onclick="refMain()" disabled class="b_foot">
									<input name="reset1"  onClick="" type=reset value="���" class="b_foot">
									<input name="kkkk"  onClick="removeCurrentTab()" type=button value="�ر�" class="b_foot">
								</TD>
							</TR>
						</TABLE>
	<div id="relationArea" style="display:none"></div>
				<div id="wait" style="display:none">
				<img  src="/nresources/default/images/blue-loading.gif" />
			</div>
			<div id="beforePrompt"></div>
		</DIV>   
</DIV>		
		<jsp:include page="/npage/common/pwd_comm.jsp"/>
			
<%@ include file="/npage/include/footer_simple.jsp" %>
	</FORM>
<script language="JavaScript">
	document.frm.idIccid.focus();
	ChgCurrStep("custQuery");
	OpCodeChange();
</script>
</BODY>
</HTML>

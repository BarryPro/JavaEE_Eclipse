<%
/********************
 version v2.0
 ������: si-tech
 update hejw@2009-2-4
********************/
%>

<%
  String opCode = request.getParameter("opCode");
  String opName = request.getParameter("opName");
  String flag="";
  String flag1="";
  String flag2="";
  if(opCode.equals("3603")){
  	flag="selected";
  }else if(opCode.equals("3604")){
  	flag1="selected";
  }else if(opCode.equals("3605")){
  	flag2="selected";
  }
%>            

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>         
<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>
<%@ page import="org.apache.log4j.Logger"%>
<%@ page import="com.sitech.boss.pub.*" %>
<%@ page import="java.util.StringTokenizer"%>
<%@ page import="com.sitech.boss.s1900.config.productCfg" %>
<%@ include file="../../include/remark.htm" %>

<%
Logger logger = Logger.getLogger("f3603_1.jsp");

String ipAddress = (String)session.getAttribute("ipAddr");
String loginNo = (String)session.getAttribute("workNo");
String workname = (String)session.getAttribute("workName");
String orgCode = (String)session.getAttribute("orgCode");
String loginPwd  =(String)session.getAttribute("password");
String regionCode = (String)session.getAttribute("regCode");
%>


<HTML>
<HEAD>
	<TITLE>BOSS��VPMN��Ա�û��������������ײͱ��</TITLE>
</HEAD>
<SCRIPT type=text/javascript>

function OpCodeChange()
{
	if (document.frm.opCode.value == "3603")
	{
		document.frm.sysNote.value="BOSS��VPMN��Ա�û�����";
		document.frm.opNote.value="BOSS��VPMN��Ա�û�����";
		document.all.trNewRate.style.display="none";
	}
	else if (document.frm.opCode.value == "3604")
	{
		document.frm.sysNote.value="BOSS��VPMN��Ա�û�����";
		document.frm.opNote.value="BOSS��VPMN��Ա�û�����";
		document.all.trNewRate.style.display="none";
	}
	else if (document.frm.opCode.value == "3605")
	{
		document.frm.sysNote.value="BOSS��VPMN��Ա�û��ײͱ��";
		document.frm.opNote.value="BOSS��VPMN��Ա�û��ײͱ��";
		document.all.trNewRate.style.display="";
	}
	ChgCurrStep("custQuery");
	getBeforePrompt(document.frm.opCode.value);
}

function ChgCurrStep(currStep)
{
	if (currStep == "custQuery")
	{
		document.frm.custQuery.disabled = false;
		document.frm.chkGrpPwd.disabled = true;
		document.frm.qryPhone.disabled = false;
		//document.frm.chkUserPwd.disabled = true;
		document.frm.doSubmit.disabled = false;
	}
	else if (currStep == "chkGrpPwd")
	{
		document.frm.custQuery.disabled = false;
		document.frm.chkGrpPwd.disabled = false;
		document.frm.qryPhone.disabled = false;
		//document.frm.chkUserPwd.disabled = true;
		document.frm.doSubmit.disabled = false;
	}
	else if (currStep == "qryPhone")
	{
		document.frm.custQuery.disabled = false;
		document.frm.chkGrpPwd.disabled = false;
		document.frm.qryPhone.disabled = false;
		//document.frm.chkUserPwd.disabled = true;
		document.frm.doSubmit.disabled = false;
	}
	else if (currStep == "chkUserPwd")
	{
		document.frm.custQuery.disabled = false;
		document.frm.chkGrpPwd.disabled = false;
		document.frm.qryPhone.disabled = false;
		//document.frm.chkUserPwd.disabled = false;
		document.frm.doSubmit.disabled = false;
	}
	else if (currStep == "doSubmit")
	{
		document.frm.custQuery.disabled = false;
		document.frm.chkGrpPwd.disabled = false;
		document.frm.qryPhone.disabled = false;
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
		if(retCode == "0")
		{
			var retResult = packet.data.findValueByName("retResult");
			if (retResult == "false")
			{
				ChgCurrStep("chkGrpPwd");
				frm.grpPwd.value = "";
				frm.grpPwd.focus();
				if (rdShowConfirmDialog(retMessage+"<br>�Ƿ񱣴������Ϣ��")==1)	
					{
						var path="/npage/s3600/s3603_1_printxls.jsp?phoneNo=" + document.all.phoneNo.value;
						path = path + "&returnMsg=" + retMessage;
						path = path +  "&unitID=" + document.all.unitId.value;
	  					path = path + "&op_Code=" + document.all.opCode.value;
	  					path = path + "&orgCode=" + document.all.orgCode.value;
          					window.open(path);
          					
					}
				return false;
			}
			else
			{
				ChgCurrStep("qryPhone");
				rdShowMessageDialog("�ͻ�����У��ɹ���",2);
			}
		}
		else
		{
			
			if (rdShowConfirmDialog(retMessage+retCode+"<br>�Ƿ񱣴������Ϣ��")==1)	
					{
						
						var path="/npage/s3600/s3603_1_printxls.jsp?phoneNo=" + document.all.phoneNo.value;
						path = path + "&returnMsg=" + retMessage+retCode;
						path = path +  "&unitID=" + document.all.unitId.value;
	  					path = path + "&op_Code=" + document.all.opCode.value;
	  					path = path + "&orgCode=" + document.all.orgCode.value;
          					window.open(path);
          					
					}
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
				
				if (rdShowConfirmDialog(retMessage+"<br>�Ƿ񱣴������Ϣ��")==1)	
					{
						
						var path="/npage/s3600/s3603_1_printxls.jsp?phoneNo=" + document.all.phoneNo.value;
						path = path + "&returnMsg=" + retMessage;
						path = path +  "&unitID=" + document.all.unitId.value;
	  					path = path + "&op_Code=" + document.all.opCode.value;
	  					path = path + "&orgCode=" + document.all.orgCode.value;
          					window.open(path);
          					
					}
				frm.userPwd.value = "";
				frm.userPwd.focus();
				return false;
			}
			else
			{
				ChgCurrStep("doSubmit");
				rdShowMessageDialog("�û�����У��ɹ���",2);
			}
		}
		else
		{
			rdShowMessageDialog("�û�����У�����������У�飡",0);
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
				page = "s3603_2.jsp";
				frm.action=page;
				frm.method="post";
				frm.submit();
			}
			else return false;
		}
		else
		{
			rdShowMessageDialog("��ѯ��ˮ����,�����»�ȡ��",0);
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
				if (rdShowConfirmDialog(retMessage+"<br>�Ƿ񱣴������Ϣ��")==1)	
					{
						
						var path="/npage/s3600/s3603_1_printxls.jsp?phoneNo=" + document.all.phoneNo.value;
						path = path + "&returnMsg=" + retMessage;
						path = path +  "&unitID=" + document.all.unitId.value;
	  					path = path + "&op_Code=" + document.all.opCode.value;
	  					path = path + "&orgCode=" + document.all.orgCode.value;
          					window.open(path);
          					
					}
				//frm.grpPwd.value = "";
				//frm.grpPwd.focus();
				ChgCurrStep("qryPhone");
				return false;
			}
			else
			{
				if(packet.data.findValueByName("runCode")!='A' 
					&& packet.data.findValueByName("runCode")!='B' 
					&& packet.data.findValueByName("runCode")!='C'
					&& packet.data.findValueByName("runCode")!='D'
					&& packet.data.findValueByName("runCode")!='E'
					&& packet.data.findValueByName("runCode")!='F'
					&& packet.data.findValueByName("runCode")!='G'
					&& packet.data.findValueByName("runCode")!='H'
					&& packet.data.findValueByName("runCode")!='I'
					&& packet.data.findValueByName("runCode")!='K'
					&& packet.data.findValueByName("runCode")!='L'
					&& packet.data.findValueByName("runCode")!='M')
				{
					
					document.frm.idNo.value="";
					document.frm.smCode.value="";
					document.frm.smName.value="";
					document.frm.userName.value="";
					document.frm.mainRate.value="";
					document.frm.mainRateName.value="";

					if (rdShowConfirmDialog("������״̬�û�[" + packet.data.findValueByName("runName") + "]�����ܰ���VPMNҵ��"+"<br>�Ƿ񱣴������Ϣ��")==1)	
					{
						
						var path="/npage/s3600/s3603_1_printxls.jsp?phoneNo=" + document.all.phoneNo.value;
						path = path + "&returnMsg=" + "������״̬�û�[" + packet.data.findValueByName("runName") + "]�����ܰ���VPMNҵ��" ;
						path = path +  "&unitID=" + document.all.unitId.value;
	  					path = path + "&op_Code=" + document.all.opCode.value;
	  					path = path + "&orgCode=" + document.all.orgCode.value;
          					window.open(path);
          					
					}	
			
				}	
			else {
				document.frm.idNo.value=packet.data.findValueByName("idNo");
				document.frm.smCode.value=packet.data.findValueByName("smCode");
				document.frm.smName.value=packet.data.findValueByName("smName");
				document.frm.userName.value=packet.data.findValueByName("custName");
				//document.frm.userPwd.value=packet.data.findValueByName("userPwd");
				document.frm.mainRate.value=packet.data.findValueByName("mainRate");
				document.frm.mainRateName.value=packet.data.findValueByName("mainRateName");
				ChgCurrStep("chkUserPwd");
			rdShowMessageDialog("ȡ�û���Ϣ�ɹ���",2);}
			}
		}
		else
		{
			
			if (rdShowConfirmDialog(retMessage+retCode+"<br>�Ƿ񱣴������Ϣ��")==1)	
					{
						
						var path="/npage/s3600/s3603_1_printxls.jsp?phoneNo=" + document.all.phoneNo.value;
						path = path + "&returnMsg=" + retMessage+retCode;
						path = path +  "&unitID=" + document.all.unitId.value;
	  					path = path + "&op_Code=" + document.all.opCode.value;
	  					path = path + "&orgCode=" + document.all.orgCode.value;
          					window.open(path);
          					
					}
			return false;
		}
	}
}


//���ù������棬���м��ſͻ�ѡ��
function getInfo_Cust()
{
	var pageTitle = "���ſͻ�ѡ��";
	var fieldName = "֤������|���ſͻ�ID|�����û�ID|�����û�����|����ID|���Ų�Ʒ����|";
	var sqlStr = "";
	var selType = "S";    //'S'��ѡ��'M'��ѡ
	var retQuence = "5|0|1|2|3|4|";
	var retToField = "idIccid|custId|grpIdNo|grpOutNo|unitId|";
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
	
	var path = "/npage/s3600/fprivategrpusr_sel.jsp";
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
	var retToField = "idIccid|custId|grpIdNo|grpOutNo|unitId|";
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
	//wuxy add 20091211 
	document.all.grpOutNo.readOnly=true;
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
	checkPwd_Packet = null ;
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
	if (!checkElement(document.all.phoneNo))
	{
		document.frm.phoneNo.focus();
		return false;
	}
	
	if (document.frm.grpIdNo.value == "")
	{
		rdShowMessageDialog("�����û�ID����Ϊ�գ�",0);
		document.frm.idIccid.focus();
		return false;		
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
		var tmpOpCode=document.all.opCode.value;
		if (tmpOpCode=="3605")
		{
			retInfo+='<%=workname%>'+"|";
    		retInfo+='<%=new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss", Locale.getDefault()).format(new java.util.Date())%>'+"|";
    		retInfo+="���֤��:"+document.frm.idIccid.value+"|";
    		retInfo+="�û�����:"+document.frm.userName.value+"|";
    		retInfo+="�����û�����:"+document.frm.grpOutNo.value+"|";
    		retInfo+="�ֻ�����:"+document.frm.phoneNo.value+"|";
    		retInfo+="��Աԭ�趨����:"+document.frm.mainRateName.value+"|";
    		retInfo+="��Ա���趨����:"+document.frm.newRateName.value+"|";
		}else{
 			retInfo+='<%=workname%>'+"|";
    		retInfo+='<%=new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss", Locale.getDefault()).format(new java.util.Date())%>'+"|";
    		retInfo+="���֤��:"+document.frm.idIccid.value+"|";
    		retInfo+="�û�����:"+document.frm.userName.value+"|";
    		retInfo+="�����û�����:"+document.frm.grpOutNo.value+"|";
    		retInfo+="�ֻ�����:"+document.frm.phoneNo.value+"|";
    		retInfo+="��Ա�趨����:"+document.frm.mainRateName.value+"|";
    		retInfo+=""+"|";
		}
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

//��ʾ��ӡ�Ի���
function showPrtDlg(printType,DlgMessage,submitCfm)
{
	var h=180;
	var w=350;
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
	getMidPrompt("10442",codeChg(document.frm.newRate.value),"ipTd");
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
	if( document.frm.grpIdNo.value == "" )
	{
		rdShowMessageDialog("�����û�ID����Ϊ�գ�",0);
		document.frm.idIccid.select();
		return false;
	}
	if( document.frm.idNo.value == "" )
	{
		rdShowMessageDialog("�û�ID����Ϊ�գ�",0);
		document.frm.phoneNo.select();
		return false;
	}
	
	if (document.frm.opCode.value == "3605")
	{
		if (document.frm.newRate.value == document.frm.mainRate.value || document.frm.newRate.value=="") <!-- -->
		{
			rdShowMessageDialog("�·��ʲ���Ϊ�գ��¾ɷ���Ҳ������ͬ!",0);
			document.frm.newRate.focus();
			return false;
		}
	}
	getSysAccept()
}


function getBefore(){
	getBeforePrompt("<%=opCode%>");
	ChgCurrStep("custQuery");
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
 function getMidPrompt(classCode,classValue,id)
	{
		var packet = new AJAXPacket("/npage/include/getMidPrompt.jsp","���Ժ�...");
		packet.data.add("opCode" ,"<%=opCode%>");
		packet.data.add("classCode" ,classCode);
		packet.data.add("classValue" ,classValue);
		packet.data.add("id" ,id);
	  core.ajax.sendPacket(packet,doGetMidPrompt,true);//�첽
		packet =null;
	}
	
	
	function doGetMidPrompt(packet)
	{
	
    var retCode = packet.data.findValueByName("retCode"); 
    var retMsg = packet.data.findValueByName("retMsg"); 
    var id = packet.data.findValueByName("id"); 
    if(retCode=="000000"){
				document.getElementById(id).className = "promptBlue";
				$("#"+id).attr("title",retMsg);
				$("#"+id).tooltip();
		}else
			{
				document.getElementById(id).className = "";
				$("#"+id).attr("title","");
				$("#"+id).tooltip();
			}
	}	
</script>
<BODY onload="getBefore();">
	<FORM action="" method="post" name="frm" >
				<%@ include file="/npage/include/header.jsp" %>
					<div class="title">
		<div id="title_zi">BOSS��VPMN��Ա�û��������������ײͱ��</div>
	</div>
	
		<input type="hidden" name="loginAccept"  value="0"> <!-- ������ˮ�� -->
		<input type="hidden" name="loginNo"  value="<%=loginNo%>">
		<input type="hidden" name="loginPwd"  value="<%=loginPwd%>">
		<input type="hidden" name="orgCode"  value="<%=orgCode%>">
		<input type="hidden" name="ipAddress"  value="<%=ipAddress%>">
		<input type="hidden" name="regionCode"  value="<%=regionCode%>">
		
		

						<table cellspacing="0">
							<TR>
								<TD class="blue" >
									<div align="left">��������</div>
								</TD>
								<TD class="blue" width="32%" colspan="3">
									<SELECT name="opCode"  id="opCode" onChange="OpCodeChange()">
										<option value="3603" <%=flag%>>��Ա����</option>
										<option value="3604" <%=flag1%>>��Ա����</option>
										<option value="3605" <%=flag2%>>��Ա�ײͱ��</option>
									</SELECT>
									<font class="orange">*</font>
								</TD>
							</TR>
							<TR>
								<TD class="blue" >
									<div align="left">���֤���ʷѴ���</div>
								</TD>
								<TD class="blue" width="32%">
									<input name="idIccid"  id="idIccid" size="24" maxlength="18" v_type="string" v_must=1 v_name="���֤��" index="1" value="">
									<input name=custQuery type=button id="custQuery"  onMouseUp="getInfo_Cust();" onKeyUp="if(event.keyCode==13)getInfo_Cust();" style="cursorhand" value=��ѯ class="b_text">
									<font class="orange">*</font>
								</TD>
								<TD class="blue" >���ſͻ�ID</TD>
								<TD class="blue" width="32%">
									<input  type="text" name="custId" size="20" maxlength="18" v_type="0_9" v_must=1 v_name="�ͻ�ID" index="2" value="">
									<font class="orange">*</font>
								</TD>
							</TR>
							<TR>
								<TD class="blue">
									<div align="left">����ID</div>
								</TD>
								<TD class="blue">
									<input name=unitId  id="unitId" size="24" maxlength="10" v_type="0_9" v_must=1 v_name="����ID" index="3" value="">
									<font class="orange">*</font>
								</TD>
								<TD class="blue">�����û����</TD>
								<TD class="blue">
									<input  name="grpOutNo" size="20" v_must=1 v_type=string v_name="�����û����" index="4" value="">
									<font class="orange">*</font>
								</TD>
							</TR>
							<TR>
								<TD class="blue">�����û�ID</TD>
								<TD class="blue" COLSPAN="1">
									<input  name="grpIdNo" size="20" readonly Class="InputGrey" v_must=1 v_type=string v_name="�����û�ID" index="4" value="">
									<font class="orange">*</font>
								</TD><TD class="blue">&nbsp;</TD>
									<TD class="blue">&nbsp;</TD>
								<input name=chkGrpPwd type="hidden" onClick="check_HidPwd();"  style="cursorhand" id="chkGrpPwd" value=У��>
							</TR>
							<TR>
								<TD class="blue">�ֻ�����</TD>
								<TD class="blue" colspan="1"><input name="phoneNo"  type="text" v_must=1 v_minlength="11" v_maxlength="11" v_type="string" v_name="�ֻ�����" index="8" value="" maxlength="11">
									<input  name=qryPhone onkeyup="if(event.keyCode==13){QryPhoneInfo()}" onmouseup="QryPhoneInfo()"  style="cursor:hand" type=button value="��ѯ" index="19" class="b_text">
									<font class="orange">*</font>
								</TD>
								<TD class="blue">&nbsp;</TD>
								<TD class="blue">&nbsp;</TD>
							</TR>
							<TR>
								<TD class="blue">�û�ID</TD>
								<TD class="blue" colspan="1">
									<input name="idNo"  type="text" v_must=1 v_type="string" v_name="�û�ID" index="8" value="" readonly Class="InputGrey" >
									<font class="orange">*</font>
								</TD>
								<TD class="blue" >�û�����</TD>
								<TD class="blue" colspan="1">
									<input name="userName"  type="text" v_must=1 v_type="string" v_name="�û�����" index="8" value="" readonly Class="InputGrey">
									<font class="orange">*</font>
								</TD>
							</TR>
							<TR>
								<TD class="blue" >�û�Ʒ�ƴ���</TD>
								<TD class="blue" colspan="1">
									<input name="smCode"  type="text" v_must=1  v_type="string" v_name="�û�Ʒ��" index="8" value="" readonly Class="InputGrey">
									<font class="orange">*</font>
								</TD>
								<TD class="blue">�û�Ʒ������</TD>
								<TD class="blue" colspan="1">
									<input name="smName"  type="text" v_must=1  v_type="string" v_name="�û�Ʒ������" index="8" value="" readonly Class="InputGrey">
									<font class="orange">*</font>
								</TD>
							</TR>
							<TR>
								<TD class="blue" >��Ա�趨����</TD>
								<TD class="blue" colspan="1">
									<input name="mainRate"  type="text" v_must=1 v_maxlength=8 v_type="string" v_name="��Ա�趨����" index="8" value="" readonly Class="InputGrey">
									<font class="orange">*</font>
								</TD>
								<TD class="blue" >��Ա�趨��������</TD>
								<TD class="blue" colspan="1">
									<input name="mainRateName"  type="text" v_must=1 v_maxlength=8 v_type="string" v_name="��Ա�趨��������" index="8" value="" readonly Class="InputGrey">
									<font class="orange">*</font>
								</TD>
							</TR>
							<TR id=trNewRate>
								<TD class="blue" >��Ա�·��ʴ���</TD>
								<TD class="blue" colspan="1" id="ipTd">
									<input name="newRate"  type="text" v_must=1 v_maxlength=8 v_type="string" v_name="��Ա�·��ʴ���" index="8" value="" readonly Class="InputGrey">
									<input  name=BNewRate onmouseup="QryNewRate()"  style="cursor:hand" type=button value="��ѯ" index="19" class="b_text">
									<font class="orange">*</font>
								</TD>
								<TD class="blue" >��Ա�·�������</TD>
								<TD class="blue" colspan="1">
									<input name="newRateName"  type="text" v_must=1 v_maxlength=8 v_type="string" v_name="��Ա�·�������" index="8" value="" readonly Class="InputGrey">
									<font class="orange">*</font>
								</TD>
							</TR>
							<TR>
								<TD class="blue" >ϵͳ��ע</TD>
								<TD class="blue" colspan="3">
									<input  name="sysNote" size="60" value="BOSS��VPMN��Ա�û�����" readonly Class="InputGrey">
									<input  name="opNote" size="60" value="BOSS��VPMN��Ա�û�����" type="hidden">
								</TD>
							</TR>

									

						</TABLE>
						<TABLE cellSpacing="0">
							<TR>
								<TD id="footer" align=center bgcolor="#EEEEEE">
									<input  name="doSubmit"  type=button value="ȷ��" onclick="refMain()" class="b_foot">
									<input  name="reset1"  onClick="location.reload()" type=button value="���" class="b_foot">
									<input  name="kkkk"  onClick="removeCurrentTab()" type=button value="�ر�" class="b_foot">
									<input type="button" name="Button" value="���汾ҳ"  onClick="document.all.button.ExecWB(4,1)" class="b_foot_long">  
<object id="button"  width=0  height=0  classid="CLSID:8856F961-340A-11D0-A96B-00C04FD705A2">  
<embed width="0" height="0"></embed>  
</object>  
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

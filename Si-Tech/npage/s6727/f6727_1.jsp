<%
/********************
 version v2.0
 ������: si-tech
 update hejw@2009-1-14
********************/
%>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http//www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http//www.w3.org/1999/xhtml">
<%@ include file="../../include/remark1.htm" %>
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%
  String opCode = "6727";
  String opName = "���Ų���ɾ����Ա";
%>

<%
Logger logger = Logger.getLogger("s6727.jsp");

	String ipAddress = (String)session.getAttribute("ipAddr");
	String loginNo = (String)session.getAttribute("workNo");
	String workname = (String)session.getAttribute("workName");
	String orgCode = (String)session.getAttribute("orgCode");
	String loginPwd  = (String)session.getAttribute("password");
	String regionCode = (String)session.getAttribute("regCode");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<HEAD>
	<TITLE>���Ų����Աɾ��</TITLE>
<META content="text/html; charset=GBK" http-equiv=Content-Type>
<meta http-equiv="Expires" content="0">
</HEAD>
<SCRIPT type=text/javascript>

//����
function ajaxSubmit(){
	$.ajax({
		type: "POST",
		url: "f6727_2.jsp",
		beforeSend:function(XMLHttpRequest){
				loading();
			},
    data:"loginAccept="+document.frm.loginAccept.value+"&"+       
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
         "grpName="+document.frm.grpName.value,//+"&"+     	        
//         "payType="+document.frm.payType.value,+"&"+               
//         "mebProdCode="+document.frm.mebProdCode.value+"&"+       
//         "mebMonthFlag="+document.frm.mebMonthFlag.value+"&"+     
//         "matureFlag="+document.frm.matureFlag.value+"&"+         
//         "matureProdCode="+document.frm.matureProdCode.value,     
         
		success: function(data, textStatus){
			$("body").html(data);
			$("body").html();
	  	}
	});
}

function OpCodeChange()
{

  if (document.frm.opCode.value == "3605")
	{
		document.frm.sysNote.value="BOSS��VPMN��Ա�û��ײͱ��";
		document.frm.opNote.value="BOSS��VPMN��Ա�û��ײͱ��";
	}
	if(document.all.smCode.value=="j1")
	{
		if(document.all.opCode.value=="3709")
		{
			tbs1.style.display="";
		}
		else
		{
			tbs1.style.display="none";
		}	
	}
	else
	{
		tbs1.style.display="none";
	}
	ChgCurrStep("custQuery");
}

function ChgCurrStep(currStep)
{ 
	if (currStep == "custQuery")
	{
		document.frm.custQuery.disabled = false;

	}
	else if (currStep == "chkGrpPwd")
	{
		document.frm.custQuery.disabled = false;
	}
	else if (currStep == "qryPhone")
	{
		document.frm.custQuery.disabled = false;

	}
	else if (currStep == "chkUserPwd")
	{
		document.frm.custQuery.disabled = false;

	}
	else if (currStep == "doSubmit")
	{
		document.frm.custQuery.disabled = false;
	}
}

function doProcess(packet)
{
	//alert(1);
	var retType = packet.data.findValueByName("retType");
	var retCode = packet.data.findValueByName("retCode");
	var retMessage = packet.data.findValueByName("retMessage");
	self.status="";
	 //���ſͻ�����У��
	     if(retType == "checkPwd") 
     {
        if(retCode == "000000")
        {
            var retResult = packet.data.findValueByName("retResult");
            if (retResult == "false") {
    	    	rdShowMessageDialog("�ͻ�����У��ʧ�ܣ����������룡",0);
	        	frm.doSubmit.disabled = true;
	        	//frm.custPwd.value = "";
	        	//frm.custPwd.focus();

    	    	return false;	        	
            } else {
                rdShowMessageDialog("�ͻ�����У��ɹ���",2);
               document.frm.doSubmit.disabled=false;
            }
         }
        else
        {
            rdShowMessageDialog("�ͻ�����У�����������У�飡",0);
            document.frm.doSubmit.disabled = true;
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
//				page = "f6727_2.jsp";
//				frm.action=page;
//				frm.method="post";
//				frm.submit();
					//return true;
					ajaxSubmit()
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
//		alert(a);
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
				rdShowMessageDialog("ȡ�û���Ϣ�ɹ���",2);
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
	var fieldName = "֤������|���ſͻ�ID|�����û�ID|�����û�����|����ID|���Ų�Ʒ����|��������|��Ʒ����|";
	var sqlStr = "";
	var selType = "S";    //'S'��ѡ��'M'��ѡ
	var retQuence = "8|0|1|2|3|4|5|6|7|";
	var retToField = "idIccid|custId|grpIdNo|grpOutNo|unitId|smName|grpName|smCode|";
	var custId = document.frm.custId.value;

	if(document.frm.idIccid.value == "" &&
	document.frm.custId.value == "" &&
	document.frm.unitId.value == "" &&
	document.frm.grpOutNo.value == "")
	{
		rdShowMessageDialog("���������֤�š��ͻ�ID������ID���Ų�Ʒ��Ž��в�ѯ��",0);
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
		rdShowMessageDialog("���Ų�Ʒ��Ų���Ϊ0��",0);
		return false;
	}

	PubSimpSelCust(pageTitle,fieldName,sqlStr,selType,retQuence,retToField);
}

function PubSimpSelCust(pageTitle,fieldName,sqlStr,selType,retQuence,retToField)
{
	var path = "/npage/s6727/fpubgrpusr_sel.jsp";
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
	var retToField = "idIccid|custId|grpIdNo|grpOutNo|unitId|smName|grpName|smCode|";
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
		document.all(obj).readOnly=true;
		retToField = retToField.substring(chPos_field + 1);
		retInfo = retInfo.substring(chPos_retInfo + 1);
		chPos_field = retToField.indexOf("|");
	}
}

function check_HidPwd()
{
	var custId = document.frm.custId.value;
	var inPwd = document.frm.grpPwd.value;
	var checkPwd_Packet = new AJAXPacket("/npage/s6727/pubCheckPwd.jsp","���ڽ�������У�飬���Ժ�......");
	checkPwd_Packet.data.add("retType","checkPwd");
	checkPwd_Packet.data.add("cust_id",custId);
	checkPwd_Packet.data.add("Pwd1",inPwd);
	core.ajax.sendPacket(checkPwd_Packet);
	checkPwd_Packet = null;
}

function ChkUserPwd()
{
	var checkPwd_Packet = new AJAXPacket("/npage/s6727/pubCheckPwd.jsp","���ڽ�������У�飬���Ժ�......");
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
	var checkPwd_Packet = new AJAXPacket("/npage/s6727/getPhoneInfo.jsp","���ڽ�������У�飬���Ժ�......");
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
		if (tmpOpCode=="6726" || tmpOpCode=="6727")
		{
			retInfo+='<%=workname%>'+"|";
    		retInfo+='<%=new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss", Locale.getDefault()).format(new java.util.Date())%>'+"|";
    		retInfo+="���֤��:"+document.frm.idIccid.value+"|";
    		retInfo+="���ſͻ�ID:"+document.frm.custId.value+"|";
    		retInfo+="���ű��:"+document.frm.unitId.value+"|";
    		retInfo+="���Ų�Ʒ���:"+document.frm.grpOutNo.value+"|";
  	    retInfo+="�ֻ�����"+document.frm.phoneNo.value+"|";
  	    retInfo+=""+"|";
  	    retInfo+=""+"|";
  	    retInfo+="ϵͳ��ע"+document.frm.sysNote.value+"|";
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
	var h=150;
	var w=350;
	var t=screen.availHeight/2-h/2;
	var l=screen.availWidth/2-w/2;
	var printStr = printInfo(printType);
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
	getSysAccept_Packet = null;
}

function refMain()
{
	if(  document.frm.phoneNo.value == "" )
	{
		rdShowMessageDialog("���ų�Ա���벻��Ϊ��!!",0);
		document.frm.phoneNo.focus();
		return false;
	}else
		{
		  var phoneNo=document.frm.phoneNo.value;
			var chPos_field ;
			var MobPhone;	
			var count=0;		
			while(phoneNo!=""){
			    chPos_field = phoneNo.indexOf("|");
			    MobPhone   =phoneNo.substring(0,chPos_field);
			    phoneNo = phoneNo.substring(chPos_field + 1);
				  //phoneNo=phoneNo.replace("\r\n","");
			    MobPhone = MobPhone.replace("\r\n","");
			    MobPhone=trimAll(MobPhone);			    
			    //alert("MobPhone="+MobPhone);
				  if(MobPhone!=""){
					    if((MobPhone.substring(0,1) !=1) || (MobPhone.substring(1,2) !=3 && MobPhone.substring(1,2) !=5&& MobPhone.substring(1,2) !=4&& MobPhone.substring(1,2) !=8))
				        {
				        rdShowMessageDialog("�ֻ�����ֻ����13��15��14��18��ͷ�������������ֻ����룡" ,2);
					      document.frm.phoneNo.focus();
						    return false;
				        }
		            if((myParseInt(MobPhone.substring(0,3),10)<134) || (myParseInt(MobPhone.substring(0,3),10)>139 && myParseInt(MobPhone.substring(0,2),10) !=15&& myParseInt(MobPhone.substring(0,2),10) !=14&& myParseInt(MobPhone.substring(0,2),10) !=18))
			          { 
			          rdShowMessageDialog("�ֻ����뷶ΧӦ����134~139֮�������15X�Ŷλ�����14X�Ŷλ�����18X�Ŷ�");
			          document.frm.phoneNo.focus();
				        return false;	
			          }	
	         }		    
			    count ++;
					if(count>30){
			      rdShowMessageDialog("ɾ���ĳ�Ա������Ϣ��ʽ������Ա��������30����");
		        document.frm.phoneNo.focus();
		        return false;
					 }
			 }
		} 
	if(  document.frm.grpIdNo.value == "" )
	{
		rdShowMessageDialog("�����û�ID����Ϊ��!!");
		document.frm.idIccid.select();
		return false;
	}
	
	if (document.frm.opCode.value == "6726")
	{
		if (document.frm.newRate.value == document.frm.mainRate.value ||document.frm.newRate.value=="")
		{
			rdShowMessageDialog("�·��ʲ���Ϊ�գ��¾ɷ���Ҳ������ͬ!");
			document.frm.newRate.focus();
			return false;
		}
	}
	 document.frm.sysNote.value = "����[<%=loginNo%>]Ϊ����["+document.all.custId.value+"]����ɾ�����Ų����Ա";
	 if((document.all.opNote.value).trim().length==0)
	 {
	 document.all.opNote.value= "����[<%=loginNo%>]Ϊ����["+document.all.custId.value+"]����ɾ�����Ų����Ա";
	 }
	getSysAccept();
	//wuxy alter 20090826 Ϊ������ȷ����ȡ�����ύ����
	//ajaxSubmit();
}

function choiceFilePut()
{
	if(document.all.byFile.checked){
		document.all.phoneNo.readOnly=true;
		document.all.addFile.readOnly=false;
	  document.all.setBBChbByFile.disabled = false;
	}else{
	  document.all.addFile.readOnly=true;
		document.all.phoneNo.readOnly=false;
		document.all.setBBChbByFile.disabled = true;
	}
}

// ����:ȫ��ȡ����
// ����:��ָ�����ı�����ߺ��ұߵĿո�ȫ����ȡ
// ����:�Ѿ���ȡ���ı�
// ����:text ָ�����ı�
function trimAll(text)
{
        return leftTrim(rightTrim(text));//���ҽ�ȡ,�����ȡ,����
}


// ����:���ȡ����
// ����:��ָ�����ı�����ߵĿո�ȫ����ȡ
// ����:�Ѿ���ȡ���ı�
// ����:text ָ�����ı�
function leftTrim(text)
{
        if(text==null || text=="") return text;//���text������,����text
        var leftIndex=0;//��������ǿո��ַ��������±�(�ո��ַ���)
        while(text.substring(leftIndex,leftIndex+1)==" ")//ֱ���ҵ�����ķǿո���ַ�,Ҫô����
                leftIndex++;//���ҷǿո��ַ��������±����
        return text.substring(leftIndex,text.length);//����
}

// ����:�ҽ�ȡ����
// ����:��ָ�����ı����ұߵĿո�ȫ����ȡ
// ����:�Ѿ���ȡ���ı�
// ����:text ָ�����ı�
function rightTrim(text)
{
        if(text==null || text=="") return text;//���text������,����text
        var rightIndex=text.length;//�������ҷǿո��ַ��������±�
        while(text.substring(rightIndex-1,rightIndex)==" ")//ֱ���ҵ����ҵķǿո���ַ�,Ҫô����
                rightIndex--;//���ҷǿո��ַ��������±�ǰ��
        return text.substring(0,rightIndex);//����
} 

function setBBChgByFile()
{

	if(document.all.addFile.value== ""){
		rdShowMessageDialog("���������...����ťѡ���ļ���");
		document.all.addFile.focus();
 		return;
	}

	var region_code = frm.region_code.value;
	document.frm.action="f5246_setBBChgByFile.jsp?region_code=" + region_code;
  document.frm.submit();
}
</script>
<BODY>
	<FORM action="" method="post" name="frm" >
		<%@ include file="/npage/include/header.jsp" %>
		<input type="hidden" name="loginAccept"  value="0"> <!-- ������ˮ�� -->
		<input type="hidden" name="loginNo"  value="<%=loginNo%>">
		<input type="hidden" name="loginPwd"  value="<%=loginPwd%>">
		<input type="hidden" name="smCode"  value="">
		<input type="hidden" name="smName"  value="">
		<input type="hidden" name="grpName"  value="">
		<input type="hidden" name="orgCode"  value="<%=orgCode%>">
		<input type="hidden" name="ipAddress"  value="<%=ipAddress%>">
		
	<div class="title">
		<div id="title_zi">���Ų���ɾ����Ա</div>
	</div>
						<TABLE cellSpacing="0">
							<TR>
								<td class="blue">
									<div align="left">��������</div>
								</TD>
							
								<TD>
									<SELECT name="opCode"  id="opCode" onChange="OpCodeChange()"  disabled>
										<option value="6726" >�������ų�Ա����</option>
										<option value="6727" selected>�������ų�Աɾ��</option>
									</SELECT>
									<font class="orange">*</font>
								</TD>
								
								<td>&nbsp;</td><td>&nbsp;</td>
							</TR>
							<TR>
								<td class="blue">
									<div align="left">֤������</div>
								</TD>
								<TD>
									<input name="idIccid"  id="idIccid" size="24" maxlength="18" v_type="string" v_must=1 v_name="���֤��" index="1" value="">
									<input name=custQuery type=button id="custQuery"  onMouseUp="getInfo_Cust();" onKeyUp="if(event.keyCode==13)getInfo_Cust();" style="cursorhand" value=��ѯ class="b_text">
									<font class="orange">*</font>
								</TD>
								<td class="blue">���ſͻ�ID</TD>
								<TD>
									<input  type="text" name="custId" size="20" maxlength="18" v_type="0_9" v_must=1 v_name="�ͻ�ID" index="2" value="">
									<font class="orange">*</font>
								</TD>
							</TR>
							<TR>
								<td class="blue">
									<div align="left">���ű��</div>
								</TD>
								<TD>
									<input name=unitId  id="unitId" size="24" maxlength="10" v_type="0_9" v_must=1 v_name="����ID" index="3" value="">
									<font class="orange">*</font>
								</TD>
								<td class="blue">���Ų�Ʒ���</TD>
								<TD>
									<input  name="grpOutNo" size="20" v_must=1 v_type=string v_name="���Ų�Ʒ���" index="4" value="">
									<font class="orange">*</font>
								</TD>
							</TR>
							<TR>
								<td class="blue">���Ų�ƷID</TD>
								<TD>
									<input  name="grpIdNo" size="20" readonly v_must=1 v_type=string v_name="�����û�ID" index="4" value="" class="InputGrey">
									<font class="orange">*</font>
								</TD>
								<td class="blue">���ſͻ�����</TD>
								<TD>
									<jsp:include page="/npage/common/pwd_1.jsp">
									<jsp:param name="width1" value="16%"  />
									<jsp:param name="width2" value="34%"  />
									<jsp:param name="pname" value="grpPwd"  />
									<jsp:param name="pwd" value=""  />
									</jsp:include>
									<!--
									<input name="grpPwd"  type="password" id="grpPwd" size="8" maxlength="8" v_must=1 v_maxlength=8 v_type="string" v_name="���ſͻ�����" index="8" onKeyUp="if(event.keyCode==13)check_HidPwd();" value="">
									-->
									<input name=chkGrpPwd type=button onClick="check_HidPwd();"  style="cursorhand" id="chkGrpPwd" value=У�� class="b_text">
									<font class="orange">*</font>               
								</TD>                                                                    
							</TR> 
							<TR>
								<td class="blue">�ֻ�����</TD>
								<TD>
								<textarea cols=30 rows=8 name="phoneNo" style="overflow:auto" v_must=1 v_minlength="11" v_maxlength="15" v_type="string" onpropertychange="if(this.value.length>600){this.value=this.value.substr(0,600);}" v_name="�ֻ�����" index="8"></textarea>
								<br>ע������ɾ���ֻ�����ʱ,����"|"��Ϊ�ָ�<br>
								��,�������һ������Ҳ����"|"��Ϊ����,����������󲻳���30����<br>
								����&nbsp;&nbsp;13900000000|<br>
								&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;13900000001|<br>
								</TD>
								<TD>&nbsp;
							</TD>					<TD>&nbsp;
							</TD>
								<div id="tbs1" style="display:none">
									<font color="red">��Ա���ʷѱ���Ϊ000030AA <br>
								  (0���⣬����ͨ�ŷ�0.40Ԫ/����)<br> 
								  ���ܼ��뱾����<br></font>
								</div>
								</TD>
							  </tr>		
							<TR>
								<td class="blue">��ע��Ϣ</TD>
								<TD colspan="3">
									<input  name="opNote" size="60" value="" class="InputGrey" readOnly >
									<input  name="sysNote" size="60" value="" readonly type="hidden">
								</TD>
							</TR>
						</TABLE>
						<TABLE cellSpacing="0">
							<TR>
								<TD align=center >
									<input class="b_foot" name="doSubmit"  type="button" value="ȷ��" onclick="refMain()">
									<input class="b_foot" name="reset1"  onClick="" type="reset" value="���">
									<input class="b_foot" name="kkkk"   onClick="removeCurrentTab()" type=button value="�ر�">
								</TD>
							</TR>
						</TABLE>
			<%@ include file="/npage/include/footer.jsp" %>
		<jsp:include page="/npage/common/pwd_comm.jsp"/>
	</FORM>
<script language="JavaScript">

	document.frm.idIccid.focus();

	ChgCurrStep("custQuery");

	OpCodeChange();

</script>
</BODY>
</HTML>

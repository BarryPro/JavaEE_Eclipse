<!DOCTYPE html PUBLIC "-//W3C//Dtd Xhtml 1.0 transitional//EN" "http://www.w3.org/tr/xhtml1/Dtd/xhtml1-transitional.dtd">
<%
  /*
   * ����:IPT��Ա���� 2903 /IPT��Ա�޸� 2907
   * �汾: 1.0
   * ����: 2009/2/3
   * ����: leimd
   * ��Ȩ: si-tech
   * update:
  */
%>
<%@	page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="com.sitech.boss.pub.*" %>
<%@ include file="../../include/remark.htm" %>

<%
	String opCode=(String)request.getParameter("opCode");
	String opName=(String)request.getParameter("opName");
	String flag1="";
	String flag2="";
	String flag3="";
	if(opCode.equals("2905")){
		flag1="selected";
	}else if(opCode.equals("2907")){
		flag2="selected";
	}else if(opCode.equals("2909")){
		flag3="selected";
	} 
	String ipAddress = (String)session.getAttribute("ipAddr");					//��½Ip
	String loginNo = (String)session.getAttribute("workNo");					//��������
	String workname = (String)session.getAttribute("workName");					//����
	String orgCode = (String)session.getAttribute("orgCode");					//��������
	String loginPwd  = (String)session.getAttribute("password");				//��������
	String regionCode = (String)session.getAttribute("regCode");				//����
%>

<html xmlns="http://www.w3.org/1999/xhtml">
<HEAD>
	<TITLE>IPT��Ա��ӡ�ɾ�����ʷѱ�� </TITLE>
</HEAD>
<SCRIPT type=text/javascript>



function OpCodeChange()
{
	if (document.frm.opCode.value == "2905")
	{
		document.frm.sysNote.value="IPT��Ա�û����";
		document.frm.opNote.value="IPT��Ա�û����";
		document.all.trNewRate.style.display="";
		document.all.trRate.style.display="none";
		document.all.tr_pay_flag.style.display="";

	}
	else if (document.frm.opCode.value == "2907")
	{
		document.frm.sysNote.value="IPT��Ա�û�ɾ��";
		document.frm.opNote.value="IPT��Ա�û�ɾ��";
		document.all.trNewRate.style.display="none";
		document.all.trRate.style.display="";
		document.all.tr_pay_flag.style.display="none";
	}
	else if (document.frm.opCode.value == "2909")
	{
		document.frm.sysNote.value="IPT��Ա�û��ײͱ��";
		document.frm.opNote.value="IPT��Ա�û��ײͱ��";
		document.all.trNewRate.style.display="";
		document.all.trRate.style.display="";
		document.all.tr_pay_flag.style.display="none";
	}
	ChgCurrStep("custQuery");
	document.all.idNo.value="";
	document.all.userName .value=""; 
	document.all.smCode.value=""; 
	document.all.smName.value="";
	document.all.mainRate.value="";
	document.all.mainRateName.value="";
	document.all.newRate.value="";
	document.all.newRateName.value="";
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
					var path="<%=request.getContextPath()%>/npage/s3600/s3603_1_printxls.jsp?phoneNo=" + document.all.phoneNo.value;
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
				var path="<%=request.getContextPath()%>/npage/s3600/s3603_1_printxls.jsp?phoneNo=" + document.all.phoneNo.value;
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
					
					var path="<%=request.getContextPath()%>/npage/s3600/s3603_1_printxls.jsp?phoneNo=" + document.all.phoneNo.value;
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
				page = "f2903_2.jsp";
				frm.action=page;
				frm.method="post";
				frm.submit();
			}
			else 
				return false;
		}
		else
		{
			rdShowMessageDialog("��ѯ��ˮ����,�����»�ȡ��",0);
			return false;
		}
	}
	if(retType == "QryPhoneInfo") 
	{
		if(retCode == "000000")
		{
			var retResult = packet.data.findValueByName("retResult");
			var retMessage = packet.data.findValueByName("retMessage");
			if (retResult == "false")
			{
				if (rdShowConfirmDialog(retMessage+"<br>�Ƿ񱣴������Ϣ��")==1)	
				{
					var path="<%=request.getContextPath()%>/npage/s2903/f2903_1_printxls.jsp?phoneNo=" + document.all.phoneNo.value;
					path = path + "&returnMsg=" + retMessage;
					path = path +  "&unitID=" + document.all.unitId.value;
	  				path = path + "&op_Code=" + document.all.opCode.value;
	  				path = path + "&orgCode=" + document.all.orgCode.value;
          			window.open(path);
				}
				frm.grpPwd.value = "";
				frm.grpPwd.focus();
				ChgCurrStep("qryPhone");
				return false;
			}
			else
			{
				if(packet.data.findValueByName("runCode")!='A')
				{
					document.frm.idNo.value="";
					document.frm.smCode.value="";
					document.frm.smName.value="";
					document.frm.userName.value="";
					document.frm.mainRate.value="";
					document.frm.mainRateName.value="";
					document.frm.id_iccid.value="";
					document.frm.cust_address.value="";
					if (rdShowConfirmDialog("������״̬�û�[" + packet.data.findValueByName("runName") + "]�����ܰ����ҵ��"+"<br>�Ƿ񱣴������Ϣ��")==1)	
					{
						var path="<%=request.getContextPath()%>/npage/s2903/f2903_1_printxls.jsp?phoneNo=" + document.all.phoneNo.value;
						path = path + "&returnMsg=" + "������״̬�û�[" + packet.data.findValueByName("runName") + "]�����ܰ����ҵ��" ;
						path = path +  "&unitID=" + document.all.unitId.value;
	  					path = path + "&op_Code=" + document.all.opCode.value;
	  					path = path + "&orgCode=" + document.all.orgCode.value;
          				window.open(path);
					}	
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
					document.frm.id_iccid.value=packet.data.findValueByName("id_iccid");
					document.frm.cust_address.value=packet.data.findValueByName("cust_address");
					//alert("aaaa"+document.frm.cust_address.value);
					
					
					ChgCurrStep("chkUserPwd");
					rdShowMessageDialog("ȡ�û���Ϣ�ɹ���",2);
				}
			}
		}
		else
		{
		
			if (rdShowConfirmDialog(retMessage+retCode+"<br>�Ƿ񱣴������Ϣ��")==1)	
			{
				var path="<%=request.getContextPath()%>/npage/s2903/f2903_1_printxls.jsp?phoneNo=" + document.all.phoneNo.value;
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
	var fieldName = "֤������|���ſͻ�ID|�����û�ID|�����ⲿ����|����ID|���Ų�Ʒ����|���Ų�Ʒ�ʺ�|���ſͻ�����|���Ų�Ʒ����|";
	//����ֻ��ռλ����,�ڶ�ҳ��д����!
	var sqlStr = "";
	var selType = "S";    //'S'��ѡ��'M'��ѡ
	var retQuence = "7|0|1|2|3|4|7|8|";
	var retToField = "idIccid|custId|grpIdNo|grpOutNo|unitId|unit_name|user_no|";
	var custId = document.frm.custId.value;

	if(document.frm.idIccid.value == "" &&
	document.frm.custId.value == "" &&
	document.frm.unitId.value == "" &&
	document.frm.grpOutNo.value == "")
	{
		rdShowMessageDialog("���������֤�š��ͻ�ID������ID�����û���Ž��в�ѯ��",1);
		document.frm.idIccid.focus();
		return false;
	}

	if(document.frm.custId.value != "" && for0_9(frm.custId) == false)
	{
		frm.custId.value = "";
		rdShowMessageDialog("���������֣�",0);
		return false;
	}

	if(document.frm.unitId.value != "" && for0_9(frm.unitId) == false)
	{
		frm.unitId.value = "";
		rdShowMessageDialog("���������֣�",0);
		return false;
	}

	if(document.frm.grpOutNo.value == "0")
	{
		frm.grpOutNo.value = "";
		rdShowMessageDialog("�����ⲿ��Ų���Ϊ0��",0);
		return false;
	}

	PubSimpSelCust(pageTitle,fieldName,sqlStr,selType,retQuence,retToField);
}

function PubSimpSelCust(pageTitle,fieldName,sqlStr,selType,retQuence,retToField)
{
	var path = "<%=request.getContextPath()%>/npage/s2903/fprivategrpusr_sel.jsp";
	path = path + "?sqlStr=" + sqlStr + "&retQuence=" + retQuence;
	path = path + "&fieldName=" + fieldName + "&pageTitle=" + pageTitle;
	path = path + "&selType=" + selType+"&idIccid=" + document.all.idIccid.value;
	path = path + "&custId=" + document.all.custId.value;
	path = path + "&unitId=" + document.all.unitId.value;
	path = path + "&grpOutNo=" + document.all.grpOutNo.value;
	path = path + "&regionCode=" + document.all.regionCode.value;

	retInfo = window.open(path,"newwindow","height=450,width=830,top=50,left=100,scrollbars=yes,resizable=no,location=no, status=yes");

	return true;
}

function getvaluecust(retInfo)
{
	var retToField = "idIccid|custId|grpIdNo|grpOutNo|unitId|unit_name|user_no|";
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
	var checkPwd_Packet = new AJAXPacket("../s3600/pubCheckPwd.jsp","���ڽ�������У�飬���Ժ�......");
	checkPwd_Packet.data.add("retType","checkPwd");
	checkPwd_Packet.data.add("GRP_ID",grpIdNo);
	checkPwd_Packet.data.add("inPwd",inPwd);
	core.ajax.sendPacket(checkPwd_Packet);
	checkPwd_Packet=null;
}

function ChkUserPwd()
{
	var checkPwd_Packet = new AJAXPacket("../s3600/pubCheckPwd.jsp","���ڽ�������У�飬���Ժ�......");
	checkPwd_Packet.data.add("retType","chkUserPwd");
	checkPwd_Packet.data.add("ID_NO",document.frm.idNo.value);
	checkPwd_Packet.data.add("inPwd",document.frm.userPwd.value);
	core.ajax.sendPacket(checkPwd_Packet);
	checkPwd_Packet=null;
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
		rdShowMessageDialog("�����û�ID����Ϊ�գ�");
		document.frm.idIccid.focus();
		return false;		
	}
	var checkPwd_Packet = new AJAXPacket("../s2903/getPhoneInfo.jsp","���ڲ�ѯ�û���Ϣ�����Ժ�......");
	checkPwd_Packet.data.add("retType","QryPhoneInfo");
	checkPwd_Packet.data.add("loginNo","<%=loginNo%>");
	checkPwd_Packet.data.add("phoneNo",document.frm.phoneNo.value);
	checkPwd_Packet.data.add("opCode",document.frm.opCode.value);
	checkPwd_Packet.data.add("grpIdNo",document.frm.grpIdNo.value);
	core.ajax.sendPacket(checkPwd_Packet);
	checkPwd_Packet=null;
}



//��ӡ��Ϣ
function printInfo(printType)
{ 
	var tmpOpCode=document.all.opCode.value;

	var cust_info="";  				//�ͻ���Ϣ
	var opr_info="";   				//������Ϣ
	var note_info1=""; 				//��ע1
	var note_info2=""; 				//��ע2
	var note_info3=""; 				//��ע3
	var note_info4=""; 				//��ע4
	var retInfo = "";  				//��ӡ����

  /*  cust_info+="�ͻ�����:    "+document.frm.userName.value+"|";
    cust_info+="�ֻ�����:    "+document.frm.phoneNo.value+"|";
    cust_info+="֤������:    "+document.frm.id_iccid.value+"|";
    cust_info+="�ͻ���ַ:    "+document.frm.cust_address.value+"|";*/
    
	cust_info+="�ͻ�������   " +document.frm.userName.value+"|";
	cust_info+="�ֻ����룺   "+document.frm.phoneNo.value+"|";
	cust_info+="�ͻ���ַ��   "+document.frm.cust_address.value+"|";
	cust_info+="֤�����룺   "+document.frm.id_iccid.value+"|";
 
	if (tmpOpCode=="2909")//������޸��ʷ�
	{
		opr_info+="����ҵ��:"+"IPT������Ⱥ����ʱͨ�����"+"|";
		opr_info+="��������:"+document.frm.unit_name.value+"|";
		opr_info+="�������:"+"ҵ���ײ�"+"|";
		opr_info+="ҵ���ײ�(ԭ):"+document.frm.mainRate.value+"|";
		opr_info+="ҵ���ײ�(��):"+document.frm.newRate.value+"|";
		opr_info+="������ˮ:"+document.frm.loginAccept.value+"|";
		opr_info+="�����Чʱ��:"+"ԤԼ��Ч(����1����Ч)"+"|";
		
		
	}
	else if(tmpOpCode=="2905")//�������ӳ�Ա
	{
 		opr_info+="����ҵ��:"+"IPT������Ⱥ����ʱͨ������"+"|";
 		opr_info+="��������:"+document.frm.unit_name.value+"|";
		opr_info+="���ѷ�ʽ:"+document.frm.pay_flag.options[document.frm.pay_flag.selectedIndex].text+"|";
		opr_info+="ҵ���ײ�:"+document.frm.newRate.value+"|";
		opr_info+="������ˮ:"+document.frm.loginAccept.value+"|";
		opr_info+="ҵ����Чʱ��:"+"������Ч"+"|";
		
	}
	else//�����ɾ����Ա
	{
		opr_info+="����ҵ��:"+"IPT������Ⱥ����ʱͨ������"+"|";
		opr_info+="��������:"+document.frm.unit_name.value+"|";
		retInfo+=""+"|";
		opr_info+="ҵ���ײ�"+document.frm.mainRate.value+"|";
		opr_info+="������ˮ:"+document.frm.loginAccept.value+"|";
		opr_info+="�����Чʱ��:"+"������Ч"+"|";
		
	}
    
    note_info1+=document.frm.sysNote.value+"|";  
    note_info2+=document.all.simBell.value+"|";
    
	retInfo= strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
  	retInfo=retInfo.replace(new RegExp("#","gm"),"%23"); //�ѡ�#"�滻Ϊurl��ʽ
    	return retInfo;	
}

//��ʾ��ӡ�Ի���
function showPrtDlg(printType,DlgMessage,submitCfm)
{
	var h=180;
	var w=350;
	var t=screen.availHeight/2-h/2;
	var l=screen.availWidth/2-w/2;
	
	var pType="print";             				 		//��ӡ���ͣ�print ��ӡ subprint �ϲ���ӡ
	var billType="1";              				 			//Ʊ�����ͣ�1���������2��Ʊ��3�վ�
	var sysAccept =document.frm.loginAccept.value;             			//��ˮ��
	var printStr = printInfo(printType);			 		//����printinfo()���صĴ�ӡ����
	var mode_code=null;           							//�ʷѴ���
	var fav_code=null;                				 		//�ط�����
	var area_code=null;             				 		//С������
	var opCode=document.frm.opCode.value ;                   			 	//��������
	var phoneNo=document.frm.phoneNo.value;                  	 		//�ͻ��绰
	
	if(printStr == "failed")
	{
		return false;
	}
	var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no"
	var path = "<%=request.getContextPath()%>/npage/innet/hljBillPrint_jc.jsp?DlgMsg=" + DlgMessage+ "&submitCfm=" + submitCfm;
    path+="&mode_code="+mode_code+
			"&fav_code="+fav_code+"&area_code="+area_code+
			"&opCode="+opCode+"&sysAccept="+sysAccept+
			"&phoneNo="+document.frm.phoneNo.value+
			"&submitCfm="+submitCfm+"&pType="+
			pType+"&billType="+billType+ "&printInfo=" + printStr;
     var ret=window.showModalDialog(path,printStr,prop);
     return ret;
}


function QryNewRate()
{
    var pageTitle = "IPT��Ա������Ϣ��ѯ";
    var fieldName = "���ʴ���|��������|";

	if (document.frm.grpIdNo.value == "")
	{
		rdShowMessageDailog("���Ŵ��벻��Ϊ�գ�");
		return false;
	}
	
    var sqlStr="select a.mode_code,a.mode_name"
    	+" from sBillModeCode a"
    	+" where a.mode_type = any('IPT0')"
    	+" and a.region_code='" + "<%=regionCode%>" + "'"
    	+" order by a.mode_code";
    var selType = "S";    //'S'��ѡ��'M'��ѡ
    var retQuence = "2|0|1|";
    var retToField = "newRate|newRateName|";
    PubSimpSel(pageTitle,fieldName,sqlStr,selType,retQuence,retToField);
}


function PubSimpSel(pageTitle,fieldName,sqlStr,selType,retQuence,retToField)
{
	var path = "<%=request.getContextPath()%>/npage/public/fPubSimpSel.jsp";
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
	getMidPrompt("10442",codeChg(document.all.newRate.value),"trNewRate");
}

//ȡ��ˮ
function getSysAccept()
{
	var getSysAccept_Packet = new AJAXPacket("pubSysAccept.jsp","�������ɲ�����ˮ�����Ժ�......");
	getSysAccept_Packet.data.add("retType","getSysAccept");
	core.ajax.sendPacket(getSysAccept_Packet);
	getSysAccept_Packet=null;
}

function refMain()
{
	getAfterPrompt(document.frm.opCode.value);
	if( document.frm.grpIdNo.value == "" )
	{
		rdShowMessageDialog("�����û�ID����Ϊ�գ�");
		document.frm.idIccid.select();
		return false;
	}
	if( document.frm.idNo.value == "" )
	{
		rdShowMessageDialog("�û�ID����Ϊ�գ�");
		document.frm.phoneNo.select();
		return false;
	}
	if (document.frm.opCode.value == "2905"||document.frm.opCode.value == "2909")
	{
		if (document.frm.newRate.value=="")
		{
			rdShowMessageDialog("�·��ʲ���Ϊ��!");
			document.frm.newRate.focus();
			return false;
		}
	}
	if (document.frm.opCode.value == "2909")
	{
		if (document.frm.newRate.value == document.frm.mainRate.value )
		{
			rdShowMessageDialog("�¾ɷ��ʲ�����ͬ!");
			document.frm.newRate.focus();
			return false;
		}
	}
	getSysAccept()
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
<BODY onload="getBeforePrompt(<%=opCode%>);OpCodeChange();">
	<FORM action="" method="post" name="frm" >
		<input type="hidden" name="loginAccept"  value="0"> <!-- ������ˮ�� -->
		<input type="hidden" name="loginNo"  value="<%=loginNo%>">
		<input type="hidden" name="loginPwd"  value="<%=loginPwd%>">
		<input type="hidden" name="orgCode"  value="<%=orgCode%>">
		<input type="hidden" name="ipAddress"  value="<%=ipAddress%>">
		<input type="hidden" name="regionCode"  value="<%=regionCode%>">
		<input type="hidden" name="id_iccid"  value=""><!--��Ա�����֤��,���뼯��֤����������-->
		<input type="hidden" name="cust_address"  value="">
		
		<!--input type="hidden" name="opCode"   value="<%=opCode%>"-->
		<input type="hidden" name="opName"  value="<%=opName%>">
		
	<%@ include file="/npage/include/header.jsp" %>	
	<div class="title">
		<div id="title_zi">ѡ���������</div>
	</div>	
<TABLE cellSpacing="0">
	<TR>
		<TD class="blue">��������</TD>
		<TD colspan="3">
			<SELECT name="opCode" class="button" id="opCode" onChange="OpCodeChange()">
				<option value="2905" <%=flag1%>>��Ա��� </option>
				<option value="2907" <%=flag3%>>��Աɾ�� </option>
				<option value="2909" <%=flag2%>>��Ա�ʷѱ�� </option>
			</SELECT>
			<font color="orange">*</font>
		</TD>
	</TR>
	
	<TR>
		<TD class="blue">����֤������</TD>
		<TD>
			<input name="idIccid" class="button" id="idIccid" size="24" maxlength="18" v_type="string" v_must=1 index="1" value="">
			<input name=custQuery type=button id="custQuery" class="b_text" onMouseUp="getInfo_Cust();" onKeyUp="if(event.keyCode==13)getInfo_Cust();" style="cursor��hand" value=��ѯ>
			<font color="orange">*</font>
		</TD>
		<TD class="blue">���ſͻ�ID</TD>
		<TD>
			<input class="button" type="text" name="custId" size="20" maxlength="18" v_type="0_9" v_must=1 index="2" value="">
			<font color="orange">*</font>
		</TD>
	</TR>
	
	<TR>
		<TD class="blue">����ID</TD>
		<TD>
			<input name=unitId class="button" id="unitId" size="24" maxlength="10" v_type="0_9" v_must=1 index="3" value="">
			<font color="orange">*</font>
		</TD>
		<TD class="blue">�����ⲿ���</TD>
		<TD>
			<input class="button" name="grpOutNo" size="20" v_must=1 v_type=string index="4" value="">
			<font color="orange">*</font>
		</TD>
	</TR>
	
	<TR>
		<TD class="blue">�����û�ID</TD>
		<TD>
			<input class="InputGrey" name="grpIdNo" size="20" readonly v_must=1 v_type=string index="4" value="">
			<font color="orange">*</font>
		</TD>
		<TD class="blue">���ſͻ�����</TD>
		<TD>
			<input name="unit_name" class="InputGrey" type="text"  value="" readOnly >
		</TD>
			<input name=chkGrpPwd type="hidden" onClick="check_HidPwd();" class="b_text" style="cursor��hand" id="chkGrpPwd" value=У��>
	</TR>
							
	<TR>
		<TD class="blue">���Ų�Ʒ����</TD>
		<TD colspan="3">
			<input class="InputGrey" name="user_no" size="20" readonly value="">
		</TD>
	</TR>
							
	<TR>
		<TD class="blue">�ֻ�����</TD>
		<TD colspan="3">
			<input name="phoneNo" class="button" type="text" v_must=1 v_minlength="11" v_maxlength="11" v_type="string" index="8" value="" maxlength="11">
			<input class="b_text" name=qryPhone onkeyup="if(event.keyCode==13){QryPhoneInfo()}" onmouseup="QryPhoneInfo()"  style="cursor:hand" type=button value="��ѯ" index="19">
			<font color="orange">*</font>
		</TD>
	</TR>
							
	<TR>
		<TD class="blue">�û�ID</TD>
		<TD>
			<input name="idNo" class="InputGrey" type="text" v_must=1 v_type="string" index="8" value="" readonly>
			<font color="orange">*</font>
		</TD>
		<TD class="blue">�û�����</TD>
		<TD>
			<input name="userName" class="InputGrey" type="text" v_must=1 v_type="string" index="8" value="" readonly>
			<font color="orange">*</font>
		</TD>
	</TR>
							
	<TR>
		<input name="smCode" class="InputGrey" type="hidden" v_must=1  v_type="string" index="8" value="" readonly>
		<TD class="blue">�û�Ʒ������</TD>
		<TD colspan="3">
			<input name="smName" class="InputGrey" type="text" v_must=1  v_type="string" index="8" value="" readonly>
			<font color="orange">*</font>
		</TD>
	</TR>
							
	<TR id=trRate>
		<TD class="blue">��Ա���ʴ���</TD>
		<TD>
			<input name="mainRate" class="InputGrey" type="text" v_must=1 v_maxlength=8 v_type="string" index="8" value="" readonly >
			<font color="orange">*</font>
		</TD>
		<TD class="blue">��Ա��������</TD>
		<TD>
			<input name="mainRateName" class="InputGrey" type="text" v_must=1 v_maxlength=8 v_type="string" index="8" value="" readonly >
			<font color="orange">*</font>
		</TD>
	</TR>
							
	<TR id=trNewRate>
		<TD class="blue">��Ա�·��ʴ���</TD>
		<TD>
			<input name="newRate" class="InputGrey" type="text" v_must=1 v_maxlength=8 v_type="string" index="8" value="" readonly >
			<input class="b_text" name=BNewRate onmouseup="QryNewRate()"  style="cursor:hand" type=button value="��ѯ" index="19">
			<font color="orange">*</font>
		</TD>
		<TD class="blue">��Ա�·�������</TD>
		<TD>
			<input name="newRateName" class="InputGrey" type="text" v_must=1 v_maxlength=8 v_type="string" index="8" value="" readonly >
			<font color="orange">*</font>
		</TD>
	</TR>
							
	<TR id=tr_pay_flag>
		<TD class="blue">���ѷ�ʽ</TD>
		<TD colspan="3">
			<select name="pay_flag" id="pay_flag">
				<option value="2" selected > ���˸��� </option>
				<option value="0"  > ����ͳ�� </option> 
			</select>
		</TD>
	</TR>
							
	<TR>
		<TD class="blue">ϵͳ��ע</TD>
		<TD colspan="3">
			<input class="InputGrey" name="sysNote" size="60" value="" readonly>
		</TD>
	</TR>
							
	<TR style="display:none">
		<TD class="blue">�û���ע</TD>
		<TD colspan="3">
			<input class="button" name="opNote" size="60" value="">
		</TD>
	</TR>
	
	<TR>
		<TD align="center" colspan="4">
			<input class="b_foot" name="doSubmit"  type=button value="ȷ��" onclick="refMain()">
			<input class="b_foot" name="reset1"  onClick="" type=reset value="���">
			<input class="b_foot" name="kkkk"  onClick="removeCurrentTab()" type=button value="�ر�">
		</TD>
	</TR>
		</table>
	<div id="relationArea" style="display:none"></div>
				<div id="wait" style="display:none">
				<img  src="/nresources/default/images/blue-loading.gif" />
			</div>
			<div id="beforePrompt"></div>
		</DIV>             
</DIV>		
		<%@ include file="/npage/include/footer_simple.jsp" %>	
	</FORM>
<script language="JavaScript">
	document.frm.idIccid.focus();
	ChgCurrStep("custQuery");
	OpCodeChange();
</script>
</BODY>
</HTML>


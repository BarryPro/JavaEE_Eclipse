<%
/********************
 version v2.0
 ������: si-tech
 update hejw@2009-1-13
********************/
%>
<%
  String opCode = "6726";
  String opName = "���Ų������ӳ�Ա";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http//www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http//www.w3.org/1999/xhtml">
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.util.StringTokenizer"%>
<%@ include file="../../include/remark1.htm" %>

<%

String ipAddress = (String)session.getAttribute("ipAddr");
String loginNo = (String)session.getAttribute("workNo");
String workname = (String)session.getAttribute("workName");
String orgCode = (String)session.getAttribute("orgCode");
String loginPwd  = (String)session.getAttribute("password");
String regionCode = (String)session.getAttribute("regCode");
%>
<%
	String sm_code = "";
  String mebProdCode ="";
  String matureProdCode ="";
  mebProdCode = request.getParameter("mebProdCode");
  matureProdCode = request.getParameter("matureProdCode");
  String sqlStr1="";
	String[][] retListString1 = null;
	
  
  //��ȡ����ҳ�õ�����Ϣ
	String loginAccept = request.getParameter("login_accept");
	if(loginAccept == null)
	{			
		//��ȡϵͳ��ˮ
%>

<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="regionCode" routerValue="<%=regionCode%>"  id="req" />

<%		
		loginAccept=req;	
		//System.out.println("-------------loginAccept--------------hjw----------------"+loginAccept);
	}
%>
<HTML>
<HEAD>
	<TITLE>���Ų����Ա����</TITLE>
<META content="text/html; charset=GBK" http-equiv=Content-Type>
<meta http-equiv="Expires" content="0">
<script language ="javascript">

//����
function ajaxSubmit(){
	$.ajax({
		type: "POST",
		url: "f6726_2.jsp",
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
			"unitId="+document.frm.unitId.value+"&"+
			"grpName="+document.frm.grpName.value+"&"+
			"payType1="+document.frm.payType1.value+"&"+
			"mebProdCode="+document.frm.mebProdCode.value+"&"+
			"mebMonthFlag1="+document.frm.mebMonthFlag1.value+"&"+
			"matureFlag="+document.frm.matureFlag.value+"&"+
			"matureProdCode="+document.frm.matureProdCode.value+"&"+
			"phoneNo1="+document.frm.phoneNo1.value,
		
		success: function(data, textStatus){
			$("body").html(data);
			$("body").html();
	  	},
	  	complete: function(XMLHttpRequest, textStatus){
		},
		error:function (XMLHttpRequest, textStatus, errorThrown) {
		}
	});
}
</script>

</HEAD>
<SCRIPT type=text/javascript>
function ChgCurrStep(currStep)
{
	if (currStep == "chkGrpPwd")
	{
		document.frm.custQuery.disabled = false;
		document.frm.chkGrpPwd.disabled = false;
		document.frm.doSubmit.disabled = false;
	}
	else if (currStep == "qryPhone")
	{
		document.frm.custQuery.disabled = false;
		document.frm.chkGrpPwd.disabled = false;
		document.frm.doSubmit.disabled = false;
	}
	else if (currStep == "chkUserPwd")
	{
		document.frm.custQuery.disabled = false;
		document.frm.chkGrpPwd.disabled = false;
		document.frm.doSubmit.disabled = false;
	}
	else if (currStep == "doSubmit")
	{
		document.frm.custQuery.disabled = false;
		document.frm.chkGrpPwd.disabled = false;
		document.frm.doSubmit.disabled = false;
	}
	else if(currStep == "custQuery")
	{
	document.all.idIccid.readonly=true;
	document.all.custId.readonly=true;
	document.all.unitId.readonly=true;		
	document.all.grpOutNo.readonly=true;
	document.all.grpIdNo.readonly=true;
	document.all.custQuery.disabled = false;	
	}
}

function doProcess(packet)
{
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
				rdShowMessageDialog("�û�����У��ɹ�",2);
			}
		}
		else
		{
			rdShowMessageDialog("�û�����У�����������У�飡",0);
			return false;
		}
	}
  //�����Ʒ
  if(retType == "changProd"){  	
	  var triListData = packet.data.findValueByName("tri_list"); 	  
	 	var triList=new Array(triListData.length);
	  triList[0]="mebProdCode";
	  document.all("mebProdCode").length=0;
	  document.all("mebProdCode").options.length=triListData.length;
	  for(j=0;j<triListData.length;j++)
	  {
		document.all("mebProdCode").options[j].text=triListData[j][1];
		document.all("mebProdCode").options[j].value=triListData[j][0];
	  }
	  document.all("mebProdCode").options[0].selected=true; 
  } 
    //������굽��ת��Ʒ
  if(retType == "changmatureProd"){  	
	  var triListData = packet.data.findValueByName("tri_list"); 	  
	 	var triList=new Array(triListData.length);
	  triList[0]="matureProdCode";
	  document.all("matureProdCode").length=0;
	  document.all("matureProdCode").options.length=triListData.length;
	  for(j=0;j<triListData.length;j++)
	  {
		document.all("matureProdCode").options[j].text=triListData[j][1];
		document.all("matureProdCode").options[j].value=triListData[j][0];
	  }
	  document.all("matureProdCode").options[0].selected=true; 
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
//				page = "f6726_2.jsp";
//				frm.action=page;
//				frm.method="post";
//				frm.submit();
   
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

//���ù������棬���в�Ʒ����ѡ��
function getmebProdCodeQuery()
{
    var pageTitle = "���ų�Ա��Ʒѡ��";
    var fieldName = "��Ʒ���Դ���|��Ʒ����|";
		var sqlStr = "";
    var selType = "S";    //'S'��ѡ��'M'��ѡ
    var retQuence = "2|0|1|";
    var retToField = "mebProdCode|mebProdName|";
    var smName = document.frm.smName.value;
    
    //�����ж��Ƿ��Ѿ�ѡ���˼�����Ϣ
    if(document.frm.smName.value == "")
   {
    rdShowMessageDialog("������ѡ������Ϣ��",0);
    return false;
   }
   //�ж��Ƿ�ѡ�񸶷�����
	 if(document.frm.payType.value == "")
   {
    rdShowMessageDialog("��ѡ�񸶷ѷ�ʽ��",0);
    return false;
   }
    if(PubSimpSelProdAttr(pageTitle,fieldName,sqlStr,selType,retQuence,retToField));
}

function PubSimpSelProdAttr(pageTitle,fieldName,sqlStr,selType,retQuence,retToField)
{
    var path = "/npage/s6726/fpubmebProdCode_sel.jsp";
    path = path + "?sqlStr=" + sqlStr + "&retQuence=" + retQuence;
    path = path + "&fieldName=" + fieldName + "&pageTitle=" + pageTitle;
    path = path + "&selType=" + selType;
    path = path + "&groupFlag=Y";
	  path = path + "&op_code=" + document.all.opCode.value;
	  path = path + "&sm_code=" + document.all.smCode.value; 
	  path = path + "&smName=" + document.all.smName.value;
	  path = path + "&payType=" +document.all.payType.value;
	  path = path + "&regionCode=<%=regionCode%>"
	  path = path + "&mebMonthFlag=" + document.all.mebMonthFlag.value;  	       
    retInfo = window.open(path,"newwindow","height=450, width=650,top=50,left=200,scrollbars=yes, resizable=no,location=no, status=yes");
	return true;
}

function getmebProdCode(retInfo)
{
	var retToField = "mebProdCode|mebProdName|";
	if(retInfo ==undefined)      
	{
		//ChgCurrStep("custQuery");
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
	document.frm.payType1.value=document.frm.payType.value;
	document.frm.payType.disabled=true;
}

function getmatureProdCodeQuery()
 {  
 	  var pageTitle = "���굽��ת���²�Ʒѡ��";
    var fieldName = "��Ʒ���Դ���|��Ʒ����|";    
		var sqlStr = "";
    var selType = "S";    //'S'��ѡ��'M'��ѡ
    var retQuence = "2|0|1|";
    var retToField = "matureProdCode|matureProdName|";
    var smName = document.frm.smName.value;
    //�����ж��Ƿ��Ѿ�ѡ���˼�����Ϣ
    if(document.frm.smName.value == "")
   {
    rdShowMessageDialog("������ѡ������Ϣ��",0);
    return false;
   }
	if(PubSimpSelmatureProdAttr(pageTitle,fieldName,sqlStr,selType,retQuence,retToField));
 }
 
function PubSimpSelmatureProdAttr(pageTitle,fieldName,sqlStr,selType,retQuence,retToField)
{   
    var path = "/npage/s6726/fpubmatureProdCode_sel.jsp"; 
    path = path + "?sqlStr=" + sqlStr + "&retQuence=" + retQuence;
    path = path + "&fieldName=" + fieldName + "&pageTitle=" + pageTitle;
    path = path + "&selType=" + selType;
    path = path + "&groupFlag=Y";
	  path = path + "&regionCode=<%=regionCode%>" 
	  path = path + "&smName=" + document.all.smName.value;  
	  path = path + "&mebMonthFlag=" + document.all.mebMonthFlag1.value;  
	  path = path + "&payType=" +document.all.payType.value; 
    retInfo = window.open(path,"newwindow","height=450, width=650,top=50,left=200,scrollbars=yes, resizable=no,location=no, status=yes");
	return true;	
}
function getmatureProd(retInfo)
{ 
	var retToField = "matureProdCode|matureName|";
	if(retInfo ==undefined)      
	{
		//ChgCurrStep("custQuery");
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
}


//���ù������棬���м��ſͻ�ѡ��
function getInfo_Cust()
{
	var pageTitle = "���ſͻ�ѡ��";
	var fieldName = "֤������|���ſͻ�ID|�����û�ID|�����û�����|����ID|���Ų�Ʒ����|��������|Ʒ������|���±�־|";
	var sqlStr = "";
	var selType = "S";    //'S'��ѡ��'M'��ѡ
	var retQuence = "9|0|1|2|3|4|5|6|7|8|";
	var retToField = "idIccid|custId|grpIdNo|grpOutNo|unitId|smName|grpName|smCode|mebMonthFlag|";
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
	var path = "/npage/s6726/fpubgrpusr_sel.jsp";
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
	var retToField = "idIccid|custId|grpIdNo|grpOutNo|unitId|smName|grpName|smCode|mebMonthFlag|";

	ChgCurrStep("custQuery");
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
	//alert("mebMonthFlag"+document.frm.mebMonthFlag.value);
	document.frm.mebMonthFlag1.value=document.frm.mebMonthFlag.value;
	document.frm.mebMonthFlag.disabled=true;	
	//tochange();
	//tomaturechange();
}

function check_HidPwd()
{
	var custId = document.frm.custId.value;
	var Pwd1 = document.frm.grpPwd.value;
	var checkPwd_Packet = new AJAXPacket("/npage/s6726/pubCheckPwd.jsp","���ڽ�������У�飬���Ժ�......");
	checkPwd_Packet.data.add("retType","checkPwd");
	checkPwd_Packet.data.add("cust_id",custId);
	checkPwd_Packet.data.add("Pwd1",Pwd1);
	core.ajax.sendPacket(checkPwd_Packet);
	checkPwd_Packet =null ;
}

function ChkUserPwd()
{
	var checkPwd_Packet = new AJAXPacket("/npage/s6726/pubCheckPwd.jsp","���ڽ�������У�飬���Ժ�......");
	checkPwd_Packet.data.add("retType","chkUserPwd");
	checkPwd_Packet.data.add("ID_NO",document.frm.idNo.value);
	checkPwd_Packet.data.add("inPwd",document.frm.userPwd.value);
	core.ajax.sendPacket(checkPwd_Packet);
	checkPwd_Packet =null;
}

function QryPhoneInfo()
{
	if (checkElement("phoneNo"))
	{
		document.frm.phoneNo.focus();
	}
	var checkPwd_Packet = new AJAXPacket("/npage/s6726/getPhoneInfo.jsp","���ڽ�������У�飬���Ժ�......");
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
	 	var payType = document.frm.payType.value;
	 	var matureFlag = document.frm.matureFlag.value;
	 	var matureProdCode = document.frm.matureProdCode.value;
	 	var phoneNo = "";
	 	if(payType=="2") {
	 		payType="���˸���";
	 	}
	 	if(payType=="0"); {
	 		payType="���Ÿ���";
	 	}
	 	var mebMonthFlag =document.frm.mebMonthFlag1.value;
	 	if(mebMonthFlag=="N") {
	 		mebMonthFlag="����";	
	 		phoneNo = document.frm.phoneNo1.value;
	 	}
	 	if(mebMonthFlag=="Y") {
	 		mebMonthFlag="����";
	 		matureProdCode="��";
	 		matureFlag="��";
	 		phoneNo = document.frm.phoneNo.value;
	 	}
		    var retInfo = "";
			  retInfo+='<%=workname%>'+"|";
    		retInfo+='<%=new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss", Locale.getDefault()).format(new java.util.Date())%>'+"|";
    		retInfo+="���֤��:"+document.frm.idIccid.value+"|";
    		retInfo+="�û�����:"+document.frm.grpName.value+"|";
    		retInfo+="�����û�����:"+document.frm.grpOutNo.value+"|";
    		retInfo+="���ѷ�ʽ:"+payType+"|";
  	    retInfo+="��Ʒ����:"+mebMonthFlag+"|";
  	    retInfo+="���ų�Ա��Ʒ:"+document.frm.mebProdCode.value+"|";
  	    retInfo+="���굽��ת����:"+matureFlag+"|";
  	    retInfo+="ת���²�Ʒ:"+matureProdCode+"|";
	    	retInfo+="�ֻ�����:"+phoneNo+"|";
	    	retInfo+=""+"|";
	    	retInfo+=""+"|";
	    	retInfo+=""+"|";
	    	retInfo+=""+"|";
	    	retInfo+=""+"|";
	    	retInfo+=""+"|";
	    	retInfo+=""+"|";
	    	retInfo+=""+"|";
	    	retInfo+=""+"|";
	    	retInfo+="��ˮ��"+document.frm.loginAccept.value+"|";
	    	retInfo+=""+"|";
	    	retInfo+=""+"|";
	    	retInfo+=""+"|";
	    	retInfo+=""+"|";
	    	retInfo+=""+"|";
	    	retInfo+=""+"|";
	    	retInfo+=document.frm.sysNote.value+"|";
			  return retInfo;
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
	var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:no; resizable:no;location:no;status:no;help:no"
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
		rdShowMessageDialog("���Ŵ��벻��Ϊ�գ�",0);
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
		if(document.frm.payType.value == "2"){		
		 if(document.frm.mebMonthFlag.value == "N" )
		 {
			 if(document.frm.matureFlag.value == "Y" )    
		   {		if(document.frm.matureProdCode.value == "" )    
		        {	
				    rdShowMessageDialog("��ѡ��ת����Ʒ!!",2);
				    document.frm.matureProdCode.focus();
				    return false;
				   }
		    }
		 }	
	 }
	if(document.frm.mebMonthFlag1.value == "Y"){		
		if(  document.frm.phoneNo.value == "" )
		{
			rdShowMessageDialog("���ų�Ա���벻��Ϊ��!!",0);
			document.frm.phoneNo.focus();
			return false;
		}	
	 }else{
	    if(document.frm.payType.value == "2"){	
	         if(document.frm.phoneNo1.value == "" )
					 {
						rdShowMessageDialog("���ų�Ա���벻��Ϊ��!!",0);
						document.frm.phoneNo1.focus();
						return false;
					 }
		  }else{
			     if(  document.frm.phoneNo.value == "" )
					 {
						rdShowMessageDialog("���ų�Ա���벻��Ϊ��!!",0);
						document.frm.phoneNo1.focus();
						return false;
					 }
	      }
	  }
	 	if(  document.frm.mebProdCode.value == "" )
		{
			rdShowMessageDialog("���ų�Ա��Ʒ����Ϊ��!!",0);
			document.frm.mebProdCode.focus();
			return false;
		}	
if(document.frm.mebMonthFlag1.value=="Y"){
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
					  if(MobPhone!=""){
						    if((MobPhone.substring(0,1) !=1) || (MobPhone.substring(1,2) !=3 && MobPhone.substring(1,2) !=5&& MobPhone.substring(1,2) !=4&& MobPhone.substring(1,2) !=8))
				        {
				        rdShowMessageDialog("�ֻ�����ֻ����13��15��14��18��ͷ�������������ֻ����룡" ,0);
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
				      rdShowMessageDialog("��ӵĳ�Ա������Ϣ��ʽ������Ա��������30����",0);
			        document.frm.phoneNo.focus();
			        return false;
					 }
			 }
		} 
		 
	document.frm.sysNote.value = "����[<%=loginNo%>]Ϊ����["+document.all.custId.value+"]�����Ų����Ա���";
	 if((document.all.opNote.value).trim().length==0)
	 {
	 document.all.opNote.value= "����[<%=loginNo%>]Ϊ����["+document.all.custId.value+"]�����Ų����Ա���";
	 }
	getSysAccept();
  //wuxy alter 20090826 ���ȷ����ȡ�����ύ������
	//ajaxSubmit();
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


function choiceFilePut()
{
	if(document.all.byFile.checked){
		document.all.phoneNo.readOnly=true;
	  document.all.setBBChbByFile.disabled = false;
		document.all.setPdButton.disabled = true;
	}else{
		document.all.phoneNo.readOnly=false;
		document.all.setBBChbByFile.disabled = true;
		document.all.setPdButton.disabled = false;
	}
}

function setBBChgByFile()
{

	if(document.all.addFile.value== ""){
		rdShowMessageDialog("���������...����ťѡ���ļ���");
		document.all.addFile.focus();
 		return;
	}

	var region_code = form1.region_code.value;
	document.frm.action="f5246_setBBChgByFile.jsp?region_code=" + region_code;
  document.frm.submit();
}

function changeOthers(){
	var payType=document.frm.payType.value;
	var mebMonthFlag1=document.frm.mebMonthFlag1.value;
	if(payType=="2"){
		  document.frm.matureProdCode.value="";	
		  document.frm.matureFlag.value="N";					
			tbs2.style.display="";
			tbs3.style.display="";			
			if(mebMonthFlag1=="Y"){
				document.frm.phoneNo1.value=""
				tbs2.style.display="none";
				tbs3.style.display="none";
				tbs4.style.display="";	
				tbs5.style.display="none";
				document.frm.matureProdCode.readonly=false;
				//document.frm.matureProdCode.style.display='none';
				document.frm.matureProdCodeQuery.disabled=true;			  		  			         
			}else{			
				document.frm.phoneNo.value=""		
				tbs4.style.display="none";
				tbs5.style.display="";							
			}				         
	}else{
		  	tbs2.style.display="none";
				tbs3.style.display="none";
			if(mebMonthFlag1=="Y"){
				document.frm.matureProdCode.value="";	
		    document.frm.matureFlag.value="N";
				document.frm.phoneNo1.value=""
				tbs4.style.display="";	
				tbs5.style.display="none";				  		  			         
			}else{
				document.frm.phoneNo.value=""
				document.frm.matureProdCode.value="";
				document.frm.matureProdCode.disabled=true;
				document.frm.matureFlag.value="N";	
				tbs4.style.display="";
				tbs5.style.display="none";							
			}	
	}	
}


function changeMatureFlag(){
	var matureFlag=document.frm.matureFlag.value;
	if(matureFlag=="Y"){
	 document.frm.matureProdCode.value="";
	 document.frm.matureProdCode.readonly=true;
	 //document.frm.matureProdCode.style.display='block'; 
	 document.frm.matureProdCodeQuery.disabled=false;
   }else{
   document.frm.matureProdCode.value="";  
   document.frm.matureProdCode.disabled=false;
   document.frm.matureProdCode.readonly=false;
   //document.frm.matureProdCode.style.display='none'   
   document.frm.matureProdCodeQuery.disabled=true;
   }	
}


function   checkLength(text)   
{   
  if (text.value.length >= 360){
  rdShowMessageDialog("�����������30���ֻ�����!!");	   
  return   false;   
  }
} 



</script>
<BODY>
	<FORM action="" method="post" name="frm" >
			<%@ include file="/npage/include/header.jsp" %>  
		<input type="hidden" name="loginAccept"  value="<%=loginAccept%>"> <!-- ������ˮ�� -->
		<input type="hidden" name="loginNo"  value="<%=loginNo%>">
		<input type="hidden" name="loginPwd"  value="<%=loginPwd%>">
		<input type="hidden" name="smCode"  value="">
		<input type="hidden" name="opCode" id="opCode" value="6726">	
		<input type="hidden" name="smName"  value="">
		<input type="hidden" name="grpName"  value="">
		<input type="hidden" name="mebProdCode"  value="">
		<input type="hidden" name="matureProdCode"  value="">
	  <input type="hidden" name="regionCode"  value="<%=regionCode%>">
		<input type="hidden" name="pay_type"  value="">
		<input type="hidden" name="orgCode"  value="<%=orgCode%>">
		<input type="hidden" name="ipAddress"  value="<%=ipAddress%>">
	  <input type="hidden" name="matureName"  value="">
	  <input type="hidden" name="payType1"  value="2">
	  <input type="hidden" name="mebMonthFlag1"  value="Y">	  
		<div class="title">
		<div id="title_zi">���Ų������ӳ�Ա</div>
	</div>
						<TABLE  cellSpacing=0>
							<TR>
								<td class="blue">
									��������
								</TD>
								<TD colspan="3">
									<SELECT name="opCode1"  id="opCode1" onChange="OpCodeChange()"  disabled >
										<option value="6726" selected>�������ų�Ա����</option>
										<option value="6727">�������ų�Աɾ��</option>
									</SELECT>
									<font class="orange">*</font>
								</TD>
							</TR>
							<TR>
								<td class="blue">
									֤������
								</TD>
								<TD>
									<input name="idIccid"  id="idIccid" size="24" maxlength="18" v_type="string" v_must=1 v_name="���֤��" index="1" value="">
									<input name=custQuery type=button id="custQuery" class="b_text" onMouseUp="getInfo_Cust();" onKeyUp="if(event.keyCode==13)getInfo_Cust();" style="cursorhand" value=��ѯ>
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
								���ű��</div>
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
								<TD COLSPAN="1">
									<input  name="grpIdNo" size="20" readonly v_must=1 v_type=string v_name="�����û�ID" index="4" value="" class="InputGrey">
									<font class="orange">*</font>
								</TD>
								<td class="blue">���ſͻ�����</TD>
								<TD colspan="1">
									<jsp:include page="/npage/common/pwd_1.jsp">
									<jsp:param name="width1" value="16%"  />
									<jsp:param name="width2" value="34%"  />
									<jsp:param name="pname" value="grpPwd"  />
									<jsp:param name="pwd" value=""  />
									</jsp:include>

									<input name=chkGrpPwd type=button onClick="check_HidPwd();" class="b_text" style="cursorhand" id="chkGrpPwd" value=У�� >
									<font class="orange">*</font>               
								</TD>                                                                    
							</TR>                                                                 
              <TR>                                                 
								<TD class="blue">                                                               
									���ѷ�ʽ                           
								</TD>
								<TD >
									<SELECT name="payType"  id="payType" onclick="changeOthers()">
                    <option value="" selected>--��ѡ��--</option>
										<option value="2" >���˸���</option>
										<option value="0" >���Ÿ���</option>
									</SELECT>
									<font class="orange">*</font>
								</TD>
								<td class="blue">
									��Ʒ����
								</TD>
								<TD >
									<SELECT name="mebMonthFlag"  id="mebMonthFlag"  onclick="changeOthers()">
										<option value="N" >����</option>
										<option value="Y" >���� </option>
									</SELECT>
									<font class="orange">*</font>
								</TD>
							</TR>
						 <TR>
								<td class="blue">
									���ų�Ա��Ʒ
								</TD>											
	           <TD>
	              <input  type="text" id="mebProdName"  name="mebProdName" size="20" value=""  readonly>
	              <input name="mebProdCodeQuery" type="button" id="mebProdCodeQuery"  class="b_text" onMouseUp="getmebProdCodeQuery();" onKeyUp="if(event.keyCode==13)getmebProdCodeQuery();" value="ѡ��">
				  			<font class="orange">*</font>
	  			   	</TD>													
								<td class="blue">
								<div id=tbs2 style="display:none">���굽��ת����</div>
								</TD>								
							   
							  <TD >
							  	<div id=tbs3 style="display:none">																
										<SELECT name="matureFlag"  id="change_year" onChange="changeMatureFlag()" >
											<option value="Y" >�� </option>
											<option value="N" selected>�� </option>
										</SELECT>									         		      
			              <input  type="text" id="matureProdName"  name="matureProdName" size="15" value="" readonly>
			              <input name="matureProdCodeQuery" type="button" id="matureProdCodeQuery"  class="b_text" onMouseUp="getmatureProdCodeQuery();" onKeyUp="if(event.keyCode==13)getmatureProdCodeQuery();" value="ѡ��">
						  			<font class="orange">*</font>		 			   	  														 			
							 		</div>									
								</TD>												           
		          </TR>															
							<TR>
								<td class="blue">�ֻ�����</TD>
								<TD colspan="1">
							  <div id="tbs4" style="display:">
								<textarea cols=30 rows=8 name="phoneNo" style="overflow:auto" v_must=1 v_minlength="11" v_maxlength="12" v_type="string" v_name="�ֻ�����" index="8" onpropertychange="if(this.value.length>600){this.value=this.value.substr(0,600);}" value=""></textarea>
								<br>ע���������ֻ�����ʱ,����"|"��Ϊ�ָ�<br>
								��,�������һ������Ҳ����"|"��Ϊ����,����������󲻳���30����<br>
								���磺13900000000|<br>
								&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;13900000001|<br>
								</div>
								 <div id="tbs5" style=display="none">
									<input  name="phoneNo1" size="24" value="" maxlength="11" v_minlength="11" v_maxlength="11">
									<br>עһ��ֻ��������һ���ֻ�����,����Ҫ�ӡ�|����<br>					
								</div>
								</TD>
								<TD>
								<TD>
								<div id="tbs1" style="display:none">
									<font color="red">��Ա���ʷѱ���Ϊ000030AA <br>
								  (0���⣬����ͨ�ŷ�0.40Ԫ/����)<br> 
								  ���ܼ��뱾����<br></font>
								</div>
								</TD>
							  </tr>
	
							<TR>
								<td>&nbsp;</TD>
								<TD colspan="3">
									<input  name="sysNote" size="60" value="" readonly type="hidden">
								</TD>
							</TR>
							<TR>
								<td class="blue">�û���ע</TD>
								<TD colspan="3">
									<input  name="opNote" size="60" value="" class="InputGrey">
								</TD>
							</TR>
						</TABLE>
						<TABLE cellSpacing=0>
							<TR>
								<TD align=center id="footer">
									<input class="b_foot" name="doSubmit"  type=button value="ȷ��" onclick="refMain()"  disabled >
									<input class="b_foot" name="reset1"  onClick="location = 'f6726_1.jsp';" type=reset value="���" >
									<input class="b_foot" name="kkkk"  onClick="removeCurrentTab()" type=button value="�ر�" >
								</TD>
							</TR>
						</TABLE>
    <%@ include file="/npage/include/footer.jsp" %>
		<jsp:include page="/npage/common/pwd_comm.jsp"/>
	</FORM>
 <script language="JavaScript">
	document.frm.idIccid.focus();
</script>
</BODY>
</HTML>

<%
/********************
version v2.0
������: si-tech
ģ�飺�ʻ����ϱ��
update zhaohaitao at 2008.12.23
********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html  xmlns="http://www.w3.org/1999/xhtml">
	
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page contentType= "text/html;charset=GBK" %>
<%@ page import="java.util.*"%>
<%@ include file="../../npage/bill/getMaxAccept.jsp" %>

<%
	String opCode = request.getParameter("opCode");
	String opName = request.getParameter("opName");
	
	String work_no = (String)session.getAttribute("workNo");
	String workName = (String)session.getAttribute("workName");
	String nopass = (String)session.getAttribute("password");
	String sIpAddress = (String)session.getAttribute("ipAddr");
	String org_code = (String)session.getAttribute("orgCode");
	String region_code = org_code.substring(0,2);
	String district_code = org_code.substring(2,4);
	String[][] favInfo = (String[][])session.getAttribute("favInfo");
	
	String myphone_no="";
	String mysql_str = "";
	String op_code = "1211";
	
	//2011/6/23 wanghfa��� ������Ȩ������ start
  boolean pwrf=false;
	String pubOpCode = op_code;
	String pubWorkNo = work_no;
%>
	<%@ include file="/npage/public/pubCheckPwdPower.jsp" %>
<%
	System.out.println("====wanghfa====s1211Main.jsp==== pwrf = " + pwrf);
	//2011/6/23 wanghfa��� ������Ȩ������ end
	

	// Please input init page jsp code
   StringBuffer sqlBuffer = new StringBuffer("");
   sqlBuffer.append("SELECT id_Name FROM sIdType order by id_type;");
   sqlBuffer.append("SELECT trim(bank_code)||'#'||trim(bank_code)||'->'||bank_name from sBankCode where   region_code='");
   sqlBuffer.append(region_code+"' ");
   sqlBuffer.append(" order by bank_code;");
  // sqlBuffer.append(" and district_code = '" + district_code + "' order by bank_code;");
   sqlBuffer.append("SELECT trim(post_bank_code)||'#'||trim(post_bank_code)||'->'||bank_name from sPostCode where region_code='");
   sqlBuffer.append(region_code+ "' order by post_bank_code;");
   sqlBuffer.append("SELECT post_type||'#'||post_name from sPostType;");
   sqlBuffer.append("SELECT ACCOUNT_TYPE||'#'||TYPE_NAME from sAccountType;");
   sqlBuffer.append("SELECT pay_code||'#'||pay_name from sPayCode where pay_code =any('0','4') and region_code = '");
   sqlBuffer.append(region_code+ "';");
   sqlBuffer.append("SELECT status_code||'#'||status_name from sConStatusCode");
   
%>
	<wtc:mutilselect name="sPubMultiSel" routerKey="region" routerValue="<%=region_code%>" retcode="retCode" retmsg="retMsg" id="metaData" type="array">
	<wtc:sql><%=sqlBuffer.toString()%></wtc:sql>
	</wtc:mutilselect>
<%
	
   String sqlStr = "SELECT hand_fee,favour_code from sNewFunctionFee where region_code='" + region_code +"' and function_code='"+ op_code+"'" + " and hand_fee > 0";

   int feeFlag = 0;
   String tmpHandFee = "0";
   //ArrayList tmpSelList = implSel.sPubSelect("2",sqlStr);
%>
	<wtc:service name="sPubSelect" routerKey="region" routerValue="<%=region_code%>" retcode="retCode2" retmsg="retMsg2" outnum="2">
		<wtc:param value="<%=sqlStr%>"/>
	</wtc:service>
	<wtc:array id="resultArr" scope="end"/>
<%
   if(retCode2.equals("000000"))
   {
		String[][] s = resultArr;
		if(s.length == 0)
	   {
			tmpHandFee = "0";
	   }
	   else
	   {
	   		tmpHandFee = s[0][0];
	       if(tmpHandFee.trim().length() == 0)
		   {
		   	tmpHandFee = "0";
		   }
		   for(int i = 0 ; i < favInfo.length ; i ++){
				if(favInfo[i][0].trim().equals(s[0][1])){
					feeFlag = 1;
					break;
				}
		   }
	   }
   }
  
String printAccept="";	
printAccept = getMaxAccept();
%>

<HEAD>
<TITLE>�ʻ����ϱ��</TITLE>
<META content=no-cache http-equiv=Pragma>
<META content=no-cache http-equiv=Cache-Control>
<META content="MSHTML 5.00.3315.2870" name=GENERATOR>

</HEAD>
<script language="javascript">
 
  onload=function()
  { 
	f1211Init(); 
	fillSelect();
	f1211CheckID();
  }
  
  var scheckcustpass="0";

  //---ͨ��RPC������-��ȡ�ʻ���Ϣ��Ϣ------
  function doProcess(packet)
  {      
	  var rpc_page=packet.data.findValueByName("rpc_page");
	 
	  if(rpc_page=="f1211ConMsg")
	  { 
	    var triListData = packet.data.findValueByName("ConMsg"); 
		var vConPaswdFlag = packet.data.findValueByName("vConPaswdFlag");
		var billOrder = packet.data.findValueByName("billOrder");
		
		var bank_name = packet.data.findValueByName("bank_name");
		var post_name = packet.data.findValueByName("post_name");
		var pay_name = packet.data.findValueByName("wm_paytype");
		
		//document.all.vBankCode.value='012';
		document.all.bank_name.value=bank_name;
		document.all.post_name.value=post_name;
		document.all.pay_name.value=pay_name;
		
		document.all.billOrder.value = billOrder;
		

		if(triListData.length != 1)
		{
		   rdShowMessageDialog("���ʻ�ID��Ϣ�����ڣ�");
		   document.all.vConID.focus();
		   return false;
		}
		<%-- if("<%=pwrf%>" == "false") --%>
		//{
			if(vConPaswdFlag != 0)
			{
				rdShowMessageDialog("�ʻ������������������!");
				document.all.vConPaswd.value="";
				document.all.vConPaswd.focus();
				document.all.qConMsg.disabled = false;
				return false;
			}
		//}
		
		if("<%=feeFlag%>" == "0")
		 {
			document.all.vPayFee.readOnly = true;
		 }
		if(triListData[0].length == 15)
		{
			
		 document.all.vAcountName.value = triListData[0][1]; //�ʻ�����
		 document.all.oldvAcountName.value = triListData[0][1]; //�ʻ�����
		 document.all.vCountHead.value = triListData[0][2];   //�ʻ���ͷ
		 document.all.vPrePay.value = triListData[0][3];    //prepay_fee
		 document.all.vDeposit.value = triListData[0][4]; //Ѻ��
		 document.all.vMinYearMonth.value = (triListData[0][5]).substr(0,4)+"��"+(triListData[0][5]).substr(4,2)+"��";//��СǷ������
		 document.all.vOweFee.value = triListData[0][6];    //Ƿ��
		 document.all.vMark.value = (triListData[0][7]).trim();  //����
		 document.all.vCountGrand.value = triListData[0][8]; //�ʻ�������
		
		 document.all.vPayCode.value = triListData[0][9];  //���ʽ
		 document.all.paycode.value = triListData[0][9];
		 document.all.vBankCode.value = triListData[0][10]; //bank_code
		
		 document.all.vPostCode.value = triListData[0][11]; //post_bank_code
		 document.all.vAcountNum.value = triListData[0][12]; //account_no
		 document.all.vCountType.value = triListData[0][13];  //account_type
		 

		 document.all.vCountStatus.value = triListData[0][14];  //account_status
		 

		 document.all.vNewPaswd.value = document.all.tmpPaswd.value;
		 document.all.vCfmPaswd.value = document.all.tmpPaswd.value;
		
		}
	
		var triListData2 = packet.data.findValueByName("ConPostMsg"); 
		if(triListData2.length != 0)
		{
			if(triListData2[0].length == 6)
			{
				document.all.vPostFlag.value = triListData2[0][0];  //POST_FLAG
				document.all.vPostType.value = triListData2[0][1];  //POST_TYPE
				document.all.vPostAddress.value = triListData2[0][2]; //POST_ADDRESS
				document.all.vPostZip.value = triListData2[0][3];     // POST_ZIP
				document.all.vFaxNo.value = triListData2[0][4];       //FAX_NO
				document.all.vMailAddress.value = triListData2[0][5]; //MAIL_ADDRESS
			}
			
		}else{
			document.all.vPostFlag.value = "";  //POST_FLAG
			document.all.vPostType.value = "";  //POST_TYPE
			document.all.vPostAddress.value = ""; //POST_ADDRESS
			document.all.vPostZip.value = "";     // POST_ZIP
			document.all.vFaxNo.value = "";       //FAX_NO
			document.all.vMailAddress.value = ""; //MAIL_ADDRESS
		}
		
		var grpName = packet.data.findValueByName("grpName");
		var cardName = packet.data.findValueByName("cardName");
		document.all.vGrpName.value = grpName;
		document.all.vCardName.value = cardName;		
		
		document.all.vSysNote.value="�޸�"+document.all.vConID.value + "�ʻ���Ϣ";
		window.status="";
		
	  }
		if (rpc_page=="queryBookingId")/*zhangyan@��ԤԼID*/
		{
			var vBookingPhoneNo = packet.data.findValueByName("vBookingPhoneNo"); 
			if (vBookingPhoneNo!="")
			{
				document.all.vPhoneNo.value=vBookingPhoneNo;
			}
			else 
			{
				rdShowMessageDialog(retcode+":"+retmsg);
			}
		}
   }
 
  function f1211GetConMsg(formField)
  {
       if(!checkElement(document.all.vConID))
	  {
			formField.value = "";
			formField.focus();
			return false;

	  }
 	  if(document.all.vConPaswd.value=="")
	  {
 		 rdShowMessageDialog("�������ʻ�����!");
			document.all.vConPaswd.value="";
			document.all.vConPaswd.focus();
			return false;
	  }
 		document.all.tmpPaswd.value = document.all.vConPaswd.value; 
		document.all.qConMsg.disabled = true;
		var myPacket = new AJAXPacket("f1211ConMsg.jsp","���ڻ���ʻ���Ϣ�����Ժ�......");
		//�����������
		
		myPacket.data.add("pContractNo",formField.value);
		myPacket.data.add("vConPaswd",document.all.vConPaswd.value);
		core.ajax.sendPacket(myPacket);
		myPacket=null;
  }

  function f1211CheckID()
  {
        document.all.vConID.disabled = false;
        if(document.all.vQryType[0].checked) // �����ʻ���ѯ
	{  
		document.all.tr_bookingInfo.style.display="none";//zhangyan@YUYUEXINXI
	   document.all.idCert.style.display="none";
	   document.all.idCust.style.display="none";
	   document.all.idPhoneCust.style.display="none";
	   document.all.vConID.value="";
	   document.all.vConPaswd.value="";
	   document.all.qConMsg.disabled=false;
	   document.all.vConID.focus();
	}
	
	if(document.all.vQryType[1].checked) // ����֤����ѯ
	{ 
		document.all.tr_bookingInfo.style.display="none";//zhangyan@YUYUEXINXI
	   document.all.idCert.style.display="";
	   document.all.idCust.style.display="";
	   document.all.idPhoneCust.style.display="none";
	   document.all.vCertNum.value="";
	   document.all.vCustID.value="";
	   document.all.vConID.value="";
	   document.all.vCustPaswd.value="";
	   document.all.vConPaswd.value="";
	   document.all.qCustID.disabled=false;
	   document.all.qConID.disabled=true;
	   document.all.qConMsg.disabled=true;
	   document.all.vCertType.focus();
	}
	
	/*if(document.all.vQryType[2].checked) // ���տͻ���ѯ
	{     
		document.all.idCert.style.display="none";
		document.all.idPhoneCust.style.display="none";
		document.all.idCust.style.display="";
		document.all.vCustID.value="";
		document.all.vCustPaswd.value="";
		document.all.vConID.value="";
		document.all.vConPaswd.value="";
		document.all.qConID.disabled=false;
		document.all.qConMsg.disabled=true;
		document.all.vCustID.focus();
	}*/
	
	if(document.all.vQryType[2].checked) // �����ƶ������ѯ
	{ 
		document.all.tr_bookingInfo.style.display="none";//zhangyan@YUYUEXINXI
	   document.all.idCert.style.display="none";
	   document.all.idPhoneCust.style.display="";
	   document.all.idCust.style.display="none";
	   document.all.vCertNum.value="";
	   document.all.vCustID.value="";
	   document.all.vConID.value="";
	   document.all.vCustPaswd.value="";
	   document.all.vConPaswd.value="";
	   document.all.qCustID.disabled=false;
	   document.all.qConID.disabled=true;
	   document.all.qConMsg.disabled=true;
	   document.all.vPhoneNo.value="";
	   document.all.vPhoneNo.focus();
	}
	if(document.all.vQryType[3].checked) // zhangyan@��ԤԼID��ѯ
	{ 
		document.all.tr_bookingInfo.style.display="";
	   document.all.idCert.style.display="none";
	   document.all.idPhoneCust.style.display="";
	   document.all.idCust.style.display="none";
	   document.all.vCertNum.value="";
	   document.all.vCustID.value="";
	   document.all.vConID.value="";
	   document.all.vCustPaswd.value="";
	   document.all.vConPaswd.value="";
	   document.all.qCustID.disabled=false;
	   document.all.qConID.disabled=true;
	   document.all.qConMsg.disabled=true;
	   document.all.vPhoneNo.value="";
	   document.all.vPhoneNo.focus();
	}

	
   }
   
function f1211GetCustID(formField){
    if(!checkElement(document.all.vCertNum))
	{
		formField.value = "";
	   return false;
	}
    document.all.vCustID.value="";
    var pageTitle = "�ͻ�ID��Ϣ��ѯ";
    var fieldName = "�ͻ�ID|�ͻ�����|"; 
    var selType = "S";    //'S'��ѡ��'M'��ѡ
    var retQuence = "1|0|";
    var retToField = "vCustID|";
    var sqlStr = "select cust_id,cust_name from dCustDoc " +"where id_iccid ='" + 
             formField.value+"'";
    
    //alert(pageTitle + '==' + fieldName + '==' + selType + '==' + retQuence+ '==' + retToField);
    //PubSimpSel(pageTitle,fieldName,sqlStr,selType,retQuence,retToField);
    //zhouby go on
    
    var path = "selectCustMsg.jsp";
    path = path + "?id_iccid=" + formField.value;  
    retInfo = window.showModalDialog(path);
    if(typeof(retInfo)=="undefined"){
        return false;   
    }
    
    $('input[name="vCustID"]').attr('value', retInfo);
      
  	document.all.qConID.disabled=false;
 }
 function f1211GetByPhone(formField){
    if(!checkElement(document.all.vPhoneNo))
	{
		formField.value = "";
	   return false;
	}
	
			<%-- if("<%=pwrf%>" == "false")
		{ --%>
			var checkPwd_Packet = new AJAXPacket("pubCheckPwd1211.jsp","���ڽ�������У�飬���Ժ�......");
			checkPwd_Packet.data.add("custType","01");				//01:�ֻ����� 02 �ͻ�����У�� 03�ʻ�����У��
			checkPwd_Packet.data.add("phoneNo",document.all.vPhoneNo.value);	//�ƶ�����,�ͻ�id,�ʻ�id
			checkPwd_Packet.data.add("custPaswd",document.all.vPhonePaswd.value);//�û�/�ͻ�/�ʻ�����
			checkPwd_Packet.data.add("idType","en");				//en ����Ϊ���ģ�������� ����Ϊ����
			checkPwd_Packet.data.add("idNum","");					//����
			checkPwd_Packet.data.add("loginNo","<%=work_no%>");		//����
			core.ajax.sendPacket(checkPwd_Packet, doCheckPwd);
			checkPwd_Packet=null;
			
		/* } */
		
		if(scheckcustpass=="1") {
		 return false;
		}
		

   	//document.all.vConID.value="";
    //var pageTitle = "�ʻ�ID��Ϣ��ѯ";
    //var fieldName = "�ʻ�ID|�ʻ�����|";
	//var selType = "S";    //'S'��ѡ��'M'��ѡ
    //var retQuence = "1|0|";
    //var retToField = "vConID|";
 

    document.all.vConID.value="";
	
    var pageTitle = "�ʻ�ID��Ϣ��ѯ";
    var fieldName = "�ʻ�ID|�ʻ�����|"; 
    var selType = "S";    //'S'��ѡ��'M'��ѡ
    var retQuence = "1|0|";
    var retToField = "vConID|";
    var sqlStr = "90000110";
    var params = formField.value+"|";
    PubSimpSel(pageTitle,fieldName,sqlStr,selType,retQuence,retToField,params);
	if(document.all.vConID.value == "")
	{	
		return false;
	}        
	document.all.qConMsg.disabled=false;
	document.all.vConPaswd.focus();
 }
 
 function f1211GetConID(formField){
   if(!checkElement(document.all.vCustID))
   {
	   formField.value = "";
	 formField.focus();
	 return null;
   }
    
	if(!checkElement(document.all.vCustPaswd))
	{
		document.all.vCustPaswd.value = "";
		document.all.vCustPaswd.focus();
		return null;
	}


		<%-- if("<%=pwrf%>" == "false")
		{ --%>
			var checkPwd_Packet = new AJAXPacket("pubCheckPwd1211.jsp","���ڽ�������У�飬���Ժ�......");
			checkPwd_Packet.data.add("custType","02");				//01:�ֻ����� 02 �ͻ�����У�� 03�ʻ�����У��
			checkPwd_Packet.data.add("phoneNo",document.all.vCustID.value);	//�ƶ�����,�ͻ�id,�ʻ�id
			checkPwd_Packet.data.add("custPaswd",document.all.vCustPaswd.value);//�û�/�ͻ�/�ʻ�����
			checkPwd_Packet.data.add("idType","en");				//en ����Ϊ���ģ�������� ����Ϊ����
			checkPwd_Packet.data.add("idNum","");					//����
			checkPwd_Packet.data.add("loginNo","<%=work_no%>");		//����
			core.ajax.sendPacket(checkPwd_Packet, doCheckPwd);
			checkPwd_Packet=null;
			
		/* } */
		
		if(scheckcustpass=="1") {
		 return false;
		}

			
	
	document.all.vConID.value="";
    var pageTitle = "�ʻ�ID��Ϣ��ѯ";
    var fieldName = "�ʻ�ID|�ʻ�����|"; 
    var selType = "S";    //'S'��ѡ��'M'��ѡ
    var retQuence = "1|0|";
    var retToField = "vConID|";

    var sqlStr = "90000109";
    var params = formField.value+"|";

    PubSimpSel(pageTitle,fieldName,sqlStr,selType,retQuence,retToField,params);

	if(document.all.vConID.value=="")
	{
		return null;
	}      
	document.all.qConMsg.disabled=false;
 }
 
 			function doCheckPwd(packet) {
				var retResult = packet.data.findValueByName("retResult");
				var msg = packet.data.findValueByName("msg");
				if (retResult != "000000") {
					rdShowMessageDialog(msg);
					scheckcustpass="1";
				}else {
				  scheckcustpass="0";
				}
			}
			
			
 function f1211CheckForm()
 {
     if(!checkElement(document.all.vConID))return false;
	 if(!checkElement(document.all.vAcountNum))return false;
	 if(!checkElement(document.all.vAcountName))return false;

	 if(document.all.vPostFlag.value == "Y")
	 {
		 if(document.all.vPostType.value == "0") //����
		 {
/*	2008��9��19�� Ӧ�г����������϶����ʵ���������
			if(!checkElement('vFaxNo')) return false;
*/	
		 }
		 else if(document.all.vPostType.value == "1") //�ʼ�
		 {
			if(!checkElement(document.all.vPostZip)) return false;
			if(!checkElement(document.all.vPostAddress)) return false;
		 }
		 else if(document.all.vPostType.value == "2")//�����ʼ�
		 {
			 if(!checkElement(document.all.vMailAddress)) return false;
			
		 }
	 }
	
	 if(document.all.vFaxNo.value == "")document.all.vFaxNo.value=" ";
	 if(document.all.vPostZip.value == "")document.all.vPostZip.value=" ";
	 if(document.all.vPostAddress.value == "")document.all.vPostAddress.value=" ";
	 if(document.all.vMailAddress.value == "")document.all.vMailAddress.value=" ";

	 if(!checkElement(document.all.vPayFee)) return false;
	 if(!checkElement(document.all.vRealFee)) return false;
	 
	 if(!checkElement(document.all.vNewPaswd)) return false;
	 if(document.all.vNewPaswd.value != document.all.vCfmPaswd.value)
	 {
		 rdShowMessageDialog("�������ȷ�����벻�ȣ����������룡");
		 return false;
	 }
	
	 return true;
 }

 function f1211Cfm()
 {   	 
	 getAfterPrompt();
	 document.all.f1211.action="f1211Cfm.jsp";
     document.all.f1211.submit();
	 return false;
 }
 function printCommit()
{          
	getAfterPrompt();
 	if(document.all.vQryType[3].checked) // zhangyan@��ԤԼID��ѯ
	{ 
		if (document.all.bookingId.value=="")
		{
			rdShowMessageDialog("ԤԼID������д!",0);	
			return false;
		}
	} 	
	if(!f1211CheckForm())  return false;
	
	if((document.all.vNewPaswd.value).trim().length>0)
	{
      if(document.all.vNewPaswd.value.length!=6)
	  {
         rdShowMessageDialog("���ʻ����볤������");
		 document.all.vNewPaswd.focus();
		 return false;
	  }
	}
/*  wangmei     add      20051105  */
	   
     if(document.all.f1211.vPayCode.options[document.all.f1211.vPayCode.selectedIndex].value=="4"){
	   if(document.all.f1211.vBankCode.value=="")
		 {rdShowMessageDialog("���д��벻��Ϊ�գ�");
		  document.all.vBankCode.focus();
		  return false;
	     }
	   if(document.all.f1211.vPostCode.value=="")
		 {rdShowMessageDialog("�ַ����д��벻��Ϊ�գ�");
		  document.all.vPostCode.focus();
		  return false;
	     }
	 }
	showPrtDlg("Detail","ȷʵҪ���е��������ӡ��","Yes"); 
	
	return true;
}

function showPrtDlg(printType,DlgMessage,submitCfm)
{  //��ʾ��ӡ�Ի��� 
	var h=180;
	var w=400;
	var t=screen.availHeight/2-h/2;
	var l=screen.availWidth/2-w/2;
	
	var phoneNo="";                                            //�ͻ��绰
	var pType="subprint";                                      // ��ӡ���ͣ�print ��ӡ subprint �ϲ���ӡ
	var billType="1";                                          // Ʊ�����ͣ�1���������2��Ʊ��3�վ�
	var sysAccept=<%=printAccept%>;                            // ��ˮ��
	var printStr=printInfo(printType);                         //����printinfo()���صĴ�ӡ����
	var mode_code=null;                                        //�ʷѴ���
	var fav_code=null;                                         //�ط�����
	var area_code=null;                                        //С������
	var opCode="<%=opCode%>";                                  //��������
	if(document.all.vPhoneNo)
		phoneNo=document.all.vPhoneNo.value;                   
	/* ningtn */
	var iccidInfoStr = $("#firstId").val() + "|" + $("#secondId").val();	
	var accInfoStr = $("#accInfoHid1").val() + "|" +$("#accInfoHid2").val()+ "|" +$("#accInfoHid3").val()+ "|" +$("#accInfoHid4").val();
	/* ningtn */
	var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no";
	var path = "<%=request.getContextPath()%>/npage/innet/hljBillPrint_jc_hw.jsp?DlgMsg=" + DlgMessage+ "&submitCfm=" + submitCfm+ "&iccidInfo=" + iccidInfoStr + "&accInfoStr="+accInfoStr;
	path=path+"&mode_code="+mode_code+"&fav_code="+fav_code+"&area_code="+area_code+"&opCode=<%=opCode%>&sysAccept="+sysAccept+"&phoneNo="+phoneNo+"&submitCfm="+submitCfm+"&pType="+pType+"&billType="+billType+ "&printInfo=" + printStr;
	var ret=window.showModalDialog(path,printStr,prop);
	
	if(typeof(ret)!="undefined")
	{
		if((ret=="confirm")&&(submitCfm == "Yes"))
		{
			 if(rdShowConfirmDialog('ȷ�ϵ��������')==1)
			 {
			   f1211Cfm();
			 }
		}
		if(ret=="continueSub")
		{
			 if(rdShowConfirmDialog('ȷ��Ҫ�ύ�ʻ������Ϣ��')==1)
			 {
			   f1211Cfm();
			 }
		}
		else
		{
			 if(rdShowConfirmDialog('ȷ��Ҫ�ύ�ʻ������Ϣ��')==1)
			 {
			   	f1211Cfm();
			 }
		}
	}
}

function printInfo(printType)
{
	var bank_name = "";
	var post_bank_name = "";
	if(document.all.f1211.vBankCode.selectedIndex=="-1"){
		bank_name = "��";
	}else{ 
	  	bank_name = document.all.f1211.vBankCode.options[document.all.f1211.vBankCode.selectedIndex].text;
	}
	if(document.all.f1211.vPostCode.selectedIndex=="-1"){
	 	post_bank_name="��";
	}else{
	 	post_bank_name = document.all.f1211.vPostCode.options[document.all.f1211.vPostCode.selectedIndex].text;
	}
	var paytype = document.all.f1211.vPayCode.options[document.all.f1211.vPayCode.selectedIndex].text;
	
	var cust_info="";  	
	var opr_info="";   	
	var note_info1=""; 	
	var note_info2=""; 	
	var note_info3=""; 	
	var note_info4=""; 	
	var retInfo = "";  	
	
	cust_info+="֤�����룺"+document.all.vCertNum.value+"|";
	
	opr_info+="�ͻ���ַ��"+document.all.vPostAddress.value+"|";
	opr_info+="�ʻ����ƣ�"+document.all.vAcountName.value+"|";
	opr_info+="�ʻ� ID��"+document.all.vConID.value+"|";
	
	opr_info+="����ҵ��"+"�ʻ����ϱ��"+"  ������ˮ��"+"<%=printAccept%>"+"|";
	opr_info+="�ʻ�ԭ���ϣ�"+"���д������ƣ�"+document.all.bank_name.value+"  �ַ����д������ƣ�"+document.all.post_name.value+"|";
	opr_info+="�ʻ�ID��"+document.all.vConID.value+"  �ʻ����ƣ�"+document.all.oldvAcountName.value+"  ���ѷ�ʽ��"+document.all.pay_name.value+"|";
	opr_info+="�ʻ������ϣ�"+"���д������ƣ�"+bank_name+"|";
	opr_info+="�ַ����д������ƣ�"+post_bank_name+"|"; 
	opr_info+="�ʻ�ID��"+document.all.vConID.value+"  �ʻ����ƣ�"+document.all.vAcountName.value+"  ���ѷ�ʽ��"+paytype+"|";
	
	note_info1+="��ע��"+"|";
	
	retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
	retInfo=retInfo.replace(new RegExp("#","gm"),"%23"); 
	return retInfo;	
}
 // �����Ѽ��
 function getFew()
{
  if(window.event.keyCode==13)
  {
    var fee=document.all.vPayFee;
    var fact=document.all.vRealFee;
    var few=document.all.vPayChange;
    if((fact.value).trim().length==0)
    {
	  rdShowMessageDialog("ʵ�ս���Ϊ�գ�");	
	  fact.value="";
	  fact.focus();
	  return;
    }
    if(parseFloat(fact.value)<parseFloat(fee.value))
    {
  	  rdShowMessageDialog("ʵ�ս��㣡");	
	  fact.value="";
	  fact.focus();
	  return;
    }  

	var tem1=((parseFloat(fact.value)-parseFloat(fee.value))*100+0.5).toString();
	var tem2=tem1;
	if(tem1.indexOf(".")!=-1) tem2=tem1.substring(0,tem1.indexOf("."));
    few.value=(tem2/100).toString();
    few.focus();
  }
}
 function f1211Init()
 {
    document.all.idCert.style.display="none";
	document.all.idCust.style.display="none";
	//document.all.idPhoneCust.style.display="none";
	
 }
 /*
    ����1(pageTitle)����ѯҳ�����
    ����2(fieldName)�����������ƣ���'|'�ָ��Ĵ�
    ����3(sqlStr)��sql���
    ����4(selType)������1 rediobutton 2 checkbox
    ����5(retQuence)����������Ϣ������������� �������ʶ����'|'�ָ�����"3|0|2|3"��ʾ����3����0��2��3
    ����6(retToField))������ֵ����������,��'|'�ָ�
*/
function PubSimpSel(pageTitle,fieldName,sqlStr,selType,retQuence,retToField,params)
{   //������ѯ 
    var path = "<%=request.getContextPath()%>/npage/public/fPubSimpSel.jsp";
    path = path + "?sqlStr=" + sqlStr + "&retQuence=" + retQuence;
    path = path + "&fieldName=" + fieldName + "&pageTitle=" + pageTitle;
    path = path + "&selType=" + selType+ "&params=" + params;  
    retInfo = window.showModalDialog(path);
    if(typeof(retInfo)=="undefined")    
    {   return false;   }
    var chPos_field = retToField.indexOf("|");
    var chPos_retStr;
    var valueStr;
    var obj;
    //alert(retInfo);
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
function chgContype()
{
	if(document.f1211.billOrder.value == "99999999"){
	document.all.wm_counttype.value = "1";
	}
}
function chgpaytype()
{
	if(document.f1211.billOrder.value =="99999999"){
		document.f1211.wm_paytype.value = "1";	
	}
	if(document.all.vCountType.value!="1"){
		 rdShowMessageDialog("�Ǽ����ʻ���������и��ѷ�ʽ�޸ģ�");
		 document.all.b_print.disabled=true;
		 return false;
	}
}
/*zhangyan@add@��ԤԼ��Ϣ b*/
function getBooingInfo()
{
	if(((document.all.bookingId.value).trim()).length<1)
	{
		rdShowMessageDialog("ԤԼID����Ϊ�գ�");
		return;
	}		
	var myPacket = new AJAXPacket("queryBookingId.jsp","���ڲ�ѯ�ͻ�ID�����Ժ�......");
	myPacket.data.add("bookingId",(document.all.bookingId.value).trim());
	core.ajax.sendPacket(myPacket);
	myPacket = null;	
}
/*zhangyan@add@��ԤԼ��Ϣ e*/	
</script>
<body>
<form name="f1211" method="post" action=""  onKeyUp="chgFocus(f1211);">
	<%@ include file="/npage/include/header.jsp" %>   
  	
		<div class="title">
			<div id="title_zi">�ͻ���Ϣ</div>
		</div>
		
	<table cellspacing="0">
		<tr> 
			<td class="blue">��ѯ����</td>
			<td colspan="3"> 
			<input type="radio" name="vQryType" value="0" onClick="f1211.reset();this.checked=true; f1211CheckID()">�ʻ� 
			<input type="radio" name="vQryType" value="1" onClick="f1211.reset();this.checked=true; f1211CheckID()" >֤�� 
			<input type="radio" name="vQryType" value="3" onClick="f1211.reset();this.checked=true; f1211CheckID()" checked >�������
			<input type="radio" name="vQryType" value="4" 
				onClick="f1211.reset();this.checked=true; f1211CheckID()" checked >ԤԼID
			</td>
		</tr>
		<tr id="idCert"> 
			<td class="blue">֤������</td>
			<td> 
				<select name="vCertType" index="0">
				</select>
			</td>
			<td class="blue">֤������</td>
			<td> 
				<input name="vCertNum" type="text"  v_type="string" index="1" onkeyup="if(event.keyCode==13)f1211GetCustID(vCertNum)">
				<input type="button" class="b_text" name="qCustID" value="��ѯ�ͻ�ID" onClick="f1211GetCustID(vCertNum)">
			</td>
		</tr>
		<tr id="tr_bookingInfo" style.display="none">
			<td class="blue">ԤԼID</td>
			<td colspan="3"> 
			    <input id= "bookingId" name="bookingId" type="text" v_type="">
			    <font class="orange">*</font>
			    <input type="button" class="b_text" name="getBooking" value="��ѯԤԼID"
			    	onclick="getBooingInfo()">
			</td>
		</tr>
		<tr id="idPhoneCust"> 
			<td class="blue">�������</td>
			<td> 
			    <input name="vPhoneNo" type="text" v_type="int" index="2">
			</td>
			<td class="blue">��������</td>
			<td> 
			    <input name="vPhonePaswd" type="password" v_type="0_9"  v_must="0" index="3" onkeyup="if(event.keyCode==13)f1211GetByPhone(vPhoneNo)">
			    <input type="button" class="b_text" name="qCustIdByPhone" value="��ѯ�ͻ�ID" onClick="f1211GetByPhone(vPhoneNo)">
			</td>
		</tr>
		<tr id="idCust" style="display:none"> 
			<td class="blue">�ͻ�ID</td>
			<td> 
			  <input name="vCustID" type="text" v_type="int" index="4">
			</td>
			<td class="blue">�ͻ�����</td>
			<td> 
			  <input name="vCustPaswd" type="password" v_type="0_9" v_must="0" index="5" onkeyup="if(event.keyCode==13)f1211GetConID(vCustID)">
			  <input type="button" class="b_text" name="qConID" value="��ѯ�ʻ�ID" onClick="f1211GetConID(vCustID)">
			</td>
		</tr>
		<tr> 
			<td class="blue">�ʻ� ID</td>
			<td> 
			  <input name="vConID" type="text"  v_must="1" v_type="int" index="6">
			</td>
			<td class="blue">�ʻ�����</div>
			</td>
			<td> 
			  <input name="vConPaswd" type="password" v_type="0_9"  v_must="0" index="7" onkeyup="if(event.keyCode==13)f1211GetConMsg(vConID)">
			  <input type="button" class="b_text" name="qConMsg" value="��ѯ�ʻ���Ϣ" onClick="f1211GetConMsg(vConID)">
			</td>
		</tr>
	</table>
</div>

<div id="Operation_Table"> 
<div class="title">
	<div id="title_zi">�˻���Ϣ</div>
</div>
	<table cellspacing="0">
		<tr> 
			<td class="blue">��ͻ���־</td>
			<td> 
			    <input type="text" class="InputGrey orange" name="vCardName" readonly>
			</td>
			<td class="blue">���ű�־</td>
			<td> 
			    <input type="text" name="vGrpName" class="InputGrey" readonly>
			</td>
		</tr>
		<tr> 
			<td class="blue">�ʻ���ͷ</td>
			<td> 
			    <input type="text" name="vCountHead" class="InputGrey" readonly>
			</td>
			<td class="blue">�ʻ�������</td>
			<td> 
			    <input type="text"  name="vCountGrand" class="InputGrey" readonly>
			</td>
		</tr>
		<tr> 
			<td class="blue">�ʻ�Ԥ��</td>
			<td> 
			  <input type="text" name="vPrePay" class="InputGrey" readonly>
			</td>
			<td class="blue">Ѻ ��</td>
			<td> 
			  <input type="text" name="vDeposit" class="InputGrey" readonly>
			</td>
		</tr>
		<tr> 
			<td class="blue">��СǷ������</td>
			<td> 
			    <input type="text" name="vMinYearMonth" class="InputGrey" readonly>
			</td>
			<td class="blue">Ƿ ��</td>
			<td> 
			    <input type="text" name="vOweFee" class="InputGrey" readonly>
			</td>
		</tr>
		<tr> 
			<td class="blue">�� ��</td>
			<td colspan="3"> 
			    <input type="text" name="vMark" class="InputGrey" readonly>
			</td>
		</tr>
	</table>
</div>

<div id="Operation_Table"> 
<div class="title">
	<div id="title_zi">������Ϣ</div>
</div>
	<table cellspacing="0">
		<tr> 
			<td class="blue">���д�������</td>
			<td colspan="3"> 
			    <select name="vBankCode" index="8" >
			    </select>
			</td>
		</tr>
		<tr>
			<td class="blue">�ַ����д�������</td>
			<td colspan="3"> 
			    <select name="vPostCode" index="9">
			    </select>
			</td>
		</tr>
		<tr> 
			<td class="blue">�� ��</td>
			<td> 
			    <input name="vAcountNum" type="text" v_type="string" index="10">
			    <font class="orange">*</font>
			</td>
			<td class="blue">�ʻ�����</td>
			<td> 
			    <input name="vAcountName" type="text" v_must="1" v_type="string" index="11">
			    <font color="orange">*</font>
			</td>
		</tr>
		<tr> 
			<td class="blue">�ʻ�����</td>
			<td> 
			    <select name="vCountType" onchange="chgContype()" index="12" disabled>
			    </select>
			</td>
			<td class="blue">�ʻ�״̬</td>
			<td> 
			    <select name="vCountStatus" index="13">
			    </select>
			</td>
		</tr>
		<tr> 
			<td class="blue">�ʼı�־</td>
			<td> 
			    <select name="vPostFlag" class="button" index="14">
				    <option value="N">��</option>
				    <option value="Y">��</option> 
			  	</select>
			</td>
			<td class="blue">�ʼķ�ʽ</td>
			<td> 
				<select name="vPostType" index="15">
				</select>
			</td>
		</tr>
		<tr> 
			<td class="blue">�� ��</td>
			<td> 
			    <input name="vPostZip" type="text" v_must="1" v_type="zip" index="16">
			</td>
			<td class="blue">�ʼĵ�ַ</td>
			<td> 
			  <input type="text" v_must="1" v_type="string" name="vPostAddress" index="17">
			</td>
		</tr>
		<tr> 
			<td class="blue">�����</td>
			<td> 
			  <input type="text" name="vFaxNo" v_must="1"  v_type="phone" index="18">
			</td>
			<td class="blue">E_Mail��ַ</td>
			<td> 
			  <input type="text"  id="vMailAddress"  name="vMailAddress" v_must="1" v_type="email" index="19">
			</td>
		</tr>
		<tr> 
			<td class="blue">���ʽ</td>
			<td colspan="3"> 
			    <select name="vPayCode" class="button" onchange="chgpaytype()" index="20">
			    </select>
			</td>
		</tr>
		<tr> 
			<td class="blue">ͬʱ���¿ͻ���������</td>
			<td colspan="3"> 
				<input type="radio" name="vDocFlag" value="0" checked>��
				<input type="radio" name="vDocFlag" value="1">��
			</td>
		</tr>
		<tr style="display:none"> 
			<td class="blue">���ʻ�����</td>
			<td> 
			    <input name="vNewPaswd" v_type="0_9"  type="password" index="21" v_maxlength=6 v_must=0>
			</td>
			<td class="blue">ȷ������</td>
			<td> 
			    <input name="vCfmPaswd"  v_must=0 v_type="0_9"  type="password" index="22" v_maxlength=6>
			</td>
		</tr>
	
		<tr> 
			<td class="blue">������</td>
			<td> 
			    <input name="vPayFee" type="text" value="<%=tmpHandFee%>"  v_minlength="1" v_maxlength="12" v_must=1 v_type="cfloat" index="23" size="20">
			</td>
			<td class="blue"> 
				<div align="left">ʵ�� 
					<input name="vRealFee" type="text"  onKeyUp="getFew()" index="24">
				</div>
			</td>
			<td class="blue">
				<div align="left">���� 
					<input name="vPayChange" type="text" value="0" class="InputGrey" readonly>
				</div>
			</td>
		</tr>
		<tr> 
			<td class="blue">��ע</td>
			<td colspan="3"> 
			    <input name="vSysNote" type="text" size="40" class="InputGrey" readonly>
			</td>
		</tr>
	</table>
	<!-- ningtn 2011-8-4 10:28:18 ������ӹ��� -->
<jsp:include page="/npage/public/hwReadCustCard.jsp">
	<jsp:param name="hwAccept" value="<%=printAccept%>"  />
	<jsp:param name="showBody" value="01"  />
	<jsp:param name="sopcode" value="<%=opCode%>"  />
</jsp:include>
	<table>
		<tr> 
			<td id="footer" colspan="4"> 
				<div align="center"> 
					<input class="b_foot" type="button" name="b_print" value="ȷ��&��ӡ"  
						onClick="printCommit()" index="26">
					<input class="b_foot" type="button"  name="b_clear" value="���" index="27" onclick="f1211.reset();">
					<input class="b_foot" type="button" name="b_back" value="����"  onClick="removeCurrentTab()" index="28">
				</div>
			</td>
		</tr>
	</table>
<input type="hidden" name="billOrder" value="">
<input type="hidden" name="wm_counttype" value="0">
<input type="hidden" name="wm_paytype" value="0">
<input type="hidden" name="paycode" value="">
<input type="hidden" name="tmpPaswd" value="">
<input type="hidden" name="vWorkNo" value="<%=work_no%>">
<input type="hidden" name="vOrgCode" value="<%=org_code%>">
<input type="hidden" name="vIpAddress" value="<%=sIpAddress%>">
<input type="hidden" name="vWorkPaswd" value="<%=nopass%>">
<input type="hidden" name="vHandFee" value="<%=tmpHandFee%>">
<input type="hidden" name="oldvAcountName" value="">
<input type="hidden" name="bank_name" value="">
<input type="hidden" name="post_name" value="">
<input type="hidden" name="pay_name" value="">
<input type="hidden" name="opName" value="<%=opName%>">
<input type="hidden" name="opCode" value="<%=opCode%>">
<input type="hidden" name="printAccept" value="<%=printAccept%>">
<%@ include file="../../include/remark.htm" %>
<%@ include file="/npage/include/footer.jsp" %>  
</form>
	  
</BODY>
<!-- ningtn 2011-7-12 08:35:36 ���ӻ���������Χ -->
<%@ include file="/npage/public/hwObject.jsp" %> 
<script language="JavaScript">
	function fillSelect()
	{		
<% 
	  //�����޸���-------------------
	  int selObj_num=7;
	  String[] selObj={"vCertType","vbankCode","vPostCode","vPostType","vCountType","vPayCode","vCountStatus"};
			//-------------------------
					//System.out.println("111111111111111111111");
		for(int p=0;p<selObj_num;p++)
		{
%>
  	 		 document.all("<%=selObj[p]%>").options.length=<%=metaData[p].length%>;
	  	
<%
			 for(int i=0;i<metaData[p].length;i++)
		     {
%>
    		   document.all("<%=selObj[p]%>").options[<%=i%>].text='<%=WtcUtil.getOneTok(metaData[p][i],"#",2)%>';                                                      
    		   document.all("<%=selObj[p]%>").options[<%=i%>].value='<%=WtcUtil.getOneTok(metaData[p][i],"#",1)%>';
			 <%
			  }
		}
%>
	}
</script>
</HTML>

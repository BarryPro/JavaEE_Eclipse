<!DOCTYPE html PUBLIC "-//W3C//Dtd Xhtml 1.0 transitional//EN" "http://www.w3.org/tr/xhtml1/Dtd/xhtml1-transitional.dtd">
<%
  /*
   * ����: �˻������޸�
   * �汾: 1.0
   * ����: 2009/1/19
   * ����: leimd
   * ��Ȩ: si-tech
   * update:
  */
%>
<%@	page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="com.sitech.boss.pub.util.*" %>
<%@ include file="../../npage/common/pwd_comm.jsp" %>
<%
		response.setHeader("Pragma","No-cache");
		response.setHeader("Cache-Control","no-cache");
		response.setDateHeader("Expires", 0);
%>
<%
  request.setCharacterEncoding("GBK");
%>

<%
	String opCode = (String)request.getParameter("opCode");			//��������
	String opName = (String)request.getParameter("opName");			//������
	String dWorkNo = (String)session.getAttribute("workNo");		//��������
	String nopass = (String)session.getAttribute("password");		//��������
	String sIpAddress = (String)session.getAttribute("ipAddr");		//��¼IP
	String org_code = (String)session.getAttribute("orgCode");		//��������
	String region_code = (String)session.getAttribute("regCode");	//����
	String regionCode = region_code;
	String district_code = org_code.substring(2,4);
	String[][] favInfo = (String[][])session.getAttribute("favInfo");//�Ż���Ϣ
	int favFlag = 0 ;
	
	//2011/6/23 wanghfa��� ������Ȩ������ start
  boolean pwrf=false;
	String pubOpCode = opCode;
	String pubWorkNo = dWorkNo;
%>
	<%@ include file="/npage/public/pubCheckPwdPower.jsp" %>
<%
	System.out.println("====wanghfa====f1232.jsp==== gaopengSeeLog---pwrf = " + pwrf);
	if (pwrf) {
		favFlag = 1;
	}else{
		favFlag=0;
	}
	favFlag=0;
	
	//2011/6/23 wanghfa��� ������Ȩ������ end

	String op_code = "1232";
%>
<%
/** �ж�4A�ܿ��أ�������Ϊ��ʱ������4A��������Ϊ��ʱ������������� 
	*		0��û�����ǹ� �� 1�ǿ�
	**/
	int switchFlag = 0;
	int goldFlag=0;
	boolean goldFlagA = false;
	
	String inParamsSwitchFlag [] = new String[2];
	inParamsSwitchFlag[0] = "SELECT TO_NUMBER(FLAG_SWITCH) FROM ssystemParameter WHERE LOGIN_NO =:loginNo and op_code =:opCode ";
	inParamsSwitchFlag[1] = "loginNo=switch,opCode=e269";
	
	String inParamsGoldFlag [] = new String[2];
	inParamsGoldFlag[0] = "SELECT TO_NUMBER(FLAG_SWITCH) FROM ssystemParameter WHERE LOGIN_NO =:loginNo and op_code =:opCode ";
	inParamsGoldFlag[1] = "loginNo=switch,opCode=e768";
	
	%>
		<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode_region" retmsg="retMessage_region" outnum="1"> 
	    <wtc:param value="<%=inParamsSwitchFlag[0]%>"/>
	    <wtc:param value="<%=inParamsSwitchFlag[1]%>"/> 
	  </wtc:service>  
	  <wtc:array id="resultSwitchFlag"  scope="end"/>
	  	
	  <wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode_region2" retmsg="retMessage_region2" outnum="1"> 
	    <wtc:param value="<%=inParamsSwitchFlag[0]%>"/>
	    <wtc:param value="<%=inParamsSwitchFlag[1]%>"/> 
	  </wtc:service>  
	  <wtc:array id="resultGoldFlag"  scope="end"/>
	<%	
	
	if("000000".equals(retCode_region) && resultSwitchFlag.length > 0){
		switchFlag = Integer.parseInt(resultSwitchFlag[0][0]);
	}else{
		%>
		<script language="javascript">
			rdShowMessageDialog("��ѯ��⿪�س���!",1);
			removeCurrentTab();
		</script>
		<%
	}
	if("000000".equals(retCode_region2) && resultGoldFlag.length > 0){
		goldFlag=Integer.parseInt( resultGoldFlag[0][0] );
	}else{
		%>
		<script language="javascript">
			rdShowMessageDialog("��ѯ��⿪�س���!",1);
			removeCurrentTab();
		</script>
		<%
	}
	

if("000000".equals(retCode_region2) && resultGoldFlag.length > 0  &&  "000000".equals(retCode_region) && resultSwitchFlag.length > 0  ){
	switchFlag = Integer.parseInt(resultSwitchFlag[0][0]);
	goldFlag=Integer.parseInt( resultGoldFlag[0][0] );

	/*Ĭ�ϸ�ֵΪ1*/
	//switchFlag = 1;
	//goldFlag = 1;
	
	if(switchFlag == 1 && goldFlag == 1){
		goldFlagA = true;
	}else{
		goldFlagA = false;
	}
	System.out.println("~~~~~gaopengSee4ALog~~~~~switchFlag~~~~~~~~~~~~~~~~~~~"+switchFlag);
	System.out.println("~~~~~gaopengSee4ALog~~~~~goldFlag~~~~~~~~~~~~~~~~~~~"+goldFlag);
}
%>
<%
	StringBuffer sqlBuffer = new StringBuffer("");
	sqlBuffer.append("SELECT id_Name FROM sIdType order by id_type;");
	sqlBuffer.append("SELECT trim(bank_code)||'#'||trim(bank_name) from sBankCode where   region_code='");
	sqlBuffer.append(region_code+"' ");
	sqlBuffer.append(" and district_code = '" + district_code + "';");
	sqlBuffer.append("SELECT trim(post_bank_code)||'#'||trim(post_name) from sPostCode where region_code='");
	sqlBuffer.append(region_code+ "';");
	sqlBuffer.append("SELECT trim(post_type)||'#'||trim(post_name) from sPostType;");
	sqlBuffer.append("SELECT trim(pay_code)||'#'||trim(pay_name) from sPayCode where region_code = '");
	sqlBuffer.append(region_code+ "';");
	sqlBuffer.append("SELECT trim(status_code)||'#'||trim(status_name) from sConStatusCode");
	String sqls = sqlBuffer.toString();
	System.out.println(sqls);
//	SPubCallSvrImpl implSel=new SPubCallSvrImpl();
//	String[][] metaData=implSel.fillSelect(sqlBuffer.toString());
%>
	<wtc:mutilselect  name="sPubMultiSel"  routerKey="region" routerValue="<%=region_code%>"  id="metaData" type="array"  retcode="retCode" retmsg="retMsg">
		<wtc:sql><%=sqls%></wtc:sql>
	</wtc:mutilselect>
<%
	System.out.println("metaData==="+metaData.length);
	String sqlStr = "SELECT hand_fee ,favour_code from sNewFunctionFee where region_code='" + region_code +"' and function_code='"+ op_code+"'";
	
	
//	ArrayList tmpSelList = implSel.sPubSelect("2",sqlStr);
%>
	<wtc:pubselect name="sPubSelect"  routerKey="region" routerValue="<%=region_code%>" outnum="2" retcode="handFeeCode" retmsg="handFeeMsg">
		<wtc:sql><%=sqlStr%></wtc:sql>
	</wtc:pubselect>
	<wtc:array id="tmd0" scope="end" />
<%
	String tmpHandFee = "0";
	int feeFlag = 0;
//	String[][] tmd0 = (String[][])tmpSelList.get(0);
	if(tmd0.length==0){
		tmpHandFee = "0";
		feeFlag = 0;
	}
	else{
		tmpHandFee=tmd0[0][0];
		for(int i = 0 ; i < favInfo.length ; i ++){
			if(favInfo[i][0].trim().equals(tmd0[0][1])){
				feeFlag = 1;
				//�������Ѳ������Ż�Ȩ��
				}
			}
		}
	
   
%>
<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="region" routerValue="<%=region_code%>"  id="seq"/>
<html xmlns="http://www.w3.org/1999/xhtml">
	<HEAD>
<TITLE>�ʻ������޸�</TITLE>
<META content=no-cache http-equiv=Pragma>
<META content=no-cache http-equiv=Cache-Control>
<META content="MSHTML 5.00.3315.2870" name=GENERATOR>
</HEAD>
<script language="javascript">
  var printFlag=9;
  onload=function()
  {  
		self.status="";
		document.all.vQryType[0].focus();
		fillSelect();
		
		
  }

  //---ͨ��RPC������-��ȡ�ʻ���Ϣ��Ϣ------
  function doProcess(packet)
  {        
	  var rpc_page=packet.data.findValueByName("rpc_page");
	  if(rpc_page=="1"){
	  	var loginAccept = packet.data.findValueByName("loginAccept");
		var errMsg = packet.data.findValueByName("errMsg");
		var errCode = packet.data.findValueByName("errCode"); 
		var errCodeInt = parseInt(errCode,10);
		
		rdShowMessageDialog(errMsg);
		if(errCodeInt==0){
			document.f1211.backLoginAccept.value=loginAccept;
			
			if(document.f1211.vPayFee.value!=0){
				printBill();

			}else{
				//window.location="f1232.jsp";
				removeCurrentTab();
			}
		}else{
			//document.f1211.submit.disabled=true; 
			removeCurrentTab();
		}
		
		
	  }
	  if(rpc_page=="f1211ConMsg")
	  {
	  	
	    var triListData = packet.data.findValueByName("ConMsg"); 
		var vConPaswdFlag = packet.data.findValueByName("vConPaswdFlag");
		if(triListData.length != 1)
		{
		   rdShowMessageDialog("���ʻ�ID��Ϣ�����ڣ�");
		   document.all.qConMsg.disabled=false;

		   
		   return ;
		}
		if(vConPaswdFlag != 0)
		{
		   rdShowMessageDialog("�ʻ������������������!");
		   document.all.vConPaswd.value="";
		   document.all.qConMsg.disabled = false;
		   document.all.vConPaswd.disabled = false;
		   return ;
		}

				 
		if(triListData[0].length == 15)
		{
			document.all.vConPaswd.value=triListData[0][0];
		document.all.vAcountName.value = triListData[0][1]; //�ʻ�����
		
		 document.all.vCountHead.value = triListData[0][2];   //�ʻ���ͷ
		 
		 document.all.vPrePay.value = triListData[0][3];    //prepay_fee
		 
		 document.all.vDeposit.value = triListData[0][4]; //Ѻ��
		 
		 document.all.vMinYearMonth.value = (triListData[0][5]).substr(0,4)+"��"+(triListData[0][5]).substr(4,2)+"��";//��СǷ������
		 
		 document.all.vOweFee.value = triListData[0][6];    //Ƿ��
		 
		 document.all.vMark.value = triListData[0][7];  //����
		 
		 document.all.vCountGrand.value = triListData[0][8]; //�ʻ�������
		 
		 document.all.vPayCode.value = triListData[0][9];  //���ʽ
		 
		 document.all.vBankCode.value = triListData[0][10]; //bank_code
		 
		 document.all.vPostCode.value = triListData[0][11]; //post_bank_code
		 
		 document.all.vAcountNum.value = triListData[0][12]; //account_no
		 
		 document.all.vCountType.value = triListData[0][13];  //account_type
		 
		 document.all.vCountStatus.value = triListData[0][14];  //account_status
		 
		 


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
			var grpName = packet.data.findValueByName("grpName");
			var cardName = packet.data.findValueByName("cardName");
			document.all.vGrpName.value = grpName;
			document.all.vCardName.value = cardName;
		}

		document.all.submit.disabled=false;

		document.all.vConID.readonly = true;

			if(document.f1211.passOpType.value == '1'){
				document.all.vSysNote.value="����"+document.all.vConID.value + "�ʻ���Ϣ";
			}
			else if(document.f1211.passOpType.value == '0'){
				document.all.vSysNote.value="�޸�"+document.all.vConID.value + "�ʻ���Ϣ"
			}


		window.status="";
		
	  }
   }
  
  function checkIfPayCode4(){
  	var vConID =  $.trim(document.all.vConID.value);
  	var checkPwd_Packet = new AJAXPacket("/npage/s1232/f1232CheckPayCode.jsp","���ڽ�������У�飬���Ժ�......");
		checkPwd_Packet.data.add("vConID",vConID);		//����
		core.ajax.sendPacket(checkPwd_Packet, doCheckPay);
		checkPwd_Packet=null;
  }
  function doCheckPay(packet){
  	var retCode = packet.data.findValueByName("retcode");
		var retMsg = packet.data.findValueByName("retmsg");
		var mycount = packet.data.findValueByName("mycount");
		if (retCode == "000000") {
			/*������ֵ*/
			$("#myCount").val(mycount);
		}else{
			
			rdShowMessageDialog("������룺"+retCode+",������Ϣ��"+retMsg,1);
			return false;
		}
		
  }
  
  function ajaxQueryOfferTraffic() {
    var vConID =  $.trim(document.all.vConID.value);
		var funtionnames_Packet = new AJAXPacket("queryKZCHCon.jsp","���ڲ�ѯ�����Ժ�......");
		funtionnames_Packet.data.add("contractno",vConID);
		core.ajax.sendPacket(funtionnames_Packet,doreturnFunctions);
		funtionnames_Packet=null;
  }

  function doreturnFunctions(packet) {
    var queryCount = packet.data.findValueByName("queryCount");
    $("#offerTrafficflag").val(queryCount);
  }
  
  
  var formFieldOut = "";
	function f1211GetConMsg(formField)
	{
		/*����У���Ƿ������ʻ�*/
		if($("#passOpType").val() == "1"){//��������
			checkIfPayCode4();
			ajaxQueryOfferTraffic();
			var myCount = $("#myCount").val();
			var offerTrafficflag = $("#offerTrafficflag").val();
			/*�������˻���У����*/
			if(myCount != "0" || offerTrafficflag != "0"){
				var flag4A = allCheck4A("1233");
				if(!flag4A){
					return false;
				}
			}
		}
		
		
		formFieldOut = formField;
		if(!checkElement(document.all.vConID))
		{
			formField.value = "";
			formField.focus();
			return ;
		
		}
	 
		document.all.tmpPaswd.value = document.all.vConPaswd.value; 
		document.all.qConMsg.disabled = true;
		document.all.vConPaswd.disabled = true;
		//2010-8-20 15:51 wanghfa�޸� ������֤�޸� start
		/*2015/5/12 9:42:10 gaopeng 
			����������˻� ���ҽ�⿪��Ϊ�� ����Ҫ��������
		*/
		if(("<%=goldFlagA%>" == "true" && (myCount != "0" || offerTrafficflag != "0") && $("#passOpType").val() == "1") ){
			var myPacket = new AJAXPacket("f1211ConMsg.jsp","���ڻ���ʻ���Ϣ�����Ժ�......");
	
			//�����������
			myPacket.data.add("pContractNo",formFieldOut.value);
			myPacket.data.add("vConPaswd",document.all.vConPaswd.value);
			
			core.ajax.sendPacket(myPacket);
			
			myPacket=null;
		}
		else if("<%=favFlag%>" == "1"){
			var myPacket = new AJAXPacket("f1211ConMsg.jsp","���ڻ���ʻ���Ϣ�����Ժ�......");
			
			//�����������
			myPacket.data.add("pContractNo",formFieldOut.value);
			myPacket.data.add("vConPaswd",document.all.vConPaswd.value);
			
			core.ajax.sendPacket(myPacket);
			
			myPacket=null;
		}
		/*���û������Ȩ��*/
		else{
			
			if(document.all.vConPaswd.value.length==0){
				rdShowMessageDialog("���������룡");
				document.all.vConPaswd.disabled=false;
				document.all.qConMsg.disabled=false;
				return;
			}
		 
			var checkPwd_Packet = new AJAXPacket("/npage/public/pubCheckPwd.jsp","���ڽ�������У�飬���Ժ�......");
			checkPwd_Packet.data.add("custType","03");				//01:�ֻ����� 02 �ͻ�����У�� 03�ʻ�����У��
			checkPwd_Packet.data.add("phoneNo",document.all.vConID.value);	//�ƶ�����,�ͻ�id,�ʻ�id
			checkPwd_Packet.data.add("custPaswd",document.all.vConPaswd.value);//�û�/�ͻ�/�ʻ�����
			checkPwd_Packet.data.add("idType","un");				//en ����Ϊ���ģ�������� ����Ϊ����
			checkPwd_Packet.data.add("idNum","");					//����
			checkPwd_Packet.data.add("loginNo","<%=dWorkNo%>");		//����
			core.ajax.sendPacket(checkPwd_Packet, doCheckPwd);
			checkPwd_Packet=null;
		}
	}

	function doCheckPwd(packet) {
		var retResult = packet.data.findValueByName("retResult");
		var msg = packet.data.findValueByName("msg");
		if (retResult != "000000") {
			rdShowMessageDialog(msg);
			document.all.vConPaswd.value="";
			document.all.qConMsg.disabled = false;
			document.all.vConPaswd.disabled = false;
			return;
		}
		
		//var myPacket = new AJAXPacket("f1211ConMsg1.jsp","���ڻ���ʻ���Ϣ�����Ժ�......");

		var myPacket = new AJAXPacket("f1211ConMsg.jsp","���ڻ���ʻ���Ϣ�����Ժ�......");

		//�����������
		myPacket.data.add("pContractNo",formFieldOut.value);
		myPacket.data.add("vConPaswd",document.all.vConPaswd.value);
		
		core.ajax.sendPacket(myPacket);
		
		myPacket=null;
	}
//2010-8-20 15:51 wanghfa�޸� ������֤�޸� end

  function f1211CheckID()
  {
        document.all.vConID.disabled = false;
        if(document.all.vQryType[0].checked) // �����ʻ���ѯ
	{  
	   document.all.idCert.style.display="none";
	   document.all.idCust.style.display="none";
	   document.all.vConID.value="";
	   document.all.vConPaswd.value="";
	   document.all.qConMsg.disabled=false;
	   document.all.vCountGrand.value="";
	   document.all.vDeposit.value="";
	   document.all.vCountHead.value="";
	   document.all.vMinYearMonth.value="";
	   document.all.vAcountName.value="";
	   document.all.vOweFee.value="";
	   document.all.vSysNote.value="";
	   document.all.vConPaswd.disabled = false;
	   document.all.vPrePay.value="";
	  
	   document.all.vConID.focus();
	}
	
	if(document.all.vQryType[1].checked) // ����֤����ѯ
	{ 
	   document.all.idCert.style.display="";
	   document.all.idCust.style.display="";
	   document.all.vCertNum.value="";
	   document.all.vPrePay.value="";
	   document.all.vDeposit.value="";
	   document.all.vCustID.value="";
	   document.all.vMinYearMonth.value="";
	   document.all.vConID.value="";
	   document.all.vAcountName.value="";
	   document.all.vCountHead.value="";
	   document.all.vCustPaswd.value="";
	   document.all.vConPaswd.value="";
	   document.all.qCustID.disabled=false;
	   document.all.qConID.disabled=true;
	   document.all.vCountGrand.value="";
	   document.all.vOweFee.value="";
	   document.all.vSysNote.value="";
	   document.all.qConMsg.disabled=true;
	   document.all.vConPaswd.disabled=true;
	   document.all.vCertType.focus();
	}
	
	if(document.all.vQryType[2].checked) // ���տͻ���ѯ
	{     
		document.all.idCert.style.display="none";
		document.all.idCust.style.display="";
		document.all.vCustID.value="";
		document.all.vCustPaswd.value="";
		document.all.vConID.value="";
		document.all.vCountHead.value="";
		document.all.vPrePay.value="";
		document.all.vAcountName.value="";
		document.all.vCountGrand.value="";
		document.all.vDeposit.value="";
		document.all.vOweFee.value="";
		document.all.vMinYearMonth.value="";
		document.all.vConPaswd.value="";
		document.all.vSysNote.value="";
		document.all.qConID.disabled=false;
		document.all.qConMsg.disabled=true;
		document.all.vConPaswd.disabled=true;
		document.all.vCustID.focus();
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
    //var sqlStr = "select cust_id,cust_name from dCustDoc " +"where id_iccid ='" + 
    //       formField.value+"'";
    var sqlStr = "";
    PubSimpSelNew(pageTitle,fieldName,sqlStr,selType,retQuence,retToField,formField.value);
    //PubSimpSel(pageTitle,fieldName,sqlStr,selType,retQuence,retToField);
	if(document.all.vCustID.value == "")
	{	
		return false;
	}        
	document.all.qConID.disabled=false;
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
	document.all.vConPaswd.disabled=false;
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
			if(!checkElement(document.all.vFaxNo)) return false;
		 }
		 else if(document.all.vPostType.value == "1") //�ʼ�
		 {
			if(!checkElement(document.all.vPostZip)) return false;
			if(!checkElement(document.all.vPostAddress)) return false;
		 }
		 else //�����ʼ�
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
	 if(!checkElement(document.all.vPayChange)) return false;

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
	 if(!f1211CheckForm())  return false;

     document.all.f1211.action="f1211Cfm.jsp";
     document.all.f1211.submit();
	 return false;
 }


 // �����Ѽ��
 function getFew()
{
  if(window.event.keyCode==13)
  {
    var fee=document.all.vPayFee;
    var fact=document.all.vRealFee;
    var few=document.all.vPayChange;
    if(jtrim(fact.value).length==0)
    {
	  rdShowMessageDialog("ʵ�ս���Ϊ�գ�");	
	  fact.value="";
	  fact.focus();
	  return;
    }
//    if(parseFloat(fact.value)<parseFloat(fee.value))
//    {
//  	  rdShowMessageDialog("ʵ�ս��㣡");	
//	  fact.value="";
//	  fact.focus();
//	  return;
//    }
    if(parseFloat(fact.value)<parseFloat(fee.value))
    {
  	  few.value="0";
    }  
    else
    {
	  var tem1=((parseFloat(fact.value)-parseFloat(fee.value))*100+0.5).toString();
	  var tem2=tem1;
	  if(tem1.indexOf(".")!=-1) tem2=tem1.substring(0,tem1.indexOf("."));
      few.value=(tem2/100).toString();
    }
    few.focus();
  }
}
 function f1211Init()
 {
    document.all.idCert.style.display="none";
	document.all.idCust.style.display="none";
	document.all.submit.disabled=true;	
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

 /*
    ����1(pageTitle)����ѯҳ�����
    ����2(fieldName)�����������ƣ���'|'�ָ��Ĵ�
    ����3(sqlStr)��sql���
    ����4(selType)������1 rediobutton 2 checkbox
    ����5(retQuence)����������Ϣ������������� �������ʶ����'|'�ָ�����"3|0|2|3"��ʾ����3����0��2��3
    ����6(retToField))������ֵ����������,��'|'�ָ�
*/
function PubSimpSelNew(pageTitle,fieldName,sqlStr,selType,retQuence,retToField,id_iccid)
{   //������ѯ 
    var path = "<%=request.getContextPath()%>/npage/s1232/fPubSimpSelNew.jsp";
    //var path = "<%=request.getContextPath()%>/npage/public/fPubSimpSel.jsp";
    path = path + "?sqlStr=" + sqlStr + "&retQuence=" + retQuence;
    path = path + "&fieldName=" + fieldName + "&pageTitle=" + pageTitle;
    path = path + "&selType=" + selType;  
    path = path + "&id_iccid=" + id_iccid;
    path = path + "&v_opCode=" + document.f1211.opCode.value;    
    retInfo = window.showModalDialog(path);
    if(typeof(retInfo)=="undefined")    
    {   return false;   }
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

function submitt(){
	    getAfterPrompt();
		if(document.f1211.vNewPaswd.value!=document.f1211.vCfmPaswd.value){
			rdShowMessageDialog("������������벻һ�£�");
			return;
		}
		if(document.f1211.vNewPaswd.value.length==0){
			rdShowMessageDialog("�����벻��Ϊ�գ�");
			return;
		}
		if(!forNonNegInt(document.f1211.vNewPaswd)){
			return;
		}
		if(document.f1211.vOpNote.value.length==0){
			if(document.f1211.passOpType.value == '1'){
				document.f1211.vOpNote.value="�ʻ���������";
			}
			else if(document.f1211.passOpType.value == '0'){
			  document.f1211.vOpNote.value="�ʻ������޸�";
			}
		}
		
		checkPwdEasy(document.f1211.vNewPaswd.value);	//2010-8-9 9:52 wanghfa��� �ͻ�������������
}

//2010-8-9 8:43 wanghfa��� ��֤������ڼ� start
function checkPwdEasy(pwd) {
	var checkPwd_Packet = new AJAXPacket("../public/pubCheckPwdEasy.jsp","������֤�����Ƿ���ڼ򵥣����Ժ�......");
	checkPwd_Packet.data.add("password", pwd);
	checkPwd_Packet.data.add("phoneNo", "");
	checkPwd_Packet.data.add("idNo", "");
	checkPwd_Packet.data.add("contractNo", document.all.vConID.value);
	checkPwd_Packet.data.add("opCode", document.f1211.opCode.value);

	core.ajax.sendPacket(checkPwd_Packet, doCheckPwdEasy);
	checkPwd_Packet=null;
}

function doCheckPwdEasy(packet) {
	var retResult = packet.data.findValueByName("retResult");
	if (retResult == "1") {
		rdShowMessageDialog("�𾴵Ŀͻ������������õ�����Ϊ��ͬ���������룬��ȫ�Խϵͣ�Ϊ�˸��õر���������Ϣ��ȫ���������ð�ȫ�Ը��ߵ����롣");
		return;
	} else if (retResult == "2") {
		rdShowMessageDialog("�𾴵Ŀͻ������������õ�����Ϊ���������룬��ȫ�Խϵͣ�Ϊ�˸��õر���������Ϣ��ȫ���������ð�ȫ�Ը��ߵ����롣");
		return;
	} else if (retResult == "3") {
		rdShowMessageDialog("�𾴵Ŀͻ������������õ�����Ϊ�ֻ������е��������֣���ȫ�Խϵͣ�Ϊ�˸��õر���������Ϣ��ȫ���������ð�ȫ�Ը��ߵ����롣");
		return;
	} else if (retResult == "4") {
		rdShowMessageDialog("�𾴵Ŀͻ������������õ�����Ϊ֤���е��������֣���ȫ�Խϵͣ�Ϊ�˸��õر���������Ϣ��ȫ���������ð�ȫ�Ը��ߵ����롣");
		return;
	} else if (retResult == "0") {
		printCommit();
		if(printFlag!=1){
			return;
		}		
		document.f1211.submit.disabled=true;
		var myPacket = new AJAXPacket("submit.jsp","�����ύ�����Ժ�......");
		myPacket.data.add("workNo",document.f1211.workNo.value);
		myPacket.data.add("nopass",document.f1211.vWorkPaswd.value);
		myPacket.data.add("orgCode",document.f1211.orgCode.value);
		myPacket.data.add("opCode",document.f1211.opCode.value);
		myPacket.data.add("opType",document.f1211.opType.value);
		myPacket.data.add("opFlag",document.f1211.opFlag.value);
		myPacket.data.add("loginAccept","<%=seq%>");
		myPacket.data.add("idNo",document.f1211.vConID.value);
		myPacket.data.add("payFee",document.f1211.payFee.value);
		//myPacket.data.add("realFee",document.f1211.vPayFee.value);
		myPacket.data.add("realFee",document.f1211.vRealFee.value-document.f1211.vPayChange.value);
		myPacket.data.add("ipAddr",document.f1211.selfIpAddr.value);
		myPacket.data.add("oldPass",document.f1211.vConPaswd.value);		
		myPacket.data.add("newPass",document.f1211.vNewPaswd.value);
		myPacket.data.add("systemRemark","systemRemark");
		myPacket.data.add("remark",document.f1211.vOpNote.value);
		core.ajax.sendPacket(myPacket);
		myPacket=null;
	}
}
//2010-8-9 8:43 wanghfa��� ��֤������ڼ� end



function getThePassType(){
	var i = 0 ; 
	var passType = 0 ;
	for(i = 0 ; i < document.f1211.passOpType.length ; i ++){
		if(document.f1211.passOpType.options[i].selected){
			passType = document.f1211.passOpType.options[i].value;
			
		}
	}
	
	if(passType==1){//��λ
		//showHideTr.style.display="none";
		document.f1211.opType.value="1";
		document.f1211.vNewPaswd.value="";
		document.f1211.vCfmPaswd.value="";
		document.f1211.opCode.value="1233";
		
	}
	else{//�޸�
		document.f1211.opType.value="0";
		//showHideTr.style.display="";
		document.f1211.opCode.value="1232";
		document.f1211.vNewPaswd.value="";
		document.f1211.vCfmPaswd.value="";
		
		
	}

}
</script>
<body>
<form name="f1211" method="post" action="" onLoad="f1211Init()" onKeyUp="chgFocus(f1211)">
	<%@ include file="/npage/include/header.jsp" %>
	<div class="title">
		<div id="title_zi">ѡ���ѯ����</div>
	</div>
<table cellspacing="0">
	
		<tr> 
			<td class="blue">��������</td>
		<td colspan="3">
			<select name=passOpType id='passOpType' onchange="getThePassType()" index="8">
				<option value="1">��������</option>
				<option value="0">�޸�����</option>
			</select>
		</td>
	</tr>
	
	<tr> 
		<td class="blue">��ѯ����</td>
		<td colspan="3">
			<input type="radio" name="vQryType" index="0" value="0" onkeyup="if(event.keyCode==13){f1211CheckID()}" onClick="f1211CheckID()" checked>
			�ʻ� 
			<input type="radio" name="vQryType" index="1" value="1" onClick="f1211CheckID()" onkeyup="if(event.keyCode==13){f1211CheckID()}">
			֤�� 
			<input type="hidden" name="vQryType" index="2" value="2" onclick="f1211CheckID()" onkeyup="if(event.keyCode==13){f1211CheckID()}">
		</td>
	</tr>
	
	<tr id="idCert"> 
		<td class="blue">֤������</td>
		<td><select name="vCertType" index="3"></select></td>
		<td class="blue">֤������</td>
		<td>
			<input name="vCertNum" type="text" v_type="string" class="button" size="18" maxlength="18" index="4" onkeyup="if(event.keyCode==13){f1211GetCustID(vCertNum)}"> 
			<input class="b_text" type="button" name="qCustID" value="��ѯ�ͻ�ID" onClick="f1211GetCustID(vCertNum)">
		</td>
	</tr>
    
	<tr id="idCust"> 
	<td class="blue">�ͻ� ID</td>
	<td>
		<input name="vCustID" type="text" class="button" v_type="int" index="5" onkeyup="if(event.keyCode==13){f1211GetConID(vCustID)}" maxlength="22">
	</td>
	<td colspan="2">
		<input name="vCustPaswd"  type="hidden" class="button" size="18" v_type="0_9" v_must="0" maxlength="8">
		<input class="b_text" type="button" name="qConID" value="��ѯ�ʻ�ID" onClick="f1211GetConID(vCustID)"></td>
	</tr>
    
	<tr> 
		<td class="blue">�ʻ�ID</td>
		<td>
			<input name="vConID" type="text" index="6" class="button" v_must="1" v_type="int" maxlength="22">
		</td>
		<%if(favFlag==0){%>
		<td class="blue">�ʻ�����</td>
		<td>
			<input name="vConPaswd" index="7" onkeyup="if(event.keyCode==13){f1211GetConMsg(vConID)}" type="password" class="button" v_type="0_9" v_must="0" size="18" maxlength="8"> 
			<input class="b_text" type="button" name="qConMsg" value="��ѯ�ʻ���Ϣ" onClick="f1211GetConMsg(vConID)">
		</td>
		<%}else{%>
		<td colspan="2">
			<input name="vConPaswd" index="7" type="hidden" class="button" v_type="0_9" v_must="0" size="18" maxlength="8" disabled value="111111"> 
			<input class="b_text" type="button" name="qConMsg" value="��ѯ�ʻ���Ϣ" onClick="f1211GetConMsg(vConID)">
		</td>
		<%}%>
	</tr>
    
	<tr>
		<td class="blue" nowrap>��ͻ���־</td>
		<td>
			<input type="text" class="InputGrey" name="vCardName" readonly>
		</td>
		<td class="blue" nowrap>���ű�־</td>
		<td>
			<input type="text" class="InputGrey" name="vGrpName" readonly>
		</td>
	</tr>
	
	<tr> 
		<td class="blue">�ʻ���ͷ</td>
		<td valign="top">
			<input type="text" class="InputGrey" name="vCountHead" readonly>
		</td>
		<td class="blue" nowrap>�ʻ�������</td>
		<td>
			<input type="text" class="InputGrey" name="vCountGrand" readonly>
		</td>
	</tr>
	
    <tr> 
		<td class="blue">�ʻ�Ԥ��</td>
		<td>
			<input type="text" class="InputGrey" name="vPrePay" readonly>
		</td>
		<td class="blue">Ѻ ��</td>
		<td>
			<input type="text" class="InputGrey" name="vDeposit" readonly>
		</td>
    </tr>
    
    <tr> 
		<td class="blue" nowrap>��СǷ������</td>
		<td valign="top">
			<input type="text" class="InputGrey" name="vMinYearMonth" readonly>
		</td>
		<td class="blue">Ƿ ��</td>
		<td>
			<input type="text" class="InputGrey" name="vOweFee" readonly>
		</td>
    </tr>
    
	<tr> 
		<td class="blue">�� ��</td>
		<td colspan="3">
			<input type="text" class="InputGrey" name="vMark" readonly>
		</td>
    </tr>
  
    
    <tr> 
		<td class="blue">���д�������</td>
		<td><select name="vBankCode" class="button" disabled></select></td>
		<td class="blue">�ַ����д�������</td>
		<td><select name="vPostCode" class="button" disabled></select></td>
    </tr>
    
    <tr> 
		<td class="blue">�� ��</td>
		<td colspan="3">
			<input name="vAcountNum" type="text" v_type="int" class="InputGrey" size="60" readonly>
		</td>
    </tr>
    
    <tr> 
		<td class="blue">�ʻ�����</td>
		<td colspan="3">
			<input name="vAcountName" type="text" v_must="1"  v_type="string" class="InputGrey" size="60" readonly>
		</td>
    </tr>
    
	<tr> 
		<td class="blue">�ʻ�����</td>
		<td>
			<select name="vCountType" class="button" disabled>
				<option value="2"> </option>
				<option value="1">�쳣</option>
				<option value="0">����</option>
			</select>
		</td>
		<td class="blue">�ʻ�״̬</td>
		<td><select name="vCountStatus" class="button" disabled ></select></td>
    </tr>
    
    <tr> 
		<td class="blue">�ʼı�־</td>
		<td>
			<select name="vPostFlag" class="button" disabled>
				<option value="Y">��</option>
				<option value="N">��</option>
			</select>
		</td>
		<td class="blue">�ʼķ�ʽ</td>
		<td>
			<select name="vPostType" class="button" disabled>
			</select>
		</td>
    </tr>
	
    <tr> 
		<td class="blue">�� ��</td>
		<td>
			<input name="vPostZip" type="text" v_must="1" v_type="zip" class="InputGrey" maxlength="6" readonly>
		</td>
		<td class="blue">�ʼĵ�ַ</td>
		<td>
			<input type="text" class="InputGrey" v_must="1" v_type="string" name="vPostAddress" readonly>
		</td>
    </tr>
    
    <tr> 
		<td class="blue">�����</td>
		<td>
			<input type="text" class="InputGrey" name="vFaxNo" v_must="1" v_type="phone" readonly>
		</td>
		<td class="blue">E_Mail��ַ</td>
		<td>
			<input type="text" class="InputGrey" id="vMailAddress"  name="vMailAddress" v_must="1" v_type="email" readonly>
		</td>
    </tr>
    
    <tr> 
		<td class="blue">���ʽ</td>
		<td colspan="3"><select name="vPayCode" class="button" disabled></select></td>

     </tr>
     
	<tr id=showHideTr> 
		<jsp:include page="/npage/common/pwd_2.jsp">
		<jsp:param name="width1" value="16%"  />
		<jsp:param name="width2" value="34%"  />
		<jsp:param name="pname" value="vNewPaswd"  />
		<jsp:param name="pcname" value="vCfmPaswd"  />
		</jsp:include>
	</tr>
	
    <tr> 
		<td class="blue">������</td>
		<td>
			<input name="vPayFee" type="text" index="11" class="InputGrey" value="<%=tmpHandFee%>" size="12" readonly v_minlength="1" v_maxlength="12" v_must=1 v_type="cfloat">
		</td>
		<td class="blue">ʵ��
			<input name="vRealFee" type="text" class="InputGrey"  index="12" onKeyUp="getFew()" <%if(feeFlag==0){%>value="<%=tmpHandFee%>" readonly<%}%> v_minlength="1" v_maxlength="12" v_must=1 v_type="cfloat">
		</td>
		<td class="blue">����
			<input name="vPayChange" type="text" class="InputGrey" value="0" readonly v_minlength="1" v_maxlength="12" v_must=1 v_type="cfloat">
		</td>
    </tr>
    
    <tr> 
      <td class="blue">ϵͳ��ע</td>
      <td colspan="3">
      	<input name="vSysNote" class="InputGrey" type="text" size="60" readonly>
      </td>
    </tr>
    
    <tr style="display:none"> 
		<td class="blue">�û���ע</td>
		<td colspan="3">
			<input name="vOpNote" class="button" index="13" type="text" size="60" maxlength="60">
		</td>
    </tr>
</table>
<!-- ningtn 2011-8-4 11:05:17 ������ӹ��� -->
<jsp:include page="/npage/public/hwReadCustCard.jsp">
	<jsp:param name="hwAccept" value="<%=seq%>"  />
	<jsp:param name="showBody" value="01"  />
</jsp:include>
<table>
	<tr> 
		<td id="footer" colspan="4" align="center"> 
			<input class="b_foot" type="button" name="submit" value="ȷ��"  onClick="submitt()" index="14" onkeyup="if(event.keyCode==13){submitt()}">
			<input class="b_foot" type="button"  name="b_clear" value="���" onclick="document.f1211.vNewPaswd.value='';document.f1211.vCfmPaswd.value='';">
			<input class="b_foot" type="button" name="b_back" value="�ر�"  onClick="removeCurrentTab()">
		</td>
	</tr>
	
  </table>
<input type="hidden" name="tmpPaswd" value="">
<input type="hidden" name="vOrgCode" value="<%=org_code%>">
<input type="hidden" name="vIpAddress" value="<%=sIpAddress%>">
<input type="hidden" name="vWorkPaswd" value="<%=nopass%>">
<input type="hidden" name="vHandFee" value="<%=tmpHandFee%>">
<input type="hidden" name="myCount" id="myCount" value="0">
<input type="hidden" name="offerTrafficflag" id="offerTrafficflag" value="0">



<input type=hidden name=loginAccept value="0">
<input type=hidden name=opCode value="1233">
<input type=hidden name=workNo value="<%=dWorkNo%>">
<input type=hidden name=orgCode value="<%=org_code%>">
<input type=hidden name=opType value="1">
<input type=hidden name=opFlag value="2">
<input type=hidden name=payFee value="<%=tmpHandFee%>">
<input type=hidden name=selfIpAddr value="<%=request.getRemoteAddr()%>">
<input type=hidden name=backLoginAccept>

<!-- 2014/12/26 14:47:50 gaopeng �������ƽ��ģʽ�����������Ϣģ���������� ���빫��ҳ�� openType����������ͨ���У��Ͷ����๫��У��-->
<jsp:include page="/npage/public/intf4A/common/intfCommon4A.jsp">
	<jsp:param name="openType" value="SPECIAL"  />
</jsp:include>
	<%@ include file="/npage/include/footer.jsp" %>
</form>
	  
	  <!------------------------------------------------------------------------->


</BODY>
<!-- ningtn 2011-7-12 08:35:36 ���ӻ���������Χ -->
<%@ include file="/npage/public/hwObject.jsp" %> 
<script language="JavaScript">
	function fillSelect()
	{		
<% 
	  int selObj_num=6;
	  
	  String[] selObj={"vCertType","vbankCode","vPostCode","vPostType","vPayCode","vCountStatus"};
			
					
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
	
<script>
	f1211Init();
</script>
<script>

function printCommit()
{          
	// in here form check
	showPrtDlg("Detail","ȷʵҪ���е��������ӡ��","Yes");  	 
}

function showPrtDlg(printType,DlgMessage,submitCfn)
{  //��ʾ��ӡ�Ի��� 
	var h=210;
	var w=400;
	var t=screen.availHeight/2-h/2;
	var l=screen.availWidth/2-w/2;
	var pType="print";
	var billType="1";  
	var printStr = printInfo(printType);
   
	var mode_code=null;
	var fav_code=null;
	var area_code=null;
	
	var sysAccept = "<%=seq%>";
	/* ningtn */
	var iccidInfoStr = $("#firstId").val() + "|" + $("#secondId").val();	
	var accInfoStr = $("#accInfoHid1").val() + "|" +$("#accInfoHid2").val()+ "|" +$("#accInfoHid3").val()+ "|" +$("#accInfoHid4").val();
	/* ningtn */
	var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no"; 
	var path = "<%=request.getContextPath()%>/npage/innet/hljBillPrint_jc_hw.jsp?DlgMsg=" + DlgMessage+ "&iccidInfo=" + iccidInfoStr + "&accInfoStr="+accInfoStr;
	var path = path  + "&mode_code="+mode_code+"&fav_code="+fav_code+"&area_code="+area_code+"&opCode=<%=opCode%>&sysAccept="+sysAccept+"&phoneNo=&submitCfm=" + submitCfn+"&pType="+pType+"&billType="+billType+ "&printInfo=" + printStr;
	var ret=window.showModalDialog(path,printStr,prop);
	ret="confirm";
	
   if(typeof(ret)!="undefined")
   {
     if((ret=="confirm")&&(submitCfn == "Yes"))
     {
       if(rdShowConfirmDialog('ȷ��Ҫ���д��������')==1)
       {
       	printFlag=1;
       }
     }
   }
}

function printInfo(printType)
{
   var retInfo = "";
     var cust_info="";
	 var opr_info="";
	 var note_info1="";
	 var note_info2="";
	 var note_info3="";
	 var note_info4="";
    if(printType == "Detail")
    {
	  cust_info+="�ʻ�ID��"+document.all.vConID.value+"|";
	  cust_info+="�ʻ����ƣ�"+document.all.vAcountName.value+"|";
	  opr_info+="����ҵ��"+document.all.passOpType.options[document.all.passOpType.selectedIndex].text+"|";
	  opr_info+="�ʻ�����(ID)��"+document.f1211.vConID.value+"|";
	  opr_info+="�ʻ�����:"+document.f1211.vAcountName.value+"|";
	  note_info1+="��ע��"+"|";
	  retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
	  retInfo=retInfo.replace(new RegExp("#","gm"),"%23");
      return retInfo;	

    }  

    return retInfo;
}
</script>
<script>
function printBill(){
	var infoStr="";                                                                         
	 infoStr+=" "+"|";
     infoStr+='<%=new java.text.SimpleDateFormat("yyyy", Locale.getDefault()).format(new java.util.Date())%>'+"|";
	 infoStr+='<%=new java.text.SimpleDateFormat("MM", Locale.getDefault()).format(new java.util.Date())%>'+"|";
	 infoStr+='<%=new java.text.SimpleDateFormat("dd", Locale.getDefault()).format(new java.util.Date())%>'+"|";
	 infoStr+=""+"|";//�ƶ�����                                                   
	 infoStr+=" "+"|";//��ͬ����                                                          
	 infoStr+=document.all.vAcountName.value+"|";//�û�����                                                
	 infoStr+=document.all.vPostAddress.value+"|";//�û���ַ   
	 infoStr+="�ֽ�"+"|";
		 infoStr+=document.all.vPayFee.value+"|";                                                
	 infoStr+="�ʻ������޸ġ�*�����ѣ�"+(document.f1211.vRealFee.value-document.f1211.vPayChange.value)+"*��ˮ�ţ�"+document.all.backLoginAccept.value+"|";
	 location="chkPrint.jsp?retInfo="+infoStr+"&dirtPage=f1232.jsp";                    
}
</script>
</HTML>

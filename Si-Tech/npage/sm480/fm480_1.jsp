<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%
    String opCode = "m479";
    String opName = "�̻���ͣ";
    
    String orgCode = (String)session.getAttribute("orgCode");
    System.out.println("orgCode====="+orgCode);
    String regionCode = orgCode.substring(0,2);
    //String workName = (String)session.getAttribute("workName");
    String dateStr2 =  new java.text.SimpleDateFormat("yyyyMMdd").format(new java.util.Date());
    String dateStr2222 =  new java.text.SimpleDateFormat("yyyy-MM-dd hh:mm:ss").format(new java.util.Date());
    String broadPhone = request.getParameter("broadPhone");
%>	
<%
    String workNo = (String) session.getAttribute("workNo");
    String nopass = (String) session.getAttribute("password");
    String iChnSource = "01";
    String iUserPwd = "";
    String[][] favInfo = (String[][])session.getAttribute("favInfo");
    
    int favFlag = 1;
    String org_codeT = orgCode;
    String region_codeT = org_codeT.substring(0, 2);
    System.out.println("region_code======="+region_codeT);
    String feeSql = "select function_code, hand_fee ,region_code,favour_code from sNewFunctionFee where region_code = '" + region_codeT + "' and function_code in ('m479','m480','m481','b543','b544')";
%>
<!--�����ѵĲ�ѯ-->
		<wtc:pubselect name="sPubSelect" routerKey="phone" routerValue="<%=activePhone%>" outnum="4">
		<wtc:sql><%=feeSql%></wtc:sql>
		</wtc:pubselect>
		<wtc:array id="fee" scope="end" />
<%
    System.out.println("the length of fee==========="+fee.length);
    String workSql = "select count(*) from shighlogin where login_no = '" + workNo + "' and op_code='b544'";
%>
<!--�߶��û��Ĳ�ѯ-->
		<wtc:pubselect name="sPubSelect" routerKey="phone" routerValue="<%=activePhone%>" outnum="2">
		<wtc:sql><%=workSql%></wtc:sql>
		</wtc:pubselect>
		<wtc:array id="higflagArr" scope="end" />
<%
		String higflag="";
		if(higflagArr!=null&&higflagArr.length>0){
			higflag = higflagArr[0][0];
		}
%>
<wtc:service name="sUserCustInfo" outnum="100"  retcode="errCode" retmsg="errMsg" routerKey="region" routerValue="<%=regionCode%>">
			<wtc:param value="0" />
			<wtc:param value="01" />	
			<wtc:param value="<%=opCode%>" />	
			<wtc:param value="<%=workNo%>" />
			<wtc:param value="<%=nopass%>" />
			<wtc:param value="<%=activePhone%>" />
			<wtc:param value="" />
			<wtc:param value="" />
			<wtc:param value="�̻��ۺϱ����ѯ�û���Ϣ" />
</wtc:service>				
<wtc:array id="baseArr" scope="end"/>
<%
String id_no="";
String contract_no="";
String smcode = "";
String username ="";
 if(baseArr!=null&&baseArr.length>0){
   System.out.println("baseArr.length===="+baseArr.length); 
    	if(baseArr[0][0].equals("00")) {
    	  
          id_no = (baseArr[0][30]);
          contract_no=(baseArr[0][32]);
          smcode = (baseArr[0][38]);
          username = (baseArr[0][5]);
          }
    }

%>			
<HEAD>
    <TITLE>��ͣ����ͣ�ָ���Ԥ��������</TITLE>

<script language="javascript">
var printFlag = 9;//�û����۱�ʶ
var flag = 0;//��ѯ�û���Ϣ�ɹ�����ʶ
function doProcess(packet) {
	
	
    var backString = packet.data.findValueByName("backString");
    var cfmFlag = packet.data.findValueByName("flag");
    //cfmFlag = 1;
    /*��������ķ���*/
    
    //alert("document.frm.opCode.value = "+document.frm.opCode.value+"\npubSmCode = "+$("#pubSmCode").val()+"\ncfmFlag = "+cfmFlag);
    
    if (cfmFlag == 1) {
        var errMsg = packet.data.findValueByName("errMsg");
        var errCode = packet.data.findValueByName("errCode");
        var errCodeInt = parseInt(errCode, 10);
        //errCodeInt = 0;
        if (errCodeInt == 0) {
        		//document.frm.opCode.value = "b544";
            rdShowMessageDialog("�����ɹ���",2);
            document.frm.backLoginAccept.value = backString[0][0];
            if ((document.frm.opCode.value == "m479" || document.frm.opCode.value == "m480") 
            		&& parseFloat(document.frm.factPay.value) > 0) {
            		rdShowMessageDialog("��ӡ��Ʊ");
                showBroadBill("Bill","ȷʵҪ���з�Ʊ��ӡ��","Yes");
            }
            if (document.frm.opCode.value == "b544" && parseFloat(document.frm.backPrepay.value) > 0) {
                rdShowMessageDialog("��ӡ��Ʊ");
                showBroadBill("Bill","ȷʵҪ���з�Ʊ��ӡ��","Yes");
            }
            var pubSmCode = $("#pubSmCode").val();
            if(document.frm.opCode.value == "m481"&& parseFloat(document.frm.backPrepay.value) > 0){
            	rdShowMessageDialog("��ӡ��Ʊ");
              showBroadBill("Bill","ȷʵҪ���з�Ʊ��ӡ��","Yes");
            }
            
            document.frm.phoneNo.value="<%=activePhone%>";
            document.frm.smName.value = "";
            document.frm.customPass.value = "";
            document.frm.userId.value = "";
            document.frm.runName.value = "";
            document.frm.gradeName.value = "";
            document.frm.totalPrepay.value = "";
            document.frm.totalOwe.value = "";
            document.frm.custName.value = "";
            document.frm.factPay.value = "";
            document.frm.remark.value = "";
            document.frm.cardType.value = "";
            document.frm.idCardNo.value = "";
            document.frm.custAddress.value = "";
            document.frm.backPrepay.value = "";
            document.frm.iccName.value = "";
            document.frm.iccNo.value = "";
            document.frm.innerTime.value = "";
            document.frm.backDate.value = "";
            document.frm.remark.value = "";
            document.frm.asNotes.value = "";
            document.frm.productName.value = "";
            document.frm.loginAccept.value = "";  
            flag = 0;
            resett();

        } else {
            rdShowMessageDialog(errCode + ":" + errMsg);
            document.frm.vConID.value = "";
            document.frm.vPhoneNo.value = "";
            document.frm.productName.value = "";
            resett();
            return;
        }

    }
    /*�û���Ϣ��ѯʧ��*/
    if (cfmFlag == 9) {
        var errCode = packet.data.findValueByName("errCode");
        var errMsg = packet.data.findValueByName("errMsg");
        rdShowMessageDialog(errCode + " : " + errMsg);
				if(errCode != "000000"){
					window.location='fm480_1.jsp?activePhone=<%=activePhone%>';
				}
        var ii = 0 ;
        for (ii = 0; ii < document.frm.radiobutton.length; ii ++) {
            document.all.radiobutton[ii].disabled = false;
        }
        flag = 0;
        return;
    }
    /*�û���Ϣ����ʾ*/
    if (cfmFlag == 0) {

        var errMsg = packet.data.findValueByName("errMsg");
        var errCode = packet.data.findValueByName("errCode");
        var phoneNo=packet.data.findValueByName("phoneNo");
        var errCodeInt = parseInt(errCode, 10);
				
        
        document.frm.userId.value = backString[0][0];
        document.frm.smName.value = backString[0][2];
        document.frm.custName.value = backString[0][3];
        document.frm.customPass.value = backString[0][4];
        document.frm.runName.value = backString[0][6];
        document.frm.gradeName.value = backString[0][8]; 
        document.frm.custAddress.value = backString[0][11];
        document.frm.iccName.value = backString[0][13];
        document.frm.idCardNo.value = backString[0][14];
        document.frm.iccNo.value = backString[0][14];
        document.frm.cardType.value = backString[0][15];
        document.frm.totalOwe.value = backString[0][16];  
        document.frm.totalPrepay.value = backString[0][17];
        document.frm.backPrepay.value = backString[0][20];
        document.frm.lxPrepay.value = backString[0][21];
        document.frm.innerTime.value = backString[0][22];
        document.frm.backDate.value = backString[0][23];     
        document.frm.phoneNo.value=phoneNo;
        if (document.frm.cardType.value.indexOf("�и߶��û�", 0) >= 0) {
            rdShowMessageDialog("���û����и߶��û���");
        }
        if (document.frm.cardType.value.indexOf("�и߶��û�", 0) >= 0 && <%=higflag%> ==0 && document.frm.opCode.value == "b544"){
		        rdShowMessageDialog("���û����и߶��û�,�˹���û������Ȩ�ޣ�");
		        return;
    		}
        document.frm.noBack.value = backString[0][24];
        document.frm.productName.value = backString[0][25];
        document.frm.loginAccept.value = backString[0][26];
        document.frm.cfmLogin.value = backString[0][27];
        
        
        /*2015/01/19 15:03:46 gaopeng m483 Ԥ��ʱ,kh��չʾ���˽��*/
				/*��ȡƷ��sm_code*/
				getPubSmCode($("#cfmLogin").val());
				var smCode = $("#pubSmCode").val();
				
				if(document.frm.opCode.value == "m481"){
					$("#noBackDiv").show();
					$("#showMyMsg").show();
					
				var getdataPacket = new AJAXPacket("getTerminaleFeeFlag.jsp","���ڻ�����ݣ����Ժ�......");
				getdataPacket.data.add("cfmLogin",$("#cfmLogin").val());
				core.ajax.sendPacket(getdataPacket,doBroadMsgBack);
				getdataPacket = null;
				
				}
				
        
         document.frm.cctIdOld.value = backString[0][30];
        
        document.frm.factPay.disabled = false;
        flag = 1;
        if (errCode == 0) {
            if (document.frm.favFlag.value == 1) {
                document.frm.submit.disabled = false;
            }
        }

        if (errCode != 0) {
            if (errCode == 121350) {
                rdShowMessageDialog(errCodeInt + " : " + errMsg);
                if (rdShowConfirmDialog('ȷ��Ҫ�������ű����') != 1) {
                    return;
                }
                if (document.frm.favFlag.value == 1) {
                    document.frm.submit.disabled = false;
                }
            }
            else if (errCode == 1206) {
                rdShowMessageDialog(errCodeInt + " : " + errMsg);
                if (rdShowConfirmDialog('ȷ��Ҫ�������ű����') != 1) {
                    return;
                }
                if (document.frm.favFlag.value == 1) {
                    document.frm.submit.disabled = false;
                }
            }
            else {

                if (errCode == 1201) {
                    errMsg = "�Ҳ����÷������";
                }

                if (errCode == 1202) {
                    errMsg = "��״̬��������";
                }
                if (errCode == 1203) {
                    errMsg = "�˺��벻������ز���";
                }
                if (errCode == 1204) {
                    errMsg = "��ҵ�����Ͳ����������";
                }
                if (errCode == 1007) {
                    errMsg = "Ƿ��״̬��������";
                }
                if (errCode == 1008) {
                    errMsg = "Ƿ��״̬��������";
                }

                if (errCode == 1207) {
                    errMsg = "���û��Ѿ�����";
                }

                rdShowMessageDialog(errCodeInt + " : " + errMsg);
                var ii = 0 ;
                for (ii = 0; ii < document.frm.radiobutton.length; ii ++) {
                    document.all.radiobutton[ii].disabled = false;
                }

                document.frm.smName.value = "";
                document.frm.customPass.value = "";
                document.frm.userId.value = "";
                document.frm.runName.value = "";
                document.frm.gradeName.value = "";
                document.frm.totalPrepay.value = "";
                document.frm.totalOwe.value = "";
                document.frm.custName.value = "";
                document.frm.remark.value = "";
                document.frm.factPay.value = "";
                document.frm.cardType.value = "";
                document.frm.idCardNo.value = "";
                document.frm.custAddress.value = "";
                document.frm.backPrepay.value = "";
                document.frm.lxPrepay.value = "";
                document.frm.noBack.value = "";
                document.frm.iccName.value = "";
                document.frm.iccNo.value = "";
                document.frm.innerTime.value = "";
                document.frm.remark.value = "";
                document.frm.asNotes.value = "";
                document.frm.productName.value = "";
                document.frm.loginAccept.value = "";
                flag = 0;
            }
        }
        /** bingId Ϊ63ʱ�������Ʒ�ƣ�����ѯ����Դ��Ϣ**/
        var bindVal = backString[0][29];
        $("#bindId").val(bindVal);
				if(document.all.radioValue.value == 'm481' && bindVal != "63"){
       			//getOldResByCfmLogin();
        }
     }
}

function doBroadMsgBack(packet){
var	result = packet.data.findValueByName("result");
	if(result != ""){
		rdShowMessageDialog("�������û����й̻��ն��豸Ѻ�𷵻���Ѻ�𷵻�����Ϊ��m355-�̻��豸Ѻ�𷵻���");
	}
}

/*��ȡ����Դ��Ϣ*/
function getOldResByCfmLogin()
{
	 document.all.deviceTypeOld.value="";
   document.all.deviceCodeOld.value="";
   document.all.modelOld.value= "";
   document.all.factoryOld.value= "";
   document.all.ipAddressOld.value= "";
   document.all.deviceInAddressOld.value="";
   document.all.portCodeOld.value= "";
   document.all.portTypeOld.value= "";
   document.all.cctIdOld.value = "";
}

/*********�û���Ϣ�Ĳ�ѯ****************/
function submitt() {
		for (var i = 0; i < document.frm.radiobutton.length; i++)
    {
        if (document.frm.radiobutton[i].checked)
        {
            document.all.radioValue.value = document.frm.radiobutton[i].value;
            document.all.radioIndex.value=document.frm.radiobutton[i].index;
        }
    }
    var allInfo = "";
    var radioK = 0;

    for (radioK = 0; radioK < document.frm.radiobutton.length; radioK++) {
        if (document.frm.radiobutton[radioK].checked) {
            allInfo = document.frm.radiobutton[radioK].value;
        }
    }
    if (allInfo == "") {
        rdShowMessageDialog("��ѡ���������!");
        return;
    }

    var ii = 0 ;
    for (ii = 0; ii < document.frm.radiobutton.length; ii ++) {
        document.all.radiobutton[ii].disabled = true;
    }
    /*��ȡ�̻��û���Ϣ*/
		if(document.all.phoneNo.value != ""){
			//alert(350);
	    var myPacket = new AJAXPacket("getKDUserInfo.jsp", "�����ύ�����Ժ�......");
	    myPacket.data.add("loginAccept", document.frm.loginAccept.value);
	    myPacket.data.add("iChnSource", document.frm.iChnSource.value);
	    myPacket.data.add("opCode", document.frm.opCode.value);
	    myPacket.data.add("workNo", document.frm.workNo.value);
	    myPacket.data.add("opCode", document.frm.opCode.value);
	    myPacket.data.add("phoneNo", document.frm.phoneNo.value);
	    myPacket.data.add("iUserPwd ", document.frm.iUserPwd .value);    
	    core.ajax.sendPacket(myPacket);
	    myPacket=null;
		}else{
  	  rdShowMessageDialog("��ѯ�̻��û���Ϣʧ�ܣ�",0);
  	  return false;
  	}
}

/******** ���������ʱ���ӻ�����ʾ��Ϣ *********/

/*zhangyan add*/
function setBusInfo(packet)
{
	var	retCode	=packet.data.findValueByName("retCode"); 	
	var	retMsg	=packet.data.findValueByName("retMsg"); 	

	if (!( retCode=="000000" ) )
	{
		document.all.bFCode.value=retCode;
		document.all.bFMsg.value=retMsg;
	}
	else
	{
		document.all.bFCode.value="000000";
		document.all.bFMsg.value="У��ɹ�";
	}
}

function set_otreson(){
	var sel_val = $("#sel_reasonDescription").val();
	if(sel_val=="10"){
		$("#tr_otreson").show();
	}else{
		$("#tr_otreson").hide();
	}
	$("#textarea_otreson").text("");	
}


function formSubmitCfm()
{


	var reasonDescription = "";
	
	if(document.frm.opCode.value == "m481"){
	if($("#sel_reasonDescription").val()=="10"){
		if($("#textarea_otreson").text().trim()==""){
			rdShowMessageDialog("����������ԭ��");
			return;
		}
		
		if($("#textarea_otreson").text().trim().length>30||$("#textarea_otreson").text().trim().length<1){
			rdShowMessageDialog("����ԭ��ֻ������1-30���ַ�");
			return;
		}
		
		reasonDescription = $("#sel_reasonDescription").val()+"��"+$("#sel_reasonDescription option:selected").text()+"��"+$("#textarea_otreson").text().trim();
		
	}else{
			if($("#sel_reasonDescription").val()==""){
					rdShowMessageDialog("��ѡ������ԭ��");
					return;
			}	
			
			reasonDescription = $("#sel_reasonDescription").val()+"��"+$("#sel_reasonDescription option:selected").text();
	}
}

	showBroadBill("Bill","ȷʵҪ���з�Ʊ��ӡ��","Yes");//����д��
	
	//getAfterPrompt();

	submitCfm(reasonDescription);
}

/**********ҳ����ύ***************/
function submitCfm( reasonDescription) 
{	
		var op_code=document.frm.opCode.value;
		getAfterPrompt(op_code);
		
	/*zhangyan*/
	if(document.all.opCode.value.trim() == "m481")
	{
		/*ָ��Ajax����ҳ*/
		var packet = new AJAXPacket("../public/pubBUSAPIAjax.jsp"
		,"���Ժ�...");
	
		/*��ajaxҳ�洫�ݲ���*/
		packet.data.add("netCode"
		,document.frm.cfmLogin.value.trim() );
		packet.data.add("opCode",document.all.opCode.value.trim() );
	
		/*����ҳ��,��ָ���ص�����*/
		core.ajax.sendPacket(packet,setBusInfo,false);
		packet=null;		
	}
	
	if(document.all.opCode.value.trim() == "m481")
	{
		if (!(  document.all.bFCode.value=="000000") )
		{
			rdShowMessageDialog(document.all.bFMsg.value , 0);
			return false;
		}
	}			
		
    if (flag == 1) {
        if (document.frm.remark.value.length == 0) {
            document.frm.remark.value = document.frm.sysRemark.value;
            document.frm.remark.value = "�û�����" + document.frm.phoneNo.value + "�û�����" + document.frm.custName.value + "����" + document.frm.remark.value + "��";
        }
        
        if(document.frm.asNotes.value.trim().len()==0){
        		document.frm.asNotes.value=document.frm.remark.value;
        }
        if (!forMoney(document.frm.handFee)) {
            return;
        }
        if (!forMoney(document.frm.factPay)) {
            return;
        }
        if (parseFloat(document.frm.factPay.value) > parseFloat(document.frm.handFeeT.value)) {
            rdShowMessageDialog("�����Ѳ��ܴ���" + document.frm.handFeeT.value);
            return;
        }
         for (var i = 0; i < document.frm.radiobutton.length; i ++) {
            if (document.all.radiobutton[i].checked)
            {
                var radio1 = document.all.radiobutton[i].value;
                if (radio1 == "m481")
                {	
                    if(document.all.construct_request.value.trim().length==0){
			     							document.all.construct_request.value="��";
			 							}
                } 
            }
        }
    /*    
		getPubSmCode($("#cfmLogin").val());
		var pubSmCode = $("#pubSmCode").val();
		alert(pubSmCode);
		alert(document.frm.opCode.value);
    if(document.frm.opCode.value == "m483" && pubSmCode == "kh"){
            	rdShowMessageDialog("��ӡ��Ʊ");
              showBroadBill("Bill","ȷʵҪ���з�Ʊ��ӡ��","Yes");
    }*/
    if(!printCommit()){
    	return false;
    }
    
    
     if (printFlag != 1 && printFlag != 2) {
	        return;
	    }

			document.frm.submit.disabled = true;
			var vPhoneNo = document.frm.phoneNo.value;
			
			var myPacket = new AJAXPacket("fm480_Cfm.jsp", "�����ύ�����Ժ�......");
				myPacket.data.add("opCode", document.frm.opCode.value);
				myPacket.data.add("iChnSource", $("iChnSource").val());
				myPacket.data.add("radioIndex", document.frm.radioIndex.value);
				myPacket.data.add("phoneNo", document.frm.phoneNo.value); 
				myPacket.data.add("iUserPwd", $("#iUserPwd").val()); 
				myPacket.data.add("cfmLogin", document.frm.cfmLogin.value);
				myPacket.data.add("cfmPwdOld", "");
				myPacket.data.add("cfmPwdNew", "");
				myPacket.data.add("workNo", document.frm.workNo.value);
				myPacket.data.add("loginAccept", document.frm.loginAccept.value);
				myPacket.data.add("vPhoneNo", document.frm.vPhoneNo.value);
				myPacket.data.add("vConID", document.frm.vConID.value);
				myPacket.data.add("backPrepay", document.frm.backPrepay.value);
				myPacket.data.add("orgCode", document.frm.orgCode.value);
				myPacket.data.add("handFee", document.frm.handFee.value);
				myPacket.data.add("factPay", document.frm.factPay.value);
				myPacket.data.add("sysRemark", document.frm.sysRemark.value);
				myPacket.data.add("ipAdd", $("#ipAdd").val());
				myPacket.data.add("construct_request", $("#construct_request").val());
				myPacket.data.add("appointTime", $("#appointTime").val());
				myPacket.data.add("portCodeOld", $("#portCodeOld").val());
				myPacket.data.add("deviceCodeOld", $("#deviceCodeOld").val());
				myPacket.data.add("ipAddressOld", $("#ipAddressOld").val());
				myPacket.data.add("deviceInAddressOld", $("#deviceInAddressOld").val());
				myPacket.data.add("iModemFlag", $("input[name='iModemFlag']:checked").val());
				myPacket.data.add("cctIdOld", $("#cctIdOld").val());
				myPacket.data.add("reasonDescription", reasonDescription);
				
				core.ajax.sendPacket(myPacket);
		    myPacket=null;
	    if (printFlag == 2) {
	        var vEvalValue = GetEvalReq(1);
	        if (vEvalValue == 4) {
	            rdShowMessageDialog("�û�δ��������!");
	        }
	        var vEvalPacket = new AJAXPacket("../../npage/public/evalCfm.jsp?vEvalValue=" + vEvalValue, "�����ύ�û���������ۣ����Ժ�......");
	        vEvalPacket.data.add("vLoginAccept", document.frm.loginAccept.value);
	        vEvalPacket.data.add("vOpCoce", document.frm.opCode.value);
	        vEvalPacket.data.add("vLoginNo", document.frm.workNo.value);
	        vEvalPacket.data.add("vPhoneNo", vPhoneNo);
	        core.ajax.sendPacket(vEvalPacket);
	        vEvalPacket=null;
	    }
      }
   	 else
   	 {
        rdShowMessageDialog("���Ȳ�ѯ�û���Ϣ��");
    }
}
/******ҳ�������*********/
function resett() {
    printFlag = 9;
    document.frm.customPass.value = "";
    document.frm.userId.value = "";
    document.frm.runName.value = "";
    document.frm.gradeName.value = "";
    document.frm.totalPrepay.value = "";
    document.frm.totalOwe.value = "";
    document.frm.custName.value = "";
    document.frm.smName.value = "";
    document.frm.backPrepay.value = "";
    document.frm.lxPrepay.value = "";
    document.frm.noBack.value = "";
    document.frm.iccName.value = "";
    document.frm.iccNo.value = "";
    document.frm.innerTime.value = "";
    document.frm.asNotes.value = "";
     /*�û�����Դ��Ϣ������ */
    document.frm.cfmLogin.value = "";
    document.frm.deviceTypeOld.value = "";
    document.frm.deviceCodeOld.value = "";
    document.frm.deviceInAddressOld.value = "";
    document.frm.factoryOld.value = "";
    document.frm.portTypeOld.value = "";
    document.frm.portCodeOld.value = "";
    document.frm.ipAddressOld.value = "";
    document.frm.modelOld.value = "";
    
    /*ʩ����Ϣ������*/
    document.frm.construct_request.value = "";
    document.frm.appointTime.value = "";
    var ii = 0 ;
    for (ii = 0; ii < document.frm.radiobutton.length; ii ++) {
        document.all.radiobutton[ii].disabled = false;
    }

    document.frm.submit.disabled = true;
    document.frm.cardType.value = "";
    document.frm.idCardNo.value = "";
    document.frm.custAddress.value = "";
    flag = 0;
}
/****����ת������ѯ��ȷ���˺�****/
function m479GetByPhone(formField) {
    if (document.frm.vPhoneNo.value == document.frm.phoneNo.value)
    {
        rdShowMessageDialog("ת����벻���ڷ��������ͬ�������²�����");
        document.frm.vPhoneNo.value = "";
        document.frm.vPhoneNo.focus();
        return false;
    }
    document.all.vConID.value = "";

    var pageTitle = "�ʻ���Ϣ��ѯ";
    var fieldName = "ת���ʻ�|ת���ʻ�����";
    var selType = "S";    //'S'��ѡ��'M'��ѡ
    var retQuence = "0";
    var retToField = "vConID";
    var sqlStr = "select a.contract_no, a.bank_cust from dConMsg a, dCustMsg b, dConUserMsg c where a.contract_no = c.contract_no and   b.id_no = c.id_no and   b.phone_no  = '" + formField.value + "'";
    PubSimpSel(pageTitle, fieldName, sqlStr, selType, retQuence, retToField);
    if (document.all.vConID.value == "")
    {
        return false;
    }        
}
/***�������Ļ�����ʾ*****/
function showPreCancelInfo()
{
}
/***�������ŵĻ�����ʾ*****/

/*****��ʾ�Ų�ѯ********/
function beforePrompt(){
	var op_code=$("input[@name=radiobutton][@checked]").val();
	var packet = new AJAXPacket("/npage/include/getBeforePrompt.jsp","���Ժ�...");
	packet.data.add("opCode" ,op_code);
	core.ajax.sendPacketHtml(packet,doGetBeforePrompt,true);//�첽
	packet =null;
}
function doGetBeforePrompt(data)
{
	$('#wait').hide();
	$('#beforePrompt').html(data);
}
/*****ע�������ѯ********/
function getAfterPrompt(op_code)
{
	var packet = new AJAXPacket("/npage/include/getAfterPrompt.jsp","���Ժ�...");
	packet.data.add("opCode" ,op_code);
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
/*�û���Ϣ�Ĳ�ѯ*/
function clickRadio(){
	/* ����radio  by ningtn  */
	var opCode=$("input[@name=radiobutton][@checked]").val();
	$("#tr_otreson").hide();
	$("#tr_otreson_1").hide();
	
	if(opCode == "m479"){
		noBackDiv.style.display='none';
		backDiv.style.display='none';
		document.frm.opCode.value='m479';
		document.frm.handFee.value='0';
		document.frm.handFeeT.value='0';
		document.frm.factPay.value='0';
		document.frm.sysRemark.value='��ͣ';
	}else if(opCode == "m480"){
		noBackDiv.style.display='none';
		backDiv.style.display='none';
		document.frm.opCode.value='m480';
		document.frm.handFee.value='0';
		document.frm.handFeeT.value='0';
		document.frm.factPay.value='0';
		document.frm.sysRemark.value='��ͣ�ָ�';
	}else if(opCode == "m481"){
	
		noBackDiv.style.display='none';
		backDiv.style.display='none';
		constructDiv.style.display='';
		modemFlagTr.style.display=''; //���ڱ���2013��9�µ�һ��ҵ��֧��ϵͳ�г�רҵ����ĺ�-�����ϱ�CRM��BOSS�;���ϵͳ�������ʾ hejwa add 2013��10��28��9:32:54
		userOldResDiv1.style.display='none'; 
		userOldResDiv2.style.display='none'; 
		document.frm.opCode.value='m481';
		document.frm.handFee.value='0';
		document.frm.handFeeT.value='0';
		document.frm.factPay.value='0';
		document.frm.sysRemark.value='����';
		$("#tr_otreson_1").show();
	}else if(opCode == "b544"){
		noBackDiv.style.display='';
		backDiv.style.display='';
		document.frm.opCode.value='b544';
		document.frm.handFee.value='0';
		document.frm.handFeeT.value='0';
		document.frm.factPay.value='0';
		document.frm.sysRemark.value='����';
	}
	<%
	for(int i = 0; i < fee.length ; i ++){
	%>
	
	if("<%=fee[i][0]%>" == opCode){
		
		document.frm.handFee.value="<%=fee[i][1]%>";
		document.frm.handFeeT.value="<%=fee[i][1]%>";
		var factPayObj = $("#factPay");
		factPayObj.val("<%=fee[i][1]%>");
		factPayObj.attr("readonly","readonly");
		<%
		for(int j = 0; j < favInfo.length; j++){
		%>
		
			if("<%=fee[i][3]%>" == "<%=favInfo[j][0].trim()%>"){
				

				factPayObj.removeAttr("readonly");
			}
		<%
		}
		%>
	}
	<%
	}
	%>
	
	submitt();
}

function go_reset(){
	location = location;
}
</script>
</HEAD>
<body>
<FORM action="" method=post name="frm">
<%@ include file="/npage/include/header.jsp" %>
<!--BUSУ�鷵�ش���-->
<input type="hidden" name="bFCode" value="1">
<input type="hidden" name="bFMsg" value="1">

<div class="title">
    <div id="title_zi">��ѡ���������</div>
</div>
<table cellspacing="0">
<tbody>
<tr>
<td class="blue" nowrap width="25%">��������</td>

<td width="25%">
    <input type="radio" name="radiobutton" index="1" value="m479"
           onclick="clickRadio();" >��ͣ
</td>
<td width="25%">
    <input type="radio" name="radiobutton" index="2" value="m480"
           onclick="clickRadio();">��ͣ�ָ�
</td>
<td width="25%">
    <input type="radio" name="radiobutton" index="3" value="m481"
           onclick="clickRadio();">����
</td>
 
</tr>
</tbody>
</table>
</div>
<div id="Operation_Table"> 
			<div class="title">
				<div id="title_zi">�û���Ϣ</div>
			</div>
		<table cellspacing="0">
			<tr>
					<td  class="blue"> 
			    		<input type="radio" name="r_con" id="r_con" value="0"  index="9" checked>������� 
			    </td>
			    <td colspan=5>
			        <%if (workNo.substring(0, 1).trim().equals("kk")) {%>
			        <%String userPhoneNo = (String) session.getAttribute("userPhoneNo");%>
			        <input
			                id=Text2 type=text size=17 name=queryContent v_type="mobphone" v_name="�������" disabled maxlength=11 index="5"
			                onKeyUp="if(event.keyCode==13)submitt()" value="<%=userPhoneNo%>">
			        <%} else {%>
			        <input   id=Text2 type=text size=17 name="phoneNo" 
			         value="<%=activePhone%>"  class="InputGrey" readonly >
			        <%}%>
			     </td>
			</tr>
			<tr>
			    <td class="blue" width="20%" nowrap>�û�ID</td>
			    <td width="21%">
			        <input id=Text2 type=text size=17 name=userId class="InputGrey" readonly>
			    </td>
			    <td class="blue" width="12%" nowrap>��ǰ״̬</td>
			    <td width="21%">
			        <input type=text size=17 name=runName class="InputGrey" readonly>
			    </td>
			    <td class="blue" width="16%" nowrap>����</td>
			    <td>
			        <input type=text size=17 name=gradeName class="InputGrey" readonly>
			    </td>
			</tr>
			<tr>
			    <td class="blue">��ǰԤ��</td>
			    <td>
			        <input id=Text2 type=text size=17 name=totalPrepay class="InputGrey" readonly>
			    </td>
			    <td class="blue">��ǰǷ��</td>
			    <td>
			        <input id=Text2 type=text size=17 name=totalOwe class="InputGrey" readonly>
			    </td>
			    <td class="blue" nowrap>��ͻ���־</td>
			    <td>
			        <input type=text size=15 name=cardType class="InputGrey" readonly>
			    </td>
			</tr>
			<tr>
			    <td class="blue"> �ͻ�����</td>
			    <td>
			        <input type=text size=17 name=custName id="custName" class="InputGrey" readonly>
			    </td>
			    <td class="blue"> ��Ʒ����</td>
			    <td>
			        <input type=text size=17 name=productName class="InputGrey" readonly>
			    </td>
			    <td class="blue">�̻���½�˻�</td>
			    <td>
			        <input type=text size=17 name=cfmLogin id="cfmLogin" class="InputGrey" readonly>
			    </td>
			</tr>
			<tr id=noBackDiv style="display:none">
			    <td class="blue">������Ԥ��</td>
					<td>
			   			 <input id=Text2 type=text size=17 name=noBack class="InputGrey" readonly>
			    </td>
			    <td class="blue">����Ԥ��</td>
			    <td>
			        <input id=Text2 type=text size=17 name=backPrepay id="backPrepay" class="InputGrey" readonly>
			    </td>
			    <td class="blue">��Ϣ</td>
			    <td width="19%" colspan=2>
			        <input id=Text2 type=text size=17 name=lxPrepay class="InputGrey" readonly>
			    </td>
			</tr>
			<tr id=backDiv style="display:none">
			    <td class="blue">ת�����</td>
			    <td>
			        <input type=text maxlength="11" size=17 name=vPhoneNo>
			        <input class="b_text" type="button" name="qCustIdByPhone" value="��ѯ" onClick="m479GetByPhone(vPhoneNo)">
			    </td>
			    <td class="blue">ת���ʻ�</td>
			    <td width="19%" colspan=4>
			        <input type=text size=17 name=vConID class="InputGrey" readonly>
			    </td>
			</tr>
			<tr>
			    <td class="blue"> ֤������</td>
			    <td>
			        <input id=Text2 type=text size=17 name=iccName class="InputGrey" readonly>
			    </td>
			    <td class="blue">֤������</td>
			    <td>
			        <input id=Text2 type=text size=17 name=iccNo class="InputGrey" readonly>
			    </td>
			    <td class="blue">����ʱ��</td>
			    <td width="19%" colspan=2>
			        <input id=Text2 type=text size=25 name=innerTime class="InputGrey" readonly>
			    </td>
			</tr>
			<tr id="userOldResDiv1" style=display:none>
				<td  class="blue">�豸����</td>
				<td>
				  	<input id="deviceTypeOld" name="deviceTypeOld" readonly>
				</td>
				<td  class="blue">�豸����</td>  
				<td> 
					  <input id="deviceCodeOld" name="deviceCodeOld"  readonly> 
				</td> 
				<td  class="blue">�豸��װ��ַ</td>  
				<td> 
				  	<input id="deviceInAddressOld" name="deviceInAddressOld"  readonly> 
				 	  <input type="hidden" id="factoryOld" name="factoryOld" >
				</td> 
					 
			</tr>
			<tr id="userOldResDiv2" style=display:none>
				<td  class="blue"> �˿�����</td>
				<td>
				   	<input id="portTypeOld" name="portTypeOld" readonly>
				</td>
				<td class="blue"> �˿ڱ���</td>  
				<td> 
						<input id="portCodeOld" name="portCodeOld"   readonly> 
				</td>  
				<td class="blue" >ip��ַ</td>
				<td>
						<input id="ipAddressOld" name="ipAddressOld" readonly>
						<input type="hidden" id="modelOld" name="modelOld" >
				</td>	  	 
			</tr>
			
			<tr>
					<td class="blue">������</td>
					<td>
					    <input type="text" size=17 name=handFee id="handFee" readonly class="InputGrey" v_type=float v_name="������" index="7">
					</td>
					<td class="blue">ʵ��</td>
					<td colspan="3">
						<input id="factPay" type=text size=17 name="factPay" index="8" 
						 disabled v_type="money" />
					</td>
			</tr>
			<!--���ڱ���2013��9�µ�һ��ҵ��֧��ϵͳ�г�רҵ����ĺ�-�����ϱ�CRM��BOSS�;���ϵͳ�������ʾ hejwa add 2013��10��28��9:32:54-->
			<tr id="modemFlagTr" style="display:none">
					<td class="blue">�Ƿ񷵻ص��ƽ����</td>
					<td colspan=5>
								<input type="radio" name="iModemFlag"     value="1" checked /> ��
								<input type="radio" name="iModemFlag"     value="0" /> ��
					</td>
					 
			</tr>	
			
			<tr id=constructDiv style="display:none">
					<td class="blue">ʩ��Ҫ��</td>
					<td colspan=2>
								<input type="text" name="construct_request" id="construct_request"  maxlength=80>
					</td>
					<td class="blue" >&nbsp</td>
					<td colspan=2>
							<input type="hidden" name="appointTime" id="appointTime" value="<%=dateStr2%>" >
							&nbsp
					</td>
			</tr>	
			 <tr  id="tr_otreson_1" style="display:none"  >
				  	<td class="blue">����ԭ��</td>
				  <td colspan="5">
								<select id="sel_reasonDescription" style="width:300px;" name="sel_reasonDescription" onchange="set_otreson()">
										
										<option value="">--��ѡ��--</option>
								    <option value="1">����������Ǩ</option>
								    <option value="2">�ƶ������޷���������</option>
								    <option value="3">У԰�����</option>
								    <option value="4">��ҵ��У</option>
								    <option value="5">װά���񲻺�</option>
								    <option value="6">ת����ͨ�����š�ת�������̻��ʺ�</option>
								    <option value="7">�ʷѲ�����</option>
								    <option value="8">�ͻ�/�ھ�/��ҵ��ͬ�������ߡ����ߡ���ǽ</option>
								    <option value="9">�µ����޷���װ</option>
								    <option value="10">����ԭ��</option>

								</select>
						</td>
				  </tr>
				  
				  <tr id="tr_otreson" style="display:none">
				  	<td colspan="6" >
				  			<textarea id="textarea_otreson" name="textarea_otreson"  cols="140" rows="3" ></textarea>
				  			<font class="orange">ע����ѡ����ԭ������ȷд������ԭ��</font>
				  	</td>
				  </tr>
				  
				  			
			<tr>
					<td class="blue">ϵͳ��ע</td>
					<td colspan="5">
							<input id=Text3 type=text size=80 name=remark value="">
					</td>
			</tr>
			<tr  style="display:none">
					<td class="blue">�û���ע</td>
					<td colspan="5">
								<input id=Text2 type=text size=80 name=asNotes maxlength=60 onkeyup="value=value.replace(/[@#$%!^&*()<>?|]/g,'');" index="9">
					</td>
			</tr>
			<tr id="showMyMsg" style="display:none">
				<td colspan="6" ><font color="red">ע������Ʒ�ƵĹ̻��ڹ̻�����ʱ������û��˷ѡ�</font></td>
			</tr>   
		</table>
		
		<table cellSpacing="0">
		    <tbody>
		        <tr>
		            <td id="footer">
		                <input class="b_foot" name=submit type=button value="ȷ��" index="10"
		                       onKeyUp="if(event.keyCode==13){formSubmitCfm()}" onclick="formSubmitCfm()" disabled>
		                &nbsp;&nbsp;
		                <input class="b_foot" name=back type=button value="���" onclick="go_reset()">
		                &nbsp;&nbsp;
		                <input class="b_foot" name=back type=button value="�ر�" onclick="parent.removeTab('<%=opCode%>')">
		                &nbsp;&nbsp;
		            </td>
		        </tr>
		    </tbody>
		</table>
<input type=hidden name=opCode>
<input type=hidden name=workNo value=<%=workNo%>>
<input type=hidden name=noPass value=<%=nopass%>>
<input type=hidden name=orgCode value=<%=orgCode%>>
<input type=hidden name=iChnSource id="iChnSource" value=<%=iChnSource%>>  <!--������ʶ-->
<input type=hidden name=iUserPwd id="iUserPwd" value=<%=iUserPwd%>>  <!--�������� -->
<input type=hidden name=sysRemark value="�̻��ۺϱ��">
<input type=hidden name=ipAdd id="ipAdd" value="<%=request.getRemoteAddr()%>">
<input type=hidden name=handFeeT><!--������-->
<input type=hidden name=customPass><!--�û�����-->
<input type=hidden name=idCardNo><!--֤������-->
<input type=hidden name=custAddress id="custAddress">
<input type=hidden name=backLoginAccept><!--�����ɹ�����ˮ��-->
<input type=hidden name=backDate>
<input type=hidden name=favFlag value="<%=favFlag%>">
<input type=hidden name=loginAccept id="loginAccept"><!--������ˮ��-->
<input type=hidden name=smName>
<input type=hidden name=cctIdOld id="cctIdOld"><!--���žֱ���-->
<input type=hidden name=isConstruct value="1"><!--�Ƿ�ʩ����־-->
<input type="hidden" name="radioValue" value=""><!--ѡ���opcode-->
<input type="hidden" name="radioIndex" value=""><!--ѡ��Ĳ�����˳���-->
<input type="hidden" name="bindId" id="bindId" value="">
<!-- 2014/04/04 11:15:23 gaopeng Ʒ��sm_code -->
<input type="hidden" name="pubSmCode" id="pubSmCode" value="" />
		
<div id="relationArea" style="display:none"></div>
			<div id="wait" style="display:none">
			<img  src="/nresources/default/images/blue-loading.gif" />
		</div>
		<div id="beforePrompt"></div>       
<%@ include file="/npage/include/footer_simple.jsp" %>
</FORM>
<OBJECT classid="clsid:2F593576-E694-46B5-BF4F-9F23C1020642" height=1 id=evalControl width=1>
</OBJECT> 
</BODY>
</HTML>
<script>
/*���������ӡ**/
function printCommit()
{
			/*��ȡƷ��sm_code*/
			getPubSmCode($("#cfmLogin").val());
			var ret = showPrtDlg("Detail", "ȷʵҪ���е��������ӡ��", "Yes");
		
	  iRetrun = showEvalConfirmDialog('ȷ��Ҫ���д��������');
	  if (iRetrun == 1)
	  {
	      if (document.frm.cardType.value.indexOf("�и߶��û�", 0) >= 0 && document.frm.opCode.value == "b544") {
	          if (rdShowConfirmDialog('���û����и߶��û���ȷ��Ҫ������') == 1) {
	              printFlag = 1;
	              return true;
	          }
	      } else {
	          printFlag = 1;
	          return true;
	      }
	  } else if (iRetrun == 2)
	  { 
	      if (document.frm.cardType.value.indexOf("�и߶��û�", 0) >= 0 && document.frm.opCode.value == "b544") {
	          if (rdShowConfirmDialog('���û����и߶��û���ȷ��Ҫ������') == 1) {
	              printFlag = 2;
	              return true;
	          }
	      } else {
	          printFlag = 2;
	          return true;
	      }
	  }else{
	  	return false;
	  }
}
function showPrtDlg(printType, DlgMessage, submitCfn)
{  //��ʾ��ӡ�Ի��� 
	var h=210;
	var w=400;
    var t = screen.availHeight / 2 - h / 2;
    var l = screen.availWidth / 2 - w / 2;
    var opCode=$("input[@name=radiobutton][@checked]").val();
	var pType="subprint";
	var billType="1";
	var mode_code=null;
	var fav_code=null;
	var area_code=null;
	var sysAccept = document.frm.loginAccept.value;
    var printStr = printInfo(printType);
    var iRetrun = 0;
    var prop = "dialogHeight:" + h + "px; dialogWidth:" + w + "px; dialogLeft:" + l + "px; dialogTop:" + t + "px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no"
	var path = "<%=request.getContextPath()%>/npage/innet/hljBillPrint_jc_hw.jsp?DlgMsg=" + DlgMessage;
    var path = path  + "&mode_code="+mode_code+"&fav_code="+fav_code+"&area_code="+area_code+"&opCode="+opCode+"&sysAccept="+sysAccept+"&phoneNo=<%=activePhone%>&submitCfm=" + submitCfn+"&pType="+pType+"&billType="+billType+ "&printInfo=" + printStr;
    var ret = window.showModalDialog(path, printStr, prop);
}

/*2014/04/04 11:02:20 gaopeng ���ù�����ѯ����Ʒ��sm_code*/
function getPubSmCode(kdNo){
		var getdataPacket = new AJAXPacket("/npage/public/pubGetSmCode.jsp","���ڻ�����ݣ����Ժ�......");
		getdataPacket.data.add("phoneNo","");
		getdataPacket.data.add("kdNo",kdNo);
		core.ajax.sendPacket(getdataPacket,doPubSmCodeBack);
		getdataPacket = null;
}
function doPubSmCodeBack(packet){
	retCode = packet.data.findValueByName("retcode");
	retMsg = packet.data.findValueByName("retmsg");
	smCode = packet.data.findValueByName("smCode");
	if(retCode == "000000"){
		$("#pubSmCode").val(smCode);
	}
}

function printInfo(printType)
{
	
		var retInfo = "";
    if (printType == "Detail"){
			var cust_info="";
			var opr_info="";
			var note_info1="";
			var note_info2="";
			var note_info3="";
			var note_info4="";        
			cust_info += "�̻��ʺţ�" + $("#cfmLogin").val() + "|";
			cust_info += "�ͻ�������" + document.all.custName.value + "|";
			
			var pubSmCode = $("#pubSmCode").val();
			
			for (var i = 0; i < document.frm.radiobutton.length; i ++) {
				if (document.all.radiobutton[i].checked){
					
					var appendStr = "����1��";
					if(pubSmCode == "kh"){
						appendStr = "��һ������";
					}
					
					
					var radio1 = document.all.radiobutton[i].value
					//alert(radio1);
					if (radio1 == "m479"){
					  opr_info += "ҵ������ʱ�䣺<%=dateStr2222%>" + "|";	
						opr_info += "����ҵ����ͣ" + "|";
						opr_info += "������ˮ��" + document.frm.loginAccept.value + "|";
						opr_info += "ҵ����Чʱ��:ԤԼ��Ч|";//��"+appendStr+"��ʼִ����ͣ����" + "|";	
									
					} else if (radio1 == "m480") {
						opr_info += "ҵ������ʱ�䣺<%=dateStr2222%>" + "|";
						opr_info += "����ҵ�񣺸���" + "|";
						opr_info += "������ˮ��" + document.frm.loginAccept.value + "|";
						opr_info += "ҵ����Чʱ�䣺������Ч" + "|";
					} else if (radio1 == "m481") {
						cust_info += "�ͻ���ַ��" + $("#custAddress").val() + "|";
						opr_info += "����ҵ������" + "|";
						opr_info += "������ˮ��" + document.frm.loginAccept.value + "|";
						/* 
					   * ����Э������ʡ�������̻�����Ӫ�������ں��ײ�����ĺ�����Ʒ���֣�@2014/7/24 
					   * ����ʡ���kg������Ʒ��kh
					   */
						if(pubSmCode == "kf" || pubSmCode == "kg" || pubSmCode == "kh" || pubSmCode == "ki"){
						}else{
							//note_info2 += "����Ԥ����24Сʱ�ڼ�ֹͣʹ�á�Ԥ�����µķ��ð���ʱ���ʷѱ�׼������ȡ��Ԥ��30�����������˳���Ч֤�������ڵ���ʣ�����Ԥ��Ʊ��Ӫҵ��������ʽ����������" + "|";
						}
					} else if (radio1 == "b544") {
						opr_info += "����ҵ������" + "|";
						opr_info += "������ˮ��" + document.frm.loginAccept.value + "|";
						opr_info += "�˷ѽ�" + document.frm.backPrepay.value + "Ԫ|";
						/* 
					   * ����Э������ʡ�������̻�����Ӫ�������ں��ײ�����ĺ�����Ʒ���֣�@2014/7/24 
					   * ����ʡ���kg������Ʒ��kh
					   */
						if(pubSmCode == "kf" || pubSmCode == "kg" || pubSmCode == "kh" || pubSmCode == "ki"){
						}else{
							note_info2 += "���������������Ҫ�����»ָ���ҵ�񣬽��������û�����̻�ҵ�����̰���" + "|";
						}
						
					}else{
						opr_info +="|";
					}
				}
			}
			/*2014/04/09 9:39:49 gaopeng �޸���� �ƶ���ͥ�ͻ��̻�ҵ����Ӫ֧��ϵͳ����*/
			note_info1 += ""+"|";
			note_info1 += "��ע��"+"|";
			/* 
		   * ����Э������ʡ�������̻�����Ӫ�������ں��ײ�����ĺ�����Ʒ���֣�@2014/7/24 
		   * ����ʡ���kg������Ʒ��kh
		   */
			if(pubSmCode == "kf" || pubSmCode == "kg" || pubSmCode == "kh" || pubSmCode == "ki"){
				if (radio1 == "m479"){
					note_info1 += "1���û�������һ����Ӧ���˽�ͬʱ�뽻��10Ԫ��ͣ������+30ԪԤ��������ͣҵ�񷽿���Ч����ͣ��ȡ10Ԫ�����ѣ�"+"|";
					note_info1 += "��ͣ�ڼ����ȡ10Ԫ/��ͣ��ͨ��ռ�÷ѣ���Ԥ����пɿ۳�������һ���°�һ���¼ƣ�"+"|";
					note_info1 += "2����ͣ���뵱�·��ð���ʱ�ʷѱ�׼������ȡ��|";//��"+appendStr+"��ʼִ����ͣ����"+"|";
					note_info1 += "3����ͣ�����Ϊ90�죬�������û�û��������������ϵͳ�Զ��ָ�������ʵ�б���ͣǰ�ʷѡ����û�������������������Ч�����°�����ͣ��ʱ���ʷѱ�׼��ȡ��"+"|";
					note_info1 += "4���̻�ҵ����ʱ�䰴��ͣ����������˳�ӣ�����ͣ2����10�졢����ʱ��˳��2���£��Դ����ƣ�"+"|";
					note_info1 += "5��һ��������2�α���ͣ��"+"|";
					note_info1 += "6�����ֻ�Ӫ��������Ĺ̻���������ͣ�ӳ���Ч�ڡ�"+"|";
					note_info1 += "7������ϵ�绰�䶯ʱ���뼰ʱ���ƶ���˾��ϵ���Ա������»�������ʱ��ʱ�յ�֪ͨ��"+"|";
					note_info1 += "8������������벦��������ߣ�10086��"+"|";
				}else if(radio1 == "m480"){
					note_info1 += "1���û�����������������Ч�����°�����ͣ��ʱ���ʷѱ�׼��ȡ��"+"|";
					note_info1 += "2������ϵ�绰�䶯ʱ���뼰ʱ���ƶ���˾��ϵ���Ա������»�������ʱ��ʱ�յ�֪ͨ��"+"|";
					note_info1 += "3������������벦��������ߣ�10086��"+"|";
					
				}else if(radio1 == "m481"){
					//note_info1 += "1������Ԥ����24Сʱ�ڼ�ֹͣʹ�á�Ԥ�����µķ��ð���ʱ���ʷѱ�׼������ȡ��Ԥ��30�����������˳���Ч֤�������ڵ���ʣ�����Ԥ��Ʊ��Ӫҵ��������ʽ����������"+"|";
					//note_info1 += "2������ϵ�绰�䶯ʱ���뼰ʱ���ƶ���˾��ϵ���Ա������»�������ʱ��ʱ�յ�֪ͨ��"+"|";
					//note_info1 += "3������������벦��������ߣ�10086��"+"|";
					
				}else if(radio1 == "b544"){
					note_info1 += "1�����������������Ҫ�����»ָ���ҵ�񣬽��������û��������̰���"+"|";
					note_info1 += "2������������벦��������ߣ�10086��"+"|";
					
				}
			}
			//retInfo = cust_info+"#"+opr_info+"#"+note_info1+"#"+note_info2+"#"+note_info3+"#"+note_info4+"#";
			retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
			retInfo=retInfo.replace(new RegExp("#","gm"),"%23");
		}

    return retInfo;
}
function printBill() {
        var infoStr = "";
        infoStr += " " + "|";
        infoStr += '<%=new java.text.SimpleDateFormat("yyyy", Locale.getDefault()).format(new java.util.Date())%>' + "|";
        infoStr += '<%=new java.text.SimpleDateFormat("MM", Locale.getDefault()).format(new java.util.Date())%>' + "|";
        infoStr += '<%=new java.text.SimpleDateFormat("dd", Locale.getDefault()).format(new java.util.Date())%>' + "|";
        infoStr += document.frm.phoneNo.value + "|";//�ƶ�����                                                                                                    
        infoStr += "" + "|";//��ͬ����                                                          
        infoStr += document.frm.custName.value + "|";//�û�����                                                
        infoStr += document.frm.custAddress.value + "|";//�û���ַ  
        infoStr += "�ֽ�" + "|";
        infoStr += document.frm.handFee.value + "|";
        infoStr += document.frm.sysRemark.value + "��*�����ѣ�" + document.frm.handFee.value + "*��ˮ�ţ�" + document.frm.backLoginAccept.value + "|";
	      //rdShowMessageDialog("-"+infoStr+"-");
        location.href = "chkPrint.jsp?retInfo=" + infoStr + "&dirtPage=fm480_1.jsp";
}
function showBroadBill(printType,DlgMessage,submitCfm){
	
	var pubSmCode = $("#pubSmCode").val();
	var printInfo = "";
	var prtLoginAccept = $("#loginAccept").val();
	var custName = $("#custName").val();
	var cashPay = $("#factPay").val();
	var broadNo = $("#cfmLogin").val();
	var printStr = "";
	var opName = "";
	
	if(document.frm.opCode.value == "m479"){
		printStr = "��ͣ�����ѣ�";
		opName = "�̻�ҵ����ͣ";
	}else if(document.frm.opCode.value == "m480"){
		printStr = "���������ѣ�";
		opName = "�̻�ҵ����ͣ�ָ�";
	}else if(document.frm.opCode.value == "m481" ){
		printStr = "�˷ѽ�";
		opName = "�̻�����";
		cashPay = document.frm.backPrepay.value;
	}else{
		printStr = "�˷ѽ�";
		opName = "�̻�����";
		cashPay = document.frm.backPrepay.value;
	}
	printInfo += "<%=new java.text.SimpleDateFormat("yyyy",Locale.getDefault()).format(new java.util.Date())%>" + "|";
	printInfo += "<%=new java.text.SimpleDateFormat("MM",Locale.getDefault()).format(new java.util.Date())%>" + "|";
	printInfo += "<%=new java.text.SimpleDateFormat("dd",Locale.getDefault()).format(new java.util.Date())%>" + "|";
	printInfo += prtLoginAccept + "|";
	printInfo += custName + "|";
	printInfo += " " + "|";
	printInfo += " " + "|";
	printInfo += broadNo + "|";
	printInfo += " " + "|";
	printInfo += cashPay + "|";
	printInfo += cashPay + "|";
	printInfo += opName + "|";
	printInfo += printStr + cashPay + "Ԫ" + "~";
	/* 
   * ����Э������ʡ�������̻�����Ӫ�������ں��ײ�����ĺ�����Ʒ���֣�@2014/7/24 
   * ����ʡ���kg������Ʒ��kh
   */
	if(pubSmCode == "kf" || pubSmCode == "kg" || pubSmCode == "kh" || pubSmCode == "ki"){
		printInfo += "�ͷ����ߣ�10086" + "|";
	}else{
		printInfo += "�ͷ����ߣ�10050" + "~";
		printInfo += "��ַ��http://www.10050.net" + "|";
	}
		var  billArgsObj = new Object();
	    $(billArgsObj).attr("10001","<%=workNo%>");       //����
 		$(billArgsObj).attr("10002","<%=new java.text.SimpleDateFormat("yyyy",Locale.getDefault()).format(new java.util.Date())%>");
 		$(billArgsObj).attr("10003","<%=new java.text.SimpleDateFormat("MM",Locale.getDefault()).format(new java.util.Date())%>");
 		$(billArgsObj).attr("10004","<%=new java.text.SimpleDateFormat("dd",Locale.getDefault()).format(new java.util.Date())%>");
 		$(billArgsObj).attr("10005",custName); //�ͻ�����
 		$(billArgsObj).attr("10006",opName); //ҵ�����
 		$(billArgsObj).attr("10008","<%=activePhone%>"); //�û�����
 		
 		
 		if(document.frm.opCode.value == "m479"||document.frm.opCode.value == "m480"){
 			$(billArgsObj).attr("10015", cashPay); //���η�Ʊ���(Сд)��
 			$(billArgsObj).attr("10016", cashPay); //��д���ϼ�
 		} 
 		var sumtypes1="*";
 		var sumtypes2="";
 		var sumtypes3="";
 		$(billArgsObj).attr("10017",sumtypes1); //���νɷ��ֽ�
 		$(billArgsObj).attr("10018",sumtypes2); //֧Ʊ
 		$(billArgsObj).attr("10019",sumtypes3); //ˢ��
 
 		
 		if(document.frm.opCode.value == "m481"){
 			 			
 			$(billArgsObj).attr("10021", cashPay);
 			$(billArgsObj).attr("10015", cashPay); //���η�Ʊ���(Сд)��
 			$(billArgsObj).attr("10016", cashPay); //��д���ϼ�
 			
 		}
 		$(billArgsObj).attr("10030",prtLoginAccept); //��ˮ��--ҵ����ˮ
 		$(billArgsObj).attr("10036",document.frm.opCode.value); //��������
 		$(billArgsObj).attr("10074","<%=id_no%>"); 
 		$(billArgsObj).attr("10075","<%=contract_no%>"); 
 		$(billArgsObj).attr("10007","<%=smcode%>"); 
 		var path = "";
	 	/* 
	   * ����Э������ʡ�������̻�����Ӫ�������ں��ײ�����ĺ�����Ʒ���֣�@2014/7/24 
	   * ����ʡ���kg������Ʒ��kh
	   */
	 
 		if(pubSmCode == "kf" || pubSmCode == "kg" || pubSmCode == "kh" || pubSmCode == "ki"){
 			//path = "/npage/public/pubBillPrintCfm_YGZ.jsp?dlgMsg=" + "��Ʊ��ӡ";
 						//��Ʊ��Ŀ�޸�Ϊ��·��
			var path = "/npage/public/billPrtNew/Bill_ELE_Prt.jsp?dlgMsg=" + "��Ʊ��ӡ";
	
		}else{
			path = "/npage/public/pubBillPrintBroad.jsp?dlgMsg=" + "��Ʊ��ӡ";
		}
	var h=210;
	var w=400;
	var t=screen.availHeight/2-h/2;
	var l=screen.availWidth/2-w/2;
	var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no" 
	var loginAccept = prtLoginAccept;
	var path = path + "&infoStr="+printInfo+"&loginAccept="+loginAccept+"&opCode=<%=opCode%>&submitCfm=submitCfm&phoneNo=<%=activePhone%>";
	var ret = window.showModalDialog(path,billArgsObj,prop);
}
function printTwoBill() {
		 var infoStr = "";
		 infoStr += " " + "|";
		 if (document.frm.backPrepay.value.length == 0) {
		     document.frm.backPrepay.value = 0;
		 }
		 if (document.frm.lxPrepay.value.length == 0) {
		     document.frm.lxPrepay.value = 0;
		 }
		 infoStr += '<%=new java.text.SimpleDateFormat("yyyy", Locale.getDefault()).format(new java.util.Date())%>' + "|";
		 infoStr += '<%=new java.text.SimpleDateFormat("MM", Locale.getDefault()).format(new java.util.Date())%>' + "|";
		 infoStr += '<%=new java.text.SimpleDateFormat("dd", Locale.getDefault()).format(new java.util.Date())%>' + "|";
		 infoStr += document.frm.phoneNo.value + "|";//�ƶ�����                                                                                                    
		 infoStr += document.frm.backPrepay.value + "*" + document.frm.lxPrepay.value + "*" + document.frm.noBack.value + "|";//��ͬ����                                                          
		 infoStr += document.frm.custName.value + "|";//�û�����                                                
		 infoStr += document.frm.custAddress.value + "|";//�û���ַ  
		 infoStr += "�ֽ�" + "|";
		 infoStr += document.frm.handFee.value + "|";
		 infoStr += document.frm.sysRemark.value + "��*�����ѣ�" + document.frm.handFee.value + "*��ˮ�ţ�" + document.frm.backLoginAccept.value + "|";
		 location.href = "chkTwoPrint.jsp?retInfo=" + infoStr + "&dirtPage=fm480_1.jsp&activePhone=<%=activePhone%>";
}
function printTwoBillZero() {
    var infoStr = "";
    infoStr += " " + "|";
    if (document.frm.backPrepay.value.length == 0) {
        document.frm.backPrepay.value = 0;
    }
    if (document.frm.lxPrepay.value.length == 0) {
        document.frm.lxPrepay.value = 0;
    }
    infoStr += '<%=new java.text.SimpleDateFormat("yyyy", Locale.getDefault()).format(new java.util.Date())%>' + "|";
    infoStr += '<%=new java.text.SimpleDateFormat("MM", Locale.getDefault()).format(new java.util.Date())%>' + "|";
    infoStr += '<%=new java.text.SimpleDateFormat("dd", Locale.getDefault()).format(new java.util.Date())%>' + "|";
    infoStr += document.frm.phoneNo.value + "|";//�ƶ�����                                                                                                    
    infoStr += document.frm.backPrepay.value + "*" + document.frm.lxPrepay.value + "*" + document.frm.noBack.value + "|";//��ͬ����                                                           
    infoStr += document.frm.custName.value + "|";//�û�����                                                
    infoStr += document.frm.custAddress.value + "|";//�û���ַ  
    infoStr += "�ֽ�" + "|";
    infoStr += document.frm.handFee.value + "|";
    infoStr += document.frm.sysRemark.value + "��*�����ѣ�" + document.frm.handFee.value + "*��ˮ�ţ�" + document.frm.backLoginAccept.value + "|";
    location.href = "chkTwoPrintZero.jsp?retInfo=" + infoStr + "&dirtPage=fm480_1.jsp&activePhone=<%=activePhone%>";
}
function printThreeBill() {
    var infoStr = "";
    infoStr += document.frm.remark.value + "|";
    infoStr += '<%=new java.text.SimpleDateFormat("yyyy", Locale.getDefault()).format(new java.util.Date())%>' + "|";
    infoStr += '<%=new java.text.SimpleDateFormat("MM", Locale.getDefault()).format(new java.util.Date())%>' + "|";
    infoStr += '<%=new java.text.SimpleDateFormat("dd", Locale.getDefault()).format(new java.util.Date())%>' + "|";
    infoStr += document.frm.phoneNo.value + "|";//�ƶ�����                                                                                                    
    infoStr += document.frm.backPrepay.value + "|";//����Ԥ��                                                          
    infoStr += document.frm.custName.value + "|";//�û�����                                                
    infoStr += document.frm.custAddress.value + "|";//�û���ַ  
    infoStr += document.frm.idCardNo.value + "|";//֤������
    infoStr += document.frm.handFee.value + "|";
    infoStr += document.frm.sysRemark.value + "��*�����ѣ�" + document.frm.handFee.value + "*��ˮ�ţ�" + document.frm.backLoginAccept.value + "|";
		//infoStr+=document.frm.backDate.value+"|";
    //rdShowMessageDialog(document.frm.backDate.value);
    location.href = "chkThreePrint.jsp?backDate=" + document.frm.backDate.value + "&retInfo=" + infoStr + "&dirtPage=fm480_1.jsp&activePhone=<%=activePhone%>";
}
function printThreeBillZero() {
    var infoStr = "";
    infoStr += document.frm.remark.value + "|";
    infoStr += '<%=new java.text.SimpleDateFormat("yyyy", Locale.getDefault()).format(new java.util.Date())%>' + "|";
    infoStr += '<%=new java.text.SimpleDateFormat("MM", Locale.getDefault()).format(new java.util.Date())%>' + "|";
    infoStr += '<%=new java.text.SimpleDateFormat("dd", Locale.getDefault()).format(new java.util.Date())%>' + "|";
    infoStr += document.frm.phoneNo.value + "|";//�ƶ�����                                                                                                    
    infoStr += document.frm.backPrepay.value + "|";//����Ԥ��                                                          
    infoStr += document.frm.custName.value + "|";//�û�����                                                
    infoStr += document.frm.custAddress.value + "|";//�û���ַ  
    infoStr += document.frm.idCardNo.value + "|";//֤������
    infoStr += document.frm.handFee.value + "|";
    infoStr += document.frm.sysRemark.value + "��*�����ѣ�" + document.frm.handFee.value + "*��ˮ�ţ�" + document.frm.backLoginAccept.value + "|";
    //infoStr+=document.frm.backDate.value+"|";
    //rdShowMessageDialog(document.frm.backDate.value);
    location.href = "chkThreePrintZero.jsp?backDate=" + document.frm.backDate.value + "&retInfo=" + infoStr + "&dirtPage=fm480_1.jsp&activePhone=<%=activePhone%>";
}
</script>


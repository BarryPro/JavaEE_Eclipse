<%
    /********************
     version v2.0
     ������: si-tech
     *
     *update:zhanghonga@2008-08-27 ҳ�����,�޸���ʽ
     *     
     ********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%
    String opCode=request.getParameter("opCode");
		String opName=request.getParameter("opName");
    
    String orgCode = (String)session.getAttribute("orgCode");
    String regionCode = orgCode.substring(0,2);
    String workName = (String)session.getAttribute("workName");
    String sqIdtype = "select id_type,id_name from sidtype";
    String accountType = (String)session.getAttribute("accountType"); //1 ΪӪҵ���� 2 Ϊ�ͷ�����
    String display = "";
    System.out.println("accountType="+accountType);
    if("2".equals(accountType.trim())){
    	display ="style = \"display:none\"";
    }
    String display2 = "style = \"display:none\"";//����ͣ(1213)������ҵ������@2014/1/15 
    System.out.println("display="+display);
    String accountTypeTrim = accountType.trim();/*ȥ�ո�*/
%>
		<wtc:pubselect name="sPubSelect" routerKey="phone" routerValue="<%=activePhone%>" outnum="2">
		<wtc:sql><%=sqIdtype%></wtc:sql>
		</wtc:pubselect>
		<wtc:array id="sIdTypeStr" scope="end" />
<%
    String workNo = (String) session.getAttribute("workNo");
    String nopass = (String) session.getAttribute("password");
    String iChnSource = "01";
    String iUserPwd = "";
    String[][] favInfo = (String[][])session.getAttribute("favInfo");

	/****
	//��Ϊ������У��ͳһ�ŵ������ȥ��.������Է���
	int favFlag = 0;
	for (int i = 0; i < favInfo.length; i++) {
		if (favInfo[i][0].trim().equals("a272")) {
		    favFlag = 1;
		}
	}
	***/
	 /***begin  ���ݿ���ʱ�䣬��ȡͣ������(��)�����·ݵ���һ���µĵ�һ�죺���ֱ�ͣ��ʱ�������ڵġ���ͣ6����Ȼ�¡�����Ϊ����ͣ7����Ȼ�¡���@2013/1/17 ***/
	  String addMonthsStr = "";
	  String addMonthsY = "";
	  String addMonthsM = "";
    String addMonthsSql = "select to_char(add_months(sysdate,7),'yyyyMM') from dual ";
    
%>
    <wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode_addMonths" retmsg="retMsg_addMonths" outnum="1"> 
      <wtc:param value="<%=addMonthsSql%>"/>
    </wtc:service>  
    <wtc:array id="addMonthsArr"  scope="end"/>
<%
    if("000000".equals(retCode_addMonths)){
      if(addMonthsArr.length>0){
        addMonthsStr = addMonthsArr[0][0];
      }
    }
    if(!("".equals(addMonthsStr))&&addMonthsStr!=null){
      if(addMonthsStr.length()>0){
        addMonthsY = addMonthsStr.substring(0,4);
        addMonthsM = addMonthsStr.substring(4,addMonthsStr.length());
      }
    }
    /***end  ���ݿ���ʱ�䣬��ȡͣ�����ŵ���ʱ��@2013/1/17 ***/
    
    int favFlag = 1;
    String org_codeT = orgCode;
    String region_codeT = org_codeT.substring(0, 2);
    String feeSql = "select function_code, hand_fee from sNewFunctionFee where region_code = '" + region_codeT + "'";
%>
		<wtc:pubselect name="sPubSelect" routerKey="phone" routerValue="<%=activePhone%>" outnum="2">
		<wtc:sql><%=feeSql%></wtc:sql>
		</wtc:pubselect>
		<wtc:array id="fee" scope="end" />

<HEAD>
    <TITLE>��ͣ����ʧ�͸���</TITLE>

<script language="javascript">
var printFlag = 9;
var flag = 0;

onload = function() {

}

function doProcess(packet) {

    var backString = packet.data.findValueByName("backString");
    var cfmFlag = packet.data.findValueByName("flag");
    /***
    if (cfmFlag == 99) {
        if (backString == 1) {
            rdShowMessageDialog("��֤�ɹ���",2);
            document.frm.submit.disabled = false;
        } else {
            rdShowMessageDialog("���벻��ȷ��");
            document.frm.submit.disabled = true;
        }
    }
    ***/
    
    if (cfmFlag == 1) {
        var errMsg = packet.data.findValueByName("errMsg");
        var errCode = packet.data.findValueByName("errCode");
        var errCodeInt = parseInt(errCode, 10);
        if (errCodeInt == 0) {
            rdShowMessageDialog("�����ɹ���",2);
            document.frm.backLoginAccept.value = backString[0][0];
            if (document.frm.handFee.value != 0) {
                printBill();
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
            document.frm.remain.value = "";
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
            document.frm.asCustName.value = "";
            document.frm.asCustPhone.value = "";
            document.frm.asIdType.options[0].selected = true;
            document.frm.asIdIccid.value = "";
            document.frm.asIdAddress.value = "";
            document.frm.asContractAddress.value = "";
            document.frm.asNotes.value = "";
            document.frm.productName.value = "";
            document.frm.loginAccept.value = "";
               
            document.frm.family_code.value = "";
            document.frm.family_order.value = "";
            document.frm.family_count.value = "";
            
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
    if (cfmFlag == 9) {
        var errCode = packet.data.findValueByName("errCode");
        var errMsg = packet.data.findValueByName("errMsg");
        rdShowMessageDialog(errCode + " : " + errMsg);
        /*** ningtn CRM�ͷ�ϵͳ
        document.frm.qry.disabled = false;
				*/
        var ii = 0 ;
        for (ii = 0; ii < document.frm.radiobutton.length; ii ++) {
            document.all.radiobutton[ii].disabled = false;
        }
        flag = 0;
        return;
    }

    if (cfmFlag == 0) {

        var errMsg = packet.data.findValueByName("errMsg");
        var errCode = packet.data.findValueByName("errCode");
        var errCodeInt = parseInt(errCode, 10);

        document.frm.smName.value = backString[0][2];
        document.frm.customPass.value = backString[0][4];
        document.frm.userId.value = backString[0][0];
        document.frm.runName.value = backString[0][6];
        document.frm.gradeName.value = backString[0][8];
        document.frm.totalPrepay.value = backString[0][17];
        document.frm.totalOwe.value = backString[0][16];
        document.frm.custName.value = backString[0][3];
        document.frm.custAddress.value = backString[0][11];
        document.frm.cardType.value = backString[0][15];
        document.frm.idCardNo.value = backString[0][14];
        document.frm.iccNo.value = backString[0][14];
        document.frm.iccName.value = backString[0][13];
        document.frm.innerTime.value = backString[0][23];
        document.frm.backPrepay.value = backString[0][21];
        document.frm.lxPrepay.value = backString[0][22];
        document.frm.backDate.value = backString[0][24];
        if (document.frm.cardType.value.indexOf("�и߶��û�", 0) >= 0) {
            rdShowMessageDialog("���û����и߶��û���");
        }

        document.frm.asCustName.value = backString[0][25];
        document.frm.asCustPhone.value = backString[0][26];


        var idI = 0 ;
        for (idI = 0; idI < document.frm.asIdType.length; idI ++) {

            if (document.frm.asIdType.options[idI].value == backString[0][27]) {
                document.frm.asIdType.options[idI].selected = true;
            }
        }
        document.frm.asIdIccid.value = backString[0][28];
        document.frm.asIdAddress.value = backString[0][29];
        document.frm.asContractAddress.value = backString[0][30];
        document.frm.asNotes.value = backString[0][31];
        document.frm.noBack.value = backString[0][32];
        document.frm.productName.value = backString[0][33];
        document.frm.loginAccept.value = backString[0][34];
        $("#hwAccept").val(backString[0][34]);
        document.frm.family_code.value =backString[0][35];
        document.frm.family_order.value = backString[0][36];
        document.frm.family_count.value = backString[0][37];

        document.frm.factPay.disabled = false;
        flag = 1;
        if (errCode == 0) {
            if (document.frm.favFlag.value == 1) {
                document.frm.submit.disabled = false;
            }
        }
        if(document.frm.opCode.value=="m394"){
        	var myPacket = new AJAXPacket("getTx.jsp", "�����ύ�����Ժ�......");
        	myPacket.data.add("iLoginAccept", document.frm.loginAccept.value);							//��ˮ              
        	myPacket.data.add("iChnSource", document.frm.iChnSource.value);									//������ʶ          
        	myPacket.data.add("iOpCode", document.frm.opCode.value);												//��������          
        	myPacket.data.add("iLoginNo", document.frm.workNo.value);												//��������	        
        	myPacket.data.add("iLoginPwd", document.frm.noPass.value);											//��������	        
        	myPacket.data.add("iPhoneNo", document.frm.phoneNo.value); 											//�ֻ�����	        
        	myPacket.data.add("iUserPwd", document.frm.iUserPwd.value);											//��������       
            core.ajax.sendPacket(myPacket,do_getTx);
            myPacket=null;
        }
        if (errCode != 0) {
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
                /*** ningtn CRM�ͷ�ϵͳ
                document.frm.qry.disabled = false;
                **/
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
                document.frm.remain.value = "";
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
                document.frm.asCustName.value = "";
                document.frm.asCustPhone.value = "";
                document.frm.asIdType.options[0].selected = true;
                document.frm.asIdIccid.value = "";
                document.frm.asIdAddress.value = "";
                document.frm.asContractAddress.value = "";
                document.frm.asNotes.value = "";
                document.frm.productName.value = "";
                document.frm.loginAccept.value = "";
                flag = 0;

        }
    }


}

function do_getTx(packet){
	var error_code = packet.data.findValueByName("code");//���ش���
    var error_msg =  packet.data.findValueByName("msg");//������Ϣ
    if(error_code=="000000"){//�����ɹ�
	    $("#promptPhoneNo").val(packet.data.findValueByName("promptPhoneNo"));
    }
}
function submitt() {

    //added by hanfa 20070117
    for (var i = 0; i < document.frm.radiobutton.length; i++)
    {
        if (document.frm.radiobutton[i].checked)
        {
            document.all.radioValue.value = document.frm.radiobutton[i].value;
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
		/*** ningtn CRM�ͷ�ϵͳ
    document.frm.qry.disabled = true;
    ***/
    var ii = 0 ;
    for (ii = 0; ii < document.frm.radiobutton.length; ii ++) {
        document.all.radiobutton[ii].disabled = true;
    }
    var myPacket = new AJAXPacket("getUserInfo.jsp", "�����ύ�����Ժ�......");
    myPacket.data.add("loginAccept", document.frm.loginAccept.value);
    myPacket.data.add("iChnSource", document.frm.iChnSource.value);
    myPacket.data.add("opCode", document.frm.opCode.value);
    myPacket.data.add("workNo", document.frm.workNo.value);
    myPacket.data.add("opCode", document.frm.opCode.value);
    myPacket.data.add("phoneNo", document.frm.phoneNo.value);
    myPacket.data.add("iUserPwd ", document.frm.iUserPwd .value);    
    core.ajax.sendPacket(myPacket);
    myPacket=null;
}
function getRemain() {

    if (flag != 1) {
        rdShowMessageDialog("���Ȳ�ѯ�û���Ϣ��");
        return;
    }


    if (parseFloat(document.frm.handFee.value) > parseFloat(document.frm.handFeeT.value)) {
        rdShowMessageDialog("�����Ѳ��ܴ���" + document.frm.handFeeT.value);
        return;
    }

    document.frm.remain.value = document.frm.factPay.value - document.frm.handFee.value;
}


function formSubmitCfm()
{
	//getAfterPrompt();
    submitCfm();
}

 /*2014/04/04 11:02:20 gaopeng ���ù�����ѯ����Ʒ��sm_code*/
function getPubSmCode(myNo){
		var getdataPacket = new AJAXPacket("/npage/public/pubGetSmCode.jsp","���ڻ�����ݣ����Ժ�......");
		getdataPacket.data.add("phoneNo",myNo);
		getdataPacket.data.add("kdNo","");
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

function submitCfm() 
{
	var op_code=document.frm.opCode.value;
	/***begin diling add for ͣ������(��)(g073)ʱ��������ʾ@2014/1/15*/
	if(op_code=="g073"){
		rdShowMessageDialog("Ϊ�����û�Ԥ���㵼�±�ͣ�ڼ���Ƿ�ѱ�������������û�����Ԥ�����ڱ��µ��ߡ�6����ͣ�����ŷѡ�δ���ʻ����ܶ��Ԥ��<%=("2".equals(accountType)?"�ͻ���ͣ������ܲ���Ԥ���������ѿͻ���ͣǰ��ȡ����ֵҵ�񣬱������ͣҵ�������ֵҵ��δȡ�����޷�����Ԥ����":"")%>");		
		if("<%=accountTypeTrim%>" == "2"){
			var promptPhoneNo = $.trim($("#promptPhoneNo").val());
			if(promptPhoneNo.length == 0){
				rdShowMessageDialog("����дǷ�����Ѻ��룡");
				return false;
			}
			if(!forMobil(document.frm.promptPhoneNo))  return false;
			
		}
	
	}
	/*** end diling add @2014/1/15*/
	if(op_code=="m394"){
		rdShowMessageDialog("Ϊ�����û�Ԥ���㵼�±�ͣ�ڼ���Ƿ�ѱ�������������û�Ԥ��6���µ�ͣ�����ŷ��á�");		
		if("<%=accountTypeTrim%>" == "2"){
			var promptPhoneNo = $.trim($("#promptPhoneNo").val());
			if(promptPhoneNo.length == 0){
				rdShowMessageDialog("����дǷ�����Ѻ��룡");
				return false;
			}
			if(!forMobil(document.frm.promptPhoneNo))  return false;
		}
	}
	/***begin diling add for ��ͣʱ��У��Ƿ���ֻ���Ϣ��ʽ@2012/9/6*/
	if((op_code=="1213")||(op_code=="g073"&&"<%=accountTypeTrim%>"!="2")){
		var promptPhoneNo = $.trim($("#promptPhoneNo").val());
	  if($("#promptPhoneNo").val()!=""){
	    if(!forMobil(document.frm.promptPhoneNo))  return false;
	  }
	}
	/*** end diling add @2012/9/6*/
	getAfterPrompt(op_code);
    if (flag == 1) {
        if (document.frm.remark.value.length == 0) {
            document.frm.remark.value = document.frm.sysRemark.value;
            document.frm.remark.value = "�û�����" + document.frm.phoneNo.value + "�û�����" + document.frm.custName.value + "����" + document.frm.remark.value + "��";
        }
        
        //if(document.frm.asNotes.value.trim().len()==0){
        		//document.frm.asNotes.value=document.frm.remark.value;
        // }
        if (!forMoney(document.frm.handFee)) {
            return;
        }
        if (parseFloat(document.frm.handFee.value) > parseFloat(document.frm.handFeeT.value)) {
            rdShowMessageDialog("�����Ѳ��ܴ���" + document.frm.handFeeT.value);
            return;
        }
        var idJ = 0 ;
        var inputIdType = 0;
        for (idJ = 0; idJ < document.frm.asIdType.length; idJ ++) {
            if (document.frm.asIdType.options[idJ].selected == true) {
                inputIdType = document.frm.asIdType.options[idJ].value;
            }
        }
     printCommit();
     if (printFlag != 1 && printFlag != 2) {
	        return;
	    }

	    document.frm.submit.disabled = true;
	    var vPhoneNo = $.trim(document.frm.phoneNo.value);
	    getPubSmCode(vPhoneNo);
 			var pubSmCode = $("#pubSmCode").val();
	    /*gaopeng 2013/4/2 ���ڶ� 18:34:04 ���������� �ж���205 206��ͷ�����������룬���е���zhangzhea�ķ���sWLWInterFace begin */
	    if((pubSmCode=="PA"||pubSmCode=="PB") && op_code != "1214" && op_code != "1215")
			{
				//alert("����2��");
				 var myPacket = new AJAXPacket("/npage/public/sWLWI.jsp", "�����ύ�����Ժ�......");
			    myPacket.data.add("iLoginAccept", document.frm.loginAccept.value);							//��ˮ              
			    myPacket.data.add("iChnSource", document.frm.iChnSource.value);									//������ʶ          
			    myPacket.data.add("iOpCode", document.frm.opCode.value);												//��������          
			    myPacket.data.add("iLoginNo", document.frm.workNo.value);												//��������	        
			    myPacket.data.add("iLoginPwd", document.frm.noPass.value);											//��������	        
			    myPacket.data.add("iPhoneNo", document.frm.phoneNo.value); 											//�ֻ�����	        
			    myPacket.data.add("iUserPwd", document.frm.iUserPwd.value);											//��������          
			    myPacket.data.add("iOrgCode", document.frm.orgCode.value);											//���Ź���          
			    myPacket.data.add("iIdNo", "");                        													//�û�ID		        
			    myPacket.data.add("iOldSim", "");                       												//�û���SIM����			
			    myPacket.data.add("iOldSimStatus", "");                                         //�û���SMI��״̬	  
			    myPacket.data.add("iNewSim", "");                                               //�û���SIM����	    
			    myPacket.data.add("iNewSimShouldFee", "");                											//�û���SIM��Ӧ�շ� 
			    myPacket.data.add("iNewSimRealFee", "");                                        //�û���SIM��ʵ�շ� 
			    myPacket.data.add("iHandShouldFee", document.frm.handFeeT.value);               //�û�������Ӧ��		
			    myPacket.data.add("iHandRealFee", document.frm.handFee.value);                  //�û�������ʵ��	  
			    myPacket.data.add("iSystemNote", document.frm.sysRemark.value);                 //ϵͳ��ע          
			    myPacket.data.add("iOpNote", document.frm.asNotes.value);                        //�û���ע          
			    myPacket.data.add("iIpAddr", document.frm.ipAdd.value);                         //IP��ַ            
			    myPacket.data.add("iCardBZ", "");                                               //д��״̬          
			    myPacket.data.add("iCardStatus", "");                                           //�տ�״̬          
			    myPacket.data.add("iCardNo", "");                                               //�տ�����          
			    myPacket.data.add("iTransConId", document.frm.vConID.value);                    //ת���ʻ�          
			    myPacket.data.add("iTransMoney", document.frm.backPrepay.value);                //ת����          
			    myPacket.data.add("iTransPhoneNo", document.frm.vPhoneNo.value);                //ת���ֻ���        
			    myPacket.data.add("iTurnPhoneNo", "");                      										//ת����Դ����      
			    myPacket.data.add("iTurnType", "");                                      				//ת����Դ��������  
			    myPacket.data.add("iRemindPhone", $("#promptPhoneNo").val());                  	//Ƿ�����Ѻ���    
			    
			    core.ajax.sendPacket(myPacket,retsWLWI);
			    
			    myPacket=null;
					
			}
	    else if( op_code == "m394"){
	    //	alert("aaaa");
	    	var myPacket = new AJAXPacket("../sm394/fm394Cfm.jsp", "�����ύ�����Ժ�......");
	    	myPacket.data.add("iLoginAccept", document.frm.loginAccept.value);							//��ˮ              
		    myPacket.data.add("iChnSource", document.frm.iChnSource.value);									//������ʶ          
		    myPacket.data.add("iOpCode", document.frm.opCode.value);												//��������          
		    myPacket.data.add("iLoginNo", document.frm.workNo.value);												//��������	        
		    myPacket.data.add("iLoginPwd", document.frm.noPass.value);											//��������	        
		    myPacket.data.add("iPhoneNo", document.frm.phoneNo.value); 											//�ֻ�����	        
		    myPacket.data.add("iUserPwd", document.frm.iUserPwd.value);											//��������       
		    myPacket.data.add("iOpNote", document.frm.asNotes.value);                        //�û���ע        
		    myPacket.data.add("iRemindPhone", $("#promptPhoneNo").val());                  	//Ƿ�����Ѻ���
		    core.ajax.sendPacket(myPacket,do_sm394_cfm);
		    myPacket=null;
	    }
		else{
	    var myPacket = new AJAXPacket("f1213Cfm.jsp?asCustName=" + document.frm.asCustName.value + "&asCustPhone=" + document.frm.asCustPhone.value + "&asIdIccid=" + document.frm.asIdIccid.value + "&asIdAddress=" + document.frm.asIdAddress.value + "&asContractAddress=" + document.frm.asContractAddress.value + "&asNotes=" + document.frm.asNotes.value + "&sysRemark=" + document.frm.sysRemark.value + "&remark=" + document.frm.remark.value, "�����ύ�����Ժ�......");
	    myPacket.data.add("loginAccept", document.frm.loginAccept.value);
	    myPacket.data.add("iChnSource", document.frm.iChnSource.value);
	    myPacket.data.add("opCode", document.frm.opCode.value);
	    myPacket.data.add("workNo", document.frm.workNo.value);
	    myPacket.data.add("noPass", document.frm.noPass.value);
	    myPacket.data.add("idNo", document.frm.phoneNo.value); 
	    myPacket.data.add("iUserPwd", document.frm.iUserPwd.value);
	    myPacket.data.add("asIdType", inputIdType);
	    myPacket.data.add("orgCode", document.frm.orgCode.value);
	    myPacket.data.add("handFee", document.frm.handFeeT.value);
	    myPacket.data.add("factPay", document.frm.handFee.value);
	    myPacket.data.add("lx", document.frm.lxPrepay.value);
	    myPacket.data.add("ipAdd", document.frm.ipAdd.value);
	    myPacket.data.add("vConID", document.frm.vConID.value);
	    myPacket.data.add("backPrepay", document.frm.backPrepay.value);
	    myPacket.data.add("vPhoneNo", document.frm.vPhoneNo.value);
	    myPacket.data.add("book_phoneNo", document.frm.phoneNo.value);	
	    myPacket.data.add("promptPhoneNo", $("#promptPhoneNo").val());/*diling add for Ƿ�����Ѻ���@2012/9/6 */
	    core.ajax.sendPacket(myPacket);
	    
	    myPacket=null;
	  }
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

function do_sm394_cfm(packet){
	var error_code = packet.data.findValueByName("code");//���ش���
    var error_msg =  packet.data.findValueByName("msg");//������Ϣ

    if(error_code=="000000"){//�����ɹ�
    	rdShowMessageDialog("�����ɹ�",2);
        removeCurrentTab();
    }else{//���÷���ʧ��
    	rdShowMessageDialog(error_code+":"+error_msg);
	    return;
   }
}

function retsWLWI(packet)
{
	var errCode = packet.data.findValueByName("errCode");
   var errMsg = packet.data.findValueByName("errMsg");
   if(errCode=="000000")
   {
	   	rdShowMessageDialog("�������û�������Ϣ�Ѿ����ͼ��Ź�˾������ͨ�������Ϊ������ҵ��");
	   	removeCurrentTab();
   }
   else
   	{
   		rdShowMessageDialog("�������û�������Ϣ����ʧ�ܣ�"+errCode + "[" + errMsg + "]",0);
   		removeCurrentTab();
   	}
   
}

/***
function verifyPass() {
    if (flag == 1) {
        var m = document.frm.inputPass.value;
        var n = document.frm.customPass.value;

        var myPacket = new AJAXPacket("verifyPass.jsp", "�����ύ�����Ժ�......");

        myPacket.data.add("inputPass", m);
        myPacket.data.add("customPass", n);
        core.ajax.sendPacket(myPacket);

        myPacket=null;
    } else {
        rdShowMessageDialog("���Ȳ�ѯ�û���Ϣ��");
    }
}
***/
function resett() {
    printFlag = 9;
    document.frm.customPass.value = "";
    //document.frm.inputPass.value = "";
    document.frm.userId.value = "";
    document.frm.runName.value = "";
    document.frm.gradeName.value = "";
    document.frm.totalPrepay.value = "";
    document.frm.totalOwe.value = "";
    document.frm.custName.value = "";
    document.frm.smName.value = "";
    /*** ningtn CRM�ͷ�ϵͳ
    document.frm.qry.disabled = false;
    ***/
    document.frm.backPrepay.value = "";
    document.frm.lxPrepay.value = "";
    document.frm.noBack.value = "";
    document.frm.iccName.value = "";
    document.frm.iccNo.value = "";
    document.frm.innerTime.value = "";
    document.frm.asCustName.value = "";
    document.frm.asCustPhone.value = "";
    document.frm.asIdType.options[0].selected = true;
    document.frm.asIdIccid.value = "";
    document.frm.asIdAddress.value = "";
    document.frm.asContractAddress.value = "";
    document.frm.asNotes.value = "";
    document.frm.family_code.value = "";
    document.frm.family_order.value = "";
    document.frm.family_count.value = "";
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

function f1213GetByPhone(formField) {
    if (document.frm.vPhoneNo.value == document.frm.phoneNo.value)
    {
        rdShowMessageDialog("ת����벻���ڷ��������ͬ�������²�����");
        document.frm.vPhoneNo.value = "";
        document.frm.vPhoneNo.focus();
        return false;
    }
    /*   if(document.frm.vPhoneNo.value =="")
     {
        rdShowMessageDialog("ת����벻��Ϊ�գ������²�����");
        document.frm.vPhoneNo.focus(); 
        return false;
     }*/
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
	
	//document.all.vConPaswd.focus();
}

//added by hanfa 20070117
//add by wanglma 20110613 �ж��˻�ר���Ƿ���

//added by hanfa 20070117

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

function clickRadio(){
  /*** begin diling add for ��ͣ(1213)������һ��Ƿ�����Ѻ��������򣬲��Ǳ�������@2012/9/6 ***/
  var radiobuttonValue =$("input[@name=radiobutton][@checked]").val(); 
  if((radiobuttonValue=="1213")||(radiobuttonValue=="g073"&&"<%=accountTypeTrim%>"!="2")){/* �ͷ����ţ�����ͣ������ʱ����չʾ���� */
    document.getElementById("promptPhoneNo").value="";
    document.getElementById("rowPromptPhone").style.display="";
  }else{
      document.getElementById("promptPhoneNo").value="";
      document.getElementById("rowPromptPhone").style.display="";
  }
   /*** end diling add @2012/9/6 ***/
	submitt();
}


function printCommit()
{
    showPrtDlg("Detail", "ȷʵҪ���е��������ӡ��", "Yes");
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
    /* ningtn */
    var iccidInfoStr = $("#firstId").val() + "|" + $("#secondId").val();	
		var accInfoStr = $("#accInfoHid1").val() + "|" +$("#accInfoHid2").val()+ "|" +$("#accInfoHid3").val()+ "|" +$("#accInfoHid4").val();
    /* ningtn */
    var iRetrun = 0;
    var prop = "dialogHeight:" + h + "px; dialogWidth:" + w + "px; dialogLeft:" + l + "px; dialogTop:" + t + "px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no"
		var path = "<%=request.getContextPath()%>/npage/innet/hljBillPrint_jc_hw.jsp?DlgMsg=" + DlgMessage+ "&iccidInfo=" + iccidInfoStr + "&accInfoStr="+accInfoStr;
    var path = path  + "&mode_code="+mode_code+"&fav_code="+fav_code+"&area_code="+area_code+"&opCode="+opCode+"&sysAccept="+sysAccept+"&phoneNo=<%=activePhone%>&submitCfm=" + submitCfn+"&pType="+pType+"&billType="+billType+ "&printInfo=" + printStr;
    var ret = window.showModalDialog(path, printStr, prop);
		/* ningtn  CRM�ͷ�ϵͳ��ͣ��������ϵͳȷ���� ɾ��ԭ��û�õ��ж� */
    ret = "confirm";
    if ((ret == "confirm") && (submitCfn == "Yes"))
    {
        iRetrun = showEvalConfirmDialog('ȷ��Ҫ���д��������');
        if (iRetrun == 1)
        {
                printFlag = 1;
        } else if (iRetrun == 2)
        {//���� 2008��1��2������
                printFlag = 2;
        }
    }
    
}

function printInfo(printType)
{
  var printOpCode=$("input[@name=radiobutton][@checked]").val();
	var retInfo = "";
  if (printType == "Detail")
  {       
      var cust_info="";
      var opr_info="";
      var note_info1="";
      var note_info2="";
      var note_info3="";
      var note_info4=""; 
      if (radio1 == "m394"){
    	  cust_info += "�ֻ����룺" + document.all.phoneNo.value + "|";
    	  cust_info += "�ͻ�������" + document.all.custName.value + "|";
          cust_info += "�ͻ���ַ��" + document.all.custAddress.value + "|";
          cust_info += "֤�����룺" + document.all.idCardNo.value + "|";
      }
      else{
    	  cust_info += "�ͻ�������" + document.all.custName.value + "|";
          cust_info += "�ֻ����룺" + document.all.phoneNo.value + "|";
          cust_info += "�ͻ���ַ��" + document.all.custAddress.value + "|";
          cust_info += "֤�����룺" + document.all.idCardNo.value + "|";
      }
      
      for (var i = 0; i < document.frm.radiobutton.length; i ++) {
        if (document.all.radiobutton[i].checked)
        {
          var radio1 = document.all.radiobutton[i].value
          if (radio1 == "1213")
          {	
              opr_info += "�û�Ʒ�ƣ�" + document.frm.smName.value + "*" + "����ҵ�񣺱�ͣ" + "|";
              opr_info += "������ˮ��" + document.frm.loginAccept.value + "|";
              opr_info += "�û��ʷѣ�" + document.frm.productName.value + "|";
          } else if (radio1 == "1215") {
              opr_info += "�û�Ʒ�ƣ�" + document.frm.smName.value + "*" + "����ҵ�񣺸���" + "|";
              opr_info += "������ˮ��" + document.frm.loginAccept.value + "|";
              opr_info += "�û��ʷѣ�" + document.frm.productName.value + "|";
          }else if (radio1 == "g073"){
              opr_info += "�û�Ʒ�ƣ�" + document.frm.smName.value + "*" + "����ҵ��ͣ������(��)" + "|";
              opr_info += "������ˮ��" + document.frm.loginAccept.value + "|";
              opr_info += "�û��ʷѣ�" + document.frm.productName.value + "|";
              /*** ���ڹ��ֹ�˾�����Ż���ͣҵ�񹤵�����ʾ @2014/6/20 ***/
              if($("#promptPhoneNo").val()!=""){
			    opr_info += "Ƿ�����Ѻ��룺" + $("#promptPhoneNo").val() + "|";
			  }else{
			  	opr_info += "�ͻ�δ����Ƿ�����Ѻ���" + "|";
			  }
			/*** ���ڹ��ֹ�˾�����Ż���ͣҵ�񹤵�����ʾ @2014/6/20 ***/
          }else if (radio1 == "m394"){
              opr_info += "����ҵ��������ͣ" + "|";
              opr_info += "������ˮ��" + document.frm.loginAccept.value + "|";
              opr_info += "�û��ʷѣ�" + document.frm.productName.value + "|";
              if($("#promptPhoneNo").val()!=""){
			    opr_info += "Ƿ�����Ѻ��룺" + $("#promptPhoneNo").val() + "|";
			  }else{
			  	opr_info += "�ͻ�δ����Ƿ�����Ѻ���" + "|";
			  }
          }else{
          	 opr_info +="|";
          }  
        }
      }
      if(printOpCode=="g073"){/*ͣ�����ŵ����*/
        note_info1+="��ע��"+"��ܰ��ʾ����ͣ���¹̶�����������ȡ����ͣ��ÿ��5Ԫ����ͣ��Ч�ڵ�<%=addMonthsY%>��<%=addMonthsM%>��1�գ���Ч��֮���ֻ����뽫�Զ��ָ�Ϊ����״̬��ÿ����ȡ��Ӧ������ȷ��á�"+"|";
      }
      else if(printOpCode=="m394"){
    	  note_info1+="��ע��"+"��ܰ��ʾ����ͣ��ÿ��5Ԫ����ͣ��Ч�ڵ�<%=addMonthsY%>��<%=addMonthsM%>��1�գ���Ч�ں��������Ƿ�ѽ��Զ��ָ�Ϊ����״̬��ÿ����ȡ��Ӧ������ȷ��á�"+"|";
      }else{
        note_info1+="��ע��"+"|";
      }
      
      
      //retInfo = cust_info+"#"+opr_info+"#"+note_info1+"#"+note_info2+"#"+note_info3+"#"+note_info4+"#";
      retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
      retInfo=retInfo.replace(new RegExp("#","gm"),"%23");
  }
  if (printType == "Bill")
  {    //��ӡ��Ʊ
  }

    return retInfo;
}
    function printBill() {
        var  billArgsObj = new Object();
 		$(billArgsObj).attr("10001",document.frm.workNo.value);       //����
 		$(billArgsObj).attr("10002","<%=new java.text.SimpleDateFormat("yyyy",Locale.getDefault()).format(new java.util.Date())%>");
 		$(billArgsObj).attr("10003","<%=new java.text.SimpleDateFormat("MM",Locale.getDefault()).format(new java.util.Date())%>");
 		$(billArgsObj).attr("10004","<%=new java.text.SimpleDateFormat("dd",Locale.getDefault()).format(new java.util.Date())%>");
 		$(billArgsObj).attr("10005",document.frm.custName.value); //�ͻ�����
 		$(billArgsObj).attr("10006","<%=opName%>"); //ҵ�����
 		$(billArgsObj).attr("10008",document.frm.phoneNo.value); //�û�����
 		$(billArgsObj).attr("10015", document.frm.handFee.value);   //���η�Ʊ���
	    $(billArgsObj).attr("10016", document.frm.handFee.value);   //��д���ϼ�	
	    $(billArgsObj).attr("10017","*"); //���νɷ��ֽ�
 		$(billArgsObj).attr("10021",document.frm.handFee.value); //������
 		$(billArgsObj).attr("10030",document.frm.backLoginAccept.value); //��ˮ��--ҵ����ˮ
 		$(billArgsObj).attr("10036","<%=opCode%>"); //��������
 		var h=210;
		var w=400;
		var t=screen.availHeight/2-h/2;
		var l=screen.availWidth/2-w/2;
		var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no" 
		var path = "/npage/public/pubBillPrintCfm_YGZ.jsp?dlgMsg=ȷʵҪ���з�Ʊ��ӡ��" ;
		var loginAccept = document.frm.backLoginAccept.value;
		var path = path + "&loginAccept="+loginAccept+"&opCode=<%=opCode%>&submitCfm=submitCfm";
		var ret = window.showModalDialog(path,billArgsObj,prop);
 		location.href = "f1213.jsp?activePhone=<%=activePhone%>&opCode=<%=opCode%>&opName=<%=opName%>";
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
        location.href = "chkTwoPrint.jsp?accept=" + document.frm.backLoginAccept.value
        	 + "&opCode=" + document.all.radioValue.value
        	 + "&retInfo=" + infoStr + "&dirtPage=f1213.jsp&activePhone=<%=activePhone%>&opCode=<%=opCode%>&opName=<%=opName%>";
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
        location.href = "chkTwoPrintZero.jsp?accept=" + document.frm.backLoginAccept.value
        	 + "&opCode=" + document.all.radioValue.value
        	 + "&retInfo=" + infoStr + "&dirtPage=f1213.jsp&activePhone=<%=activePhone%>&opCode=<%=opCode%>&opName=<%=opName%>";
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
        location.href = "chkThreePrint.jsp?accept=" + document.frm.backLoginAccept.value
        	 + "&opCode=" + document.all.radioValue.value
        	 + "&backDate=" + document.frm.backDate.value + "&retInfo=" + infoStr + "&dirtPage=f1213.jsp&activePhone=<%=activePhone%>&opCode=<%=opCode%>&opName=<%=opName%>";
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
        location.href = "chkThreePrintZero.jsp?accept=" + document.frm.backLoginAccept.value
        	 + "&opCode=" + document.all.radioValue.value
        	 + "&backDate=" + document.frm.backDate.value + "&retInfo=" + infoStr + "&dirtPage=f1213.jsp&activePhone=<%=activePhone%>&opCode=<%=opCode%>&opName=<%=opName%>";
    }
</script>
</HEAD>
<body>
<FORM action="" method=post name="frm">
<%@ include file="/npage/include/header.jsp" %>
<div class="title">
    <div id="title_zi">��ѡ���������</div>
</div>
<!-- added by hanfa 20070117 -->
<input type="hidden" name="radioValue" value="">
<!--2015/9/7 9:10:41 gaopeng pubSmCode -->
  <input type="hidden" name="pubSmCode" id="pubSmCode" value="">
<table cellspacing="0">
<tbody>
<tr>
<%if (fee.length != 0) {%>
<td class="blue"  width="11%">��������</td>
<td <%=display2%>>
    <input type="radio" name="radiobutton" value="1213" index="0"
    <%
    
    
    int tmd1 = 0;
     int tmd11 = 0;
     for(int i = 0 ; i < fee.length ; i ++){
        if(tmd1==0){
        if(fee[i][0].equals("1213")){
          tmd1 = 1;
        System.out.println("1213���ݿ�����ֵ"+fee[i][2]+fee[i][3]);
    
    
    
    %>
           onclick="beforePrompt(); 
            <%
		for(int j = 0 ;  j< favInfo.length ; j ++){
		if(favInfo[j][0].trim().equals(fee[i][3])){
		tmd11 = 1;
	%>
	document.frm.handFee.disabled=false;
            <%}}%>
            <%if(tmd11==0){%>document.frm.handFee.disabled=true;<%}%> noBackDiv.style.display='none';backDiv.style.display='none';document.frm.sysRemark.value='��ͣ���';document.frm.opCode.value=<%=fee[i][0]%>;document.frm.handFee.value=<%=fee[i][2]%>;document.frm.handFeeT.value=<%=fee[i][2]%>;"
    <%
    
    
    

    }}}if(tmd1==0){
    //System.out.println("��ִ��");
    
    
    
    %>
           onclick="noBackDiv.style.display='none';backDiv.style.display='none';document.frm.handFee.disabled=true;document.frm.opCode.value='1213';document.frm.handFee.value='0';document.frm.handFeeT.value='0';document.frm.sysRemark.value='��ͣ���';beforePrompt();clickRadio();"


    <%
    
    
    
    
    }
    
    
    %>


      >��ͣ
</td>


<td <%=display%>>
    <input type="radio" name="radiobutton" value="1214" index="1"

    <%
    
    
    
       int tmd2 = 0 ;
       int tmd22 = 0;
       for(int i = 0 ; i < fee.length ; i ++){
        if(tmd2==0){
        if(fee[i][0].equals("1214")){
    //System.out.println("1214���ݿ�����ֵ"+fee[i][2]+fee[i][3]);
    tmd2=1;
    
    
    
    %>
           onclick="beforePrompt();
            <%for(int j = 0 ;  j< favInfo.length ; j ++){
	if(favInfo[j][0].trim().equals(fee[i][3])){
	//System.out.println("������");
	tmd22 = 1;
	%>
            document.frm.handFee.disabled=false;document.frm.sysRemark.value='��ʧ���';
            <%}}%>
            
            <%if(tmd22 == 0){%>document.frm.handFee.disabled=true;<%}%>
            noBackDiv.style.display='none';backDiv.style.display='none';document.frm.opCode.value=<%=fee[i][0]%>;document.frm.handFee.value=<%=fee[i][2]%>;document.frm.handFeeT.value=<%=fee[i][2]%>;clickRadio();"


    <%
    
    
    }}}if(tmd2==0){
    
    
    
    
    %>
           onclick="noBackDiv.style.display='none';backDiv.style.display='none';document.frm.handFee.disabled=true;document.frm.opCode.value='1214';document.frm.handFee.value='0';document.frm.handFeeT.value='0';document.frm.sysRemark.value='��ʧ���';beforePrompt();clickRadio();"
    <%
    
    
    
    
    }
    
    
    %>>��ʧ
</td>

<!-- yuanqs add 2010/9/15 14:12:02 �ͷ�����Ҫ����ʾ������ť ȥ��<%=display%>-->
<td>
    <input type="radio" name="radiobutton" value="1215" index="2"
    <%
    
    
    
       int tmd3 = 0;
       int tmd33 = 0;
       for(int i = 0 ; i < fee.length ; i ++){
        if(tmd3 == 0){
        if(fee[i][0].equals("1215")){
     tmd3=1;   
    
    
    
    %>
           onclick="beforePrompt();
            <%for(int j = 0 ;  j< favInfo.length ; j ++){
	if(favInfo[j][0].trim().equals(fee[i][3])){
	tmd33 =1;
	%>
            document.frm.handFee.disabled=false;document.frm.sysRemark.value='�������';
            <%}}%>
            <%if(tmd33 == 0){%>document.frm.handFee.disabled=true;<%}%>
            noBackDiv.style.display='none';backDiv.style.display='none';document.frm.opCode.value=<%=fee[i][0]%>;document.frm.handFee.value=<%=fee[i][2]%>;document.frm.handFeeT.value=<%=fee[i][2]%>;clickRadio();"

    <%
    
    
    }}}if(tmd3==0){
    
    
    
    
    %>
           onclick="noBackDiv.style.display='none';backDiv.style.display='none';document.frm.handFee.disabled=true;document.frm.opCode.value='1215';document.frm.handFee.value='0';document.frm.handFeeT.value='0';document.frm.sysRemark.value='�������';beforePrompt();clickRadio();"
    <%
    
    
    
    
    }
    
    
    %>>����
</td>
<%/*** begin diling add for ����ͣ������(����) @2012/9/7 ***/%>
<td >
    <input type="radio" name="radiobutton" value="g073" index="0"
    <%
    
    
    int tmd4 = 0;
     int tmd44 = 0;
     for(int i = 0 ; i < fee.length ; i ++){
        if(tmd4==0){
        if(fee[i][0].equals("g073")){
          tmd4 = 1;
        System.out.println("g073���ݿ�����ֵ"+fee[i][2]+fee[i][3]);
    
    
    
    %>
           onclick="beforePrompt(); 
            <%
		for(int j = 0 ;  j< favInfo.length ; j ++){
		if(favInfo[j][0].trim().equals(fee[i][3])){
		tmd44 = 1;
	%>
	document.frm.handFee.disabled=false;
            <%}}%>
            <%if(tmd44==0){%>document.frm.handFee.disabled=true;<%}%> noBackDiv.style.display='none';backDiv.style.display='none';document.frm.sysRemark.value='ͣ������(��)���';document.frm.opCode.value=<%=fee[i][0]%>;document.frm.handFee.value=<%=fee[i][2]%>;document.frm.handFeeT.value=<%=fee[i][2]%>;"
    <%
    
    
    

    }}}if(tmd4==0){
    //System.out.println("��ִ��");
    
    
    
    %>
           onclick="noBackDiv.style.display='none';backDiv.style.display='none';document.frm.handFee.disabled=true;document.frm.opCode.value='g073';document.frm.handFee.value='0';document.frm.handFeeT.value='0';document.frm.sysRemark.value='ͣ������(��)���';beforePrompt();clickRadio();"


    <%
    
    
    
    
    }
    
    
    %>


      >ͣ������(��)
</td>
<%/*** end diling add@2012/9/7 ***/%>

<%/*** begin liangyl add for ������ͣ @2016/8/20 ***/%>
<td >
    <input type="radio" name="radiobutton" value="m394" index="0"
    <%
    int tmd5 = 0;
     int tmd55 = 0;
     for(int i = 0 ; i < fee.length ; i ++){
        if(tmd5==0){
        if(fee[i][0].equals("m394")){
          tmd5 = 1;
        System.out.println("m394���ݿ�����ֵ"+fee[i][2]+fee[i][3]);
    %>
           onclick="beforePrompt(); 
            <%
		for(int j = 0 ;  j< favInfo.length ; j ++){
		if(favInfo[j][0].trim().equals(fee[i][3])){
		tmd55 = 1;
	%>
	document.frm.handFee.disabled=false;
            <%}}%>
            <%if(tmd55==0){%>document.frm.handFee.disabled=true;<%}%> noBackDiv.style.display='none';backDiv.style.display='none';document.frm.sysRemark.value='������ͣ';document.frm.opCode.value=<%=fee[i][0]%>;document.frm.handFee.value=<%=fee[i][2]%>;document.frm.handFeeT.value=<%=fee[i][2]%>;"
    <%
    }}}if(tmd5==0){
    //System.out.println("��ִ��");
    %>
     onclick="noBackDiv.style.display='none';backDiv.style.display='none';document.frm.handFee.disabled=true;document.frm.opCode.value='m394';document.frm.handFee.value='0';document.frm.handFeeT.value='0';document.frm.sysRemark.value='������ͣ';beforePrompt();clickRadio();"
    <%
    }
    %>
      >������ͣ
</td>
<%/*** end liangyl add for ������ͣ @2016/8/20 ***/%>
<%} else {%>
<td class="blue" nowrap >��������</td>

<td <%=display2%>>
    <input type="radio" name="radiobutton" index="0" value="1213"
           onclick="noBackDiv.style.display='none';backDiv.style.display='none';document.frm.opCode.value='1213';document.frm.handFee.value='0';document.frm.handFeeT.value='0';document.frm.sysRemark.value='��ͣ���';clickRadio();">��ͣ
</td>
<td <%=display%>>
    <input type="radio" name="radiobutton" index="1" value="1214"
           onclick="noBackDiv.style.display='none';backDiv.style.display='none';document.frm.opCode.value='1214';document.frm.handFee.value='0';document.frm.handFeeT.value='0';document.frm.sysRemark.value='��ʧ���';clickRadio();">��ʧ
</td>
<!-- yuanqs add 2010/9/15 14:42:27 �ͷ�����Ҫ��ָ���������ȥ�� <%=display%> -->
<td>
    <input type="radio" name="radiobutton" index="2" value="1215"
           onclick="noBackDiv.style.display='none';backDiv.style.display='none';document.frm.opCode.value='1215';document.frm.handFee.value='0';document.frm.handFeeT.value='0';document.frm.sysRemark.value='�������';clickRadio();">����
</td>
<%/*** begin diling add for ����ͣ������(����) @2012/9/7 ***/%>
<td>
    <input type="radio" name="radiobutton" index="0" value="g073"
           onclick="noBackDiv.style.display='none';backDiv.style.display='none';document.frm.opCode.value='g073';document.frm.handFee.value='0';document.frm.handFeeT.value='0';document.frm.sysRemark.value='ͣ������(��)���';clickRadio();">ͣ������(��)
</td>
<%/*** end diling add@2012/9/7 ***/%>
<%/*** begin liangyl add for ������ͣ @2016/8/20 ***/%>
<td>
    <input type="radio" name="radiobutton" index="0" value="m394"
           onclick="noBackDiv.style.display='none';backDiv.style.display='none';document.frm.opCode.value='m394';document.frm.handFee.value='0';document.frm.handFeeT.value='0';document.frm.sysRemark.value='������ͣ';clickRadio();">������ͣ
</td>
<%/*** end liangyl add for ������ͣ @2016/8/20 ***/%>
<!--
<td>
  <input type="radio" name="radiobutton" value="1217" onclick="lxDiv.style.display='none';noBackDiv.style.display='none';backDiv.style.display='none';document.frm.opCode.value='1217';document.frm.handFee.value='0';document.frm.handFeeT.value='0';document.frm.sysRemark.value='Ԥ���ָ����';">Ԥ���ָ�
</td>
-->

<%}%>


</tr>
</TBODY>
</TABLE>
			</div>
			<div id="Operation_Table"> 
			<div class="title">
				<div id="title_zi">�û���Ϣ</div>
			</div>
<table cellspacing="0">
<tbody>
<tr>
    <td class="blue" width="12%" nowrap>�������</td>
    <td colspan="5">
        <%if (workNo.substring(0, 1).trim().equals("kk")) {%>
        <%String userPhoneNo = (String) session.getAttribute("userPhoneNo");%>
        <input
                id=Text2 type=text size=17 name=phoneNo v_type="mobphone" v_name="�������" disabled maxlength=11 index="5"
                onKeyUp="if(event.keyCode==13)submitt()" value="<%=userPhoneNo%>">
        <%} else {%>
        <input class="InputGrey" id=Text2 type=text size=17 name=phoneNo value="<%=activePhone%>" readonly>
        <%}%>
				<!-- ningtn CRM�ͷ�ϵͳ����
        <input class="b_text" id=Text2 type=button size=17 name=qry value="��ѯ" onclick="submitt()">
        -->
    </td>

		<!---
    <td class="blue">�û�����</td>
    <td colspan="3">

        <jsp:include page="/npage/common/pwd_one1.jsp">
            <jsp:param name="width1" value="16%"/>
            <jsp:param name="width2" value="34%"/>
            <jsp:param name="pname" value="inputPass"/>
            <jsp:param name="pwd" value="12345"/>
        </jsp:include>


        <%if (favFlag == 0) {%>
        <input id=Text2 type=button class="b_text" size=17 name=verifyPass1 value="��֤����" onclick="verifyPass()">
        <%} else {%>
        <input id=Text2 type=button class="b_text" size=17 name=verifyPass1 value="��֤����" onclick="verifyPass()" disabled>
        <%}%>
    </td>
		--->
</tr>
<tr>
    <td class="blue" width="12%" nowrap>�û�ID</td>
    <td width="21%">
        <input id=Text2 type=text size=17 name=userId class="InputGrey" readonly>
    </td>
    <td class="blue" width="12%" nowrap>��ǰ״̬</td>
    <td width="21%">
        <input type=text size=17 name=runName class="InputGrey" readonly>
    </td>
    <td class="blue" width="12%" nowrap>����</td>
    <td>
        <input type=text size=17 name=gradeName class="InputGrey" readonly>
    </td>
</tr>
<tr>
    <td class="blue">��ǰԤ��</td>
    <td>
        <input
                id=Text2 type=text size=17 name=totalPrepay class="InputGrey" readonly>
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
        <input type=text size=17 name=custName class="InputGrey" readonly>
    </td>
    <td class="blue"> ��Ʒ����</td>
    <td align=left colspan="3">
        <input type=text size=56 name=productName class="InputGrey" readonly>
    </td>
</tr>
<tr id=noBackDiv style="display:none">
    <td class="blue">������Ԥ��</td>
    <td>
        <input id=Text2 type=text size=17 name=noBack class="InputGrey" readonly>
    </td>
    <td class="blue">����Ԥ��</td>
    <td>
        <input id=Text2 type=text size=17 name=backPrepay class="InputGrey" readonly>
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
        <input class="b_text" type="button" name="qCustIdByPhone" value="��ѯ" onClick="f1213GetByPhone(vPhoneNo)">
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
        <input id=Text2 type=text size=17 name=innerTime class="InputGrey" readonly>
    </td>
</tr>
<tr style=display:none>
    <td class="blue"> ����������</td>
    <td>
        <input id=Text2 type=text size=17 name=asCustName maxlength=20
               onkeyup="value=value.replace(/[@#$%!^&*()<>?|]/g,'');">
    </td>
    <td class="blue">��������ϵ�绰</td>
    <td>
        <input id=Text2 type=text size=17 name=asCustPhone maxlength=20>
    </td>
    <td class="blue">��������ϵ��ַ</td>
    <td colspan=2>
        <input id=Text2 type=text size=17 name=asContractAddress maxlength=20
               onkeyup="value=value.replace(/[@#$%!^&*()<>?|]/g,'');">
    </td>
</tr>
<tr style=display:none>
    <td class="blue"> ������֤������</td>
    <td>
        <select size=1 name=asIdType>
            <%for (int i = 0; i < sIdTypeStr.length; i++) {%>
            <option value="<%=sIdTypeStr[i][0]%>"><%=sIdTypeStr[i][1]%>
            </option>
            <%}%>
        </select>
    </td>
    <td class="blue">������֤������</td>
    <td>
        <input id=Text2 type=text size=17 name=asIdIccid maxlength=20
               onkeyup="value=value.replace(/[@#$%!^&*()<>?|]/g,'');">
    </td>
    <td class="blue">������֤����ַ</td>
    <td width="19%" colspan=2>
        <input id=Text2 type=text size=17 name=asIdAddress maxlength=20
               onkeyup="value=value.replace(/[@#$%!^&*()<>?|]/g,'');">
    </td>
</tr>
<tr style="display:none">
    <td class="blue">������ע</td>
    <td colspan="5">
        <input id=Text21 type=text size=17 name=asNotes1 maxlength=20
               onkeyup="value=value.replace(/[@#$%!^&*()<>?|]/g,'');">
    </td>
</tr>

    <tr>
        <td class="blue">������</td>
        <td>
            <input id=Text2 type=text size=17 name=handFee disabled v_type=float v_name="������" index="7">
        </td>
        <td class="blue">ʵ��</td>
        <td>
            <input
                    id=Text2 type=text size=17 name=factPay index="8" disabled 
                    onKeyUp="if(event.keyCode==13){getRemain()}">&nbsp;<input
                id=Text2 type=button size=17
                name=getUseInfo class="b_text" value="-->"
                onclick="getRemain()">
        </td>
        <td class="blue">����</td>
        <td>
            <input id=Text2 type=text size=17 name=remain disabled>
        </td>
    </tr>
    <tr id = "rowPromptPhone"  style="display:none">
      <td class="blue">Ƿ�����Ѻ���</td>
      <td colspan= "5">
        <input id="promptPhoneNo" type=text size=17  name="promptPhoneNo" v_type="mobphone" v_name="Ƿ�����Ѻ���"  maxlength="11" />
      </td>
    </tr>
    <tr>
        <td class="blue">ϵͳ��ע</td>
        <td colspan="5"><input id=Text3 type=text size=80 name=remark value=""></td>
    </tr>
    <tr>
        <td class="blue">�û���ע</td>
        <td colspan="5"><input id=Text2 type=text size=80 name=asNotes maxlength=60
                   onkeyup="value=value.replace(/[@#$%!^&*()<>?|]/g,'');" index="9">
        </td>
    </tr>   
</table>
<jsp:include page="/npage/public/hwReadCustCard.jsp">
	<jsp:param name="hwAccept" value="12"  />
	<jsp:param name="showBody" value="01"  />
</jsp:include>
<TABLE cellSpacing="0">
    <TBODY>
        <TR>
            <TD id="footer">
                <input class="b_foot" name=submit type=button value="ȷ��" index="10"
                       onKeyUp="if(event.keyCode==13){formSubmitCfm()}" onclick="formSubmitCfm()" 
                       disabled>
                &nbsp;&nbsp;
                <input class="b_foot" name=back type=button value="���" onclick="window.location='f1213.jsp?activePhone=<%=activePhone%>&opCode=<%=opCode%>&opName=<%=opName%>'">
                &nbsp;&nbsp;
                <input class="b_foot" name=back type=button value="�ر�" onclick="parent.removeTab('<%=opCode%>')">
                &nbsp;&nbsp;
            </TD>
        </TR>
    </TBODY>
</TABLE>
<input type=hidden name=family_code> <!--��ͥ����-->
<input type=hidden name=family_order>	<!--��ͥλ��-->
<input type=hidden name=family_count> <!--��ͥ����-->
<input type=hidden name=opCode>
<input type=hidden name=workNo value=<%=workNo%>>
<input type=hidden name=noPass value=<%=nopass%>>
<input type=hidden name=orgCode value=<%=orgCode%>>
<input type=hidden name=iChnSource value=<%=iChnSource%>>  <!--������ʶ-->
<input type=hidden name=iUserPwd value=<%=iUserPwd%>>  <!--�������� -->
<input type=hidden name=sysRemark value="�ۺϱ��">
<input type=hidden name=ipAdd value="<%=request.getRemoteAddr()%>">
<input type=hidden name=handFeeT>
<input type=hidden name=customPass>
<input type=hidden name=idCardNo>
<input type=hidden name=custAddress>
<input type=hidden name=backLoginAccept>
<input type=hidden name=backDate>
<input type=hidden name=favFlag value="<%=favFlag%>">
<input type=hidden name=loginAccept>
<input type=hidden name=smName>
<input type=hidden name=simBell
       value="   �ֻ�������ѡ�ײ��Żݵ�GPRS������ָCMWAP�ڵ����������.  �������أ�1.��������꿨,�ͼ�ֵ88Ԫ������ء�  2.��½������ɣ�wap.hljmonternet.com��ʹ���ֻ�����������ͼ�����ء�������Ѷ�����������������������������ʱ������,������Ϣ�ѣ�����1860��ͨGPRS ��">
<input type=hidden name=worldSimBell
       value="    �������ҵ��󣬼���Ϊ�ҹ�˾ȫ��ͨǩԼ�ͻ�����ǩԼ������ʹ���ҹ�˾ҵ�񼰲�Ʒ��ͬʱִ���µ����������ߡ������ɵ�Ԥ�����������������������ϣ�ͬʱ�������Ļ����ڻ���ʹ�����޺󷽿�ʹ�á�       ��Э����Ч�������������ʷѱ�׼�������������µ��ʷ�����ִ�С�       ��Ϊȫ��ͨ�ͻ������������ҹ�˾Ϊ���ṩ��������">
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
<%@ include file="/npage/public/hwObject.jsp" %> 
</HTML>



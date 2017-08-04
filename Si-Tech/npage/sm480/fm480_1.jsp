<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%
    String opCode = "m479";
    String opName = "固话暂停";
    
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
<!--手续费的查询-->
		<wtc:pubselect name="sPubSelect" routerKey="phone" routerValue="<%=activePhone%>" outnum="4">
		<wtc:sql><%=feeSql%></wtc:sql>
		</wtc:pubselect>
		<wtc:array id="fee" scope="end" />
<%
    System.out.println("the length of fee==========="+fee.length);
    String workSql = "select count(*) from shighlogin where login_no = '" + workNo + "' and op_code='b544'";
%>
<!--高端用户的查询-->
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
			<wtc:param value="固话综合变更查询用户信息" />
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
    <TITLE>暂停、暂停恢复、预销、销户</TITLE>

<script language="javascript">
var printFlag = 9;//用户评价标识
var flag = 0;//查询用户信息成功与否标识
function doProcess(packet) {
	
	
    var backString = packet.data.findValueByName("backString");
    var cfmFlag = packet.data.findValueByName("flag");
    //cfmFlag = 1;
    /*变更操作的返回*/
    
    //alert("document.frm.opCode.value = "+document.frm.opCode.value+"\npubSmCode = "+$("#pubSmCode").val()+"\ncfmFlag = "+cfmFlag);
    
    if (cfmFlag == 1) {
        var errMsg = packet.data.findValueByName("errMsg");
        var errCode = packet.data.findValueByName("errCode");
        var errCodeInt = parseInt(errCode, 10);
        //errCodeInt = 0;
        if (errCodeInt == 0) {
        		//document.frm.opCode.value = "b544";
            rdShowMessageDialog("操作成功！",2);
            document.frm.backLoginAccept.value = backString[0][0];
            if ((document.frm.opCode.value == "m479" || document.frm.opCode.value == "m480") 
            		&& parseFloat(document.frm.factPay.value) > 0) {
            		rdShowMessageDialog("打印发票");
                showBroadBill("Bill","确实要进行发票打印吗？","Yes");
            }
            if (document.frm.opCode.value == "b544" && parseFloat(document.frm.backPrepay.value) > 0) {
                rdShowMessageDialog("打印发票");
                showBroadBill("Bill","确实要进行发票打印吗？","Yes");
            }
            var pubSmCode = $("#pubSmCode").val();
            if(document.frm.opCode.value == "m481"&& parseFloat(document.frm.backPrepay.value) > 0){
            	rdShowMessageDialog("打印发票");
              showBroadBill("Bill","确实要进行发票打印吗？","Yes");
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
    /*用户信息查询失败*/
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
    /*用户信息的显示*/
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
        if (document.frm.cardType.value.indexOf("中高端用户", 0) >= 0) {
            rdShowMessageDialog("该用户是中高端用户！");
        }
        if (document.frm.cardType.value.indexOf("中高端用户", 0) >= 0 && <%=higflag%> ==0 && document.frm.opCode.value == "b544"){
		        rdShowMessageDialog("该用户是中高端用户,此工号没有销号权限！");
		        return;
    		}
        document.frm.noBack.value = backString[0][24];
        document.frm.productName.value = backString[0][25];
        document.frm.loginAccept.value = backString[0][26];
        document.frm.cfmLogin.value = backString[0][27];
        
        
        /*2015/01/19 15:03:46 gaopeng m483 预销时,kh的展示可退金额*/
				/*获取品牌sm_code*/
				getPubSmCode($("#cfmLogin").val());
				var smCode = $("#pubSmCode").val();
				
				if(document.frm.opCode.value == "m481"){
					$("#noBackDiv").show();
					$("#showMyMsg").show();
					
				var getdataPacket = new AJAXPacket("getTerminaleFeeFlag.jsp","正在获得数据，请稍候......");
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
                if (rdShowConfirmDialog('确认要进行销号变更吗？') != 1) {
                    return;
                }
                if (document.frm.favFlag.value == 1) {
                    document.frm.submit.disabled = false;
                }
            }
            else if (errCode == 1206) {
                rdShowMessageDialog(errCodeInt + " : " + errMsg);
                if (rdShowConfirmDialog('确认要进行销号变更吗？') != 1) {
                    return;
                }
                if (document.frm.favFlag.value == 1) {
                    document.frm.submit.disabled = false;
                }
            }
            else {

                if (errCode == 1201) {
                    errMsg = "找不到该服务号码";
                }

                if (errCode == 1202) {
                    errMsg = "此状态不允许变更";
                }
                if (errCode == 1203) {
                    errMsg = "此号码不允许异地操作";
                }
                if (errCode == 1204) {
                    errMsg = "此业务类型不允许做变更";
                }
                if (errCode == 1007) {
                    errMsg = "欠费状态不允许变更";
                }
                if (errCode == 1008) {
                    errMsg = "欠费状态不允许变更";
                }

                if (errCode == 1207) {
                    errMsg = "该用户已经销号";
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
        /** bingId 为63时，即广电品牌，不查询旧资源信息**/
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
		rdShowMessageDialog("请提醒用户进行固话终端设备押金返还。押金返还功能为“m355-固话设备押金返还”");
	}
}

/*获取旧资源信息*/
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

/*********用户信息的查询****************/
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
        rdShowMessageDialog("请选择操作类型!");
        return;
    }

    var ii = 0 ;
    for (ii = 0; ii < document.frm.radiobutton.length; ii ++) {
        document.all.radiobutton[ii].disabled = true;
    }
    /*获取固话用户信息*/
		if(document.all.phoneNo.value != ""){
			//alert(350);
	    var myPacket = new AJAXPacket("getKDUserInfo.jsp", "正在提交，请稍候......");
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
  	  rdShowMessageDialog("查询固话用户信息失败！",0);
  	  return false;
  	}
}

/******** 拆机或销户时增加积分提示信息 *********/

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
		document.all.bFMsg.value="校验成功";
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
			rdShowMessageDialog("请输入其他原因");
			return;
		}
		
		if($("#textarea_otreson").text().trim().length>30||$("#textarea_otreson").text().trim().length<1){
			rdShowMessageDialog("其他原因只能输入1-30个字符");
			return;
		}
		
		reasonDescription = $("#sel_reasonDescription").val()+"）"+$("#sel_reasonDescription option:selected").text()+"："+$("#textarea_otreson").text().trim();
		
	}else{
			if($("#sel_reasonDescription").val()==""){
					rdShowMessageDialog("请选择销户原因");
					return;
			}	
			
			reasonDescription = $("#sel_reasonDescription").val()+"）"+$("#sel_reasonDescription option:selected").text();
	}
}

	showBroadBill("Bill","确实要进行发票打印吗？","Yes");//测试写死
	
	//getAfterPrompt();

	submitCfm(reasonDescription);
}

/**********页面的提交***************/
function submitCfm( reasonDescription) 
{	
		var op_code=document.frm.opCode.value;
		getAfterPrompt(op_code);
		
	/*zhangyan*/
	if(document.all.opCode.value.trim() == "m481")
	{
		/*指定Ajax调用页*/
		var packet = new AJAXPacket("../public/pubBUSAPIAjax.jsp"
		,"请稍后...");
	
		/*给ajax页面传递参数*/
		packet.data.add("netCode"
		,document.frm.cfmLogin.value.trim() );
		packet.data.add("opCode",document.all.opCode.value.trim() );
	
		/*调用页面,并指定回调方法*/
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
            document.frm.remark.value = "用户号码" + document.frm.phoneNo.value + "用户姓名" + document.frm.custName.value + "进行" + document.frm.remark.value + "。";
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
            rdShowMessageDialog("手续费不能大于" + document.frm.handFeeT.value);
            return;
        }
         for (var i = 0; i < document.frm.radiobutton.length; i ++) {
            if (document.all.radiobutton[i].checked)
            {
                var radio1 = document.all.radiobutton[i].value;
                if (radio1 == "m481")
                {	
                    if(document.all.construct_request.value.trim().length==0){
			     							document.all.construct_request.value="无";
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
            	rdShowMessageDialog("打印发票");
              showBroadBill("Bill","确实要进行发票打印吗？","Yes");
    }*/
    if(!printCommit()){
    	return false;
    }
    
    
     if (printFlag != 1 && printFlag != 2) {
	        return;
	    }

			document.frm.submit.disabled = true;
			var vPhoneNo = document.frm.phoneNo.value;
			
			var myPacket = new AJAXPacket("fm480_Cfm.jsp", "正在提交，请稍候......");
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
	            rdShowMessageDialog("用户未进行评价!");
	        }
	        var vEvalPacket = new AJAXPacket("../../npage/public/evalCfm.jsp?vEvalValue=" + vEvalValue, "正在提交用户满意度评价，请稍候......");
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
        rdShowMessageDialog("请先查询用户信息！");
    }
}
/******页面的重置*********/
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
     /*用户旧资源信息的重置 */
    document.frm.cfmLogin.value = "";
    document.frm.deviceTypeOld.value = "";
    document.frm.deviceCodeOld.value = "";
    document.frm.deviceInAddressOld.value = "";
    document.frm.factoryOld.value = "";
    document.frm.portTypeOld.value = "";
    document.frm.portCodeOld.value = "";
    document.frm.ipAddressOld.value = "";
    document.frm.modelOld.value = "";
    
    /*施工信息的重置*/
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
/****根据转存号码查询并确定账号****/
function m479GetByPhone(formField) {
    if (document.frm.vPhoneNo.value == document.frm.phoneNo.value)
    {
        rdShowMessageDialog("转存号码不能于服务号码相同，请重新操作！");
        document.frm.vPhoneNo.value = "";
        document.frm.vPhoneNo.focus();
        return false;
    }
    document.all.vConID.value = "";

    var pageTitle = "帐户信息查询";
    var fieldName = "转存帐户|转存帐户名称";
    var selType = "S";    //'S'单选；'M'多选
    var retQuence = "0";
    var retToField = "vConID";
    var sqlStr = "select a.contract_no, a.bank_cust from dConMsg a, dCustMsg b, dConUserMsg c where a.contract_no = c.contract_no and   b.id_no = c.id_no and   b.phone_no  = '" + formField.value + "'";
    PubSimpSel(pageTitle, fieldName, sqlStr, selType, retQuence, retToField);
    if (document.all.vConID.value == "")
    {
        return false;
    }        
}
/***办理拆机的积分提示*****/
function showPreCancelInfo()
{
}
/***办理销号的积分提示*****/

/*****提示信查询********/
function beforePrompt(){
	var op_code=$("input[@name=radiobutton][@checked]").val();
	var packet = new AJAXPacket("/npage/include/getBeforePrompt.jsp","请稍后...");
	packet.data.add("opCode" ,op_code);
	core.ajax.sendPacketHtml(packet,doGetBeforePrompt,true);//异步
	packet =null;
}
function doGetBeforePrompt(data)
{
	$('#wait').hide();
	$('#beforePrompt').html(data);
}
/*****注意事项查询********/
function getAfterPrompt(op_code)
{
	var packet = new AJAXPacket("/npage/include/getAfterPrompt.jsp","请稍后...");
	packet.data.add("opCode" ,op_code);
  core.ajax.sendPacket(packet,doGetAfterPrompt,false);//同步
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
/*用户信息的查询*/
function clickRadio(){
	/* 控制radio  by ningtn  */
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
		document.frm.sysRemark.value='暂停';
	}else if(opCode == "m480"){
		noBackDiv.style.display='none';
		backDiv.style.display='none';
		document.frm.opCode.value='m480';
		document.frm.handFee.value='0';
		document.frm.handFeeT.value='0';
		document.frm.factPay.value='0';
		document.frm.sysRemark.value='暂停恢复';
	}else if(opCode == "m481"){
	
		noBackDiv.style.display='none';
		backDiv.style.display='none';
		constructDiv.style.display='';
		modemFlagTr.style.display=''; //关于报送2013年9月第一批业务支撑系统市场专业需求的函-关于上报CRM、BOSS和经分系统需求的请示 hejwa add 2013年10月28日9:32:54
		userOldResDiv1.style.display='none'; 
		userOldResDiv2.style.display='none'; 
		document.frm.opCode.value='m481';
		document.frm.handFee.value='0';
		document.frm.handFeeT.value='0';
		document.frm.factPay.value='0';
		document.frm.sysRemark.value='销户';
		$("#tr_otreson_1").show();
	}else if(opCode == "b544"){
		noBackDiv.style.display='';
		backDiv.style.display='';
		document.frm.opCode.value='b544';
		document.frm.handFee.value='0';
		document.frm.handFeeT.value='0';
		document.frm.factPay.value='0';
		document.frm.sysRemark.value='销户';
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
<!--BUS校验返回代码-->
<input type="hidden" name="bFCode" value="1">
<input type="hidden" name="bFMsg" value="1">

<div class="title">
    <div id="title_zi">请选择操作类型</div>
</div>
<table cellspacing="0">
<tbody>
<tr>
<td class="blue" nowrap width="25%">操作类型</td>

<td width="25%">
    <input type="radio" name="radiobutton" index="1" value="m479"
           onclick="clickRadio();" >暂停
</td>
<td width="25%">
    <input type="radio" name="radiobutton" index="2" value="m480"
           onclick="clickRadio();">暂停恢复
</td>
<td width="25%">
    <input type="radio" name="radiobutton" index="3" value="m481"
           onclick="clickRadio();">销户
</td>
 
</tr>
</tbody>
</table>
</div>
<div id="Operation_Table"> 
			<div class="title">
				<div id="title_zi">用户信息</div>
			</div>
		<table cellspacing="0">
			<tr>
					<td  class="blue"> 
			    		<input type="radio" name="r_con" id="r_con" value="0"  index="9" checked>服务号码 
			    </td>
			    <td colspan=5>
			        <%if (workNo.substring(0, 1).trim().equals("kk")) {%>
			        <%String userPhoneNo = (String) session.getAttribute("userPhoneNo");%>
			        <input
			                id=Text2 type=text size=17 name=queryContent v_type="mobphone" v_name="服务号码" disabled maxlength=11 index="5"
			                onKeyUp="if(event.keyCode==13)submitt()" value="<%=userPhoneNo%>">
			        <%} else {%>
			        <input   id=Text2 type=text size=17 name="phoneNo" 
			         value="<%=activePhone%>"  class="InputGrey" readonly >
			        <%}%>
			     </td>
			</tr>
			<tr>
			    <td class="blue" width="20%" nowrap>用户ID</td>
			    <td width="21%">
			        <input id=Text2 type=text size=17 name=userId class="InputGrey" readonly>
			    </td>
			    <td class="blue" width="12%" nowrap>当前状态</td>
			    <td width="21%">
			        <input type=text size=17 name=runName class="InputGrey" readonly>
			    </td>
			    <td class="blue" width="16%" nowrap>级别</td>
			    <td>
			        <input type=text size=17 name=gradeName class="InputGrey" readonly>
			    </td>
			</tr>
			<tr>
			    <td class="blue">当前预存</td>
			    <td>
			        <input id=Text2 type=text size=17 name=totalPrepay class="InputGrey" readonly>
			    </td>
			    <td class="blue">当前欠费</td>
			    <td>
			        <input id=Text2 type=text size=17 name=totalOwe class="InputGrey" readonly>
			    </td>
			    <td class="blue" nowrap>大客户标志</td>
			    <td>
			        <input type=text size=15 name=cardType class="InputGrey" readonly>
			    </td>
			</tr>
			<tr>
			    <td class="blue"> 客户名称</td>
			    <td>
			        <input type=text size=17 name=custName id="custName" class="InputGrey" readonly>
			    </td>
			    <td class="blue"> 产品名称</td>
			    <td>
			        <input type=text size=17 name=productName class="InputGrey" readonly>
			    </td>
			    <td class="blue">固话登陆账户</td>
			    <td>
			        <input type=text size=17 name=cfmLogin id="cfmLogin" class="InputGrey" readonly>
			    </td>
			</tr>
			<tr id=noBackDiv style="display:none">
			    <td class="blue">不可退预存</td>
					<td>
			   			 <input id=Text2 type=text size=17 name=noBack class="InputGrey" readonly>
			    </td>
			    <td class="blue">可退预存</td>
			    <td>
			        <input id=Text2 type=text size=17 name=backPrepay id="backPrepay" class="InputGrey" readonly>
			    </td>
			    <td class="blue">利息</td>
			    <td width="19%" colspan=2>
			        <input id=Text2 type=text size=17 name=lxPrepay class="InputGrey" readonly>
			    </td>
			</tr>
			<tr id=backDiv style="display:none">
			    <td class="blue">转存号码</td>
			    <td>
			        <input type=text maxlength="11" size=17 name=vPhoneNo>
			        <input class="b_text" type="button" name="qCustIdByPhone" value="查询" onClick="m479GetByPhone(vPhoneNo)">
			    </td>
			    <td class="blue">转存帐户</td>
			    <td width="19%" colspan=4>
			        <input type=text size=17 name=vConID class="InputGrey" readonly>
			    </td>
			</tr>
			<tr>
			    <td class="blue"> 证件名称</td>
			    <td>
			        <input id=Text2 type=text size=17 name=iccName class="InputGrey" readonly>
			    </td>
			    <td class="blue">证件号码</td>
			    <td>
			        <input id=Text2 type=text size=17 name=iccNo class="InputGrey" readonly>
			    </td>
			    <td class="blue">入网时间</td>
			    <td width="19%" colspan=2>
			        <input id=Text2 type=text size=25 name=innerTime class="InputGrey" readonly>
			    </td>
			</tr>
			<tr id="userOldResDiv1" style=display:none>
				<td  class="blue">设备类型</td>
				<td>
				  	<input id="deviceTypeOld" name="deviceTypeOld" readonly>
				</td>
				<td  class="blue">设备编码</td>  
				<td> 
					  <input id="deviceCodeOld" name="deviceCodeOld"  readonly> 
				</td> 
				<td  class="blue">设备安装地址</td>  
				<td> 
				  	<input id="deviceInAddressOld" name="deviceInAddressOld"  readonly> 
				 	  <input type="hidden" id="factoryOld" name="factoryOld" >
				</td> 
					 
			</tr>
			<tr id="userOldResDiv2" style=display:none>
				<td  class="blue"> 端口类型</td>
				<td>
				   	<input id="portTypeOld" name="portTypeOld" readonly>
				</td>
				<td class="blue"> 端口编码</td>  
				<td> 
						<input id="portCodeOld" name="portCodeOld"   readonly> 
				</td>  
				<td class="blue" >ip地址</td>
				<td>
						<input id="ipAddressOld" name="ipAddressOld" readonly>
						<input type="hidden" id="modelOld" name="modelOld" >
				</td>	  	 
			</tr>
			
			<tr>
					<td class="blue">手续费</td>
					<td>
					    <input type="text" size=17 name=handFee id="handFee" readonly class="InputGrey" v_type=float v_name="手续费" index="7">
					</td>
					<td class="blue">实收</td>
					<td colspan="3">
						<input id="factPay" type=text size=17 name="factPay" index="8" 
						 disabled v_type="money" />
					</td>
			</tr>
			<!--关于报送2013年9月第一批业务支撑系统市场专业需求的函-关于上报CRM、BOSS和经分系统需求的请示 hejwa add 2013年10月28日9:32:54-->
			<tr id="modemFlagTr" style="display:none">
					<td class="blue">是否返回调制解调器</td>
					<td colspan=5>
								<input type="radio" name="iModemFlag"     value="1" checked /> 是
								<input type="radio" name="iModemFlag"     value="0" /> 否
					</td>
					 
			</tr>	
			
			<tr id=constructDiv style="display:none">
					<td class="blue">施工要求</td>
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
				  	<td class="blue">销户原因</td>
				  <td colspan="5">
								<select id="sel_reasonDescription" style="width:300px;" name="sel_reasonDescription" onchange="set_otreson()">
										
										<option value="">--请选择--</option>
								    <option value="1">工作调动搬迁</option>
								    <option value="2">移动网速无法满足需求</option>
								    <option value="3">校园寒暑假</option>
								    <option value="4">毕业离校</option>
								    <option value="5">装维服务不好</option>
								    <option value="6">转用联通、电信、转网更换固话帐号</option>
								    <option value="7">资费不满意</option>
								    <option value="8">客户/邻居/物业不同意走明线、飞线、穿墙</option>
								    <option value="9">下单后无法安装</option>
								    <option value="10">其他原因</option>

								</select>
						</td>
				  </tr>
				  
				  <tr id="tr_otreson" style="display:none">
				  	<td colspan="6" >
				  			<textarea id="textarea_otreson" name="textarea_otreson"  cols="140" rows="3" ></textarea>
				  			<font class="orange">注：如选其他原因，请明确写明离网原因</font>
				  	</td>
				  </tr>
				  
				  			
			<tr>
					<td class="blue">系统备注</td>
					<td colspan="5">
							<input id=Text3 type=text size=80 name=remark value="">
					</td>
			</tr>
			<tr  style="display:none">
					<td class="blue">用户备注</td>
					<td colspan="5">
								<input id=Text2 type=text size=80 name=asNotes maxlength=60 onkeyup="value=value.replace(/[@#$%!^&*()<>?|]/g,'');" index="9">
					</td>
			</tr>
			<tr id="showMyMsg" style="display:none">
				<td colspan="6" ><font color="red">注：所有品牌的固话在固话销户时，须给用户退费。</font></td>
			</tr>   
		</table>
		
		<table cellSpacing="0">
		    <tbody>
		        <tr>
		            <td id="footer">
		                <input class="b_foot" name=submit type=button value="确认" index="10"
		                       onKeyUp="if(event.keyCode==13){formSubmitCfm()}" onclick="formSubmitCfm()" disabled>
		                &nbsp;&nbsp;
		                <input class="b_foot" name=back type=button value="清除" onclick="go_reset()">
		                &nbsp;&nbsp;
		                <input class="b_foot" name=back type=button value="关闭" onclick="parent.removeTab('<%=opCode%>')">
		                &nbsp;&nbsp;
		            </td>
		        </tr>
		    </tbody>
		</table>
<input type=hidden name=opCode>
<input type=hidden name=workNo value=<%=workNo%>>
<input type=hidden name=noPass value=<%=nopass%>>
<input type=hidden name=orgCode value=<%=orgCode%>>
<input type=hidden name=iChnSource id="iChnSource" value=<%=iChnSource%>>  <!--渠道标识-->
<input type=hidden name=iUserPwd id="iUserPwd" value=<%=iUserPwd%>>  <!--号码密码 -->
<input type=hidden name=sysRemark value="固话综合变更">
<input type=hidden name=ipAdd id="ipAdd" value="<%=request.getRemoteAddr()%>">
<input type=hidden name=handFeeT><!--手续费-->
<input type=hidden name=customPass><!--用户密码-->
<input type=hidden name=idCardNo><!--证件号码-->
<input type=hidden name=custAddress id="custAddress">
<input type=hidden name=backLoginAccept><!--操作成功后流水号-->
<input type=hidden name=backDate>
<input type=hidden name=favFlag value="<%=favFlag%>">
<input type=hidden name=loginAccept id="loginAccept"><!--操作流水号-->
<input type=hidden name=smName>
<input type=hidden name=cctIdOld id="cctIdOld"><!--电信局编码-->
<input type=hidden name=isConstruct value="1"><!--是否施工标志-->
<input type="hidden" name="radioValue" value=""><!--选择的opcode-->
<input type="hidden" name="radioIndex" value=""><!--选择的操作的顺序号-->
<input type="hidden" name="bindId" id="bindId" value="">
<!-- 2014/04/04 11:15:23 gaopeng 品牌sm_code -->
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
/*电子免填单打印**/
function printCommit()
{
			/*获取品牌sm_code*/
			getPubSmCode($("#cfmLogin").val());
			var ret = showPrtDlg("Detail", "确实要进行电子免填单打印吗？", "Yes");
		
	  iRetrun = showEvalConfirmDialog('确认要进行此项服务吗？');
	  if (iRetrun == 1)
	  {
	      if (document.frm.cardType.value.indexOf("中高端用户", 0) >= 0 && document.frm.opCode.value == "b544") {
	          if (rdShowConfirmDialog('该用户是中高端用户，确认要销号吗？') == 1) {
	              printFlag = 1;
	              return true;
	          }
	      } else {
	          printFlag = 1;
	          return true;
	      }
	  } else if (iRetrun == 2)
	  { 
	      if (document.frm.cardType.value.indexOf("中高端用户", 0) >= 0 && document.frm.opCode.value == "b544") {
	          if (rdShowConfirmDialog('该用户是中高端用户，确认要销号吗？') == 1) {
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
{  //显示打印对话框 
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

/*2014/04/04 11:02:20 gaopeng 调用公共查询返回品牌sm_code*/
function getPubSmCode(kdNo){
		var getdataPacket = new AJAXPacket("/npage/public/pubGetSmCode.jsp","正在获得数据，请稍候......");
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
			cust_info += "固话帐号：" + $("#cfmLogin").val() + "|";
			cust_info += "客户姓名：" + document.all.custName.value + "|";
			
			var pubSmCode = $("#pubSmCode").val();
			
			for (var i = 0; i < document.frm.radiobutton.length; i ++) {
				if (document.all.radiobutton[i].checked){
					
					var appendStr = "下月1日";
					if(pubSmCode == "kh"){
						appendStr = "下一帐期日";
					}
					
					
					var radio1 = document.all.radiobutton[i].value
					//alert(radio1);
					if (radio1 == "m479"){
					  opr_info += "业务受理时间：<%=dateStr2222%>" + "|";	
						opr_info += "办理业务：暂停" + "|";
						opr_info += "操作流水：" + document.frm.loginAccept.value + "|";
						opr_info += "业务生效时间:预约生效|";//，"+appendStr+"起开始执行暂停处理" + "|";	
									
					} else if (radio1 == "m480") {
						opr_info += "业务受理时间：<%=dateStr2222%>" + "|";
						opr_info += "办理业务：复机" + "|";
						opr_info += "操作流水：" + document.frm.loginAccept.value + "|";
						opr_info += "业务生效时间：立即生效" + "|";
					} else if (radio1 == "m481") {
						cust_info += "客户地址：" + $("#custAddress").val() + "|";
						opr_info += "办理业务：销户" + "|";
						opr_info += "操作流水：" + document.frm.loginAccept.value + "|";
						/* 
					   * 关于协助开发省广电合作固话话费营销案和融合套餐需求的函（单品部分）@2014/7/24 
					   * 新增省广电kg，备用品牌kh
					   */
						if(pubSmCode == "kf" || pubSmCode == "kg" || pubSmCode == "kh" || pubSmCode == "ki"){
						}else{
							//note_info2 += "办理预销的24小时内即停止使用。预销当月的费用按当时的资费标准正常收取。预销30天后，请机主本人持有效证件及大于等于剩余金额的预存款发票到营业厅办理正式销户手续。" + "|";
						}
					} else if (radio1 == "b544") {
						opr_info += "办理业务：销户" + "|";
						opr_info += "操作流水：" + document.frm.loginAccept.value + "|";
						opr_info += "退费金额：" + document.frm.backPrepay.value + "元|";
						/* 
					   * 关于协助开发省广电合作固话话费营销案和融合套餐需求的函（单品部分）@2014/7/24 
					   * 新增省广电kg，备用品牌kh
					   */
						if(pubSmCode == "kf" || pubSmCode == "kg" || pubSmCode == "kh" || pubSmCode == "ki"){
						}else{
							note_info2 += "如申请办理销户后，要求重新恢复此业务，将按照新用户申请固话业务流程办理。" + "|";
						}
						
					}else{
						opr_info +="|";
					}
				}
			}
			/*2014/04/09 9:39:49 gaopeng 修改免填单 移动家庭客户固话业务运营支撑系统需求*/
			note_info1 += ""+"|";
			note_info1 += "备注："+"|";
			/* 
		   * 关于协助开发省广电合作固话话费营销案和融合套餐需求的函（单品部分）@2014/7/24 
		   * 新增省广电kg，备用品牌kh
		   */
			if(pubSmCode == "kf" || pubSmCode == "kg" || pubSmCode == "kh" || pubSmCode == "ki"){
				if (radio1 == "m479"){
					note_info1 += "1、用户余额大于一个月应出账金额，同时须交纳10元暂停手续费+30元预存款办理暂停业务方可生效。暂停收取10元手续费；"+"|";
					note_info1 += "暂停期间仅收取10元/月停机通道占用费，在预存款中可扣除，不足一个月按一个月计；"+"|";
					note_info1 += "2、暂停申请当月费用按当时资费标准正常收取。|";//；"+appendStr+"起开始执行暂停处理；"+"|";
					note_info1 += "3、暂停最长期限为90天，如逾期用户没有来办理复机，则系统自动恢复正常且实行报暂停前资费。如用户主动复机，则立即生效，当月按报暂停当时的资费标准收取；"+"|";
					note_info1 += "4、固话业务到期时间按暂停期整月数量顺延，例暂停2个月10天、则到期时间顺延2个月，以此类推；"+"|";
					note_info1 += "5、一年内允许2次报暂停；"+"|";
					note_info1 += "6、与手机营销案捆绑的固话不允许报暂停延长有效期。"+"|";
					note_info1 += "7、当联系电话变动时，请及时与移动公司联系，以便于有新活动或服务到期时及时收到通知。"+"|";
					note_info1 += "8、如需帮助，请拨打服务热线：10086。"+"|";
				}else if(radio1 == "m480"){
					note_info1 += "1、用户主动复机，立即生效，当月按报暂停当时的资费标准收取。"+"|";
					note_info1 += "2、当联系电话变动时，请及时与移动公司联系，以便于有新活动或服务到期时及时收到通知。"+"|";
					note_info1 += "3、如需帮助，请拨打服务热线：10086。"+"|";
					
				}else if(radio1 == "m481"){
					//note_info1 += "1、办理预销的24小时内即停止使用。预销当月的费用按当时的资费标准正常收取。预销30天后，请机主本人持有效证件及大于等于剩余金额的预存款发票到营业厅办理正式销户手续。"+"|";
					//note_info1 += "2、当联系电话变动时，请及时与移动公司联系，以便于有新活动或服务到期时及时收到通知。"+"|";
					//note_info1 += "3、如需帮助，请拨打服务热线：10086。"+"|";
					
				}else if(radio1 == "b544"){
					note_info1 += "1、如申请办理销户后，要求重新恢复此业务，将按照新用户申请流程办理。"+"|";
					note_info1 += "2、如需帮助，请拨打服务热线：10086。"+"|";
					
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
        infoStr += document.frm.phoneNo.value + "|";//移动号码                                                                                                    
        infoStr += "" + "|";//合同号码                                                          
        infoStr += document.frm.custName.value + "|";//用户名称                                                
        infoStr += document.frm.custAddress.value + "|";//用户地址  
        infoStr += "现金" + "|";
        infoStr += document.frm.handFee.value + "|";
        infoStr += document.frm.sysRemark.value + "。*手续费：" + document.frm.handFee.value + "*流水号：" + document.frm.backLoginAccept.value + "|";
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
		printStr = "报停手续费：";
		opName = "固话业务暂停";
	}else if(document.frm.opCode.value == "m480"){
		printStr = "复机手续费：";
		opName = "固话业务暂停恢复";
	}else if(document.frm.opCode.value == "m481" ){
		printStr = "退费金额：";
		opName = "固话销户";
		cashPay = document.frm.backPrepay.value;
	}else{
		printStr = "退费金额：";
		opName = "固话销户";
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
	printInfo += printStr + cashPay + "元" + "~";
	/* 
   * 关于协助开发省广电合作固话话费营销案和融合套餐需求的函（单品部分）@2014/7/24 
   * 新增省广电kg，备用品牌kh
   */
	if(pubSmCode == "kf" || pubSmCode == "kg" || pubSmCode == "kh" || pubSmCode == "ki"){
		printInfo += "客服热线：10086" + "|";
	}else{
		printInfo += "客服热线：10050" + "~";
		printInfo += "网址：http://www.10050.net" + "|";
	}
		var  billArgsObj = new Object();
	    $(billArgsObj).attr("10001","<%=workNo%>");       //工号
 		$(billArgsObj).attr("10002","<%=new java.text.SimpleDateFormat("yyyy",Locale.getDefault()).format(new java.util.Date())%>");
 		$(billArgsObj).attr("10003","<%=new java.text.SimpleDateFormat("MM",Locale.getDefault()).format(new java.util.Date())%>");
 		$(billArgsObj).attr("10004","<%=new java.text.SimpleDateFormat("dd",Locale.getDefault()).format(new java.util.Date())%>");
 		$(billArgsObj).attr("10005",custName); //客户名称
 		$(billArgsObj).attr("10006",opName); //业务类别
 		$(billArgsObj).attr("10008","<%=activePhone%>"); //用户号码
 		
 		
 		if(document.frm.opCode.value == "m479"||document.frm.opCode.value == "m480"){
 			$(billArgsObj).attr("10015", cashPay); //本次发票金额(小写)￥
 			$(billArgsObj).attr("10016", cashPay); //大写金额合计
 		} 
 		var sumtypes1="*";
 		var sumtypes2="";
 		var sumtypes3="";
 		$(billArgsObj).attr("10017",sumtypes1); //本次缴费现金
 		$(billArgsObj).attr("10018",sumtypes2); //支票
 		$(billArgsObj).attr("10019",sumtypes3); //刷卡
 
 		
 		if(document.frm.opCode.value == "m481"){
 			 			
 			$(billArgsObj).attr("10021", cashPay);
 			$(billArgsObj).attr("10015", cashPay); //本次发票金额(小写)￥
 			$(billArgsObj).attr("10016", cashPay); //大写金额合计
 			
 		}
 		$(billArgsObj).attr("10030",prtLoginAccept); //流水号--业务流水
 		$(billArgsObj).attr("10036",document.frm.opCode.value); //操作代码
 		$(billArgsObj).attr("10074","<%=id_no%>"); 
 		$(billArgsObj).attr("10075","<%=contract_no%>"); 
 		$(billArgsObj).attr("10007","<%=smcode%>"); 
 		var path = "";
	 	/* 
	   * 关于协助开发省广电合作固话话费营销案和融合套餐需求的函（单品部分）@2014/7/24 
	   * 新增省广电kg，备用品牌kh
	   */
	 
 		if(pubSmCode == "kf" || pubSmCode == "kg" || pubSmCode == "kh" || pubSmCode == "ki"){
 			//path = "/npage/public/pubBillPrintCfm_YGZ.jsp?dlgMsg=" + "发票打印";
 						//发票项目修改为新路径
			var path = "/npage/public/billPrtNew/Bill_ELE_Prt.jsp?dlgMsg=" + "发票打印";
	
		}else{
			path = "/npage/public/pubBillPrintBroad.jsp?dlgMsg=" + "发票打印";
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
		 infoStr += document.frm.phoneNo.value + "|";//移动号码                                                                                                    
		 infoStr += document.frm.backPrepay.value + "*" + document.frm.lxPrepay.value + "*" + document.frm.noBack.value + "|";//合同号码                                                          
		 infoStr += document.frm.custName.value + "|";//用户名称                                                
		 infoStr += document.frm.custAddress.value + "|";//用户地址  
		 infoStr += "现金" + "|";
		 infoStr += document.frm.handFee.value + "|";
		 infoStr += document.frm.sysRemark.value + "。*手续费：" + document.frm.handFee.value + "*流水号：" + document.frm.backLoginAccept.value + "|";
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
    infoStr += document.frm.phoneNo.value + "|";//移动号码                                                                                                    
    infoStr += document.frm.backPrepay.value + "*" + document.frm.lxPrepay.value + "*" + document.frm.noBack.value + "|";//合同号码                                                           
    infoStr += document.frm.custName.value + "|";//用户名称                                                
    infoStr += document.frm.custAddress.value + "|";//用户地址  
    infoStr += "现金" + "|";
    infoStr += document.frm.handFee.value + "|";
    infoStr += document.frm.sysRemark.value + "。*手续费：" + document.frm.handFee.value + "*流水号：" + document.frm.backLoginAccept.value + "|";
    location.href = "chkTwoPrintZero.jsp?retInfo=" + infoStr + "&dirtPage=fm480_1.jsp&activePhone=<%=activePhone%>";
}
function printThreeBill() {
    var infoStr = "";
    infoStr += document.frm.remark.value + "|";
    infoStr += '<%=new java.text.SimpleDateFormat("yyyy", Locale.getDefault()).format(new java.util.Date())%>' + "|";
    infoStr += '<%=new java.text.SimpleDateFormat("MM", Locale.getDefault()).format(new java.util.Date())%>' + "|";
    infoStr += '<%=new java.text.SimpleDateFormat("dd", Locale.getDefault()).format(new java.util.Date())%>' + "|";
    infoStr += document.frm.phoneNo.value + "|";//移动号码                                                                                                    
    infoStr += document.frm.backPrepay.value + "|";//可退预存                                                          
    infoStr += document.frm.custName.value + "|";//用户名称                                                
    infoStr += document.frm.custAddress.value + "|";//用户地址  
    infoStr += document.frm.idCardNo.value + "|";//证件号码
    infoStr += document.frm.handFee.value + "|";
    infoStr += document.frm.sysRemark.value + "。*手续费：" + document.frm.handFee.value + "*流水号：" + document.frm.backLoginAccept.value + "|";
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
    infoStr += document.frm.phoneNo.value + "|";//移动号码                                                                                                    
    infoStr += document.frm.backPrepay.value + "|";//可退预存                                                          
    infoStr += document.frm.custName.value + "|";//用户名称                                                
    infoStr += document.frm.custAddress.value + "|";//用户地址  
    infoStr += document.frm.idCardNo.value + "|";//证件号码
    infoStr += document.frm.handFee.value + "|";
    infoStr += document.frm.sysRemark.value + "。*手续费：" + document.frm.handFee.value + "*流水号：" + document.frm.backLoginAccept.value + "|";
    //infoStr+=document.frm.backDate.value+"|";
    //rdShowMessageDialog(document.frm.backDate.value);
    location.href = "chkThreePrintZero.jsp?backDate=" + document.frm.backDate.value + "&retInfo=" + infoStr + "&dirtPage=fm480_1.jsp&activePhone=<%=activePhone%>";
}
</script>


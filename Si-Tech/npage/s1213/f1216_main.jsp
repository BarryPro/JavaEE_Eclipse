<%
    /********************
     version v2.0
     开发商: si-tech
     *
     *update:zhanghonga@2008-08-27 页面改造,修改样式
     *     
     ********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ include file="/npage/bill/getMaxAccept.jsp" %>
<%
    String opCode=request.getParameter("opCode");
		String opName=request.getParameter("opName");
    //流水号
 		String loginAccept1 = getMaxAccept();
    String orgCode = (String)session.getAttribute("orgCode");
    String regionCode = orgCode.substring(0,2);
    String workName = (String)session.getAttribute("workName");
    String sqIdtype = "select id_type,id_name from sidtype";
    String accountType = (String)session.getAttribute("accountType"); //1 为营业工号 2 为客服工号
    String display = "";
    System.out.println("accountType="+accountType);
    if("2".equals(accountType.trim())){
    	display ="style = \"display:none\"";
    }
    System.out.println("display="+display);
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
	//因为免密码校验统一放到框架中去了.这里可以废弃
	int favFlag = 0;
	for (int i = 0; i < favInfo.length; i++) {
		if (favInfo[i][0].trim().equals("a272")) {
		    favFlag = 1;
		}
	}
	***/
    
    int favFlag = 1;
    String org_codeT = orgCode;
    String region_codeT = org_codeT.substring(0, 2);
String feeSql = "select function_code, hand_fee,hand_fee,function_code from sNewFunctionFee where region_code = '" + region_codeT + "'";%>
		<wtc:pubselect name="sPubSelect" routerKey="phone" routerValue="<%=activePhone%>" outnum="4">
		<wtc:sql><%=feeSql%></wtc:sql>
		</wtc:pubselect>
		<wtc:array id="fee" scope="end" />
<%
    String workSql = "select count(*) from shighlogin where login_no = '" + workNo + "' and op_code='1218'";
%>
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
			<wtc:param value="销户查询用户信息" />
</wtc:service>				
<wtc:array id="baseArr" scope="end"/>
<%
String id_no="";
String contract_no="";
String smcode = "";
String username ="";

 if(baseArr!=null&&baseArr.length>0){
   System.out.println("baseArr.length===="+baseArr.length); 
   System.out.println("id_no=="+baseArr[0][30]);
   System.out.println("contract_no=="+baseArr[0][32]);
    	if(baseArr[0][0].equals("00")) {
    	  
          id_no = (baseArr[0][30]);
          contract_no=(baseArr[0][32]);
          smcode = (baseArr[0][38]);
          username = (baseArr[0][5]);
          }
    }

%>
<HEAD>
    <TITLE>预销和销号</TITLE>
<style type="text/css">

.table-wrap  th.bg-white{
	background-color:#fff;
	}
.cust-tab3-line{border-bottom:1px solid #c2deea; height:23px; position:absolute; z-index:1; width:97%;}
.cust-tab3-link{padding-left:20px;}
.cust-tab3-link a{display:inline-block; height:22px; line-height:22px; position:relative; z-index:2; border:1px solid #c2deea; padding:0 5px;cursor:hand;}
.cust-tab3-link a.on{border-bottom:1px solid #f7feff; background:#f7feff;font-weight:bold;}
</style>
<script language="javascript" type="text/javascript" src="/npage/public/knockout-2.0.0.js" ></script>
<script language="javascript">
var printFlag = 9;
var flag = 0;
var checkphonflag="0";

onload = function() {

}

function doProcess(packet) {
    var backString = packet.data.findValueByName("backString");
    var cfmFlag = packet.data.findValueByName("flag");
    /***
    if (cfmFlag == 99) {
        if (backString == 1) {
            rdShowMessageDialog("验证成功！",2);
            document.frm.submit.disabled = false;
        } else {
            rdShowMessageDialog("密码不正确！");
            document.frm.submit.disabled = true;
        }
    }
    ***/
    
    if (cfmFlag == 1) {
        var errMsg = packet.data.findValueByName("errMsg");
        var errCode = packet.data.findValueByName("errCode");
        var errCodeInt = parseInt(errCode, 10);
        
        if (errCodeInt == 0) {
            rdShowMessageDialog("操作成功！",2);
            document.frm.backLoginAccept.value = backString[0][0];
            if (document.frm.opCode.value == "1218") {
                //rdShowMessageDialog(1);
                if (document.frm.handFee.value != 0) {
                    printTwoBill();
                } else {
                    printTwoBillZero();
                }

            }else if (document.frm.opCode.value == "1216") {
                if (document.frm.handFee.value != 0) {
                //liujian 2012-8-20 8:57:21 取消发票打印
                //    printThreeBill();
                } else {
                //liujian 2012-8-20 8:57:21 取消发票打印
                //    printThreeBillZero();
                }
            }else if (document.frm.handFee.value != 0) {
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


            document.frm.new_srv_no.value = "";
            document.frm.contactPhone.value = "";
            
            document.frm.productName.value = "";
            resett();
            return;
        }

    }
    if (cfmFlag == 9) {
        var errCode = packet.data.findValueByName("errCode");
        var errMsg = packet.data.findValueByName("errMsg");
        rdShowMessageDialog(errCode + " : " + errMsg);
        /*** ningtn CRM客服系统
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
        if (document.frm.cardType.value.indexOf("中高端用户", 0) >= 0) {
            rdShowMessageDialog("该用户是中高端用户！");
        }
        /* 
        //liujian add 去掉中高端销号的限制 begin
        if (document.frm.cardType.value.indexOf("中高端用户", 0) >= 0 && <%=higflag%> ==0 && document.frm.opCode.value == "1218"){
		        rdShowMessageDialog("该用户是中高端用户,此工号没有销号权限！");
		        return;
    		}
    		//liujian add 去掉中高端销号的限制 end   
				*/
				
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
        document.frm.wxyyhy.value = backString[0][38];
        if(backString[0][38]=="0") {
        document.frm.wxyuhya.value="否";
        }
        if(backString[0][38]=="1") {
        document.frm.wxyuhya.value="是";
        }

        document.frm.factPay.disabled = false;
        
        /*begin diling add for 增加显示用户积分*/
        var vPacket = new AJAXPacket("getUserIntegralInfo.jsp", "正在提交，请稍候......");
        vPacket.data.add("loginAccept", document.frm.loginAccept.value);
        vPacket.data.add("iChnSource", document.frm.iChnSource.value);
        vPacket.data.add("opCode", document.frm.opCode.value);
        vPacket.data.add("workNo", document.frm.workNo.value);
        vPacket.data.add("noPass", document.frm.noPass.value);
        vPacket.data.add("phoneNo", document.frm.phoneNo.value);
        vPacket.data.add("iUserPwd ", document.frm.iUserPwd .value);   
        core.ajax.sendPacket(vPacket,doGetUserIntegralInfo);
        vPacket=null;
        /*end diling add */
        
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
                /*** ningtn CRM客服系统
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


}
/*begin diling add for 展示用户积分回调函数@2012/6/21*/
function doGetUserIntegralInfo(packet){
  var retCode = packet.data.findValueByName("retcode");
  var retMsg = packet.data.findValueByName("retmsg");
  var custJFv1 = packet.data.findValueByName("custJFv1");
  $("#userIntegral").val(custJFv1);
}
/*end diling add */
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
        rdShowMessageDialog("请选择操作类型!");
        return;
    }
		/*** ningtn CRM客服系统
    document.frm.qry.disabled = true;
    ***/
    var ii = 0 ;
    for (ii = 0; ii < document.frm.radiobutton.length; ii ++) {
        document.all.radiobutton[ii].disabled = true;
    }
    var myPacket = new AJAXPacket("getUserInfo.jsp", "正在提交，请稍候......");
    myPacket.data.add("loginAccept", document.frm.loginAccept.value);
    myPacket.data.add("iChnSource", document.frm.iChnSource.value);
    myPacket.data.add("opCode", document.frm.opCode.value);
    myPacket.data.add("workNo", document.frm.workNo.value);
    myPacket.data.add("opCode", document.frm.opCode.value);
    myPacket.data.add("phoneNo", document.frm.phoneNo.value);
    myPacket.data.add("iUserPwd ", document.frm.iUserPwd .value);    
    core.ajax.sendPacket(myPacket);
    myPacket=null;
    if(document.frm.opCode.value == "1216"){
	    getPriceRevoMsg();
	  }
}
	function getPriceRevoMsg(){
		var getdataPacket = new AJAXPacket("/npage/se761/fe759PubPriceRevoMsg.jsp","请稍后...");
		getdataPacket.data.add("opCode","<%=opCode%>");
		getdataPacket.data.add("phoneNo","<%=activePhone%>");
		getdataPacket.data.add("qryType","3");
		getdataPacket.data.add("flag","0");
		core.ajax.sendPacketHtml(getdataPacket,doGetPriceRevoMsgHtml);
		getdataPacket =null;
	}
	function doGetPriceRevoMsgHtml(data){
		$("#stockTab").empty();
		$("#stockTab").append(data);
		$("#prodLibDiv").show();
		/* 用户资源量，当前使用、下月预约 点击触发的事件 */
		$(".m-box-txt2 a").click(function(){
			$(this).addClass("on").siblings("a").removeClass("on");
			num = $(".m-box-txt2 a").index($(this)[0]);
			$(".m-box-txt2 .tab-con").eq(num).show().siblings(".tab-con").hide();
		});
		if($("#stockTab").find("table").eq(0).find("tr").length > 1){
			viewModel.resourceAvailability(true);
  	}else{
  		viewModel.resourceAvailability(false);
  	}
	}
	function changeType(){
		/*点转赠类型，换属性*/
		var preNoType = $('input[@name=giveType][@checked]').val();
		if(preNoType == "1"){
			/*手机号码*/
			$("#giveNumber").attr("v_type","mobphone");
		}else if(preNoType == "0"){
			/*身份证号码*/
			$("#giveNumber").attr("v_type","idcard");
		}
	}
	function checkNumber(){
		
		var preNo = $("#giveNumber").val();
		var preNoType = $('input[@name=giveType][@checked]').val();
		
		if(!checkElement(document.frm.giveNumber)){
			return false;
		}
		
		var getdataPacket = new AJAXPacket("/npage/se761/pubGetPreQry.jsp","请稍后...");
		getdataPacket.data.add("opCode","<%=opCode%>");
		getdataPacket.data.add("phoneNo","<%=activePhone%>");
		getdataPacket.data.add("queryType","0");
		getdataPacket.data.add("serivceName","sPreSrcQry");
		getdataPacket.data.add("preNo",preNo);
		getdataPacket.data.add("preNoType",preNoType);
		core.ajax.sendPacket(getdataPacket,checkNumberBack);
		getdataPacket = null;
	}
	function checkNumberBack(packet){
		var retCode = packet.data.findValueByName("retcode");
		var retMsg = packet.data.findValueByName("retmsg");
		if(retCode == "000000"){
			rdShowMessageDialog("校验成功！",2);
			$("#giveNumber").attr("readonly","readOnly");
			viewModel.checkFlag(true);
		}else{
			rdShowMessageDialog("校验失败" +retCode + retMsg,0);
		}
		
	}
	
	function returnretcodes(packet){
      var retcode = packet.data.findValueByName("retcode");
      var retmsg = packet.data.findValueByName("retmsg");
      if(retcode != "000000"){
        rdShowMessageDialog("校验失败！错误代码：" + retcode + "，错误信息：" + retmsg,0);
       	checkphonflag="1";
      }else{
   			checkphonflag="0";
      }
    }
	
	
function getRemain() {

    if (flag != 1) {
        rdShowMessageDialog("请先查询用户信息！");
        return;
    }


    if (parseFloat(document.frm.handFee.value) > parseFloat(document.frm.handFeeT.value)) {
        rdShowMessageDialog("手续费不能大于" + document.frm.handFeeT.value);
        return;
    }

    document.frm.remain.value = document.frm.factPay.value - document.frm.handFee.value;
}


/******** 预销或销户时增加积分提示信息 added by hanfa 20070117 begin *********/
function formSubmitCfm()
{ 
	//getAfterPrompt();
    if (document.all.radioValue.value == '1216')
    {
    	
    	if($("#isxiaohu").val()=="Y"){
	    	 if($("#contactPhone").attr("v_send_flag")!="Y"){
	    	 	rdShowMessageDialog("请先验证联系人短信");
	    	 	return;
	    	 }
  		}
  		
       var isxiaohu = $("#isxiaohu").val();    			
    		if(isxiaohu=="Y") {
    		
    	if(checkElement(document.all.new_srv_no)==false){
    	document.frm.new_srv_no.focus();
    	return false;
    	}
    	
    	if(checkElement(document.all.contactPhone)==false){
    	document.frm.contactPhone.focus();
    	return false;
    	}
    	
    	if (document.frm.new_srv_no.value == document.frm.phoneNo.value)
      {
        rdShowMessageDialog("转费手机号码不能与服务号码相同，请重新填写！");
        document.frm.new_srv_no.value = "";
        document.frm.new_srv_no.focus();
        return false;
      }
    	if (document.frm.contactPhone.value == document.frm.phoneNo.value)
      {
        rdShowMessageDialog("客户联系电话不能与服务号码相同，请重新填写！");
        document.frm.contactPhone.value = "";
        document.frm.contactPhone.focus();
        return false;
      }
      
      	var myPacketsd = new AJAXPacket("checkPhoneNos.jsp","正在验证新SIM类型，请稍候......");
				myPacketsd.data.add("yewuphoneno",document.frm.phoneNo.value);
				myPacketsd.data.add("zhuanfeiphoneno",document.frm.new_srv_no.value);
				myPacketsd.data.add("lianxiphonno",document.frm.contactPhone.value);
				core.ajax.sendPacket(myPacketsd,returnretcodes);
				myPacketsd=null;
				
				if(checkphonflag=="1") {
					return false;
				}
      
      }    

    
    	/*资费革命 ningtn 2012-4-24 18:13:10
    	如果用户还有预约的产品，不允许办理办理预销
    	*/
    	if($("#stockTab").find("table").eq(2).find("tr").length > 1){
				rdShowMessageDialog("用户有预约的产品，不允许办理预销");
				return false;
    	}
    	/******
    	如果用户选择了资源转赠，那么没填写转增号码或者没校验通过，不允许继续办理
    	*/
    	if(viewModel.giveAvailability()){
    		if(!viewModel.checkFlag()){
    			rdShowMessageDialog("请设置完资源量转增号码后再进行业务办理");
					return false;
    		}
    	}
    	if(!$("#oaTd1").is(":hidden")){
	    	var oaNum = $("#oaNum").val().trim();
	      	if(oaNum==""){
	    		rdShowMessageDialog("OA编号不能为空!");
	    	    return false;
	    	}
		}
    	
        if (rdShowConfirmDialog("用户办理预销，积分将清零，请提示客户兑换积分。<br><br>确认进行下一步操作吗？") == 1)
        {
			/*************gonght add 2009-3-25 13:35:05***************/
			var count = document.all.family_count.value;
	 		var ret1 = document.all.family_order.value;
	 		if(typeof(ret1)!="undefined")
	 		{
	 			if((ret1==1)||(count<=3 && count!=0))
	 			{
	 				if(rdShowConfirmDialog('该成员预销后，家庭将解散，是否确认？')==1)
	 				{
	 					 submitCfm();
	 				}
	 				else
			        {
			            return false;
			        }
	 			}
	 			else
	 			{
	 				submitCfm();
	 			}
	 		}
	 		/*************gonght add end************************/
        }
        else
        {
            return false;
        }
    }
    else if (document.all.radioValue.value == '1218')
    {
    		rdShowMessageDialog("如原机主捆绑了银行或其它服务行业等第三方公司信息，或办理移动宽带时预留了本手机号码，应在申请办理本手机号码的过户或销户前主动变更所留存的联系电话号码或解除捆绑关系！用户办理销号，积分将清零，请提示客户兑换积分。");
        if (rdShowConfirmDialog("确认进行下一步操作吗？") == 1)
        {
            submitCfm();
        }
        else
        {
            return false;
        }
    }
    else
    {
        submitCfm();
    }

}
/******** 预销或销户时增加积分提示信息 added by hanfa 20070117 end *********/

 /*2014/04/04 11:02:20 gaopeng 调用公共查询返回品牌sm_code*/
function getPubSmCode(myNo){
		var getdataPacket = new AJAXPacket("/npage/public/pubGetSmCode.jsp","正在获得数据，请稍候......");
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
	getAfterPrompt(op_code);
    if (flag == 1) {
        if (document.frm.remark.value.length == 0) {
            document.frm.remark.value = document.frm.sysRemark.value;
            document.frm.remark.value = "用户号码" + document.frm.phoneNo.value + "用户姓名" + document.frm.custName.value + "进行" + document.frm.remark.value + "。";
        }
        
        //if(document.frm.asNotes.value.trim().len()==0){
        		//document.frm.asNotes.value=document.frm.remark.value;
        // }
        if (!forMoney(document.frm.handFee)) {
            return;
        }
        if (parseFloat(document.frm.handFee.value) > parseFloat(document.frm.handFeeT.value)) {
            rdShowMessageDialog("手续费不能大于" + document.frm.handFeeT.value);
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
	    var vPhoneNo = document.frm.phoneNo.value;
	    getPubSmCode(vPhoneNo);
 			var pubSmCode = $("#pubSmCode").val();
			var preNoType = $('input[@name=giveType][@checked]').val();
	    /*gaopeng 2013/4/2 星期二 18:34:04 物联网需求 判断是205 206开头的物联网号码，进行调用zhangzhea的服务sWLWInterFace begin */
	    if((pubSmCode=="PA"||pubSmCode=="PB") && op_code != "1218")
			{
				//alert(document.frm.opCode.value);
				/*alert("<%=loginAccept1%>");*/
				 var myPacket = new AJAXPacket("/npage/public/sWLWI.jsp", "正在提交，请稍候......");
			    myPacket.data.add("iLoginAccept","<%=loginAccept1%>");													//流水              
			    myPacket.data.add("iChnSource", document.frm.iChnSource.value);									//渠道标识          
			    myPacket.data.add("iOpCode", document.frm.opCode.value);												//操作代码          
			    myPacket.data.add("iLoginNo", document.frm.workNo.value);												//操作工号	        
			    myPacket.data.add("iLoginPwd", document.frm.noPass.value);											//工号密码	        
			    myPacket.data.add("iPhoneNo", document.frm.phoneNo.value); 											//手机号码	        
			    myPacket.data.add("iUserPwd", document.frm.iUserPwd.value);											//号码密码          
			    myPacket.data.add("iOrgCode", document.frm.orgCode.value);											//工号归属          
			    myPacket.data.add("iIdNo", "");                        													//用户ID		        
			    myPacket.data.add("iOldSim", "");                       												//用户旧SIM卡号			
			    myPacket.data.add("iOldSimStatus", "");                                         //用户旧SMI卡状态	  
			    myPacket.data.add("iNewSim", "");                                               //用户新SIM卡号	    
			    myPacket.data.add("iNewSimShouldFee", "");                											//用户新SIM卡应收费 
			    myPacket.data.add("iNewSimRealFee", "");                                        //用户新SIM卡实收费 
			    myPacket.data.add("iHandShouldFee", document.frm.handFeeT.value);               //用户手续费应收		
			    myPacket.data.add("iHandRealFee", document.frm.handFee.value);                  //用户手续费实收	  
			    myPacket.data.add("iSystemNote", document.frm.sysRemark.value);                 //系统备注          
			    myPacket.data.add("iOpNote", document.frm.asNotes.value);                       //用户备注          
			    myPacket.data.add("iIpAddr", document.frm.ipAdd.value);                         //IP地址            
			    myPacket.data.add("iCardBZ", "");                                               //写卡状态          
			    myPacket.data.add("iCardStatus", "");                                           //空卡状态          
			    myPacket.data.add("iCardNo", "");                                               //空卡卡号          
			    myPacket.data.add("iTransConId", "");                    //转存帐户          
			    myPacket.data.add("iTransMoney", document.frm.backPrepay.value);                //转存金额          
			    myPacket.data.add("iTransPhoneNo", "");                //转存手机号        
			    myPacket.data.add("iTurnPhoneNo", $("#giveNumber").val());                      //转赠资源号码      
			    myPacket.data.add("iTurnType", preNoType);                                      //转赠资源号码类型  
			    myPacket.data.add("iRemindPhone", "");                                          //欠费提醒号码(问diling怎么取的，目前有问题)	
			    
			    myPacket.data.add("issqxh", $("#isxiaohu").val());//号码密码
	        myPacket.data.add("zfsjhms", document.frm.new_srv_no.value);//号码密码
	        myPacket.data.add("khlxdhs", document.frm.contactPhone.value);//号码密码    
			    
			    core.ajax.sendPacket(myPacket,retsWLWI);
			    
			    myPacket=null;
					
			}
			/*gaopeng 2013/4/2 星期二 18:34:04 物联网需求 判断是205 206开头的物联网号码，进行调用zhangzhea的服务sWLWInterFace begin */
			else{
	    var myPacket = new AJAXPacket("f1213Cfm.jsp?asCustName=" + document.frm.asCustName.value + "&asCustPhone=" + document.frm.asCustPhone.value + "&asIdIccid=" + document.frm.asIdIccid.value + "&asIdAddress=" + document.frm.asIdAddress.value + "&asContractAddress=" + document.frm.asContractAddress.value + "&asNotes=" + document.frm.asNotes.value + "&sysRemark=" + document.frm.sysRemark.value + "&remark=" + document.frm.remark.value, "正在提交，请稍候......");
	    myPacket.data.add("loginAccept", document.frm.loginAccept.value);//流水
	    myPacket.data.add("iChnSource", document.frm.iChnSource.value);//渠道标识
	    myPacket.data.add("opCode", document.frm.opCode.value);//操作代码
	    myPacket.data.add("workNo", document.frm.workNo.value);//操作工号	
	    myPacket.data.add("noPass", document.frm.noPass.value);//工号密码	
	    myPacket.data.add("idNo", document.frm.phoneNo.value); //手机号码	
	    myPacket.data.add("iUserPwd", document.frm.iUserPwd.value);//号码密码
	    
	    myPacket.data.add("orgCode", document.frm.orgCode.value);//工号归属
	    myPacket.data.add("asIdType", inputIdType);
	    myPacket.data.add("handFee", document.frm.handFeeT.value);
	    myPacket.data.add("factPay", document.frm.handFee.value);
	    myPacket.data.add("lx", document.frm.lxPrepay.value);
	    myPacket.data.add("ipAdd", document.frm.ipAdd.value);
	    myPacket.data.add("vConID", "");
	    myPacket.data.add("backPrepay", document.frm.backPrepay.value);
	    myPacket.data.add("vPhoneNo", "");
	    myPacket.data.add("book_phoneNo", document.frm.phoneNo.value);	
	    myPacket.data.add("preNo", $("#giveNumber").val());	
	    myPacket.data.add("preNoType", preNoType);	
	    
	    myPacket.data.add("issqxh", $("#isxiaohu").val());//号码密码
	    myPacket.data.add("zfsjhms", document.frm.new_srv_no.value);//号码密码
	    myPacket.data.add("khlxdhs", document.frm.contactPhone.value);//号码密码
	    myPacket.data.add("ipt_sRanDomSend", $("#ipt_sRanDomSend").val());	
	    
	    
	    core.ajax.sendPacket(myPacket);
	    
	    myPacket=null;
	  }
	    if(!$("#oaTd1").is(":hidden")){
	    	var myPacket = new AJAXPacket("saveOaNumber.jsp", "正在提交，请稍候......");
		    myPacket.data.add("iLoginAccept","<%=loginAccept1%>");													//流水              
		    myPacket.data.add("iChnSource", document.frm.iChnSource.value);									//渠道标识          
		    myPacket.data.add("iOpCode", document.frm.opCode.value);												//操作代码          
		    myPacket.data.add("iLoginNo", document.frm.workNo.value);												//操作工号	        
		    myPacket.data.add("iLoginPwd", document.frm.noPass.value);											//工号密码	        
		    myPacket.data.add("iPhoneNo", document.frm.phoneNo.value); 											//手机号码	        
		    myPacket.data.add("iUserPwd", document.frm.iUserPwd.value);											//号码密码          
		    myPacket.data.add("iOANo", $("#oaNum").val());                        													//用户ID		        
		    core.ajax.sendPacket(myPacket,do_savaoanumber);
		    myPacket=null;
	    }
	    
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
function retsWLWI(packet)
{
	var errCode = packet.data.findValueByName("errCode");
   var errMsg = packet.data.findValueByName("errMsg");
   if(errCode=="000000")
   {
	   	rdShowMessageDialog("物联网用户申请信息已经发送集团公司，审批通过后继续为您办理业务。");
	   	removeCurrentTab();
   }
   else
   	{
   		rdShowMessageDialog("物联网用户申请信息发送失败！"+errCode + "[" + errMsg + "]",0);
   		removeCurrentTab();
   	}
   
}

function do_savaoanumber(packet)
{
	var errCode = packet.data.findValueByName("errCode");
   var errMsg = packet.data.findValueByName("errMsg");
   if(errCode=="000000")
   {
	   	rdShowMessageDialog("物联网用户申请信息已经发送集团公司，审批通过后继续为您办理业务。");
	   	removeCurrentTab();
   }
   else
   	{
   		rdShowMessageDialog("物联网用户申请信息发送失败！"+errCode + "[" + errMsg + "]",0);
   		removeCurrentTab();
   	}
   
}
/***
function verifyPass() {
    if (flag == 1) {
        var m = document.frm.inputPass.value;
        var n = document.frm.customPass.value;

        var myPacket = new AJAXPacket("verifyPass.jsp", "正在提交，请稍候......");

        myPacket.data.add("inputPass", m);
        myPacket.data.add("customPass", n);
        core.ajax.sendPacket(myPacket);

        myPacket=null;
    } else {
        rdShowMessageDialog("请先查询用户信息！");
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
    /*** ningtn CRM客服系统
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


    		$("#backDivsss").hide(); 
    		$("#isxiaohu").val("N")    		
    		$("#new_srv_no").val("");
    		$("#contactPhone").val("");

    document.frm.submit.disabled = true;
    document.frm.cardType.value = "";
    document.frm.idCardNo.value = "";
    document.frm.custAddress.value = "";
    flag = 0;
}

function f1213GetByPhone(formField) {
    if (document.frm.vPhoneNo.value == document.frm.phoneNo.value)
    {
        rdShowMessageDialog("转存号码不能于服务号码相同，请重新操作！");
        document.frm.vPhoneNo.value = "";
        document.frm.vPhoneNo.focus();
        return false;
    }
    /*   if(document.frm.vPhoneNo.value =="")
     {
        rdShowMessageDialog("转存号码不能为空，请重新操作！");
        document.frm.vPhoneNo.focus(); 
        return false;
     }*/
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
	
	//document.all.vConPaswd.focus();
}

//added by hanfa 20070117
//add by wanglma 20110613 判断账户专款是否到期
function showPreCancelInfo()
{
    rdShowMessageDialog("用户办理预销，积分将清零，请提示客户兑换积分。");
    var packet = new AJAXPacket("checkPhoneNoZK.jsp","请稍后...");
	packet.data.add("phoneNo" ,document.frm.phoneNo.value);
	core.ajax.sendPacket(packet,doMsg);//异步
	packet =null;
}
function doMsg(packet){
	var retCode = packet.data.findValueByName("retc"); 
	var retMsg = packet.data.findValueByName("retm");
	var flag1 = packet.data.findValueByName("flag");
	if(retCode=="000000" && flag1 == "Y"){
		rdShowMessageDialog("您参与的统一预存赠礼活动（手机活动）当前未结束，若您进行销户，所涉及营销活动的剩余费用将不再进行返还。");
	}
	if(retCode != "000000"){
		rdShowMessageDialog("errorCode :"+retCode+"  errorMsg :"+retMsg);
	}
}

//added by hanfa 20070117
function showCancelInfo()
{
    rdShowMessageDialog("用户办理销号，积分将清零，请提示客户兑换积分。");
}
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

function clickRadio(){
	var opCode=$("input[@name=radiobutton][@checked]").val();
	if("1216"==opCode){
		$("#tr_sRanDomSend").show();
		$("#tr_sRanDomCheck").show();
	}else{
		$("#tr_sRanDomSend").hide();
		$("#tr_sRanDomCheck").hide();
	}
	
	submitt();
}


function printCommit()
{
    showPrtDlg("Detail", "确实要进行电子免填单打印吗？", "Yes");
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
    /* ningtn */
    var iccidInfoStr = $("#firstId").val() + "|" + $("#secondId").val();	
		var accInfoStr = $("#accInfoHid1").val() + "|" +$("#accInfoHid2").val()+ "|" +$("#accInfoHid3").val()+ "|" +$("#accInfoHid4").val();
    /* ningtn */
    var iRetrun = 0;
    var prop = "dialogHeight:" + h + "px; dialogWidth:" + w + "px; dialogLeft:" + l + "px; dialogTop:" + t + "px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no"
		var path = "<%=request.getContextPath()%>/npage/innet/hljBillPrint_jc_hw.jsp?DlgMsg=" + DlgMessage+ "&iccidInfo=" + iccidInfoStr + "&accInfoStr="+accInfoStr;
    var path = path  + "&mode_code="+mode_code+"&fav_code="+fav_code+"&area_code="+area_code+"&opCode="+opCode+"&sysAccept="+sysAccept+"&phoneNo=<%=activePhone%>&submitCfm=" + submitCfn+"&pType="+pType+"&billType="+billType+ "&printInfo=" + printStr;
    var ret = window.showModalDialog(path, printStr, prop);
    ret = "confirm";
    if ((ret == "confirm") && (submitCfn == "Yes"))
    {
        iRetrun = showEvalConfirmDialog('确认要进行此项服务吗？');
        if (iRetrun == 1)
        {
            if (document.frm.cardType.value.indexOf("中高端用户", 0) >= 0 && document.frm.opCode.value == "1218") {
                if (rdShowConfirmDialog('该用户是中高端用户，确认要销号吗？') == 1) {
                    printFlag = 1;
                }
            } else {
                printFlag = 1;
            }
        } else if (iRetrun == 2)
        {//王良 2008年1月2日增加
            if (document.frm.cardType.value.indexOf("中高端用户", 0) >= 0 && document.frm.opCode.value == "1218") {
                if (rdShowConfirmDialog('该用户是中高端用户，确认要销号吗？') == 1) {
                    printFlag = 2;
                }
            } else {
                printFlag = 2;
            }
        }
    }
    
}

function printInfo(printType)
{
	var retInfo = "";
    if (printType == "Detail")
    {       
	     var cust_info="";
		 var opr_info="";
		 var note_info1="";
		 var note_info2="";
		 var note_info3="";
		 var note_info4="";        
        cust_info += "客户姓名：" + document.all.custName.value + "|";
        cust_info += "手机号码：" + document.all.phoneNo.value + "|";
        cust_info += "客户地址：" + document.all.custAddress.value + "|";
        cust_info += "证件号码：" + document.all.idCardNo.value + "|"; 
        for (var i = 0; i < document.frm.radiobutton.length; i ++) {
            if (document.all.radiobutton[i].checked)
            {
                var radio1 = document.all.radiobutton[i].value
                if (radio1 == "1218") {
                    opr_info += "用户品牌：" + document.frm.smName.value + "*" + "办理业务：销号" + "|";
                    opr_info += "操作流水：" + document.frm.loginAccept.value + "|";
                } else if (radio1 == "1216") {
                    opr_info += "用户品牌：" + document.frm.smName.value + "*" + "办理业务：预销" + "|";
                    opr_info += "操作流水：" + document.frm.loginAccept.value + "|";
                    opr_info += "用户资费：" + document.frm.productName.value + "|";
                    
                   var wuxianhy = document.frm.wxyyhy.value;

                   if(wuxianhy=="1") {
                   opr_info += "您本次办理的预销业务已同步取消无线音乐俱乐部会员业务" + "|";
                   }
                   if(wuxianhy=="0") {
                   
                   }
                   
               var isxiaohu = $("#isxiaohu").val();    			
    		       if(isxiaohu=="Y") {
    		       			opr_info += "是否授权销户：是" + "|";
    		       			opr_info += "转费手机号码：" + document.frm.new_srv_no.value +"|";
    		       			opr_info += "预留联系电话：" + document.frm.contactPhone.value +"|";
    		       }else {
    		       			opr_info += "是否授权销户：否" + "|";
    		       }
                    
                  /*opr_info += "说明：办理预销后，请您于下月5日后到营业厅办理正式销号手续。预销3个月，" + "|";
                    opr_info += "客户未办理正式销号手续，将按客户自动销号处理。预销恢复时，恢复费用的收取，" + "|";
                    opr_info += "同时补收预销期间的费用。" + "|";  */
                } else if (radio1 == "1217") {
                    opr_info += "用户品牌：" + document.frm.smName.value + "*" + "办理业务：预销恢复" + "|";
                }else{
                	 opr_info +="|";
                }  
            }
        }
        
	
	    if (document.all.radioValue.value == '1216')
    {
    
       var isxiaohu = $("#isxiaohu").val();    			
    		if(isxiaohu=="Y") {
    		note_info1+="备注：授权销户操作成功后，系统将在次月15日之后完成正式销户操作。如您有可转预存款，将同时转移至预留的转费电话号码中；如有欠费，将向预留的联系电话中发送提醒短信。"+"|";
    		}else {
    		note_info1+="备注："+"|";
    		}
    }else {
    	note_info1+="备注："+"|";
    
    }
	
	//retInfo = cust_info+"#"+opr_info+"#"+note_info1+"#"+note_info2+"#"+note_info3+"#"+note_info4+"#";
	retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
	retInfo=retInfo.replace(new RegExp("#","gm"),"%23");
    }
    if (printType == "Bill")
    {    //打印发票
    }

    return retInfo;
}
    function printBill() {
    	var  billArgsObj = new Object();
    	$(billArgsObj).attr("10001", document.frm.workNo.value);       //工号
 		$(billArgsObj).attr("10002","<%=new java.text.SimpleDateFormat("yyyy",Locale.getDefault()).format(new java.util.Date())%>");
 		$(billArgsObj).attr("10003","<%=new java.text.SimpleDateFormat("MM",Locale.getDefault()).format(new java.util.Date())%>");
 		$(billArgsObj).attr("10004","<%=new java.text.SimpleDateFormat("dd",Locale.getDefault()).format(new java.util.Date())%>");
 		$(billArgsObj).attr("10005",document.frm.custName.value); //客户名称
 		$(billArgsObj).attr("10006","<%=opName%>"); //业务类别
 		$(billArgsObj).attr("10008", document.frm.phoneNo.value); //用户号码
 		$(billArgsObj).attr("10015", document.frm.handFee.value); //本次发票金额(小写)￥
 		$(billArgsObj).attr("10016", document.frm.handFee.value); //大写金额合计
 		var sumtypes1="*";
 		var sumtypes2="";
 		var sumtypes3="";
 		$(billArgsObj).attr("10017",sumtypes1); //本次缴费现金
 		$(billArgsObj).attr("10018",sumtypes2); //支票
 		$(billArgsObj).attr("10019",sumtypes3); //刷卡
 		$(billArgsObj).attr("10021",document.frm.handFee.value ); //手续费
 		$(billArgsObj).attr("10030",document.frm.backLoginAccept.value); //流水号--业务流水
 		$(billArgsObj).attr("10036","<%=opCode%>"); //操作代码
 		var h=210;
		var w=400;
		var t=screen.availHeight/2-h/2;
		var l=screen.availWidth/2-w/2;
		var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no" 
		//var path = "/npage/public/pubBillPrintCfm_YGZ.jsp?dlgMsg=确实要进行发票打印吗？" ;
		
		
			//发票项目修改为新路径
			var path = "/npage/public/billPrtNew/Bill_ELE_Prt.jsp?dlgMsg=确实要进行发票打印吗？" ;
	
	
	
		var loginAccept = document.frm.backLoginAccept.value;
		var path = path + "&loginAccept="+loginAccept+"&opCode=<%=opCode%>&submitCfm=submitCfm";
		var ret = window.showModalDialog(path,billArgsObj,prop);
		 location.href = "f1216_main.jsp?activePhone=<%=activePhone%>&opCode=<%=opCode%>&opName=<%=opName%>";
    }
    function printTwoBill() {
      	var totalFee = -(document.frm.backPrepay.value- document.frm.handFee.value).toFixed(2)
        var  billArgsObj = new Object();
    	$(billArgsObj).attr("10001", document.frm.workNo.value);       //工号
 		$(billArgsObj).attr("10002","<%=new java.text.SimpleDateFormat("yyyy",Locale.getDefault()).format(new java.util.Date())%>");
 		$(billArgsObj).attr("10003","<%=new java.text.SimpleDateFormat("MM",Locale.getDefault()).format(new java.util.Date())%>");
 		$(billArgsObj).attr("10004","<%=new java.text.SimpleDateFormat("dd",Locale.getDefault()).format(new java.util.Date())%>");
 		$(billArgsObj).attr("10005",document.frm.custName.value); //客户名称
 		$(billArgsObj).attr("10006","<%=opName%>"); //业务类别
 		$(billArgsObj).attr("10008", document.frm.phoneNo.value); //用户号码
 		$(billArgsObj).attr("10015", totalFee); //本次发票金额(小写)￥
 		$(billArgsObj).attr("10016", totalFee); //大写金额合计
 		var sumtypes1="*";
 		var sumtypes2="";
 		var sumtypes3="";
 		$(billArgsObj).attr("10017",sumtypes1); //本次缴费现金
 		$(billArgsObj).attr("10018",sumtypes2); //支票
 		$(billArgsObj).attr("10019",sumtypes3); //刷卡
 		$(billArgsObj).attr("10021",document.frm.handFee.value ); //手续费
 		$(billArgsObj).attr("10030",document.frm.backLoginAccept.value); //流水号--业务流水
 		$(billArgsObj).attr("10036","<%=opCode%>"); //操作代码
 		$(billArgsObj).attr("10074","<%=id_no%>"); 
 		$(billArgsObj).attr("10075","<%=contract_no%>"); 
 		$(billArgsObj).attr("10007","<%=smcode%>");  		
 		var h=210;
		var w=400;
		var t=screen.availHeight/2-h/2;
		var l=screen.availWidth/2-w/2;
		var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no" 
		//var path = "/npage/public/pubBillPrintCfm_YGZ.jsp?dlgMsg=确实要进行发票打印吗？" ;
		

		//发票项目修改为新路径
		var path = "/npage/public/billPrtNew/Bill_ELE_Prt.jsp?dlgMsg=确实要进行发票打印吗？" ;
	
			
		var loginAccept = document.frm.backLoginAccept.value;
		var path = path + "&loginAccept="+loginAccept+"&opCode=<%=opCode%>&submitCfm=submitCfm";
		var ret = window.showModalDialog(path,billArgsObj,prop);
		 location.href = "f1216_main.jsp?activePhone=<%=activePhone%>&opCode=<%=opCode%>&opName=<%=opName%>";
    }
    function printTwoBillZero() {
      	var totalFee = -(document.frm.backPrepay.value- document.frm.handFee.value).toFixed(2)
        var  billArgsObj = new Object();
    	$(billArgsObj).attr("10001", document.frm.workNo.value);       //工号
 		$(billArgsObj).attr("10002","<%=new java.text.SimpleDateFormat("yyyy",Locale.getDefault()).format(new java.util.Date())%>");
 		$(billArgsObj).attr("10003","<%=new java.text.SimpleDateFormat("MM",Locale.getDefault()).format(new java.util.Date())%>");
 		$(billArgsObj).attr("10004","<%=new java.text.SimpleDateFormat("dd",Locale.getDefault()).format(new java.util.Date())%>");
 		$(billArgsObj).attr("10005",document.frm.custName.value); //客户名称
 		$(billArgsObj).attr("10006","<%=opName%>"); //业务类别
 		$(billArgsObj).attr("10008", document.frm.phoneNo.value); //用户号码
 		$(billArgsObj).attr("10015", totalFee); //本次发票金额(小写)￥
 		$(billArgsObj).attr("10016", totalFee); //大写金额合计
 		var sumtypes1="*";
 		var sumtypes2="";
 		var sumtypes3="";
 		$(billArgsObj).attr("10017",sumtypes1); //本次缴费现金
 		$(billArgsObj).attr("10018",sumtypes2); //支票
 		$(billArgsObj).attr("10019",sumtypes3); //刷卡
 		$(billArgsObj).attr("10021",document.frm.handFee.value ); //手续费
 		$(billArgsObj).attr("10030",document.frm.backLoginAccept.value); //流水号--业务流水
 		$(billArgsObj).attr("10036","<%=opCode%>"); //操作代码
 		$(billArgsObj).attr("10074","<%=id_no%>"); 
 		$(billArgsObj).attr("10075","<%=contract_no%>"); 
 		$(billArgsObj).attr("10007","<%=smcode%>"); 
 		var h=210;
		var w=400;
		var t=screen.availHeight/2-h/2;
		var l=screen.availWidth/2-w/2;
		var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no" 
		//var path = "/npage/public/pubBillPrintCfm_YGZ.jsp?dlgMsg=确实要进行发票打印吗？" ;
		

		//发票项目修改为新路径
		var path = "/npage/public/billPrtNew/Bill_ELE_Prt.jsp?dlgMsg=确实要进行发票打印吗？" ;
			
		
		var loginAccept = document.frm.backLoginAccept.value;
		var path = path + "&loginAccept="+loginAccept+"&opCode=<%=opCode%>&submitCfm=submitCfm";
		var ret = window.showModalDialog(path,billArgsObj,prop);
		 location.href = "f1216_main.jsp?activePhone=<%=activePhone%>&opCode=<%=opCode%>&opName=<%=opName%>";
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
        location.href = "chkThreePrint.jsp?accept=" + document.frm.backLoginAccept.value
        	 + "&opCode=" + document.all.radioValue.value
        	 + "&backDate=" + document.frm.backDate.value + "&retInfo=" + infoStr + "&dirtPage=f1216_main.jsp&activePhone=<%=activePhone%>&opCode=<%=opCode%>&opName=<%=opName%>";
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
        location.href = "chkThreePrintZero.jsp?accept=" + document.frm.backLoginAccept.value
        	 + "&opCode=" + document.all.radioValue.value
        	 + "&backDate=" + document.frm.backDate.value + "&retInfo=" + infoStr + "&dirtPage=f1216_main.jsp&activePhone=<%=activePhone%>&opCode=<%=opCode%>&opName=<%=opName%>";
    }
    
    function opxiaohu() {
    		var isxiaohu = $("#isxiaohu").val();
    		$("#new_srv_no").val("");
    		$("#contactPhone").val("");
    		hiddenTip(document.all.new_srv_no);
    		hiddenTip(document.all.contactPhone);
    			
    		if(isxiaohu=="Y") {
    		$("#backDivsss").show();    		
    		}else {
    		$("#backDivsss").hide(); 
    		}
    }
    
function go_checkTestCard(){
	var getdataPacket = new AJAXPacket("checkTestCard.jsp","请稍后...");
	getdataPacket.data.add("phoneNo","<%=activePhone%>");
	core.ajax.sendPacket(getdataPacket,do_checkTestCard);
	getdataPacket = null;
	return;
}
function do_checkTestCard(packet){
	var retCode = packet.data.findValueByName("return_code");
	var retMsg = packet.data.findValueByName("return_msg");
	$("#oaTd1").hide();
	$("#oaTd2").hide();
	$("#oaTd3").show();
	$("#oaTd4").show();
	if(retCode == "000000"){
		var s_result = packet.data.findValueByName("s_result");
		if(s_result=="0"){
			$("#oaTd1").show();
			$("#oaTd2").show();
			$("#oaTd3").hide();
			$("#oaTd4").hide();
		}
	}else{
		
	}
	return false;
}

function go_sRanDomSend(){
		if($("#contactPhone").val()==""){
			rdShowMessageDialog("请输入联系人号码");
			return;
		}
		
		if($("#contactPhone").val()=="<%=activePhone%>"){
			$("#contactPhone").val("");
			rdShowMessageDialog("不能使用预消号码");
			return;
		}
		
    var packet = new AJAXPacket("go_sRanDomSend.jsp","请稍后...");
        packet.data.add("opCode","<%=opCode%>");//
        packet.data.add("phoneNo","<%=activePhone%>");//
        packet.data.add("ipt_sRanDomSend",$("#contactPhone").val());//
    core.ajax.sendPacket(packet,do_sRanDomSend);
    packet =null;	
	
}    
function do_sRanDomSend(packet){
    var error_code = packet.data.findValueByName("code");//返回代码
    var error_msg =  packet.data.findValueByName("msg");//返回信息

    if(error_code!="000000"){//调用服务失败
      rdShowMessageDialog(error_code+":"+error_msg);
	    return;
    }else{//操作成功
	    rdShowMessageDialog("发送成功",2);
	    //短信验证标志位 N = 未发送短信 S=已发送  Y=验证成功
	    $("#contactPhone").attr("v_send_flag","S");
	    
	    $("#contactPhone").attr("readOnly","readOnly");
	    $("#contactPhone").addClass("InputGrey");
	    
	    $("#btn_go_sRanDomSend").attr("disabled","disabled");
    }
}


function go_sRanDomCheck(){
		if($("#ipt_sRanDomCheck").val()==""){
			rdShowMessageDialog("请输入短信码");
			return;
		}
		
    var packet = new AJAXPacket("go_sRanDomCheck.jsp","请稍后...");
        packet.data.add("opCode","<%=opCode%>");//
        packet.data.add("phoneNo","<%=activePhone%>");//
        packet.data.add("ipt_sRanDomSend",$("#contactPhone").val());//
        packet.data.add("ipt_sRanDomCheck",$("#ipt_sRanDomCheck").val());//
        
    core.ajax.sendPacket(packet,do_sRanDomCheck);
    packet =null;	
	
}    
function do_sRanDomCheck(packet){
    var error_code = packet.data.findValueByName("code");//返回代码
    var error_msg =  packet.data.findValueByName("msg");//返回信息

    if(error_code!="000000"){//调用服务失败
      rdShowMessageDialog(error_code+":"+error_msg);
	    return;
    }else{//操作成功
	    rdShowMessageDialog("校验成功",2);
	    //短信验证标志位 N = 未发送短信 S=已发送  Y=验证成功
	    $("#contactPhone").attr("v_send_flag","Y");
	    
	    $("#ipt_sRanDomCheck").attr("readOnly","readOnly");
	    $("#ipt_sRanDomCheck").addClass("InputGrey");
	    
	    $("#btn_go_sRanDomCheck").attr("disabled","disabled");
	    
    }
}




</script>
</HEAD>
<body>
<FORM action="" method=post name="frm">
<%@ include file="/npage/include/header.jsp" %>
<div class="title">
    <div id="title_zi">请选择操作类型</div>
</div>
<!-- added by hanfa 20070117 -->
<input type="hidden" name="radioValue" value="">
<table cellspacing="0">
<tbody>
<tr>
<%if (fee.length != 0) {%>
<td class="blue"  width="11%">操作类型</td>
<td <%=display%>>
    <input type="radio" name="radiobutton" value="1216" index="3"
    <%
    
    
    
       int tmd4 = 0 ;
       int tmd44 = 0;
       for(int i = 0 ; i < fee.length ; i ++){
        if(tmd4 == 0){
        if(fee[i][0].equals("1216")){
        tmd4 = 1;
    
    
    
    %>
           onclick="go_checkTestCard();showPreCancelInfo();beforePrompt();
            <%for(int j = 0 ;  j< favInfo.length ; j ++){
	if(favInfo[j][0].trim().equals(fee[i][3])){
	tmd44 =1;
	%>
            document.frm.handFee.disabled=false;document.frm.sysRemark.value='预销';
            <%}}%>
            <%if(tmd44 == 0 ){%>document.frm.handFee.disabled=true;<%}%>
            <%if(tmd4==0){%>document.frm.handFee.disabled=true;<%}%>
            
            noBackDiv.style.display='';backDiv.style.display='';document.frm.opCode.value=<%=fee[i][0]%>;document.frm.handFee.value=<%=fee[i][2]%>;document.frm.handFeeT.value=<%=fee[i][2]%>;clickRadio();"

    <%
    
    
    }}}if(tmd4==0){
    
    
    
    
    %>
           onclick="go_checkTestCard();showPreCancelInfo();noBackDiv.style.display='';backDiv.style.display='';document.frm.handFee.disabled=true;document.frm.opCode.value='1216';document.frm.handFee.value='0';document.frm.handFeeT.value='0';document.frm.sysRemark.value='预销';beforePrompt();clickRadio();"

    <%
    
    
    
    
    }
    
    
    %>>预销
</td>


<td <%=display%>>
    <input type="radio" name="radiobutton" value="1217"
    <%
    
    
    
    int tmd5 = 0;
    int tmd55 = 0;
    for(int i = 0 ; i < fee.length ; i ++){
        if(tmd5 == 0){
        if(fee[i][0].equals("1217")){
        tmd5 = 1;
    
    
    
    %>

           onclick="beforePrompt();
            <%for(int j = 0 ;  j< favInfo.length ; j ++){
	if(favInfo[j][0].trim().equals(fee[i][3])){
	tmd55 = 1;
	%>
            document.frm.handFee.disabled=false;document.frm.sysRemark.value='预销恢复';
            <%}}%>
            
            <%if(tmd55 == 0){%>document.frm.handFee.disabled=true;<%}%>
            noBackDiv.style.display='none';backDiv.style.display='none';document.frm.opCode.value=<%=fee[i][0]%>;document.frm.handFee.value=<%=fee[i][2]%>;document.frm.handFeeT.value=<%=fee[i][2]%>;clickRadio();"

    <%
    
    
    }}}if(tmd5==0){
    
    
    
    
    %>
           onclick="beforePrompt();noBackDiv.style.display='none';backDiv.style.display='none';document.frm.opCode.value='1217';document.frm.handFee.value='0';document.frm.handFeeT.value='0';document.frm.sysRemark.value='预销恢复';clickRadio();"
    <%
    
    
    
    
    }
    
    
    %>>预销恢复
</td>


<td <%=display%>>
    <input type="radio" name="radiobutton" value="1218" index="4"
    <%
    
    
    
       int tmd6 = 0;
       int tmd66 = 0;
       for(int i = 0 ; i < fee.length ; i ++){
        if(tmd6==0){
        if(fee[i][0].equals("1218")){
        tmd6 =1;
    
    
    
    
    %>
           onclick="showCancelInfo();beforePrompt();
            <%for(int j = 0 ;  j< favInfo.length ; j ++){
	if(favInfo[j][0].trim().equals(fee[i][3])){
	tmd66 = 1;
	%>
	
            document.frm.handFee.disabled=false;document.frm.sysRemark.value='销号变更';
            <%}}%>
            
            <%if(tmd66 == 0){%>document.frm.handFee.disabled=true;<%}%>
            noBackDiv.style.display='';backDiv.style.display='none';document.frm.opCode.value=<%=fee[i][0]%>;document.frm.handFee.value=<%=fee[i][2]%>;document.frm.handFeeT.value=<%=fee[i][2]%>;clickRadio();"

    <%
    
    
    }}}if(tmd6==0){
    
    
    
    %>

           onclick="showCancelInfo();noBackDiv.style.display='';backDiv.style.display='none';document.frm.opCode.value='1218';document.frm.handFee.value='0';document.frm.handFeeT.value='0';document.frm.sysRemark.value='销号变更';beforePrompt();clickRadio();"

    <%
    
    
    
    
    
    }
    
    
    %>>销号
</td>

<%} else {%>
<td class="blue" nowrap >操作类型</td>
<td <%=display%>>
    <input type="radio" name="radiobutton" index="3" value="1217"
           onclick="noBackDiv.style.display='none';backDiv.style.display='none';document.frm.opCode.value='1216';document.frm.handFee.value='0';document.frm.handFeeT.value='0';document.frm.sysRemark.value='预销变更';showPreCancelInfo();clickRadio();">预销
</td>
<!--
<td>
  <input type="radio" name="radiobutton" value="1217" onclick="lxDiv.style.display='none';noBackDiv.style.display='none';backDiv.style.display='none';document.frm.opCode.value='1217';document.frm.handFee.value='0';document.frm.handFeeT.value='0';document.frm.sysRemark.value='预销恢复变更';">预销恢复
</td>
-->
<td <%=display%>>
    <input type="radio" name="radiobutton" index="4" value="1218"
           onclick="noBackDiv.style.display='';backDiv.style.display='';document.frm.opCode.value='1218';document.frm.handFee.value='0';document.frm.handFeeT.value='0';document.frm.sysRemark.value='销号变更';showCancelInfo();clickRadio();">销号
</td>
<%}%>


</tr>
</TBODY>
</TABLE>
			</div>
			<div id="Operation_Table"> 
			<div class="title">
				<div id="title_zi">用户信息</div>
			</div>
<table cellspacing="0">
<tbody>
<tr>
    <td class="blue" width="12%" nowrap>服务号码</td>
    <td colspan="5">
        <%if (workNo.substring(0, 1).trim().equals("kk")) {%>
        <%String userPhoneNo = (String) session.getAttribute("userPhoneNo");%>
        <input
                id=Text2 type=text size=17 name=phoneNo v_type="mobphone" v_name="服务号码" disabled maxlength=11 index="5"
                onKeyUp="if(event.keyCode==13)submitt()" value="<%=userPhoneNo%>">
        <%} else {%>
        <input class="InputGrey" id=Text2 type=text size=17 name=phoneNo value="<%=activePhone%>" readonly>
        <%}%>
				<!-- ningtn CRM客服系统需求
        <input class="b_text" id=Text2 type=button size=17 name=qry value="查询" onclick="submitt()">
        -->
    </td>


</tr>
<tr>
    <td class="blue" width="12%" nowrap>用户ID</td>
    <td width="21%">
        <input id=Text2 type=text size=17 name=userId class="InputGrey" readonly>
    </td>
    <td class="blue" width="12%" nowrap>当前状态</td>
    <td width="21%">
        <input type=text size=17 name=runName class="InputGrey" readonly>
    </td>
    <td class="blue" width="12%" nowrap>级别</td>
    <td>
        <input type=text size=17 name=gradeName class="InputGrey" readonly>
    </td>
</tr>
<tr>
    <td class="blue">当前预存</td>
    <td>
        <input
                id=Text2 type=text size=17 name=totalPrepay class="InputGrey" readonly>
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
        <input type=text size=17 name=custName class="InputGrey" readonly>
    </td>
    <td class="blue"> 产品名称</td>
    <td align=left colspan="3">
        <input type=text size=56 name=productName class="InputGrey" readonly>
    </td>
</tr>
<tr id=noBackDiv style="display:none">
    <td class="blue">不可退预存</td>
    <td>
        <input id=Text2 type=text size=17 name=noBack class="InputGrey" readonly>
    </td>
    <td class="blue">可退预存</td>
    <td>
        <input id=Text2 type=text size=17 name=backPrepay class="InputGrey" readonly>
    </td>
    <td class="blue">利息</td>
    <td width="19%" colspan=2>
        <input id=Text2 type=text size=17 name=lxPrepay class="InputGrey" readonly>
    </td>
</tr>
<tr id=backDiv style="display:none">
	 <td class="blue">是否选择授权销户</td>
	 <td colspan=6>
			<select id="isxiaohu" name="isxiaohu" onChange="opxiaohu()">
			<option value="N">否</option>
			<option value="Y">是</option>
			</select>
		</td>					
</tr>

<tr id=backDivsss style="display:none">
									
    <td class="blue">转费手机号码</td>
    <td>
    <input type="text" name="new_srv_no" v_must=1 id="new_srv_no" size="14" v_minlength=0 v_maxlength=11 v_type=mobphone  v_name="转费手机号码" maxlength="11"  onBlur="if(this.value!=''){if(checkElement(document.all.new_srv_no)==false){return false;}}" >
		<font class="orange">*</font>
		</td>
		
    <td class="blue">客户联系电话</td>
    <td width="19%" >
    	<input type="text" name="contactPhone" v_send_flag="" v_must=1 id="contactPhone" size="14" v_minlength=0 v_maxlength=11 v_type=mobphone  v_name="客户联系电话" maxlength="11"  onBlur="if(this.value!=''){if(checkElement(document.all.contactPhone)==false){return false;}}" >
      
      <font class="orange">*</font>
      <input type="button" class="b_text" value="下发短信"  id="btn_go_sRanDomSend"  onclick="go_sRanDomSend()" />
    </td>
    
    <td class="blue">随机验证码</td>
    <td colspan="5"><input id="ipt_sRanDomCheck" name="ipt_sRanDomCheck"  maxlength="6"  v_type="0_9" value=""  onblur = "checkElement(this)" />
    	<input type="button" class="b_text" value="验证短信"  id="btn_go_sRanDomCheck"  onclick="go_sRanDomCheck()" />
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
        <input id=Text2 type=text size=17 name=innerTime class="InputGrey" readonly>
    </td>
</tr>
<tr style=display:none>
    <td class="blue"> 担保人名称</td>
    <td>
        <input id=Text2 type=text size=17 name=asCustName maxlength=20
               onkeyup="value=value.replace(/[@#$%!^&*()<>?|]/g,'');">
    </td>
    <td class="blue">担保人联系电话</td>
    <td>
        <input id=Text2 type=text size=17 name=asCustPhone maxlength=20>
    </td>
    <td class="blue">担保人联系地址</td>
    <td colspan=2>
        <input id=Text2 type=text size=17 name=asContractAddress maxlength=20
               onkeyup="value=value.replace(/[@#$%!^&*()<>?|]/g,'');">
    </td>
</tr>
<tr style=display:none>
    <td class="blue"> 担保人证件类型</td>
    <td>
        <select size=1 name=asIdType>
            <%for (int i = 0; i < sIdTypeStr.length; i++) {%>
            <option value="<%=sIdTypeStr[i][0]%>"><%=sIdTypeStr[i][1]%>
            </option>
            <%}%>
        </select>
    </td>
    <td class="blue">担保人证件号码</td>
    <td>
        <input id=Text2 type=text size=17 name=asIdIccid maxlength=20
               onkeyup="value=value.replace(/[@#$%!^&*()<>?|]/g,'');">
    </td>
    <td class="blue">担保人证件地址</td>
    <td width="19%" colspan=2>
        <input id=Text2 type=text size=17 name=asIdAddress maxlength=20
               onkeyup="value=value.replace(/[@#$%!^&*()<>?|]/g,'');">
    </td>
</tr>
<tr style="display:none">
    <td class="blue">担保备注</td>
    <td colspan="5">
        <input id=Text21 type=text size=17 name=asNotes1 maxlength=20
               onkeyup="value=value.replace(/[@#$%!^&*()<>?|]/g,'');">
    </td>
</tr>

    <tr>
        <td class="blue">手续费</td>
        <td>
            <input id=Text2 type=text size=17 name=handFee disabled v_type=float v_name="手续费" index="7">
        </td>
        <td class="blue">实收</td>
        <td>
            <input
                    id=Text2 type=text size=17 name=factPay index="8" disabled 
                    onKeyUp="if(event.keyCode==13){getRemain()}">&nbsp;<input
                id=Text2 type=button size=17
                name=getUseInfo class="b_text" value="-->"
                onclick="getRemain()">
        </td>
        <td class="blue">找零</td>
        <td>
            <input id=Text2 type=text size=17 name=remain disabled>
        </td>
    </tr>
     <tr>
        <td class="blue">用户积分</td>
        <td ><input  type="text" size="17" id="userIntegral" name="userIntegral" value="" class="InputGrey" readonly /></td>
        <td class="blue">是否是无线音乐会员</td>
        <td><input  type="text" size="17" id="wxyuhya" name="wxyuhya"  class="InputGrey" readonly /></td>
    	<td id="oaTd1" class="blue" style="display: none">OA编号</td>
       	<td id="oaTd2" style="display: none">
        	<input class="button"type="text" id="oaNum" name="oaNum" size="17" maxlength="30">
        	<font color="orange">*</font>
       	</td>
       	<td id="oaTd3"></td>
       	<td id="oaTd4"></td>
    </tr>
    
 
    
    <tr>
        <td class="blue">系统备注</td>
        <td colspan="5"><input id=Text3 type=text size=80 name=remark value=""></td>
    </tr>
    <tr>
        <td class="blue">用户备注</td>
        <td colspan="5"><input id=Text2 type=text size=80 name=asNotes maxlength=60
                   onkeyup="value=value.replace(/[@#$%!^&*()<>?|]/g,'');" index="9">
        </td>
    </tr>   
</table>
<div id="prodLibDiv" style="display:none;">
	<div id="Operation_Table"> 
		<div class="title">
			<div id="title_zi">用户资源信息</div>
		</div>
	<div class="m-box-txt2" id="stockTab">
	</div>
	<table cellspacing="0">
		<tr>
			<td class="blue" width="20%">资源转赠</td>
			<td width="20%">
				<input type="checkbox" name="isGive" id="isGive"
				 data-bind="checked:giveAvailability,enable:resourceAvailability" />资源转赠
			</td>
			<td width="30%" data-bind="visible:giveAvailability">
				<input type="radio" value="1" name="giveType" checked="checked" 
				 data-bind="disable:checkFlag" onclick="changeType()" />
				转赠手机号码
				<input type="radio" value="0" name="giveType" 
				 data-bind="disable:checkFlag" onclick="changeType()" />
				转赠客户的证件号码
			</td>
			<td width="30%" data-bind="visible:giveAvailability">
				<input type="text" name="giveNumber" id="giveNumber" 
				 maxlength="18" v_must="1" v_type="mobphone" onblur = "checkElement(this)" />
				<input type="button" name="" value="校验" class="b_text" 
				 data-bind="disable:checkFlag" onclick="checkNumber()" />
			</td>
		</tr>
	</table>
	</div>
</div>
<jsp:include page="/npage/public/hwReadCustCard.jsp">
	<jsp:param name="hwAccept" value="12"  />
	<jsp:param name="showBody" value="01"  />
</jsp:include>
<TABLE cellSpacing="0">
    <TBODY>
        <TR>
            <TD id="footer">
                <input class="b_foot" name=submit type=button value="确认" index="10"
                       onKeyUp="if(event.keyCode==13){formSubmitCfm()}" onclick="formSubmitCfm()" 
                       disabled>
                &nbsp;&nbsp;
                <input class="b_foot" name=back type=button value="清除" onclick="window.location='f1216_main.jsp?activePhone=<%=activePhone%>&opCode=<%=opCode%>&opName=<%=opName%>'">
                &nbsp;&nbsp;
                <input class="b_foot" name=back type=button value="关闭" onclick="parent.removeTab('<%=opCode%>')">
                &nbsp;&nbsp;
            </TD>
        </TR>
    </TBODY>
</TABLE>
<input type=hidden name=wxyyhy> <!--无线音乐会员-->
<input type=hidden name=family_code> <!--家庭代码-->
<input type=hidden name=family_order>	<!--家庭位置-->
<input type=hidden name=family_count> <!--家庭人数-->
<input type=hidden name=opCode>
<input type=hidden name=workNo value=<%=workNo%>>
<input type=hidden name=noPass value=<%=nopass%>>
<input type=hidden name=orgCode value=<%=orgCode%>>
<input type=hidden name=iChnSource value=<%=iChnSource%>>  <!--渠道标识-->
<input type=hidden name=iUserPwd value=<%=iUserPwd%>>  <!--号码密码 -->
<input type=hidden name=sysRemark value="综合变更">
<input type=hidden name=ipAdd value="<%=request.getRemoteAddr()%>">
<input type=hidden name=handFeeT>
<input type=hidden name=customPass>
<input type=hidden name=idCardNo>
<input type=hidden name=custAddress>
<input type=hidden name=backLoginAccept>
<input type=hidden name=backDate>
<input type=hidden name=favFlag value="<%=favFlag%>">
<input type="hidden" name="loginAccept" value="<%=loginAccept1%>">
<!--2015/9/7 9:10:41 gaopeng pubSmCode -->
  <input type="hidden" name="pubSmCode" id="pubSmCode" value="">
<input type=hidden name=smName>
<input type=hidden name=simBell
       value="   手机上网可选套餐优惠的GPRS流量仅指CMWAP节点产生的流量.  彩铃下载：1.购彩铃包年卡,送价值88元德赛电池。  2.登陆龙江风采（wap.hljmonternet.com）使用手机上网：体验图铃下载、新闻资讯、网络美文免费体验区下载铃音、时尚屏保,免收信息费！拨打1860开通GPRS 。">
<input type=hidden name=worldSimBell
       value="    您办理此业务后，即成为我公司全球通签约客户，在签约期限内使用我公司业务及产品，同时执行月底限消费政策。您交纳的预存款需在消费期限内消费完毕，同时您获赠的积分在积分使用期限后方可使用。       在协议有效期内若遇国家资费标准调整，按国家新的资费政策执行。       做为全球通客户，您将享受我公司为您提供的尊贵服务。">
<div id="relationArea" style="display:none"></div>
			<div id="wait" style="display:none">
			<img  src="/nresources/default/images/blue-loading.gif" />
		</div>
		<div id="beforePrompt"></div>       
<%@ include file="/npage/include/footer.jsp" %>
</FORM>
<OBJECT classid="clsid:2F593576-E694-46B5-BF4F-9F23C1020642" height=1 id=evalControl width=1>
</OBJECT> 
</BODY>
<script type="text/javascript" language="JavaScript">
	var viewModel = {
		resourceAvailability:ko.observable(false),
		giveAvailability:ko.observable(false),
		giveNumber:ko.observable(""),
		checkFlag:ko.observable(false)
	}
	ko.applyBindings(viewModel);
</script>
<%@ include file="/npage/public/hwObject.jsp" %> 
</HTML>



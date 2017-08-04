<%
/********************
 *version v2.0
 *开发商: si-tech
 *update by qidp @ 2008-12-25
 ********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType= "text/html;charset=GBK" %>
<%@ page import="java.util.ArrayList"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%
	System.out.println(" ====================== f1222.jsp");
	response.setHeader("Pragma","No-cache");
	response.setHeader("Cache-Control","no-cache");
	response.setDateHeader("Expires", 0);
    String opCode = request.getParameter("opCode");
    String opName = request.getParameter("opName");
    request.setCharacterEncoding("GBK");
    String activePhone1=request.getParameter("activePhone1");
    /* ningtn 2010-11-1 11:05:19*/
    String dateStr = new java.text.SimpleDateFormat("yyyyMMdd").format(new java.util.Date());
    //取当前省代码
    //SPubCallSvrImpl impl=new SPubCallSvrImpl();
    String sql1 = "select province_code from sProvinceCode where run_flag='Y'";
    //ArrayList sProvRunArr = impl.sPubSelect("1",sql1);
%>

    <wtc:pubselect name="TlsPubSelCrm" routerKey="phone" routerValue="<%=activePhone1%>"  outnum="1">

        <wtc:sql><%=sql1%></wtc:sql>
    </wtc:pubselect>
    <wtc:array id="sProvRunStr" scope="end"/>
<%
    String provCode=sProvRunStr[0][0];
    //取证件类型、证件名称
    sql1 = "select id_type,id_name from sidtype";
    //ArrayList sIdTypeArr = impl.sPubSelect("2",sql1);
%>

    <wtc:pubselect name="TlsPubSelCrm" routerKey="phone" routerValue="<%=activePhone1%>"  outnum="2">

        <wtc:sql><%=sql1%></wtc:sql>
    </wtc:pubselect>
    <wtc:array id="sIdTypeStr" scope="end"/>
<%
    //取session信息
    String workNo = (String)session.getAttribute("workNo");
    String workName = (String)session.getAttribute("workName");
    String nopass = (String)session.getAttribute("password");
    String[][] favInfo = (String[][])session.getAttribute("favInfo");
%>
<%
    //取办理手续费
    String org_codeT =(String)session.getAttribute("orgCode");
    String region_codeT = org_codeT.substring(0,2);
    //ArrayList arr = F1222Wrapper.getFuncFee(region_codeT);
    
    String sqll = "select function_code,to_char(hand_fee),favour_code from sNewFunctionFee where region_code=:regionCode and function_code='1222'";
    String [] paraIn = new String[2];
    
    paraIn[0] = sqll;    
    paraIn[1]="regionCode="+region_codeT;
%>
    <wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=region_codeT%>"  outnum="3" >
        <wtc:param value="<%=paraIn[0]%>"/>
        <wtc:param value="<%=paraIn[1]%>"/> 
    </wtc:service>
    <wtc:array id="fee" scope="end"/>
<%
    
    //String[][] fee = (String[][])arr.get(0);
    String tHandFee = "0";
    int feeFlag = 0;
    System.out.println("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@fee.length=="+fee.length);
     //判断是否有变更优惠手续费权限
    if(fee.length==0){
        tHandFee="0";
        feeFlag = 0;
    }
    else{
        tHandFee=fee[0][1];
        for(int i = 0 ; i < favInfo.length ; i ++){
        	if(favInfo[i][0].trim().equals(fee[0][2])){
        		feeFlag = 1;
        	}
        }
    }
		
    String[][] country 	   = new String[][]{};
    String[][] roamTypeArr = new String[][]{};
    String[][] machCodeArr = new String[][]{};
    String[][] rentTypeArr = new String[][]{};

    StringBuffer sq1 = new StringBuffer();
/*
    sq1.append("SELECT a.country_code,a.country_name,b.phone_usefee from");
    sq1.append("  scountrycode a,sownercountry b");
    sq1.append("  where a.country_code=b.country_code");
    sq1.append(" and b.region_code='");
    sq1.append(region_codeT);
    sq1.append("';");
*/
    sq1.append("SELECT country_code, country_name,phone_fee from scountrycode;");

    sq1.append("SELECT rent_type,rent_name");
    sq1.append(" FROM sRentTypeName");
    sq1.append(" order by rent_type;");

    sq1.append("SELECT machine_code,machine_name");
    sq1.append("  FROM sMachCode where region_code='");
    sq1.append(region_codeT);
    sq1.append("' order by machine_code;");

    sq1.append("select rent_code,rent_name,rent_fee");
    sq1.append("  from srentcode where region_code='");
    sq1.append(region_codeT);
    sq1.append("' order by rent_code");
	int[] colNums=new int[4];
	colNums[0] = 3;
	colNums[1] = 2;
	colNums[2] = 2;
	colNums[3] = 3;
	//comImpl co=new comImpl();
	//ArrayList passArr=co.multiSql(colNums,sq1.toString());
%>
    <wtc:pubselectah name="sPubMultiSel" routerKey="region" routerValue="<%=region_codeT%>"  outnum="10">
        <wtc:sql><%=sq1%></wtc:sql>
    </wtc:pubselectah>
    <wtc:array id="sPubMultiSelArr" scope="end"/>
    <wtc:array id="sPubMultiSelArr1" start="0" length="3" scope="end"/>
    <wtc:array id="sPubMultiSelArr2" start="3" length="2" scope="end"/>
    <wtc:array id="sPubMultiSelArr3" start="5" length="2" scope="end"/>
    <wtc:array id="sPubMultiSelArr4" start="7" length="3" scope="end"/>
<%
	if(sPubMultiSelArr != null)
	{
        country = sPubMultiSelArr1;
        roamTypeArr = sPubMultiSelArr2;
        System.out.println("------------------------------------------------77---");
        System.out.println("roamTypeArr[0][0]=   "+roamTypeArr[0][0]);
        System.out.println("roamTypeArr[0][1]=   "+roamTypeArr[0][1]);
        machCodeArr = sPubMultiSelArr3;
        rentTypeArr = sPubMultiSelArr4;
	}

    // 取业务操作流水
    String paraStr[]=new String[1];
%>
    <wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="region" routerValue="<%=region_codeT%>"  id="login_accept"/>
<%
    paraStr[0] = login_accept;
    System.out.println("流水:  "+paraStr[0]);
%>

<html xmlns="http://www.w3.org/1999/xhtml">
<HEAD>
<TITLE>异制租机申请</TITLE>
<META content="MSHTML 5.00.3315.2870" name=GENERATOR>
</HEAD>
<script language="javascript">
var printFlag = 9;
var flag = 0;
//core.loadUnit("debug");
//core.loadUnit("rpccore");
onload=function(){
	self.status="";
	//document.all.phoneNo.focus();
	//core.rpc.onreceive = doProcess;
	f1222Init();//查询用户信息
}

function doProcess(packet){
	var backString = packet.data.findValueByName("backString");
	var cfmFlag = packet.data.findValueByName("flag");

	

	if(cfmFlag==2){
		var rentPhoneLength = backString.length;
	   	var arr = new Array(rentPhoneLength);
	   	if(rentPhoneLength==0){
			/* ningtn
			document.all.rentPhoneDiv.innerHTML = "<select name=rent_phone ></SELECT>";
			*/
	   		rdShowMessageDialog("没有该国家的漫游号码资源，请重新选择漫游国家或者漫游方式");

		}
		else{
	     		/* ningtn
	     		for(var i = 0 ; i < rentPhoneLength; i ++){

	     			arr[i] = "<OPTION value="+"\""+backString[i][0]+"|"+backString[i][1]+"|"+backString[i][2]+"|"
	     			       + backString[i][3]+"|"+backString[i][4]+"|"+backString[i][5]+"|"
	     			       + backString[i][6]+"|"+backString[i][7]+ "\""+">" + backString[i][0] + "</OPTION>";
				}

	     	document.all.rentPhoneDiv.innerHTML = "<select name=rent_phone onchange=getPhoneInfo()><option value=''></option>" + arr.join() + "</SELECT>";
	     	*/
	   	}
	}

	if(cfmFlag==9){
		var errCode = packet.data.findValueByName("errCode");
		var errMsg = packet.data.findValueByName("errMsg");

		rdShowMessageDialog(errCode + " : " + errMsg,0);
        removeCurrentTab();

		flag=0;
		return;
	}

	if(cfmFlag==1){
		var errCode = packet.data.findValueByName("errCode");
		var errMsg = packet.data.findValueByName("errMsg");
		var errCodeInt = parseInt(errCode,10);

		if(errCodeInt==0){
			rdShowMessageDialog("操作成功！",2);
			document.frm.backLoginAccept.value=backString[0][0];
			removeCurrentTab();
		}
		else{
			rdShowMessageDialog(errCode + " : " + errMsg,0);
			window.location="f1222.jsp?activePhone1=<%=activePhone1%>&opCode=<%=opCode%>&opName=<%=opName%>";
		}
			
	}

	if(cfmFlag==0){
		var errCode = packet.data.findValueByName("errCode");
		var errMsg = packet.data.findValueByName("errMsg");
		var moreString = packet.data.findValueByName("moreString");
		var errCodeInt = parseInt(errCode,10);

		if(errCodeInt!=0){
			document.frm.cust_password.value=backString[0][4];
			document.frm.id_no.value=backString[0][0];
			document.frm.run_code.value=backString[0][6];
			document.frm.cust_grade.value=backString[0][8];
			document.frm.prepay_fee.value=backString[0][17];
			document.frm.owe_fee.value=backString[0][16];
			document.frm.cust_name.value=backString[0][3];
			document.frm.rent_cost.disabled =true;
			document.frm.idCardNo.value=backString[0][14];
			document.frm.custAddress.value=backString[0][11];
			document.frm.cardName.value=backString[0][15];
			
			rdShowMessageDialog(errCode + " : " + errMsg,0);
			removeCurrentTab();
		}
		if(errCodeInt==0){
				

			document.frm.cust_password.value=backString[0][4];
			document.frm.id_no.value=backString[0][0];
			document.frm.run_code.value=backString[0][6];
			document.frm.cust_grade.value=backString[0][8];
			document.frm.prepay_fee.value=backString[0][17];
			document.frm.owe_fee.value=backString[0][16];
			document.frm.cust_name.value=backString[0][3];
			document.frm.custAddress.value=backString[0][11];
			document.frm.idCardNo.value=backString[0][14];
			document.frm.cardName.value=backString[0][15];
			document.frm.cardType.value=backString[0][21];
			document.frm.smName.value=backString[0][2];

			document.frm.asCustName.value=moreString[0][24];
			document.frm.asCustPhone.value=moreString[0][25];
			document.frm.asIdIccid.value=moreString[0][27];
			document.frm.asIdAddress.value=moreString[0][28];
			document.frm.asContractAddress.value=moreString[0][29];
			document.frm.asNotes.value=moreString[0][30];


			var idI = 0 ;
			for(idI = 0 ; idI < document.frm.asIdType.length ; idI ++){
				if(document.frm.asIdType.options[idI].value==moreString[0][26]){
				document.frm.asIdType.options[idI].selected=true;
				break;
			}
		}

		flag=1;
		}
	}
}

//提取号码信息
function f1222Init(){
    if(document.frm.phoneNo.value.length==0){
    	rdShowMessageDialog("请输入手机号码！");
    	return;
    }
    
    if(!checkElement(document.frm.phoneNo)){

        return;
    }

	var myPacket = new AJAXPacket("getUserInfo.jsp","正在提交，请稍候......");

	myPacket.data.add("workNo",document.frm.workNo.value);
	myPacket.data.add("phoneNo",document.frm.phoneNo.value);
	myPacket.data.add("opCode",document.frm.opCode.value);
	myPacket.data.add("orgCode",document.frm.orgCode.value);

	core.ajax.sendPacket(myPacket);
	myPacket = null;
}

function getSum1(){
	document.frm.machine_rent.value=document.frm.machine_num.value*document.frm.perMachine_rent.value;
	getSum4();
}
function getSum2(){
	document.frm.battery_rent.value=document.frm.battery_num.value*document.frm.perBattery_rent.value;
	getSum4();
}
function getSum3(){
	document.frm.charger_rent.value=document.frm.charger_num.value*document.frm.perCharger_rent.value;
	getSum4();
}
function getSum4(){
	document.frm.all_rent.value=parseFloat(document.frm.machine_rent.value)+parseFloat(document.frm.charger_rent.value)+parseFloat(document.frm.battery_rent.value)+parseFloat(document.frm.addition_fee.value);
	getSum5();
}
function getSum5(){
	document.frm.all_cost.value=parseFloat(document.frm.setNo_cost.value)+parseFloat(document.frm.handFee.value)+parseFloat(document.frm.all_rent.value);
}
function getSum6(obj){
	if(!checkElement(obj)){
		return;
	}
	var feeObj = $("#addition_fee");
	if(feeObj.val() == "" || feeObj.val() == null){
		feeObj.val("0.00");
	}
	getSum4();
}
//计算找零金额
function getRemain(){
	if(flag!=1){
		rdShowMessageDialog("请先查询用户信息！");
		return;
	}

	if(parseFloat(document.frm.handFee.value) > parseFloat(document.frm.handFeeT.value)){
		rdShowMessageDialog("手续费不能大于"+document.frm.handFeeT.value);
		return;
	}

	if(parseFloat(document.frm.factPay.value) < parseFloat(document.frm.all_cost.value)){
		rdShowMessageDialog("实收费不能小于"+document.frm.all_cost.value);
		document.frm.factPay.value=0;
		return;
	}

	document.frm.remain.value=parseFloat(document.frm.factPay.value)-parseFloat(document.frm.all_cost.value);
}

//获得漫游号码机器类型、序列号及对应押金
function getPhoneInfo(){
		var i = 0 ;
		for(i = 0 ; i < document.frm.rent_phone.length ; i ++){
			if(document.frm.rent_phone.options[i].selected==true){
				var phoneTypeValue = document.frm.rent_phone.options[i].value;
				var divFlag1 = phoneTypeValue.indexOf("|",0);
				var divFlag2 = phoneTypeValue.indexOf("|",divFlag1+1);
				var divFlag3 = phoneTypeValue.indexOf("|",divFlag2+1);
				var divFlag4 = phoneTypeValue.indexOf("|",divFlag3+1);
				var divFlag5 = phoneTypeValue.indexOf("|",divFlag4+1);
				var divFlag6 = phoneTypeValue.indexOf("|",divFlag5+1);
				var divFlag7 = phoneTypeValue.indexOf("|",divFlag6+1);

				var rentPhone = phoneTypeValue.substring(0,divFlag1);
				var machCode = phoneTypeValue.substring(divFlag1+1,divFlag2);
				var machIccid = phoneTypeValue.substring(divFlag2+1,divFlag3);
				var machName = phoneTypeValue.substring(divFlag3+1,divFlag4);
				var machbodyFee = phoneTypeValue.substring(divFlag4+1,divFlag5);
				var batteryFee = phoneTypeValue.substring(divFlag5+1,divFlag6);
				var chargerFee = phoneTypeValue.substring(divFlag6+1,divFlag7);
				var fujianFee = phoneTypeValue.substring(divFlag7+1,phoneTypeValue.length);
/*
				alert("rentPhone=" + rentPhone);
				alert("machCode=" + machCode);
				alert("machIccid=" + machIccid);
				alert("machName=" + machName);
				alert("machbodyFee=" + machbodyFee);
				alert("batteryFee=" + batteryFee);
				alert("chargerFee=" + chargerFee);
				alert("fujianFee=" + fujianFee);
*/

				document.frm.fRentPhoneValue.value=rentPhone;
				document.frm.mobile_type.value=machName;
				document.frm.mobile_serial.value=machIccid;
				document.frm.perMachine_rent.value=machbodyFee;
	   			document.frm.perBattery_rent.value=batteryFee;
	   			document.frm.perCharger_rent.value=chargerFee;
				document.all.machine_num.value=1;
				document.all.battery_num.value=0;
				document.all.charger_num.value=0;
				document.all.accountBook.value=0;
				document.all.perMachine_rent.value=0.00;
				document.all.perBattery_rent.value=0.00;
				document.all.perCharger_rent.value=0.00;
				document.all.addition_fee.value=0.00;
				document.all.machine_rent.value=0.00;
				document.all.battery_rent.value=0.00;
				document.all.charger_rent.value=0.00;
				document.all.all_cost.value=0.00;

	   			break;   			
			}
		}
}

//确认处理
function submitCfm(){
    getAfterPrompt();
	var begin_timeT = "";
	var end_timeT = "";
	var getRentTimeT = "";
	var preBackTimeT = "";

	if(flag==1){
		document.frm.systemNote.value=document.frm.country_code.value+","+document.frm.roam_type.value+",押金合计:"+document.frm.all_rent.value+"元,租金方式:"+document.frm.rent_type.value;
		if(document.frm.opNote.value.length==0){
			document.frm.opNote.value=document.frm.phoneNo.value+"办理漫游租机,移动电话序列号："+document.frm.mobile_serial.value;
		}

    	if(forDate(document.frm.getRentTime)==false){
    		return;
    	}
    	if(forDate(document.frm.preBackTime)==false){
    		return;
    	}
    	if(forDate(document.frm.begin_time)==false){
    		return;
    	}
    	if(forDate(document.frm.end_time)==false){
    		return;
    	}
    	/* ningtn 异制租机*/
    	if(!checkTomr(document.frm.bookingTime)){
    		return false;
    	}
    	if(!checkOther(document.frm.otherComponent)){
    		return false;
    	}
    	var fDate = to_date(document.frm.begin_time);
    	var bDate = to_date(document.frm.end_time);
    	var fDate1 = to_date(document.frm.getRentTime);
    	var bDate1 = to_date(document.frm.preBackTime);
    	if(fDate>bDate){
    		rdShowMessageDialog("业务开通时间应该先于业务关闭时间！");
    		return;
    	}
    	if(fDate1>bDate1){
    		rdShowMessageDialog("取机时间应该先于还机时间！");
    		return;
    	}
    	begin_timeT=document.frm.begin_time.value+" 00:00:00";
    	end_timeT=document.frm.end_time.value+" 00:00:00";
    	getRentTimeT=document.frm.getRentTime.value+" 00:00:00";
    	preBackTimeT=document.frm.preBackTime.value+" 00:00:00";
    
    	if(document.frm.mobile_serial.value.length==0){
    		rdShowMessageDialog("请输入移动电话序列号码!");
    		return;
    	}
    
    	if(document.frm.machine_num.value.length==0){
    		rdShowMessageDialog("请输入机身数量!");
    		return;
    	}
    
    	if(document.frm.battery_num.value.length==0){
    		rdShowMessageDialog("请输入电池数量!");
    		return;
    	}
    
    	if(document.frm.charger_num.value.length==0){
    		rdShowMessageDialog("请输入充电器数量!");
    		return;
    	}
    
    	if(!forReal(document.frm.handFee)){
    		return;
    	}
    
    	if(parseFloat(document.frm.handFee.value) > parseFloat(document.frm.handFeeT.value)){
    		rdShowMessageDialog("手续费不能大于"+document.frm.handFeeT.value);
    		return;
    	}
        if(document.all.rent_type.value == "")
        {
            rdShowMessageDialog("请选择月租类型!");
    		return;
        }
    
    	printCommit();
    
    	if(printFlag!=1){
    		return;
    	}
    
    	document.frm.submit.disabled=true;
    	/* ningtn 2010-11-1 10:17:27
    	var myPacket = new AJAXPacket("f1222Cfm.jsp?asCustName="+document.frm.asCustName.value+"&asCustPhone="+document.frm.asCustPhone.value+"&asIdIccid="+document.frm.asIdIccid.value+"&asIdAddress="+document.frm.asIdAddress.value+"&asContractAddress="+document.frm.asContractAddress.value+"&asNotes="+document.frm.asNotes.value+"&machIccid="+document.frm.mobile_serial.value+"&travelName="+document.frm.travelName.value+"&otherComponent="+document.frm.otherComponent.value+"&systemNote="+document.frm.systemNote.value+"&opNote="+document.frm.opNote.value,"正在提交，请稍候......");
    	*/
    	var myPacket = new AJAXPacket("f1222Cfm.jsp?asCustName="+document.frm.asCustName.value+"&asCustPhone="+document.frm.asCustPhone.value+"&asIdIccid="+document.frm.asIdIccid.value+"&asIdAddress="+document.frm.asIdAddress.value+"&asContractAddress="+document.frm.asContractAddress.value+"&asNotes="+document.frm.asNotes.value+"&machIccid="+document.frm.mobile_serial.value+"&travelName=&otherComponent="+document.frm.otherComponent.value+"&systemNote="+document.frm.systemNote.value+"&opNote="+document.frm.opNote.value,"正在提交，请稍候......");
    
    	myPacket.data.add("loginAccept",document.frm.loginAccept.value);
    	myPacket.data.add("opCode",document.frm.opCode.value);
    	myPacket.data.add("workNo",document.frm.workNo.value);
    	myPacket.data.add("asIdType",document.frm.asIdType.value);
    	myPacket.data.add("noPass",document.frm.noPass.value);
    	myPacket.data.add("orgCode",document.frm.orgCode.value);
    	myPacket.data.add("idNo",document.frm.id_no.value);
    	myPacket.data.add("roamCountryCode",document.frm.fCountryCode.value);
    	myPacket.data.add("custType",document.frm.custtype.value);
    	myPacket.data.add("roamType",document.frm.roam_type.value);
    	myPacket.data.add("phoneRent","<%=activePhone1%>");
    	/*
    		alert("roamType : " + document.frm.roam_type.value);
    		alert("phoneRent : " + "<%=activePhone1%>");
    	*/
    	/* ningtn 2010-11-1 10:20:07
    	myPacket.data.add("roamType",document.frm.fRoamTypeValue.value);
    	myPacket.data.add("phoneRent",document.frm.fRentPhoneValue.value);
    	myPacket.data.add("travelFlag",document.frm.travelFlag.value);
    	myPacket.data.add("travelName",document.frm.travelName.value);
    	*/
    	myPacket.data.add("travelFlag","");
    	myPacket.data.add("travelName","");
    	myPacket.data.add("opTime",getRentTimeT);
    	myPacket.data.add("returnTime",preBackTimeT);
    	myPacket.data.add("openTime",begin_timeT);
    	myPacket.data.add("closeTime",end_timeT);
    	myPacket.data.add("machType",document.frm.mobile_type.value);
    
    	myPacket.data.add("machBodyNum",document.frm.machine_num.value);
    	myPacket.data.add("machBodyFee",document.frm.perMachine_rent.value);
    	myPacket.data.add("batteriesNun",document.frm.battery_num.value);
    	myPacket.data.add("batteriesFee",document.frm.perBattery_rent.value);
    	myPacket.data.add("chargerNum",document.frm.charger_num.value);
    	myPacket.data.add("chargerFee",document.frm.perCharger_rent.value);
    	myPacket.data.add("accountBook",document.frm.accountBook.value);
    	myPacket.data.add("additionFee",document.frm.addition_fee.value);
    
    	myPacket.data.add("rentType",document.frm.fRentCode.value);
    	myPacket.data.add("rentFee",document.frm.rent_cost.value);
    	/* ningtn
    	myPacket.data.add("visaName",document.frm.visaName.value);
    	*/
    	myPacket.data.add("visaName","");
    	myPacket.data.add("deposit",document.frm.all_rent.value);
    	myPacket.data.add("chandFee",document.frm.handFeeT.value);
    	myPacket.data.add("handFee",document.frm.handFee.value);
    	myPacket.data.add("phoneFee",document.frm.setNo_cost.value);
    	myPacket.data.add("ipAddr",document.frm.ipAdd.value);
		myPacket.data.add("phoneNo",document.frm.phoneNo.value);
		myPacket.data.add("bookingTime",document.frm.bookingTime.value);
    	core.ajax.sendPacket(myPacket);
    	
    	myPacket = null;
    	}
    	else{
    		rdShowMessageDialog("请先查询用户信息！");
    	}
}

//提取租金
function getRent(){
	var rentValue = document.frm.rent_type.value;
	var divFlag = rentValue.indexOf("|",0);
	var fRentCode = rentValue.substring(0,divFlag);
	var fRentFee = rentValue.substring(divFlag+1,rentValue.length);

	document.frm.fRentCode.value=fRentCode;
	document.frm.rent_cost.value=fRentFee;
}

//提取漫游号码相关信息
function showDiv(){
  	var countryValue=document.frm.country_code.value;
	var divFlag=countryValue.indexOf("|",0);
	var fCountryCode=countryValue.substring(0,divFlag);
	var fPhoneFee=countryValue.substring(divFlag+1,countryValue.length);

	document.frm.setNo_cost.value=fPhoneFee;
	document.frm.fCountryCode.value=fCountryCode;

	var roamFlag = 9;
	roamFlag = document.frm.roam_type.value;
	document.frm.fRoamTypeValue.value = roamFlag;

	/* ningtn
	document.all.rent_phone.disabled=false;
    document.all.mobile_serial.readOnly=true;
    document.all.mobile_type.readOnly=true;
    */
	document.all.mobile_serial.value="";
	document.all.mobile_type.value="";
	document.all.machine_num.value=1;
	document.all.battery_num.value=0;
	document.all.charger_num.value=0;
	document.all.accountBook.value=0;
	document.all.perMachine_rent.value=0.00;
	document.all.perBattery_rent.value=0.00;
	document.all.perCharger_rent.value=0.00;
	document.all.addition_fee.value=0.00;
	document.all.machine_rent.value=0.00;
	document.all.battery_rent.value=0.00;
	document.all.charger_rent.value=0.00;
	document.all.all_cost.value=0.00;


	//以下是各省不同租机方式相关处理
	//四川GSM-CDMA自动漫游
	if(<%=provCode%>==2800) {
		if (roamFlag==2){
			/* ningtn
			document.all.rentPhoneDiv.innerHTML="<input type=text class=button name=rent_phone disabled>";
			*/
			document.all.fRentPhoneValue.value=document.all.phoneNo.value;
			document.all.mobile_serial.readOnly=false;
			document.all.mobile_type.readOnly=false;
			return;
		}
	}
	//黑龙江0082境外取机
	if(<%=provCode%>==4510) {
		//alert(roamFlag);
		//alert(document.all.country_code.value.substring(0,4));
		if (roamFlag==0 && document.all.country_code.value.substring(0,4)=="0082"){
			/* ningtn
			document.all.rentPhoneDiv.innerHTML="<input type=text class=button name=rent_phone disabled>";
			*/
			document.all.fRentPhoneValue.value=document.all.phoneNo.value;
			document.all.mobile_serial.readOnly=false;
			document.all.mobile_type.readOnly=false;
			return;
		}
	}
	//山西、黑龙江原号漫游
	if(<%=provCode%>==3510||<%=provCode%>==4310) {
		if (roamFlag==0){
			/* ningtn
			document.all.rentPhoneDiv.innerHTML="<input type=text class=button name=rent_phone disabled>";
			document.all.rent_phone.value=document.all.phoneNo.value;
			*/
			document.all.mobile_serial.readOnly=false;
			document.all.mobile_type.readOnly=false;
			return;
		}
	}
	/* ningtn 去除调用
	getPhoneRentRes();
	 */
}

//获得未用漫游号码及对应机型押金
function getPhoneRentRes(){
	var myPacket = new AJAXPacket("getPhoneRentRes.jsp","正在提交，请稍候......");

	myPacket.data.add("countryCode",document.frm.fCountryCode.value);
	myPacket.data.add("owner_code",document.frm.cardType.value);
	myPacket.data.add("roam_type",document.frm.fRoamTypeValue.value);
	myPacket.data.add("prov_code","<%=provCode%>");
	myPacket.data.add("region_code","<%=region_codeT%>");

	core.ajax.sendPacket(myPacket);
	myPacket = null;

}


//旅行社名称
function setTravelName(){
	if (document.frm.travelFlag.value==1)
	{
		document.frm.travelName.value="";
		document.frm.travelName.readOnly=false;
	}
	else
	{
		document.frm.travelName.value="无信息";
		document.frm.travelName.readOnly=true;
	}
}

function checkTomr(obj){
	hiddenTip(obj);
	if(!checkElement(obj)){
		return false;
	}
	var inputTime = $("#bookingTime").val();
	var nowTime = "<%=dateStr%>";
	if(inputTime < nowTime){
		showTip(obj,"输入日期不得小于当前日期")
		return false;
	}
	return true;
}

function checkOther(obj){
	hiddenTip(obj);
	var otherStr = obj.value;
	if(otherStr.len() > 30){
		showTip(obj,"输入长度不得超过30字节");
		return false;
	}
	if(!checkElement(obj)){
		return false ;
	}
	return true;
}
</script>

<body>
<FORM action="" method=post name="frm" onKeyUp="chgFocus(frm)">
<%@ include file="/npage/include/header.jsp" %>
<div class="title">
	<div id="title_zi">用户信息</div>
</div>


<table cellspacing="0">
    <tr>
        <td class="blue">服务号码</td>
        <td>
            <input id=Text2 type=text size=13 name="phoneNo" id="phoneNo" value="<%=activePhone1%>" class="InputGrey" readOnly>
        </td>
        <td class="blue">客户名称</td>
        <td colspan="3">
            <input type="text" name="cust_name" class="InputGrey" readOnly>
        </td>
    </tr>
    <tr>
        <td class="blue">用户 I D</td>
        <td>
            <input type="text" name="id_no" class="InputGrey" readOnly>
        </td>
        <td class="blue">当前状态</td>
        <td>
            <input type="text" name="run_code" class="InputGrey" readOnly>
        </td>
        <td class="blue">级别</td>
        <td>
            <input type="text" name="cust_grade" class="InputGrey" readOnly>
        </td>
    </tr>
    
    <tr>
        <td class="blue">当前预存</td>
        <td>
            <input type="text" name="prepay_fee" class="InputGrey" readOnly>
        </td>
        <td class="blue">当前欠费</td>
        <td>
            <input type="text" name="owe_fee" class="InputGrey" readOnly>
        </td>
        <td class="blue">大客户标志</td>
        <td>
            <input type=text name=cardName class="InputGrey orange" readOnly>
        </td>
    </tr>

</table>

</div>
<div id="Operation_Table">
<div class="title">
	<div id="title_zi">业务办理</div>
</div>

<TABLE cellSpacing="0">
    <tr>
        <td class="blue">漫游国家</td>
        <td>
        	<!-- ningtn 2010-11-4 10:06:08 去除 onChange="showDiv()" -->
            <select name="country_code" index="2" onChange="showDiv()">
                <option value="">--请选择--</option>
                <%for(int i = 0 ; i < country.length ; i ++){%>
                    <option value="<%=country[i][0]%>|<%=country[i][2]%>"><%=country[i][1]%></option>
                <%}%>
            </select>
        </td>
        <td class="blue">申请人类别</td>
        <td colspan="3">
            <select name="custtype" index="3">
                <option value="0">个人</option>
                <option value="1">单位</option>
                <option value="2">委托</option>
            </select>
        </td>
    </tr>
    <tr>
        <td class="blue">漫游方式</td>
        <td colspan="5">
        	<!-- ningtn 2010-11-4 10:06:31 去除 onChange="showDiv()" -->
            <select name="roam_type" index="3" onChange="showDiv()">
                <option value="">--请选择--</option>
                <%for(int i = 0 ; i < roamTypeArr.length ; i ++){%>
                    <option value="<%=roamTypeArr[i][0]%>"><%=roamTypeArr[i][1]%></option>
                <%}%>
            </select>
        </td>
        <!-- ningtn 异制租机
        <td class="blue">漫游号码</td>
        <td colspan="3" id=rentPhoneTd >
            <div id=rentPhoneDiv>
                <select name="rent_phone">
                    <option value="">--请选择--</option>
                </select>
            </div>
        </td>
        -->
    </tr>
    
    <!-- ningtn 
    <tr id=travelDiv style="display=''">
        <td class="blue">旅行社取机标志</td>
        <td>
            <select name=travelFlag onchange=setTravelName()>
                <option value=0>否</option>
                <option value=1>是</option>
            </select>
        </td>
        <td class="blue">旅行社名称</td>
        <td colspan="3">
            <input type="text" name="travelName" value="无信息" readOnly index="7" >
        </td>
    </tr>
    <tr style="display=''">
        <td class="blue">护照号码</td>
        <td colspan="5">
            <input type="text" name="visaName" index="7" style="ime-mode:disabled" onKeyPress="return isKeyNumberdot(0)" onkeyup="value=value.replace(/[^\d]/g,'') "onbeforepaste="clipboardData.setData('text',clipboardData.getData('text').replace(/[^\d]/g,''))">
        </td>
    </tr>
    -->
    <tr id=travelDiv5 style="display=''">
        <td class="blue">取机时间</td>
        <td>
            <input type="text" name="getRentTime" v_format="yyyyMMdd" maxlength=8 index="8">
        </td>
        <td class="blue">预计还机时间</td>
        <td colspan="3">
            <input type="text" name="preBackTime" v_format="yyyyMMdd" maxlength=8 index="9">
        </td>
        </tr>
        <tr>
        <td class="blue">业务开通时间</td>
        <td>
            <input type="text" name="begin_time" v_format="yyyyMMdd" maxlength=8 index="10">
        </td>
        <td class="blue">业务关闭时间</td>
        <td colspan="3">
            <input type="text" name="end_time" v_format="yyyyMMdd" maxlength=8 index="11">
        </td>
    </tr>
    <tr>
    	<td class="blue">预约生效时间</td>
    	<td colspan="6">
    		<input type="text" name="bookingTime" id="bookingTime" value="<%=dateStr%>" 
    				v_must="1" v_type="date" v_format="yyyyMMdd" maxlength="8" onblur="checkTomr(this)" />
    	</td>
    </tr>
    <tr id=phoneDiv style="display=''" >
        <td class="blue">移动电话序列号</td>
        <td>
            <input type="text" name="mobile_serial"  maxlength="30" index="12">
        </td>
        <td class="blue">移动电话型号</td>
        <td colspan="3">
            <input type="text" name="mobile_type"  maxlength="30" index="12">
        </td>
    </tr>
    <tr id=phoneDiv1 style="display=''" >
        <td class="blue">机身数量</td>
        <td>
            <input type="text" name="machine_num" index="14" style="ime-mode:disabled" onKeyPress="return isKeyNumberdot(0)" onChange="getSum1()" value="1" onbeforepaste="clipboardData.setData('text',clipboardData.getData('text').replace(/[^\d]/g,''))">
        </td>
        <td class="blue">机身押金/单位</td>
        <td>
            <input type="text" name="perMachine_rent" style="ime-mode:disabled" onKeyPress="return isKeyNumberdot(0)" onChange="getSum1()" value="0.00" >
        </td>
        <td class="blue">总计
            <input class="b_text" type="button" name="Submit" value="--&gt;" onclick="getSum1()" >
        </td>
        <td class="blue">
            <input class="InputGrey" type="text" name="machine_rent" value="0.00" readOnly>
        </td>
    </tr>
    <tr id=phoneDiv2 style="display=''">
        <td class="blue">电池数量</td>
        <td>
            <input type="text" style="ime-mode:disabled" onKeyPress="return isKeyNumberdot(0)" name="battery_num" index="15" onChange="getSum2()" value="0"  onbeforepaste="clipboardData.setData('text',clipboardData.getData('text').replace(/[^\d]/g,''))">
        </td>
        <td class="blue">电池押金/单位</td>
        <td>
            <input type="text" style="ime-mode:disabled" onKeyPress="return isKeyNumberdot(0)" name="perBattery_rent" onChange="getSum2()" value="0.00" >
        </td>
        <td class="blue" nowrap>总计
            <input class="b_text" type="button" name="Submit2" value="--&gt;" onclick="getSum2()">
        </td>
        <td>
            <input class="InputGrey" type="text" name="battery_rent"  value="0.00" readOnly>
        </td>
    </tr>
    <tr id=phoneDiv3 style="display=''">
        <td class="blue" nowrap>充电器数量</td>
        <td>
            <input type="text" name="charger_num" index="16" onChange="getSum3()" value="0" style="ime-mode:disabled" onKeyPress="return isKeyNumberdot(0)" onbeforepaste="clipboardData.setData('text',clipboardData.getData('text').replace(/[^\d]/g,''))">            </td>
        <td class="blue" nowrap>充电器押金/单位</td>
        <td>
            <input type="text" name="perCharger_rent" style="ime-mode:disabled" onKeyPress="return isKeyNumberdot(0)" onChange="getSum3()" value="0.00" >
        </td>
        <td class="blue" nowrap>总计
            <input class="b_text" type="button" name="Submit3" value="--&gt;" onclick="getSum3()">
        </td>
        <td>
            <input type="text" name="charger_rent"  value="0.00" class="InputGrey" readOnly >
        </td>
    </tr>
    <tr id=travelDiv6 style="display=''">
        <td class="blue">说明书数量</td>
        <td>
            <input type="text" name="accountBook" index="17" value="0" style="ime-mode:disabled" onKeyPress="return isKeyNumberdot(0)" onbeforepaste="clipboardData.setData('text',clipboardData.getData('text').replace(/[^\d]/g,''))">
        </td>
        <td class="blue" nowrap>其他租用附件</td>
        <td>
        	<!-- ningtn 2010-11-1 10:52:00
            <select name=otherComponent>
                <option value=无>无</option>
                <option value=有>有</option>
            </select>
            -->
            <input type="text" name="otherComponent" id="otherComponent" maxlength="30" v_type="string" onblur = "checkOther(this)" v_maxlength="30" />
        </td>
        <td class="blue" nowrap>总计
            <input class="b_text" type="button" name="Submit4" value="--&gt;" onclick="getSum4();document.frm.addition_fee.value=document.frm.addition_fee.value;">
        </td>
        <td>
            <input type="text" name="addition_fee" id="addition_fee" value="0.00" v_type="money" onblur="getSum6(this)"/>
        </td>
    </tr>
    <tr style="display:none ">
        <td class="blue" nowrap>担保人名称</td>
        <td>
            <input id=Text2 type=text size=17 name=asCustName maxlength=20 onkeyup="value=value.replace(/[@#$%!^&*()<>?|]/g,'');">
        </td>
        <td class="blue" nowrap>担保人联系电话</td>
        <td>
            <input id=Text2 type=text size=17 name=asCustPhone maxlength=20  >
        </td>
        <td class="blue">联系地址</td>
        <td>
            <input id=Text2 type=text size=17 name=asContractAddress  maxlength=20 onkeyup="value=value.replace(/[@#$%!^&*()<>?|]/g,'');">
        </td>
    </tr>
    <tr style="display:none ">
        <td class="blue" nowrap>担保人证件类型</td>
        <td>
            <select size=1 name=asIdType  >
                <%for(int i = 0 ; i < sIdTypeStr.length ; i ++){%>
                    <option value="<%=sIdTypeStr[i][0]%>"><%=sIdTypeStr[i][1]%></option>
                <%}%>
            </select>
        </td>
        <td class="blue" nowrap>证件号码</td>
        <td>
            <input id=Text2 type=text size=17 name=asIdIccid  maxlength=20>
        </td>
        <td class="blue" nowrap>证件地址</td>
        <td>
            <input id=Text2 type=text size=17 name=asIdAddress  maxlength=20 onkeyup="value=value.replace(/[@#$%!^&*()<>?|]/g,'');">
        </td>
    </tr>
    
    <tr style="display:none">
        <td class="blue">担保备注</td>
        <td colspan="5">
            <input id=Text2a type=text size=30 name=asNotes  maxlength=30 onkeyup="value=value.replace(/[@#$%!^&*()<>?|]/g,'');">
        </td>
    </tr>
    <tr>
        <td class="blue">号码设定费</td>
        <td>
            <input class="InputGrey" type="text" name="setNo_cost" value="<%=country[0][2]%>" readOnly >
        </td>
        <td class="blue">押金合计
            <input class="b_text" type="button" name="Submit" value="--&gt;" onclick="getSum4()" >
        </td>
        <td colspan="3">
            <input class="InputGrey" type="text" name="all_rent" value="0.00" readOnly >
        </td>
    </tr>
    <tr>
        <td class="blue">月租类型</td>
        <td>
            <select name="rent_type" onchange="getRent()" index="5">
                <option value="">--请选择--</option>
                <%for(int i = 0 ; i < rentTypeArr.length ; i ++){%>
                    <option value="<%=rentTypeArr[i][0]%>|<%=rentTypeArr[i][2]%>"><%=rentTypeArr[i][1]%></option>
                <%}%>
            </select>
        </td>
        <td class="blue">单位租金</td>
        <td colspan="3">
            <input class="InputGrey" type="text" name="rent_cost"  value="<%=rentTypeArr[0][2]%>" readOnly >
        </td>
    </tr>
    <tr>
        <td class="blue">手续费</td>
        <td>
            <input type="text" name="handFee" index="20" <%if(feeFlag==0){%>readOnly class="InputGrey"<%}%> value="<%=tHandFee%>" v_type=float v_name="手续费">
        </td>
        <td class="blue">费用总计
            <input class="b_text" type="button" name="Submit6" value="--&gt;" index="21" onclick="getSum5()" >
        </td>
        <td colspan="3">
            <input class="InputGrey" type="text" name="all_cost" value="0.00" readOnly >
        </td>
    </tr>
    <tr>
        <td class="blue">实　收</td>
        <td>
            <input name="factPay" type="text" style="ime-mode:disabled" onKeyPress="return isKeyNumberdot(0)" onChange="getRemain()" value="0" size=24 index="22">
        
        </td>
        <td class="blue">找&nbsp;&nbsp;&nbsp;&nbsp;零
            <input class="b_text" id=getUseInfo type=button size=17 name=getUseInfo value="-->" onClick="getRemain()">
        </td>
        <td colspan="3">
            <input class="InputGrey" type="text" name="remain" size=24 value="0.00" readOnly >
        </td>
    </tr>
    <tr style="display:none">
        <td class="blue">用户备注</td>
        <td colspan="5">
            <input type="text" name="systemNote" size="60" index="23" onkeyup="value=value.replace(/[@#$%!^&*()<>?|]/g,'');">
        </td>
    </tr>
    <tr>
        <td class="blue">备　注</td>
        <td colspan="5">
            <input id=Text2 type=text size=60 name=opNote  maxlength=30 onkeyup="value=value.replace(/[@#$%!^&*()<>?|]/g,'');" class="InputGrey" readOnly>
        </td>
    </tr>
</table>
<!-- ningtn 2011-8-4 15:48:11 扩大电子工单 -->
<jsp:include page="/npage/public/hwReadCustCard.jsp">
	<jsp:param name="hwAccept" value="<%=paraStr[0]%>"  />
	<jsp:param name="showBody" value="01"  />
</jsp:include>
<table>
    <TR id="footer">
        <TD colspan="6">
            <input class="b_foot" name=submit  type=button value="确认" index="24" onkeyup="if(event.keyCode==13){submitCfm()}" onclick="submitCfm()" id=button >
            <input class="b_foot" name=cancel  type=button value=清除 id=Button2 onClick="window.location='f1222.jsp?activePhone1=<%=activePhone1%>&opCode=<%=opCode%>&opName=<%=opName%>'">
            <input class="b_foot" name=back13  type=button value=关闭 id=Button2 onClick="removeCurrentTab()">
        </TD>
    </TR>

</TABLE>

<input type=hidden name=workNo value=<%=workNo%>>
<input type=hidden name=noPass value=<%=nopass%>>
<input type=hidden name=orgCode value=<%=org_codeT%>>
<input type=hidden name=ipAdd value="<%=request.getRemoteAddr()%>">
<input type=hidden name=loginAccept value="<%=paraStr[0]%>">
<input type=hidden name=opCode value="1222">
<input type=hidden name=handFeeT value="<%=tHandFee%>">
<input type=hidden name=fRentCode value=<%=rentTypeArr[0][0]%>>
<input type=hidden name=fCountryCode value="<%=country[0][0]%>">
<input type=hidden name=fRoamTypeValue value="">
<input type=hidden name=fRentPhoneValue value="">
<input type=hidden name=cust_password value="">
<input type=hidden name=idCardNo>
<input type=hidden name=custAddress>
<input type=hidden name=backLoginAccept>

<input type=hidden name=cardType value="">
<input type=hidden name=smName value="">
<%@ include file="../../include/remark.htm" %>
&nbsp;&nbsp;&nbsp;
<%@ include file="/npage/include/footer.jsp" %>
</FORM>
</td></tr></table>

<script>

function printCommit()
{
    // in here form check
    showPrtDlg("Detail","确实要进行电子免填单打印吗？","Yes");
}

function showPrtDlg(printType,DlgMessage,submitCfn)
{  //显示打印对话框
    var h=198;
    var w=400;
    var t=screen.availHeight/2-h/2;
    var l=screen.availWidth/2-w/2;

    //var printStr = printInfo(printType);
    //
    //var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no"
    //var path = "<%=request.getContextPath()%>/page/innet/hljPrint.jsp?DlgMsg=" + DlgMessage;
    //var path = path + "&printInfo=" + printStr + "&submitCfn=" + submitCfn;
    //var ret=window.showModalDialog(path,"",prop);
     
    var pType="subprint";
    var billType="1";
    var sysAccept = "<%=paraStr[0]%>";
    var mode_code = null;
    var fav_code = null;
    var area_code = null;
    var printStr = printInfo(printType);
    var phoneno = "<%=activePhone1%>";
		/* ningtn */
		var iccidInfoStr = $("#firstId").val() + "|" + $("#secondId").val();	
		var accInfoStr = $("#accInfoHid1").val() + "|" +$("#accInfoHid2").val()+ "|" +$("#accInfoHid3").val()+ "|" +$("#accInfoHid4").val();
		/* ningtn */
    var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no"; 
    var path = "<%=request.getContextPath()%>/npage/innet/hljBillPrint_jc_hw.jsp?DlgMsg=" + DlgMessage+ "&iccidInfo=" + iccidInfoStr + "&accInfoStr="+accInfoStr;
    var path = path+"&mode_code="+mode_code+"&fav_code="+fav_code+"&area_code="+area_code+"&opCode=<%=opCode%>&sysAccept="+sysAccept+"&phoneNo="+phoneno+"&submitCfm="+submitCfn+"&pType="+pType+"&billType="+billType+ "&printInfo=" + printStr;
    var ret=window.showModalDialog(path,printStr,prop);
     
    ret="confirm";
    if(typeof(ret)!="undefined")
    {
        if((ret=="confirm")&&(submitCfn == "Yes"))
        {
            if(rdShowConfirmDialog('确认要进行此项服务吗吗？')==1)
            {
                printFlag=1;
            }
        }
    }
}

function printInfo(printType)   
{
    var cust_info="";
    var opr_info="";
    var note_info1="";
    var note_info2="";
    var note_info3="";
    var note_info4="";

    var retInfo = "";
    if(printType == "Detail")
    {
        //retInfo+='<%=workNo%>  <%=workName%>'+"|";
        //retInfo+='<%=new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss", Locale.getDefault()).format(new java.util.Date())%>'+"|";
        
        cust_info+="手机号码："+document.all.phoneNo.value+"|";
        cust_info+="客户姓名："+document.all.cust_name.value+"|";
        cust_info+="客户地址："+document.all.custAddress.value+"|";
        cust_info+="证件号码："+document.all.idCardNo.value+"|";

        opr_info+="用户品牌："+document.all.smName.value+"   业务类型：异制租机 － 申请 "+"   操作流水："+document.frm.loginAccept.value+"|";
        /* ningtn 2010-11-3 10:04:22 */
        opr_info+="机身押金: "+document.all.machine_rent.value + "  电池押金: "+document.all.battery_rent.value + "  充电器押金: "+document.all.charger_rent.value + "  " + $("#otherComponent").val() + " " + $("#addition_fee").val();
        opr_info+="  租机押金合计: " + document.all.all_rent.value + " 元|";
        opr_info+="手机序列号："+document.all.mobile_serial.value+"  手机型号："+document.all.mobile_type.value+"|";
        opr_info+="租机方式： "+document.all.roam_type.options[document.all.roam_type.selectedIndex].text+"      漫游国家："+document.all.country_code.options[document.all.country_code.selectedIndex].text+"|";

    	//alert(document.frm.fRentCode.value);
    	if(document.frm.fRentCode.value =="a")
    	{
    	    opr_info+="租金类型: 日收   "+ "日租金: " + document.all.rent_cost.value+" 元|";
    	}else if (document.frm.fRentCode.value == "b")
    	{
    	    opr_info+="租金类型: 月收   "+ "月租金: " + document.all.rent_cost.value+" 元|";
    	}
    	else if (document.frm.fRentCode.value == "c")
    	{
    	    opr_info+="租金类型: 年收   "+ "年租金: " + document.all.rent_cost.value+" 元|";
    	}
    	opr_info+="预计还机时间： "+document.all.preBackTime.value+"|";
    	
    	note_info1+="备注"+"|";
    	
        retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
        retInfo=retInfo.replace(new RegExp("#","gm"),"%23"); 
    }

    if(printType == "Bill")
    {	//打印发票
    	//printBill();
    }
    return retInfo;
}
</script>
<script>
function printBill(){
    var infoStr="";
    infoStr+='<%=workNo%>'+"  "+document.frm.backLoginAccept.value+"  "+"异制租机申请"+"|";
    infoStr+='<%=new java.text.SimpleDateFormat("yyyy   MM    dd", Locale.getDefault()).format(new java.util.Date())%>'+"|";
    infoStr+=document.frm.cust_name.value+"|";
    infoStr+=""+"|";
    infoStr+=document.frm.phoneNo.value+"|";
    infoStr+=""+"|";
    infoStr+=""+"|";
    infoStr+=document.frm.handFee.value+"|";
    infoStr+="异制租机申请。*手续费："+document.frm.handFee.value+"|";
    infoStr+=""+"|";
    infoStr+="备注："+"用户 "+document.frm.phoneNo.value+" 打印发票"+"|";
    location="<%=request.getContextPath()%>/npage/innet/chkPrintNew.jsp?retInfo="+infoStr+"&dirtPage=<%=request.getContextPath()%>/npage/s1222/f1222.jsp?activePhone1=<%=activePhone1%>&opCode=<%=opCode%>&opName=<%=opName%>";

}
</script>
</BODY>
<!-- ningtn 2011-7-12 08:35:36 电子化工单扩大范围 -->
<%@ include file="/npage/public/hwObject.jsp" %> 
</HTML>

<!DOCTYPE html PUBLIC "-//W3C//Dtd Xhtml 1.0 transitional//EN" "http://www.w3.org/tr/xhtml1/Dtd/xhtml1-transitional.dtd">
<%
  /*
   * 功能: 账户密码修改
   * 版本: 1.0
   * 日期: 2009/1/19
   * 作者: leimd
   * 版权: si-tech
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
	String opCode = (String)request.getParameter("opCode");			//操作代码
	String opName = (String)request.getParameter("opName");			//操作名
	String dWorkNo = (String)session.getAttribute("workNo");		//操作工号
	String nopass = (String)session.getAttribute("password");		//工号密码
	String sIpAddress = (String)session.getAttribute("ipAddr");		//登录IP
	String org_code = (String)session.getAttribute("orgCode");		//归属代码
	String region_code = (String)session.getAttribute("regCode");	//地市
	String regionCode = region_code;
	String district_code = org_code.substring(2,4);
	String[][] favInfo = (String[][])session.getAttribute("favInfo");//优惠信息
	int favFlag = 0 ;
	
	//2011/6/23 wanghfa添加 对密码权限整改 start
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
	
	//2011/6/23 wanghfa添加 对密码权限整改 end

	String op_code = "1232";
%>
<%
/** 判断4A总开关，当开关为开时，调用4A。当开关为关时，允许继续操作 
	*		0和没数据是关 ， 1是开
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
			rdShowMessageDialog("查询金库开关出错!",1);
			removeCurrentTab();
		</script>
		<%
	}
	if("000000".equals(retCode_region2) && resultGoldFlag.length > 0){
		goldFlag=Integer.parseInt( resultGoldFlag[0][0] );
	}else{
		%>
		<script language="javascript">
			rdShowMessageDialog("查询金库开关出错!",1);
			removeCurrentTab();
		</script>
		<%
	}
	

if("000000".equals(retCode_region2) && resultGoldFlag.length > 0  &&  "000000".equals(retCode_region) && resultSwitchFlag.length > 0  ){
	switchFlag = Integer.parseInt(resultSwitchFlag[0][0]);
	goldFlag=Integer.parseInt( resultGoldFlag[0][0] );

	/*默认赋值为1*/
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
				//有手续费并且有优惠权限
				}
			}
		}
	
   
%>
<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="region" routerValue="<%=region_code%>"  id="seq"/>
<html xmlns="http://www.w3.org/1999/xhtml">
	<HEAD>
<TITLE>帐户密码修改</TITLE>
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

  //---通过RPC处理函数-获取帐户信息信息------
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
		   rdShowMessageDialog("此帐户ID信息不存在！");
		   document.all.qConMsg.disabled=false;

		   
		   return ;
		}
		if(vConPaswdFlag != 0)
		{
		   rdShowMessageDialog("帐户密码错误，请重新输入!");
		   document.all.vConPaswd.value="";
		   document.all.qConMsg.disabled = false;
		   document.all.vConPaswd.disabled = false;
		   return ;
		}

				 
		if(triListData[0].length == 15)
		{
			document.all.vConPaswd.value=triListData[0][0];
		document.all.vAcountName.value = triListData[0][1]; //帐户名称
		
		 document.all.vCountHead.value = triListData[0][2];   //帐户零头
		 
		 document.all.vPrePay.value = triListData[0][3];    //prepay_fee
		 
		 document.all.vDeposit.value = triListData[0][4]; //押金
		 
		 document.all.vMinYearMonth.value = (triListData[0][5]).substr(0,4)+"年"+(triListData[0][5]).substr(4,2)+"月";//最小欠费年月
		 
		 document.all.vOweFee.value = triListData[0][6];    //欠费
		 
		 document.all.vMark.value = triListData[0][7];  //积分
		 
		 document.all.vCountGrand.value = triListData[0][8]; //帐户信誉度
		 
		 document.all.vPayCode.value = triListData[0][9];  //付款方式
		 
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
				document.all.vSysNote.value="重置"+document.all.vConID.value + "帐户信息";
			}
			else if(document.f1211.passOpType.value == '0'){
				document.all.vSysNote.value="修改"+document.all.vConID.value + "帐户信息"
			}


		window.status="";
		
	  }
   }
  
  function checkIfPayCode4(){
  	var vConID =  $.trim(document.all.vConID.value);
  	var checkPwd_Packet = new AJAXPacket("/npage/s1232/f1232CheckPayCode.jsp","正在进行密码校验，请稍候......");
		checkPwd_Packet.data.add("vConID",vConID);		//工号
		core.ajax.sendPacket(checkPwd_Packet, doCheckPay);
		checkPwd_Packet=null;
  }
  function doCheckPay(packet){
  	var retCode = packet.data.findValueByName("retcode");
		var retMsg = packet.data.findValueByName("retmsg");
		var mycount = packet.data.findValueByName("mycount");
		if (retCode == "000000") {
			/*隐藏域赋值*/
			$("#myCount").val(mycount);
		}else{
			
			rdShowMessageDialog("错误代码："+retCode+",错误信息："+retMsg,1);
			return false;
		}
		
  }
  
  function ajaxQueryOfferTraffic() {
    var vConID =  $.trim(document.all.vConID.value);
		var funtionnames_Packet = new AJAXPacket("queryKZCHCon.jsp","正在查询，请稍后......");
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
		/*增加校验是否托收帐户*/
		if($("#passOpType").val() == "1"){//重置密码
			checkIfPayCode4();
			ajaxQueryOfferTraffic();
			var myCount = $("#myCount").val();
			var offerTrafficflag = $("#offerTrafficflag").val();
			/*是托收账户，校验金库*/
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
		//2010-8-20 15:51 wanghfa修改 密码验证修改 start
		/*2015/5/12 9:42:10 gaopeng 
			如果是托收账户 并且金库开关为开 则不需要输入密码
		*/
		if(("<%=goldFlagA%>" == "true" && (myCount != "0" || offerTrafficflag != "0") && $("#passOpType").val() == "1") ){
			var myPacket = new AJAXPacket("f1211ConMsg.jsp","正在获得帐户信息，请稍候......");
	
			//传递输入参数
			myPacket.data.add("pContractNo",formFieldOut.value);
			myPacket.data.add("vConPaswd",document.all.vConPaswd.value);
			
			core.ajax.sendPacket(myPacket);
			
			myPacket=null;
		}
		else if("<%=favFlag%>" == "1"){
			var myPacket = new AJAXPacket("f1211ConMsg.jsp","正在获得帐户信息，请稍候......");
			
			//传递输入参数
			myPacket.data.add("pContractNo",formFieldOut.value);
			myPacket.data.add("vConPaswd",document.all.vConPaswd.value);
			
			core.ajax.sendPacket(myPacket);
			
			myPacket=null;
		}
		/*如果没有免密权限*/
		else{
			
			if(document.all.vConPaswd.value.length==0){
				rdShowMessageDialog("请输入密码！");
				document.all.vConPaswd.disabled=false;
				document.all.qConMsg.disabled=false;
				return;
			}
		 
			var checkPwd_Packet = new AJAXPacket("/npage/public/pubCheckPwd.jsp","正在进行密码校验，请稍候......");
			checkPwd_Packet.data.add("custType","03");				//01:手机号码 02 客户密码校验 03帐户密码校验
			checkPwd_Packet.data.add("phoneNo",document.all.vConID.value);	//移动号码,客户id,帐户id
			checkPwd_Packet.data.add("custPaswd",document.all.vConPaswd.value);//用户/客户/帐户密码
			checkPwd_Packet.data.add("idType","un");				//en 密码为密文，其它情况 密码为明文
			checkPwd_Packet.data.add("idNum","");					//传空
			checkPwd_Packet.data.add("loginNo","<%=dWorkNo%>");		//工号
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
		
		//var myPacket = new AJAXPacket("f1211ConMsg1.jsp","正在获得帐户信息，请稍候......");

		var myPacket = new AJAXPacket("f1211ConMsg.jsp","正在获得帐户信息，请稍候......");

		//传递输入参数
		myPacket.data.add("pContractNo",formFieldOut.value);
		myPacket.data.add("vConPaswd",document.all.vConPaswd.value);
		
		core.ajax.sendPacket(myPacket);
		
		myPacket=null;
	}
//2010-8-20 15:51 wanghfa修改 密码验证修改 end

  function f1211CheckID()
  {
        document.all.vConID.disabled = false;
        if(document.all.vQryType[0].checked) // 按照帐户查询
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
	
	if(document.all.vQryType[1].checked) // 按照证件查询
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
	
	if(document.all.vQryType[2].checked) // 按照客户查询
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
    var pageTitle = "客户ID信息查询";
    var fieldName = "客户ID|客户名称|"; 
    var selType = "S";    //'S'单选；'M'多选
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
    var pageTitle = "帐户ID信息查询";
    var fieldName = "帐户ID|帐户名称|"; 
    var selType = "S";    //'S'单选；'M'多选
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
		 if(document.all.vPostType.value == "0") //传真
		 {
			if(!checkElement(document.all.vFaxNo)) return false;
		 }
		 else if(document.all.vPostType.value == "1") //邮寄
		 {
			if(!checkElement(document.all.vPostZip)) return false;
			if(!checkElement(document.all.vPostAddress)) return false;
		 }
		 else //电子邮件
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
		 rdShowMessageDialog("新密码和确认密码不等，请重新输入！");
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


 // 手续费检查
 function getFew()
{
  if(window.event.keyCode==13)
  {
    var fee=document.all.vPayFee;
    var fact=document.all.vRealFee;
    var few=document.all.vPayChange;
    if(jtrim(fact.value).length==0)
    {
	  rdShowMessageDialog("实收金额不能为空！");	
	  fact.value="";
	  fact.focus();
	  return;
    }
//    if(parseFloat(fact.value)<parseFloat(fee.value))
//    {
//  	  rdShowMessageDialog("实收金额不足！");	
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
    参数1(pageTitle)：查询页面标题
    参数2(fieldName)：列中文名称，以'|'分隔的串
    参数3(sqlStr)：sql语句
    参数4(selType)：类型1 rediobutton 2 checkbox
    参数5(retQuence)：返回域信息，返回域个数＋ 返回域标识，以'|'分隔，如"3|0|2|3"表示返回3个域0，2，3
    参数6(retToField))：返回值存放域的名称,以'|'分隔
*/
function PubSimpSel(pageTitle,fieldName,sqlStr,selType,retQuence,retToField,params)
{   //公共查询 
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
    参数1(pageTitle)：查询页面标题
    参数2(fieldName)：列中文名称，以'|'分隔的串
    参数3(sqlStr)：sql语句
    参数4(selType)：类型1 rediobutton 2 checkbox
    参数5(retQuence)：返回域信息，返回域个数＋ 返回域标识，以'|'分隔，如"3|0|2|3"表示返回3个域0，2，3
    参数6(retToField))：返回值存放域的名称,以'|'分隔
*/
function PubSimpSelNew(pageTitle,fieldName,sqlStr,selType,retQuence,retToField,id_iccid)
{   //公共查询 
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
			rdShowMessageDialog("两次输入的密码不一致！");
			return;
		}
		if(document.f1211.vNewPaswd.value.length==0){
			rdShowMessageDialog("新密码不得为空！");
			return;
		}
		if(!forNonNegInt(document.f1211.vNewPaswd)){
			return;
		}
		if(document.f1211.vOpNote.value.length==0){
			if(document.f1211.passOpType.value == '1'){
				document.f1211.vOpNote.value="帐户密码重置";
			}
			else if(document.f1211.passOpType.value == '0'){
			  document.f1211.vOpNote.value="帐户密码修改";
			}
		}
		
		checkPwdEasy(document.f1211.vNewPaswd.value);	//2010-8-9 9:52 wanghfa添加 客户密码限制需求
}

//2010-8-9 8:43 wanghfa添加 验证密码过于简单 start
function checkPwdEasy(pwd) {
	var checkPwd_Packet = new AJAXPacket("../public/pubCheckPwdEasy.jsp","正在验证密码是否过于简单，请稍候......");
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
		rdShowMessageDialog("尊敬的客户，您本次设置的密码为相同数字类密码，安全性较低，为了更好地保护您的信息安全，请您设置安全性更高的密码。");
		return;
	} else if (retResult == "2") {
		rdShowMessageDialog("尊敬的客户，您本次设置的密码为连号类密码，安全性较低，为了更好地保护您的信息安全，请您设置安全性更高的密码。");
		return;
	} else if (retResult == "3") {
		rdShowMessageDialog("尊敬的客户，您本次设置的密码为手机号码中的连续数字，安全性较低，为了更好地保护您的信息安全，请您设置安全性更高的密码。");
		return;
	} else if (retResult == "4") {
		rdShowMessageDialog("尊敬的客户，您本次设置的密码为证件中的连续数字，安全性较低，为了更好地保护您的信息安全，请您设置安全性更高的密码。");
		return;
	} else if (retResult == "0") {
		printCommit();
		if(printFlag!=1){
			return;
		}		
		document.f1211.submit.disabled=true;
		var myPacket = new AJAXPacket("submit.jsp","正在提交，请稍候......");
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
//2010-8-9 8:43 wanghfa添加 验证密码过于简单 end



function getThePassType(){
	var i = 0 ; 
	var passType = 0 ;
	for(i = 0 ; i < document.f1211.passOpType.length ; i ++){
		if(document.f1211.passOpType.options[i].selected){
			passType = document.f1211.passOpType.options[i].value;
			
		}
	}
	
	if(passType==1){//复位
		//showHideTr.style.display="none";
		document.f1211.opType.value="1";
		document.f1211.vNewPaswd.value="";
		document.f1211.vCfmPaswd.value="";
		document.f1211.opCode.value="1233";
		
	}
	else{//修改
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
		<div id="title_zi">选择查询类型</div>
	</div>
<table cellspacing="0">
	
		<tr> 
			<td class="blue">操作类型</td>
		<td colspan="3">
			<select name=passOpType id='passOpType' onchange="getThePassType()" index="8">
				<option value="1">重置密码</option>
				<option value="0">修改密码</option>
			</select>
		</td>
	</tr>
	
	<tr> 
		<td class="blue">查询类型</td>
		<td colspan="3">
			<input type="radio" name="vQryType" index="0" value="0" onkeyup="if(event.keyCode==13){f1211CheckID()}" onClick="f1211CheckID()" checked>
			帐户 
			<input type="radio" name="vQryType" index="1" value="1" onClick="f1211CheckID()" onkeyup="if(event.keyCode==13){f1211CheckID()}">
			证件 
			<input type="hidden" name="vQryType" index="2" value="2" onclick="f1211CheckID()" onkeyup="if(event.keyCode==13){f1211CheckID()}">
		</td>
	</tr>
	
	<tr id="idCert"> 
		<td class="blue">证件类型</td>
		<td><select name="vCertType" index="3"></select></td>
		<td class="blue">证件号码</td>
		<td>
			<input name="vCertNum" type="text" v_type="string" class="button" size="18" maxlength="18" index="4" onkeyup="if(event.keyCode==13){f1211GetCustID(vCertNum)}"> 
			<input class="b_text" type="button" name="qCustID" value="查询客户ID" onClick="f1211GetCustID(vCertNum)">
		</td>
	</tr>
    
	<tr id="idCust"> 
	<td class="blue">客户 ID</td>
	<td>
		<input name="vCustID" type="text" class="button" v_type="int" index="5" onkeyup="if(event.keyCode==13){f1211GetConID(vCustID)}" maxlength="22">
	</td>
	<td colspan="2">
		<input name="vCustPaswd"  type="hidden" class="button" size="18" v_type="0_9" v_must="0" maxlength="8">
		<input class="b_text" type="button" name="qConID" value="查询帐户ID" onClick="f1211GetConID(vCustID)"></td>
	</tr>
    
	<tr> 
		<td class="blue">帐户ID</td>
		<td>
			<input name="vConID" type="text" index="6" class="button" v_must="1" v_type="int" maxlength="22">
		</td>
		<%if(favFlag==0){%>
		<td class="blue">帐户密码</td>
		<td>
			<input name="vConPaswd" index="7" onkeyup="if(event.keyCode==13){f1211GetConMsg(vConID)}" type="password" class="button" v_type="0_9" v_must="0" size="18" maxlength="8"> 
			<input class="b_text" type="button" name="qConMsg" value="查询帐户信息" onClick="f1211GetConMsg(vConID)">
		</td>
		<%}else{%>
		<td colspan="2">
			<input name="vConPaswd" index="7" type="hidden" class="button" v_type="0_9" v_must="0" size="18" maxlength="8" disabled value="111111"> 
			<input class="b_text" type="button" name="qConMsg" value="查询帐户信息" onClick="f1211GetConMsg(vConID)">
		</td>
		<%}%>
	</tr>
    
	<tr>
		<td class="blue" nowrap>大客户标志</td>
		<td>
			<input type="text" class="InputGrey" name="vCardName" readonly>
		</td>
		<td class="blue" nowrap>集团标志</td>
		<td>
			<input type="text" class="InputGrey" name="vGrpName" readonly>
		</td>
	</tr>
	
	<tr> 
		<td class="blue">帐户零头</td>
		<td valign="top">
			<input type="text" class="InputGrey" name="vCountHead" readonly>
		</td>
		<td class="blue" nowrap>帐户信誉度</td>
		<td>
			<input type="text" class="InputGrey" name="vCountGrand" readonly>
		</td>
	</tr>
	
    <tr> 
		<td class="blue">帐户预存</td>
		<td>
			<input type="text" class="InputGrey" name="vPrePay" readonly>
		</td>
		<td class="blue">押 金</td>
		<td>
			<input type="text" class="InputGrey" name="vDeposit" readonly>
		</td>
    </tr>
    
    <tr> 
		<td class="blue" nowrap>最小欠费年月</td>
		<td valign="top">
			<input type="text" class="InputGrey" name="vMinYearMonth" readonly>
		</td>
		<td class="blue">欠 费</td>
		<td>
			<input type="text" class="InputGrey" name="vOweFee" readonly>
		</td>
    </tr>
    
	<tr> 
		<td class="blue">积 分</td>
		<td colspan="3">
			<input type="text" class="InputGrey" name="vMark" readonly>
		</td>
    </tr>
  
    
    <tr> 
		<td class="blue">银行代码名称</td>
		<td><select name="vBankCode" class="button" disabled></select></td>
		<td class="blue">局方银行代码名称</td>
		<td><select name="vPostCode" class="button" disabled></select></td>
    </tr>
    
    <tr> 
		<td class="blue">帐 号</td>
		<td colspan="3">
			<input name="vAcountNum" type="text" v_type="int" class="InputGrey" size="60" readonly>
		</td>
    </tr>
    
    <tr> 
		<td class="blue">帐户名称</td>
		<td colspan="3">
			<input name="vAcountName" type="text" v_must="1"  v_type="string" class="InputGrey" size="60" readonly>
		</td>
    </tr>
    
	<tr> 
		<td class="blue">帐户类型</td>
		<td>
			<select name="vCountType" class="button" disabled>
				<option value="2"> </option>
				<option value="1">异常</option>
				<option value="0">正常</option>
			</select>
		</td>
		<td class="blue">帐户状态</td>
		<td><select name="vCountStatus" class="button" disabled ></select></td>
    </tr>
    
    <tr> 
		<td class="blue">邮寄标志</td>
		<td>
			<select name="vPostFlag" class="button" disabled>
				<option value="Y">是</option>
				<option value="N">否</option>
			</select>
		</td>
		<td class="blue">邮寄方式</td>
		<td>
			<select name="vPostType" class="button" disabled>
			</select>
		</td>
    </tr>
	
    <tr> 
		<td class="blue">邮 编</td>
		<td>
			<input name="vPostZip" type="text" v_must="1" v_type="zip" class="InputGrey" maxlength="6" readonly>
		</td>
		<td class="blue">邮寄地址</td>
		<td>
			<input type="text" class="InputGrey" v_must="1" v_type="string" name="vPostAddress" readonly>
		</td>
    </tr>
    
    <tr> 
		<td class="blue">传真号</td>
		<td>
			<input type="text" class="InputGrey" name="vFaxNo" v_must="1" v_type="phone" readonly>
		</td>
		<td class="blue">E_Mail地址</td>
		<td>
			<input type="text" class="InputGrey" id="vMailAddress"  name="vMailAddress" v_must="1" v_type="email" readonly>
		</td>
    </tr>
    
    <tr> 
		<td class="blue">付款方式</td>
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
		<td class="blue">手续费</td>
		<td>
			<input name="vPayFee" type="text" index="11" class="InputGrey" value="<%=tmpHandFee%>" size="12" readonly v_minlength="1" v_maxlength="12" v_must=1 v_type="cfloat">
		</td>
		<td class="blue">实收
			<input name="vRealFee" type="text" class="InputGrey"  index="12" onKeyUp="getFew()" <%if(feeFlag==0){%>value="<%=tmpHandFee%>" readonly<%}%> v_minlength="1" v_maxlength="12" v_must=1 v_type="cfloat">
		</td>
		<td class="blue">找零
			<input name="vPayChange" type="text" class="InputGrey" value="0" readonly v_minlength="1" v_maxlength="12" v_must=1 v_type="cfloat">
		</td>
    </tr>
    
    <tr> 
      <td class="blue">系统备注</td>
      <td colspan="3">
      	<input name="vSysNote" class="InputGrey" type="text" size="60" readonly>
      </td>
    </tr>
    
    <tr style="display:none"> 
		<td class="blue">用户备注</td>
		<td colspan="3">
			<input name="vOpNote" class="button" index="13" type="text" size="60" maxlength="60">
		</td>
    </tr>
</table>
<!-- ningtn 2011-8-4 11:05:17 扩大电子工单 -->
<jsp:include page="/npage/public/hwReadCustCard.jsp">
	<jsp:param name="hwAccept" value="<%=seq%>"  />
	<jsp:param name="showBody" value="01"  />
</jsp:include>
<table>
	<tr> 
		<td id="footer" colspan="4" align="center"> 
			<input class="b_foot" type="button" name="submit" value="确认"  onClick="submitt()" index="14" onkeyup="if(event.keyCode==13){submitt()}">
			<input class="b_foot" type="button"  name="b_clear" value="清除" onclick="document.f1211.vNewPaswd.value='';document.f1211.vCfmPaswd.value='';">
			<input class="b_foot" type="button" name="b_back" value="关闭"  onClick="removeCurrentTab()">
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

<!-- 2014/12/26 14:47:50 gaopeng 关于完善金库模式管理和敏感信息模糊化的需求 引入公共页面 openType用来区分普通金库校验和定制类公共校验-->
<jsp:include page="/npage/public/intf4A/common/intfCommon4A.jsp">
	<jsp:param name="openType" value="SPECIAL"  />
</jsp:include>
	<%@ include file="/npage/include/footer.jsp" %>
</form>
	  
	  <!------------------------------------------------------------------------->


</BODY>
<!-- ningtn 2011-7-12 08:35:36 电子化工单扩大范围 -->
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
	showPrtDlg("Detail","确实要进行电子免填单打印吗？","Yes");  	 
}

function showPrtDlg(printType,DlgMessage,submitCfn)
{  //显示打印对话框 
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
       if(rdShowConfirmDialog('确认要进行此项服务吗？')==1)
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
	  cust_info+="帐户ID："+document.all.vConID.value+"|";
	  cust_info+="帐户名称："+document.all.vAcountName.value+"|";
	  opr_info+="办理业务："+document.all.passOpType.options[document.all.passOpType.selectedIndex].text+"|";
	  opr_info+="帐户号码(ID)："+document.f1211.vConID.value+"|";
	  opr_info+="帐户名称:"+document.f1211.vAcountName.value+"|";
	  note_info1+="备注："+"|";
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
	 infoStr+=""+"|";//移动号码                                                   
	 infoStr+=" "+"|";//合同号码                                                          
	 infoStr+=document.all.vAcountName.value+"|";//用户名称                                                
	 infoStr+=document.all.vPostAddress.value+"|";//用户地址   
	 infoStr+="现金"+"|";
		 infoStr+=document.all.vPayFee.value+"|";                                                
	 infoStr+="帐户密码修改。*手续费："+(document.f1211.vRealFee.value-document.f1211.vPayChange.value)+"*流水号："+document.all.backLoginAccept.value+"|";
	 location="chkPrint.jsp?retInfo="+infoStr+"&dirtPage=f1232.jsp";                    
}
</script>
</HTML>

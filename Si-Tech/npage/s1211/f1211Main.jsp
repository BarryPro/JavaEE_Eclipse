<%
/********************
version v2.0
开发商: si-tech
模块：帐户资料变更
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
	
	//2011/6/23 wanghfa添加 对密码权限整改 start
  boolean pwrf=false;
	String pubOpCode = op_code;
	String pubWorkNo = work_no;
%>
	<%@ include file="/npage/public/pubCheckPwdPower.jsp" %>
<%
	System.out.println("====wanghfa====s1211Main.jsp==== pwrf = " + pwrf);
	//2011/6/23 wanghfa添加 对密码权限整改 end
	

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
<TITLE>帐户资料变更</TITLE>
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

  //---通过RPC处理函数-获取帐户信息信息------
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
		   rdShowMessageDialog("此帐户ID信息不存在！");
		   document.all.vConID.focus();
		   return false;
		}
		<%-- if("<%=pwrf%>" == "false") --%>
		//{
			if(vConPaswdFlag != 0)
			{
				rdShowMessageDialog("帐户密码错误，请重新输入!");
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
			
		 document.all.vAcountName.value = triListData[0][1]; //帐户名称
		 document.all.oldvAcountName.value = triListData[0][1]; //帐户名称
		 document.all.vCountHead.value = triListData[0][2];   //帐户零头
		 document.all.vPrePay.value = triListData[0][3];    //prepay_fee
		 document.all.vDeposit.value = triListData[0][4]; //押金
		 document.all.vMinYearMonth.value = (triListData[0][5]).substr(0,4)+"年"+(triListData[0][5]).substr(4,2)+"月";//最小欠费年月
		 document.all.vOweFee.value = triListData[0][6];    //欠费
		 document.all.vMark.value = (triListData[0][7]).trim();  //积分
		 document.all.vCountGrand.value = triListData[0][8]; //帐户信誉度
		
		 document.all.vPayCode.value = triListData[0][9];  //付款方式
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
		
		document.all.vSysNote.value="修改"+document.all.vConID.value + "帐户信息";
		window.status="";
		
	  }
		if (rpc_page=="queryBookingId")/*zhangyan@查预约ID*/
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
 		 rdShowMessageDialog("请输入帐户密码!");
			document.all.vConPaswd.value="";
			document.all.vConPaswd.focus();
			return false;
	  }
 		document.all.tmpPaswd.value = document.all.vConPaswd.value; 
		document.all.qConMsg.disabled = true;
		var myPacket = new AJAXPacket("f1211ConMsg.jsp","正在获得帐户信息，请稍候......");
		//传递输入参数
		
		myPacket.data.add("pContractNo",formField.value);
		myPacket.data.add("vConPaswd",document.all.vConPaswd.value);
		core.ajax.sendPacket(myPacket);
		myPacket=null;
  }

  function f1211CheckID()
  {
        document.all.vConID.disabled = false;
        if(document.all.vQryType[0].checked) // 按照帐户查询
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
	
	if(document.all.vQryType[1].checked) // 按照证件查询
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
	
	/*if(document.all.vQryType[2].checked) // 按照客户查询
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
	
	if(document.all.vQryType[2].checked) // 按照移动号码查询
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
	if(document.all.vQryType[3].checked) // zhangyan@按预约ID查询
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
    var pageTitle = "客户ID信息查询";
    var fieldName = "客户ID|客户名称|"; 
    var selType = "S";    //'S'单选；'M'多选
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
			var checkPwd_Packet = new AJAXPacket("pubCheckPwd1211.jsp","正在进行密码校验，请稍候......");
			checkPwd_Packet.data.add("custType","01");				//01:手机号码 02 客户密码校验 03帐户密码校验
			checkPwd_Packet.data.add("phoneNo",document.all.vPhoneNo.value);	//移动号码,客户id,帐户id
			checkPwd_Packet.data.add("custPaswd",document.all.vPhonePaswd.value);//用户/客户/帐户密码
			checkPwd_Packet.data.add("idType","en");				//en 密码为密文，其它情况 密码为明文
			checkPwd_Packet.data.add("idNum","");					//传空
			checkPwd_Packet.data.add("loginNo","<%=work_no%>");		//工号
			core.ajax.sendPacket(checkPwd_Packet, doCheckPwd);
			checkPwd_Packet=null;
			
		/* } */
		
		if(scheckcustpass=="1") {
		 return false;
		}
		

   	//document.all.vConID.value="";
    //var pageTitle = "帐户ID信息查询";
    //var fieldName = "帐户ID|帐户名称|";
	//var selType = "S";    //'S'单选；'M'多选
    //var retQuence = "1|0|";
    //var retToField = "vConID|";
 

    document.all.vConID.value="";
	
    var pageTitle = "帐户ID信息查询";
    var fieldName = "帐户ID|帐户名称|"; 
    var selType = "S";    //'S'单选；'M'多选
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
			var checkPwd_Packet = new AJAXPacket("pubCheckPwd1211.jsp","正在进行密码校验，请稍候......");
			checkPwd_Packet.data.add("custType","02");				//01:手机号码 02 客户密码校验 03帐户密码校验
			checkPwd_Packet.data.add("phoneNo",document.all.vCustID.value);	//移动号码,客户id,帐户id
			checkPwd_Packet.data.add("custPaswd",document.all.vCustPaswd.value);//用户/客户/帐户密码
			checkPwd_Packet.data.add("idType","en");				//en 密码为密文，其它情况 密码为明文
			checkPwd_Packet.data.add("idNum","");					//传空
			checkPwd_Packet.data.add("loginNo","<%=work_no%>");		//工号
			core.ajax.sendPacket(checkPwd_Packet, doCheckPwd);
			checkPwd_Packet=null;
			
		/* } */
		
		if(scheckcustpass=="1") {
		 return false;
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
		 if(document.all.vPostType.value == "0") //短信
		 {
/*	2008年9月19日 应市场部需求整合短信帐单发送渠道
			if(!checkElement('vFaxNo')) return false;
*/	
		 }
		 else if(document.all.vPostType.value == "1") //邮寄
		 {
			if(!checkElement(document.all.vPostZip)) return false;
			if(!checkElement(document.all.vPostAddress)) return false;
		 }
		 else if(document.all.vPostType.value == "2")//电子邮件
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
		 rdShowMessageDialog("新密码和确认密码不等，请重新输入！");
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
 	if(document.all.vQryType[3].checked) // zhangyan@按预约ID查询
	{ 
		if (document.all.bookingId.value=="")
		{
			rdShowMessageDialog("预约ID必须填写!",0);	
			return false;
		}
	} 	
	if(!f1211CheckForm())  return false;
	
	if((document.all.vNewPaswd.value).trim().length>0)
	{
      if(document.all.vNewPaswd.value.length!=6)
	  {
         rdShowMessageDialog("新帐户密码长度有误！");
		 document.all.vNewPaswd.focus();
		 return false;
	  }
	}
/*  wangmei     add      20051105  */
	   
     if(document.all.f1211.vPayCode.options[document.all.f1211.vPayCode.selectedIndex].value=="4"){
	   if(document.all.f1211.vBankCode.value=="")
		 {rdShowMessageDialog("银行代码不能为空！");
		  document.all.vBankCode.focus();
		  return false;
	     }
	   if(document.all.f1211.vPostCode.value=="")
		 {rdShowMessageDialog("局方银行代码不能为空！");
		  document.all.vPostCode.focus();
		  return false;
	     }
	 }
	showPrtDlg("Detail","确实要进行电子免填单打印吗？","Yes"); 
	
	return true;
}

function showPrtDlg(printType,DlgMessage,submitCfm)
{  //显示打印对话框 
	var h=180;
	var w=400;
	var t=screen.availHeight/2-h/2;
	var l=screen.availWidth/2-w/2;
	
	var phoneNo="";                                            //客户电话
	var pType="subprint";                                      // 打印类型：print 打印 subprint 合并打印
	var billType="1";                                          // 票价类型：1电子免填单、2发票、3收据
	var sysAccept=<%=printAccept%>;                            // 流水号
	var printStr=printInfo(printType);                         //调用printinfo()返回的打印内容
	var mode_code=null;                                        //资费代码
	var fav_code=null;                                         //特服代码
	var area_code=null;                                        //小区代码
	var opCode="<%=opCode%>";                                  //操作代码
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
			 if(rdShowConfirmDialog('确认电子免填单吗？')==1)
			 {
			   f1211Cfm();
			 }
		}
		if(ret=="continueSub")
		{
			 if(rdShowConfirmDialog('确认要提交帐户变更信息吗？')==1)
			 {
			   f1211Cfm();
			 }
		}
		else
		{
			 if(rdShowConfirmDialog('确认要提交帐户变更信息吗？')==1)
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
		bank_name = "无";
	}else{ 
	  	bank_name = document.all.f1211.vBankCode.options[document.all.f1211.vBankCode.selectedIndex].text;
	}
	if(document.all.f1211.vPostCode.selectedIndex=="-1"){
	 	post_bank_name="无";
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
	
	cust_info+="证件号码："+document.all.vCertNum.value+"|";
	
	opr_info+="客户地址："+document.all.vPostAddress.value+"|";
	opr_info+="帐户名称："+document.all.vAcountName.value+"|";
	opr_info+="帐户 ID："+document.all.vConID.value+"|";
	
	opr_info+="办理业务："+"帐户资料变更"+"  操作流水："+"<%=printAccept%>"+"|";
	opr_info+="帐户原资料："+"银行代码名称："+document.all.bank_name.value+"  局方银行代码名称："+document.all.post_name.value+"|";
	opr_info+="帐户ID："+document.all.vConID.value+"  帐户名称："+document.all.oldvAcountName.value+"  付费方式："+document.all.pay_name.value+"|";
	opr_info+="帐户新资料："+"银行代码名称："+bank_name+"|";
	opr_info+="局方银行代码名称："+post_bank_name+"|"; 
	opr_info+="帐户ID："+document.all.vConID.value+"  帐户名称："+document.all.vAcountName.value+"  付费方式："+paytype+"|";
	
	note_info1+="备注："+"|";
	
	retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
	retInfo=retInfo.replace(new RegExp("#","gm"),"%23"); 
	return retInfo;	
}
 // 手续费检查
 function getFew()
{
  if(window.event.keyCode==13)
  {
    var fee=document.all.vPayFee;
    var fact=document.all.vRealFee;
    var few=document.all.vPayChange;
    if((fact.value).trim().length==0)
    {
	  rdShowMessageDialog("实收金额不能为空！");	
	  fact.value="";
	  fact.focus();
	  return;
    }
    if(parseFloat(fact.value)<parseFloat(fee.value))
    {
  	  rdShowMessageDialog("实收金额不足！");	
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
		 rdShowMessageDialog("非集团帐户不允许进行付费方式修改！");
		 document.all.b_print.disabled=true;
		 return false;
	}
}
/*zhangyan@add@查预约信息 b*/
function getBooingInfo()
{
	if(((document.all.bookingId.value).trim()).length<1)
	{
		rdShowMessageDialog("预约ID不能为空！");
		return;
	}		
	var myPacket = new AJAXPacket("queryBookingId.jsp","正在查询客户ID，请稍候......");
	myPacket.data.add("bookingId",(document.all.bookingId.value).trim());
	core.ajax.sendPacket(myPacket);
	myPacket = null;	
}
/*zhangyan@add@查预约信息 e*/	
</script>
<body>
<form name="f1211" method="post" action=""  onKeyUp="chgFocus(f1211);">
	<%@ include file="/npage/include/header.jsp" %>   
  	
		<div class="title">
			<div id="title_zi">客户信息</div>
		</div>
		
	<table cellspacing="0">
		<tr> 
			<td class="blue">查询类型</td>
			<td colspan="3"> 
			<input type="radio" name="vQryType" value="0" onClick="f1211.reset();this.checked=true; f1211CheckID()">帐户 
			<input type="radio" name="vQryType" value="1" onClick="f1211.reset();this.checked=true; f1211CheckID()" >证件 
			<input type="radio" name="vQryType" value="3" onClick="f1211.reset();this.checked=true; f1211CheckID()" checked >服务号码
			<input type="radio" name="vQryType" value="4" 
				onClick="f1211.reset();this.checked=true; f1211CheckID()" checked >预约ID
			</td>
		</tr>
		<tr id="idCert"> 
			<td class="blue">证件类型</td>
			<td> 
				<select name="vCertType" index="0">
				</select>
			</td>
			<td class="blue">证件号码</td>
			<td> 
				<input name="vCertNum" type="text"  v_type="string" index="1" onkeyup="if(event.keyCode==13)f1211GetCustID(vCertNum)">
				<input type="button" class="b_text" name="qCustID" value="查询客户ID" onClick="f1211GetCustID(vCertNum)">
			</td>
		</tr>
		<tr id="tr_bookingInfo" style.display="none">
			<td class="blue">预约ID</td>
			<td colspan="3"> 
			    <input id= "bookingId" name="bookingId" type="text" v_type="">
			    <font class="orange">*</font>
			    <input type="button" class="b_text" name="getBooking" value="查询预约ID"
			    	onclick="getBooingInfo()">
			</td>
		</tr>
		<tr id="idPhoneCust"> 
			<td class="blue">服务号码</td>
			<td> 
			    <input name="vPhoneNo" type="text" v_type="int" index="2">
			</td>
			<td class="blue">服务密码</td>
			<td> 
			    <input name="vPhonePaswd" type="password" v_type="0_9"  v_must="0" index="3" onkeyup="if(event.keyCode==13)f1211GetByPhone(vPhoneNo)">
			    <input type="button" class="b_text" name="qCustIdByPhone" value="查询客户ID" onClick="f1211GetByPhone(vPhoneNo)">
			</td>
		</tr>
		<tr id="idCust" style="display:none"> 
			<td class="blue">客户ID</td>
			<td> 
			  <input name="vCustID" type="text" v_type="int" index="4">
			</td>
			<td class="blue">客户密码</td>
			<td> 
			  <input name="vCustPaswd" type="password" v_type="0_9" v_must="0" index="5" onkeyup="if(event.keyCode==13)f1211GetConID(vCustID)">
			  <input type="button" class="b_text" name="qConID" value="查询帐户ID" onClick="f1211GetConID(vCustID)">
			</td>
		</tr>
		<tr> 
			<td class="blue">帐户 ID</td>
			<td> 
			  <input name="vConID" type="text"  v_must="1" v_type="int" index="6">
			</td>
			<td class="blue">帐户密码</div>
			</td>
			<td> 
			  <input name="vConPaswd" type="password" v_type="0_9"  v_must="0" index="7" onkeyup="if(event.keyCode==13)f1211GetConMsg(vConID)">
			  <input type="button" class="b_text" name="qConMsg" value="查询帐户信息" onClick="f1211GetConMsg(vConID)">
			</td>
		</tr>
	</table>
</div>

<div id="Operation_Table"> 
<div class="title">
	<div id="title_zi">账户信息</div>
</div>
	<table cellspacing="0">
		<tr> 
			<td class="blue">大客户标志</td>
			<td> 
			    <input type="text" class="InputGrey orange" name="vCardName" readonly>
			</td>
			<td class="blue">集团标志</td>
			<td> 
			    <input type="text" name="vGrpName" class="InputGrey" readonly>
			</td>
		</tr>
		<tr> 
			<td class="blue">帐户零头</td>
			<td> 
			    <input type="text" name="vCountHead" class="InputGrey" readonly>
			</td>
			<td class="blue">帐户信誉度</td>
			<td> 
			    <input type="text"  name="vCountGrand" class="InputGrey" readonly>
			</td>
		</tr>
		<tr> 
			<td class="blue">帐户预存</td>
			<td> 
			  <input type="text" name="vPrePay" class="InputGrey" readonly>
			</td>
			<td class="blue">押 金</td>
			<td> 
			  <input type="text" name="vDeposit" class="InputGrey" readonly>
			</td>
		</tr>
		<tr> 
			<td class="blue">最小欠费年月</td>
			<td> 
			    <input type="text" name="vMinYearMonth" class="InputGrey" readonly>
			</td>
			<td class="blue">欠 费</td>
			<td> 
			    <input type="text" name="vOweFee" class="InputGrey" readonly>
			</td>
		</tr>
		<tr> 
			<td class="blue">积 分</td>
			<td colspan="3"> 
			    <input type="text" name="vMark" class="InputGrey" readonly>
			</td>
		</tr>
	</table>
</div>

<div id="Operation_Table"> 
<div class="title">
	<div id="title_zi">操作信息</div>
</div>
	<table cellspacing="0">
		<tr> 
			<td class="blue">银行代码名称</td>
			<td colspan="3"> 
			    <select name="vBankCode" index="8" >
			    </select>
			</td>
		</tr>
		<tr>
			<td class="blue">局方银行代码名称</td>
			<td colspan="3"> 
			    <select name="vPostCode" index="9">
			    </select>
			</td>
		</tr>
		<tr> 
			<td class="blue">帐 号</td>
			<td> 
			    <input name="vAcountNum" type="text" v_type="string" index="10">
			    <font class="orange">*</font>
			</td>
			<td class="blue">帐户名称</td>
			<td> 
			    <input name="vAcountName" type="text" v_must="1" v_type="string" index="11">
			    <font color="orange">*</font>
			</td>
		</tr>
		<tr> 
			<td class="blue">帐户类型</td>
			<td> 
			    <select name="vCountType" onchange="chgContype()" index="12" disabled>
			    </select>
			</td>
			<td class="blue">帐户状态</td>
			<td> 
			    <select name="vCountStatus" index="13">
			    </select>
			</td>
		</tr>
		<tr> 
			<td class="blue">邮寄标志</td>
			<td> 
			    <select name="vPostFlag" class="button" index="14">
				    <option value="N">否</option>
				    <option value="Y">是</option> 
			  	</select>
			</td>
			<td class="blue">邮寄方式</td>
			<td> 
				<select name="vPostType" index="15">
				</select>
			</td>
		</tr>
		<tr> 
			<td class="blue">邮 编</td>
			<td> 
			    <input name="vPostZip" type="text" v_must="1" v_type="zip" index="16">
			</td>
			<td class="blue">邮寄地址</td>
			<td> 
			  <input type="text" v_must="1" v_type="string" name="vPostAddress" index="17">
			</td>
		</tr>
		<tr> 
			<td class="blue">传真号</td>
			<td> 
			  <input type="text" name="vFaxNo" v_must="1"  v_type="phone" index="18">
			</td>
			<td class="blue">E_Mail地址</td>
			<td> 
			  <input type="text"  id="vMailAddress"  name="vMailAddress" v_must="1" v_type="email" index="19">
			</td>
		</tr>
		<tr> 
			<td class="blue">付款方式</td>
			<td colspan="3"> 
			    <select name="vPayCode" class="button" onchange="chgpaytype()" index="20">
			    </select>
			</td>
		</tr>
		<tr> 
			<td class="blue">同时更新客户姓名资料</td>
			<td colspan="3"> 
				<input type="radio" name="vDocFlag" value="0" checked>是
				<input type="radio" name="vDocFlag" value="1">否
			</td>
		</tr>
		<tr style="display:none"> 
			<td class="blue">新帐户密码</td>
			<td> 
			    <input name="vNewPaswd" v_type="0_9"  type="password" index="21" v_maxlength=6 v_must=0>
			</td>
			<td class="blue">确认密码</td>
			<td> 
			    <input name="vCfmPaswd"  v_must=0 v_type="0_9"  type="password" index="22" v_maxlength=6>
			</td>
		</tr>
	
		<tr> 
			<td class="blue">手续费</td>
			<td> 
			    <input name="vPayFee" type="text" value="<%=tmpHandFee%>"  v_minlength="1" v_maxlength="12" v_must=1 v_type="cfloat" index="23" size="20">
			</td>
			<td class="blue"> 
				<div align="left">实收 
					<input name="vRealFee" type="text"  onKeyUp="getFew()" index="24">
				</div>
			</td>
			<td class="blue">
				<div align="left">找零 
					<input name="vPayChange" type="text" value="0" class="InputGrey" readonly>
				</div>
			</td>
		</tr>
		<tr> 
			<td class="blue">备注</td>
			<td colspan="3"> 
			    <input name="vSysNote" type="text" size="40" class="InputGrey" readonly>
			</td>
		</tr>
	</table>
	<!-- ningtn 2011-8-4 10:28:18 扩大电子工单 -->
<jsp:include page="/npage/public/hwReadCustCard.jsp">
	<jsp:param name="hwAccept" value="<%=printAccept%>"  />
	<jsp:param name="showBody" value="01"  />
	<jsp:param name="sopcode" value="<%=opCode%>"  />
</jsp:include>
	<table>
		<tr> 
			<td id="footer" colspan="4"> 
				<div align="center"> 
					<input class="b_foot" type="button" name="b_print" value="确认&打印"  
						onClick="printCommit()" index="26">
					<input class="b_foot" type="button"  name="b_clear" value="清除" index="27" onclick="f1211.reset();">
					<input class="b_foot" type="button" name="b_back" value="返回"  onClick="removeCurrentTab()" index="28">
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
<!-- ningtn 2011-7-12 08:35:36 电子化工单扩大范围 -->
<%@ include file="/npage/public/hwObject.jsp" %> 
<script language="JavaScript">
	function fillSelect()
	{		
<% 
	  //最终修改区-------------------
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

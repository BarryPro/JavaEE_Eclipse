<%
/********************
 version v2.0
 开发商: si-tech
 update hejw@2009-1-16
********************/
%> 

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

	
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>  
<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>
<%@ page import="org.apache.log4j.Logger"%>
<%@ page import="com.sitech.boss.pub.*" %>
<%@ page import="java.util.StringTokenizer"%>
<%@ page import="com.sitech.boss.s1900.config.productCfg" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.GregorianCalendar" %>

<%@ include file="../../include/remark.htm" %>

<%
	String opCode = request.getParameter("opCode");
	String opName = request.getParameter("opName");
	String flag ="";
	String flag1 ="";
	String flag2 ="";
	if(opCode.equals("3702")){
		flag="selected";
	}else if(opCode.equals("3704")){
		flag1="selected";	
	}else{
	  flag2="selected";
	}
%>


<%
Logger logger = Logger.getLogger("s3702.jsp");

String ipAddress = (String)session.getAttribute("ipAddr");
String loginNo = (String)session.getAttribute("workNo");
String workname = (String)session.getAttribute("workName");
String orgCode = (String)session.getAttribute("orgCode");
String loginPwd  = (String)session.getAttribute("password");
String regionCode = (String)session.getAttribute("regCode");


Date date = new Date();
SimpleDateFormat df = new SimpleDateFormat("yyyyMM");
GregorianCalendar gc = new GregorianCalendar();
gc.setTime(date); 
gc.add(2,1);
gc.set(gc.get(gc.YEAR),gc.get(gc.MONTH),gc.get(gc.DATE));
String beginDate=df.format(gc.getTime())+"01";
gc.add(1,1);
String endDate=df.format(gc.getTime())+"01";
System.out.println("xxxxxxxxxxxxxxxx"+beginDate);
System.out.println("xxxxxxxxxxxxxxxx"+endDate);

String dateStr = new java.text.SimpleDateFormat("yyyyMMdd").format(new java.util.Date());//wuxy add 20090207

%>
<html xmlns="http://www.w3.org/1999/xhtml">
<HEAD>
	<TITLE>统一付费成员管理</TITLE>
</HEAD>
<SCRIPT type=text/javascript>

//锁屏
function ajaxSubmit(){
	$.ajax({
		type: "POST",
		url: "s3702_2.jsp",
		beforeSend:function(XMLHttpRequest){
				loading();
			},
		data:"opCode="+document.frm.opCode.value+"&"+
		"opName="+document.frm.opName.value+"&"+
		"loginAccept="+document.frm.loginAccept.value+"&"+
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
		"allPayFlag="+document.frm.allPayFlag.value+"&"+
		"allFlag="+document.frm.allFlag.value+"&"+
		"cycleMoney="+document.frm.cycleMoney.value+"&"+
		"beginDate="+document.frm.beginDate.value+"&"+
		"endDate="+document.frm.endDate.value,
	
		success: function(data, textStatus){
			$("body").html(data);
			$("body").html();
	  	}
	});
}

function OpCodeChange()
{
	if (document.frm.opCode.value == "3702")
	{
		document.frm.sysNote.value="集团BOSS优惠批量成员用户开户";
		document.frm.opNote.value="集团BOSS优惠批量成员用户开户";
		document.all.allPayFlag.value="1";
		changePayFlag();
		document.all.line_0.style.display="";
		document.frm.opName.value="统一付费成员管理";
		getBeforePrompt(document.frm.opCode.value);
		var a=document.all.allPayFlag;
		var b=document.all.allFlag;
		a.remove(0);
		b.remove(0);
		a.remove(1);
		b.remove(1);
		var   o1=document.createElement('option');   
  	o1.text="统付";   
 		o1.value="1";   
  	a.add(o1); 
  	var   o2=document.createElement('option');   
  	o2.text="按账目项统付";   
 		o2.value="0";   
  	a.add(o2); 
		
  	
	  var  p1=document.createElement('option');   
  	p1.text="定额交费";   
 		p1.value="0";  
 		b.add(p1);
 		var  p2=document.createElement('option');   
  	p2.text="全额交费";   
 		p2.value="1";  
 		b.add(p2);
	}
	else if (document.frm.opCode.value == "3704")
	{
		document.frm.sysNote.value="集团BOSS优惠成员用户销户";
		document.frm.opNote.value="集团BOSS优惠成员用户销户";
		document.all.allPayFlag.value="0";
		changePayFlag();
		document.all.line_0.style.display="none";
		document.frm.opName.value="统一付费成员管理(删除) ";
		getBeforePrompt(document.frm.opCode.value);
	}
	else if (document.frm.opCode.value == "3605")
	{
		document.frm.sysNote.value="BOSS侧VPMN成员用户套餐变更";
		document.frm.opNote.value="BOSS侧VPMN成员用户套餐变更";
		document.frm.opName.value="BOSS侧VPMN成员管理(套餐变更)";
		getBeforePrompt(document.frm.opCode.value);
	}else if(document.frm.opCode.value == "3318"){
		document.frm.sysNote.value="集团BOSS优惠批量成员用户开户";
		document.frm.opNote.value="集团BOSS优惠批量成员用户开户";
		document.all.allPayFlag.value="1";
		changePayFlag();
		document.all.line_0.style.display="";
		document.frm.opName.value="统一付费成员管理";
		getBeforePrompt(document.frm.opCode.value);
		var a=document.all.allPayFlag;
		//a.remove(0);
		a.remove(1);
		var b=document.all.allFlag;
		//b.remove(0);
		b.remove(1);
		//var   o1=document.createElement('option');   
  	//o1.text="统付";   
 		//o1.value="1";   
  	//a.add(o1); 
	  //var  p1=document.createElement('option');   
  	//p1.text="定额交费";   
 		//p1.value="0";  
 		//b.add(p1);
	}
	ChgCurrStep("custQuery");
}

function ChgCurrStep(currStep)
{
	if (currStep == "custQuery")
	{
		document.frm.custQuery.disabled = false;
		document.frm.chkGrpPwd.disabled = true;
		//document.frm.qryPhone.disabled = true;
		//document.frm.chkUserPwd.disabled = true;
		//document.frm.doSubmit.disabled = false;
	}
	else if (currStep == "chkGrpPwd")
	{
		document.frm.custQuery.disabled = false;
		document.frm.chkGrpPwd.disabled = false;
		//document.frm.qryPhone.disabled = true;
		//document.frm.chkUserPwd.disabled = true;
		//document.frm.doSubmit.disabled = false;
	}
	else if (currStep == "qryPhone")
	{
		document.frm.custQuery.disabled = false;
		document.frm.chkGrpPwd.disabled = false;
		//document.frm.qryPhone.disabled = false;
		//document.frm.chkUserPwd.disabled = true;
		//document.frm.doSubmit.disabled = false;
	}
	else if (currStep == "chkUserPwd")
	{
		document.frm.custQuery.disabled = false;
		document.frm.chkGrpPwd.disabled = false;
		//document.frm.qryPhone.disabled = false;
		//document.frm.chkUserPwd.disabled = false;
		//document.frm.doSubmit.disabled = false;
	}
	else if (currStep == "doSubmit")
	{
		document.frm.custQuery.disabled = false;
		document.frm.chkGrpPwd.disabled = false;
		//document.frm.qryPhone.disabled = false;
		//document.frm.chkUserPwd.disabled = false;
		//document.frm.doSubmit.disabled = false;
	}
}

function doProcess(packet)
{
	var retType = packet.data.findValueByName("retType");
	var retCode = packet.data.findValueByName("retCode");
	var retMessage = packet.data.findValueByName("retMessage");
	self.status="";
	if(retType == "checkPwd") //集团客户密码校
	{
		if(retCode == "000000")
		{
			var retResult = packet.data.findValueByName("retResult");
			if (retResult == "false")
			{
				ChgCurrStep("chkGrpPwd");
				frm.grpPwd.value = "";
				frm.grpPwd.focus();
				rdShowMessageDialog(retMessage);
				return false;
			}
			else
			{
				ChgCurrStep("qryPhone");
				rdShowMessageDialog("客户密码校验成功！",2);
				document.all.doSubmit.disabled=false;
			}
		}
		else
		{
			rdShowMessageDialog(retMessage+retCode,0);
			return false;
		}
	}

	if(retType == "chkUserPwd") //集团用户密码校
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
				rdShowMessageDialog("用户密码校验成功！");
				document.all.doSubmit.disabled=false;
			}
		}
		else
		{
			rdShowMessageDialog("用户密码校验出错，请重新校验！");
			return false;
		}
	}

	//取流水
	if(retType == "getSysAccept")
	{
		if(retCode == "000000")
		{
			var sysAccept = packet.data.findValueByName("sysAccept");
			document.frm.loginAccept.value=sysAccept;
			showPrtDlg("Detail","确实要打印电子免填单吗？","Yes");
			if (rdShowConfirmDialog("是否提交确认操作？")==1)
			{	
				 //return true;
				 ajaxSubmit()
			}
			else return false;
		}
		else
		{
			rdShowMessageDialog("查询流水出错,请重新获取！");
			return false;
		}
	}
	if(retType == "QryPhoneInfo") //集团客户密码校
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
				document.frm.mainRate.value=packet.data.findValueByName("mainRate");
				document.frm.mainRateName.value=packet.data.findValueByName("mainRateName");
				ChgCurrStep("chkUserPwd");
				rdShowMessageDialog("取用户信息成功！");
			}
		}
		else
		{
			rdShowMessageDialog(retMessage+retCode,0);
			return false;
		}
	}
}


//调用公共界面，进行集团客户选择
function getInfo_Cust()
{
	var pageTitle = "集团客户选择";
	var fieldName = "证件号码|集团客户ID|集团产品ID|集团用户编码|集团编号|集团产品名称|集团名称|";
	var sqlStr = "";
	var selType = "S";    //'S'单选；'M'多选
	var retQuence = "7|0|1|2|3|4|5|6|";
	var retToField = "idIccid|custId|grpIdNo|grpOutNo|unitId|smName|grpName|";
	var custId = document.frm.custId.value;

	if(document.frm.idIccid.value == "" &&
	document.frm.custId.value == "" &&
	document.frm.unitId.value == "" &&
	document.frm.grpOutNo.value == "")
	{
		rdShowMessageDialog("请输入证件号码、集团客户客户ID、集团编号或集团用户编号进行查询！",0);
		document.frm.idIccid.focus();
		return false;
	}

	if(document.frm.custId.value != "" && forNonNegInt(frm.custId) == false)
	{
		frm.custId.value = "";
		rdShowMessageDialog("必须是数字！",0);
		return false;
	}

	if(document.frm.unitId.value != "" && forNonNegInt(frm.unitId) == false)
	{
		frm.unitId.value = "";
		rdShowMessageDialog("必须是数字！",0);
		return false;
	}

	if(document.frm.grpOutNo.value == "0")
	{
		frm.grpOutNo.value = "";
		rdShowMessageDialog("集团用户编号不能为0！",0);
		return false;
	}

	PubSimpSelCust(pageTitle,fieldName,sqlStr,selType,retQuence,retToField);
}

function PubSimpSelCust(pageTitle,fieldName,sqlStr,selType,retQuence,retToField)
{
	var path = "/npage/s3700/fpubgrpusr_sel3702.jsp";
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
	var retToField = "idIccid|custId|grpIdNo|grpOutNo|unitId|smName|grpName|";
	if(retInfo ==undefined)      
	{
		ChgCurrStep("custQuery");
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
	ChgCurrStep("chkGrpPwd");
}

function check_HidPwd()
{
	var grpIdNo = document.frm.grpIdNo.value;
	var inPwd = document.frm.grpPwd.value;
	var checkPwd_Packet = new AJAXPacket("/npage/s3600/pubCheckPwd.jsp","正在进行密码校验，请稍候......");
	checkPwd_Packet.data.add("retType","checkPwd");
	checkPwd_Packet.data.add("GRP_ID",grpIdNo);
	checkPwd_Packet.data.add("inPwd",inPwd);
	core.ajax.sendPacket(checkPwd_Packet);
	checkPwd_Packet = null;

}

function ChkUserPwd()
{
	var checkPwd_Packet = new AJAXPacket("/npage/s3600/pubCheckPwd.jsp","正在进行密码校验，请稍候......");
	checkPwd_Packet.data.add("retType","chkUserPwd");
	checkPwd_Packet.data.add("ID_NO",document.frm.idNo.value);
	checkPwd_Packet.data.add("inPwd",document.frm.userPwd.value);
	core.ajax.sendPacket(checkPwd_Packet);
	checkPwd_Packet = null;
}

function QryPhoneInfo()
{
	if (checkElement("phoneNo"))
	{
		document.frm.phoneNo.focus();
	}
	var checkPwd_Packet = new AJAXPacket("/npage/s3600/getPhoneInfo.jsp","正在进行密码校验，请稍候......");
	checkPwd_Packet.data.add("retType","QryPhoneInfo");
	checkPwd_Packet.data.add("loginNo","<%=loginNo%>");
	checkPwd_Packet.data.add("phoneNo",document.frm.phoneNo.value);
	checkPwd_Packet.data.add("opCode",document.frm.opCode.value);
	checkPwd_Packet.data.add("grpIdNo",document.frm.grpIdNo.value);
	core.ajax.sendPacket(checkPwd_Packet);
	checkPwd_Packet =null;
}

//打印信息
	 function printInfo(printType)
	 { 
		var retInfo = "";
		var tmpOpCode=document.all.opCode.value;
		if (tmpOpCode=="3702" || tmpOpCode=="3704")
		{
			retInfo+='<%=workname%>'+"|";
    		retInfo+='<%=new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss", Locale.getDefault()).format(new java.util.Date())%>'+"|";
    		retInfo+="身份证号:"+document.frm.idIccid.value+"|";
    		retInfo+="用户名称:"+document.frm.grpName.value+"|";
    		retInfo+="集团用户编码:"+document.frm.grpOutNo.value+"|";
    		retInfo+=""+"|";
    	    retInfo+=""+"|";
    	    retInfo+=""+"|";
    	    retInfo+=""+"|";
    	    retInfo+=""+"|";
    	retInfo+=""+"|";
    	retInfo+=""+"|";
    	retInfo+=""+"|";
    	retInfo+=""+"|";
    	retInfo+=""+"|";
    	retInfo+=""+"|";
    	retInfo+=""+"|";
    	retInfo+=""+"|";
    	retInfo+=""+"|";
    	retInfo+=""+"|";  
    	retInfo+="业务类型"+document.frm.opCode.options[document.frm.opCode.selectedIndex].text+"|";
    	retInfo+="流水"+document.frm.loginAccept.value+"|";
    	retInfo+=""+"|";
    	retInfo+=""+"|";
    	retInfo+=""+"|";
    	retInfo+=""+"|";
    	retInfo+=""+"|";
    	retInfo+=""+"|";
    	retInfo+=document.frm.sysNote.value+"|";
    	retInfo+=document.all.simBell.value+"|";
		 return retInfo;
	 }
	 }

//显示打印对话框
function showPrtDlg(printType,DlgMessage,submitCfm)
{
	var h=163;
	var w=375;
	var t=screen.availHeight/2-h/2;
	var l=screen.availWidth/2-w/2;
	var printStr = printInfo(printType);
	if(printStr == "failed")
	{
		return false;
	}
	var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no"
	var path = "/npage/innet/hljPrint.jsp?DlgMsg=" + DlgMessage;
	var path = path + "&printInfo=" + printStr + "&submitCfm=" + submitCfm;
	var ret=window.showModalDialog(path,"",prop);
}


function QryNewRate()
{
    var pageTitle = "集团费率信息查询";
    var fieldName = "集团费率代码|集团费率名称|";

	if (document.frm.grpIdNo.value == "")
	{
		rdShowMessageDialog("集团代码不能为空！");
		return false;
	}
	var sqlStr =	 "SELECT b.mode_code, b.mode_name"
				+"  FROM dGrpUserMsgAdd a, sBillModeCode b"
				+" WHERE trim(a.field_value) = b.mode_code"
				+"   AND id_no = " + document.frm.grpIdNo.value
				+"   AND b.region_code = '" + "<%=regionCode%>" + "'"
				+"   AND a.field_code = any('10000', '10001')"
				+" ORDER BY b.mode_code";
    
    var selType = "S";    //'S'单选；'M'多选
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

//取流水
function getSysAccept()
{
	var getSysAccept_Packet = new AJAXPacket("pubSysAccept.jsp","正在生成操作流水，请稍候......");
	getSysAccept_Packet.data.add("retType","getSysAccept");
	core.ajax.sendPacket(getSysAccept_Packet);
	getSysAccept_Packet = null;
}

function refMain()
{
	getAfterPrompt(document.frm.opCode.value);
	if (document.frm.opCode.value=="3702"||document.frm.opCode.value=="3318")
		if (document.frm.allPayFlag.value == "1")
		{
			if (document.frm.cycleMoney.value == "")
			{
				rdShowMessageDialog("请输入定额金额");
				document.frm.cycleMoney.focus();
				return false;
			}
			if (!forMoney(document.frm.cycleMoney))
			{
				document.frm.cycleMoney.focus();
				return false;
			}
			if (document.frm.beginDate.value == "" || document.frm.endDate.value == "")
			{
				rdShowMessageDialog("请输入开始日期和结束日期");
				document.frm.allFlag.focus();
				return false;
			}
			if (!forDate(document.all.beginDate))
			{
					document.all.beginDate.focus();
					return false;
			}
			if (!forDate(document.all.endDate))
			{
					document.all.endDate.focus();
					return false;
			}
			
			//wuxy add 20090207 用于限制开始日期必选大于当前日期
			if(parseInt(document.all.yearmonth.value)>parseInt(document.all.beginDate.value))
			{
				rdShowMessageDialog("开始日期应大于等于当前日期"+document.all.yearmonth.value,0);
				return false;
			}
			
			if(document.all.beginDate.value>document.all.endDate.value)
			{
				rdShowMessageDialog("开始日期不允许比结束日期晚");
				document.all.beginDate.focus();
				return false;
			}
		}
	
	if(  document.frm.phoneNo.value == "" )
	{
		rdShowMessageDialog("请输入手机号码");
		document.frm.phoneNo.focus();
		return false;
	}
	
	if(  document.frm.grpIdNo.value == "" )
	{
		rdShowMessageDialog("集团产品ID不能为空!!");
		document.frm.idIccid.select();
		return false;
	}
	
	if (document.frm.opCode.value == "3605")
	{
		if (document.frm.newRate.value == document.frm.mainRate.value ||document.frm.newRate.value=="")
		{
			rdShowMessageDialog("新费率不能为空，新旧费率也不能相同!");
			document.frm.newRate.focus();
			return false;
		}
	}
	getSysAccept();
	//wuxy alter 20090826 为解决确定、取消都提交问题
	//ajaxSubmit();
	
}

function changeFlag(){
	if(document.all.allFlag.value=="1"){
		document.all.line_111.style.display="none";
		document.all.cycleMoney.value="0";
	}
	else{
		document.all.line_111.style.display="";
		document.all.cycleMoney.value="";
	}
}

function changePayFlag(){
	if(document.all.allPayFlag.value=="0")
	{
		document.all.line_111.style.display="none";
		document.all.line_1.style.display="none";
		document.all.line_2.style.display="none";
	}
	else
	{
		document.all.line_111.style.display="";
		document.all.line_1.style.display="";
		document.all.line_2.style.display="";
	}
}
	function getBeforePrompt(opCode)
	{
		var packet = new AJAXPacket("/npage/include/getBeforePrompt.jsp","请稍后...");
		packet.data.add("opCode" ,opCode);
	  core.ajax.sendPacketHtml(packet,doGetBeforePrompt,true);//异步
		packet =null;
	}
	
	function doGetBeforePrompt(data)
	{
		$('#wait').hide();
		$('#beforePrompt').html(data);
	}
	
	function getAfterPrompt(opCode)
	{
		var packet = new AJAXPacket("/npage/include/getAfterPrompt.jsp","请稍后...");
		packet.data.add("opCode" ,opCode);
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
</script>
<BODY onload="getBeforePrompt(<%=opCode%>)">
	<div id ="loadpage"></div>
	<FORM action="" method="post" name="frm" >
		<%@ include file="/npage/include/header.jsp" %>
		<input type="hidden" name="loginAccept"  value="0"> <!-- 操作流水号 -->
		<input type="hidden" name="loginNo"  value="<%=loginNo%>">
		<input type="hidden" name="loginPwd"  value="<%=loginPwd%>">
		<input type="hidden" name="smName"  value="">
		<input type="hidden" name="grpName"  value="">
		<input type="hidden" name="orgCode"  value="<%=orgCode%>">
		<input type="hidden" name="ipAddress"  value="<%=ipAddress%>">
		<input type="hidden" name="opName"  value="<%=opName%>">
			<input type="hidden" name="yearmonth"  value="<%=dateStr%>"><!-- wuxy add 20090207 -->
	<div class="title">
		<div id="title_zi">统一付费成员管理</div>
	</div>
	<div id="results"></div>
						<TABLE cellSpacing="0">
							<TR>
								<TD class="blue">
									<div align="left">操作类型</div>
								</TD>
								<TD colspan="3">
									<SELECT name="opCode"  id="opCode" onChange="OpCodeChange()">
										<option value="3702" <%=flag%>>批量成员开户</option>
										<option value="3318" <%=flag2%>>批量成员修改(统付类)</option>
										<option value="3704" <%=flag1%>>批量成员销户</option>
									</SELECT>
									<font class="orange">*</font>
								</TD>
							</TR>
							<TR>
								<TD  class="blue">
									<div align="left">证件号码</div>
								</TD>
								<TD>
									<input name="idIccid"  id="idIccid" size="24" maxlength="18" v_type="string" v_must=1  index="1" value="">
									<input name=custQuery type=button id="custQuery"  onMouseUp="getInfo_Cust();" onKeyUp="if(event.keyCode==13)getInfo_Cust();" style="cursorhand" value=查询 class="b_text">
									<font class="orange">*</font>
								</TD>
								<TD  class="blue">集团客户ID</TD>
								<TD>
									<input  type="text" name="custId" size="20" maxlength="18" v_type="0_9" v_must=1  index="2" value="">
									<font class="orange">*</font>
								</TD>
							</TR>
							<TR>
								<TD class="blue">
									<div align="left">集团编号</div>
								</TD>
								<TD>
									<input name=unitId  id="unitId" size="24" maxlength="10" v_type="0_9" v_must=1  index="3" value="">
									<font class="orange">*</font>
								</TD>
								<TD class="blue">集团用户编号</TD>
								<TD>
									<input  name="grpOutNo" size="20" v_must=1 v_type=string  index="4" value="">
									<font class="orange">*</font>
								</TD>
							</TR>
							<TR>
								<TD class="blue">集团产品ID</TD>
								<TD COLSPAN="1">
									<input  name="grpIdNo" size="20" readonly v_must=1 v_type=string  index="4" value="">
									<font class="orange">*</font>
								</TD>
								<TD class="blue">集团客户密码</TD>
								<TD colspan="1">
									<jsp:include page="/npage/common/pwd_1.jsp">
									<jsp:param name="width1" value="16%"  />
									<jsp:param name="width2" value="34%"  />
									<jsp:param name="pname" value="grpPwd"  />
									<jsp:param name="pwd" value=""  />
									</jsp:include>

									<input name=chkGrpPwd type=button onClick="check_HidPwd();"  style="cursorhand" id="chkGrpPwd" value=校验 class="b_text">
									<font class="orange">*</font>
								</TD>
							</TR>
							<TR>
								<TD class="blue">手机号码</TD>
								<TD colspan="1">
								<textarea cols=30 rows=8 name="phoneNo" style="overflow:auto" v_must=1 v_minlength="11" v_maxlength="15" v_type="string"  index="8"></textarea>
								

								</TD>
								<TD><br>注批量增加手机号码时,请用"|"作为分隔<br>
								符,并且最后一个号码也请用"|"作为结束.<br>
								例如：13900000000|<br>
								&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;13900000001|<br></TD>
								<TD>&nbsp;</TD>
								
							</TR>
            <TR id="line_0"> 		
			    <TD class="blue">统付标志</TD>
	            <TD  colspan=3>	              	
	            	<select name="allPayFlag" onchange="changePayFlag()">	 
	              	<!--<option value="0">统付</option> -->
	              	<option value="1">按账目项付费</option>
	              	</select>&nbsp;<font class="orange">*</font>
	            </TD>
	          </TR> 
            <TR id="line_1"> 		
			    <TD class="blue">全额标志</TD>
	            <TD colspan=3>	              	
	            	<select name="allFlag" onchange="changeFlag()">
	            			<!--<option value="0">定额交费</option>  -->
	              		<option value="1">全额交费</option>           		
	              	</select>&nbsp;<font class="orange">*</font>
	            </TD>
	          </TR> 
	         <TR id="line_111">    	              
	            <TD class="blue">定额金额</TD>
	            <TD colspan=3>
	              	<input type="text"  v_type="money"  v_must="1" v_minlength="1" v_maxlength="14"   name="cycleMoney" maxlength="14">&nbsp;<font class="orange">*</font>
	            </TD>
	         </TR>
	         
	         <TR id="line_2"> 
				<TD class="blue">开始日期</TD>
	            <TD height = 20>
	              	<input type="text"  name="beginDate" maxlength="8" value="<%=dateStr%>" v_type="date"  v_must="1" v_format="yyyyMMdd">
	              	&nbsp;(格式:yyyymmdd)&nbsp;<font class="orange">*</font>            	
	            </TD> 			
			    <TD class="blue">结束日期</TD>
	            <TD height = 20>
	              	<input type="text" name="endDate" maxlength="8" value="<%=endDate%>" v_type="date"  v_must="1"  v_format="yyyyMMdd">
	              	&nbsp;(格式:yyyymmdd)&nbsp;<font class="orange">*</font>  
	            </TD> 		            	              
	         </TR>
									<input  name="sysNote" size="60" value="BOSS统一优惠成员管理" readonly type="hidden"> 
							<TR>
								<TD  class="blue">用户备注</TD>
								<TD colspan="3">
									<input  name="opNote" size="60" value="BOSS统一优惠成员管理" class="InputGrey">
								</TD>
							</TR>
						</TABLE>
						<TABLE cellSpacing="0">
							<TR>
								<TD align=center>
									<input name="doSubmit" type=button value="确认" onclick="refMain()" disabled class="b_foot">
									<input name="reset1"  onClick="" type=reset value="清除" class="b_foot">
									<input name="kkkk"  onClick="removeCurrentTab()" type=button value="关闭" class="b_foot">
								</TD>
							</TR>
						</TABLE>
	<div id="relationArea" style="display:none"></div>
				<div id="wait" style="display:none">
				<img  src="/nresources/default/images/blue-loading.gif" />
			</div>
			<div id="beforePrompt"></div>
		</DIV>   
</DIV>		
		<jsp:include page="/npage/common/pwd_comm.jsp"/>
			
<%@ include file="/npage/include/footer_simple.jsp" %>
	</FORM>
<script language="JavaScript">
	document.frm.idIccid.focus();
	ChgCurrStep("custQuery");
	OpCodeChange();
</script>
</BODY>
</HTML>

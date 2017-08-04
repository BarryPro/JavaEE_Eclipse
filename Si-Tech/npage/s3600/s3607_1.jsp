<!DOCTYPE html PUBLIC "-//W3C//Dtd Xhtml 1.0 transitional//EN" "http://www.w3.org/tr/xhtml1/Dtd/xhtml1-transitional.dtd">
<%
/********************
 version v2.0
 开发商: si-tech
 update hejw@2009-1-20
********************/
%>
<%
  String opCode = "3607";
  String opName = "BOSS侧VPMN批量成员管理";
%>
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>     
<%@ page import="org.apache.log4j.Logger"%>
<%@ page import="com.sitech.boss.pub.*" %>
<%@ include file="../../include/remark.htm" %>


<%
	Logger logger = Logger.getLogger("s3607_1.jsp");
	
	String ipAddress = (String)session.getAttribute("ipAddr");
	String loginNo = (String)session.getAttribute("workNo");
	String workname = (String)session.getAttribute("workName");
	String orgCode = (String)session.getAttribute("orgCode");
	String loginPwd  = (String)session.getAttribute("password");
	String regionCode = (String)session.getAttribute("regCode");
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<HEAD>
	<TITLE>BOSS侧VPMN批量成员用户开户</TITLE>
</HEAD>
<SCRIPT type=text/javascript>
	
//锁屏
function ajaxSubmit(){
	$.ajax({
		type: "POST",
		url: "s3607_2.jsp",
		beforeSend:function(XMLHttpRequest){
				loading();
			},

			data:"loginAccept="+document.frm.loginAccept.value+"&"+
           "opCode="+document.frm.opCode.value+"&"+
           "loginNo="+document.frm.loginNo.value+"&"+
           "loginPwd="+document.frm.loginPwd.value+"&"+
           "orgCode="+document.frm.orgCode.value+"&"+
           "sysNote="+document.frm.sysNote.value+"&"+
           "opNote="+document.frm.opNote.value+"&"+
           "ipAddress="+document.frm.ipAddress.value+"&"+
           "phoneNo="+document.frm.phoneNo.value+"&"+
           "grpIdNo="+document.frm.grpIdNo.value+"&"+
           "grpOutNo="+document.frm.grpOutNo.value+"&"+
           "unitId="+document.frm.unitId.value,
           
		success: function(data, textStatus){
			$("body").html(data);
			$("body").html();
	  	}
	});
}

function OpCodeChange()
{
	if (document.frm.opCode.value == "3607")
	{
		document.frm.sysNote.value="BOSS侧VPMN批量成员用户开户";
		document.frm.opNote.value="BOSS侧VPMN批量成员用户开户";
	}
	else if (document.frm.opCode.value == "3604")
	{
		document.frm.sysNote.value="BOSS侧VPMN成员用户销户";
		document.frm.opNote.value="BOSS侧VPMN成员用户销户";
	}
	else if (document.frm.opCode.value == "3605")
	{
		document.frm.sysNote.value="BOSS侧VPMN成员用户套餐变更";
		document.frm.opNote.value="BOSS侧VPMN成员用户套餐变更";
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
		document.frm.doSubmit.disabled = false;
	}
	else if (currStep == "chkGrpPwd")
	{
		document.frm.custQuery.disabled = false;
		document.frm.chkGrpPwd.disabled = false;
		//document.frm.qryPhone.disabled = true;
		//document.frm.chkUserPwd.disabled = true;
		document.frm.doSubmit.disabled = false;
	}
	else if (currStep == "qryPhone")
	{
		document.frm.custQuery.disabled = false;
		document.frm.chkGrpPwd.disabled = false;
		//document.frm.qryPhone.disabled = false;
		//document.frm.chkUserPwd.disabled = true;
		document.frm.doSubmit.disabled = false;
	}
	else if (currStep == "chkUserPwd")
	{
		document.frm.custQuery.disabled = false;
		document.frm.chkGrpPwd.disabled = false;
		//document.frm.qryPhone.disabled = false;
		//document.frm.chkUserPwd.disabled = false;
		document.frm.doSubmit.disabled = false;
	}
	else if (currStep == "doSubmit")
	{
		document.frm.custQuery.disabled = false;
		document.frm.chkGrpPwd.disabled = false;
		//document.frm.qryPhone.disabled = false;
		//document.frm.chkUserPwd.disabled = false;
		document.frm.doSubmit.disabled = false;
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
				rdShowMessageDialog("客户密码校验成功！");
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
//				page = "s3607_2.jsp";
//				frm.action=page;
//				frm.method="post";
//				frm.submit();
					//return true;
					ajaxSubmit();
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
				//document.frm.userPwd.value=packet.data.findValueByName("userPwd");
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
	var fieldName = "证件号码|集团客户ID|集团用户ID|集团用户编码|集团ID|集团产品名称|成员设定费率|成员设定费率名称|";
	var sqlStr = "";
	var selType = "S";    //'S'单选；'M'多选
	var retQuence = "8|0|1|2|3|4|5|6|7|";
	var retToField = "idIccid|custId|grpIdNo|grpOutNo|unitId|unitName|mainRate|mainRateName|";
	var custId = document.frm.custId.value;

	if(document.frm.idIccid.value == "" &&
	document.frm.custId.value == "" &&
	document.frm.unitId.value == "" &&
	document.frm.grpOutNo.value == "")
	{
		rdShowMessageDialog("请输入身份证号、客户ID、集团ID或集团用户编号进行查询！",0);
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
	var path = "/npage/s3600/fpubgrpusr_sel.jsp";
	path = path + "?sqlStr=" + sqlStr + "&retQuence=" + retQuence;
	path = path + "&fieldName=" + fieldName + "&pageTitle=" + pageTitle;
	path = path + "&selType=" + selType+"&idIccid=" + document.all.idIccid.value;
	path = path + "&custId=" + document.all.custId.value;
	path = path + "&unitId=" + document.all.unitId.value;
	path = path + "&grpOutNo=" + document.all.grpOutNo.value;
	path = path + "&regionCode=" + document.all.regionCode.value;

	retInfo = window.open(path,"newwindow","height=450, width=830,top=50,left=100,scrollbars=yes, resizable=no,location=no, status=yes");

	return true;
}

function getvaluecust(retInfo)
{
	var retToField = "idIccid|custId|grpIdNo|grpOutNo|unitId|unitName|mainRate|mainRateName|";
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
	checkPwd_Packet = null;
}

//打印信息
	 function printInfo(printType)
	 { 
		var retInfo = "";
		//var tmpOpCode=document.all.opCode.value;
		//if (tmpOpCode=="3605")
		//{
			retInfo+='<%=workname%>'+"|";
  		retInfo+='<%=new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(Calendar.getInstance().getTime())%>'+"|";
  		retInfo+="证件号码:"+document.frm.idIccid.value+"|";
  		retInfo+="集团编码:"+document.frm.grpOutNo.value+"|";
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
    	retInfo+=""+"|";
    	retInfo+="办理业务"+"BOSS侧VPMN成员用户开户"+"|";
    	retInfo+="增加手机号码:"+(document.all.phoneNo.value).replace(/\|/g,",")+"|";  
    	retInfo+="成员设定费率"+document.frm.mainRate.value+"->"+document.frm.mainRateName.value+"|";
    	retInfo+="流水"+document.frm.loginAccept.value+"|";
    	retInfo+=""+"|";
    	retInfo+=""+"|";
    	retInfo+=""+"|";
    	retInfo+=""+"|";
    	retInfo+=document.frm.sysNote.value+"|";
    	retInfo+=document.all.simBell.value+"|";
    	retInfo+=""+"|";
		 return retInfo;
	 //}
	 }

//显示打印对话框
function showPrtDlg(printType,DlgMessage,submitCfm)
{
	var h=180;
	var w=350;
	var t=screen.availHeight/2-h/2;
	var l=screen.availWidth/2-w/2;
	var printStr = printInfo(printType);
	//wuxy alter 20090512 解决申告中反映问题
	//alert(printStr);
	if(printStr == "failed")
	{
		return false;
	}
	var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no"
	var path = "/npage/innet/hljBillPrint.jsp?DlgMsg=" + DlgMessage;
	var path = path + "&printInfo=" + printStr + "&submitCfm=" + submitCfm;
	var ret=window.showModalDialog(path,printStr,prop);
}


function QryNewRate()
{
    var pageTitle = "集团费率信息查询";
    var fieldName = "集团费率代码|集团费率名称|";

	if (document.frm.grpIdNo.value == "")
	{
		alert("集团代码不能为空！");
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
	getSysAccept_Packet =null;
}

function refMain()
{
	getAfterPrompt();
	if(  document.frm.grpIdNo.value == "" )
	{
		rdShowMessageDialog("集团用户ID不能为空!!");
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
	//wuxy alter 20090826 解决点击确定、取消都提交问题
	//ajaxSubmit();
}

</script>
<BODY>
	<FORM action="" method="post" name="frm" >
		<%@ include file="/npage/include/header.jsp" %>

		<input type="hidden" name="loginAccept"  value="0"> <!-- 操作流水号 -->
		<input type="hidden" name="loginNo"  value="<%=loginNo%>">
		<input type="hidden" name="loginPwd"  value="<%=loginPwd%>">
		<input type="hidden" name="orgCode"  value="<%=orgCode%>">
		<input type="hidden" name="ipAddress"  value="<%=ipAddress%>">
		<input type="hidden" name="regionCode"  value="<%=regionCode%>">
		<input type="hidden" name="unitName"  >
			<div class="title">
	   	<div id="title_zi">BOSS侧VPMN成员用户开户、销户和套餐变更</div>
			</div>
<TABLE cellSpacing="0">
	<TR>
		<TD class="blue">
			<div align="left">操作类型</div>
		</TD>
		<TD colspan="3">
			<SELECT name="opCode"  id="opCode" onChange="OpCodeChange()">
				<option value="3607">批量成员开户</option>
			</SELECT>
			<font class="orange">*</font>
		</TD>
	</TR>
							<TR>
								<TD  class="blue">
									<div align="left">身份证或资费代码</div>
								</TD>
								<TD>
									<input name="idIccid"  id="idIccid" size="24" maxlength="18" v_type="string" v_must=1 v_name="身份证号" index="1" value="">
									<input name=custQuery type=button id="custQuery"  onMouseUp="getInfo_Cust();" onKeyUp="if(event.keyCode==13)getInfo_Cust();" style="cursorhand" value=查询 class="b_text">
									<font class="orange">*</font>
								</TD>
								<TD  class="blue">集团客户ID</TD>
								<TD>
									<input  type="text" name="custId" size="20" maxlength="18" v_type="0_9" v_must=1 v_name="客户ID" index="2" value="">
									<font class="orange">*</font>
								</TD>
							</TR>
							<TR>
								<TD class="blue">
									<div align="left">集团ID</div>
								</TD>
								<TD>
									<input name=unitId  id="unitId" size="24" maxlength="10" v_type="0_9" v_must=1 v_name="集团ID" index="3" value="">
									<font class="orange">*</font>
								</TD>
								<TD class="blue">集团用户编号</TD>
								<TD>
									<input  name="grpOutNo" size="20" v_must=1 v_type=string v_name="集团用户编号" index="4" value="">
									<font class="orange">*</font>
								</TD>
							</TR>
							<TR>
								<TD class="blue">集团用户ID</TD>
								<TD>
									<input  name="grpIdNo" size="20" readonly v_must=1 v_type=string v_name="集团用户ID" index="4" value="" class="InputGrey">
									<font class="orange">*</font>
								</TD>
								<TD class="blue">集团客户密码</TD>
								<TD>
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
								<TD  class="blue">成员设定费率</TD>
								<TD>
									<input name="mainRate"  type="text" v_must=1 v_maxlength=8 v_type="string" v_name="成员设定费率" index="8" value="" readonly class="InputGrey">
									<font class="orange">*</font>
								</TD>
								<TD  class="blue">成员设定费率名称</TD>
								<TD>
									<input name="mainRateName"  type="text" v_must=1 v_maxlength=8 v_type="string" v_name="成员设定费率名称" index="8" value="" readonly class="InputGrey">
									<font class="orange">*</font>
								</TD>
							</TR>
							<TR>
								<TD class="blue">手机号码</TD>
								<TD colspan="3">
								<textarea cols=30 rows=8 name="phoneNo" style="overflow:auto" v_must=1 v_minlength="11" v_maxlength="15" v_type="string" v_name="手机号码" index="8"></textarea>
								<br>注批量增加手机号码时,请用"|"作为分隔<br>
								符,并且最后一个号码也请用"|"作为结束.<br>
								例如：13900000000|<br>
								&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;13900000001|<br>
								</TD>
							</TR>

							<TR>
								<TD  class="blue">备注信息</TD>
								<TD colspan="3">
									<input  name="opNote" size="60" value="BOSS侧VPMN成员用户开户" class="InputGrey" readonly >

									<input  name="sysNote" size="60" value="BOSS侧VPMN成员用户开户" type="hidden">

								</TD>
							</TR>
						
							<TR>
								<TD align=center id="footer" colspan="4">
									<input  name="doSubmit"  type=button value="确认" onclick="refMain()" class="b_foot">
									<input  name="reset1"  onClick="" type=reset value="清除" class="b_foot">
									<input  name="kkkk"  onClick="removeCurrentTab()" type=button value="关闭" class="b_foot">
								</TD>
							</TR>
						</TABLE>


		<%@ include file="/npage/include/footer.jsp" %>
	</FORM>
<script language="JavaScript">
	document.frm.idIccid.focus();
	ChgCurrStep("custQuery");
	OpCodeChange();
</script>
</BODY>
</HTML>

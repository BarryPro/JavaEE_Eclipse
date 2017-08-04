<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%
    /********************
     version v2.0
     开发商: si-tech
     *
     *update:zhanghonga@2008-09-07 页面改造,修改样式
     *
     ********************/
%>
<html xmlns="http://www.w3.org/1999/xhtml">

<%@ page contentType="text/html; charset=GB2312" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%
    response.setHeader("Pragma","No-cache");
    response.setHeader("Cache-Control","no-cache");
    response.setDateHeader("Expires", 0);
%>
<%
		String opCode = WtcUtil.repNull(request.getParameter("opCode"))==""?"2897":WtcUtil.repNull(request.getParameter("opCode"));	
		String opName = WtcUtil.repNull(request.getParameter("opName"))==""?"黑白名单管理":WtcUtil.repNull(request.getParameter("opName"));
		
		String ipAddress = (String)session.getAttribute("ipAddr");
		String loginNo = (String)session.getAttribute("workNo");
		String workname = (String)session.getAttribute("workName");
		String orgCode = (String)session.getAttribute("orgCode");
		String loginPwd  = (String)session.getAttribute("password");
		String Department = (String)session.getAttribute("orgCode");
		String regionCode = Department.substring(0,2);
		String districtCode = Department.substring(2,4);
		String strDate=new SimpleDateFormat("yyyyMMdd").format(Calendar.getInstance().getTime());
		System.out.println(")))))))))))))))))))))))))))))0="+strDate);
%>
<HTML>
<HEAD>
	<TITLE>黑白名单管理</TITLE>
	<META content=no-cache http-equiv=Pragma>
	<META content=no-cache http-equiv=Cache-Control>
	<meta http-equiv="Content-Type" content="text/html; charset=gb2312">

<SCRIPT type=text/javascript>
	
function OpCodeChange()
{
	if (document.frm.opCode.value == "2898")
	{
		document.frm.sysNote.value="黑名单添加";
		document.frm.opNote.value="黑名单添加";
	}
	else if (document.frm.opCode.value == "2899")
	{
		document.frm.sysNote.value="黑名单删除";
		document.frm.opNote.value="黑名单删除";
	}
	else if (document.frm.opCode.value == "2900")
	{
		document.frm.sysNote.value="白名单添加";
		document.frm.opNote.value="白名单添加";
	}
	else if (document.frm.opCode.value == "2901")
	{
		document.frm.sysNote.value="白名单删除";
		document.frm.opNote.value="白名单删除";
	}
	ChgCurrStep("custQuery");
	beforePrompt(document.frm.opCode.value);
}
function beforePrompt(op_code){
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
function ChgCurrStep(currStep)
{
	if (currStep == "custQuery")
	{
		document.frm.custQuery.disabled = false;
		document.frm.chkGrpPwd.disabled = true;
	}
	else if (currStep == "chkGrpPwd")
	{
		document.frm.custQuery.disabled = false;
		document.frm.chkGrpPwd.disabled = false;
	}
	else if (currStep == "qryPhone")
	{
		document.frm.custQuery.disabled = false;
		document.frm.chkGrpPwd.disabled = false;
	}
	else if (currStep == "chkUserPwd")
	{
		document.frm.custQuery.disabled = false;
		document.frm.chkGrpPwd.disabled = false;
	}
	else if (currStep == "doSubmit")
	{
		document.frm.custQuery.disabled = false;
		document.frm.chkGrpPwd.disabled = false;
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
		if(retCode == 0)
		{
			var retResult = packet.data.findValueByName("retResult");
			if (retResult == "false")
			{
				ChgCurrStep("chkGrpPwd");
				frm.grpPwd.value = "";
				frm.grpPwd.focus();
				rdShowMessageDialog(retMessage);
				return false;
			}else{
				ChgCurrStep("qryPhone");
				rdShowMessageDialog("客户密码校验成功！",2);
				document.all.doSubmit.disabled=false;
			}
		}else{
			rdShowMessageDialog(retMessage+retCode);
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

		}else{
			rdShowMessageDialog("查询流水出错,请重新获取！");
			return false;
		}
	}
}


//调用公共界面，进行集团客户选择
function 	getInfo_Cust()
{
	var pageTitle = "集团客户选择";
	var fieldName = "证件号码|集团客户ID|集团编号|集团名称|集团用户编码|产品号码|产品代码|产品名称|aa|aa|";
	var sqlStr = "";
	var selType = "S";    //'S'单选；'M'多选
	var retQuence = "8|0|1|2|3|4|5|6|7|";
	var retToField = "idIccid|custId|unitId|grpName|grpOutNo|grpIdNo|smName|aa|aa|";
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
	var path = "<%=request.getContextPath()%>/npage/s2897/fpubgrpusr_sel.jsp";
	path = path + "?sqlStr=" + sqlStr + "&retQuence=" + retQuence;
	path = path + "&fieldName=" + fieldName + "&pageTitle=" + pageTitle;
	path = path + "&selType=" + selType+"&idIccid=" + document.all.idIccid.value;
	path = path + "&custId=" + document.all.custId.value;
	path = path + "&unitId=" + document.all.unitId.value;
	path = path + "&grpOutNo=" + document.all.grpOutNo.value
	path = path + "&pageOpCode=<%=opCode%>&pageOpName=<%=opName%>";

	retInfo = window.open(path,"newwindow","height=450, width=830,top=50,left=100,scrollbars=yes, resizable=no,location=no, status=yes");

	return true;
}

function getvaluecust(retInfo)
{
	var retToField = "idIccid|custId|unitId|grpName|grpOutNo|grpIdNo|smName|";
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
	var checkPwd_Packet = new AJAXPacket("pubCheckPwd.jsp","正在进行密码校验，请稍候......");
	checkPwd_Packet.data.add("retType","checkPwd");
	checkPwd_Packet.data.add("GRP_ID",grpIdNo);
	checkPwd_Packet.data.add("inPwd",inPwd);
	core.ajax.sendPacket(checkPwd_Packet);
	checkPwd_Packet=null;
}

//打印信息
function printInfo(printType)
{ 
		var retInfo = "";
		var cust_info="";
		var opr_info="";
		var note_info1="";
		var note_info2="";
		var note_info3="";
		var note_info4="";
		var tmpOpCode=document.all.opCode.value;
		if (tmpOpCode=="2898" || tmpOpCode=="2899"|| tmpOpCode=="2900"|| tmpOpCode=="2901")
		{
    		cust_info+="证件号码："+document.frm.idIccid.value+"|";
    		cust_info+="客户姓名："+document.frm.grpName.value+"|";
    		cust_info+="集团客户编码："+document.frm.grpOutNo.value+"|";

	    	opr_info+="业务类型："+document.frm.opCode.options[document.frm.opCode.selectedIndex].text+"|";
	    	opr_info+="流水："+document.frm.loginAccept.value+"|";
			
			note_info1="备注："+"|";
	    	note_info1+=document.frm.sysNote.value+"|";
	    	note_info1+=document.all.simBell.value+"|";
	    	//retInfo = cust_info+"#"+opr_info+"#"+note_info1+"#"+note_info2+"#"+note_info3+"#"+note_info4+"#";
	    	retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
			retInfo=retInfo.replace(new RegExp("#","gm"),"%23");
		 	return retInfo;
	 }
}

//显示打印对话框
function showPrtDlg(printType,DlgMessage,submitCfm)
{
	var h=210;
	var w=400;
	var t=screen.availHeight/2-h/2;
	var l=screen.availWidth/2-w/2;
	var pType="print";   
	var billType="1";  
	var sysAccept = document.frm.loginAccept.value;
	var printStr = printInfo(printType);
	var opCode = document.all.opCode.value;
	if(printStr == "failed")
	{
		return false;
	}
	var mode_code=null;
	var fav_code=null;
	var area_code=null
	var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no"
	var path = "<%=request.getContextPath()%>/npage/innet/hljBillPrint_jc.jsp?DlgMsg=" + DlgMessage;
	var path = path  + "&mode_code="+mode_code+"&fav_code="+fav_code+"&area_code="+area_code+"&opCode="+opCode+"&sysAccept="+sysAccept+"&phoneNo=xxxx&submitCfm=" + submitCfm+"&pType="+pType+"&billType="+billType+ "&printInfo=" + printStr;
	var ret=window.showModalDialog(path,printStr,prop);
}


	//选择录入方式
function inputByNo(){
	if(document.frm.byNo.checked == true){
    window.document.frm.byFile.checked = false;
	}
	document.all.tableNo.style.display="";
	document.all.tableFile.style.display="none"; 
}
function inputByFile(){
	if(document.frm.byFile.checked == true){
    window.document.frm.byNo.checked = false;
	}
	document.all.tableNo.style.display="none";
	document.all.tableFile.style.display=""; 
}

//取流水
function getSysAccept()
{
	var getSysAccept_Packet = new AJAXPacket("pubSysAccept.jsp","正在生成操作流水，请稍候......");
	getSysAccept_Packet.data.add("retType","getSysAccept");
	core.ajax.sendPacket(getSysAccept_Packet);
	getSysAccept_Packet=null;
}

function refMain()
{
	var op_code=document.frm.opCode.value;
    getAfterPrompt(op_code);//add by qidp
	var nowDate= "<%=strDate%>";
	var expect_time=document.frm.expect_time.value;
	//add by rendi for增加对txt文件的判断，以避免后台服务core
	var uploadfile = document.all.PosFile.value;
	var ext = "*.txt";
	var file_name = uploadfile.substr(uploadfile.lastIndexOf(".")); 
	if(ext.indexOf("*"+file_name)==-1)   
    {   
    rdShowMessageDialog("程序只支持txt格式文件(*.txt)！");  
    return;  
    }    
	if(parseInt(expect_time)<parseInt(nowDate))
	{
		rdShowMessageDialog("期望日期不能小于当前日期！");
		return;
	}
	
	if (document.frm.byNo.checked==true)
	{
		document.frm.opType.value="no";
	}
	else
	{
		document.frm.opType.value="file";
	}
	
	if(  document.frm.grpIdNo.value == "" )
	{
		rdShowMessageDialog("产品号码不能为空!!");
		document.frm.idIccid.select();
		return false;
	}
	if( frm.all.byNo.checked==true && document.frm.phoneNo.value == "" )
	{
		rdShowMessageDialog("请输入号码");
		document.frm.phoneNo.focus();
		return false;
	}
	
		if (!forDate(document.all.expect_time))
	{
		document.all.expect_time.focus();
		return false;
	}
	
	if (document.frm.expect_time.value == "" )
	{
		rdShowMessageDialog("请输入期望生效日期!");
		document.all.expect_time.focus();
		return false;
	}

	getSysAccept();
	showPrtDlg("Detail","确实要打印电子免填单吗？","Yes");
	if (rdShowConfirmDialog("是否提交确认操作？")==1)
	{
		page = "s2897_2.jsp?opType="+document.frm.opType.value;
		frm.action=page;
		frm.method="post";
		frm.submit();
	}
	else{ 
		return false;
	}
}
</script>

</HEAD>
<BODY>
	<FORM action="" method="post" name="frm" ENCTYPE="multipart/form-data">
		<input type="hidden" name="loginAccept"  value="0"> <!-- 操作流水号 -->
		<input type="hidden" name="loginNo"  value="<%=loginNo%>">
		<input type="hidden" name="loginPwd"  value="<%=loginPwd%>">
		<input type="hidden" name="smName"  value="">
		<input type="hidden" name="grpName"  value="">
		<input type="hidden" name="opType"  value="124">
		<input type="hidden" name="orgCode"  value="<%=orgCode%>">
		<input type="hidden" name="ipAddress"  value="<%=ipAddress%>">
		<input type=hidden name=simBell value="   手机上网可选套餐优惠的GPRS流量仅指CMWAP节点产生的流量.  彩铃下载：1.购彩铃包年卡,送价值88元德赛电池。  2.登陆龙江风采（wap.hljmonternet.com）使用手机上网：体验图铃下载、新闻资讯、网络美文免费体验区下载铃音、时尚屏保,免收信息费！拨打1860开通GPRS 。">
		<input type=hidden name=worldSimBell value="    您办理此业务后，即成为我公司全球通签约客户，在签约期限内使用我公司业务及产品，同时执行月底限消费政策。您交纳的预存款需在消费期限内消费完毕，同时您获赠的积分在积分使用期限后方可使用。       在协议有效期内若遇国家资费标准调整，按国家新的资费政策执行。       做为全球通客户，您将享受我公司为您提供的尊贵服务。">
		<input type="hidden" name="pageOpCode" value="<%=opCode%>">
		<input type="hidden" name="pageOpName" value="<%=opName%>">
					<%@ include file="/npage/include/header.jsp" %>
						<div class="title">
						    <div id="title_zi">请选择操作类型</div>
						</div>
						<TABLE cellSpacing="0">
							<tr>
								<TD width=12% class="blue">
									<div align="left">操作类型</div>
								</TD>
								<TD width="32%" colspan="3">
									<SELECT name="opCode" id="opCode" onChange="OpCodeChange()">
										<option value="2898">黑名单添加 </option>
										<option value="2899">黑名单删除 </option>
										<option value="2900">白名单添加 </option>
										<option value="2901">白名单删除 </option>
									</SELECT>
									<font class="orange">*</font>
								</TD>
							</TR>
							<tr>
								<TD width=12% class="blue">
									<div align="left">证件号码</div>
								</TD>
								<TD width="32%">
									<input name="idIccid" id="idIccid" size="24" maxlength="18" v_type="string" v_must=1 index="1" value="">
									<input name=custQuery type=button class="b_text" id="custQuery" onMouseUp="getInfo_Cust();" onKeyUp="if(event.keyCode==13)getInfo_Cust();" style="cursor：hand" value=查询>
									<font class="orange">*</font>
								</TD>
								<TD class="blue">集团客户ID</TD>
								<TD width="32%">
									<input type="text" name="custId" size="20" maxlength="18" v_type="0_9" v_must=1 index="2" value="" style="ime-mode:disabled" onKeyPress="return isKeyNumberdot(0)">
									<font class="orange">*</font>
								</TD>
							</TR>
							<tr>
								<TD width=12% class="blue">
									<div align="left">集团编号</div>
								</TD>
								<TD>
									<input name=unitId id="unitId" size="24" maxlength="10" v_type="0_9" v_must=1 index="3" value="" style="ime-mode:disabled" onKeyPress="return isKeyNumberdot(0)">
									<font class="orange">*</font>
								</TD>
								<TD class="blue">集团用户编号</TD>
								<TD>
									<input name="grpOutNo" size="20" v_must=1 v_type=string index="4" value="" style="ime-mode:disabled" onKeyPress="return isKeyNumberdot(0)">
									<font class="orange">*</font>
								</TD>
							</TR>
							<tr>
								<TD class="blue">产品号码</TD>
								<TD COLSPAN="1">
									<input name="grpIdNo" size="20" readonly v_must=1 v_type=string index="4" value="">
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
									<input name=chkGrpPwd type=button class="b_text" onClick="check_HidPwd();" style="cursor：hand" id="chkGrpPwd" value=校验>
									<font class="orange">*</font>
								</TD>
							</TR>
							<Tr> 
            		<TD width="12%" class="blue"> 
									<div align="left">增加方式</div>
								</TD>
            		<TD colspan="3"> 
									<input name="byNo" onClick="inputByNo()" type="radio" value="no" checked index="2">
									按号码
									<input name="byFile" onClick="inputByFile()"  type="radio"  value="file" index="3">
									按文件
								</TD>
          		</TR>
							<TR id="tableNo">
								<TD class="blue">号码</TD>
								<TD colspan="1">
									<textarea cols=30 rows=8 name="phoneNo" style="overflow:auto" v_must=1 v_minlength="11" v_maxlength="15" v_type="string" v_name="手机号码" index="8"></textarea>
								</TD>
								<TD colspan="2">
									注：批量增加号码时,请用"|"作为分隔符,并且最后一个号码也请用"|"作为结束.
									<br>例如：
									<br>&nbsp;&nbsp;&nbsp;&nbsp;20200000000|
									<br>&nbsp;&nbsp;&nbsp;&nbsp;20200654321|
								</TD>
							</TR>			
							<TR id="tableFile" style=display:none>
								<TD align="left" width=12% class="blue">录入文件</TD>	   
        				<TD> 
          				<input type="file" name="PosFile">
        				</TD>
								<TD colspan="2">文件说明:一个号码一行</TD>
							</TR>

	         
	          <TR id="expect_time_txt"> 
						<TD width=12% class="blue"> 期望日期</TD>
	            <TD width=20% colspan="3">
	              	<input type="text"  name="expect_time" v_format="yyyyMMdd" maxlength="8" value="" v_type="date" v_must="1" size="9" >
	              	<font class="orange">*</font>&nbsp;(格式:YYYYMMDD)&nbsp;            	
	            </TD> 					            	              
	         </TR>
							<tr>
								<TD class="blue">系统备注</TD>
								<TD colspan="3">
									<input name="sysNote" size="60" value="黑白名单管理" readonly >
								</TD>
							</TR>
							<tr style="display:none">
								<TD class="blue">用户备注</TD>
								<TD colspan="3">
									<input name="opNote" size="60" value="黑白名单管理" >
								</TD>
							</TR>
						</TABLE>
						<TABLE cellSpacing="0">
							<tr>
								<TD align=center id="footer">
									<input class="b_foot" name="doSubmit" type=button value="确认" onclick="refMain()" disabled >
									<input class="b_foot" name="reset1"  onClick="" type=reset value="清除" >
									<input class="b_foot" name="kkkk"  onClick="removeCurrentTab();" type=button value="关闭" >
								</TD>
							</TR>
						</TABLE>
			        <div id="relationArea" style="display:none"></div>
						<div id="wait" style="display:none">
						<img  src="/nresources/default/images/blue-loading.gif" />
					</div>
					<div id="beforePrompt"></div>   						
					<%@ include file="/npage/include/footer_simple.jsp" %>
					<jsp:include page="/npage/common/pwd_comm.jsp"/>
				</FORM>
		<script language="JavaScript">
			document.frm.idIccid.focus();
			ChgCurrStep("custQuery");
			OpCodeChange();
		</script>
</BODY>
</HTML>



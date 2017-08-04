<%@ page contentType= "text/html;charset=GBK" %>
<%@ page errorPage="../common/errorpage.jsp" %>
<%@ page import="com.sitech.boss.pub.util.*"%>
<%@ page import="com.sitech.boss.login.ejb.*"%>
<%@ page import="com.sitech.boss.login.wrapper.*"%>
<%@ taglib uri="/WEB-INF/wtc.tld" prefix="wtc" %>
<script type="text/javascript" src="/njs/redialog/redialog.js"></script>
<%
System.out.println("---------------------------------------------------------------------------");
/* 获取参数 */
String token = request.getParameter("token4a")==null? "" : request.getParameter("token4a");
String loginNo = request.getParameter("staffNo")==null? "" : request.getParameter("staffNo");
String sessionToken = (String)session.getAttribute("token4a");
String workNo4a   = (String)session.getAttribute("workNo");
System.out.println(workNo4a);
System.out.println(loginNo);
/*yanpx 如果session中的工号与request中的工号不等则推出系统*/
if(!loginNo.equals(workNo4a)){
%>
	<SCRIPT language="javascript">
		window.open("","_self");
		window.close();
	</SCRIPT>
<%	
}
if(sessionToken == null || "null".equals(sessionToken) || (!sessionToken.equals(token))){
	/*如果session中的token串为空，或者与获取的不相符，直接关闭页面*/
	System.out.println("ningtn error token");
%>
	<SCRIPT language="javascript">
		window.open("","_self");
		window.close();
	</SCRIPT>
<%
}else{
System.out.println("ningtn --------------->" + token + "|" + loginNo + "|");

%>
<html>
<head>
<META http-equiv=Content-Language content=zh-cn />
<META http-equiv=Content-Type content="text/html; charset=GBK" />
<title>中国移动客户关系管理系统</title>
<link href="/nresources/default/css/login.css" rel="stylesheet" type="text/css"></link>
<link href="../../nresources/default/css/FormText.css" rel="stylesheet" type="text/css"></link>
<style type="text/css">
#lightBoxDiv {
	display: none;
	position: absolute;
	z-index: 1000;
	height: 100%;
	width: 100%;
	background: #000000;
	filter:Alpha(opacity=30);
}
#pwdAnswer {
	display: none;
	position: absolute;
	height: 50%;
	width: 430px;
	padding-top: 10%;
	z-index: 1001;
	left: 25%;
	top: 15%;
}
.layer_handle 
{
	background-color:#5588bb;
	padding:2px;
	text-align:center;
	font-weight:bold;
	color: #FFFFFF;
	vertical-align:middle;
	width: 430px;
}

.layer_content {
	padding:5px;
	background-color:#FFFFFF;
	width: 430px;
}

.close {
  float:right;
  text-decoration:none;
  color:#FFFFFF;
}
</style>
<script src="/njs/extend/jquery/jquery123_pack.js" type="text/javascript"></script>
<script src="/njs/system/system.js" type="text/javascript"></script>
<script type="text/javascript" src="/njs/si/core_sitech_pack.js"></script>	
<script type="text/javascript" src="/njs/extend/jquery/block/jquery.blockUI.js"></script>
<!--add by dujl begin 20100402 for zhanglicheng
<OBJECT ID="hljMacInfo1" WIDTH=0 HEIGHT=0
 CLASSID="CLSID:50575fe3-507F-4C9D-86A1-8426A3B203E7" codebase="/ocx/hljMacInfo.ocx">
    <PARAM NAME="_Version" VALUE="2">
    <PARAM NAME="_ExtentX" VALUE="2646">
    <PARAM NAME="_ExtentY" VALUE="1323">
    <PARAM NAME="_StockProps" VALUE="9">
</OBJECT>
-->
<OBJECT ID="hljMacInfo1" WIDTH=0 HEIGHT=0
 CLASSID="CLSID:C03441C8-3DD3-44A4-B501-D816930AA833"
 codebase="/ocx/hljMacInfo.cab#Version=1,0,0,3">
</OBJECT>
<OBJECT id='localIdObject' classid="CLSID:8DCCE0F4-FFA9-423C-8052-5095FA327EE3"
codebase="/ocx/RemoteClientInfo.cab#version=1,0,0,1"
	  width=20
	  height=20
	  align=center
	  hspace=0
	  vspace=0>
</OBJECT>
<!--add by gaolw begin 20091221 获得客户端mac地址 -->
<SCRIPT language=JScript event="OnCompleted(hResult,pErrorObject, pAsyncContext)" for=foo>
//	document.loginForm.macAddr.value=unescape(MACAddr);
</SCRIPT>

<SCRIPT language=JScript event=OnObjectReady(objObject,objAsyncContext) for=foo>
	if(objObject.IPEnabled != null && objObject.IPEnabled != "undefined" && objObject.IPEnabled == true && objObject.MACAddress != null && objObject.MACAddress != "undefined")
	MACAddr = objObject.MACAddress;
</SCRIPT>

<OBJECT id=locator classid=CLSID:76A64158-CB41-11D1-8B02-00600806D9B6 VIEWASTEXT></OBJECT>
<OBJECT id=foo classid=CLSID:75718C9A-F029-11d1-A1AC-00C04FB6C223></OBJECT>

<SCRIPT language=JScript>
	var service = locator.ConnectServer();
	var MACAddr;
	service.Security_.ImpersonationLevel=3;
	service.InstancesOfAsync(foo, 'Win32_NetworkAdapterConfiguration');
</SCRIPT>
<!--add by gaolw end -->
<script language="javascript">

document.oncontextmenu=new Function("event.returnValue=false;"); //禁止右键功能

$(document).ready(function(){
			$("BUTTON").hover(
				function () {
				    $(this).css("background-position","center");
				},
				function () {
				    $(this).css("background-position","top");
				}
			);
			
			var localip='<%=request.getRemoteAddr()%>';
			
			if(localip.substring(0,localip.lastIndexOf('.'))=='10.111.91'){
				try{
					var localclientip=localIdObject.GetRemoteLoginClientIP(); //获取远程登录客户端IP地址
					document.all.localclientip.value=localclientip;
				}catch(e){
					document.all.localclientip.value=localip;
				}
			}else
			{
				document.all.localclientip.value=localip;
			}			
			
			if("" == "<%=token%>" || "" == "<%=loginNo%>"){
				window.location="index.html";
				return false;
			}
		});
function openPwdAnswer(){
	getQuestion();
}
function colsePwdAnswer(){
	$("#lightBoxDiv").hide();
	$("#pwdAnswer").hide();
}
/*判断是否设置了密码找回问题 如果没有设置密码找回问题则不用显示密码问题*/
function getQuestion(){
	/*
	点击找回密码的时候，才调用服务
	因为这是登录界面，否则的话会有很大的调用量，并且用不上路由，压力太大
	*/
	var packet = new AJAXPacket("fe792GetQuestion.jsp","请稍后...");
	packet.data.add("workNo",$("#staffNo").val());	
	core.ajax.sendPacket(packet		,doCfmBack);
	packet =null;
}
function doCfmBack(packet){
	var	retCode	=packet.data.findValueByName("retCode");
	var	retmsg	=packet.data.findValueByName("retmsg");
	var	result	=packet.data.findValueByName("result");
	$("#pwdTBody").empty();
	if(retCode!="-1"){
		$(result).each(function(i,n){
			var insertHtml = "";
			insertHtml = "<tr><td><select name='questionList' onchange='changeQues(this,"+i+")'><option value='0'>--请选择问题--</option>";
			$(result).each(function(i,n){
				insertHtml += "<option value='"+n[0]+"'>"+n[1]+"</option>";
			});
			insertHtml += "</select></td><td><input type='text' name='answer' maxlength='40' size='40' /></td></tr>"
			$("#pwdTBody").append(insertHtml);
			
				$("#lightBoxDiv").show();
	
				$("#pwdAnswer").show();
		});
	}else{
		rdShowMessageDialog(retmsg);
	}
}
function changeQues(obj,selectIndex){
	var selectedVal = $(obj).val();
	if(selectedVal != "0"){
		/*选择了某一个问题，看看是否设置过*/
		$("select").each(function(i,n){
			if(i != selectIndex && $(this).val() == selectedVal){
				rdShowMessageDialog("该问题已经回答，请选择其他问题");
				$(obj).attr("value","0");
			}
		});
	}
}
function submitt(){
	var flag = true;
	var countNum = 0;
	var questionList = new Array();
	var answerList = new Array();
	$("select").each(function(i,n){
		if($(this).val() != "0"){
			var answerVal = $("input[name='answer']").eq(i).val();
			if(answerVal != ""){
				questionList[countNum] = $(this).val();
				answerList[countNum]   = answerVal;
				countNum++;
			}else{
				rdShowMessageDialog("问题的答案不能为空");
				flag = false;
			}
		}
	});
	
	if(flag && countNum < 2){
		rdShowMessageDialog("请至少回答两个问题");
		flag = false;
		return false;
	}
	if(flag && $("#newPass").val().length == 0){
		rdShowMessageDialog("请输入新密码！");
		flag = false;
		return false;
	}
	if(flag && $("#newPass").val().length != 6){
		rdShowMessageDialog("密码长度应为六位！");
		flag = false;
		return false;
	}
	if(flag && $("#newPass").val() != $("#cfmPass").val()){
		rdShowMessageDialog("两次输入新密码不一致！");
		flag = false;
		return false;
	}
	if(flag){
		var reg = new RegExp('[0-9a-zA-Z]*([a-zA-Z]+[0-9]+|[0-9]+[a-zA-Z]+)[0-9a-zA-Z]*');
		var newPwdstr = $("#newPass").val();
		flag = reg.test(newPwdstr);
		if(flag == false){
			rdShowMessageDialog("密码中请至少输入一个字母和一个数字！");
			flag = false;
			return false;
		}
	}
	if(flag){
			/*
			调用重置密码的服务了
			*/
			var packet = new AJAXPacket("fe792Cfm.jsp","请稍后...");
			packet.data.add("opCode","e792");
			packet.data.add("workNo",$("#staffNo").val());
			packet.data.add("pwdFirst",$("#newPass").val());
			packet.data.add("pwdSecond",$("#cfmPass").val());
			packet.data.add("questionList",questionList);
			packet.data.add("answerList",answerList);
			core.ajax.sendPacket(packet		,doResetCfmBack);
			packet =null;
	}
}
function doResetCfmBack(packet){
	var	retCode	=packet.data.findValueByName("retCode");
	var	retMsg	=packet.data.findValueByName("retMsg");
	if("000000" == retCode){
		rdShowMessageDialog("重置成功");
		$("#newPass").val("");
		$("#cfmPass").val("");
		colsePwdAnswer();
	}else{
		window.showModalDialog("prompt.jsp?content="+retMsg+"&rnd="+Math.random(),"" , "status=no;center=yes;help=no;dialogWidth=440px;dialogHeight=320px;scroll=yes;resize=no");
		$("#newPass").val("");
		$("#cfmPass").val("");
	}

}

function nof11(){
	if(event.keyCode==122)
		window.close();
}

//必须从index.html打开，否则定位到index.html
function closeme()
{
	if(window.opener==undefined||window.opener==null)
	{
		window.location="index.html";
		return false;
	}
}

function rightBrowse()
{
	closeme(); // 解决速度慢问题测试需要，暂时封闭  ，正式环境放开 liubo

  var appName = navigator.appName;
  var userAgent = navigator.userAgent;
  var foo;
  var result = "非法浏览器！";

  if(appName.indexOf("Netscape")!= -1)
  {
	 rdShowMessageDialog("您使用的是非IE内核浏览器，请使用IE!");
	 window.opener= "";
	 window.close();
  }
  else if(appName.indexOf("Microsoft")!=-1)
  {
    if(userAgent.indexOf("TencentTraveler")!=-1)
		{
		 	rdShowMessageDialog("你使用了Tencent浏览器，请您关闭Tencent浏览器，使用IE!");
			window.opener= "";
			window.close();
		}else if(userAgent.indexOf("Maxthon")!=-1)
		{
		 	rdShowMessageDialog("你使用了Maxthon浏览器，请您关闭Maxthon浏览器，使用IE!");
			window.opener= "";
			window.close();
		}
  }

  try
  {
    foo = external.tab_count; //利用Maxthon提供的一个JavaScript 函数接口
  }
  catch(e){
    result = "CONTINUE"; //调用出错证明不是 Maxthon
  }
  if (typeof foo == "undefined" ) result = "CONTINUE"; //调用后返回空值证明不是 Maxthon

  if (result != "CONTINUE") {
         rdShowMessageDialog("请勿使用非IE浏览器!");
         window.opener= "";
         window.close();
  }
  document.forms[0].staffNo.focus();
  return 1;
}

function formReset()
{
	loginForm.reset();
	//document.getElementById("subBtn").style.display="";
}

function doForward()
{
	getSysInfo();
	
	var staffNo = document.all.staffNo.value;
	//var password = document.all.password.value;

	if ((check_name()))
	{
		//document.getElementById("subBtn").style.display="none";
		//loginForm.action="/npage/login/checkCrmDatabase.jsp";
		loginForm.action="/npage/login/index.jsp";
		loginForm.submit();
		document.all.login_B.disabled=true;
  }
}

function check_name()
{
   if(document.loginForm.staffNo.value.length==0)
	 {
	 	rdShowMessageDialog("请输入用户名！");
		document.all.staffNo.focus();
		return false;
	 }
	 return true;
}

function getSysInfo()
{ 
	/*yanpx注释 为ie8测试环境使用 上线请放开*/
	//alert(document.getElementById("hljMacInfo1").getMacInfo());
	document.all.uuidCode.value=document.getElementById("hljMacInfo1").getMacInfo();
}

function check_pass()  //验证密码的合法性
{
	if(document.loginForm.password.value.length!=6)
	{
		rdShowMessageDialog("密码位数低于6位，请重新输入 ！");
		document.all.password.focus();
		return false;
	}
	/*
	if(haveSpe_self_a(document.loginForm.password.value)==true || haveSpe_self(document.loginForm.password.value)==true)
	{
		rdShowMessageDialog("密码必须是数字和字符混和的！");
		document.all.password.focus();
		return false;
	}
	*/
	else
	{
		return true;
	}
}

function haveSpe_self(str)
{
	return str.match(/\d/)==null;
}

function haveSpe_self_a(str)
{
	var comp="abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ";
	var aChar="";
	for(var i=0;i<str.length;i++)
	{
		aChar=str.charAt(i);
		if(comp.indexOf(aChar)!=-1)
			return false;
	}
	return true;
}

/** add by qidp for simple version */
 var now_skin = readCookie("skin_foryou"); 

	function doSubmit(thisForm){
		thisForm.SUBMIT.disabled=true;
		thisForm.submit();
	}
		
	/*	$(document).ready(function(){
			$("BUTTON").hover(
				function () {
				    $(this).css("background-position","center");
				},
				function () {
				    $(this).css("background-position","top");
				}
			);
			chgInputStyle();
		});
		
		function chgInputStyle(){
			$("input:text,input:password,textarea").focus(function(){this.className = "focusInput";});	
			$("input:text,input:password,textarea").blur(function(){this.className = "";});	
		}*/ 
		
	//读Cookie
function readCookie(name)
{
    var nameEQ = name + "=";
    var ca = document.cookie.split(';');
    for(var i=0;i < ca.length;i++)
    {
        var c = ca[i];
        while (c.charAt(0)==' ') c = c.substring(1,c.length);
        if (c.indexOf(nameEQ) == 0) return c.substring(nameEQ.length,c.length);
    }
    return null;
}	

	//写Cookie
function createCookie(name,value,days)
{
    if (days)
    {
        var date = new Date();
        date.setTime(date.getTime()+(days*24*60*60*1000));
        var expires = "; expires="+date.toGMTString();
    }
    else var expires = "";
    document.cookie = name+"="+value+expires+"; path=/";
}

 //清Cookie
function eraseCookie(name)
{
    createCookie(name,"",-1);
}
  
function versonType_Fun()
{
	var versonTypeBox = document.getElementsByName("versonTypeBox");
 	if(versonTypeBox[0].checked==true)
	{
		document.all.versonType.value="simple";
		
		if(now_skin != "simple"){
			createCookie("skin_foryou","simple",1000);
		}
	}else{
		document.all.versonType.value="normal";	
		if(now_skin != "default")
			createCookie("skin_foryou","default",1000);
	}
}
function  login_load()
{
	var versonTypeBox = document.getElementsByName("versonTypeBox");
	/*if(now_skin=="orange"){ 
	
		location="login_orange.htm";
	}
	else*/ if(now_skin=="simple"){
			document.all.versonType.value="simple";
			versonTypeBox[0].checked=true;
	}else
	{
		document.all.versonType.value="normal";
		versonTypeBox[0].checked=false;
	}						
}
</script>
</head>
<body  class="login" onkeydown="nof11();" onload="rightBrowse();document.all.staffNo.focus();login_load();">
	<div id="lightBoxDiv">
	</div>
	<div id="pwdAnswer">
		<div class="layer_handle">
			<a href="#this" id="close3" class="close" onclick="colsePwdAnswer()" >[ x ]</a>
			<font color="red">请回答至少两道问题</font>
		</div>
		<div class="layer_content">
			<table width="100%" cellspacing="0">
				<tr>
					<th>问题</th>
					<th>答案</th>
				</tr>
				<tbody id="pwdTBody">
				</tbody>
				<tr bgcolor="#FFFFFF">
					<td class="blue">
						新密码
					</td>
					<td>
						<input type="password" name="newPass" id="newPass" size="12" maxlength="6"/>
						<font class="orange">*</font>
					</td>
				</tr>
				<tr bgcolor="#FFFFFF">
					<td class="blue">
						确认密码
					</td>
					<td>
						<input type="password" name="cfmPass" id="cfmPass" size="12" maxlength="6"/>
						<font class="orange">*</font>
					</td>
				</tr>
				<tr>
					<td colspan="2" align=center>
						<input type="button" class="b_foot" value="密码重置" onclick="submitt()" />
					</td>
				</tr>
			</table>
		</div>
	</div>
	<div class="loginPanel_esop panel2"></div>
	<div class="loginPanel_esop">
		<div class="caption">
			<div class="title">
			</div>
		</div>		
		<form id="loginForm" name="loginForm" target="_self" method="post">
			<div class="suggest">
				版本:
				<input type="checkbox" name="versonTypeBox" id="versonTypeBox" onclick="versonType_Fun()"/> <span>高速版</span>（建议使用GPRS等窄带网络的合作厅选择该版本） 
				<a href="#" onclick="javascript:window.showModalDialog('netSpeedTest.jsp','','dialogHeight:200px;dialogWidth:500px;scroll:no;status:no;help:no');" class="speedtest">网速测试</a>
			</div>
			<fieldset class="fm-input">
				<div class="fm-div">
					<label>帐&nbsp;&nbsp;&nbsp;&nbsp;号:</label>
					<input type="text" id="staffNo" name="staffNo" class="idName"   value="<%=loginNo%>" maxlength=6 class="login_input_line" readOnly />
				</div>
				<input type="hidden" id="password" name="password" value="" />
				<input type="hidden" name="addressFlag" value="1">
				<input type="hidden" name="token4a" value="<%=token%>">
				<!--
				<div class="fm-div">
				<label>密&nbsp;&nbsp;&nbsp;&nbsp;码:</label>
				<input type="password" id="password" class="pass"  name="password" value="abc123" maxlength=6 class="login_input_line"  onkeyDown="if(event.keyCode==13)doForward()" />
				</div>
				-->
			</fieldset>
			<fieldset class="fm-submit">
				<div class="fm-div"><button name="login_B" onclick="doForward()">登 录</button></div>
				<!--
				<div class="fm-div"><button name="reset_B"  onclick="formReset()" >重 置</button></div>
				-->
			</fieldset>	
		
			<input type="hidden" name="versonType" value="normal"/>
			<input type="hidden" name="uuidCode" value=""><!--add by gaolw for 营业厅与mac地址绑定-->
      <input type="hidden" name="localclientip" value=""><!--add by gaolw for 营业厅与mac地址绑定-->
		</form>
		<div class="footer">
			<div>
				<a href="#" onclick="javascript:window.open('http://<%=request.getServerName()%>:<%=request.getServerPort()%>/doprint.html')">下载打印控件</a>
			</div>
			<div style="margin-top:-10px;">&copy;中国移动通信集团黑龙江有限公司</div>
			<div style="margin-top:-16px;font-size: 10px;">&copy;CHINA MOBILE GROUP HEILONGJIANG CO.,LTD	</div>
		</div>
		<div class="otherlink">
			<a href="#" onclick="openPwdAnswer()" class="l2">密码找回</a>
			<a href="#" onclick="javascript:window.open('http://10.110.45.7/csp/bsf/index.action')" class="l1">知识库6.0</a>
		</div>
	</div>

</body>
</html>
<%}%>
<%@ page contentType= "text/html;charset=GBK" %>
<%@ page errorPage="../common/errorpage.jsp" %>
<%@ page import="com.sitech.boss.pub.util.*"%>
<%@ page import="com.sitech.boss.login.ejb.*"%>
<%@ page import="com.sitech.boss.login.wrapper.*"%>
<%@ page import="java.util.*"%>
<%@ page import="javax.servlet.*"%>
<%@ page import="java.security.*" %>
<%@ page import="javax.crypto.*;" %>
<%@ taglib uri="/WEB-INF/wtc.tld" prefix="wtc" %>
<script type="text/javascript" src="/njs/redialog/redialog.js"></script>
<script type="text/javascript" src="/njs/si/desPlusPub.js"></script>

<%

String workNo = (String) session.getAttribute("workNo");
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
if( workNo!=null ){

    String	sqlStr = "update dLoginMsg set try_times=0 where login_no ='"+workNo+"'";
		try{
			%>
			<wtc:pubselect name="sPubSelect" outnum="1">
				<wtc:sql><%=sqlStr%></wtc:sql>
			</wtc:pubselect>
			<%
		}catch(Exception ex)
		{
		}
	 	String selfIp = request.getRemoteAddr();
    Counter.logout(selfIp,new User());
		session.invalidate();
}
%>
<html>
<head>
<title>�й��ƶ��ͻ���ϵ����ϵͳ</title>
<META http-equiv=Content-Language content=zh-cn>
<META http-equiv=Content-Type content="text/html; charset=GBK">
<link href="/nresources/default/css/login.css" rel="stylesheet" type="text/css"></link>
<link href="../../nresources/default/css/FormText.css" rel="stylesheet" type="text/css"></link>
<script src="/njs/extend/jquery/jquery123_pack.js" type="text/javascript"></script>

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
<!--add by gaolw begin 20091221 ��ÿͻ���mac��ַ -->
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
var xbzhsHandle="";
document.oncontextmenu=new Function("event.returnValue=false;"); //��ֹ�Ҽ�����

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
					var localclientip=localIdObject.GetRemoteLoginClientIP(); //��ȡԶ�̵�¼�ͻ���IP��ַ
					document.all.localclientip.value=localclientip;
				}catch(e){
					document.all.localclientip.value=localip;
				}
			}else
			{
				document.all.localclientip.value=localip;
			}
		});

function nof11(){
	if(event.keyCode==122)
		window.close();
}

//�����index.html�򿪣�����λ��index.html
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
	closeme(); // ����ٶ������������Ҫ����ʱ���  ����ʽ�����ſ� liubo

  var appName = navigator.appName;
  var userAgent = navigator.userAgent;
  var foo;
  var result = "�Ƿ��������";
  if(appName.indexOf("Netscape")!= -1)
  {
	 rdShowMessageDialog("��ʹ�õ��Ƿ�IE�ں����������ʹ��IE!");
	 window.opener= "";
	 window.close();
  }
  else if(appName.indexOf("Microsoft")!=-1)
  {
    if(userAgent.indexOf("TencentTraveler")!=-1)
		{
		 	rdShowMessageDialog("��ʹ����Tencent������������ر�Tencent�������ʹ��IE!");
			window.opener= "";
			window.close();
		}else if(userAgent.indexOf("Maxthon")!=-1)
		{
		 	rdShowMessageDialog("��ʹ����Maxthon������������ر�Maxthon�������ʹ��IE!");
			window.opener= "";
			window.close();
		}
  }

  try
  {
    foo = external.tab_count; //����Maxthon�ṩ��һ��JavaScript �����ӿ�
  }
  catch(e){
    result = "CONTINUE"; //���ó���֤������ Maxthon
  }
  if (typeof foo == "undefined" ) result = "CONTINUE"; //���ú󷵻ؿ�ֵ֤������ Maxthon

  if (result != "CONTINUE") {
         rdShowMessageDialog("����ʹ�÷�IE�����!");
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
	var password = document.all.password.value;

	if ((check_name())&&(check_pass()))
	{
		//document.getElementById("subBtn").style.display="none";
		//loginForm.action="/npage/login/checkCrmDatabase.jsp";
		//loginForm.action="/npage/login/index.jsp";
		staffNo = base64encode(utf16to8(staffNo));
		password = base64encode(utf16to8(password));
		document.loginForm.staffNo.value = staffNo;
	 	document.loginForm.password.value = password;
	 	
		loginForm.action="/npage/login/login_check4ALogin.jsp";
		loginForm.submit();
		document.all.login_B.disabled=true;
  }
}

function check_name()
{
   if(document.loginForm.staffNo.value.length==0)
	 {
	 	rdShowMessageDialog("�������û�����");
		document.all.staffNo.focus();
		return false;
	 }
	 return true;
}

function getSysInfo()
{ 
	/*yanpxע�� Ϊie8���Ի���ʹ�� ������ſ�*/
	//alert(document.getElementById("hljMacInfo1").getMacInfo());
	document.all.uuidCode.value=document.getElementById("hljMacInfo1").getMacInfo();
}

function check_pass()  //��֤����ĺϷ���
{
	if(document.loginForm.password.value.length!=6)
	{
		rdShowMessageDialog("����λ������6λ������������ ��");
		document.all.password.focus();
		return false;
	}
	/*
	if(haveSpe_self_a(document.loginForm.password.value)==true || haveSpe_self(document.loginForm.password.value)==true)
	{
		rdShowMessageDialog("������������ֺ��ַ���͵ģ�");
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
		
	//��Cookie
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

	//дCookie
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

 //��Cookie
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
	function openZSKWindow(url){
 	if(xbzhsHandle!=null&&xbzhsHandle!=''&&(xbzhsHandle.closed!=undefined&&!xbzhsHandle.closed)){
		xbzhsHandle.focus();
 	}else{
 		xbzhsHandle=window.open(url);
 	}

}
</script>
</head>
<body  class="login" onkeydown="nof11();" onload="rightBrowse();document.all.staffNo.focus();login_load();">
<div class="loginPanel_esop panel2"></div>
	<div class="loginPanel_esop">
		<div class="caption">
			<div class="title">
		    </div>
		</div>		
<form id="loginForm" name="loginForm" target="_self" method="post">
	<div class="suggest">�汾:<input type="checkbox" name="versonTypeBox" id="versonTypeBox" onclick="versonType_Fun()"/> <span>���ٰ�</span>������ʹ��GPRS��խ������ĺ�����ѡ��ð汾�� <a href="#" onclick="javascript:window.showModalDialog('networkspeed.jsp','','');" class="speedtest">�ٶȲ��Թ���</a></div>
<fieldset class="fm-input">
	<div class="fm-div">
	  <label>��&nbsp;&nbsp;&nbsp;&nbsp;��:</label>
	  <input type="text" id="staffNo" name="staffNo" class="idName"   value="aaaaxp" maxlength=6 class="login_input_line"/>
	</div>
    <div class="fm-div">
	  <label>��&nbsp;&nbsp;&nbsp;&nbsp;��:</label>
	  <input type="password" id="password" class="pass"  name="password" value="abc123" maxlength=6 class="login_input_line" autocomplete="off"  onkeyDown="if(event.keyCode==13)doForward()" />
    </div>
</fieldset>
<fieldset class="fm-submit">
	    	 <div class="fm-div"><button name="login_B" onclick="doForward()">�� ¼</button></div>
	    	 <div class="fm-div"><button name="reset_B"  onclick="formReset()" >�� ��</button></div>
</fieldset>	

<input type="hidden" name="versonType" value="normal"/>
<input type="hidden" name="uuidCode" value=""><!--add by gaolw for Ӫҵ����mac��ַ��-->
<input type="hidden" name="localclientip" value=""><!--add by gaolw for Ӫҵ����mac��ַ��-->
</form>
<div class="footer">
	<div>
		<a href="#" onclick="this.style.behavior='url(#default#homepage)';this.setHomePage('http://<%=request.getServerName()%>:<%=request.getServerPort()%>/npage/login/index.html');">��Ϊ��ҳ</a>|
		<a href="#" onclick="javascript:window.external.AddFavorite('http://<%=request.getServerName()%>:<%=request.getServerPort()%>/npage/login/index.html', '�������ƶ�BOSS--�ۺ�ҵ�����ϵͳ')">�ղر�վ</a>|
		<a href="#" onclick="javascript:window.open('http://<%=request.getServerName()%>:<%=request.getServerPort()%>/doprint.html')">���ش�ӡ�ؼ�</a></div>
			<div style="margin-top:-10px;">&copy;�й��ƶ�ͨ�ż��ź��������޹�˾	</div>
			<div style="margin-top:-16px;font-size: 10px;">&copy;CHINA MOBILE GROUP HEILONGJIANG CO.,LTD	</div>
</div>
<div class="otherlink">
	<a href="#" onclick="javascript:window.open('http://10.110.45.7/csp/bsf/index.action')" class="l1">֪ʶ��6.0</a>
	<a href="#" onclick="javascript:openZSKWindow('<%=basePath%>npage/login/ssoOpenNew.jsp')"  class="l1">�°�֪ʶ��</a>
</div>
</div>

</body>
</html>

<%@page contentType="text/html;charset=GBK"%>
<HTML>
<HEAD>
<TITLE>客服中心功能关系配置</TITLE>
<META http-equiv=Content-Type content="text/html; charset=gb2312">
<script type="text/javascript" src="../../njs/extend/jquery/jquery123_pack.js"></script>	
<script type="text/javascript" src="../../njs/si/core_sitech_pack.js"></script>	
<script type="text/javascript" src="../../njs/redialog/redialog.js"></script>
<script type="text/javascript" src="../../njs/extend/jquery/block/jquery.blockUI.js"></script>
<script language="JavaScript" src="../../njs/si/validate_pack.js"></script>
<link href="../../nresources/default/css/FormText.css" rel="stylesheet" type="text/css"></link>
<link href="../../nresources/default/css/font_color.css" rel="stylesheet" type="text/css"></link>
<link href="../../nresources/default/css/ValidatorStyle.css" rel="stylesheet" type="text/css"></link>
<script type="text/javascript" src="../../njs/extend/jquery/hotkey/jquery.hotkeys_jsa.js"></script>

<script type="text/javascript">
<!--
function submitConfig(){
	var mainCCSIp = $('mainCCSIp').value;
	var mainCCSIp2 = $('mainCCSIp2').value;
	dcrmcallcfgService.save(mainCCSIp, mainCCSIp2, callback);
}
		
function callback(msg) {
	alert(msg);
} 

alert(par_mac);

//-->
</script>

</HEAD>
<BODY>
<OBJECT id='locator' classid=CLSID:76A64158-CB41-11D1-8B02-00600806D9B6 VIEWASTEXT></OBJECT>
<OBJECT id='varMacObject' classid=CLSID:75718C9A-F029-11d1-A1AC-00C04FB6C223></OBJECT>

<FORM  name=formbar>

<input type="button" value="mac" onclick="alert(par_mac)">
<input type="button" value="ip" onclick="alert(par_ip)">

<div id="Main">
<table width="98%" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td width="20" valign="top" background="../../nresources/default/images/DotGray.jpg" class="LeftFixBg"><img src="../../nresources/default/images/CornerLeft.jpg" width="20" height="75" /></td>
	<td valign="top" background="../../nresources/default/images/MainTopBg.jpg" class="TopFixBg">
	<div id="Operation_Title"><B><font face="Arial">1100</font>·本机系统参数配置</B></div>
    <div id="Operation_Table">
    <div class="title">本机系统参数配置</div>  
    <table width="100%" border="0" cellpadding="0" cellspacing="0" id=tb0>
      <tr>
        <td width=16% class="blue">台号</td>
        <td width=34%> 
		  <input name=birthDay maxlength=8 index="27"  v_must=1 v_maxlength=8 v_type="date" size="8"><font class="orange">*</font>
        </td>
        <td width=16% class="blue">主用CCS的IP地址</td>
        <td width="34%"> 
        <input id="mainCCSIp" maxlength=8 index="27"  v_must=1 v_maxlength=8 v_type="date" size="8"><font class="orange">*</font>
        </td>
      </tr>
      <tr> 
        <td width=16% class="blue">备用CCS的IP地址</td>
        <td width=34%> 
          <input id="mainCCSIp2" maxlength=8 index="27"  v_must=1 v_maxlength=8 v_type="date" size="8"><font class="orange">*</font>
        </td>
        <td width=16% class="blue">CCS超时设定</td>
        <td width=34%> 
          <input name=birthDay maxlength=8 index="27"  v_must=1 v_maxlength=8 v_type="date" size="8"><font class="orange">*</font>
        </td>
       </tr>
       <tr> 
         <td width=16% class="blue">mac地址</td>
         <td width="34%"> 
         <input name=birthDay maxlength=8 index="27"  v_must=1 v_maxlength=8 v_type="date" size="8"><font class="orange">*</font>
         </td>
         <td width=16% class="blue">APC卡类型</td>
         <td width=34%> 
         <input name=birthDay maxlength=8 index="27"  v_must=1 v_maxlength=8 v_type="date" size="8"><font class="orange">*</font>
         </td>              
       </tr>
       <tr> 
         <td width=16% class="blue">是否签入排队机</td>
         <td width="34%"> 
         <input name=birthDay maxlength=8 index="27"  v_must=1 v_maxlength=8 v_type="date" size="8"><font class="orange">*</font>
         </td>
         <td width=16% class="blue">服务器进程ID</td>
         <td width=34%> 
         <input name=birthDay maxlength=8 index="27"  v_must=1 v_maxlength=8 v_type="date" size="8"><font class="orange">*</font>
         </td>
       </tr>
      </table>

      <table width="100%" border="0" cellpadding="0" cellspacing="0">
        <tr> 
          <td id="footer"  align=center> 
            <input class="b_foot" name="submit" type="button" value="确认" onclick="submitConfig()">
        	<input class="b_foot" name="reset1" type="button"  onclick="history.go(0);" value="清除">
       		<input class="b_foot" name="back" type="button" onclick="grpClose();" value="关闭"  >
       		<script language="javascript">
       			if(typeof(parent.removeTab)=="function"){
					}else{
           				document.write("<input class='b_foot' name='kkkk'  onClick='grpGoback()' type=button value='返回' style='cursor:hand'>");
					}
			</script>
            <input type="reset" name="Reset" value="Reset" style="display='none'">
        </td>
       </tr>  
     </table>
    </div>
    <br/>          
    </td>
    <td width="20" valign="top" background="../../nresources/default/images/DotGray.jpg" class="RightFixBg"><img src="../../nresources/default/images/CornerRight.jpg" width="20" height="45" /></td>
  </tr>
        
  <tr>
    <td><img src="../../nresources/default/images/CornerLeftDown.gif" width="20" height="20" /></td>
    <td valign="bottom">
    <table width="100%" border="0" cellpadding="0" cellspacing="0" bgcolor="#D8D8D8">
      <tr>
        <td height="1"></td>
      </tr>
    </table>
    </td>
    <td><img src="../../nresources/default/images/CornerRightDown.gif" width="20" height="20" /></td>
  </tr>
</table>
</div>

</FORM>
</BODY>
</HTML>
 
 <script>
 var par_mac=new Array();
 var par_ip=new Array();
 var service = locator.ConnectServer();
 service.Security_.ImpersonationLevel=3;
 service.InstancesOfAsync(varMacObject, 'Win32_NetworkAdapterConfiguration');
</script>
<SCRIPT language=javascript event=OnObjectReady(objObject,objAsyncContext) for=varMacObject>
   if(objObject.IPEnabled != null && objObject.IPEnabled != "undefined" && objObject.IPEnabled == true)
   {
    if(objObject.MACAddress != null && objObject.MACAddress != "undefined")
    MACAddr = objObject.MACAddress;
	par_mac.push(MACAddr);
    if(objObject.IPEnabled && objObject.IPAddress(0) != null && objObject.IPAddress(0) != "undefined")
    IPAddr = objObject.IPAddress(0);
    par_ip.push(IPAddr);
    if(objObject.DNSHostName != null && objObject.DNSHostName != "undefined")
    sDNSName = objObject.DNSHostName;
    }
</SCRIPT>
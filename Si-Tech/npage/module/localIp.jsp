<%
  /*
   * ����: ����ϵͳ����
�� * �汾: 1.0.0
�� * ����: 2008/10/16
�� * ����: tancf
�� * ��Ȩ: sitech
	 *update:
��*/
%>
<HTML>   
<HEAD><TITLE>WMI Scripting HTML</TITLE>   
    <META http-equiv=Content-Type content="text/html; charset=gb2312">   
    <SCRIPT language=JScript event="OnCompleted(hResult,pErrorObject, pAsyncContext)" for=foo>   
        document.forms[0].txtMACAddr.value = unescape(MACAddr);   
        document.forms[0].txtIPAddr.value = unescape(IPAddr);   
        document.forms[0].txtDNSName.value = unescape(sDNSName);   
        //document.formbar.submit();   
    </SCRIPT>   
  
    <SCRIPT language=JScript event=OnObjectReady(objObject,objAsyncContext) for=foo>   
        if (objObject.IPEnabled != null && objObject.IPEnabled != "undefined" && objObject.IPEnabled == true)   
        {   
            if (objObject.MACAddress != null && objObject.MACAddress != "undefined")   
                MACAddr = objObject.MACAddress;   
            if (objObject.IPEnabled && objObject.IPAddress(1) != null && objObject.IPAddress(1) != "undefined")   
                IPAddr = objObject.IPAddress(1);   
            if (objObject.DNSHostName != null && objObject.DNSHostName != "undefined")   
                sDNSName = objObject.DNSHostName;   
        }   
    </SCRIPT>   
  
    <META content="MSHTML 6.00.2800.1106" name=GENERATOR>   
</HEAD>   
<BODY>   
<OBJECT id=locator classid=CLSID:76A64158-CB41-11D1-8B02-00600806D9B6 VIEWASTEXT>   
</OBJECT>   
<OBJECT id=foo classid=CLSID:75718C9A-F029-11d1-A1AC-00C04FB6C223></OBJECT>   
<SCRIPT language=JScript>   
    var service = locator.ConnectServer();   
    var MACAddr ;   
    var IPAddr ;   
    var DomainAddr;   
    var sDNSName;   
    service.Security_.ImpersonationLevel = 3;   
    service.InstancesOfAsync(foo, 'Win32_NetworkAdapterConfiguration');   
</SCRIPT>   
  
<FORM id="formfoo" name="formbar" action="index.do" method="post">   
    <INPUT name="txtMACAddr"> <br>   
    <INPUT name="txtIPAddr"><br>   
    <INPUT name="txtDNSName"></FORM>   
</BODY>   
</HTML>  






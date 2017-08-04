

<OBJECT id='locator' classid=CLSID:76A64158-CB41-11D1-8B02-00600806D9B6 VIEWASTEXT></OBJECT>
<OBJECT id='varMacObject' classid=CLSID:75718C9A-F029-11d1-A1AC-00C04FB6C223></OBJECT>

 <script>
 var par_mac = new Array();
 var par_ip = new Array();
 var locator = document.getElementById("locator");
 var varMacObject = document.getElementById("varMacObject");
 var service = locator.ConnectServer();
 
 alert("service == > " + service );
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
</SCRIPT>>
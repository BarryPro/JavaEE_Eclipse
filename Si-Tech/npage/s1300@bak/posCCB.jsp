<script language="javascript">
	function SetSysInfo()
	{
		/*set IP 端口*/
		//var svrip= "10.109.180.9";   //tianyang
		//var svrip= "10.110.5.143";   //maoliang
		//var svrip= "10.110.191.23";
		//var svrip= "10.110.6.151";   //开发区营业厅测试
		svrip= "15.28.6.219";
		svrport = Number("3001");
		comport = Number("5");
		BankCtrl.SetServer(svrip,svrport,comport);
	}
</script>
<!-- **********建行控件******** -->
<OBJECT id="BankCtrl" codeBase="../../ocx/BankCtrl.cab#version=1.0.0.42"  classid="CLSID:11F0BB5B-8105-4710-B1AD-BB6877CACA29" width="0" height="0" VIEWASTEXT>
</OBJECT>

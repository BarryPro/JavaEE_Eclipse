<!-- **********¹¤ÐÐ¿Ø¼þ******** -->
<object name="KeeperClient" classid="clsid:9BB1BFD1-D279-462B-BB7B-74AEF30A6BDA" style="height:18pt;width:120;display:none
	"codebase='../../ocx/KeeperClient.CAB'#version=1,0,0,4">
</object>
<script language="javascript">
	function SetICBCCfg(inputStr)
	{
		KeeperClient.SetICBCCfg("172.20.1.86","3210","COM5");
		var str = KeeperClient.misposTrans(inputStr,"1,0,5,1");
		return str;
	}
</script>
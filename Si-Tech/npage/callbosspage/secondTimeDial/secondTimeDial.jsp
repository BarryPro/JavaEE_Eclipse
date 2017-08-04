<%@page contentType="text/html;charset=GBK"%>
<HTML>
	<HEAD>
		<TITLE>二次拨号</TITLE>
		<META http-equiv=Content-Type content="text/html; charset=gb2312">
		<script type="text/javascript"
			src="../../njs/extend/jquery/jquery123_pack.js"></script>
		<script type="text/javascript" src="../../njs/si/core_sitech_pack.js"></script>
		<script type="text/javascript" src="../../njs/redialog/redialog.js"></script>
		<script type="text/javascript"
			src="../../njs/extend/jquery/block/jquery.blockUI.js"></script>
		<script language="JavaScript" src="../../njs/si/validate_pack.js"></script>
		<link href="../../nresources/default/css/FormText.css"
			rel="stylesheet" type="text/css"></link>
		<link href="../../nresources/default/css/font_color.css"
			rel="stylesheet" type="text/css"></link>
		<link href="../../nresources/default/css/ValidatorStyle.css"
			rel="stylesheet" type="text/css"></link>
		<script type="text/javascript"
			src="../../njs/extend/jquery/hotkey/jquery.hotkeys_jsa.js"></script>
	</HEAD>
	<BODY>
		<form name="form1" method="post" action="systemRalation_save.jsp">
			<div class="layer_content">
				<table width="100%" border="0" cellpadding="0" cellspacing="0">
					<tr>
						<td class="blue">
							电话号码：
						</td>
						<td>
							<input type="text" name="secondDial" value="">
						</td>
					</tr>
					<tr>
						<td align="right">
							<input type="checkbox" name="secondDialnow" value="1">
							
						</td>
						<td>即拨即送</td>
					</tr>
				</table>
				<table width="100%" border="0" cellpadding="0" cellspacing="0">
					<tr>
						<td id="footer" align=center>
							<input class="b_foot" name="submit1" type="button" value="确认"
								onclick="submitConfig()">
							<input class="b_foot" name="cancel" type="button"
								onclick="goaway();" value="取消">
						</td>
					</tr>
				</table>
			</div>
		</form>
	</BODY>
</HTML>
<script language="javascript">
function submitConfig()
{
var returnvalue="";
if(document.getElementById("secondDialnow").checked)
returnvalue="1";
window.returnValue=document.getElementById("secondDial").value+"isnowsend"+returnvalue;   
window.close();
}
function goaway()
{
window.returnValue="cancel";   

window.close();
}
</script>
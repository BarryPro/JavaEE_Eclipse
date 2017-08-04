<%@page contentType="text/html;charset=GBK"%>
<HTML>
	<HEAD>
		<TITLE>技能组调整</TITLE>
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
				<td>
					<div id="Operation_Title"><B><font face="Arial">员工可选技能组</font></B></div>
				</td>
				<td>
					<div><img src="../../images/webdown.png"  onclick="getdisplay('employeegroup1');"/></div>
				</td>
			</tr>
		</table>
		
			<div id="employeegroup1">
				<table width="100%" border="0" cellpadding="0" cellspacing="0">
					<tr>
							<td class="blue">
							技能组编号
						</td>
						<td class="blue">
							技能组名称
						</td>
						<td class="blue">
							默认技能组
						</td>
					</tr>
						<tr>
							<td class="blue">
							&nbsp;
						</td>
						<td class="blue">
						&nbsp;
						</td>
						<td class="blue">
							&nbsp;
						</td>
					</tr>
				</table>
			</div>
			
			<table width="100%" border="0" cellpadding="0" cellspacing="0">
			<tr>
				<td>
					<div id="Operation_Title"><B><font face="Arial">技能组队列信息</font></B></div>
				</td>
				<td>
					<div><img src="../../images/webdown.png"  onclick="getdisplay('employeegroup2');"/></div>
				</td>
			</tr>
		</table>
		
			<div id="employeegroup2">
				<table width="100%" border="0" cellpadding="0" cellspacing="0">
					<tr>
						<td class="blue">
							技能队列编号
						</td>
						<td class="blue">
							技能队列名称
						</td>
					</tr>
						<tr>
						<td class="blue">
							&nbsp;
						</td>
						<td class="blue">
							&nbsp;
						</td>
					</tr>
				</table>
			</div>
					<table width="100%" border="0" cellpadding="0" cellspacing="0">
			<tr>
				<td>
					<div id="Operation_Title"><B><font face="Arial">员工当前签入队列</font></B></div>
				</td>
				<td>
					<div><img src="../../images/webdown.png"  onclick="getdisplay('employeegroup3');"/></div>
				</td>
			</tr>
		</table>
		
			<div id="employeegroup3">
				<table width="100%" border="0" cellpadding="0" cellspacing="0" >
					<tr>
						<td class="blue">
							技能队列编号
						</td>
						<td class="blue">
							技能队列名称
						</td>
					</tr>
					<tr>
						<td class="blue">
							&nbsp;
						</td>
						<td class="blue">
							&nbsp;
						</td>
					</tr>
				</table>
			</div>
			
			
			
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
function getdisplay(info)
{
//alert(info);
if(document.getElementById(info).style.display=='none')
{
document.getElementById(info).style.display='';
}
else
{
document.getElementById(info).style.display='none'
}

}

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
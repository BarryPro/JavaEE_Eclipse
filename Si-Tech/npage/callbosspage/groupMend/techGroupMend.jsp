<%@page contentType="text/html;charset=GBK"%>
<HTML>
	<HEAD>
		<TITLE>���������</TITLE>
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
					<div id="Operation_Title"><B><font face="Arial">Ա����ѡ������</font></B></div>
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
							��������
						</td>
						<td class="blue">
							����������
						</td>
						<td class="blue">
							Ĭ�ϼ�����
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
					<div id="Operation_Title"><B><font face="Arial">�����������Ϣ</font></B></div>
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
							���ܶ��б��
						</td>
						<td class="blue">
							���ܶ�������
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
					<div id="Operation_Title"><B><font face="Arial">Ա����ǰǩ�����</font></B></div>
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
							���ܶ��б��
						</td>
						<td class="blue">
							���ܶ�������
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
							<input class="b_foot" name="submit1" type="button" value="ȷ��"
								onclick="submitConfig()">
							<input class="b_foot" name="cancel" type="button"
								onclick="goaway();" value="ȡ��">
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
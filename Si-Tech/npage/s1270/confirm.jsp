<%@ page contentType="text/html; charset=GBK" %>
<html>
<head>
		<script language="javascript" src="/njs/redialog/rd-config.js"></script>
		<link href="/nresources/default/css/FormText.css" rel="stylesheet" type="text/css"></link>
		<link href="/nresources/default/css/font_color.css" rel="stylesheet" type="text/css"></link>	
</head>
<%
	String offerName_alert =(String)request.getParameter("offerName_alert");
	String offerName =offerName_alert.substring(0,offerName_alert.length()-1);
	String[]  offerNames = offerName.split(",");
%>

<script language="javascript" >
function wRtn(s)
{
	window.returnValue=s;
	window.close();	
}
</script>

<body>
	 <div class="popup">
	<input type=hidden id="rdHideReturnValue" value="0" />
	<table width = "100%">
		<tr align= "center" valign="center">
			<td>	
				<div class="popup_zi orange" id="message" 
					style="height:260px;position: relative;OVERFLOW-y:auto;">
					<div  style="width:300px;position: absolute;top: 50%;left: 50%;">
						<p style="position: relative;top: -50%;left:-50%">
							主资费变更生效同时可选资费:</br>
							<%
							for(  int i = 0 ; i < offerNames.length; i++)
							{
							%>
								<%=offerNames[i]%></br>
							<%
							}				
							%>
							将被取消，请确认是否变更主资费。				
						</p>
					</div>
				</div>
			</td>
		</tr>
		<tr  align= "center">
			<td>
				<input type="button" name="rdBtnOK" value="确定" onClick="javascript:wRtn('1')" class="b_foot" >
				<input type="button" name="rdBtnCancel" value="取消" onClick="javascript:wRtn('0')" class="b_foot" >				
			</td>	
		</tr>
	</table>
	</div>
<script language="javascript" src="/njs/redialog/corerd-face-control.js"></script>
<script language="javascript" src="/njs/redialog/coreevent-handle-confirm.js"></script>
</body>
</html>

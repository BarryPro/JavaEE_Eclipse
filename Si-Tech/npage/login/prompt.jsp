<%@ page contentType="text/html; charset=GBK" %>
<html>
<head>
		<script language="javascript" src="/njs/redialog/rd-config.js"></script>
		<link href="/nresources/default/css/FormText.css" rel="stylesheet" type="text/css"></link>
		<link href="/nresources/default/css/font_color.css" rel="stylesheet" type="text/css"></link>	
</head>
<%
	String content =(String)request.getParameter("content");
	String[]  contentArr = content.split("\\|");
	for(int i=0;i<contentArr.length;i++){
		System.out.println(contentArr[i]);
	}
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
							<%
							for(  int i = 0 ; i < contentArr.length; i++)
							{
							%>
								<%=contentArr[i]%></br>
							<%
							}				
							%>
						</p>
					</div>
				</div>
			</td>
		</tr>
		<tr  align= "center">
			<td>
				<input type="button" name="rdBtnCancel" value="¹Ø±Õ" onClick="javascript:wRtn('0')" class="b_foot" >				
			</td>	
		</tr>
	</table>
	</div>
<script language="javascript" src="/njs/redialog/corerd-face-control.js"></script>
<script language="javascript" src="/njs/redialog/coreevent-handle-confirm.js"></script>
</body>
</html>

<%@ page contentType= "text/html;charset=gb2312" %>
<%
  String openPage = request.getParameter("openPage");
%>
<html>
<script>

   onload = function()
   {
      document.all.contFrame.src = "<%=openPage%>";
   }
   
</script>
<body rightmargin="0" leftMargin=0 topMargin=0 marginheight="0" marginwidth="0" style="OVERFLOW-Y:hidden;OVERFLOW-X:hidden;">
<table width="100%" height="100%" border="0" cellpadding="0" cellspacing="0">
	<tr>
		<td valign="top">
			 <iframe id="contFrame" src="" marginwidth=0 marginheight=0 align="right" valign="top" width=100% height="100%" scrolling=auto frameborder=0 noresize></iframe>
 		</td>
 	</tr>
</table>
</body>
</html>
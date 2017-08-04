<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page contentType="text/html; charset=GBK" %>


<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<%

    
	String photozheng = request.getParameter("photozheng");
	String photofan = request.getParameter("photofan"); 
	String three = request.getParameter("three"); 

	String opName = "查看客户身份证照片"; 
	
%>
<html>
<head>
<title>查看客户身份证照片</title>
<META content=no-cache http-equiv=Pragma>
<META content=no-cache http-equiv=Cache-Control>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<script language="JavaScript">

</script>

</head>

<body>
<FORM method=post name="fPubSimpSel">
	<%@ include file="/npage/include/header_pop.jsp" %>

	<div class="title">
		<div id="title_zi">查看客户身份证照片</div>
	</div>

	<table cellspacing="0">
		<tr>
			<td align=center>
				<img name="custPhoto" width=1000 height=612 src="http://10.110.2.150:33000/photos/photos/<%=photozheng%>.JPG"></img>
			</td>
		</tr>
	</table>
	<table cellspacing="0">
		<tr>
			<td align=center>
				<img name="custPhoto" width=1000 height=612 src="http://10.110.2.150:33000/photos/photos/<%=photofan%>.jpg"></img>
			</td>
		</tr>
	</table>
	<table cellspacing="0">
		<tr>
			<td align=center>
				<img name="custPhoto" width=1000 height=612 src="http://10.110.2.150:33000/photos/photos/<%=three%>.jpg"></img>
			</td>
		</tr>
	</table>

    <TABLE cellSpacing="0">
    <TBODY>
        <TR> 
            <TD align=center id="footer"> 
                <input class="b_foot" name=back onClick="window.close();" style="cursor:hand" type=button value=关闭>&nbsp;        
            </TD>
        </TR>
    </TBODY>
    </TABLE>

	<%@ include file="/npage/include/footer_pop.jsp" %>
</FORM>
</body>

</html>

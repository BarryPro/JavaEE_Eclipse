<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<html>
	<%
		String opCode = "m014";
		String opName = "IMS固话过户（Centrex）";
	%>
	<script language="javascript">
		$(document).ready(function(){
			
			var obj = window.dialogArguments;
			var errPhone = obj.errPhone;
			var errCode = obj.errCode;
			var errMsg = obj.errMsg;
			errPhone = errPhone.substring(0,errPhone.length-1)
			errCode = errCode.substring(0,errCode.length-1)
			errMsg = errMsg.substring(0,errMsg.length-1)
			var errPhoneArr = errPhone.split("|");
			var errCodeArr = errCode.split("|");
			var errMsgArr = errMsg.split("|");
			var insertStr = "";
			$.each(errPhoneArr,function(i,n){
				insertStr += "<tr>";
				insertStr += "<td>"+errPhoneArr[i]+"</td>";
				insertStr += "<td>"+errCodeArr[i]+"</td>";
				insertStr += "<td>"+errMsgArr[i]+"</td>";
				insertStr += "</tr>";
			});
			$("#resultTab").empty().append(insertStr);
		});
		
	</script>
<body>
	<FORM method=post name="fPubSimpSel">   
	<%@ include file="/npage/include/header_pop.jsp" %>
	<table cellSpacing="0">
		<tr>
			<th>固话号码</th>
			<th>返回编码</th>
			<th>返回信息</th>
		</tr>
		<tbody id="resultTab">
		</tbody>
	</table>
	<TABLE cellSpacing=0>
		<TR id="footer"> 
		<TD align=center>
			<input class="b_foot" onClick="window.close();" style="cursor:hand" type="button" value="确认"/>
		</TD>
		</TR>
	</TABLE>
	<%@ include file="/npage/include/footer_pop.jsp" %>
</FORM>
</body>
</html>
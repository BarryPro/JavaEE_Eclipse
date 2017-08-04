<html>
<head>

<script>
<%/*if(com.sitech.bean.login.LoginUtil.canConsulation((String)session.getAttribute("workNo"))) {*/%>
  canConsulation = true;
<%/*} else {*/%>
  canConsulation = false;
<%/*}*/%>
//var activeXWin = top.voiceFrame.document.scripts;
function login(){
	alert("agent3.jsp login");
  tryLogin(document.forms[0].workId.value.substring(1,6));
}

function onloadtrylogin1(){
	setTimeout(tryLogin,20000); 
}


</script>
</head>

<body>
<center>

		<input type="hidden" name="agentCall" />

<form>
<input type="hidden" name="callingNumber" value ="" />
<input type=hidden name=workId value='<%=session.getAttribute("workNo")%>'>
</form>
</center>
</body>
</html>


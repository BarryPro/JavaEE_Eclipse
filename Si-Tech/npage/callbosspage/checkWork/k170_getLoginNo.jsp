<%@ page contentType="text/html;charset=gb2312"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="com.sitech.crmpd.core.wtc.util.*,java.util.*"%>
<%
	String opCode = "170";
	String opName = "���Ų�ѯ";
	String login_no =request.getParameter("login_no");
	String contactMonth =request.getParameter("contactMonth");

%>
<html>
<head>
<title>���Ų�ѯ</title>

<script language=javascript>

function win(){

//alert(document.form1.treeValue.value);
//window.opener.document.getElementById("call_cause_id").value=document.form1.node_Id.value;
window.close();
}
function submitInput(){
	if( document.sitechform.login_no.value == ""){
    	  showTip(document.sitechform.login_no,"���Ų���Ϊ�գ������ѡ�������");
        sitechform.login_no.focus();
    }

   else {
    hiddenTip(document.sitechform.login_no);
    doSubmit();
    }
}

function doSubmit(){
    window.sitechform.myaction.value="doLoad";
    window.sitechform.action="k170_getLoginNo.jsp";
    window.sitechform.method='post';
    window.sitechform.submit();
}


</script>
</head>
<body>
<form name="form1" method="POST" action="">	
<div id="Operation_Table"> 
	  	<div class="title" id="footer">	 
 		����&nbsp;<input name="login_no" type="text"  id="login_no" value="" >
   <input name="search" type="button"  id="search" value="��ѯ" onClick="submitInput('k170_getLoginNo.jsp?myaction=doLoad')"> &nbsp;&nbsp;
   	  <table cellspacing="0" >
	  	<tr>
	  		<td>����</td>
	  		<td>����</td>
	  		<td>����</td>
	  	</tr>
	  	<tr>
	  		<td></td>
	  		<td></td>
	  		<td></td>
	  	</tr>
	  	<tr>
	  		<td></td>
	  		<td></td>
	  		<td></td>
	  	</tr>
		</table>
	</div>
	<div id="Operation_Table">

  </form>
</body>
</html>
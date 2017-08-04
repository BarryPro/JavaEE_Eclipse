<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">



<%@ page contentType="text/html; charset=GB2312" %>

<%@ include file="/npage/include/public_title_name.jsp" %>

<%

	String opCode = WtcUtil.repStr(request.getParameter("opCode"), "");

	String opName = WtcUtil.repStr(request.getParameter("opName"), "");

%>

<html>

<head>

<title><%=opName%></title>

<META content="MSHTML 5.00.3315.2870" name=GENERATOR>

<script language=javascript>

	var opFlag;	
	window.onload = function() {
		opchange();
	}

	function opchange() {

		if (document.getElementsByName("opFlag")[0].checked) {

			opFlag = "1";

<%

			if ("e860".equals(opCode) || "e863".equals(opCode)) {

%>

				document.getElementById("opCode").value = "e860";

				document.getElementById("opName").value = "集团重要成员调出申请";


<%

			}

%>


		} else if (document.getElementsByName("opFlag")[1].checked) {

			opFlag = "2";

<%

			if ("e860".equals(opCode) || "e863".equals(opCode)) {

%>

				document.getElementById("opCode").value = "e863";

				document.getElementById("opName").value = "集团重要成员调入处理";


<%

			}

%>


		}

	}

	

	function submitt() {

		if (opFlag == "1") {

			buttonSub = document.getElementById("cubmitt");

			buttonSub.disabled = "true";

			

			frm.action = "fe860_1.jsp";

			frm.submit();

		} else if (opFlag == "2") {

				buttonSub = document.getElementById("cubmitt");
				buttonSub.disabled = "true";			
				frm.action = "fe863_1.jsp";
				frm.submit();
		}

	}

</script>

</head>

<body>



<form name="frm" method="POST">

<input type="hidden" name="opCode" id="opCode" value="<%=opCode%>">

<input type="hidden" name="opName" id="opName" value="<%=opName%>">



<%@ include file="/npage/include/header.jsp" %>

<div class="title">

	<div name="title_zi" id="title_zi"><%=opName%></div>

</div>



<table cellspacing="0">

	<tr>

		<td class="blue" width="30%">

			操作类型

		</td>

		<td width="70%">

<%

			if ("e860".equals(opCode)) {

%>

			<input type="radio" name="opFlag" value="1" onclick="opchange()" checked>集团重要成员调出申请&nbsp;&nbsp;

			<input type="radio" name="opFlag" value="2" onclick="opchange()" >集团重要成员调入处理&nbsp;&nbsp;

<%

			} else if ("e863".equals(opCode)) {

%>

			<input type="radio" name="opFlag" value="1" onclick="opchange()" >集团重要成员调出申请&nbsp;&nbsp;

			<input type="radio" name="opFlag" value="2" onclick="opchange()" checked>集团重要成员调入处理&nbsp;&nbsp;

<%

			}

%>

		</td>

	</tr>


	         </TR>    

           

</table>

<table cellspacing="0">

	<tr>

	    <td colspan="3" id="footer">

	      <input class="b_foot" type=button name="cubmitt" value="确定" onClick="submitt();">

	      <input class="b_foot" type=button name="closeB" value="关闭" onClick="parent.removeTab('<%=opCode%>')">

	    </td>

	</tr>

</table>

<%@ include file="/npage/include/footer_simple.jsp" %> 

</form>

</body>

</html>




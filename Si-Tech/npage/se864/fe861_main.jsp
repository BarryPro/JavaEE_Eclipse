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

			if ("e861".equals(opCode) || "e862".equals(opCode)) {

%>

				document.getElementById("opCode").value = "e861";

				document.getElementById("opName").value = "������Ҫ��Ա��������";


<%

			}

%>


		} else if (document.getElementsByName("opFlag")[1].checked) {

			opFlag = "2";

<%

			if ("e861".equals(opCode) || "e862".equals(opCode)) {

%>

				document.getElementById("opCode").value = "e862";

				document.getElementById("opName").value = "������Ҫ��Ա��������";


<%

			}

%>


		}

	}

	

	function submitt() {

		if (opFlag == "1") {

			buttonSub = document.getElementById("cubmitt");

			buttonSub.disabled = "true";

			

			frm.action = "fe861_1.jsp";

			frm.submit();

		} else if (opFlag == "2") {

				buttonSub = document.getElementById("cubmitt");
				buttonSub.disabled = "true";			
				frm.action = "fe862_1.jsp";
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

			��������

		</td>

		<td width="70%">

<%

			if ("e861".equals(opCode)) {

%>

			<input type="radio" name="opFlag" value="1" onclick="opchange()" checked>������Ҫ��Ա��������&nbsp;&nbsp;

			<input type="radio" name="opFlag" value="2" onclick="opchange()" >������Ҫ��Ա��������&nbsp;&nbsp;

<%

			} else if ("e862".equals(opCode)) {

%>

			<input type="radio" name="opFlag" value="1" onclick="opchange()" >������Ҫ��Ա��������&nbsp;&nbsp;

			<input type="radio" name="opFlag" value="2" onclick="opchange()" checked>������Ҫ��Ա��������&nbsp;&nbsp;

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

	      <input class="b_foot" type=button name="cubmitt" value="ȷ��" onClick="submitt();">

	      <input class="b_foot" type=button name="closeB" value="�ر�" onClick="parent.removeTab('<%=opCode%>')">

	    </td>

	</tr>

</table>

<%@ include file="/npage/include/footer_simple.jsp" %> 

</form>

</body>

</html>




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

			if ("1008".equals(opCode) || "d948".equals(opCode)) {

%>

				document.getElementById("opCode").value = "1008";

				document.getElementById("opName").value = "�����ر�����   ";
				$("#seled").empty();
				$("#seled").append("<option value='03' selected>�ٱ�����</option><option value='02'>ʡ�ڼ��</option>");
				

<%

			}

%>


		} else if (document.getElementsByName("opFlag")[1].checked) {

			opFlag = "2";

<%

			if ("1008".equals(opCode) || "d948".equals(opCode)) {

%>

				document.getElementById("opCode").value = "d948";

				document.getElementById("opName").value = "�����ָ��ͻ��������� ";
				$("#seled").empty();
				$("#seled").append("<option value='02' selected>ʡ�ڼ��</option><option value='04'>�û�Ͷ��</option>");

<%

			}

%>


		}

	}

	

	function submitt() {
		
		var flag4A = allCheck4A("<%=opCode%>");
		if(!flag4A){
			return false;
		}

		if (opFlag == "1") {

			buttonSub = document.getElementById("cubmitt");
			document.getElementById("optype").value = document.all.seled.value;
			buttonSub.disabled = "true";
			frm.action = "f1008main.jsp";

			frm.submit();

		} else if (opFlag == "2") {

				buttonSub = document.getElementById("cubmitt");
				document.getElementById("optype").value = $("#seled").val();
				buttonSub.disabled = "true";			
				frm.action = "fd948main.jsp";
				frm.submit();
		}

	}

</script>

</head>

<body>



<form name="frm" method="POST">

<input type="hidden" name="opCode" id="opCode" value="<%=opCode%>">
<input type="hidden" name="opName" id="opName" value="<%=opName%>">
<input type="hidden" name="optype" id="optype" >


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

			if ("1008".equals(opCode)) {

%>

			<input type="radio" name="opFlag" value="1" onclick="opchange()" checked>1008-�����ر���������&nbsp;&nbsp;

			<input type="radio" name="opFlag" value="2" onclick="opchange()" >d948-�����ָ��ͻ���������&nbsp;&nbsp;



<%

			} else if ("d948".equals(opCode)) {

%>

			<input type="radio" name="opFlag" value="1" onclick="opchange()" >1008-�����ر���������&nbsp;&nbsp;

			<input type="radio" name="opFlag" value="2" onclick="opchange()" checked>d948-�����ָ��ͻ���������&nbsp;&nbsp;
 

<%

			}

%>

		</td>

	</tr>

           <TR id="bltys"  style="display:none"> 
	          <TD width="16%" class="blue">������Դ</TD>
              <TD >
                 <select id="seled" style="width:100px;">
									</select>

	          </TD>
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
<!-- 2014/12/26 14:47:50 gaopeng �������ƽ��ģʽ�����������Ϣģ���������� ���빫��ҳ�� openType����������ͨ���У��Ͷ����๫��У��-->
<jsp:include page="/npage/public/intf4A/common/intfCommon4A.jsp">
	<jsp:param name="openType" value="SPECIAL"  />
</jsp:include>

<%@ include file="/npage/include/footer_simple.jsp" %> 

</form>

</body>

</html>




<%
  /*
   * 功能: 外网高端客户带机转网
   * 版本: 1.0
   * 日期: 20110617
   * 作者: 王怀峰wanghfa
   * 版权: si-tech
  */
%>
<!DOCTYPE html PUBLIC "-//W3C//Dtd Xhtml 1.0 transitional//EN" "http://www.w3.org/tr/xhtml1/Dtd/xhtml1-transitional.dtd">
<%@	page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%
  response.setHeader("Pragma","No-Cache"); 
  response.setHeader("Cache-Control","No-Cache");
  response.setDateHeader("Expires", 0); 
  request.setCharacterEncoding("GBK");
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>外网高端客户带机转网</title>
<META content="MSHTML 5.00.3315.2870" name=GENERATOR>
<%
	String opCode=request.getParameter("opCode");
	String opName=request.getParameter("opName");
	String workNo=(String)session.getAttribute("workNo");
	String regionCode=(String)session.getAttribute("regCode");
%>
<script language="javascript">

	window.onload=function() {
		opchange();
	}
	
	function opchange() {
		if(document.getElementsByName("opFlag")[0].checked == true) {
	  	document.getElementById("backAcceptBody").style.display = "none";
		} else if(document.getElementsByName("opFlag")[1].checked == true) {
	  	document.getElementById("backAcceptBody").style.display = "";
		}
	}

	function resetFrm() {
		document.getElementById("backAcceptBody").value = "";
	}
	
	function controlBtn(flag) {
		$("#submitBtn").attr("disabled", flag);
		//$("#resetBtn").attr("disabled", flag);
		$("#closeBtn").attr("disabled", flag);
	}
	
	function submitt() {
		controlBtn(true);
		if(document.getElementsByName("opFlag")[0].checked == true) {
			$("#opCode").val("d925");
			$("#opName").val("外网高端客户带机转网申请");
			document.frm.action = "fd925_main.jsp";
		} else if(document.getElementsByName("opFlag")[1].checked == true) {
			if (document.getElementById("backAccept").value.trim().length == 0) {
				rdShowMessageDialog("请输入冲正流水！", 1);
				controlBtn(false);
				return false;
			}
			
			$("#opCode").val("d926");
			$("#opName").val("外网高端客户带机转网冲正");
			document.frm.action = "fd926_main.jsp";
		}
		
		document.frm.submit();
	}
</script>
</head>
<body>
<form name="frm" method="POST" >
 	<input type="hidden" name="opCode" id="opCode" value="<%=opCode%>">
 	<input type="hidden" name="opName" id="opName" value="<%=opName%>">

	<%@ include file="/npage/include/header.jsp" %>
	<div class="title">
		<div id="title_zi">选择操作类型</div>
	</div>
<table cellspacing="0">
	<tr>
		<td class="blue" width="30%">电话号码</td>
		<td width="70%"> 
			<input type="text" name="activePhone" id="activePhone" value="<%=activePhone%>" id="activePhone" class="InputGrey" readOnly>
		</td>
	</tr>
	<tr>
		<td class="blue">操作类型</td>
		<td>
			<input type="radio" name="opFlag" onclick="opchange()" checked>申请&nbsp;&nbsp;
			<input type="radio" name="opFlag" onclick="opchange()">冲正
		</td>
	</tr>
	<tbody name="backAcceptBody" id="backAcceptBody" style="display:none">
		<tr>
			<td class="blue" width="30%">冲正流水</td>
			<td width="70%"> 
				<input type="text" name="backAccept" id="backAccept" value="">
			</td>
		</tr>
	</tbody>
	<tr>
		<td colspan="2" align="center" id="footer">
			<input class="b_foot" type=button name="submitBtn" id="submitBtn" value="确认" onClick="submitt()">
			<input class="b_foot" type=button name="closeBtn" id="closeBtn" value="关闭" onClick="removeCurrentTab()">
		</td>
	</tr>
</table>
    <input type="hidden" id="flag" name="flag" value=""/>
    <%@ include file="/npage/include/footer_simple.jsp" %>
</form>
</body>
</html>

<!DOCTYPE html PUBLIC "-//W3C//Dtd Xhtml 1.0 transitional//EN" "http://www.w3.org/tr/xhtml1/Dtd/xhtml1-transitional.dtd">
<%
  /*
   * 功能:异常交易监控配置修改界面
   * 版本: 1.0
   * 日期: 2009/12/24
   * 作者: gaolw
   * 版权: si-tech
  */
%>
<%@	page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ include file="/npage/bill/getMaxAccept.jsp" %>
<%@ page import="java.util.*" %>

<%
	response.setHeader("Pragma","No-Cache"); 
	response.setHeader("Cache-Control","No-Cache");
	response.setDateHeader("Expires", 0); 
 
	String opCode = "8364";
	String opName = "异常交易监控配置";
	String iLoginAccept = "";
	iLoginAccept = getMaxAccept();
	
	String temloginNo = request.getParameter("temloginNo");
	String temopCode = request.getParameter("temopCode");
	String temlimitValue = request.getParameter("temlimitValue");
%>

<html xmlns="http://www.w3.org/1999/xhtml">
<HEAD>
<script language="JavaScript">

function commJsp(){//确认按钮
	if(document.form1.limitValue.value.length < 1) {
		rdShowMessageDialog("请输入阀值！");
		document.getElementById("limitValue").focus();
		return false;
	}
	
	if(rdShowConfirmDialog('确认要提交修改信息吗？')==1)
	{
		document.form1.action="f8364_3modCfm.jsp";
	 	form1.submit();
	}
}

</script> 
 
<title>修改异常交易监控配置信息</title>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
</head>
<BODY>
<form  method="post" name="form1"  >
	<%@ include file="/npage/include/header.jsp" %>
	<div class="title">
		<div id="title_zi">修改异常交易监控配置信息</div>
	</div>
<table cellspacing="0">  
	<tr>
		<td class="blue" width="15%">工号</td>
		<td colspan="3">
			<input type="text" name="loginNo" id="loginNo" value="<%=temloginNo%>" maxlength="6"  class="InputGrey" readonly size="10">
		</td>
	</tr>           
	<tr>
		<td class="blue" width="15%">业务代码</td>
		<td colspan="3">
			<input type="text" name="opCodeAdd" value="<%=temopCode%>" id="opCodeAdd" maxlength="60" class="InputGrey" readonly size="40">	
		</td>
	</tr>
	<tr>
		<td class="blue" width="15%">阀值</td>
		<td colspan="3">
			<input type="text" name="limitValue" value="<%=temlimitValue%>" id="limitValue" v_must="1" v_type="0_9" style="ime-mode:disabled" onKeyPress="return isKeyNumberdot(0)" maxlength="4" size="30">
		</td>
	</tr>	
	
	<tr> 
		<td align="center" id="footer" colspan="4"> 
			<input type="button" name="confirm" class="b_foot" value="确认" onclick="commJsp()">
			&nbsp;&nbsp;&nbsp;
			<input type="button" name="return" class="b_foot" value="返回" onclick="location='f8364_3.jsp?loginNo=<%=temloginNo%>'">
		</td>
	</tr>
</table>
  <input type="hidden" name="opCode" value="<%=opCode%>">
	<input type="hidden" name="opName" value="<%=opName%>">
	<input type="hidden" name="iLoginAccept" value="<%=iLoginAccept%>">
	
	<%@ include file="/npage/include/footer.jsp" %>
</form>
</BODY>
</HTML>
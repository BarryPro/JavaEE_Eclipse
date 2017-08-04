<!DOCTYPE html PUBLIC "-//W3C//Dtd XHTML 1.0 transitional//EN" "http://www.w3.org/tr/xhtml1/Dtd/xhtml1-transitional.dtd">
<%
  /*
   * 功能: 电信管控 d344
   * 版本: 1.0
   * 日期: 2011/3/25
   * 作者: huangrong
   * 版权: si-tech
   * update:
  */
%>
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%
	String hdword_no =(String)session.getAttribute("workNo");//工号
	String phoneNo = (String)request.getParameter("activePhone");
	String opCode="d344";
	String opName="电信管控";
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>电信管控</title>
</head>
<body>
<form action="" method=post name="form1">
	<%@ include file="/npage/include/header.jsp" %>
	<div class="title">
		<div id="title_zi">请选择操作类型</div>
	</div>

	<table cellspacing="0">
	<tr>
		<td class="blue">操作类型</td>
		<td  class="blue">
			<input type="radio" name="opFlag" value="K" checked>强开
			<input type="radio" name="opFlag" value="N"> 强关
		</td>
	</tr>

	<tr>
		<td class="blue">服务号码</td>
		<td>
			<input name="phoneNo" value="<%=phoneNo%>" class="InputGrey" readonly>
		</td>
	</tr>
	<tr>
		<td align=center colspan="2">
			<input class="b_foot" name=sure  type=button value=确认 onClick="if(check(form1))  pageSubmit();" >
			<input class="b_foot" name=reset onClick="" type="reset" value=清除>
			<input class="b_foot" name=close onClick="removeCurrentTab()" type=button value=关闭>
		</td>
	</tr>
</table>
	<%@ include file="/npage/include/footer_simple.jsp" %>
</form>
</body>
</html>

<script language="javascript">
	function pageSubmit(){
		form1.action="fd344_2.jsp";
		form1.submit();
	}
</script>




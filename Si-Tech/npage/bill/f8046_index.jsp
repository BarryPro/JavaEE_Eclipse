<!DOCTYPE html PUBLIC "-//W3C//Dtd Xhtml 1.0 transitional//EN" "http://www.w3.org/tr/xhtml1/Dtd/xhtml1-transitional.dtd">
<%
  /*
   * 功能: 营销案取消8046
   * 版本: 1.0
   * 日期: 2010/11/03
   * 作者: huangrong
   * 版权: si-tech
   * update:
  */
%>
<%@	page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%
	request.setCharacterEncoding("GBK");
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>营销案取消</title>
<%

  String opCode=request.getParameter("opCode");
	String opName=request.getParameter("opName");	
	String phoneNo = (String)request.getParameter("activePhone");
  String workNo=(String)session.getAttribute("workNo");
  String regionCode=(String)session.getAttribute("regCode");
  String[][] favInfo=(String[][])session.getAttribute("favInfo");
%>

<META content=no-cache http-equiv=Pragma>
<META content=no-cache http-equiv=Cache-Control>
<META content="MSHTML 5.00.3315.2870" name=GENERATOR>
<script language="javascript">
  onload=function()
  {
		document.all.opFlag[0].checked=true;
  }

//----------------验证及提交函数-----------------
function doCfm(subButton)
{
	var radio1 = document.getElementsByName("opFlag");
	var flag = document.getElementById("flag");
	for(var i=0;i<radio1.length;i++)
	{
		if(radio1[i].checked)
		{
			var opFlag = radio1[i].value;
			if(opFlag=="one")
			{
				flag.value="0";			
			}else if(opFlag=="two")
			{
				flag.value="1";
			}
			frm.action="f8046_login.jsp";
			document.all.opcode.value="8046";
		}
  }
	frm.submit();	
	return true;
}

</script>
</head>
<body>
<form name="frm" method="POST" onKeyUp="chgFocus(frm)">
 	<input type="hidden" name="opcode" >
	<%@ include file="/npage/include/header.jsp" %>
	<div class="title">
		<div id="title_zi">选择操作类型</div>
	</div>
<table cellspacing="0">
	<tr> 
		<td class="blue" width="20%">操作类型</td>
		<td colspan="3">
			<input type="radio" name="opFlag" value="one">生效营销案取消&nbsp;&nbsp;
			<input type="radio" name="opFlag" value="two">预约营销案取消&nbsp;&nbsp;
			<input type="hidden" name="phoneNo" value="<%=phoneNo%>">
			<input type="hidden" name="flag" id="flag" value="">
			
			
		</td>
	</tr>     
	<tr> 
		<td colspan="4" align="center" id="footer"> 
			<input class="b_foot" type=button name="confirm" value="确认" onClick="doCfm(this)" index="2">    
			<input class="b_foot" type=button name=qryP value="关闭" onClick="removeCurrentTab();">
		</td>
	</tr>
</table>
    <%@ include file="/npage/include/footer_simple.jsp" %>
</form>
</body>
</html>

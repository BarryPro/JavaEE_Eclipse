<!DOCTYPE html PUBLIC "-//W3C//Dtd Xhtml 1.0 transitional//EN" "http://www.w3.org/tr/xhtml1/Dtd/xhtml1-transitional.dtd">
<%
  /*
   * 功能: WLAN普通资费套餐申请
   * 版本: 1.0
   * 日期: 2010/6/24
   * 作者: dujl
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
<title>WLAN普通资费套餐申请</title>
<%

    String opCode=request.getParameter("opCode");
	String opName=request.getParameter("opName");	
	String phoneNo = (String)request.getParameter("activePhone");
    String workNo=(String)session.getAttribute("workNo");
    String regionCode=(String)session.getAttribute("regCode");
%>

</script>
<META content=no-cache http-equiv=Pragma>
<META content=no-cache http-equiv=Cache-Control>
<META content="MSHTML 5.00.3315.2870" name=GENERATOR>
<script language="javascript">
onload=function()
{
	var opCode = "<%=opCode%>";
	if(opCode=="9387")
	{
		document.all.opFlag[0].checked=true;
	}
	if(opCode=="9388")
	{
		document.all.opFlag[1].checked=true;
	}
	if(opCode=="9389")
	{
		document.all.opFlag[2].checked=true;
	}
}

//----------------验证及提交函数-----------------
function doCfm(subButton)
{
	controlButt(subButton);			//延时控制按钮的可用性

	var radio1 = document.getElementsByName("opFlag");
	for(var i=0;i<radio1.length;i++)
	{
		if(radio1[i].checked)
		{
			var opFlag = radio1[i].value;
			if(opFlag=="10")
			{
				document.all.opCode.value="9387";
				document.all.opName.value="WLAN普通资费套餐申请";
				frm.action="f9387_1.jsp";
			}
			else if(opFlag=="11")
			{
				document.all.opCode.value="9388";
				document.all.opName.value="WLAN普通资费套餐变更";
				frm.action="f9388_1.jsp";
			}
			else if(opFlag=="12")
			{
				document.all.opCode.value="9389";
				document.all.opName.value="WLAN普通资费套餐取消";
				frm.action="f9388_1.jsp";
			}
		}
	}
	
	frm.submit();	
	return true;
}

function controlButt(subButton)
{
	subButt2 = subButton;
	subButt2.disabled = true;
	setTimeout("subButt2.disabled = false",3000);
}

</script>
</head>
<body>
<form name="frm" method="POST" onKeyUp="chgFocus(frm)">
	<input type="hidden" name="opCode" value="<%=opCode%>">
	<input type="hidden" name="opName" value="<%=opName%>">
	<%@ include file="/npage/include/header.jsp" %>
	<div class="title">
		<div id="title_zi">选择操作类型</div>
	</div>
<table cellspacing="0">
	<tr>
		<td class="blue" width="20%">操作类型</td>
		<td colspan="3">
			<input type="radio" name="opFlag" value="10"" checked>套餐申请&nbsp;&nbsp;
			<input type="radio" name="opFlag" value="11">套餐变更&nbsp;&nbsp;
			<input type="radio" name="opFlag" value="12">套餐取消
		</td>
	</tr>
	<tr>
		<td class="blue">手机号码</td>
		<td>
			<input type="text" size="15" name="srv_no" value="<%=activePhone%>" id="srv_no" v_minlength=1 v_maxlength=16 v_type="mobphone" v_must=1 maxlength="11" index="0" class="InputGrey" readOnly>
				<font color="orange">*</font>
		</td>
	</tr>   
	<tr>
		<td colspan="4" align="center" id="footer"> 
			<input class="b_foot" type=button name="confirm" value="确认" onClick="doCfm(this)" index="2">
			<input class="b_foot" type=button name=back value="清除" onClick="frm.reset()">
			<input class="b_foot" type=button name=qryP value="关闭" onClick="removeCurrentTab();">
		</td>
	</tr>
</table>
    <%@ include file="../../npage/common/pwd_comm.jsp" %>
    <%@ include file="/npage/include/footer_simple.jsp" %>
</form>
</body>
</html>

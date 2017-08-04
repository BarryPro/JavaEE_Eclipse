<!DOCTYPE html PUBLIC "-//W3C//Dtd Xhtml 1.0 transitional//EN" "http://www.w3.org/tr/xhtml1/Dtd/xhtml1-transitional.dtd">
<%
  /*
   * 功能: 动感地带高校迎新入网赠话费4428
   * 版本: 1.0
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
<title>动感地带高校迎新入网赠话费</title>
<%
    //String opCode="4428";
	//String opName="动感地带高校迎新入网赠话费";
	
    String opCode=request.getParameter("opCode");
	String opName=request.getParameter("opName");
	String ReqPageName = WtcUtil.repNull(request.getParameter("ReqPageName"));
	//String phoneNo = (String)request.getParameter("activePhone");
	activePhone = WtcUtil.repNull(request.getParameter("activePhone"));
    String workNo=(String)session.getAttribute("workNo");
%>

</script>
<META content=no-cache http-equiv=Pragma>
<META content=no-cache http-equiv=Cache-Control>
<META content="MSHTML 5.00.3315.2870" name=GENERATOR>
<script language="javascript">
onload=function()
{
	var opCode = "<%=opCode%>";
	if(opCode=="4428")
	{
		document.all.opFlag[0].checked=true;
		opchange();		
	}
	if(opCode=="4429")
	{
		document.all.opFlag[1].checked=true;  
		opchange();			
	}
}

//----------------验证及提交函数-----------------
function doCfm()
{
/*	var radio1 = document.getElementsByName("opFlag");
	for(var i=0;i<radio1.length;i++)
	{
		if(radio1[i].checked)
		{
			var opFlag = radio1[i].value;
			if(opFlag=="one")
			{
				frm.action="f4428_1.jsp";
				document.all.opCode.value="4428";
			}
			else if(opFlag=="two")
			{
				frm.action="f4428_1.jsp";
				document.all.opCode.value="4429";
			}
		}
  	}*/
	frm.submit();
}

/* function controlButt(subButton){
	subButt2 = subButton;
    subButt2.disabled = true;
	setTimeout("subButt2.disabled = false",3000);
  }*/
  
function opchange()
{
	if(document.all.opFlag[0].checked==true) 
	{

	}else 
	{
	
	}
}
</script>
</head>
<body>
<form name="frm" method="POST" onKeyUp="chgFocus(frm)" action="f4428_1.jsp">
 	<input type="hidden" name="opCode" value="<%=opCode%>">
 	<input type="hidden" name="opName" value="<%=opName%>">
 	<input type="hidden" name="activePhone" value="<%=activePhone%>">
	<%@ include file="/npage/include/header.jsp" %>
	<div class="title">
		<div id="title_zi">选择操作类型</div>
	</div>
<table cellspacing="0">
	<tr> 
		<td class="blue" width="20%">操作类型</td>
		<td colspan="3">
			<input type="text" name="opFlag" value="申请" class="InputGrey" readOnly onclick="opchange()">&nbsp;&nbsp;
			<input type="hidden" name="opFlag" value="two" onclick="opchange()">
		</td>
	</tr>    
	<tr> 
		<td class="blue">手机号码 </td>
		<td> 
			<input type="text" size="12" name="phone_no" value="<%=activePhone%>" id="phone_no" v_minlength=1 v_maxlength=16 v_type="mobphone" v_must=1 maxlength="11" index="0" class="InputGrey" readOnly>
				<font color="orange">*</font>
		</td>
	</tr>
	<tr> 
		<td colspan="4" align="center" id="footer"> 
			<input class="b_foot" type=button name="confirm" value="确认" onClick="doCfm();" index="2">
			<input class="b_foot" type=button name=qryP value="关闭" onClick="removeCurrentTab();">
		</td>
	</tr>
</table>
    <%@ include file="../../npage/common/pwd_comm.jsp" %>
    <%@ include file="/npage/include/footer_simple.jsp" %>
</form>
</body>
</html>

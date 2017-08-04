<!DOCTYPE html PUBLIC "-//W3C//Dtd Xhtml 1.0 transitional//EN" "http://www.w3.org/tr/xhtml1/Dtd/xhtml1-transitional.dtd">
<%
  /*
   * 功能: 赠送预存款 8379
   * 版本: 1.0
   * 日期: 2010/3/12
   * 作者: sunaj
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
<title>赠送预存款</title>
<%
    //String opCode="8379";
	//String opName="赠送预存款";
	
    String opCode=request.getParameter("opCode");
	String opName=request.getParameter("opName");	
	String phoneNo = (String)request.getParameter("activePhone");
    String workNo=(String)session.getAttribute("workNo");
    String regionCode=(String)session.getAttribute("regCode");
    String[][] favInfo=(String[][])session.getAttribute("favInfo");
	boolean workNoFlag=false;
	if(workNo.substring(0,1).equals("k"))
		workNoFlag=true;
%>
  </script>
<META content=no-cache http-equiv=Pragma>
<META content=no-cache http-equiv=Cache-Control>
<META content="MSHTML 5.00.3315.2870" name=GENERATOR>
<script language="javascript">

onload=function()
{
  	var opCode = document.frm.opcode.value;
  	if(opCode=="b894")
  	{
		 
		document.all.opFlag[0].checked=true;
		opchange();		
  	}
  	if(opCode=="b941")
  	{
		 
		document.all.opFlag[1].checked=true;  
		opchange();			
  	}
}

//----------------验证及提交函数-----------------
function doCfm(subButton)
{
	controlButt(subButton);			//延时控制按钮的可用性
//	if(!check(frm)) return false; 
	//alert('11111 '+document.frm.opcode.value);
	if(document.all.opcode.value=="b894"){
		frm.action="fb894_1.jsp";
	}
	if(document.all.opcode.value=="b941"){
		if(rdShowConfirmDialog('确认要提交信息吗？')==1)
		{
			frm.action="fb941_1.jsp";
		}
		
		
	}
	
	
 
			
		
  
	frm.submit();	
	return true;
}
 function controlButt(subButton){
	subButt2 = subButton;
    subButt2.disabled = true;
	setTimeout("subButt2.disabled = false",3000);
  }
function opchange()
{
	 
	 if(document.all.opFlag[0].checked==true) 
	{
	   
		document.frm.opcode.value = "b894";

	}else {
		 
	  	document.frm.opcode.value = "b941";
	}
}
</script>
</head>
<body>
<form name="frm" method="POST" onKeyUp="chgFocus(frm)">
 	<input type="hidden" name="opcode" value = "b941" >
	<%@ include file="/npage/include/header.jsp" %>
	<div class="title">
		<div id="title_zi">选择操作类型</div>
	</div>
<table cellspacing="0">
	<tr> 
		<td class="blue" width="20%">操作类型</td>
		<td colspan="3">
			<input type="radio" name="opFlag" value="one" onc   onclick = "opchange()"  >申请&nbsp;&nbsp;
			<!--xl 新加冲正--> 
			<input type="radio" name="opFlag" value="two"   onclick = "opchange()" checked = "checked">冲正
		</td>
	</tr>    
	<tr> 
		<td class="blue">手机号码 </td>
		<td> 
			<input type="text" size="12" name="srv_no" value="<%=activePhone%>" id="srv_no" v_minlength=1 v_maxlength=16 v_type="mobphone" v_must=1 maxlength="11" index="0" class="InputGrey" readOnly>
				<font color="orange">*</font>
		</td>
	</tr>
	<tr style="display:none" id="backaccept_id"> 
		<td class="blue">业务流水</td>
		<td colspan="3">
			<input class="button" type="text" name="backaccept" v_must=1 >
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

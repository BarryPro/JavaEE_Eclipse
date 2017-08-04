<!DOCTYPE html PUBLIC "-//W3C//Dtd Xhtml 1.0 transitional//EN" "http://www.w3.org/tr/xhtml1/Dtd/xhtml1-transitional.dtd">
<%
  /*
   * 功能: 集团统一预存赠礼6949
   * 版本: 1.0
   * 日期: 2008/12/30
   * 作者: leimd
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
<title>集团统一预存赠礼</title>
<%
    String opCode="6949";
	String opName="集团统一预存赠礼";	
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
  	var opCode = "<%=opCode%>";
  	if(opCode=="6949"){
		document.all.opFlag[0].checked=true;
		opchange();		
  	}
  	if(opCode=="6950"){
		document.all.opFlag[1].checked=true;  
		opchange();			
  	}
  }
//----------------验证及提交函数-----------------
function doCfm(subButton)
{
	controlButt(subButton);			//延时控制按钮的可用性
//	if(!check(frm)) return false; 
	var radio1 = document.getElementsByName("opFlag");
	for(var i=0;i<radio1.length;i++)
	{
		if(radio1[i].checked)
		{
			var opFlag = radio1[i].value;
			if(opFlag=="one") {
				document.getElementById("preFlag").value = "0";
				frm.action="f6949_1.jsp";
				document.all.opcode.value="6949";
			} else if(opFlag=="two") {
				if(document.all.backaccept.value==""){
					rdShowMessageDialog("请输入业务流水！",1)
					return;
				}
				document.getElementById("preFlag").value = "0";
				frm.action="f6950_1.jsp";
				document.all.opcode.value="6950";
			} else if(opFlag=="three") {
				document.getElementById("preFlag").value = "1";
				frm.action="f6949_1.jsp";
				document.all.opcode.value="6949";
			} else if(opFlag=="four") {
				if(document.all.backaccept.value==""){
					rdShowMessageDialog("请输入业务流水！",1)
					return;
				}
				document.getElementById("preFlag").value = "1";
				frm.action="f6950_1.jsp";
				document.all.opcode.value="6950";
			} else if(opFlag=="five") {
				frm.action="f6949_qry.jsp";
				document.all.opcode.value="6949";
			}
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
function opchange(){
	
	 if(document.all.opFlag[0].checked==true || document.all.opFlag[2].checked==true || document.all.opFlag[4].checked==true) 
	{
	  	document.all.backaccept_id.style.display = "none";
	}else{
	  	document.all.backaccept_id.style.display = "";
	}
}
</script>
</head>
<body>
<form name="frm" method="POST" onKeyUp="chgFocus(frm)">
 	<input type="hidden" name="opcode" >
 	<input type="hidden" name="preFlag" id="preFlag" value="">
 	
	<%@ include file="/npage/include/header.jsp" %>
	<div class="title">
		<div id="title_zi">选择操作类型</div>
	</div>
<table cellspacing="0">
	<tr> 
		<td class="blue" width="20%">操作类型</td>
		<td colspan="3">
			<input type="radio" name="opFlag" value="one" onclick="opchange()">申请&nbsp;&nbsp;
			<input type="radio" name="opFlag" value="two" onclick="opchange()">冲正&nbsp;&nbsp;
			<input type="radio" name="opFlag" value="three" onclick="opchange()">预约申请&nbsp;&nbsp;
			<input type="radio" name="opFlag" value="four" onclick="opchange()">预约冲正&nbsp;&nbsp;
			<input type="radio" name="opFlag" value="five" onclick="opchange()">查询
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

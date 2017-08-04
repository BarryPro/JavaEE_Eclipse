<!DOCTYPE html PUBLIC "-//W3C//Dtd Xhtml 1.0 transitional//EN" "http://www.w3.org/tr/xhtml1/Dtd/xhtml1-transitional.dtd">
<%
  /*
   * 功能: 手机邮箱5元版商用申请
   * 版权: si-tech
  */
%>
<%@	page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%
	request.setCharacterEncoding("GBK");
%>

	<%
		//String opCode = "9911";	
		//String opName = "手机邮箱5元版商用申请";
		String opCode = request.getParameter("opCode");
    String opName = request.getParameter("opName");
	%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<title><%=opName%></title>
<META content=no-cache http-equiv=Pragma>
<META content=no-cache http-equiv=Cache-Control>
<META content="MSHTML 5.00.3315.2870" name=GENERATOR>
<script language="javascript">
onload=function()
{
	document.all.srv_no.focus();
}
//----------------验证及提交函数-----------------
function doCfm()
{
	frm.action="f9912_b.jsp";
	frm.submit();
	return true;			 
}

</script>
</head>
<body>
<form name="frm" method="POST" onKeyUp="chgFocus(frm)">
	<form name="frm" method="POST" onKeyUp="chgFocus(frm)">
	<%@ include file="/npage/include/header.jsp" %>  
	<div class="title">
		<div id="title_zi"><%=opName%></div>
	</div>	
	<input type="hidden" name="opcode" value="<%=opCode%>" />
	<input type="hidden" name="opCode" value="<%=opCode%>" />
	<input type="hidden" name="opName" value="<%=opName%>" />
	<table cellspacing="0">      
		<tr> 
			<td width="16%" nowrap class="blue">手机号码</td>		            
			<td>
			    <input  type="text" size="12" name="srv_no" id="srv_no" v_minlength=1 v_maxlength=16 v_type="mobphone" v_must=1   maxlength="11" index="0" value =<%=activePhone%>  readonly class="InputGrey">
			    <font class="orange">*</font>
			</td>           
		</tr>
	</table>
	<table cellSpacing=0>
		<tr> 
			<td id="footer" > 	            
              		<input class="b_foot" type=button name="confirm" value="确认" onClick="doCfm()" index="2">    
		      	<input class="b_foot" type=button name=qryP value="关闭" onClick="removeCurrentTab();">		             
			</td>
		</tr>
	</table>
      <%@ include file="/npage/include/footer_simple.jsp" %>		
   </form>
</body>
</html>

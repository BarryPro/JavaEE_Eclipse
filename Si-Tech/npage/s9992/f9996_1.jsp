<%
/********************
 version v2.0
 开发商: si-tech
 作者: dujl
********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html  xmlns="http://www.w3.org/1999/xhtml">
	
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page contentType="text/html;charset=GBK"%>
<%@ page import="java.util.*"%>
<%
  request.setCharacterEncoding("GBK");
%>
<html>
<head>
<title>手机支付账户信息查询</title>

<%
//    String opCode = "9996";
//    String opName = "手机支付账户信息查询";
    String opCode=request.getParameter("opCode");
    String opName=request.getParameter("opName");
    String phoneNo = request.getParameter("activePhone");
    String orgCode =(String)session.getAttribute("orgCode");
	String regionCode = orgCode.substring(0,2);

%>

</script>
<META content=no-cache http-equiv=Pragma>
<META content=no-cache http-equiv=Cache-Control>
<META content="MSHTML 5.00.3315.2870" name=GENERATOR>

<script language=javascript>
onload=function()
{
	self.focus();
}

//----------------验证及提交函数-----------------
function check_HidPwd()
{
	if(document.frm.phoneNo.value=="")
	{
		 rdShowMessageDialog("请输入手机号码!");
		 document.frm.phoneNo.focus();
		 return false;
	}

  	if( document.frm.phoneNo.value.length != 11 )
  	{
		rdShowMessageDialog("手机号码只能是11位!");
		document.frm.phoneNo.value = "";
		return false;
  	}
}

function doCfm()
{
	if(document.frm.phoneNo.value=="")
  	{
	     rdShowMessageDialog("请输入手机号码!");
	     document.frm.phoneNo.focus();
	     return false;
  	}
  	
  	if( document.frm.phoneNo.value.length != 11 )
  	{
	     rdShowMessageDialog("手机号码只能是11位!");
	     document.frm.phoneNo.value = "";
	     return false;
  	}
  	
  	frm.submit();
}

</script>
</head>
<body>
	
<form name="frm" method="POST" action="f9996_2.jsp">
<%@ include file="/npage/include/header.jsp" %> 	
	<div class="title">
		<div id="title_zi"><%=opName%></div>
	</div>
    <table cellspacing="0">
		<tr>
			<td class="blue" width="20%">手机号码</td>
			<td> 
				<input class="button"type="text" name="phoneNo" size="20" maxlength="11"  onKeyPress="return isKeyNumberdot(0)" onKeyDown="if(event.keyCode==13) check_HidPwd();">
			</td>
		</tr>
		<tr> 
			<td colspan="2" id="footer"> 
		  		<div align="center"> 
				  <input class="b_foot" type=button name="confirm" value="查询" onClick="doCfm()" index="2">    
				  <input class="b_foot" type=button name=back value="清除" onClick="frm.reset()">
				  <input class="b_foot" type=button name=qryP value="关闭" onClick="removeCurrentTab();">
		  		</div>
			</td>
		</tr>
	</table>
      
<input type="hidden" name="opCode" value="<%=opCode%>" >
<input type="hidden" name="opName" value="<%=opName%>" >
<%@ include file="/npage/include/footer_simple.jsp" %>
</form>
   
</body>
</html>


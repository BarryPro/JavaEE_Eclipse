<%
/********************
 version v2.0
 开发商: si-tech
 update zhaohaitao at 2009.01.15
 模块:预存话费赠电池-申请
********************/
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
	
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page contentType="text/html;charset=GBK"%>
<%
  request.setCharacterEncoding("GBK");
%>
<html  xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>预存话费赠电池-申请</title>
<%
	
	String opCode = request.getParameter("opCode");
  	String opName = request.getParameter("opName");
  	String phoneNo = request.getParameter("activePhone");

%>

<META content=no-cache http-equiv=Pragma>
<META content=no-cache http-equiv=Cache-Control>
<META content="MSHTML 5.00.3315.2870" name=GENERATOR>

<script language=javascript>
 
  onload=function()
  {
 	self.status="";
  }

//----------------验证及提交函数-----------------
function doCfm()
{
  if(check(frm))
  {
    frm.action="f1292Main.jsp";
    frm.submit();	
  }
}
</script>
</head>
<body>
	
<form name="frm" method="POST">
<%@ include file="/npage/include/header.jsp" %>   
  	
<div class="title">
	<div id="title_zi"><%=opName%></div>
</div>
<table cellspacing="0">
    <tr> 
        <td class="blue"> 
          <div align="left">服务号码</div>
        </td>
      <td> 
        <div align="left"> 
                <input class="InputGrey"  type="text" size="12" value="<%=phoneNo%>" name="srv_no" id="srv_no" v_minlength=1 v_maxlength=16 v_type="mobphone" readOnly index="0">
      </td>
    </tr>       
	<tr> 
		<td colspan="4" id="footer"> 
			<div align="center"> 
			<input class="b_foot" type=button name=qryPage value="确认" onClick="doCfm()" index="2">    
			<input class="b_foot" type=button name=back value="清除" onClick="frm.reset()">
			<input class="b_foot" type=button name=qryP value="关闭" onClick="removeCurrentTab()">
			</div>
		</td>
    </tr>
</table>
	<input type="hidden" name="opCode" value="<%=opCode%>">
	<input type="hidden" name="opName" value="<%=opName%>">
   <%@ include file="/npage/include/footer_simple.jsp" %>   
   </form>
</body>
</html>
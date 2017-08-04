<%
  String opCode = request.getParameter("opCode");
  String opName = request.getParameter("opName");
%>              

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http//www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http//www.w3.org/1999/xhtml">
<%@ include file="/npage/include/public_title_name.jsp" %> 

<%@ page contentType="text/html;charset=GB2312"%>
<%@ page import="java.util.*"%>
<%
  request.setCharacterEncoding("GBK");
%>
<html>
<head>
<title>空中选号开户冲正</title>
 
	 	
<META content=no-cache http-equiv=Pragma>
<META content=no-cache http-equiv=Cache-Control>
<META content="MSHTML 5.00.3315.2870" name=GENERATOR>
<script language=javascript>
 

//----------------验证及提交函数-----------------
function doCfm(subButton)
{
  controlButt(subButton);//延时控制按钮的可用性
  
	  frm.action="f5927_2.jsp";
  	frm.submit();
  	return true;
}

</script>
</head>
<body>

<form name="frm" method="POST" onKeyUp="chgFocus(frm)">
	<%@ include file="/npage/include/header.jsp" %>                         


	<div class="title">
		<div id="title_zi">空中选号开户冲正</div>
	</div>

<input type="hidden" name="opCode" value="<%=opCode%>">
<input type="hidden" name="opName" value="<%=opName%>">
      <table>

         <tr>
            <td width="16%"  class=blue>
              <div align="left">手机号码</div>
            </td>
            <td nowrap  width="34%" >
            <div align="left">
                <input   type="text" size="12" name="srv_no" id="srv_no" value="<%=activePhone%>" readOnly class="InputGrey" index="0">
                <font class="orange">*</font> </div>
            </td>

     
         </tr>
         <tr >
            <td colspan="5" id="footer" >
              <input  type=button name="confirm" class="b_foot" value="确认" onClick="doCfm(this)" index="2">
              <input  type=button name=back  class="b_foot" value="清除" onClick="frm.reset()">
		      		<input  type=button name=qryP  class="b_foot" value="关闭" onClick="removeCurrentTab();">
           </td>
        </tr>
      </table>
   <%@ include file="/npage/include/footer.jsp" %>
   </form>
</body>
</html>
<%
/********************
 * version v2.0
 * 开发商: si-tech
 * author: huangrong
 * date  : 20101103
 ********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%
  request.setCharacterEncoding("GBK");
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>预约营销案查询</title>

<%
	String opCode = (String)request.getParameter("opCode");
  String opName = (String)request.getParameter("opName");
%>

<META content=no-cache http-equiv=Pragma>
<META content=no-cache http-equiv=Cache-Control>
<META content="MSHTML 5.00.3315.2870" name=GENERATOR>
<script language=javascript>
//----------------验证及提交函数-----------------
function doCfm(subButton)
{
  controlButt(subButton);//延时控制按钮的可用性
  
  
  if(document.frm.phone_no.value.trim() ==""&&document.frm.cust_id.value.trim() == "")
  {
		rdShowMessageDialog("请注意，手机号码与用户ID至少输入一个!");
		return;
  }
  frm.submit();
  return true;
}
</script>
</head>
<body>
<form name="frm" action="fb824_2.jsp" method="POST" onKeyUp="chgFocus(frm)">
<%@ include file="/npage/include/header.jsp" %>
<div class="title">
	<div id="title_zi"><%=opName%></div>
</div>
<input type="hidden" name="opCode" value="<%=opCode%>">
<input type="hidden" name="opName" value="<%=opName%>">
    <table cellspacing="0">
      <tr>
        <td class=blue>手机号码</td>
	 			<td><input type="text" name="phone_no" value="" maxlength="15"></td>
        <td class=blue>用户ID</td>
	 			<td><input type="text" name="cust_id" value=""  maxlength="14"></td>
      </tr>
      
      <tr>
        <td colspan="6" id="footer">
          <div align="center">
          <input class="b_foot" type=button name="confirm" value="确认" onClick="doCfm(this)" index="2">
          <input class="b_foot" type=button name=back value="清除" onClick="frm.reset();">
    			<input class="b_foot" type=button name=qryP value="关闭" onClick="removeCurrentTab();">
          </div>
        </td>
      </tr>
    </table>
<%@ include file="/npage/include/footer_simple.jsp" %>
</form>
</body>
</html>

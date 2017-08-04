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
<%@ include file="../../npage/bill/getMaxAccept.jsp" %>
<%
  request.setCharacterEncoding("GBK");
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>订单查询</title>

<%
	String opCode = (String)request.getParameter("opCode");
  String opName = (String)request.getParameter("opName");
  String orgCode = (String)session.getAttribute("orgCode");
  String regionCode = orgCode.substring(0,2);
  String printAccept="";
	printAccept = getMaxAccept();
	System.out.println(printAccept);
%>

<META content=no-cache http-equiv=Pragma>
<META content=no-cache http-equiv=Cache-Control>
<META content="MSHTML 5.00.3315.2870" name=GENERATOR>
<script language=javascript>
//----------------验证及提交函数-----------------
function doCfm(subButton)
{
  controlButt(subButton);//延时控制按钮的可用性
  if(document.frm.s_order_code.value.trim().length == 0)
  {
		rdShowMessageDialog("请输入子订单编号!");
		return;
  }
  frm.submit();
  return true;
}
</script>
</head>
<body>
<form name="frm" action="fb883_2.jsp" method="POST" onKeyUp="chgFocus(frm)">
<%@ include file="/npage/include/header.jsp" %>
<div class="title">
	<div id="title_zi"><%=opName%></div>
</div>
<input type="hidden" name="opCode" value="<%=opCode%>">
<input type="hidden" name="opName" value="<%=opName%>">
    <table cellspacing="0">
      <tr>
        <td class="blue" width="20%">子订单编号</td>
	 			<td><input type="text" name="s_order_code" value="" maxlength="20"><font class="orange">*</font></td>
      </tr>
      
      <tr>
        <td colspan="2" id="footer">
          <div align="center">
          <input class="b_foot" type=button name="confirm" value="确认" onClick="doCfm(this)" index="2">
          <input class="b_foot" type=button name=back value="清除" onClick="frm.reset();">
    			<input class="b_foot" type=button name=qryP value="关闭" onClick="removeCurrentTab();">
          </div>
        </td>
      </tr>
    </table>
<!------------------------>
<input type="hidden" name="printAccept" value="<%=printAccept%>">  
<input type="hidden" name="opcode" value="<%=opCode%>">     
<%@ include file="/npage/include/footer_simple.jsp" %>
</form>
</body>
</html>


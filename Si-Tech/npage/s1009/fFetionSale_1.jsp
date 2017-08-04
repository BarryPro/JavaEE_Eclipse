<%
/********************
 * version v2.0
 * 开发商: si-tech
 * author: daixy
 * date  : 20100628
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
<title>飞信营销案查询</title>

<%
	String opCode = (String)request.getParameter("opCode");
    String opName = (String)request.getParameter("opName");
	String userPhoneNo=request.getParameter("activePhone");
    if(null==userPhoneNo||userPhoneNo.equals("")){
      userPhoneNo = request.getParameter("phone_no");
    }
%>

<META content=no-cache http-equiv=Pragma>
<META content=no-cache http-equiv=Cache-Control>
<META content="MSHTML 5.00.3315.2870" name=GENERATOR>
<script language=javascript>
//----------------验证及提交函数-----------------
function doCfm(subButton)
{
  controlButt(subButton);//延时控制按钮的可用性
  if(document.frm.iYearMonth.value.length != 6)
  {
	rdShowMessageDialog("请注意，查询年月的值应为YYYYMM!");
	return;
  }
  frm.submit();
  return true;
}
</script>
</head>
<body>
<form name="frm" action="fFetionSale_2.jsp" method="POST" onKeyUp="chgFocus(frm)">
<%@ include file="/npage/include/header.jsp" %>
<div class="title">
	<div id="title_zi"><%=opName%></div>
</div>
<input type="hidden" name="opCode" value="<%=opCode%>">
<input type="hidden" name="opName" value="<%=opName%>">
    <table cellspacing="0">
      <tr>
         <td class=blue>手机号码</td>
	 <td><input name="iPhoneNo" type="text" value="<%=userPhoneNo%>" class="InputGrey" readonly></td>
         <td class=blue>查询年月</td>
	 <td><input type="text" name="iYearMonth" value="" v_must=1 maxlength="6">
	 	<font class="orange">*YYYYMM</font></td>
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

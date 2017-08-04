<%
/********************
 version v2.0
开发商: si-tech
********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>

<%
  String opName = "促销品统一付奖";
	response.setHeader("Pragma","No-Cache");
	response.setHeader("Cache-Control","No-Cache");
	response.setDateHeader("Expires", 0);
	
	String num = request.getParameter("num");
	String showName = request.getParameter("showName");
	String code = request.getParameter("code");
	
%>
<html>
	<head>
		<title>促销品统一付奖</title>
	</head>
<script type="text/javascript">

function reValue()
{
	var cardNo=document.all.cardNo.value;
	if(isNaN(cardNo))
	{
			rdShowMessageDialog("获赠城市通卡号不是数字,请重新输入!");
	 		return false;
	}
  if(cardNo.trim().length!=12)
  {
  	rdShowConfirmDialog("获赠城市通卡号必须是12位,请重新输入!");
		return false;
  }
 		var retvalue=cardNo;
    window.returnValue = retvalue;
    window.close();
}
</script>
<body>
<form name="frm" method="POST">
<%@ include file="/npage/include/header_pop.jsp" %>
	<div class="title">
		<div id="title_zi"><%=showName%></div>
	</div>
  <table cellspacing="0">
			<td class="blue">付款明细第<%=num%>记录    获赠城市通卡号</td>
			<td colspan="3">
				<input type="text" name="cardNo" maxlength="12" value="<%=code%>">
				<font color="orange">*</font> 
    </tr>
    </table>
   
    <table cellspacing="0">
    <tr>
    	<td colspan="4" id="footer">
				<div align="center">
				<input name="confirm" class="b_foot" id="confirm" type="button"  value="确认" onClick="reValue()" >
					&nbsp;
				<input name="reset" class="b_foot" type="button" value="关闭" onClick="window.close();">
					&nbsp;
				</div>
			</td>
   	</tr>
	</TABLE>

<%@ include file="/npage/include/footer_pop.jsp" %>
</form>
</body>
</html>

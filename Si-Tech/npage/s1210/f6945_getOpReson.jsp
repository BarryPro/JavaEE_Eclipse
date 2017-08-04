<%
  /*
   * 功能: 6945垃圾短信与网管黑名单综合受理--批量操作界面 获取操作原因 6945
   * 版本: 1.8.2
   * 日期: 2011/6/21
   * 作者: huangrong
   * 版权: si-tech
   * update:
  */
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>

<%
  String opName = "垃圾短信与网管黑名单综合受理_批量操作";
	response.setHeader("Pragma","No-Cache");
	response.setHeader("Cache-Control","No-Cache");
	response.setDateHeader("Expires", 0);
	String resonTxt = WtcUtil.repNull(request.getParameter("resonTxt"));
%>
<html>
	<head>
		<title>垃圾短信与网管黑名单综合受理_批量操作</title>
	</head>
<script type="text/javascript">

function reValue()
{
	var opReson=document.all.opReson.value;	
  window.returnValue = opReson;
  window.close();
}
</script>
<body>
<form name="frm" method="POST">
<%@ include file="/npage/include/header_pop.jsp" %>
	<div class="title">
		<div id="title_zi">垃圾短信与网管黑名单综合受理_批量操作</div>
	</div>
  <table cellspacing="0">
  	 </tr>
			<td class="blue">操作原因</td>
			<td>
				<input type="text" name="opReson" value="<%=resonTxt%>" maxlength="70" size="140">
      <td>
    </tr>  
    </table>
   
    <table cellspacing="0">
    <tr>
    	<td colspan="2" id="footer">
				<div align="center">
				<input name="confirm" class="b_foot" id="confirm" type="button"  value="确认" onClick="reValue()" >
					&nbsp;
				<input name="colse" class="b_foot" type="button" value="关闭" onClick="window.close();">
					&nbsp;
				</div>
			</td>
   	</tr>
	</TABLE>

<%@ include file="/npage/include/footer_pop.jsp" %>
</form>
</body>
</html>


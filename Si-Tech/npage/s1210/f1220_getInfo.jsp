<%
  /*
   * 功能: 获取卡的附属信息 1220
   * 版本: 1.8.2
   * 日期: 2011/6/16
   * 作者: huangrong
   * 版权: si-tech
   * update:
  */
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>

<%
  String opName = "换卡变更";
	response.setHeader("Pragma","No-Cache");
	response.setHeader("Cache-Control","No-Cache");
	response.setDateHeader("Expires", 0);
%>
<html>
	<head>
		<title>换卡变更</title>
	</head>
<script type="text/javascript">

function reValue()
{
	var productCode=document.all.productCode.value;
	if(productCode=="")
	{
			rdShowMessageDialog("厂商代码不能为空，请输入！");
			return false;		
	}
	var phoneModule=document.all.phoneModule.value;
	if(phoneModule=="")
	{
			rdShowMessageDialog("手机机型不能为空，请输入！");
			return false;		
	}	
	var errState=document.all.errState.value;	
	if(errState=="")
	{
			rdShowMessageDialog("故障现象不能为空，请输入！");
			return false;		
	}	
	var retvalue=productCode+"~"+phoneModule+"~"+errState;
  window.returnValue = retvalue;
  window.close();
}
</script>
<body>
<form name="frm" method="POST">
<%@ include file="/npage/include/header_pop.jsp" %>
	<div class="title">
		<div id="title_zi">卡的附属信息</div>
	</div>
  <table cellspacing="0">
  	 </tr>
			<td class="blue">厂商代码</td>
			<td>
				<input type="text" name="productCode" maxlength="10">
      <td>
    </tr>
  	 </tr>
			<td class="blue">手机机型</td>
			<td>
				<input type="text" name="phoneModule" maxlength="20" size="40">
      <td>
    </tr>    
  	 </tr>
			<td class="blue">故障现象</td>
			<td>
				<input type="text" name="errState" maxlength="30" size="60">
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

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%
  /*
   * 功能: 烟草通资费
   * 版本: 1.0
   * 日期: 2011-8-2 14:09:25
   * 作者: ningtn
   * 版权: si-tech
   * update:
  */
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<script type="text/javascript" src="/npage/public/pubScript.js"></script>	
<head>
	<title>烟草通资费</title>
	<%
		String opCode = request.getParameter("opCode");
		String opName = request.getParameter("opName");
		String workNo = (String)session.getAttribute("workNo");
		String regionCode= (String)session.getAttribute("regCode");
		String phoneNo = (String)request.getParameter("activePhone");
	%>
	<script language="JavaScript">
		function frmCfm(subButton){
			/* 按钮延迟 */
			controlButt(subButton);
			/* 事后提醒 */
			getAfterPrompt();
			/* 设置备注 */
			var opNoteObj = $("#opNote");
			if(opNoteObj.val() == ""){
				opNoteObj.val("操作员<%=workNo%>为<%=phoneNo%>做<%=opName%>操作");
			}
			/* 备注长度校验 */
			var opNoteVal =  opNoteObj.val();
			var opNoteLen = getByteLen(opNoteVal);
			if(opNoteLen > 60){
				rdShowMessageDialog("最多只允许输入30个汉字");
				return false;
			}
			/* 提交页面 */
			var confirmFlag = rdShowConfirmDialog("确认要提交操作吗?");
			if(confirmFlag!=1){
				return false;
			}
			frm.submit();
		}
		$(document).ready(function(){
			/* 页面初始化 */
			if("e147" == "<%=opCode%>"){
				$("#productTr").show();
			}else{
				$("#productTr").hide();
			}
		});
	</script>
<body>
<form name="frm" method="POST" action="fe147Cfm.jsp">
	<%@ include file="/npage/include/header.jsp" %>
	<div class="title">
		<div id="title_zi"><%=opName%></div>
	</div>
	<table cellspacing="0">
		<tr>
			<td class="blue">用户号码</td>
			<td colspan="3">
				<input type="text" id="phoneNo" name="phoneNo" value="<%=phoneNo%>" 
				 class="InputGrey" readOnly />
			</td>
		</tr>
		<tr id="productTr">
			<td class="blue">资费选择</td>
			<td colspan="3">
				<select id="productType" name="productType" onmouseover=FixWidth(this) >
					<wtc:qoption name="sPubSelect" outnum="2">
						<wtc:sql>
							select offer_id,offer_name from product_offer where offer_attr_type='YnYc' and sysdate between eff_date and exp_date
						</wtc:sql>
					</wtc:qoption>
				</select>
			</td>
		</tr>
		<tr>
			<td class="blue">操作备注</td>
			<td colspan="3">
				<input type="text" id="opNote" name="opNote" value="" size="60" maxlength="60" />
			</td>
		</tr>
	</table>
	<table cellspacing="0">
		<tr>
			<td noWrap id="footer">
			<div align="center">
				<input type="reset" name="query" class="b_foot" value="确认" onclick="frmCfm(this)" />
				&nbsp;
				<input type="reset" name="query" class="b_foot" value="取消"  />
				&nbsp;
				<input type="button" name="close" class="b_foot" value="关闭" onClick="removeCurrentTab();">
			</div>
			</td>
		</tr>
	</table>
	<input type="hidden" name="opCode" value="<%=opCode%>" />
	<input type="hidden" name="opName" value="<%=opName%>" />
	<%@ include file="/npage/include/footer.jsp" %>
</form>
</body>
</html>
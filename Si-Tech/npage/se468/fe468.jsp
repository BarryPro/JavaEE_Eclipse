<%
  /*
   * 功能: 签约优惠购机d069
   * 版本: 1.0
   * 日期: 2011-1-11 
   * 作者: 
   * 版权: si-tech
   * update:huangrong
 */
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<%@ page contentType="text/html; charset=GB2312" %>
<%@ include file="/npage/include/public_title_name.jsp" %>

<html>
<head>

<META content="MSHTML 5.00.3315.2870" name=GENERATOR>
<%
	String opCode = WtcUtil.repStr(request.getParameter("opCode"), "");
	String opName = WtcUtil.repStr(request.getParameter("opName"), "");
%>

<script language=javascript>

	function submitt() {
		var radio1 = document.getElementsByName("opFlag");
						   for(var i=0;i<radio1.length;i++)
				  {
					    if(radio1[i].checked)
						{
						  var opFlag = radio1[i].value;
								if (opFlag == "1") {//录入
								
								  frm.action = "fe468_1.jsp";
								  frm.submit();
							} else if (opFlag == "2") {//客户信息查询
					
									frm.action = "fe468_2.jsp";
									frm.submit();
							
							}
							 else if (opFlag == "3") {//历史信息查询
					
									frm.action = "fe468_3.jsp";
									frm.submit();
							
							}
							else if(opFlag == "4") {//报表查询
					
									frm.action = "fe468_4.jsp";
									frm.submit();
							
							}
								
				    }
		     }
		
	}
</script>
</head>
<body>

<form name="frm" method="POST">
<input type="hidden" name="opCode" id="opCode" value="<%=opCode%>">
<input type="hidden" name="opName" id="opName" value="<%=opName%>">

<%@ include file="/npage/include/header.jsp" %>
<div class="title">
	<div name="title_zi" id="title_zi"><%=opName%></div>
</div>

<table cellspacing="0">
	<tr>
		<td class="blue" width="30%">
			操作类型
		</td>
		<td width="70%">

			<input type="radio" name="opFlag" value="1"  checked>录入&nbsp;&nbsp;
			<input type="radio" name="opFlag" value="2"  >客户信息查询与删除&nbsp;&nbsp;
			<input type="radio" name="opFlag" value="3"  >历史信息查询&nbsp;&nbsp;
			<input type="radio" name="opFlag" value="4"  >报表查询&nbsp;&nbsp;


		</td>
	</tr>


</table>
<table cellspacing="0">
	<tr>
	    <td colspan="3" id="footer">
	      <input class="b_foot" type=button name="cubmitt" value="确定" onClick="submitt();">
	      <input class="b_foot" type=button name="closeB" value="关闭" onClick="parent.removeTab('<%=opCode%>');">
	    </td>
	</tr>
</table>
<%@ include file="/npage/include/footer_simple.jsp" %> 
</form>
</body>
</html>


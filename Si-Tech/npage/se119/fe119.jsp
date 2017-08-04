<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%
  /*
   * 功能: 工号网点查询
   * 版本: 1.0
   * 日期: 2011-08-19 
   * 作者: wanglma  finally
   * 版权: si-tech
   * update:
  */
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<script type="text/javascript" src="/npage/public/pubScript.js"></script>	
<head>
	<title>工号网点查询</title>
	<%
		String opCode = request.getParameter("opCode");
		String opName = request.getParameter("opName");
		String workNo = (String)session.getAttribute("workNo");
		String regionCode= (String)session.getAttribute("regCode");
	%>
	<script language="JavaScript">
	     function frmCfm(){
	         if($("#loginNo").val() == ""){
	         	 rdShowMessageDialog("请输入查询工号！");
	         	 return;
	         }	
	         var chkPacket = new AJAXPacket("fe119_getTab.jsp","请等待。。。");
		     chkPacket.data.add("loginNo" , $("#loginNo").val());
		     core.ajax.sendPacketHtml(chkPacket,showMsg);
		     chkPacket =null;
	     }
	     function showMsg(data){
	     	$("#showTabdiv").empty().append(data);
	     	if($("#code").val() != "000000"){
	     		rdShowMessageDialog("errorCode : "+$("#code").val() +" </br> errorMsg : "+$("#msg").val());
	     	}
	     }
	</script>
<body>
<form name="frm" method="POST" >
	<%@ include file="/npage/include/header.jsp" %>
	<div class="title">
		<div id="title_zi"><%=opName%></div>
	</div>
	<table cellspacing="0">
		<tr>
			<td class="blue">查询工号</td>
			<td colspan="3">
				<input type="text" id="loginNo" name="loginNo" />
			</td>
		</tr>
	</table>
	<table cellspacing="0">
		<tr>
			<td noWrap id="footer">
			<div align="center">
				<input type="reset" name="query" class="b_foot" value="确认" onclick="frmCfm(this)" />
				&nbsp;
				<input type="button" name="close" class="b_foot" value="关闭" onClick="removeCurrentTab();">
			</div>
			</td>
		</tr>
	</table>
	<div id="showTabdiv"></div>
	<input type="hidden" name="opCode" value="<%=opCode%>" />
	<input type="hidden" name="opName" value="<%=opName%>" />
	<%@ include file="/npage/include/footer.jsp" %>
</form>
</body>
</html>
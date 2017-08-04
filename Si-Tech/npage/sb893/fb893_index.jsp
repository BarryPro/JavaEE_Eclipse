<%
  /*
   * 功能: 网站开户 b893
   * 版本: 1.8.2
   * 日期: 2011/8/10
   * 作者: huangrong
   * 版权: si-tech
   * update:
  */
%>
            
<%
	String opCode = request.getParameter("opCode");
  String opName = request.getParameter("opName");
%>              
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http//www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http//www.w3.org/1999/xhtml">
<%@ include file="/npage/include/public_title_name.jsp" %> 
<%@ include file="../../npage/bill/getMaxAccept.jsp" %>
<%@ page import="com.sitech.crmpd.boss.bo.ContactInfo"%>
<%@ page contentType= "text/html;charset=GBK" %>
 
<HTML><HEAD><TITLE><%=opName%></TITLE>
<META content="text/html; charset=GBK" http-equiv=Content-Type>
<META content=no-cache http-equiv=Pragma>
<META content=no-cache http-equiv=Cache-Control>


<script language="JavaScript">
function queryCommit(){
  getAfterPrompt();	 
  /*
	if( document.frm.phoneNo.value==""){
		rdShowMessageDialog("手机号码不能为空，请输入！");
		return false;
	}		
	*/
	document.frm.query.disabled=true;//防止二次确认
	document.frm.action = "fb893_login.jsp";
	document.frm.submit();
}
</script>
</HEAD>
<BODY >
<FORM  method=post name=frm >
	<%@ include file="/npage/include/header.jsp" %>

	<div class="title">
		<div id="title_zi"><%=opName%></div>
	</div> 
  <table cellspacing="0">
		 	<tr>
	 			<td class="blue">身份证号</td>
	 			<td><input type="text" name="idCardNo" id="idCardNo" maxlength=20></td>
	 			<td class="blue">预占ID</td>
	 			<td ><input type="text" name="occupId" id="occupId" maxlength=20></td>
	 			<td class="blue">手机号码</td>
	 			<td><input type="text" name="phoneNo" id="phoneNo" maxlength=15></td>
			</tr>																	
	</table>
	<table>					
		 	<tr>	
		 		<td id="footer" colspan="6">
		 			<input type="button" id="query" class="b_foot" value="查询" onclick="queryCommit()">
		 			<input type="button" id="colse"  class="b_foot" value="关闭" onclick="removeCurrentTab()">
		 		</td>
		 	</tr>
	</table>
<input type="hidden" name="opCode"  value="<%=opCode%>">
<input type="hidden" name="opName" value="<%=opName%>">

</FORM>
		<%@ include file="/npage/include/footer.jsp"%>
</BODY> 	
</HTML>
						
  					


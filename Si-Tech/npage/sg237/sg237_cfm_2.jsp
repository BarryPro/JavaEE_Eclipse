<!DOCTYPE html PUBLIC "-//W3C//Dtd Xhtml 1.0 transitional//EN" "http://www.w3.org/tr/xhtml1/Dtd/xhtml1-transitional.dtd">

<%@	page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ include file="../../npage/bill/getMaxAccept.jsp" %>
<%request.setCharacterEncoding("GBK");%>
<%
	String opCode="g237";
	String opName="不良信息投诉解黑";	
	String phoneNo=(String)request.getParameter("phoneNo");
	String return_msg=(String)request.getParameter("return_msg"); 
	
%>
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<title>不良信息投诉解黑</title>
		<form name="frm" method="POST" action="sg237_cfm.jsp">
			<%@ include file="/npage/include/header.jsp" %>
			<div class="title">
				<div id="title_zi"><%=opName%></div>
			</div>
			<table cellspacing="0" >
				<tr>
					<td class="blue" width="15%">用户手机号码:</td>
					<td ><%=phoneNo%></td>
					<td><%=return_msg%></td>
				</tr>
			</table>
	 		<table cellspacing="0">
				<tr>
					<td noWrap id="footer">
					<div align="center">
						<input name="back" onClick="window.location.href='sg237.jsp?opCode=<%=opCode%>&opName=<%=opName%>'" type="button" class="b_foot"  value="返回" />
						&nbsp;
						<input type="button" name="close" class="b_foot" value="关闭" onClick="removeCurrentTab();"/>
					</div>
					</td>
				</tr>
			</table>
			<div id="gongdans"></div>	  
 			<%@ include file="/npage/include/footer.jsp" %>
		</form>
	</body>
</html>
<%
/********************
 version v2.0
开发商: si-tech
********************/
%>
<%@ page contentType="text/html;charset=GBK"%>
<%
		String pname = request.getParameter("pname");
		String width1 = request.getParameter("width1");
		String width2 = request.getParameter("width2");
		String pwd = request.getParameter("pwd");
		if(width1==null)  width1="";
		if(width2==null)  width2="";
%>
		<input name="<%=pname%>" type="password" onKeyPress="return isKeyNumberdot(0)" prefield="<%=pname%>" filedtype="pwd" functype="0" maxlength="6" disabled>
		<input name="cus_pass_button" onclick="showNumberDialog(document.all.<%=pname%>)" type=button class="b_text" value="输入">
					
			
			
			

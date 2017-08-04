<%
/********************
 version v2.0
开发商: si-tech
********************/
%>
<%@ page contentType="text/html; charset=GBK" %>
<%
			String width1 = request.getParameter("width1");
			String width2 = request.getParameter("width2");
			String pname = request.getParameter("pname");
			String pcname = request.getParameter("pcname");
			
			if(width1==null)  width1="";
			if(width2==null)  width2="";
 
%>
 
			<TD width="<%=width1%>" class="blue">密码</TD>
			<TD width="<%=width2%>">
				<input  name="<%=pname%>" type="password" maxlength="6"  class="button" >
				<input  onclick="showNumberDialog(document.all.<%=pname%>)" type="button"  class="b_text" value="输入">
			</TD>
			<TD width="<%=width1%>" class="blue">密码校验</TD>
			<TD width="<%=width2%>" class="blue">
				<input  name="<%=pcname%>"  type="password" maxlength="6" class="button" prefield="<%=pname%>" filedtype="pwd">
				<input  onclick="showReNumberDialog(document.all.<%=pcname%>)" type="button" class="b_text" value="再输入">
			</TD>
 

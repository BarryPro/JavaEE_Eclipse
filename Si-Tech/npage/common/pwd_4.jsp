<%
/********************
 version v2.0
������: si-tech
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
 
			<TD width="<%=width1%>" class=blue> 
				<div align="left">����</div>
			</TD>
			<!--
			readonly
			-->
			<TD width="<%=width2%>">
				<input name="<%=pname%>" type="password">&nbsp;
				<input class="b_text" onclick="showNumberDialog(document.all.<%=pname%>)" type="button" value="����">
			</TD>
			<TD width="<%=width1%>" class=blue> 
				<div align="left">����У��</div>
			</TD>
			<TD width="<%=width2%>">
				<input name="<%=pcname%>" type="password" prefield="<%=pname%>" filedtype="pwd">&nbsp;
			    <input class="b_text" onclick="showReNumberDialog(document.all.<%=pcname%>)" type="button" value="������">
			</TD>

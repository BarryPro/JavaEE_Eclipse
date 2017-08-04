

<%
/********************
 version v2.0
开发商: si-tech
********************/
%>
<%@ page contentType="text/html; charset=GB2312" %>
<%
String width1 = request.getParameter("width1");
String width2 = request.getParameter("width2");
String pname = request.getParameter("pname");
String pcname = request.getParameter("pcname");
String pvalue = request.getParameter("pvalue")==null?"":request.getParameter("pvalue");
if(width1==null)  width1="";
if(width2==null)  width2="";
 
%>
 
			<TD width="<%=width1%>" class="blue" > 
				<div align="left">密码</div>
			</TD>
			<!--
			readonly
			-->
			<TD width="<%=width2%>">
				<input name="<%=pname%>" type="password"  class="button" value="<%=pvalue%>">
				<input onclick="showNumberDialog(document.all.<%=pname%>)" type="button" value="输入"  class="b_text" >
			</TD>
			<TD width="<%=width1%>" class="blue" > 
				<div align="left">密码校验</div>
			</TD>
			<TD width="<%=width2%>">
				<input  name="<%=pcname%>" type="password"  class="button" prefield="<%=pname%>" filedtype="pwd" value="<%=pvalue%>">
			    <input  onclick="showReNumberDialog(document.all.<%=pcname%>)" type="button" value="再输入" class="b_text" >
			</TD>

<%
/********************
 version v2.0
������: si-tech
update zhaohaitao at 2009.02.05
********************/
%>
<%@ page contentType="text/html; charset=GBK" %>
<%
String width1 = request.getParameter("width1");
String width2 = request.getParameter("width2");
String pname = request.getParameter("pname");
String pcname = request.getParameter("pcname");
String pvalue = request.getParameter("pvalue");

if(width1==null)  width1="";
if(width2==null)  width2="";
 
%>
 
<TD class="blue"> 
	<div align="left">����</div>
</TD>
<!--
readonly
-->
<TD>
	<input name="<%=pname%>" type="password"  class="button" value="<%=pvalue%>">
	<input onclick="showNumberDialog(document.all.<%=pname%>)" type="button" class="b_text" value="����">
</TD>
<TD class="blue"> 
	<div align="left">����У��</div>
</TD>
<TD>
	<input  name="<%=pcname%>" type="password"  class="button" prefield="<%=pname%>" filedtype="pwd" value="<%=pvalue%>">
    <input  onclick="showReNumberDialog(document.all.<%=pcname%>)" type="button" class="b_text" value="������">
</TD>

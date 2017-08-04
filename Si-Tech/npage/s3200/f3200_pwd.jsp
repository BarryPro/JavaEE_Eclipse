   
<%
/********************
 version v2.0
 开发商 si-tech
 update hejw@2009-2-9
********************/
%>
        
<%@ page contentType="text/html; charset=GB2312" %>
<%
String pname = request.getParameter("pname");
String width1 = request.getParameter("width1");
String width2 = request.getParameter("width2");
String pwd = request.getParameter("pwd");
String pvalue = request.getParameter("pvalue")==null?"":request.getParameter("pvalue");
if(width1==null)  width1="";
if(width2==null)  width2="";
%>

<input name="<%=pname%>" type="password"  class="button" value="<%=pvalue%>">
<input onclick="showNumberDialog(document.all.<%=pname%>)" type=button value="输入" class="b_text">
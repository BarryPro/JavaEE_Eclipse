

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
				<input name="<%=pname%>" type="password" onblur="checkPwdEasy(document.all.<%=pname%>.value)" class="button" value="<%=pvalue%>" maxlength="6">
				<input id="btn1" type="button" value="输入"  class="b_text" >
				<font class="orange">*(默认密码<%=pvalue%>)</font>
			</TD>
			<TD width="<%=width1%>" class="blue" > 
				<div align="left">密码校验</div>
			</TD>
			<TD width="<%=width2%>">
				<input  name="<%=pcname%>" type="password"  class="button" prefield="<%=pname%>" filedtype="pwd" value="<%=pvalue%>" maxlength="6">
			    <input onclick="showNumberDialog(document.all.<%=pcname%>);" id="btn2" type="button" value="再输入" class="b_text" >
				<font class="orange">*(默认密码<%=pvalue%>)</font>
			</TD>
<script type="text/javascript">
	var btn1Obj = document.getElementById("btn1");    
	btn1Obj.attachEvent("onclick",foo);   
	btn1Obj.attachEvent("onclick",doo); 
	function foo(){
		checkPwdEasy(document.all.<%=pname%>.value);	
	}
	function doo(){
		showNumberDialog(document.all.<%=pname%>);	
	}
</script>

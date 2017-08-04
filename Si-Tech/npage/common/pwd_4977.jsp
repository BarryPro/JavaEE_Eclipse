<%

/*****************************************************
 Copyright (c) SI-TECH  Version V2.0
 All rights reserved
******************************************************/

%>
<%@ page contentType="text/html; charset=GBK" %>
<%
String width1 = request.getParameter("width1");
String width2 = request.getParameter("width2");
String pname = request.getParameter("pname");
String pcname = request.getParameter("pcname");
String pwdLength = request.getParameter("pwdLength");

if(width1==null)  width1="";
if(width2==null)  width2="";
if(pwdLength == null)  pwdLength = "6";
%>

<TD width="<%=width1%>" class="blue"><div align="left">รÜย๋</div></TD>
<TD width="<%=width2%>"><input name="<%=pname%>" type="password" onKeyPress="return isKeyNumberdot(0)" 
	class="button"  maxlength="<%=pwdLength%>"
	onblur="set4977pwd1()"
	pwdlength="<%=pwdLength%>"  value="" />
	<font class="orange">*</font> 
</TD>
<TD width="<%=width1%>" class="blue"><div align="left">รÜย๋ะฃั้</div></TD>
<TD width="<%=width2%>">
	<input  name="<%=pcname%>"   value=""   type="password" onKeyPress="return isKeyNumberdot(0)" 
	onblur="set4977pwd2()"
	 class="button" prefield="<%=pname%>" filedtype="pwd" maxlength="<%=pwdLength%>" onFocus="showReNumberDialog(document.all.<%=pcname%>)" pwdlength="<%=pwdLength%>">
	<font class="orange">*</font> 
</TD>

<%
/********************
 version v2.0
开发商: si-tech
********************/
%>
<%@ page contentType="text/html; charset=GBK" %>
<%
String pname = request.getParameter("pname");
String width1 = request.getParameter("width1");
String width2 = request.getParameter("width2");
String pwd = request.getParameter("pwd");

if(width1==null)  width1="";
if(width2==null)  width2="";
%>

<input name="<%=pname%>" type="password" >
<input class="b_text" onclick="testPassword(document.all.<%=pname%>);" type=button  value="输入">

<script language="JavaScript">
	function testPassword(obj) {
		var beforePassword = obj.value;
		obj.value = "";
		showNumberDialog(obj);
		if (obj.value != "") {
			doCheck(obj);
		} else if (obj.value == "") {
			obj.value = beforePassword;
		}
	}
</script>
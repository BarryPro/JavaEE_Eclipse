<%@ page contentType="text/html;charset=gb2312"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<html>
<head>
<title>≤‚ ‘</title>
<%
		out.println("<td class='Blue' width='50px'><input type='text' name='score' id='score' size='8' maxlength='2' onblur='sumScore();' value='' onkeyup=\"value=value.replace(/[^\\d]/g,'') \"onbeforepaste=\"clipboardData.setData('text',clipboardData.getData('text').replace(/[^\\d]/g,''))\"/></td>");
%>
</head>
</html>
<%
/********************
 version v2.0
开发商: si-tech
********************/
%>
<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>

<html>
  <head>
    <link href="<%=request.getContextPath()%>/css/jl.css" rel="stylesheet" type="text/css">
  </head>
  <body bgcolor="#649ECC" text="#000000" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  onkeydown="if(event.keyCode==8){return false}" >
<form >
  关键字<input type="text" name="quest" />
  <input type="button" onclick="doQry()" value="查询"/>
</form>
    
  </body>
</html>

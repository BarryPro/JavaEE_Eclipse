<%--
  Created by IntelliJ IDEA.
  User: belong
  Date: 16-10-30
  Time: 下午9:36
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title></title>
</head>
<body>
  <%
    session.invalidate();
    response.sendRedirect("index.jsp");
  %>
</body>
</html>

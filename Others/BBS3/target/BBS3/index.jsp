<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<!DOCTYPE html>
<html lang="zh">
  <head>
        <meta charset="utf-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        
    </head>
<body>
	<% 
		session.invalidate();
		response.sendRedirect("ArticleControl?action=query&curpage=1&userid=999"); 
	%>
</body>
</html>

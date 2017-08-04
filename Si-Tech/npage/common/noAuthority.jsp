<%
  /*
   * 功能:无权限页面
   * 版本: 1.0
   * 日期: 2014/11/13 14:12:24
   * 作者: gaopeng
   * 版权: si-tech
  */
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType= "text/html;charset=GBK" %>

<%
		response.setHeader("Pragma","No-Cache"); 
		response.setHeader("Cache-Control","No-Cache");
		response.setDateHeader("Expires", 0); 

%>
<html>
<head>
	<title>无权访问</title>
	
	<script language="javascript">
		
		
	
	</script>
	</head>
<body>
	<form action="" method="post" name="f1">
	<table align="center">
		<tr align="center">
			<td align="center">对不起，您没有权限访问该页面！</td>	
		</tr>	
	</table>
</form>
</body>


</html>

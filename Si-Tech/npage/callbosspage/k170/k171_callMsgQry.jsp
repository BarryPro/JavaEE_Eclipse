<%
  /*
   * 功能: 来电信息查询
　 * 版本: 1.0
　 * 日期: 2008/10/14
　 * 作者: donglei
　 * 版权: sitech
   * update: libin 2009/04/27 客户归属
   *
 　*/
 %>
<%@ page contentType="text/html;charset=GBK"%>
<html>
<head>
<title>来电信息查询</title>
</head>
<style>
       img{
  cursor:hand;
  }
</style>
<frameset rows="165,*" name="frameset110"  framespacing="2" border="1" frameborder="yes" bordercolor="#e8e8e8">
  <frame src="k171_callMsgQry_query.jsp" name="queryFrame" frameborder="0" marginwidth="0" marginheight="0" scrolling="no">
  <frame src="result.jsp" name="resultFrame" frameborder="0" marginwidth="0" marginheight="0" scrolling="auto">
</frameset>
<noframes>
	<body>
	</body>
</noframes>

</html>
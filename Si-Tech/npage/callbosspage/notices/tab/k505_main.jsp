<%@ page contentType="text/html;charset=GBK"%>
<%
  /*
   * 功能: "公告查看"中转页面，使其在工作区的标签窗口中打开
　 * 版本: 1.0.0
　 * 日期: 2010/09/13
　 * 作者: tangsong
　 * 版权: sitech
　 */
%>
<%
  String uri = request.getParameter("uri");
  uri = new String(uri.getBytes("GBK"),"UTF-8");
%>

<script type="text/javascript">
	window.location.href = decodeURIComponent("<%=uri%>");
</script>
<%
  /**
   * 功能: 质检权限管理->维护质检员和组主页面
　 * 版本: 1.0.0
　 * 日期: 2008/11/05
　 * 作者: mixh
　 * 版权: sitech
   * update:
　 */
%>
<html>
<head>
<title>质检员和组</title>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
</head>
<frameset cols="185,*" rows="*" name="mainFrame" framespacing="0">
	<frameset rows="*,30" frameborder="no" border="0" framespacing="0">
		<frame src="k290_tree.jsp" name="frameleft" scrolling="auto" id="frameleft" title="frameleft" style="border:solid #DFE8F6 3px;cursor:move"/>
    	<frame src="k290_leftButton.jsp" name="leftButtonFrame" id="leftButtonFrame" title="leftButtonFrame" scrolling="no" />
  	</frameset>
  <frameset rows="25,*,30" frameborder="no" border="0" framespacing="0">
  	<frame src="k290_rightTopButton.jsp" name="rightTopFrame" id="rightTopFrame" title="rightTopFrame" scrolling="no" style="border:solid #DFE8F6 3px;cursor:move"/>
    <frame src="k290_member.jsp" name="frameright" scrolling="auto" id="frameright" title="frameright" style="border:solid #DFE8F6 3px;cursor:move"/>
    <frame src="k290_rightFooterButton.jsp" name="rightFootFrame" id="rightFootFrame" title="rightFootFrame" scrolling="no" />
  </frameset>
	</frameset>
	
	
	<noframes>
		<body>
		</body>
	</noframes>
</html>

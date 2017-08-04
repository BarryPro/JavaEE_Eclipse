<%
  /**
   * 功能: 质检权限管理->质检计划管理->弹出式提示尚待质检条数
　 * 版本: 1.0.0
　 * 日期: 2009/3/15
　 * 作者: jiangbing
　 * 版权: sitech
   * update:
　 */
%>
<%
	//String opCode = "K310";
	//String opName = "未质检提示";
	String count   = WtcUtil.repNull(request.getParameter("count"));
%>
<%@page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>

<html>
<head>
<title>未质检提示</title>
<meta http-equiv=Content-Type content="text/html; charset=GBK">

<link href="<%=request.getContextPath()%>/nresources/default/css/FormText.css" rel="stylesheet" type="text/css"></link>
<link href="<%=request.getContextPath()%>/nresources/default/css/font_color.css" rel="stylesheet" type="text/css"></link>
<link href="<%=request.getContextPath()%>/nresources/default/css/ValidatorStyle.css" rel="stylesheet" type="text/css"></link>

<script type="text/javascript" src="<%=request.getContextPath()%>/njs/extend/jquery/jquery123_pack.js"></script>	
<script type="text/javascript" src="<%=request.getContextPath()%>/njs/si/core_sitech_pack.js"></script>	
<script type="text/javascript" src="<%=request.getContextPath()%>/njs/redialog/redialog.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/njs/extend/jquery/block/jquery.blockUI.js"></script>
<script language="JavaScript" src="<%=request.getContextPath()%>/njs/si/validate_pack.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/njs/extend/jquery/hotkey/jquery.hotkeys_jsa.js"></script>


</head>
<body>



<div id="Main">
<table width="98%" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td width="20" valign="top" background="<%=request.getContextPath()%>/nresources/default/images/DotGray.jpg" class="LeftFixBg"><img src="<%=request.getContextPath()%>/nresources/default/images/CornerLeft.jpg" width="20" height="75" /></td>
	<td valign="top" background="<%=request.getContextPath()%>/nresources/default/images/MainTopBg.jpg" class="TopFixBg">
	<div id="Operation_Title"><B>未质检提示：</B></div>
    <div id="Operation_Table">
    <div class="title"></div>  
    <table width="100%" border="0" cellpadding="0" cellspacing="0" id=tb0>
      
      <tr>
         <td width=100% >您现在共有：<font color=red><%=count%></font>条未完成质检计划，请合理安排工作。  </td>
      </tr>      


      </table>

      <table width="100%" border="0" cellpadding="0" cellspacing="0">
        <tr> 
          <td id="footer"  align=center> 
       		<input class="b_foot" name="back" type="button" onclick="grpClose();" value="关闭"  >
        </td>
       </tr>  
     </table>
    </div>
    <br/>          
    </td>
    <td width="20" valign="top" background="<%=request.getContextPath()%>/nresources/default/images/DotGray.jpg" class="RightFixBg"><img src="<%=request.getContextPath()%>/nresources/default/images/CornerRight.jpg" width="20" height="45" /></td>
  </tr>
        
  <tr>
    <td><img src="<%=request.getContextPath()%>/nresources/default/images/CornerLeftDown.gif" width="20" height="20" /></td>
    <td valign="bottom">
    <table width="100%" border="0" cellpadding="0" cellspacing="0" bgcolor="#D8D8D8">
      <tr>
        <td height="1"></td>
      </tr>
    </table>
    </td>
    <td><img src="<%=request.getContextPath()%>/nresources/default/images/CornerRightDown.gif" width="20" height="20" /></td>
  </tr>
</table>

</div>


</body>
</html>

<script>
function grpClose(){
window.opener = null;
window.close();
}
</script>
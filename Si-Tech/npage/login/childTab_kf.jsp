<%@ page contentType= "text/html;charset=gb2312" %>
<%
	String activePhone = request.getParameter("activePhone");
	if(activePhone==null||activePhone.equals(""))
{
	out.println("手机号码信息不正确,请重新输入");
	return;
}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
	<title>黑龙江移动综合客户服务系统</title>
	<link href="<%=request.getContextPath()%>/nresources/default/css/common.css" rel="stylesheet" type="text/css" />
	<link href="<%=request.getContextPath()%>/nresources/default/css/tabcss/tabStyle.css" rel="stylesheet" type="text/css" />
	<script src="<%=request.getContextPath()%>/njs/si/framework_kf.js" type="text/javascript"></script>	
	<script src="<%=request.getContextPath()%>/njs/si/framework_extend.js" type="text/javascript"></script>	
	<script src="<%=request.getContextPath()%>/njs/si/tabScript_jsa.js" type="text/javascript"></script>
	<script src="<%=request.getContextPath()%>/njs/extend/jquery/jquery123_pack.js" type="text/javascript"></script>
	<%@ include file="/npage/include/public_hotkey.jsp" %>
	<script language="javascript" type="text/javascript">
		window.onresize=function()
		{
	 		setChildIframe();  
	  }
		window.onload=function()
		{
			setChildIframe();
			rightDel('child_index',false);//激活综合信息右键菜单
		}
		
		var _exttabref=function(){};
	 		_exttabref.removeTab=function(opcode){
	 		removeTab(opcode);
	 	};
	</script>
	<style>
	html,
	body
	{
		overflow:hidden;
	}
	</style>
</head>
<body>
	<div id="tabset">
		<div id="tab">
			<ul id="tabtag">
				<li id="child_index" class="current"><span class="fristab"><img src="../../nresources/default/images/tab_user.gif" id="tab_user" />基本信息</span></li>
			</ul>
			<div class="clr"></div>
		</div>
		<span class="first"><img src="<%=request.getContextPath()%>/nresources/default/images/tabimages/btn_left.gif"  onclick="BtnMoveLeft(event)" id="imgLeft" /></span>
		<span class="next"><img src="<%=request.getContextPath()%>/nresources/default/images/tabimages/btn_right.gif" onclick="BtnMoveRight(event)"  id="imgRight" /></span>
		<div class="clr"></div>
		<dl id="contentArea">
			<dt class="on">
				<iframe align="top" name="false" id="user_index" frameborder="0" scrolling="auto" src="../portal/user/portal.jsp?activePhone=<%=activePhone%>" crolling="yes"  width="100%" height="100%">
				</iframe>
			</dt>
		</dl>
		<div class="clr"></div>
	
	</div>
</body>
</html>
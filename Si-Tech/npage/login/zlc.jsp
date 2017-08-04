<%@ page contentType= "text/html;charset=GBK" %>
<%@ page errorPage="../common/errorpage.jsp" %>
<%@ page import="com.sitech.boss.pub.util.*"%>
<%@ page import="com.sitech.boss.login.ejb.*"%>
<%@ page import="com.sitech.boss.login.wrapper.*"%>
<%@ taglib uri="/WEB-INF/wtc.tld" prefix="wtc" %>
<script type="text/javascript" src="/njs/redialog/redialog.js"></script>
<html>
<head>
<title>黑龙江移动综合客户服务系统</title>
<META http-equiv=Content-Language content=zh-cn>
<META http-equiv=Content-Type content="text/html; charset=GBK">
<link href="/nresources/default/css/login.css" rel="stylesheet" type="text/css"></link>
<link href="../../nresources/default/css/FormText.css" rel="stylesheet" type="text/css"></link>
<script src="/njs/extend/jquery/jquery123_pack.js" type="text/javascript"></script>

<!--add by gaolw end -->
<script language="javascript">

document.oncontextmenu=new Function("event.returnValue=false;"); //禁止右键功能

$(document).ready(function(){
			$("BUTTON").hover(
				function () {
				    $(this).css("background-position","center");
				},
				function () {
				    $(this).css("background-position","top");
				}
			);
		});

function nof11(){
	if(event.keyCode==122)
		window.close();
}

</script>
</head>
<body  class="login" onkeydown="nof11();">
<div class="loginPanel_esop panel2"></div>
	<div class="loginPanel_esop">
		<div class="caption">
			<div class="title">
		    </div>
		</div>		
<form id="loginForm" name="loginForm" target="_self" method="post">

	<div class="fm-div">
            <TABLE height=80 cellSpacing=1 width="100%" border=1>
              <TBODY>
              <TR>
                <TD width="10%"> <P align=center><IMG height=34 src="../../images/infoFlag.gif" width=36 border=0></P></TD>
                <td width="90%" valign="middle"> <font color="#AA0000"><b><font size="3">
CRM系统因系统升级原因进行计划内切换,暂无法进行业务受理,预计恢复时间1日00时
<p>&nbsp;<p>
解释口径为:客户您好！系统现在正在升级，暂时无法进行业务受理，请您稍后再试！
                </TD>
              </TR>
              </TBODY>
            </TABLE>
	</div>

</form>
<div class="footer">
	<div>

		<a href="#" onclick="this.style.behavior='url(#default#homepage)';this.setHomePage('http://<%=request.getServerName()%>:<%=request.getServerPort()%>/npage/login/index.html');">设为首页</a>|
		<a href="#" onclick="javascript:window.external.AddFavorite('http://<%=request.getServerName()%>:<%=request.getServerPort()%>/npage/login/index.html', '黑龙江移动BOSS--综合业务管理系统')">收藏本站</a>|
		<a href="#" onclick="javascript:window.open('http://<%=request.getServerName()%>:<%=request.getServerPort()%>/doprint.html')">下载打印控件</a></div><div style="margin-top:-10px;">&copy;中国移动通信集团黑龙江有限公司
	</div>
</div>
</div>

</body>
</html>

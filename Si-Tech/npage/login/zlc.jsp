<%@ page contentType= "text/html;charset=GBK" %>
<%@ page errorPage="../common/errorpage.jsp" %>
<%@ page import="com.sitech.boss.pub.util.*"%>
<%@ page import="com.sitech.boss.login.ejb.*"%>
<%@ page import="com.sitech.boss.login.wrapper.*"%>
<%@ taglib uri="/WEB-INF/wtc.tld" prefix="wtc" %>
<script type="text/javascript" src="/njs/redialog/redialog.js"></script>
<html>
<head>
<title>�������ƶ��ۺϿͻ�����ϵͳ</title>
<META http-equiv=Content-Language content=zh-cn>
<META http-equiv=Content-Type content="text/html; charset=GBK">
<link href="/nresources/default/css/login.css" rel="stylesheet" type="text/css"></link>
<link href="../../nresources/default/css/FormText.css" rel="stylesheet" type="text/css"></link>
<script src="/njs/extend/jquery/jquery123_pack.js" type="text/javascript"></script>

<!--add by gaolw end -->
<script language="javascript">

document.oncontextmenu=new Function("event.returnValue=false;"); //��ֹ�Ҽ�����

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
CRMϵͳ��ϵͳ����ԭ����мƻ����л�,���޷�����ҵ������,Ԥ�ƻָ�ʱ��1��00ʱ
<p>&nbsp;<p>
���Ϳھ�Ϊ:�ͻ����ã�ϵͳ����������������ʱ�޷�����ҵ�����������Ժ����ԣ�
                </TD>
              </TR>
              </TBODY>
            </TABLE>
	</div>

</form>
<div class="footer">
	<div>

		<a href="#" onclick="this.style.behavior='url(#default#homepage)';this.setHomePage('http://<%=request.getServerName()%>:<%=request.getServerPort()%>/npage/login/index.html');">��Ϊ��ҳ</a>|
		<a href="#" onclick="javascript:window.external.AddFavorite('http://<%=request.getServerName()%>:<%=request.getServerPort()%>/npage/login/index.html', '�������ƶ�BOSS--�ۺ�ҵ�����ϵͳ')">�ղر�վ</a>|
		<a href="#" onclick="javascript:window.open('http://<%=request.getServerName()%>:<%=request.getServerPort()%>/doprint.html')">���ش�ӡ�ؼ�</a></div><div style="margin-top:-10px;">&copy;�й��ƶ�ͨ�ż��ź��������޹�˾
	</div>
</div>
</div>

</body>
</html>

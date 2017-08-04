<%
  /*
   * 功能: 内部求助主页面
　 * 版本: 1.0.0
　 * 日期: 2008/10/14
　 * 作者: mixh
　 * 版权: sitech
	 *update:
　*/
%>
<%
	//String opCode = "K014";
	//String opName = "内部求助主页面";
%>
<%@page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>内部求助</title>

<script type="text/javascript">

function g(o)
{
	return document.getElementById(o);
}

function HoverLi(n){
	for(var i=1;i<=2;i++)
	{
		g('tb_'+i).className='normaltab';
		g('tbc_0'+i).className='undis';
	}
	g('tbc_0'+n).className='dis';
	g('tb_'+n).className='hovertab';
}
</script>

<style>
.content_02
{
	font-size:12px;
}
#tabtit
{
	height:23px;
	padding:0px 0 0 12px;
} 
#tabtit ul
{
	height:23px;
	position:absolute;
} 
#tabtit ul li
{
	float:left;
	margin-right:2px;
	display:inline;
	text-align:center;
	padding-top:7px;
	cursor:pointer;
	height:22px;
	width:100px;
}
#tabtit .normaltab
{
	color:#3161b1;
	background:url(../../../nresources/default/images/callimage/tab_bj_02.gif) no-repeat left top;
	height:23px;
}
#tabtit .hovertab 
{ 
	color:#3161b1;
	background:url(../../../nresources/default/images/callimage/tab_bj_01.gif) no-repeat left top;
	height:24px;
}
.dis
{
	display:block;
	border-top:1px solid #6c90ca;
	background:#fff url(../../../nresources/default/images/callimage/tab_cont.gif) repeat-x 0px 0px;
	padding:8px 12px;
}
.undis
{
	display:none;
}
.content_02 .dis li
{
	line-height:1.8em;
	padding-left:12px;
}
</style>

</head>

<body>
<div class="content_02">
	<div id="tabtit">
		<ul>
			<li id="tb_1" class="hovertab" onclick="HoverLi(1);">转人工服务</li>
			<li id="tb_2" class="normaltab" onclick="HoverLi(2);">转指定工号</li>
		</ul>
	</div>
	<div class="dis" id="tbc_01">
	<%--
    <%@ include file="helpToAgentMain.jsp" %>
    --%>
	</div>
	<div class="undis" id="tbc_02">
	<%@ include file="helpToAgentMain.jsp" %>
	</div>
</div>
</body>
</html>

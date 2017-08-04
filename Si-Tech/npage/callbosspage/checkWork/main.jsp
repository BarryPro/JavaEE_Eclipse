<%@page contentType="text/html;charset=GBK"%>

<html>
<head>
<title>质检管理</title>
<script type="text/javascript">

function g(o)
{
	return document.getElementById(o);
}

function HoverLi(n){
	for(var i=1;i<=5;i++)
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
			<li id="tb_1" class="hovertab" onclick="HoverLi(1);">被检对象类别管理</li>
			<li id="tb_2" class="normaltab" onclick="HoverLi(2);">差错类别管理</li>
			<li id="tb_3" class="normaltab" onclick="HoverLi(3);">差错等级定义</li>
			<li id="tb_4" class="normaltab" onclick="HoverLi(4);">放弃原因定义</li>
			<li id="tb_5" class="normaltab" onclick="HoverLi(5);">业务类别定义</li>
		</ul>
	</div>
	<div class="dis" id="tbc_01">
    <%@ include file="K230/qc_main.jsp" %>
	</div>
	<div class="undis" id="tbc_02">
	<%@ include file="helpToAgentMain.jsp" %>
	</div>
	<div class="undis" id="tbc_03">
	<%@ include file="helpToAgentMain.jsp" %>
	</div>
	<div class="undis" id="tbc_04">
	<%@ include file="helpToAgentMain.jsp" %>
	</div>	
	<div class="undis" id="tbc_05">
	<%@ include file="helpToAgentMain.jsp" %>
	</div>			
</div>
</body>
</html>

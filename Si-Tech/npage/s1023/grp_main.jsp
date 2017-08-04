<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%
  /*
   * 功能: 团客户统一视图
　  * 版本: 1.0.0
　  * 日期: 2011/05/08
　  * 作者: zhoujf
　  * 版权: sitech
   
　 */
%>
<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="javax.servlet.http.HttpServletRequest,com.sitech.crmpd.core.wtc.util.*,java.util.*,java.text.SimpleDateFormat"%>

<%	
	String opCode = "d920";		
	String opName = "集团客户统一视图";	//header.jsp需要的参数 	
	String unit_id =  request.getParameter("unit_id")==null?"":request.getParameter("unit_id");
%>	

<style type="text/css">
.content_02
{
	font-size:12px;
}
#tabtit_ts
{
	height:23px;
	padding:0px 0 0 12px;
}
#tabtit_ts ul
{
	height:23px;
	position:absolute;
}
#tabtit_ts ul li
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
#tabtit_ts .normaltab
{
	color:#3161b1;
	background:url(<%=request.getContextPath()%>/nresources/default/images/callimage/tab_bj_02.gif) no-repeat left top;
	height:23px;
}
#tabtit_ts .hovertab
{
	color:#3161b1;
	background:url(<%=request.getContextPath()%>/nresources/default/images/callimage/tab_bj_01.gif) no-repeat left top;
	height:24px;
}
.dis
{
	display:block;
	border-top:1px solid #6c90ca;
	background:#fff url(<%=request.getContextPath()%>/nresources/default/images/callimage/tab_cont.gif) repeat-x 0px 0px;
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

/*---------------听取录音按钮style开始-------*/
#callSearch
{
	width:100%;
	padding:4px 2px;
	font-size:12px;
	z-index:1000000000000;
}

#callSearch img
{
	width:16px;
	height:16px;
	cursor:pointer;
}

/*---------------听取录音按钮style结束------------*/

#subScore{
border:1px solid #FFF;
}
#basetree td {
	padding:0;
	height:0;
}

#timerDiv b {
	color:#555;
	display:block;
	float:left;
}

#timerDiv .grey {
 	filter:alpha(Opacity=30);
}
</style>


<script language="javascript" >
var num=1;
function g(o){
		return document.getElementById(o);
}

function HoverLi(n){
	
		for(var i=1;i<8;i++){
				g('tb_'+i).className='normaltab';
				g('tbc_0'+i).className='undis';
		}
		g('tbc_0'+n).className='dis';
		g('tb_'+n).className='hovertab';
		num = n;
		reinitIframe(num);

}

function reinitIframe(n){
var iframe = document.getElementById("frame_content"+n);
try{

iframe.height =  iframe.contentWindow.document.documentElement.scrollHeight;

}catch (ex){}

}

window.setInterval("reinitIframe(num)", 200);
</script>

<html>
<head>	


</head>
<body>
<form action="" name="form1"  method="post">
	<%@ include file="/npage/include/header.jsp" %>     	
		<div id="Operation_Table">
	<table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
	<tr>
		<td>
		<div class="content_02">
			<div id="tabtit_ts">
				<ul>
					<li id="tb_1" class="hovertab" onclick="HoverLi(1);">集团客户信息</li>
					<li id="tb_2" class="normaltab" onclick="HoverLi(2);">集团账务信息</li>
					<li id="tb_3" class="normaltab" onclick="HoverLi(3);">集团产品信息</li>
					<li id="tb_4" class="normaltab" onclick="HoverLi(4);">营销销售信息</li>
					<li id="tb_5" class="normaltab" onclick="HoverLi(5);">集团评价信息</li>
					<li id="tb_6" class="normaltab" onclick="HoverLi(6);">集团缴费信息</li>
					<li id="tb_7" class="normaltab" onclick="HoverLi(7);">服务请求信息</li>
				</ul>
			</div>
			<div class="dis" id="tbc_01" name="">
		    <iframe width="100%" align="top" id="frame_content1" src="grp_cust.jsp?unit_id=<%=unit_id%>" scrolling="no" frameborder="0"></iframe>

			</div>
			<div class="undis" id="tbc_02">
				<iframe width="100%" align="top" id="frame_content2" src="grp_bill.jsp?unit_id=<%=unit_id%>" scrolling="no" frameborder="0"></iframe>
				
			</div>
			<div class="undis" id="tbc_03">
				<iframe width="100%" align="top" id="frame_content3" src="grp_pro.jsp?unit_id=<%=unit_id%>" scrolling="no" frameborder="0"></iframe>
			</div>
			<div class="undis" id="tbc_04">
				<iframe width="100%" align="top" id="frame_content4" src="grp_chance.jsp?unit_id=<%=unit_id%>" scrolling="no" frameborder="0"></iframe>
			</div>
			<div class="undis" id="tbc_05">
				<iframe width="100%" align="top" id="frame_content5" src="grp_evalua.jsp?unit_id=<%=unit_id%>" scrolling="no" frameborder="0"></iframe>
			</div>
			<div class="undis" id="tbc_06">
				<iframe width="100%" align="top" id="frame_content6" src="grp_mon.jsp?unit_id=<%=unit_id%>" scrolling="no" frameborder="0"></iframe>
			</div>
		</div>
<div class="undis" id="tbc_07">
				<iframe width="100%" align="top" id="frame_content7" src="grp_serq.jsp?unit_id=<%=unit_id%>" scrolling="no" frameborder="0"></iframe>
			</div>
		</div>
		</td>
	</tr>
	</table>





</div>
      <%@ include file="/npage/include/footer.jsp" %>  
</form>
</body>
</html>
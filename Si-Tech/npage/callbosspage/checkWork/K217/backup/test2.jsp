<%
  /*
   * 功能: 计划外质检
　 * 版本: 1.0.0
　 * 日期: 2008/11/05
　 * 作者: mixh
　 * 版权: sitech
   * update:
　 */
%>
<%
	String opCode = request.getParameter("opCode");
	String opName = request.getParameter("opName");
	if(opCode == null || opCode ==""){
		opCode = "K217";
	}
	if(opName == null || opName ==""){
		opName = "计划外质检";
	}

%>

<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="javax.servlet.http.HttpServletRequest,com.sitech.crmpd.core.wtc.util.*"%>


<html>
<head>
<script>



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
	background:url(<%=request.getContextPath()%>/nresources/default/images/callimage/tab_bj_02.gif) no-repeat left top;
	height:23px;
}
#tabtit .hovertab
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


</style>

</head>
<body >
<form name="form1">

<table id="tb2" width="100%" height="25" border="0" align="center" cellpadding="4" cellspacing="0">
	<%
		out.println("<tr>");
		out.println("<td class='Blue'>");
		out.println("</td>");
		out.println("<select name='itemlevel' id='itemlevel' onchange='score.value=this.options[this.selectedIndex].value'>");
		%>
    <wtc:qoption name="s151Select" outnum="2">"
    <wtc:sql>select score, level_name from dqcckectitemlevel where item_id='0502'</wtc:sql>
    </wtc:qoption>

    <%
        out.println("</select>");
		out.println("</td>");
		out.println("</tr>");
	%>
</table>
</div>


</form>
</body>
</html>

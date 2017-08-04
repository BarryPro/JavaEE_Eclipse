<%
/**
 * 输入参数：
 * @param	opName
 * @param	workNo
 * @param	workName
 * 
 */
%>

<html>
<head>
	
</head>
<base target="_self">
<title><%=opName%></title>
<meta http-equiv="Content-Type" content="text/html"; charset="gbk">
<link href="/css/view.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="/page/workflow/admin/js/jquery.js"></script>
			
<body bgcolor="#FFFFFF" text="#000000" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  >
<table width="100%" border="0" cellspacing="0" cellpadding="0" align="center"  bgColor="#FFFFFF">
<tr>
 <td>
	 
	   <div id="logo"></div>
	   <div id="title_right"><span class="big">BOSS 3.0 </span><br />
	       <span class="small" id="titlename"><%=opName%></span></div>
	
	   <div id="NavBar"><img src="/images/list_yellow.gif" width="5" height="9" /> 工号：<%=workNo%> <img src="/images/list_yellow.gif" width="5" height="9" /> 操作员：<%=workName%></div>
	 

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
<meta http-equiv="Content-Type" content="text/html"; charset="gb2312">
<link href="/css/view2.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="/js/common/common_check.js"></script>
<script type="text/javascript" src="/js/rpc/src/core_c.js"></script>
<script language="JavaScript" src="/js/common/redialog/redialog.js"></script>
<script language="JavaScript" src="/js/iOffice_Popup.js"></script>
<script type="text/javascript" src="/page/workflow/admin/js/jquery.js"></script>
			
<body>
<table width="100%" border="0" cellspacing="0" cellpadding="0" align="center"  bgColor="#FFFFFF">

<tr>
 <td>
	 
		   
		<div id="top">
<div class="logo"></div>
<DIV class="title">BOSS 3.0<BR>
<SPAN class="titright"><%=opName%></SPAN></DIV>
</div>   
		 
	
	   <div id="NavBar"><img src="/images/list_yellow.gif" width="5" height="9" /> 工号：<%=workNo%> <img src=  "/images/list_yellow.gif" width="5" height="9" /> 操作员：<%=workName%></div>
	 

<%
/********************
version v2.0
开发商: si-tech
update:anln@2009-02-25 页面改造,修改样式
********************/
%>

<%@ page contentType="text/html;charset=Gb2312"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%	
	String loginNo1 = request.getParameter("loginNo1");		
	System.out.println("===================loginNo1============="+loginNo1);
	String dataJsp = "popedomtreeXml.jsp?isRoot=true&loginNo1="+loginNo1;
%>
<html>
<head>
<title>(<%=loginNo1%>)工号权限树</title>
<META content=no-cache http-equiv=Pragma>
<META content=no-cache http-equiv=Cache-Control>
<script language="JavaScript" src="xtree/script/loader.js"></script>
<link rel="stylesheet" type="text/css" href="xtree/css/xtree.css">
<style type="text/css">
	a:link,a:visited { text-decoration: none; color: #111111 }
	font { font-family: 宋体; font-size: 13px; }
</style>
</head>
<body>
<form name="frm" method="post" action="">

    <%-- modified by hanfa 20061113 --%>	
    
	<div id="POP_Title_block">
		<table  cellspacing="0" >
			<tr>
				<td width="40%"  class="shadow">
					<span id="titlename"><script language="javascript">document.write(document.title);</script></span>
				</td>
				<td width="60%"  class="shadow">&nbsp;
				</td>
			</tr>
		</table>
	</div>
	    <%-- added by hanfa 20061113 --%>
			<table   cellspacing="0" >
    		  	<tr> 
    		  		<TD width="20"></TD>
					<td  nowrap>
									<script>loader();</script>
									<div id="xtree"  XmlSrc="<%=dataJsp%>"></div>
									<script language="JavaScript">
									<!--
									document.all.xtree.className="xtree";
									//-->
									</script>
	    				</td>
  				</tr>
			</table>			
		<br>
		<br>
		<br>
		<table  cellspacing="0" >
			<tr>
				<TD ="footer">
					<input class="b_foot" name="doButton" type="button"  value="关  闭"   onclick="parent.window.close()">&nbsp;
				</TD>
			</tr>		
		</table>
</body>
</html>
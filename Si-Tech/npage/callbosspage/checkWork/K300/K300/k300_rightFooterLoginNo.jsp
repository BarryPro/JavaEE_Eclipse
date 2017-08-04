<%@ page language="java" pageEncoding="gb2312"%>
<%@ include file="/npage/include/public_title_name.jsp"%>
<HTML>
		<HEAD>
		<LINK
			href="<%=request.getContextPath()%>/nresources/default/css/dtmltree_css/dhtmlxtree.css"
			type=text/css rel=STYLESHEET>
	</HEAD>
	<BODY scroll=auto>
	<div id='dataTable' >
	</div>
	</BODY>
</html>
<SCRIPT LANGUAGE="JavaScript">
<!--

function CopyHtmlElement()
{
 document.getElementById('dataTable').innerHTML = parent.rightCenterLoginNo.document.getElementById('dataTable').outerHTML;
 document.execCommand("copy","",null); // ¸´ÖÆ
}
//-->
</SCRIPT>
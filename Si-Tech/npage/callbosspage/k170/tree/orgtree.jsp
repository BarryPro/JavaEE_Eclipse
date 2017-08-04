<%@ include file="/workflow/include/include.jsp"%>
<script type='text/javascript' src='<%=request.getContextPath()%>/dwr/interface/tree.js'></script>

<STYLE type=text/css>
	TD {
		FONT-SIZE: 9pt;
		FONT-FAMILY: "宋体"
	}
	
	BODY {
		FONT-SIZE: 9pt;
		FONT-FAMILY: "宋体"
	}
	
	SELECT {
		FONT-SIZE: 9pt;
		FONT-FAMILY: "宋体"
	}
	
	A {
		FONT-SIZE: 9pt;
		COLOR: #000000;
		FONT-FAMILY: "宋体";
		TEXT-DECORATION: none
	}
	
	A:hover {
		FONT-SIZE: 9pt;
		COLOR: #ff0000;
		FONT-FAMILY: "宋体";
		TEXT-DECORATION: underline
	}
	</STYLE>

<SCRIPT language=javascript src="/workflow/include/tree/js/org.js"></SCRIPT>
<!--
<META content="MSHTML 6.00.2800.1400" name=GENERATOR>
-->
</HEAD>
<BODY onload=" FolderInit('99999')">
<input type="hidden" name="curSelNode" value="">
<DIV id=mParent style="FONT-SIZE: 14px; WIDTH: 144px; HEIGHT: 19px"><IMG src="/workflow/include/tree/images/topopen.gif" align=absMiddle border=0 name=mTree> <A target="#">安徽移动</A></DIV>
<DIV id='mainDiv'></DIV>
</BODY>
</HTML>
<script>
  var curSelNode;
 
</script>

<%@ page language="java"  pageEncoding="gb2312"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="com.sitech.crmpd.core.wtc.util.*,java.util.*"%>
<STYLE type=text/css>TD {
	FONT-SIZE: 9pt; FONT-FAMILY: "宋体"
}
BODY {
	FONT-SIZE: 9pt; FONT-FAMILY: "宋体"
}
SELECT {
	FONT-SIZE: 9pt; FONT-FAMILY: "宋体"
}
A {
	FONT-SIZE: 9pt; COLOR: #000000; FONT-FAMILY: "宋体"; TEXT-DECORATION: none
}
A:hover {
	FONT-SIZE: 9pt; COLOR: #ff0000; FONT-FAMILY: "宋体"; TEXT-DECORATION: underline
}
</STYLE>

<SCRIPT language=javascript src="/npage/callbosspage/k170/tree/js/foldernav_right.js"></SCRIPT>
<Script>
	 gobal_start_node_id='<%=request.getParameter("nodeId")%>'
</script>	
<META content="MSHTML 6.00.2800.1400" name=GENERATOR></HEAD>
<BODY>
<DIV id=mParent style="FONT-SIZE: 14px; WIDTH: 144px; HEIGHT: 19px"><IMG id='MainImg'
src="/npage/callbosspage/k170/tree/images/openfoldericon.gif" align=absMiddle border=0 name=mTree> <A 
target="#" id='mainCheck'><%=request.getParameter("node_name")+"["+request.getParameter("nodeId")+"]"%></A>
</DIV>

<DIV id='mainDiv'>
  
  
</DIV>


</BODY>
<script>

	   gobal_check_str="00,01,0702";
</script>

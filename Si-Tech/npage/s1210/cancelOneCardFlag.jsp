
<%@ page contentType="text/html; charset=GBK" %>
<%@ page import="java.util.*"%>
<%@ page import="java.io.*"%>
<%@ include file="/npage/include/public_title_name.jsp" %>

<HTML>
<HEAD>
<TITLE>打印</TITLE>
<script type="text/javascript" src="/njs/extend/jquery/jquery123_pack.js"></script>
<script type="text/javascript" src="/njs/si/core_sitech_pack.js"></script>
<script type="text/javascript" src="/njs/redialog/redialog.js"></script>
<script type="text/javascript" src="/njs/extend/jquery/block/jquery.blockUI.js"></script>
<script language="JavaScript" src="/njs/si/validate_pack.js"></script>

</HEAD>

<%
	response.setHeader("Pragma","No-cache");
	response.setHeader("Cache-Control","no-cache");
	response.setDateHeader("Expires", 0);

	String opCode = request.getParameter("opCode");


  /***************** update by diling @2012/3/14 19:40:41 end****************/
	String op_name="";
	String DlgMsg = request.getParameter("DlgMsg");
	
%>

<SCRIPT type="text/javascript">

function dosave()
{

			var retValue = "yes";
			window.returnValue= retValue;
			window.close();
}

function donotsave()
{

			var retValue = "no";
			window.returnValue= retValue;
			window.close();
}
  
</SCRIPT>
<!--**************************************************************************************-->

<body style="overflow-x:hidden;overflow-y:hidden" onkeydown="if(event.keyCode==13)dosave();">
	<head>
		<title>黑龙江移动BOSS</title>
		<meta http-equiv="Content-Type" content="text/html; charset=GBK">
		<link href="/nresources/default/css/FormText.css" rel="stylesheet" type="text/css"></link>
		<link href="/nresources/default/css/font_color.css" rel="stylesheet" type="text/css"></link>
	</head>
<FORM method=post name="spubPrint" target="_parent">

   <div class="popup">
	  	<div class="popup_qu" id="rdImage" align=center>
		  	<div class="popup_zi orange" id="message"><%=DlgMsg%></div>
		  </div>

	    <div align="center">
	      <input class="b_text" name=commit onClick="dosave()"  style="width:80px;" type=button value="保留">&nbsp;&nbsp;
	      <input class="b_text" name=commit onClick="donotsave()" style="width:100px;"  type=button value="不保留">&nbsp;&nbsp;
	    </div>
	    <br>   
	 </div>


</FORM>

</BODY>
</HTML>

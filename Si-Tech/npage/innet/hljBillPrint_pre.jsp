<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%
	response.setHeader("Pragma","No-cache");
	response.setHeader("Cache-Control","no-cache");
	response.setDateHeader("Expires", 0);

%>
<html>
<body style="padding:0px;">
	<iframe width="100%" height="90%" name="actionframe" scrolling="auto" frameborder="0" 
			border="0" marginwidth="0" marginheight="0" >
	</iframe>

<form action="" method="post" id="printForm" name="printForm" target="actionframe">

<form>
</body>
<script language="javascript">
	var obj = window.dialogArguments;
	
	for(i in obj){
		var v = $(obj).attr(i);
		if(typeof(v) != "undefined"){
			v = v.replace(new RegExp("%23","gm"),"#");
			v = v.replace(new RegExp("%25","gm"),"%");
			v = v.replace(new RegExp("%2B","gm"),"+");
			v = v.replace(new RegExp("%2D","gm"),"-");
			v = v.replace(new RegExp("%2A","gm"),"*");
			v = v.replace(new RegExp("%2F","gm"),"/");
			v = v.replace(new RegExp("%26","gm"),"&");
			v = v.replace(new RegExp("%21","gm"),"!");
			v = v.replace(new RegExp("%3D","gm"),"=");
			v = v.replace(new RegExp("%3F","gm"),"?");
			v = v.replace(new RegExp("%3A","gm"),":");
			v = v.replace(new RegExp("%7C","gm"),"|");
			v = v.replace(new RegExp("%2C","gm"),",");
			v = v.replace(new RegExp("%2E","gm"),".");
		}else{
			v = "";
		}
		
		$("#printForm").append("<input type=\"hidden\" name=\""+i+"\" value=\""+v+"\" />");
		
	}
	$("#printForm").attr("action",obj.actionPath);
	
	document.printForm.submit();
</script>
</html>

<%
	/*
	 * 功能： 产品json串跳转页面，实现大量数据的post提交
	 * 日期： 2009-12-12
	 */
%>
<%@ page contentType="text/html;charset=GBK"%>
<%
	String meansId = request.getParameter("meansId");
	
	//System.out.println("actId=====meansId=dd==" + actId+"----"+meansId);	
 %>
<html>
<head>
	</head>
	<body>
		<form name ="specialFrm" action="specialAllfunds.jsp"  method="post">
			<input name ="specialallfunds" id="specialallfunds" type="hidden"/>
		</form>
	</body>
	<script type="text/javascript">
		window.onload=function(){
		 		document.forms[0].specialallfunds.value= parent.document.getElementById("global_specialallfunds").value;
		 		document.forms[0].submit();
		 }
	</script>
</html>
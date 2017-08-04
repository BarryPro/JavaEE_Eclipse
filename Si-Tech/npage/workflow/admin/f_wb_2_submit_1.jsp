<%@ include file="/page/workflow/admin/pub/wb_include.jsp" %>

<%
String wano=(String)request.getParameter("wano");
String targetPage="f_wb_2_02.jsp";
%>
<html>
	<head>
	<script type="text/javascript" src="js/jquery.js"></script>
</head>
	<body>
		<form name='form1'>
			请选择地区:<br>
			<input type=text name='region'>
					<input type=button value='提交' onclick='submit1()'>
		</form>
	</body>
</html>

<script>
	function submit1()
	{
	var form1=document.forms[0];
	var url="f_wb_2_submit_2.jsp?wano=<%=wano%>&region="+form1.region.value;
	$.ajax({
    url: url,
    type: 'GET',
    dataType: 'html',
    timeout: 10000,
    error: function(){
        alert('操作错误');
    },
    success: function(html){
    		eval(html.replace('/\r/g','').replace('/\n/g',''));
    		window.close();
    }
});
	}
	
</script>
<%@ include file="/page/workflow/admin/pub/wb_include.jsp" %>
<%
String wano=request.getParameter("wano");
String wono=request.getParameter("wono");
String targetPage="f_wb_3_02.jsp";
%>
<html>
	<script type="text/javascript" src="js/jquery.js"></script>
	<script>
		function submit1()
		{
				 var url="f_wb_3_03.jsp?wono="+wono+"&wano="+nowrow;
				$.ajax({
    url: url,
    type: 'GET',
    dataType: 'html',
    timeout: 10000,
    error: function(){
        alert('²Ù×÷´íÎó');
        window.close();
    },
    success: function(html){
			eval(html.replace('/\r/g','').replace('/\n/g',''));
			window.close();
    }
		});
		
		}
		submit1();
	</script>
</html>
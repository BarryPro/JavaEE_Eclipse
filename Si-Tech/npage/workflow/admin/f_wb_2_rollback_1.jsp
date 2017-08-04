<%@ include file="/page/workflow/admin/pub/wb_include.jsp" %>
<%
String wano=request.getParameter("wano");
String targetPage="f_wb_2_02.jsp";
%>
<html>
	<script type="text/javascript" src="js/jquery.js"></script>
	<script>
		function submit1()
		{
				 var url="f_wb_2_rollback_2.jsp?wano=<%=wano%>";
				$.ajax({
    url: url,
    type: 'GET',
    dataType: 'html',
    timeout: 10000,
    error: function(){
        parent.rdShowMessageDialog('²Ù×÷´íÎó',0);
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
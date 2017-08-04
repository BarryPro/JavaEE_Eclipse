<%
   /*
   * 功能: demo
　 * 版本: v1.0
　 * 日期: 2009-01-12
 　*/
%>
<%@ page contentType="text/html;charset=GB2312"%>
<%@ include file="/npage/include/public_title_name.jsp" %>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<title>demo</title>
</head>
<script type="text/javascript">
function dosubmit(){	frm.action="print_test.jsp?opCode="+frm.code.value+"&opName="+frm.name.value+"&gCustId="+frm.gCustId.value;
	frm.submit();
}
function test(){
	alert(frm.code.value);
}
</script>

<body>
<div id="operation">
	<FORM method="post" name="frm">
 	<%@ include file="/npage/include/header.jsp" %>
 	<div id="operation_table">
		<div class="input">	
			opCode:<input type="text" value="1104" name="code">
			opName:<input type="text" value="测试" name="name">
			custID:<input type="text" value="100004992432" name="gCustId">
		</div>
	<div id="operation_button">
		<input class="b_foot"  type="button" onclick=dosubmit() value="测试">
	</div>
	<%@ include file="/npage/include/footer.jsp" %>
	</form>
  
</div>
</body>
</html>



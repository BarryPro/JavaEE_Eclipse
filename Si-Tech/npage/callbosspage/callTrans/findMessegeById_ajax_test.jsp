<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp"%>
<script language="JavaScript" type="text/JavaScript">
var testAjax =  function(){
	//alert(id);
	//alert($('#test001').val());
	id = $('#test001').val();
	$.ajax({
		url: '<%=request.getContextPath()%>/npage/callbosspage/callTrans/findMessegeById_rpc.jsp?ids='+id,
		//data: sendData,
		type:"POST", 
		dataType:"html",
		success: function(data){
			var test = eval('('+data.trim()+')');
			for(var i = 0; i < test.data.length; i ++){
				alert(test.id[i]);
				alert(test.data[i]);
			}
		}
	});
}
</script>
<html>
<body>
<a href="#" onclick="testAjax();">testAjax();</a>
<input id="test001" value="10086044010171ML2,10086044010171ML4" style="width: 200px;">
</body>
</html>
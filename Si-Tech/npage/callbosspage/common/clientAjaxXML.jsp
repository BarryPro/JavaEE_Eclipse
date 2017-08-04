<%@page contentType="text/html;charset=GB2312"%>
<script language=javascript src="<%=request.getContextPath() %>/callbosspage/js/ajaxXML.js"></script>
<HTML>
	<HEAD>
		<TITLE>New Document</TITLE>

	</HEAD>

	<BODY>
		<form name="form1">
			Í¬²½£º <input type='text' name="dwrValue" value="">
			<input type="button" value="dwr" onclick="getData()">
		</form>
	</BODY>
</HTML>
<script> 
  function getData(){
   var ret=getXMLData('/sitechcallcenter/callbosspage/common/serverajaxProxy.jsp?url=/call/ajax/serverajaxXML.jsp&name=a&par=1');
   alert(ret);
  }
</script>

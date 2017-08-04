<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<html>
<head>
<base target="_self">
<title></title>
<script>
 function goPage(){ 	
 	var flag;
	var chs = document.sitechForm.ch;
	
	for(var i = 0; i< chs.length; i++){
		if(chs[i].checked){
			flag = chs[i].value;
		}
	}
	
	if(flag=="0"){
		
		//var valueEnter = window.showModalDialog('scatterPhone.jsp','','dialogWidth:600px;dialogHeight:800px;center:1');
		document.sitechForm.action="scatterPhone.jsp";
		
	}else if(flag=="1"){
		document.sitechForm.action="temporaryPhone.jsp";
	}else{
		return;
	}
	
	document.sitechForm.submit();
	
 }
</script>
</head>

<body>
<form name="sitechForm" action="" method="post">
<div id="Operation_Table">	
<table width="200" border="0" align="center" cellpadding="0" cellspacing="0">
	<tr>
    <td colspan="2">&nbsp;</td>
  </tr>
  <tr>
    <th width="50%" align="right"><input name="ch" type="radio" value="0"></th>
    <th width="50%">离散输入号码</th>
  </tr>

  <tr>
    <th width="50%" align="right"><input name="ch" type="radio" value="1"></th>
    <th width="50%">临时导入号码</th>
  </tr>

  <tr align="center">
    <td colspan="2"><input type="button" class="b_foot" value="下一步" onClick="goPage();">&nbsp;<input type="button" class="b_foot" value="取消" onClick="window.close();"></td>
  </tr>
</table>
</div>
</form>
</body>
</html>

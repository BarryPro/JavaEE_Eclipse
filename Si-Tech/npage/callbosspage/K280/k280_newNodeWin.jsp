<%@ page contentType="text/html;charset=gb2312"%>
<%@ include file="/npage/include/public_title_name.jsp" %>

<html>
<head>
<title>�������ʼ���</title>

<script language=javascript>

// �������¼
function cleanValue(){
	var e = document.forms[0].elements;
	for(var i=0;i<e.length;i++){
  		if(e[i].type=="select-one"||e[i].type=="text")
   		e[i].value="";
 	}
}

function closeWin(){
	window.close();
}

function addNewNode(){
	var nodeName = document.getElementById("groupName").value;
	if(nodeName == ""){
		rdShowMessageDialog("�����뱻�ʼ�������ƣ�",1);
		return;
	}
	window.close();
	window.opener.insertNewNode(nodeName);
}
</script>
</head>

<body >
<form id=sitechform name=sitechform>
	<div id="Operation_Table">
		<table>
			<tr>
  				<td>��ǰѡ�нڵ������ƣ�</td>
  				<td width="60%">
	    			<% String par_name =request.getParameter("par_Text"); %>    			
	    			<%=(par_name==null)?"":par_name%>
	  			</td>
			</tr>
			<tr>
  				<td>�����ӽڵ������ƣ�</td>
  				<td  width="60%">
  					<input id="groupName" name ="groupName" size="30" type="text" value="">
	    			<font color="orange">*</font>
	  			</td>
			</tr>
			<tr >
  				<td colspan="2" align="center">
   					<input name="add" type="button" class="b_text" id="add" value="ȷ��" onClick="addNewNode()">
   					<input name="clean" type="button" class="b_text" id="clean" value="����" onClick="cleanValue()">
   					<input name="close" type="button" class="b_text" id="close" value="ȡ��" onClick="closeWin()">
  				</td>
			</tr>
		</table>
	</div>
</form>
</body>
</html>
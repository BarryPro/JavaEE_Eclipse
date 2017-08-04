<%@ page contentType="text/html;charset=gb2312"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%
	String nodeId = WtcUtil.repNull(request.getParameter("nodeId"));
	String nodeName = WtcUtil.repNull(request.getParameter("nodeName"));
	
	//String sqlTemp = "SELECT LOGIN_GROUP_ID, LOGIN_GROUP_NAME  FROM DQCLOGINGROUP WHERE LOGIN_GROUP_ID = '" + nodeId + "'";
%>


<html>
<head>
<title>修改被质检组</title>

<script language=javascript>

// 清除表单记录
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

function modifyNode(){
	var nodeName = document.getElementById("groupName").value;
	if(nodeName == ""){
		rdShowMessageDialog("请输入被质检组的名称！",1);
		return;
	}

	window.close();
	window.opener.modifyNode("<%=nodeId%>",nodeName);
}
</script>
</head>

<body >
<form id=sitechform name=sitechform>
	<div id="Operation_Table">
		<table>
			<tr>
  				<td>选择修改的组节点名称：</td>
  				<td width="60%">
  					<input id="groupName" name ="groupName" size="40" type="text" value="<%=(nodeName==null)?"":nodeName%>">
	    			<font color="orange">*</font>
	  			</td>
			</tr>
			<tr >
  				<td colspan="2" align="center">
   					<input name="add" type="button" class="b_text" id="add" value="确定" onClick="modifyNode()">
   					<input name="clean" type="button" class="b_text" id="clean" value="重设" onClick="cleanValue()">
   					<input name="close" type="button" class="b_text" id="close" value="取消" onClick="closeWin()">
  				</td>
			</tr>
		</table>
	</div>
</form>
</body>
</html>
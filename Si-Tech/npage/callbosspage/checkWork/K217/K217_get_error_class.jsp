
<%
  /*
   * 功能: 选择差错类别
　 * 版本: 1.0.0
　 * 日期: 2008/11/05
　 * 作者: mixh
　 * 版权: sitech
   * update:
　 */
%>
<%
	String opCode = "K217";
	String opName = "选择差错类别";
%>

<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>

<html>
<head>
	<title>选择差错类别</title>
	
<script>
function selectErrorClass(val){
		var error_levels = document.getElementById("error_levels");
		var option = document.createElement("OPTION");
		option.text = "aaaa";
		option.value = "1";
		error_levels.add(option);
}

function removeErrorClass(){
		var error_levels = document.getElementById("error_levels");
		for(var i = 0; i < error_levels.length; i++){
				if(error_levels.options[i].selected==true){
					error_levels.options.remove(i);
				}
		}
		if(error_levels.length>=1)
		error_levels.options[0].selected=true;
}

function getReturnStr(){
		var texts = "";
		var ids   = "";
		var error_levels = document.getElementById("error_levels");
		for(var i = 0; i < error_levels.length; i++){
				texts += error_levels.options[i].text + ",";
				ids   += error_levels.options[i].value + ",";
		}
		return texts + '_' + ids;
}

function submitErrorClass(){
		window.returnValue = getReturnStr();
		window.close();
}
</script>
</head>
<body >
<form name="form1">


<div id="Operation_Table" style="width: 101%;padding-left:0px;"><!-- guozw20090828 -->
	<div class="title"><div id="title_zi">选择差错类别</div></div>
    <table width="100%" border="0" cellpadding="0" cellspacing="0">
      <tr>
      	<td class="blue" width="45%">
      		<table width="100%">
      		<tr><td>
      		<jsp:include page="fK240toK270_tree.jsp">
      			<jsp:param name="op_code" value="k240"/>
      		</jsp:include>
      		</td></tr>
      		</table>
      	</td>
      	<td width="5%">
      	<input type="button" class="b_text" name="btn_to_left" value=" << " onclick="removeErrorClass();"/><br/>
      	<input type="button" class="b_text" name="btn_to_right" value=" >> "/>
      	</td>
        <td width="45%">
		<select name="error_levels" id="error_levels" size="15" style="width:99%;height:100%">
		</select>
        </td>
      </tr>
    </table>
    	<table width="100%" border="0" cellpadding="0" cellspacing="0">
		<tr>
			<td align="center" id="footer">
				<input name="confirm" onClick="submitErrorClass()" type="button" class="b_foot" value="确定">
				<input name="confirm" onClick="window.close()" type="button" class="b_foot" value="取消">
			</td>
		</tr>
	</table>
</div>

</form>
</body>
</html>



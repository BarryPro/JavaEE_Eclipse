
<%
  /*
   * 功能: 评定原因定义
　 * 版本: 1.0.0
　 * 日期: 2008/11/05
　 * 作者: mixh
　 * 版权: sitech
   * update:
　 */
%>
<%
	String opCode = "K217";
	String opName = "选择评定原因";
%>

<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>

<html>
<head>
	<title>选择评定原因</title>
	
<script>
function selectCheckReasonClass(val){
		var checkReason_levels = document.getElementById("checkReason_levels");
		var option = document.createElement("OPTION");
		option.text = "aaaa";
		option.value = "1";
		checkReason_levels.add(option);
}

function removeCheckReasonClass(){
		var checkReason_levels = document.getElementById("checkReason_levels");
		for(var i = 0; i < checkReason_levels.length; i++){
				if(checkReason_levels.options[i].selected==true){
					checkReason_levels.options.remove(i);
				}
		}
		if(checkReason_levels.length>=1)
		checkReason_levels.options[0].selected=true;
}

function getReturnStr(){
		var texts = "";
		var ids   = "";
		var checkReason_levels = document.getElementById("checkReason_levels");
		for(var i = 0; i < checkReason_levels.length; i++){
				texts += checkReason_levels.options[i].text + ",";
				ids   += checkReason_levels.options[i].value + ",";
		}
                
		return texts + '_' + ids;
}

function submitCheckReasonClass(){
		window.returnValue = getReturnStr();
		window.close();
}
</script>
</head>
<body >
<form name="form1">


<div id="Operation_Table" style="width: 101%;padding-left:0px;"><!-- guozw20090828 -->
	<div class="title"><div id="title_zi">选择评定原因</div></div>
    <table width="100%" border="0" cellpadding="0" cellspacing="0">
      <tr>
      	<td class="blue">
      		<table width="45%">
      		<tr><td>
      		<jsp:include page="fK240toK270_tree.jsp">
      			<jsp:param name="op_code" value="k270"/>
      		</jsp:include>
      		</td></tr>
      		</table>
      	</td>
      	<td width="5%">
      	<input type="button" class="b_text" name="btn_to_left" value=" << " onclick="removeCheckReasonClass();"/><br/>
      	<input type="button" class="b_text" name="btn_to_right" value=" >> "/>
      	</td>
        <td width="45%">
		<select name="checkReason_levels" id="checkReason_levels" size="15" style="width:99%;height:100%">
		</select>
        </td>
      </tr>
    </table>
    	<table width="100%" border="0" cellpadding="0" cellspacing="0">
		<tr>
			<td align="center" id="footer">
				<input name="confirm" onClick="submitCheckReasonClass()" type="button" class="b_foot" value="确定">
				<input name="confirm" onClick="window.close()" type="button" class="b_foot" value="取消">
			</td>
		</tr>
	</table>
</div>

</form>
</body>
</html>



<%
  /*
   * ����: ѡ�����ԭ��
�� * �汾: 1.0.0
�� * ����: 2009/01/04
�� * ����: zengzq
�� * ��Ȩ: sitech
   * update:
�� */
%>
<%
	String opCode = "K214";
	String opName = "ѡ�����ԭ��";
%>

<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>

<html>
<head>
	<title>ѡ�������</title>
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

<%@ include file="/npage/include/header.jsp" %>
<div id="Operation_Table"style="width: 100%;padding-left:0px;"><!-- guozw20090828 -->
    <table width="100%" border="0" cellpadding="0" cellspacing="0">
      <tr>
      	<td class="blue">
      		<table width="45%">
      		<tr><td>
      		<jsp:include page="fK240toK270_tree.jsp">
      			<jsp:param name="op_code" value="k260"/>
      		</jsp:include>
      		</td></tr>
      		</table>
      	</td>
      	<td width="10%">
      	<input type="button" name="btn_to_left" value="<<" onclick="removeErrorClass();"/><br/>
      	<input type="button" name="btn_to_right" value=">>"/>
      	</td>
        <td width="45%">
		<select name="error_levels" id="error_levels" size="15" style="width:99%;height:100%">
		</select>
        </td>
      </tr>
    </table>
</div>


<div id="Operation_Table"style="width: 100%;padding-left:0px;"><!-- guozw20090828 -->
	<table width="100%" border="0" cellpadding="0" cellspacing="0">
		<tr>
			<td align="center" id="footer">
				<input name="confirm" onClick="submitErrorClass()" type="button" class="b_foot" value="ȷ��">
				<input name="confirm" onClick="window.close()" type="button" class="b_foot" value="ȡ��">
			</td>
		</tr>
	</table>
</div>


<%@ include file="/npage/include/footer.jsp" %>

</form>
</body>
</html>



<%
  /*
   * 功能: 选择典型案例类型
　 * 版本: 1.0.0
　 * 日期: 2010/05/30
　 * 作者: hucw
　 * 版权: sitech
   * update:
　 */
%>
<%
	String opCode = "K217";
	String opName = "选择典型案例";
%>

<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>

<html>
<head>
	<title>选择典型案例类型</title>
<script>

/**
comment by hucw 20100330	
function selectRemarkClass(val){
		var remark_levels = document.getElementById("remark_levels");
		var option = document.createElement("OPTION");
		option.text = "aaaa";
		option.value = "1";
		remark_levels.add(option);
}
*/

function removeRemarkClass(){
	//删除标题
		var remark_levels = document.getElementById("remark_levels");		
		for(var i = 0; i < remark_levels.length; i++){
				if(remark_levels.options[i].selected==true){
						remark_levels.options.remove(i);					
				}				
		}
		var contmsg = "";
		for(var i = 0; i < remark_levels.length; i++){
					//updated by tangsong 20100525
					//contmsg += document.getElementById('m_content_'+remark_levels.options[i].value).value+"\n";
					contmsg += remark_levels.options[i].text+"\n";									
		}
		document.getElementById("remark_levels_desc").value = contmsg; 
		if(remark_levels.length>=1)
		remark_levels.options[0].selected=true;
}

function getReturnStr(){
		var ids   = "";
		var names = "";
		var remark_levels = document.getElementById("remark_levels");
		for(var i = 0; i < remark_levels.length; i++){
				ids   += remark_levels.options[i].value + ",";
				names += remark_levels.options[i].text + ",";
		}
		var notes = document.getElementById("remark_levels_desc").value;
		return notes + '_' + ids + '_' + names;
}

function submitRemarkClass(){
		window.returnValue = getReturnStr();
		window.close();
}
	
</script>
</head>
<body >
<form name="form1">


<div id="Operation_Table" style="width: 101%;padding-left:0px;"><!-- guozw20090828 -->
	<table width="100%" border="0" cellpadding="0" cellspacing="0">
      <tr>
      	<td colspan="3">
      		<div class="title"><div id="title_zi">选择典型案例类型</div></div>
      	</td>
      </tr>
      <tr>
      	<td class="blue" width="45%">
      		
      		<table width="100%">
      		 <tr>
		        <td width="100%" >
							<jsp:include page="fK240toK270_tree.jsp">
							<jsp:param name="op_code" value="k271"/>
							</jsp:include>
		        </td>
      		 </tr>
      		</table>
      	</td>
      	<td width="5%">
      	<input type="button" name="btn_to_left" class="b_text" value=" << " onclick="removeRemarkClass();"/><br/>
      	<input type="button" name="btn_to_right" class="b_text" value=" >> "/>
      	</td>
        <td width="45%">
					<select name="remark_levels" id="remark_levels" size="15" style="width:99%;height:100%">
				</select>
        </td>
      </tr>
      <tr>
      	<td colspan="3">
      		<div class="title"><div id="title_zi">输入典型案例描述</div></div>	
      	</td>
      </tr>
      <tr>     	
        <td width="100%" colspan="3" height="60%">
					<textarea name="remark_levels_desc_area" id="remark_levels_desc" cols="132" rows="8"></textarea>
        </td>
     </tr>
    </table>
    <table width="100%" border="0" cellpadding="0" cellspacing="0">
		<tr>
			<td align="center" id="footer">
				<input name="confirm" onClick="submitRemarkClass()" type="button" class="b_foot" value="确定">
				<input name="confirm" onClick="window.close()" type="button" class="b_foot" value="取消">
			</td>
		</tr>
	</table>
   </div> 
    
</form>
</body>
</html>
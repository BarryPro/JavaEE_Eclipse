<%
  /*
   * 功能: 选择差错等级
　 * 版本: 1.0.0
　 * 日期: 2008/11/05
　 * 作者: mixh
　 * 版权: sitech
   * update:
　 */
%>
<%
	String opCode = "K217";
	String opName = "选择差错等级";
%>

<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>

<html>
<head>
	<title>选择评语范文</title>
<script>
	
function selectErrorClass(val){
		var error_levels = document.getElementById("error_levels");
		var option = document.createElement("OPTION");
		option.text = "aaaa";
		option.value = "1";
		error_levels.add(option);
}

function removeErrorClass(){
	//删除标题
		var error_levels = document.getElementById("error_levels");		
		for(var i = 0; i < error_levels.length; i++){
				if(error_levels.options[i].selected==true){
						error_levels.options.remove(i);					
				}				
		}
		//updated by tangsong 20100629
		if (error_levels.length == 0) {
			document.getElementById("error_levels_desc").value = "";
			return false;
		}
		var error_ids = "";
		for(var i = 0; i < error_levels.length; i++){
			error_ids += "'" + error_levels.options[i].value + "',";
		}
		error_ids = error_ids.substr(0, error_ids.length-1);
		var myPacket = new AJAXPacket("K250_get_error_desc.jsp","正在提交，请稍候......");
		myPacket.data.add("error_ids",error_ids);
		core.ajax.sendPacket(myPacket,setLevelDesc,true);
		myPacket = null;
		
		if(error_levels.length>=1)
		error_levels.options[0].selected=true;
}

function getReturnStr(){
		var texts = "";
		var error_levels_desc = document.getElementById("error_levels_desc").value;
		return error_levels_desc;
}

function submitErrorClass(){
		window.returnValue = getReturnStr();
		window.close();
}

//added by tangsong 20100629
function setLevelDesc(myPacket) {
	var descriptions = myPacket.data.findValueByName("descriptions");
	var re = /@#/g;
	descriptions = descriptions.replace(re,"\n");
	document.getElementById("error_levels_desc").value = descriptions;
}
</script>
</head>
<body >
<form name="form1">


<div id="Operation_Table" style="width: 103.2%;padding-left:0px;"><!-- guozw20090828 -->
	<div class="title"><div id="title_zi">选择评语范文</div></div>
	<table width="100%" border="0" cellpadding="0" cellspacing="0">
      <tr>
      	<td class="blue" width="45%">
      		
      		<table width="100%">
      		 <tr>
		        <td width="100%" >
							<jsp:include page="fK240toK270_tree.jsp">
							<jsp:param name="op_code" value="k250"/>
							</jsp:include>
		        </td>
      		 </tr>
      		</table>
      	</td>
      	<td width="5%">
      	<input type="button" name="btn_to_left" class="b_text" value=" << " onclick="removeErrorClass();"/><br/>
      	<input type="button" name="btn_to_right" class="b_text" value=" >> "/>
      	</td>
        <td width="45%">
					<select name="error_levels" id="error_levels" size="15" style="width:99%;height:100%">
				</select>
        </td>
      </tr>
      <tr>     	
        <td width="100%" colspan="3" height="60%">
					<!--<select name="error_levels_desc_area" id="error_levels_desc" size="15" style="width:970px;height:2000px">-->
					<textarea  name="error_levels_desc_area" id="error_levels_desc" cols="135" rows="8"></textarea>
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
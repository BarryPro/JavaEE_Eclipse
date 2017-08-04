<%
  /*
   * 功能: e743 全网集团业务订单受理
   * 版本: 1.0
   * 日期: 2012-03-31
   * 作者: wanghfa
   * 版权: si-tech
  */
%>
<%@ page contentType= "text/html;charset=GBK" %>
<%
	response.setHeader("Pragma","No-Cache"); 
	response.setHeader("Cache-Control","No-Cache");
	response.setDateHeader("Expires", 0); 
%>
<script type=text/javascript>
	getServiceMsg("se743QryBSL", "doGetBusinessScene",1, $("#orderType").val(), $("#poSpec").val(),in_ChanceId);
	
	function doGetBusinessScene(data) {
		$("#json1").val(data.trim());
		var businessSceneJson = eval("(" + $("#json1").val() + ")");
		
		$("#businessScene").empty();
		if (businessSceneJson.BusiScenes != null) {
			for (var a = 0; a < businessSceneJson.BusiScenes.length; a ++) {
				var _scene = businessSceneJson.BusiScenes[a];
				document.getElementById("businessScene").options.add(new Option(_scene.SceneName, _scene.SceneId)); 
				sceneObj[_scene.SceneId] = _scene.SceneType;
			}
			controlBtn(false);
		} else {
			document.getElementById("businessScene").options.add(new Option("无", "")); 
			$("#backBtn").attr("disabled", false);
		}
	}
	
	function unAvailableBusinessSceneArea() {
		unAvailable("businessScene");
	}
	
	function getBusinessSceneObj() {
		var bsId = $('#businessScene').val();
		if(bsId != null && bsId != '') {
			rstJson.input.SceneId = parseInt(bsId);	
		}else if(bsId == '') {
			rstJson.input.SceneId = bsId;
		}
	}
</script>

<table>
	<tr>
		<td class="blue" width="20%">选择业务办理场景</td>
		<td width="80%">
			<select name="businessScene" id="businessScene" style="width:200px">
				<option value="">等待初始化......</option>
			</select>
		</td>
	</tr>
</table>

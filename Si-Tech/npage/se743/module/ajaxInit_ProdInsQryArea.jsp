<%
  /*
   * 功能: 产品实例列表
   * 版本: 1.0
   * 日期: 2012-03-31
   * 作者: liujian
   * 版权: si-tech
  */
%>
<%@ page contentType= "text/html;charset=GBK" %>
<%
	response.setHeader("Pragma","No-Cache"); 
	response.setHeader("Cache-Control","No-Cache");
	response.setDateHeader("Expires", 0); 
	String areaId = request.getParameter("areaId");
%>
<script type=text/javascript>
	var areaId = '<%=areaId%>';
	var _json = getObjFromSrv(areaId);
	getHtmlSegment(_json.Elements,"<%=areaId%>_table");
	
	var count = 0;
	function addRule() {
		var sval = $('#<%=areaId%>_table select').val();
		if(sval == '') {
			return false;	
		}
		if(areaFunctions[sval]) {
			rdShowMessageDialog("一个产品订购关系编码只能添加一次！");	
			return false;	
		}
		var sname = $('#<%=areaId%>_table select').find("option:selected").text();
		count++;
		//productspecqry_sub_ruleId_count
		getOnlyTitleArea("<%=areaId%>_sub_" + sval + '_' + count + '_', "产品实例详单--" + sname , 0,20,'<%=areaId%>Area',true);
		var sval = $('#<%=areaId%>_table select').val();
		getServiceMsg("se743QryPSR", "doGetDetail",1,sceneId,'','',sval, $('input[name="POOrderNumber"]').val());		
	}
	
	//记录二级页面的ContainerPath
	function doGetDetail(data) {
		var subAreas = new Array();
		var sval = $('#<%=areaId%>_table select').val();
		setJson1Val(data);
		var _obj = eval("(" + data + ")");
		if (_obj.ElementTypes != null  || _obj.ProductOrderCharacters != null) {
			var funs = new Array();
			//liujian 解析服务返回的json串进行展示
			for (var a = 0; a < _obj.ElementTypes.length; a ++) {
				var busi_json_elType = _obj.ElementTypes[a];
				
				subAreas.push(busi_json_elType.ContainerPath);
				getInnerArea(busi_json_elType.ContainerPath, busi_json_elType.ElementTypeName, 0,20,'<%=areaId%>_sub_' + sval + '_' + count + '_Area');
				//liujian 2012-8-17 16:14:01  fromType区分分支   模块总共有三个分支，1：在途onWay 2：实例instance 3：正常办理undefined
				var fromType = 'instance';
				initInnerArea(busi_json_elType.ContainerPath,'<%=areaId%>_sub_' + sval + '_' + count + '_Area',fromType);
			}
			if(_obj.ProductOrderCharacters) {
				subAreas.push("ProductOrderCharacters");
				getInnerArea("ProductOrderCharacters", "产品属性值列表", 0,20,'<%=areaId%>_sub_' + sval + '_' + count + '_Area');	
				initInnerArea("ProductOrderCharacters",'<%=areaId%>_sub_' + sval + '_' + count + '_Area');
			}
			addMainArea('sub_' + sval + '_' +  count,sval,subAreas);
			removeBtnDisabled();
		} else {
			rdShowMessageDialog("读取商品级要素规则错误！", 1);
		}
	}
	
	function addMainArea(mainAreaId,ruleId,subAreas) {
		//点击添加
		//1.1 获得规格Id,新添加的父区域id
		//1.2 解析服务返回的数据获得subAreas
		//1.3 往areaFunctions中添加规格对象
		//1.3.1 如果规格对象不存在
		if(!areaFunctions[ruleId]) {
			areaFunctions[ruleId] = {};
			areaFunctions[ruleId].subArea = subAreas;
			areaFunctions[ruleId].mainArea = [];
			areaFunctions[ruleId].mainArea.push(mainAreaId);
		}
		//1.3.2如果规格对象存在
		else {
			areaFunctions[ruleId].mainArea.push(mainAreaId);
		}
	}
	
	function getProdInsQryObj() {
		rstJson.input.ProductOrders = [];
		for(var p in areaFunctions) {
			var mainAreas = areaFunctions[p].mainArea;
			var subAreas = areaFunctions[p].subArea;
			for(var i=0,len=mainAreas.length;i<mainAreas.length;i++) {
				ProductOrder = {};
				var areaId = '<%=areaId%>_' + mainAreas[i] + '_Area';
				for(var j=0,len2 = subAreas.length;j<len2;j++) {
					var subArea = subAreas[j];
					new Function('get' + subArea + 'Obj'+ '("' + areaId + '")')();
				}
				rstJson.input.ProductOrders.push(ProductOrder);
			}
		}
	}
	
	/*
		二级页面
		getPayCompanysObj(areaId)//支付省
		getProductOrderCharactersObj(areaId);//产品属性值
		getProductOrderChargeObj(areaId);//产品一次性消费
		getproductorderinfoObj(areaId);//产品基本信息
		getProductOrderRatePlansObj(areaId);//产品级资费列表
		getManageNodeObj(areaId);//省BOSS上传管理节点
		getManageNodeGetObj(areaId);//省BOSS下传管理节点
	*/
	
	$(function() {
		//获得商品订单号
		var ponum = $('input[name="POOrderNumber"]').val();
		if(!ponum) {	
			ponum = '';
		}
		//insOfferId:商品订购关系编码
		//getServiceMsg("se743QryPSROW", "doQryPSROW",1,sceneId,in_ChanceId,ponum,insOfferId);			
	});
</script>

<form>
	<table id="<%=areaId%>_table">
		
	</table>
</form>
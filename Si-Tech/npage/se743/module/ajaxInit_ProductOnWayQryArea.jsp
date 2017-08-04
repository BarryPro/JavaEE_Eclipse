<%
  /*
   * 功能: 
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
<script language="javascript" type="text/javascript" src="/npage/se743/json2.js"></script>
<script type=text/javascript>
//	var _json2 ='{"ContainerPath": "PoInstanceQry","ElementType": 3,"ElementTypeName": "产品实例列表","Elements": [{"EFormat": "","EMaxVal": "","EMinVal": "","EMust": "0","EOrder": 0,"EType": "","EUpdate": "1","EValue": "实例","ElementAlter": "","ElementCode": "orderPro","ElementId": 1,"ElementName": "实例","FormType": "select","SelShow": "火影忍者~海贼王~死神~","SelValue": "1~2~3~","ElementGroup": 0}]}';
//	var _json = eval("(" + _json2 + ")");
	
	function addInsMainArea(mainAreaId,ruleId,subAreas) {
		// 和产品规格不同
		//{ruleId:{mainAreaId:[]}}
		//点击添加
		//1.1 获得规格Id,新添加的父区域id
		//1.2 解析服务返回的数据获得subAreas
		//1.3 往areaFunctions中添加规格对象
		//1.3.1 如果规格对象不存在
		if(!areaFunctions[ruleId]) {
			areaFunctions[ruleId] = {};
		//	areaFunctions[ruleId].subArea = subAreas;
		//	areaFunctions[ruleId][mainAreaId] = subAreas;
		//	areaFunctions[ruleId].mainArea.push(mainAreaId);
		}
		//1.3.2如果规格对象存在
		//else {
		//	areaFunctions[ruleId].mainArea.push(mainAreaId);
		//}
		areaFunctions[ruleId][mainAreaId] = subAreas;
	}
	
	function getProductOnWayQryObj() {
		rstJson.input.ProductOrders = [];
		for(var p in areaFunctions) {
			for(var m in areaFunctions[p]) {
				ProductOrder = {};
				var subAreas = areaFunctions[p][m];
				var areaId = 'productspecqry_' + m + '_Area';
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
		getServiceMsg("se743QryPSROW", "doQryPSROW",1,sceneId,in_ChanceId,ponum);		
	});
	
	function doQryPSROW(data) {
		var sval = 0;
		var _obj = eval("(" + data + ")");
		var _proIns = _obj.ProductOrders;
		if(_proIns) {
			for(var i=0,len=_proIns.length;i<len;i++) {
				var subAreas = new Array();
				var _ins = 	_proIns[i];
				var _name = _ins.ProductSpecName;
				$('#json1').val(JSON2.stringify(_ins));
				getOnlyTitleArea("productspecqry_sub_" + sval + '_' + i + '_', _name , 0,20,'<%=areaId%>Area',false);
				if (_ins.ElementTypes != null  || _ins.ProductOrderCharacters != null) {
					var funs = new Array();
					//liujian 解析服务返回的json串进行展示
					for (var a = 0; a < _ins.ElementTypes.length; a ++) {
						var busi_json_elType = _ins.ElementTypes[a];
						subAreas.push(busi_json_elType.ContainerPath);
						getInnerArea(busi_json_elType.ContainerPath, busi_json_elType.ElementTypeName, 0,20,'productspecqry_sub_' + sval + '_' + i + '_Area');
						//liujian 2012-8-17 16:14:01  fromType区分分支   模块总共有三个分支，1：在途onWay 2：实例instance 3：正常办理undefined
						var fromType = 'onWay';
						initInnerArea(busi_json_elType.ContainerPath,'productspecqry_sub_' + sval + '_' + i + '_Area',fromType);
					
					}
					if(_ins.ProductOrderCharacters) {
						subAreas.push("ProductOrderCharacters");
						getInnerArea("ProductOrderCharacters", "产品属性值列表", 0,20,'productspecqry_sub_' + sval + '_' + i + '_Area');	
						initInnerArea("ProductOrderCharacters",'productspecqry_sub_' + sval + '_' + i + '_Area');
					}
					addInsMainArea('sub_' + sval + '_' +  i,sval,subAreas);
				} else {
					rdShowMessageDialog("读取商品级要素规则错误！", 1);
				}
			}
		}
	}
	
	function getProductOnWayQryObj() {
		rstJson.input.ProductOrders = [];
		for(var p in areaFunctions) {
			for(var m in areaFunctions[p]) {
				ProductOrder = {};
				var subAreas = areaFunctions[p][m];
				var areaId = 'productspecqry_' + m + '_Area';
				for(var j=0,len2 = subAreas.length;j<len2;j++) {
					var subArea = subAreas[j];
					new Function('get' + subArea + 'Obj'+ '("' + areaId + '")')();
				}
				rstJson.input.ProductOrders.push(ProductOrder);
			}
		}
	}
</script>

<form>
	<table id="<%=areaId%>_table">
		
	</table>
</form>
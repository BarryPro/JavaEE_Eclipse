<%
  /*
   * 功能: 产品规格列表
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
	/*
	var _json2 ='{"ContainerPath": "productspecqry","ElementType": 3,"ElementTypeName": "产品规格列表","Elements": [{"EFormat": "","EMaxVal": "","EMinVal": "","EMust": "0","EOrder": 0,"EType": "","EUpdate": "1","EValue": "资费项","ElementAlter": "","ElementCode": "orderPro","ElementId": 1,"ElementName": "资费项","FormType": "select","SelShow": "火影忍者~海贼王~死神~","SelValue": "1~2~3~","ElementGroup": 0}]}';
	var areaId = '<%=areaId%>';
	var _json = eval("(" + _json2 + ")");
	*/
	var areaId = '<%=areaId%>';
	var _json = getObjFromSrv(areaId);
	getHtmlSegment(_json.Elements,"<%=areaId%>_table");
	
	var count = 0;
	function addRule() {
		var sval = $('#<%=areaId%>_table select').val();
		if(sval == '') {
			return false;	
		}
		var sname = $('#<%=areaId%>_table select').find("option:selected").text();
		count++;
		//productspecqry_sub_ruleId_count
		getOnlyTitleArea("<%=areaId%>_sub_" + sval + '_' + count + '_', "产品规格详单--" + sname , 0,20,'<%=areaId%>Area',true);
		var sval = $('#<%=areaId%>_table select').val();
		getServiceMsg("se743QryPSR", "doGetDetail",1,sceneId,'',sval);	
	}
	function setProdRuleSelect(k) {
		//alert("setProdRuleSelect");
		var obj = eval("(" + k + ")");
		var selArr = new Array();
		if(!isBlack(obj)) {
			var ps = obj.ProductSpecList;
			if(!isBlack(ps)) {
				for(var i=0,len=ps.length;i<len;i++) {
					selArr.push('<option value=' + ps[i].ProSceneId + '/>');
					selArr.push(ps[i].ProductSpecName);
					selArr.push('</option>');	
				}	
			}
			if(selArr.length > 0) {
				$('#<%=areaId%>_table select').empty();
				$('#<%=areaId%>_table select').append(selArr.join(''));
			}
		}
	}
	//记录二级页面的ContainerPath
	
	function doGetDetail(data) {
		var subAreas = new Array();
		var sval = $('#<%=areaId%>_table select').val();
		/*
		var testObj = '';
		
		if(sval == 1) {
			testObj = '{"ElementTypes": [{"ContainerPath": "ProductOrderCharge","ElementType": 3,"ElementTypeName": "产品一次性消费","Elements": [{"EFormat": "","EMaxVal": "","EMinVal": "","EMust": "0","EOrder": 0,"EType": "","EUpdate": "0","EValue": "资费项","ElementAlter": "","ElementCode": "orderPro","ElementId": 1,"ElementName": "资费项","FormType": "text","SelShow": "","SelValue": "","ElementGroup": 0}, {"EFormat": "","EMaxVal": "","EMinVal": "","EMust": "1","EOrder": 1,"EType": "","EUpdate": "1","EValue": "","ElementAlter": "","ElementCode": "pay","ElementId": 1,"ElementName": "费用","FormType": "text","SelShow": "","SelValue": "","ElementGroup": 0}, {"EFormat": "","EMaxVal": "","EMinVal": "","EMust": "0","EOrder": 0,"EType": "","EUpdate": "0","EValue": "资费项","ElementAlter": "","ElementCode": "orderPro","ElementId": 1,"ElementName": "资费项","FormType": "text","SelShow": "","SelValue": "","ElementGroup": 1}, {"EFormat": "","EMaxVal": "","EMinVal": "","EMust": "1","EOrder": 1,"EType": "","EUpdate": "1","EValue": "","ElementAlter": "","ElementCode": "pay","ElementId": 1,"ElementName": "费用","FormType": "text","SelShow": "","SelValue": "","ElementGroup": 1}, {"EFormat": "","EMaxVal": "","EMinVal": "","EMust": "0","EOrder": 0,"EType": "","EUpdate": "0","EValue": "资费项","ElementAlter": "","ElementCode": "orderPro","ElementId": 1,"ElementName": "资费项","FormType": "text","SelShow": "","SelValue": "","ElementGroup": 2}, {"EFormat": "","EMaxVal": "","EMinVal": "","EMust": "1","EOrder": 1,"EType": "","EUpdate": "1","EValue": "","ElementAlter": "","ElementCode": "pay","ElementId": 1,"ElementName": "费用","FormType": "text","SelShow": "","SelValue": "","ElementGroup": 2}]}],"ProductOrderCharacters": [{"AlterInfo": "","CharacterGroup": "1","CharacterGroupName": "组1","CharacterName": "预受理工单编号","CharacterNumber": "999033700","CharacterOrder": 1,"CharacterType": "select","DefaultValue": "4444444444444","FieldCode": "","MaxLength": "100","MaxVal": "","MinVal": "","MultipleAble": "","ReadOnly": "","RequireFlag": "","SelShow": "安安~贝贝~出差~~","SelValue": "aa~bb~cc~","ShowFlag": "","VFormat": "","VType": "string"}, {"AlterInfo": "","CharacterGroup": "0","CharacterGroupName": "组0","CharacterName": "客户背景","CharacterNumber": "999033701","CharacterOrder": 2,"CharacterType": "select","DefaultValue": "333333333333","FieldCode": "","MaxLength": "2","MaxVal": "3","MinVal": "1","MultipleAble": "","ReadOnly": "true","RequireFlag": "","SelShow": "安安~贝贝~出差~~","SelValue": "aa~bb~cc~","ShowFlag": "","VFormat": "","VType": ""}, {"AlterInfo": "","CharacterGroup": "0","CharacterGroupName": "组0","CharacterName": "详细需求附件","CharacterNumber": "999033702","CharacterOrder": 3,"CharacterType": "","DefaultValue": "222222222","FieldCode": "","MaxLength": "11","MaxVal": "","MinVal": "","MultipleAble": "","ReadOnly": "true","RequireFlag": "","SelShow": "","SelValue": "","ShowFlag": "","VFormat": "33","VType": ""}, {"AlterInfo": "","CharacterGroup": "2","CharacterGroupName": "组2","CharacterName": "是否统一资费","CharacterNumber": "999033703","CharacterOrder": 4,"CharacterType": "","DefaultValue": "11111111111","FieldCode": "","MaxLength": "","MaxVal": "","MinVal": "","MultipleAble": "","ReadOnly": "","RequireFlag": "","SelShow": "","SelValue": "","ShowFlag": "","VFormat": "","VType": ""}, {"AlterInfo": "","CharacterGroup": "2","CharacterGroupName": "组2","CharacterName": "详细需求附件","CharacterNumber": "999033702","CharacterOrder": 3,"CharacterType": "","DefaultValue": "222222222","FieldCode": "","MaxLength": "11","MaxVal": "","MinVal": "","MultipleAble": "","ReadOnly": "true","RequireFlag": "","SelShow": "","SelValue": "","ShowFlag": "","VFormat": "33","VType": ""}]}';
		}else if(sval == 2) {
			testObj = '{"ElementTypes": [{"ContainerPath": "PayCompanys","ElementType": 3,"ElementTypeName": "支付省","Elements": [{"EFormat": "","EMaxVal": "","EMinVal": "","EMust": "0","EOrder": 0,"EType": "","EUpdate": "1","EValue": "","ElementAlter": "","ElementCode": "POAuditName","ElementId": 1,"ElementName": "支付省编码","FormType": "text","SelShow": "","SelValue": "","ElementGroup": 0}, {"EFormat": "","EMaxVal": "","EMinVal": "","EMust": "1","EOrder": 1,"EType": "","EUpdate": "1","EValue": "","ElementAlter": "","ElementCode": "POAuditTime","ElementId": 1,"ElementName": "支付省编码","FormType": "text","SelShow": "","SelValue": "","ElementGroup": 0}]}],"ProductOrderCharacters": [{"AlterInfo": "","CharacterGroup": "1","CharacterGroupName": "组1","CharacterName": "预受理工单编号","CharacterNumber": "999033700","CharacterOrder": 1,"CharacterType": "select","DefaultValue": "4444444444444","FieldCode": "","MaxLength": "100","MaxVal": "","MinVal": "","MultipleAble": "","ReadOnly": "","RequireFlag": "","SelShow": "安安~贝贝~出差~~","SelValue": "aa~bb~cc~","ShowFlag": "","VFormat": "","VType": "string"}, {"AlterInfo": "","CharacterGroup": "0","CharacterGroupName": "组0","CharacterName": "客户背景","CharacterNumber": "999033701","CharacterOrder": 2,"CharacterType": "select","DefaultValue": "333333333333","FieldCode": "","MaxLength": "2","MaxVal": "3","MinVal": "1","MultipleAble": "","ReadOnly": "true","RequireFlag": "","SelShow": "安安~贝贝~出差~~","SelValue": "aa~bb~cc~","ShowFlag": "","VFormat": "","VType": ""}, {"AlterInfo": "","CharacterGroup": "0","CharacterGroupName": "组0","CharacterName": "详细需求附件","CharacterNumber": "999033702","CharacterOrder": 3,"CharacterType": "","DefaultValue": "222222222","FieldCode": "","MaxLength": "11","MaxVal": "","MinVal": "","MultipleAble": "","ReadOnly": "true","RequireFlag": "","SelShow": "","SelValue": "","ShowFlag": "","VFormat": "33","VType": ""}, {"AlterInfo": "","CharacterGroup": "2","CharacterGroupName": "组2","CharacterName": "是否统一资费","CharacterNumber": "999033703","CharacterOrder": 4,"CharacterType": "","DefaultValue": "11111111111","FieldCode": "","MaxLength": "","MaxVal": "","MinVal": "","MultipleAble": "","ReadOnly": "","RequireFlag": "","SelShow": "","SelValue": "","ShowFlag": "","VFormat": "","VType": ""}, {"AlterInfo": "","CharacterGroup": "2","CharacterGroupName": "组2","CharacterName": "详细需求附件","CharacterNumber": "999033702","CharacterOrder": 3,"CharacterType": "","DefaultValue": "222222222","FieldCode": "","MaxLength": "11","MaxVal": "","MinVal": "","MultipleAble": "","ReadOnly": "true","RequireFlag": "","SelShow": "","SelValue": "","ShowFlag": "","VFormat": "33","VType": ""}]}';
		}else if(sval == 3) {
			testObj = '	{	"ElementTypes": [	{	"ContainerPath": "ProductOrderBase",	"ElementType": 3,	"ElementTypeName": "产品订单基础信息222",	"Elements": [	{	"EFormat": "",	"EMaxVal": "",	"EMinVal": "",	"EMust": "0",	"EOrder": 0,	"EType": "",	"EUpdate": "1",	"EValue": "",	"ElementAlter": "",	"ElementCode": "POAuditName",	"ElementId": 1,	"ElementName": "审批人姓名",	"FormType": "text",	"SelShow": "",	"SelValue": "",	"ElementGroup": 0	}, {	"EFormat": "",	"EMaxVal": "",	"EMinVal": "",	"EMust": "1",	"EOrder": 1,	"EType": "",	"EUpdate": "0",	"EValue": "",	"ElementAlter": "",	"ElementCode": "POAuditTime",	"ElementId": 1,	"ElementName": "审批时间(格式：YYYYMMDDhhmiss)",	"FormType": "text",	"SelShow": "",	"SelValue": "",	"ElementGroup": 0	}, {	"EFormat": "",	"EMaxVal": "",	"EMinVal": "",	"EMust": "1",	"EOrder": 2,	"EType": "",	"EUpdate": "1",	"EValue": "",	"ElementAlter": "",	"ElementCode": "question",	"ElementId": 1,	"ElementName": "审批意见",	"FormType": "text",	"SelShow": "",	"SelValue": "",	"ElementGroup": 0	}	]	}, {	"ContainerPath": "ProductOrderList",	"ElementType": 3,	"ElementTypeName": "产品订单列表222",	"Elements": [	{	"EFormat": "",	"EMaxVal": "",	"EMinVal": "",	"EMust": "0",	"EOrder": 0,	"EType": "",	"EUpdate": "1",	"EValue": "",	"ElementAlter": "",	"ElementCode": "POAuditName",	"ElementId": 1,	"ElementName": "审批人姓名",	"FormType": "text",	"SelShow": "",	"SelValue": "",	"ElementGroup": 0	}, {	"EFormat": "",	"EMaxVal": "",	"EMinVal": "",	"EMust": "1",	"EOrder": 1,	"EType": "",	"EUpdate": "0",	"EValue": "",	"ElementAlter": "",	"ElementCode": "POAuditTime",	"ElementId": 1,	"ElementName": "审批时间(格式：YYYYMMDDhhmiss)",	"FormType": "text",	"SelShow": "",	"SelValue": "",	"ElementGroup": 0	}, {	"EFormat": "",	"EMaxVal": "",	"EMinVal": "",	"EMust": "1",	"EOrder": 2,	"EType": "",	"EUpdate": "1",	"EValue": "",	"ElementAlter": "",	"ElementCode": "question",	"ElementId": 1,	"ElementName": "审批意见",	"FormType": "text",	"SelShow": "",	"SelValue": "",	"ElementGroup": 0	}	]	}	]	}';
		}
		
		var _obj = eval("(" + testObj + ")");
		*/
		//subAreasJson = data;
		setJson1Val(data);
		var _obj = eval("(" + data + ")");
		if (_obj.ElementTypes != null  || _obj.ProductOrderCharacters != null) {
			var funs = new Array();
			//liujian 解析服务返回的json串进行展示
			for (var a = 0; a < _obj.ElementTypes.length; a ++) {
				var busi_json_elType = _obj.ElementTypes[a];
				
				subAreas.push(busi_json_elType.ContainerPath);
				getInnerArea(busi_json_elType.ContainerPath, busi_json_elType.ElementTypeName, 0,20,'<%=areaId%>_sub_' + sval + '_' + count + '_Area');
				initInnerArea(busi_json_elType.ContainerPath,'<%=areaId%>_sub_' + sval + '_' + count + '_Area');
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
	
	function getproductspecqryObj() {
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
</script>

<form>
	<table id="<%=areaId%>_table">
		
	</table>
</form>
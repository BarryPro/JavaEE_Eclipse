var rstJson = {input:{}};
var sceneId = '';//业务办理场景
var proSceneId = '';//产品规格编号
var insOfferId = '';//商品订购关系编码
var waNo = '';//工作流传回
var in_ChanceId = '';//工作流传回  即woNo
var fromType = '';// liujian 2013-5-17 10:43:56 查看来源，有一个业务是从esop发过来 添加esop来源
var fileMapping = {};//属性的文件上传“name:area_count_code_seq ,value:*******.***”，附件的文件上传“name:poAttFile_1,value:***.***”
var hideAddProBtn = false;
var hideEcCodeBtn = false;
var areaFunctions = {};
var mainAreaArray = new Array();
var ProductOrder = {};
var checkboxArray = new Array();
var sceneObj={};//name:SceneId,value=sceneType//为了标识分支，如果为2则显示实例区域，其他不显示实例区域
//注：如果二级区域中存在下拉的doProcess事件，则设置全局变量
/*
	name:areaId,
	value : parentId
	eg. ProductOrderRatePlans中的select的父节点
	name:ProductOrderRatePlans,
	value : parentId
*/
var selectParent = {};
var ratePlansGroup ;
//var planSelectParentID = '';
//var subAreasJson = '';//二级页面的json串	
//最后提交json
function rstSubmit() {
	//拼接json串
	//getcustomerObj();//客户基本信息
	//getBusinessSceneObj();业务场景
	//getContactorInfoObj();//商品订购的联系人信息
	//getPOAttachmentObj();//商品订购对应的附件信息 
	//getPOOrderChargesObj();//商品一次性消费
	//getpoorderinfoObj();//商品基本信息
	//getPOOrderRatePolicysObj();//套餐
	//getproductspecqryObj();//产品规格
	//getPOAuditObj();//业务审批信息
	//getBaseInfoObj();//fe743.jsp 获得基础信息
	
	
	
	if(mainAreaArray.length > 0) {
		for(var i=0,len = mainAreaArray.length;i<len;i++) {
			new Function('get' + mainAreaArray[i] + 'Obj'+ '()')();
		}	
	}
	getBaseInfoObj();
	getBusinessSceneObj();//获得场景
	$('#json1').val(JSON2.stringify(rstJson));
	 
}

function setJson1Val(data) {
	$('#json1').val(data);	
}

function isArray(o) {   
  return Object.prototype.toString.call(o) === '[object Array]';    
} 
/*
 * Array新方法removeElByValue
 * 删除数组中的对象，该对象的name属性是val值
 * @param {Object} val
 * @param {Object} name
 */
Array.prototype.removeElByValue = function(val,name) {
    var index = this.indexOfByValue(val,name);
    if (index > -1) {
        this.splice(index, 1);
    }
};
/*
 * Array新方法indexOfByValue
 * 判断对象的name属性的val值，是否存在Array中
 * @param {Object} val
 * @param {Object} name
 */
Array.prototype.indexOfByValue = function(val,name) {
    for (var i = 0; i < this.length; i++) {
        if (this[i][name] == val) return i;
    }
    return -1;
};

/*
 * Array新方法getElByValue
 * 获得数组中的对象，该对象的name属性是val值
 * @param {Object} val
 * @param {Object} name
 */
Array.prototype.getElByValue = function(val,name) {
    for (var i = 0; i < this.length; i++) {
        if (this[i][name] == val)  {
        	return this[i];
        }
    }
    return -1;
}; 

function getFormValueByName(tableId,name) {
	var value = '';
	var inputVal = $('#' + tableId).find('input[name="' + name + '"]').val();
	var seletVal = $('#' + tableId).find('select[name="' + name + '"]').val();
	if(typeof(inputVal) != 'undefined') {
		value = inputVal;
	}else if(typeof(seletVal) != 'undefined'){
		value = seletVal;
	}
	return value;
}

function getTdValByObj($obj) {
	var value = '';
	var inputVal = $obj.find('input').val();
	var selectVal = $obj.find('select').val();
	if(inputVal) {
		value = inputVal;
	}else if(selectVal) {
		value = selectVal;	
	}
	return value;
}
//其实和Province一样
function SingleSelectObj(name,value) {
	this.name = name;
	this.value = value;	
}
	    
function Province(code,name) {
	this.code = code;
	this.name = name;
}
var provArr = [
	new Province('100','北京'),new Province('290','陕西'), new Province('311','河北'),
	new Province('351','山西'),new Province('371','河南'),new Province('431','吉林'),
	new Province('451','黑龙江'),new Province('471','内蒙古'),new Province('531','山东'),
	new Province('551','安徽'),new Province('571','浙江'),new Province('200','广东'),
	new Province('591','福建'),new Province('731','湖南'),new Province('771','广西'),
	new Province('791','江西'),new Province('851','贵州'),new Province('871','云南'),
	new Province('891','西藏'),new Province('898','海南'),new Province('931','甘肃'),
	new Province('951','宁夏'),new Province('210','上海'),new Province('971','青海'),
	new Province('991','新疆'),new Province('000','有限公司'),new Province('220','天津'),
	new Province('230','重庆'),new Province('240','辽宁'),new Province('250','江苏'),
	new Province('270','湖北'),new Province('280','四川')
];

//wanghf 给服务传递json串，去掉（从服务发过来的对象的）多余的属性
function trimJson(parentNode) {
	if (parentNode.length) {
		for(var i = 0; i < parentNode.length; i ++) {
			for(var key in parentNode) {
				if (key == "eleValue" && typeof parentNode[key] == "string") {
				} else if (key == "vMust" && typeof parentNode[key] == "string") {
					delete parentNode[key];
				} else if (key == "vType" && typeof parentNode[key] == "string") {
					delete parentNode[key];
				} else if (key == "vFormat" && typeof parentNode[key] == "string") {
					delete parentNode[key];
				} else if (key == "vMinvalue" && typeof parentNode[key] == "string") {
					delete parentNode[key];
				} else if (key == "vMaxvalue" && typeof parentNode[key] == "string") {
					delete parentNode[key];
				} else if (key == "vUpType" && typeof parentNode[key] == "string") {
					delete parentNode[key];
				} else if (typeof parentNode[key] == "object"){
					parentNode[key] = trimJson(parentNode[key]);
				}
			}
		}
	} else {
		for(var key in parentNode) {
			if (key == "eleValue" && typeof parentNode[key] == "string") {
			} else if (key == "vMust" && typeof parentNode[key] == "string") {
				delete parentNode[key];
			} else if (key == "vType" && typeof parentNode[key] == "string") {
				delete parentNode[key];
			} else if (key == "vFormat" && typeof parentNode[key] == "string") {
				delete parentNode[key];
			} else if (key == "vMinvalue" && typeof parentNode[key] == "string") {
				delete parentNode[key];
			} else if (key == "vMaxvalue" && typeof parentNode[key] == "string") {
				delete parentNode[key];
			} else if (key == "vUpType" && typeof parentNode[key] == "string") {
				delete parentNode[key];
			} else if (typeof parentNode[key] == "object"){
				parentNode[key] = trimJson(parentNode[key]);
			}
		}
	}
	return parentNode;
}

//wanghf 设置form表单的属性值
function putElement(eleId, eleJsonObj) {
	if (eleJsonObj.eleValue != "") {
		$("#" + eleId).val(eleJsonObj.eleValue);
	}
	if (eleJsonObj.vMust != "") {
		$("#" + eleId).attr("v_must", eleJsonObj.vMust);
	}
	if (eleJsonObj.vType != "") {
		$("#" + eleId).attr("v_type", eleJsonObj.vType);
	}
	if (eleJsonObj.vFormat != "") {
		$("#" + eleId).attr("v_format", eleJsonObj.vFormat);
	}
	if (eleJsonObj.vMinvalue != "") {
		$("#" + eleId).attr("v_minvalue", eleJsonObj.vMinvalue);
	}
	if (eleJsonObj.vMaxvalue != "") {
		$("#" + eleId).attr("v_maxvalue", eleJsonObj.vMaxvalue);
	}
	if (eleJsonObj.vUpType != "") {
		$("#" + eleId).attr("v_upType", eleJsonObj.vUpType);
	}
}

function getObjFromSrv(areaId) {
	var json = eval("(" + $("#json1").val() + ")");
	var _json = '';
	for(var i=0,len=json.ElementTypes.length;i<len;i++) {
		var elType = json.ElementTypes[i];
		if(elType.ContainerPath == areaId) {
		//	if(elType.Elements != null && elType.Elements.length > 0) {
				_json = elType;
		//	}
		}
	}	
	return _json;
}
//把jsp返回的代码片段放到div里面
function initArea(areaId) {
	$("#" + areaId + "AreaTitle").show();
	$("#" + areaId + "AreaLoading").show();
	$("#" + areaId + "Area").hide();
	//ajaxInit_" + areaId + "Area.jsp 文件新创建
	var packet = new AJAXPacket("module/ajaxInit_" + areaId + "Area.jsp", "正在初始化，请稍等......");
	//liujian 添加参数	
	packet.data.add("areaId", areaId);
	core.ajax.sendPacketHtml(packet, function(data) {
		$("#" + areaId + "AreaLoading").hide();
		$("#" + areaId + "Area").empty();
		$("#" + areaId + "Area").append(data);
		$("#" + areaId + "Area").hide();
		$("#" + areaId + "Area").slideDown(300);
	});
	packet = null;
}

//切换 显示与否
function change(v,areaId,parentId) {
	if(!isBlack(parentId)) {
		$('#' + parentId + ' #' + areaId + 'Area').toggle();
	}else {
		$('#' + areaId + 'Area').toggle();
	}
	
	if($(v).attr('src').indexOf('jia.gif') != -1) {
		$(v).attr('src','/nresources/default/images/jian.gif');
	}else {
		$(v).attr('src','/nresources/default/images/jia.gif');
	}
}

function delArea(v,areaId) {
	
	//截取areaId，productspecqry_sub_ruleId_count_Area
	var temps = split(areaId,'_');
	if(temps.length == 4) {
		var count = temps[3];
		//'sub_' + sval + '_' +  count + '_Area'
		//删除区域
		//2.1 获得规格Id，待删除的父区域id
		var ruleId = temps[2];
		var mainAreaId = areaId.substring(areaId.indexOf("_")+1,areaId.length-1);//之所以-1是因为除去结尾的‘_’
		//2.2 删除areaFunctions中对应的记录
		var mas = areaFunctions[ruleId].mainArea;
		//2.2.1如果mainArea只有此一个记录，则删除产品规格值对象
		if(mas.length == 1 && mas[0] == mainAreaId) {
			delete areaFunctions[ruleId];
			var m = 0;
			for(var i in areaFunctions) {
				m++;
			}
			if(m == 0) {
				//确认按钮不能点击
				setBtnDisabled();
			} 
		}else {
		//2.2.2只删除mainAreaId一条记录
			for(var i=0,len=mas.length;i<len;i++) {
				if(mas[i] == mainAreaId) {
					mas.splice(i, 1);
				}
			}
		}
	}
	
	$('#' + areaId + 'AreaTitle').remove();
	$('#' + areaId + 'AreaLoading').remove();
	$('#' + areaId + 'Area').remove();
}
//wanghfa 得到区域div的title
function getArea(areaId, titleName, marginTop,marginLeft) {	//区域id，区域标题，区域前空位大小px
	var packet = new AJAXPacket("module/ajaxInit_area.jsp", "正在初始化，请稍等......");
	packet.data.add("areaId", areaId);
	packet.data.add("titleName", titleName);
	packet.data.add("marginTop", marginTop);
	packet.data.add("marginLeft", marginLeft);
	core.ajax.sendPacketHtml(packet, function(data) {
		$("#startDiv").append(data);
	});
	packet = null;
}

function getOnlyTitleArea(areaId, titleName, marginTop,marginLeft,parentId,delFlag) {	//区域id，区域标题，区域前空位大小px
	var packet = new AJAXPacket("module/ajaxInit_area.jsp", "正在初始化，请稍等......");
	packet.data.add("areaId", areaId);
	packet.data.add("titleName", titleName);
	packet.data.add("marginTop", marginTop);
	packet.data.add("marginLeft", marginLeft);
	packet.data.add("showDelBtn", delFlag);
	core.ajax.sendPacketHtml(packet, function(data) {
		$("#" + parentId).append(data);
		$("#" + areaId + "AreaTitle").show();
		$("#" + areaId + "Area").show();
	});
	
	packet = null;
}
function initInnerArea(areaId,parentId,fromType) {
	$("#" + parentId + " #" + areaId + "AreaTitle").show();
	$("#" + parentId + " #" + areaId + "AreaLoading").show();
	$("#" + parentId + " #" + areaId + "Area").hide();
	//ajaxInit_" + areaId + "Area.jsp 文件新创建
	var packet = new AJAXPacket("module/ajaxInit_" + areaId + "Area.jsp", "正在初始化，请稍等......");
	//liujian 添加参数	
	packet.data.add("areaId", areaId);
	packet.data.add("parentId", parentId);
	//liujian 2012-8-17 16:14:01 增加在途的产品订单号
	packet.data.add("fromType", fromType);
	core.ajax.sendPacketHtml(packet, function(data) {
		$("#" + parentId + " #" + areaId + "AreaLoading").hide();
		$("#" + parentId + " #" + areaId + "Area").empty();
		$("#" + parentId + " #" + areaId + "Area").append(data);
		$("#" + parentId + " #" + areaId + "Area").hide();
		$("#" + parentId + " #" + areaId + "Area").slideDown(300);
	});
	packet = null;
}
function getInnerArea(areaId, titleName, marginTop,marginLeft,parentId) {	//区域id，区域标题，区域前空位大小px
	var packet = new AJAXPacket("module/ajaxInit_area.jsp", "正在初始化，请稍等......");
	packet.data.add("areaId", areaId);
	packet.data.add("titleName", titleName);
	packet.data.add("marginTop", marginTop);
	packet.data.add("marginLeft", marginLeft);
	packet.data.add("parentId", parentId);
	core.ajax.sendPacketHtml(packet, function(data) {
		$("#" + parentId).append(data);
	});
	packet = null;
}
//调用服务的公共方法
//fileFlag 一级页面为1，二级页面为2
function getServiceMsg(serviceName, backMethod,fileFlag) {
	var srvFile = "module/ajaxGetServiceMsg.jsp";
	if(fileFlag == 2 || fileFlag == '2') {
		srvFile = "ajaxGetServiceMsg.jsp";	
	}
	var packet = new AJAXPacket(srvFile, "正在初始化，请稍等......");	
	packet.data.add("serviceName", serviceName);
	var strInfo = new Array();
	for (var a = 0; a < arguments.length - 3; a ++) {
	//	packet.data.add("param" + a, arguments[a + 3]);
		strInfo.push(arguments[a + 3] + " ~^~");
	}
	if(strInfo.length > 0) {
		packet.data.add("strInfo", strInfo.join(''));	
	}else {
		packet.data.add("strInfo", "");		
	}
	core.ajax.sendPacketHtml(packet, eval(backMethod));
	packet = null;
}

//对footer的三个按钮进行控制，重置是刷新页面
function controlBtn(flag) {
	$("#submitBtn").attr("disabled", flag);
	$("#backBtn").attr("disabled", flag);
	$("#closeBtn").attr("disabled", flag);
}

//wanghf 设置某一个元素不可用，不可修改，TODO待补充tagName类型
//TODO 是否可以加遮罩呢
function unAvailable(eleId) {
	var eleTagName = ($("#" + eleId).get(0).tagName);
	if (eleTagName == "SELECT") {
		$("#" + eleId).attr("disabled", true);
	}
}





//测试用
function InterBOSS() {
	this.svcCont = new SvcCont();
}
function SvcCont() {
	this.orderInfoReq = new OrderInfoReq();
}
function OrderInfoReq() {
	this.orderSourceID = new OneElement();
	this.customerNumber = new OneElement();
	this.orderInfo = new OrderInfo();
}
function OrderInfo() {
	this.pOOrderNumber = new OneElement();
	this.pOSpecNumber = new OneElement();
	this.productOfferingID = new OneElement();
	this.sICode = new OneElement();
	this.hostCompany = new OneElement();
	this.pOOrderBusinesses = new POOrderBusinesses();
	this.businessMode = new OneElement();
	this.pOOrderCharge = new POOrderCharge();
}
function POOrderBusinesses() {
	this.operationSubTypeID = new OneElement();
}
function POOrderCharge() {
	this.pOOrderChargeCode = new OneElement();
	this.pOOrderChargeValue = new OneElement();
}

function OneElement() {
	this.eleValue = "";
	this.vMust = "";
	this.vType = "";
	this.vFormat = "";
	this.vMinvalue = "";
	this.vMaxvalue = "";
	this.vUpType = "";
}
function ItElement(val) {
	this.eleValue = val;
}

//解析json串，不完全体
function getHtmlSegment(obj,id) {
	var htmlSegment = new Array();
	var mi = 0;
	for(var i=0,len=obj.length;i<len;i++) {
		var el = obj[i];
		//1. 判断表单类型
		var attr = '';
		var type = el.FormType;
		if(mi == 0) {
			htmlSegment.push('<tr>');
		}else if(mi % 2 == 0) {
			htmlSegment.push('</tr><tr>');
		}
		mi++;
		if(isBlack(type) || type.toLocaleLowerCase() == 'text') {
			var mustFlag = false;
			htmlSegment.push('<td class="blue" style="width:20%">' + el.ElementName + '</td>'); 
			htmlSegment.push('<td style="width:30%">');
			htmlSegment.push('<input type="input"'); 
			//判断一系列的属性
			attr = el.EFormat;
			if(!isBlack(attr)) {
				htmlSegment.push(' v_format="' + $.trim(attr) + '"');
			}
			attr = el.EMaxVal;
			if(!isBlack(attr)) {
				htmlSegment.push(' v_maxvalue="' + $.trim(attr) +'"');
			}
			attr = el.EMinVal;
			if(!isBlack(attr)) {
				htmlSegment.push(' v_minvalue="' + $.trim(attr) +'"');
			}
			attr = el.EMust;
			if(!isBlack(attr) && attr == '1') {
				mustFlag = true;
				htmlSegment.push(' v_must="' + $.trim(attr) + '" onblur = "checkElement(this)" ');
			}
			attr = el.EType;
			if(!isBlack(attr)) {
				htmlSegment.push(' v_type="' + $.trim(attr) +'"');
			}
			attr = el.EUpdate;
			if(!isBlack(attr) && attr == '0') {
				htmlSegment.push(' readonly class="InputGrey" ');
			}
			attr = el.EValue;
			if(!isBlack(attr)) {
				htmlSegment.push(' value="' + $.trim(attr) +'"');
			}else {
				htmlSegment.push(' value="" ');
			}
			attr = el.ElementCode;
			if(!isBlack(attr)) {
				htmlSegment.push(' name="' + $.trim(attr) + '"/>');
			}
			
			//处理一些输入框后面带按钮的特殊情况 begin
			if(in_ChanceId != null && in_ChanceId != "null" && in_ChanceId != '') {
			}else if(!hideEcCodeBtn && el.ElementName == 'EC集团客户编码') {
				htmlSegment.push('&nbsp;&nbsp;<input type="button" class="b_text" name="getCustomerBtn" id="getCustomerBtn" value="查询" onclick="getCustomer();">');
			}else if(!hideEcCodeBtn && el.ElementName == '商品订购关系编码'){
			}
			if(el.ElementName == '商品订购关系编码') {
				htmlSegment.push('&nbsp;&nbsp;<input type="button" class="b_text" name="getInsBtn" id="getCustomerBtn" value="查询" onclick="getInstance();">');
			}
			//处理一些输入框后面带按钮的特殊情况 end
			if(mustFlag) {
				htmlSegment.push('<font class="orange">*</font>');
			}
			attr = el.ElementAlter;
			if(!isBlack(attr)) {
				htmlSegment.push('<font style="font-size:12px">' + $.trim(attr) + '</font>');
			}
			htmlSegment.push('</td>');
		}
		else if(type.toLocaleLowerCase() == 'select') {
			//select
			htmlSegment.push('<td class="blue" style="width:20%">' + el.ElementName + '</td>'); 
			htmlSegment.push('<td>');
			var nameStr = el.SelShow;
			var valueStr = el.SelValue;
			if(!isBlack(nameStr) && !isBlack(valueStr)) {
				var names = split(nameStr,'~');
				var values = split(valueStr,'~');
				var arrLen = names.length > values.length ? values.length : names.length;
				//设定select是否可以选择
				var updateStr = '';
				attr = el.EUpdate;
				if(!isBlack(attr) && attr == '0') {
					updateStr =' disabled= "disabled" ';
				}
				htmlSegment.push('<select  onmouseover="FixWidth(this);" v_must="1" name="' + el.ElementCode +'" id=""' + updateStr + ' group="'+el.ElementGroup+'" >');
				if(arrLen == 0) {
					htmlSegment.push('<option value="">请选择</option>');
				}else {
					attr = el.EValue;
					for(var j=0;j<arrLen;j++) {
						if(attr == values[j]) {
							//设定选择项
							htmlSegment.push('<option value="' + values[j] + '" selected= "selected">' + names[j] + '</option>');
						}else {
							htmlSegment.push('<option value="' + values[j] + '">' + names[j] + '</option>');
						}
					}
					
				}
				htmlSegment.push('</select>');
				
			}
			if(el.ElementName == '产品规格编号' || el.ElementName == '产品订购关系编码') {
				htmlSegment.push('&nbsp;&nbsp;<input type="button" class="b_text" name="addRuleBtn" id="addRuleBtn" value="添加" onclick="addRule();">');
			}
			if(el.EMust == '1') {
				htmlSegment.push('<font class="orange">*</font>');
			}
			attr = el.ElementAlter;
			if(!isBlack(attr)) {
				htmlSegment.push('<font>' + attr + '</font>');
			}
			htmlSegment.push('</td>');
		}else if(type.toLocaleLowerCase() == 'hidden') {
			mi--;
			htmlSegment.push('<input type="hidden" name="' + el.ElementCode + '" value="' + el.EValue+ '">');	
		}
		
		
	}
	if(mi % 2 == 0) {
		htmlSegment.push('</tr>');
	}else {
		htmlSegment.push('<td></td><td></td></tr>');
	}
	$('#' + id).append(htmlSegment.join(''));
}

//TODO 设置列表的类型
/*
	var $opt = {
		json : json[0], //json对象
		tableId : '_table', //待添加的bodyid
		showAddBtn : false,//是否显示“添加”操作按钮
		showDelBtn : false,//是否显示“删除”操作按钮
		showTitleOnly : true//是否只显示thead
	}
*/
//设置列表的类型
	var areaTrHtml = {};
	// name : area ，名称
	// value : 待添加的html字段
	function setListHtml($opt) {
		var _json = $opt.json;
		var body_id = $opt.tableId;
		var containerPath = _json.ContainerPath;
		var addBtnFlag = isBlack($opt.showAddBtn) ? false : $opt.showAddBtn;
		var delBtnFlag = isBlack($opt.showDelBtn) ? false : $opt.showDelBtn;
		var titleOnlyFlag = isBlack($opt.showTitleOnly) ? false : $opt.showTitleOnly;
		var addHiddenFlag = isBlack($opt.addHiddenInput) ? false : $opt.addHiddenInput;
		var tbody_id = 'tbody_' + containerPath; //设定tbodyid
		//循环一遍数组，获取thead的个数
		//顺序就是json传传递的第一个group的先后顺序
		var $head = {};
		var tdLen = 0;//总列数
		var $body = new Array();
		var headSmt = new Array();
		var bodySmt = new Array();
		var marker = "Group_";//组的标识位
		var group = {};
		//group对象： Group_  开头
		// { 
		//	Group_ElementGroup : [],
		//	Group_ElementGroup : [],
		// }
		//获取所有group对象
		for(var i=0,len=_json.Elements.length;i<len;i++) {
			var el = _json.Elements[i];
			var groupNo = el.ElementGroup;
			if(isBlack(group[marker + groupNo]) || group[marker + groupNo].length == 0) {
				group[marker + groupNo] = new Array();
			}
			group[marker + groupNo].push(el);
		}
		
		//设置状态，第一次读取group则设置thead
		var time = 0;
		var $tr = new Array();
		for(var g in group) {
			for(var i=0,len=group[g].length;i<len;i++) {
				var el = group[g][i];
				if(time == 0) {
					$head[el.ElementCode] = el.ElementName;
					tdLen++;
				}
				/*
				//处理列对象
				var $td = {}; 
				//$td {
				//			el.ElementCode : el.EValue
				//			type           : el.FormType
				//			names          : el.SelShow 
				//          values         : el.SelValue
				//		}
				//行对象，添加列对象
				*/
				$tr.push(el);
			}
			time++;
			//tbody对象，添加行对象
			$body.push($tr);
		}
		
		//网页面添加html片段
		//1. thead segment
		headSmt.push('<thead><tr align="center">');
		for(var h in $head) {
			headSmt.push('<th>');
			headSmt.push($head[h]);
			headSmt.push('</th>');
		}
		//添加操作列
		if(delBtnFlag) {
			tdLen++;
			headSmt.push('<th>');
			headSmt.push('操作');
			headSmt.push('</th>');
		}
		headSmt.push('</tr></thead>');
		//2. tbody segment
		bodySmt.push('<tbody id="' + tbody_id + '">');
		if(!titleOnlyFlag) {
			var trTime = 0;
			var bodyAddHtml = new Array();
			bodyAddHtml.push('<tr>')
			for(var i=0,len=$body.length;i<len;i++) {
				var _tr = $body[i];
				bodySmt.push('<tr>');
				var m = 0;
				for(var h in $head) {
					m++;
					for(var k=0,len2=_tr.length;k<len2;k++) {
						var _td = _tr[k];
						if(typeof(_td.ElementName) == "undefined" || _td.ElementName == null  || (_td.ElementName != $head[h] )) {
							continue;
						}
						//addHiddenFlag 针对一次性资费
						var _$td = setTdHtml(_td,addHiddenFlag,m);
						bodySmt.push(_$td.tbody);
						bodyAddHtml.push(_$td.tbodyAdd);
						//删除对象，节省下次查询的时间
						_tr.splice(k, 1);
						break;
					}
				}
				if(delBtnFlag) {
					bodySmt.push('<td>');
					bodySmt.push('<input type="button" value="删除" name="delRecordBtn" class="b_text" onclick="delRecord(this)" />'); 
					bodySmt.push('</td>');
					bodyAddHtml.push('<td>');
					bodyAddHtml.push('<input type="button" value="删除" name="delRecordBtn" class="b_text" onclick="delRecord(this)" />'); 
					bodyAddHtml.push('</td>');
				}
				//记录tr待添加的html片段
				bodyAddHtml.push('</tr>');
				if(trTime == 0) {
					areaTrHtml[containerPath] =  bodyAddHtml.join('');
				}
				trTime++;
				bodySmt.push('</tr>');
			}
		}
		bodySmt.push('</tbody>');
		//添加“添加”按钮
		if(addBtnFlag) {
			bodySmt.push('<tbody><tr><td>');
			bodySmt.push('<input type="button" value="添加" name="addRecordBtn" class="b_text" onclick="addRecord(\'' + containerPath + '\',\'' + body_id + '\')" />');
			bodySmt.push('</td></tr></tbody>');
		}
		$('#' + body_id).append(headSmt.join(''));
		$('#' + body_id).append(bodySmt.join(''));
	}
//设置表单类型
	function setTdHtml($td,addHiddenFlag,m) {
		var $tdHtml = {};
		var $tdHead = new Array();
		var $tdBody = new Array();
		var el = $td;
		//1. 判断表单类型
		var attr = '';
		var type = el.FormType;
		//设置tbody的td
		if(isBlack(type) || type.toLocaleLowerCase() == 'text') {
			var mustFlag = false;
			$tdBody.push('<td><input type="input" ');
			//判断一系列的属性
			//ElementGroup、ElementCode 没加进去
			attr = el.EValue;
			if(!isBlack(attr)) {
				$tdBody.push(' value="' + attr + '"');
			}else {
				$tdBody.push(' value=""');
			}
			attr = el.EMaxVal;
			if(!isBlack(attr)) {
				$tdBody.push(' v_maxvalue=' + attr );
			}
			attr = el.EMinVal;
			if(!isBlack(attr)) {
				$tdBody.push(' v_minvalue=' + attr );
			}
			attr = el.EUpdate;//0是不可，1是可以修改
			if(!isBlack(attr) && attr == '0' ) {
				$tdBody.push(' readonly class="InputGrey"  ');
			}
			attr = el.EMust;
			if(!isBlack(attr) && attr == '1') {
				mustFlag = true;
				$tdBody.push(' v_must="1" onblur = "checkElement(this)" ');
			}
			attr = el.EFormat;
			if(!isBlack(attr)) {
				$tdBody.push(' v_format=' + attr );
			}
			attr = el.EType;
			if(!isBlack(attr)) {
				$tdBody.push(' v_type=' + attr );
			}
			$tdBody.push(' />');
			//处理一些输入框后面带按钮的特殊情况 end
			if(mustFlag) {
				$tdBody.push('<font class="orange">*</font>');
			}
			attr = el.ElementAlter;
			if(!isBlack(attr)) {
				$tdBody.push('<font>' + attr + '</font>');
			}
			if(addHiddenFlag && m ==1) {
				$tdBody.push('<input type="hidden" value="' + el.ElementCode + '" />');	
			}
			$tdBody.push(' </td>');
		}else if(type.toLocaleLowerCase() == 'hidden') {
			$tdBody.push('<td style="display:none"><input type="hidden" value="' + el.EValue + '" /></td>');
		}
		else if(type.toLocaleLowerCase() == 'select') {
			//select
			$tdBody.push('<td>');
			var nameStr = el.SelShow;
			var valueStr = el.SelValue;
			if(!isBlack(nameStr) && !isBlack(valueStr)) {
				var names = split(nameStr,'~');
				var values = split(valueStr,'~');
				var arrLen = names.length > values.length ? values.length : names.length;
				//设定select是否可以选择
				var updateStr = '';
				if(!isBlack(el.EUpdate) && el.EUpdate == '0') {
					updateStr =' disabled= "disabled" ';
				}				
				$tdBody.push('<select onmouseover="FixWidth(this);" name="' + el.ElementCode + '"' + updateStr + ' v_must="1" >');
				if(arrLen == 0) {
					$tdBody.push('<option value="">请选择</option>');
				}else {
					for(var j=0;j<arrLen;j++) {
						if(el.EValue == values[j]) {
							//设定选择项
							$tdBody.push('<option value="' + values[j] + '" selected= "selected">' + names[j] + '</option>');
						}else {
							$tdBody.push('<option value="' + values[j] + '">' + names[j] + '</option>');
						}
					}
				}
				$tdBody.push('</select>');
			}
			attr = el.EMust;
			if(!isBlack(attr) && attr == '1') {
				$tdBody.push('<font class="orange">*</font>');
			}
			attr = el.ElementAlter;
			if(!isBlack(attr)) {
				$tdBody.push('<font style="font-size:12px">' + attr + '</font>');
			}
			$tdBody.push('</td>');
		}
		else if(type.toLocaleLowerCase() == 'file') {
			$tdBody.push('<td>');	
			//EValue有值就可以下载
			if(el.EValue){
				$tdBody.push('<a href="#" onclick="downloadFile(this,\'' + el.EValue + '\');"><p>' + el.EValue + '</p></a>');
			}
			//EUpdate==0不能上传文件
			if(el.EUpdate == '0') {
				
			}else {
				//上传，目前只有附件
				$tdBody.push('<input type="file" class="button" name="poAttFile"/>');
			}
			attr = el.EMust;
			if(!isBlack(attr) && attr == '1') {
				$tdBody.push('<font class="orange">*</font>');
			}
			attr = el.ElementAlter;
			if(!isBlack(attr)) {
				$tdBody.push('<font style="font-size:12px">' + attr + '</font>');
			}
			$tdBody.push('</td>');	
			
		}
		//获取thead的td
		if(!isBlack(el.CharacterName)) {
			$tdHead.push('<td>' + el.CharacterName + '</td>');
		}else {
			$tdHead.push('<td></td>');
		}
		$tdHtml.thead = $tdHead.join('');
		var _tbody = $tdBody.join('');
		$tdHtml.tbody = _tbody;
		$tdHtml.tbodyAdd = _tbody.replace('value="' + el.EValue + '"','value=""');
		return $tdHtml;
	}
	//针对ManageNode和ManageNodeGet
	function setNodeListHtml($opt) {
		var _json = $opt.json;
		var body_id = $opt.tableId;
		var containerPath = _json.ContainerPath;
		var addBtnFlag = isBlack($opt.showAddBtn) ? false : $opt.showAddBtn;
		var delBtnFlag = isBlack($opt.showDelBtn) ? false : $opt.showDelBtn;
		var titleOnlyFlag = isBlack($opt.showTitleOnly) ? false : $opt.showTitleOnly;
		var addHiddenFlag = isBlack($opt.addHiddenInput) ? false : $opt.addHiddenInput;
		var tbody_id = 'tbody_' + containerPath; //设定tbodyid
		//循环一遍数组，获取thead的个数
		//顺序就是json传传递的第一个group的先后顺序
		var $head = {};
		var tdLen = 0;//总列数
		var $body = new Array();
		var headSmt = new Array();
		var bodySmt = new Array();
		var marker = "Group_";//组的标识位
		var group = {};
		//group对象： Group_  开头
		// { 
		//	Group_ElementGroup : [],
		//	Group_ElementGroup : [],
		// }
		//获取所有group对象
		for(var i=0,len=_json.Elements.length;i<len;i++) {
			var el = _json.Elements[i];
			var groupNo = el.ElementGroup;
			if(isBlack(group[marker + groupNo]) || group[marker + groupNo].length == 0) {
				group[marker + groupNo] = new Array();
			}
			group[marker + groupNo].push(el);
		}
		//设置状态，第一次读取group则设置thead
		var time = 0;
		var $tr = new Array();
		for(var g in group) {
			for(var i=0,len=group[g].length;i<len;i++) {
				var el = group[g][i];
				if(time == 0) {
					$head[el.ElementCode] = {};
					$head[el.ElementCode].name = el.ElementName;
					$head[el.ElementCode].hiddenFlag = el.FormType == 'hidden' ? true:false;
					tdLen++;
				}
				
				//处理列对象
				//var $td = {}; 
				//$td {
				//			el.ElementCode : el.EValue
				//			type           : el.FormType
				//			names          : el.SelShow 
				//          values         : el.SelValue
				//		}
				//行对象，添加列对象
			
				$tr.push(el);
			}
			time++;
			//tbody对象，添加行对象
			$body.push($tr);
		}
		
		//网页面添加html片段
		//1. thead segment
		headSmt.push('<thead><tr align="center">');
		for(var h in $head) {
			var _headObj = $head[h];
			if(_headObj.hiddenFlag) {
				headSmt.push('<th style="display:none">');
				headSmt.push($head[h].name);
			}else {
				headSmt.push('<th>');
				headSmt.push($head[h].name);
			}
			headSmt.push('<input type="hidden" value="' + h + '"></th>');
		}
		//添加操作列
		if(delBtnFlag) {
			tdLen++;
			headSmt.push('<th>');
			headSmt.push('操作');
			headSmt.push('</th>');
		}
		headSmt.push('</tr></thead>');
		//2. tbody segment
		bodySmt.push('<tbody id="' + tbody_id + '">');
		if(!titleOnlyFlag) {
			var trTime = 0;
			var bodyAddHtml = new Array();
			bodyAddHtml.push('<tr>')
			for(var i=0,len=$body.length;i<len;i++) {
				var _tr = $body[i];
				bodySmt.push('<tr>');
				var m = 0;
				for(var h in $head) {
					m++;
					for(var k=0,len2=_tr.length;k<len2;k++) {
						var _td = _tr[k];
						if(typeof(_td.ElementName) == "undefined" || _td.ElementName == null  || (_td.ElementName != $head[h].name )) {
							continue;
						}
						//addHiddenFlag 针对一次性资费
						//hiddenFlag 针对管理属性
						var _$td = setTdHtml(_td,addHiddenFlag,m);
						bodySmt.push(_$td.tbody);
						bodyAddHtml.push(_$td.tbodyAdd);
						//删除对象，节省下次查询的时间
						_tr.splice(k, 1);
						break;
					}
				}
				if(delBtnFlag) {
					bodySmt.push('<td>');
					bodySmt.push('<input type="button" value="删除" name="delRecordBtn" class="b_text" onclick="delRecord(this)" />'); 
					bodySmt.push('</td>');
					bodyAddHtml.push('<td>');
					bodyAddHtml.push('<input type="button" value="删除" name="delRecordBtn" class="b_text" onclick="delRecord(this)" />'); 
					bodyAddHtml.push('</td>');
				}
				//记录tr待添加的html片段
				bodyAddHtml.push('</tr>');
				if(trTime == 0) {
					areaTrHtml[containerPath] =  bodyAddHtml.join('');
				}
				trTime++;
				bodySmt.push('</tr>');
			}
		}
		bodySmt.push('</tbody>');
		//添加“添加”按钮
		if(addBtnFlag) {
			bodySmt.push('<tbody><tr><td>');
			bodySmt.push('<input type="button" value="添加" name="addRecordBtn" class="b_text" onclick="addRecord(\'' + containerPath + '\',\'' + body_id + '\')" />');
			bodySmt.push('</td></tr></tbody>');
		}
		$('#' + body_id).append(headSmt.join(''));
		$('#' + body_id).append(bodySmt.join(''));
	}
	//添加记录行
	function addRecord(containerPath,bodyId) {
		$('#tbody_' + containerPath).append(areaTrHtml[containerPath]);
	}
	//删除当前记录行
	function delRecord(k) {
		$(k).parents("tr").remove();
	}
	
	function setTdHtml2($td,parentId,vsum) {
		var $tdHtml = {};
		var $tdHead = new Array();
		var $tdBody = new Array();
		var el = $td;
		//1. 判断表单类型
		var attr = '';
		var type = el.CharacterType;
		//设置tbody的td
		//fieldCode不涉及
		//"MultipleAble": "",对应type的checkbox
		//"ShowFlag": "",0不显示，""或者1显示，默认显示
				
		if(isBlack(type) || type.toLocaleLowerCase() == 'text') {
			var mustFlag = false;
			$tdBody.push('<td>');	
			$tdBody.push('<input type="input" ');
			//判断一系列的属性
			attr = el.DefaultValue;
			if(!isBlack(attr)) {
				$tdBody.push(' value="' + attr + '"');
			}else {
				$tdBody.push(' value=""');
			}
			attr = el.MaxLength;
			if(!isBlack(attr)) {
				$tdBody.push(' v_maxlength="' + attr + '"');
			}
			attr = el.MinLength;
			if(!isBlack(attr)) {
				$tdBody.push(' v_minlength="' + attr + '"');
			}
			attr = el.MaxVal;
			if(!isBlack(attr)) {
				$tdBody.push(' v_maxvalue="' + attr + '"');
			}
			attr = el.MinVal;
			if(!isBlack(attr)) {
				$tdBody.push(' v_minvalue="' + attr + '"');
			}
			attr = el.ReadOnly;
			if(!isBlack(attr) && attr == '1' ) {
				$tdBody.push(' readonly class="InputGrey" ');
			}
			attr = el.RequireFlag
			if(!isBlack(attr) && attr == '1') {
				mustFlag = true;
				$tdBody.push(' v_must="' + attr + '" onblur = "checkElement(this)" ');
			}
			attr = el.VFormat;
			if(!isBlack(attr)) {
				$tdBody.push(' v_format="' + attr +'"');
			}
			attr = el.VType;
			if(!isBlack(attr)) {
				$tdBody.push(' v_type="' + attr + '"');
			}
			$tdBody.push('id="'+el.CharacterNumber+'"');
			/***  begin  公众服务云业务优化@2014/8/11 ***/
			if(el.CharacterNumber=="1116013001"){
				$tdBody.push(' v_id="resRebateType_'+vsum+'" ');
			}
			if(el.CharacterNumber=="1116013002"){ //测试计划开始日期
				$tdBody.push(' v_id="resBeginTime_'+vsum+'" ');
				$tdBody.push(' v_type="date" ');
				$tdBody.push(' onblur = "checkElement(this)" ');
			}
			if(el.CharacterNumber=="1116013003"){
				$tdBody.push(' v_id="resEndTime_'+vsum+'" ');
				$tdBody.push(' v_type="date" ');
				$tdBody.push(' onblur = "chekResEndTime(this,'+vsum+',1)" ');
			}
			if(el.CharacterNumber=="1116013005"){
				$tdBody.push(' v_id="resFeeRebate_'+vsum+'" ');
				$tdBody.push(' v_type="int" ');
				$tdBody.push(' onblur = "checkFeeRebate(this,'+vsum+',1)" ');
			}
			
			if(el.CharacterNumber=="1101630004"){
				$tdBody.push('maxlength="6"');
			}
			if(el.CharacterNumber=="1101644002"){
				$tdBody.push('maxlength="6"');
			}
			if(el.CharacterNumber=="1101631019"){
				$tdBody.push('disabled="disabled"');
			}
			if(el.CharacterNumber=="1101632011"){
				$tdBody.push('disabled="disabled"');
			}
			if(el.CharacterNumber=="1101634004"){
				$tdBody.push('disabled="disabled"');
			}
			
			if(el.CharacterNumber=="1101644007"){
				$tdBody.push('disabled="disabled"');
			}
			if(el.CharacterNumber=="1101644010"){
				$tdBody.push('disabled="disabled"');
			}
			/***  end  公众服务云业务优化@2014/8/11 ***/
			 $tdBody.push("/>");
			//处理一些输入框后面带按钮的特殊情况 end
			
			if(mustFlag) {
				$tdBody.push('<font class="orange">*</font>');
			}
			
			/***  begin  公众服务云业务优化@2014/8/11 ***/
			if(!mustFlag && ( el.CharacterNumber=="1116013002" || el.CharacterNumber=="1116013003") ){
				$tdBody.push('<font v_id="orangeFlag_'+vsum+'" class="orange"></font> ');
			}
			if(el.CharacterNumber=="1116013005"){
				$tdBody.push(' <font v_id="feeText_'+vsum+'" class="orange"></font>');
			}
			if(el.CharacterNumber=="1116011009"){
			  $tdBody.push('&nbsp;&nbsp;<input type="button" class="b_text" name="getCustBtn" id="getCustBtn" value="查询" onclick="getProdProperty(this);"> &nbsp;&nbsp;');
			}
			/***  end  公众服务云业务优化@2014/8/11 ***/
			
			attr = el.AlterInfo;
			if(!isBlack(attr)) {
				$tdBody.push('<font style="font-size:12px">' + attr + '</font>');
			}
			$tdBody.push(' </td>');
			
		}
		else if(type.toLocaleLowerCase() == 'select') {
			//select
			$tdBody.push('<td>');	
			var nameStr = el.SelShow;
			var valueStr = el.SelValue;
			if(!isBlack(nameStr) && !isBlack(valueStr)) {
				var names = split(nameStr,'~');
				var values = split(valueStr,'~');
				var arrLen = names.length > values.length ? values.length : names.length;
				//设定select是否可以选择
				var updateStr = '';
				if(!isBlack(el.ReadOnly) && el.ReadOnly == '1') {
					updateStr =' disabled= "disabled" ';
				}
				if(el.CharacterNumber=="1101634025"){
					$tdBody.push('<select onmouseover="FixWidth(this);" name="" id="1101634025" onchange="checkktcx_1101634025(this);"' + updateStr + '>');
				}
				else if(el.CharacterNumber=="1101644006"){
					$tdBody.push('<select onmouseover="FixWidth(this);" name="" id="1101644006" onchange="checkktcx_1101644006(this);"' + updateStr + '>');
				}
				else if(el.CharacterNumber=="1101634005"){
					$tdBody.push('<select onmouseover="FixWidth(this);" name="" id="1101634005" disabled= "disabled">');
				}
				else if(el.CharacterNumber=="1101644008"){
					$tdBody.push('<select onmouseover="FixWidth(this);" name="" id="1101644008" disabled= "disabled">');
				}
				else if(el.CharacterNumber=="1116013001"){
					$tdBody.push('<select onmouseover="FixWidth(this);" v_id="resType_'+vsum+'" onchange="chekResourceInfo(this,'+vsum+');" name="" id="" ' + updateStr + '>');
				}else{
					$tdBody.push('<select onmouseover="FixWidth(this);" name="" id="" ' + updateStr + '>');
				}
				if(arrLen == 0) {
					$tdBody.push('<option value="-1">请选择</option>');
				}else {
					for(var j=0;j<arrLen;j++) {
						if(el.DefaultValue == values[j]) {
							//设定选择项
							$tdBody.push('<option value="' + values[j] + '" selected= "selected">' + names[j] + '</option>');
						}else {
							$tdBody.push('<option value="' + values[j] + '">' + names[j] + '</option>');
						}
					}
				}
				$tdBody.push('</select>');
				
			}
			attr = el.RequireFlag;
			if(!isBlack(attr) && attr == '1') {
				$tdBody.push('<font class="orange">*</font>');
			}
			attr = el.AlterInfo;
			if(!isBlack(attr)) {
				$tdBody.push('<font style="font-size:12px">' + attr + '</font>');
			}
			$tdBody.push('</td>');
		}else if(type.toLocaleLowerCase() == 'file') {
			$tdBody.push('<td>');	
			//ReadOnly==1不能上传文件
			if(el.ReadOnly == '1') {
				//DefaultValue可以下载
				if(el.DefaultValue){
					$tdBody.push('<a href="#" onclick="downloadFile(this,\'' + el.CharacterNumber + '\');"><p>' + el.DefaultValue + '</p></a>');
				}
			}else {
				//DefaultValue可以下载
				if(el.DefaultValue){
					$tdBody.push('<a href="#" onclick="downloadFile(this,\'' + el.CharacterNumber + '\');"><p>' + el.DefaultValue + '</p></a>');
				}
				
				var charNum= el.CharacterNumber;
				var _temp = '';
				if(charNum == '999033717') {
					//主办省上传成员明细文件.xls
					_temp = '<a href="detail.xls">下载模板</a>';
				}else if(charNum == '999033734') {
					//号码确认反馈明细附件
					_temp = '<a href="submit.xls">下载模板</a>';
				}else if(charNum == '999033735') {
					//号码开通反馈明细附件
					_temp = '<a href="open.xls">下载模板</a>';
				}
				//liujian 2012-9-7 14:37:21 添加两种模板 物联网跨省行业应用卡业务 begin 
				else if(charNum == '9116014560') {
					_temp = '<a href="card_detail.xls">下载模板</a>';
				}else if(charNum == '9116014556') {
					_temp = '<a href="card_open.xls">下载模板</a>';
				/*2013/12/19 9:01:48 gaopeng  关于下发优化呼叫中心业务支撑实施方案的通知 加入模板下载功能*/
				}else if(charNum == '1113035011') {
					_temp = '<a href="callcenter.xls">下载模板</a>';
				}
				//liujian 2012-9-7 14:37:21 添加两种模板 end
				$tdBody.push('<input type="file" name="' + el.CharacterNumber+ '" />');
				$tdBody.push(_temp);
			}
			attr = el.RequireFlag;
			if(!isBlack(attr) && attr == '1') {
				$tdBody.push('<font class="orange">*</font>');
			}
			attr = el.AlterInfo;
			if(!isBlack(attr)) {
				$tdBody.push('<font style="font-size:12px">' + attr + '</font>');
			}
			$tdBody.push('</td>');	
		}else if(type.toLocaleLowerCase().indexOf('checkbox')!=-1) {
			//liujian 2012-8-20 14:47:21 type=checkbox[]，总括号内为分隔符，如果type=checkbox或者checkbox[]则分隔符为","
			//1.展示 2.必选
			var _id=parentId + '_' + el.CharacterNumber;
			var _pId = 'p'+_id;
			if(el.ReadOnly == '1') {
				$tdBody.push('<td>');
				$tdBody.push('	<input id="' + _id + '" class="InputGrey"  type="text" readonly="readonly" value="' + el.DefaultValue + '" />');
				$tdBody.push('</td>');
			}else {
				$tdBody.push('<td id="' + _pId + '" style="float:left;position: relative;">');	
				$tdBody.push('<input id="' + _id + '" class="ListText"  type="text" readonly="readonly" value="请选择" />');
				attr = el.RequireFlag;
				if(!isBlack(attr) && attr == '1') {
					$tdBody.push('<font class="orange">*</font>');
				}
				attr = el.AlterInfo;
				if(!isBlack(attr)) {
					$tdBody.push('<font style="font-size:12px">' + attr + '</font>');
				}
				$tdBody.push('</td>');
				var _arr = new Array();
				if(el.SelValue) {
					var _vs = split(el.SelValue,'~');
					var _ss = split(el.SelShow,'~');
					for(var i=0,len=_vs.length;i<len;i++) {
						_arr.push(new SingleSelectObj(_vs[i],_ss[i]));
					}
				}	
				var sign = ',';
				var checkboxType = type.toLocaleLowerCase();
				if(checkboxType == 'checkbox[]' || checkboxType =='checkbox') {
					
				}else {
					if(checkboxType.length-1 > 9) {
						sign = checkboxType.substring(9,checkboxType.length-1);
					}
				}
				registerCheckboxEvent(_id,_pId,_arr,el.DefaultValue,sign);
			}
			
		}
		//获取thead的td
		if(!isBlack(el.CharacterName)) {
			$tdHead.push('<th>' + el.CharacterName + '<input type="hidden" value="' + el.CharacterNumber+ '" /></th>');
		}else {
			$tdHead.push('<th></th>');
		}
		$tdHtml.thead = $tdHead.join('');
		var _tbody = $tdBody.join('');
		$tdHtml.tbody = _tbody;
		$tdHtml.tbodyAdd = _tbody.replace('value="' + el.DefaultValue + '"','value=""');
		return $tdHtml;
	}
function split(str, data) {
    var reg = new RegExp("(#+" + data + "|" + data + ")", "g");
    var lastIndex = 0;
    var list = [];
    var replaceReg = new RegExp("(#" + data + ")", "g");

    while (true) {
        var exec = reg.exec(str);
        if (null == exec)
            break;

        var start = exec[0].match(/#+/g);

        if (null != start &&
            1 == start[0].length % 2) {
            continue;
        }

        var splitIndex = exec[0].match(/([^#].*)/);
        var txt = str.substring(lastIndex, exec.index + splitIndex.index).replace(replaceReg, data).replace(/##/g, "#");
        list.push(txt);
        lastIndex = exec.index + exec[0].length;
    }

    if (lastIndex < str.length) {
        var txt = str.substr(lastIndex).replace(replaceReg, data).replace(/##/g, "#");
        list.push(txt);
    }

    return list;
}

function isBlack(v) {
	if(typeof(v) == "undefined" || v == null || v == '') {
		return true;
	}else {
		return false;
	}
}

function fillSelect(obj,code,text)
{
	obj.length=0;
	var option0 = new Option("--请选择--","");
	obj.add(option0);
	for(var i=0; i<code.length; i++)
	{
		var option1 = new Option(code[i]+"->"+text[i],code[i]);
        obj.add(option1);
	}
}
function FixWidth(selectObj)
{

	if (navigator.userAgent.toLowerCase().indexOf("firefox") > 0) {
		return;
	}

	var newSelectObj = document.createElement("select");
	newSelectObj = selectObj.cloneNode(true);
	newSelectObj.selectedIndex = selectObj.selectedIndex;
	newSelectObj.id="newSelectObj";
  
	var e = selectObj;
	var _width = 0;
	try{
		var _ep = $(e).parent().parent().parent().parent().parent()[0]
		if(_ep) {
			if(_ep.tagName.toUpperCase() == 'FIELDSET') {
				_width = _ep.scrollLeft;
			}	
		}
	}catch(err){}
	var absTop = e.offsetTop;
	var absLeft = e.offsetLeft;
	while(e = e.offsetParent)
	{
		absLeft += e.offsetLeft;
	    absTop += e.offsetTop;
	}
	with (newSelectObj.style)
	{
	    position = "absolute";
	    top = absTop + "px";
	    left = absLeft-_width+ "px";
	    width = "auto";
	}
   	
	var rollback = function(){ RollbackWidth(selectObj, newSelectObj); };
	if(window.addEventListener)
	{
	    newSelectObj.addEventListener("blur", rollback, false);
	    newSelectObj.addEventListener("change", rollback, false);
	}
	else
	{
	    newSelectObj.attachEvent("onblur", rollback);
	    newSelectObj.attachEvent("onchange", rollback);
	}
	
	selectObj.style.visibility = "hidden";
	document.body.appendChild(newSelectObj);
	
	var newDiv = document.createElement("div");
	with (newDiv.style)
	{
	    position = "absolute";
	    top = (absTop-10) + "px";
	    left = (absLeft-_width-10) + "px";
	    width = newSelectObj.offsetWidth+20;
	    height= newSelectObj.offsetHeight+20;;
	    background = "transparent";
	    //background = "green";
	}
	document.body.appendChild(newDiv);
	newSelectObj.focus();
	var enterSel="false";
	var enter = function(){enterSel=enterSelect();};
	newSelectObj.onmouseover = enter;
	
	var leavDiv="false";
	var leave = function(){leavDiv=leaveNewDiv(selectObj, newSelectObj,newDiv,enterSel);};
	newDiv.onmouseleave = leave;
}

function RollbackWidth(selectObj, newSelectObj)
{
    selectObj.selectedIndex = newSelectObj.selectedIndex;
    selectObj.style.visibility = "visible";
    if(document.getElementById("newSelectObj") != null){
       document.body.removeChild(newSelectObj);
    }
}

function removeNewDiv(newDiv)
{
	document.body.removeChild(newDiv);
}

function enterSelect(){
	return "true";
}

function leaveNewDiv(selectObj, newSelectObj,newDiv,enterSel){
	if(enterSel == "true" ){
		RollbackWidth(selectObj, newSelectObj);
		removeNewDiv(newDiv);
	}
}

//生成文件名(时间戳)
function createFileName(value) {
	var fileSuffix= '';
	var pointIndex = value.lastIndexOf('.');
	if(pointIndex != -1 && pointIndex < value.length) {
		fileSuffix = value.substring(pointIndex,value.length);
	}
	var timeBeg = (new Date()).valueOf();
	var timeEnd = (new Date()).valueOf();
	while(timeBeg == timeEnd) {
		var s  = 0;
		for(var i=0;i<1000;i++) {
			s +=i;
		}
		timeEnd = (new Date()).valueOf();
	}
	var timeStamp = timeEnd + fileSuffix;
	return  timeStamp;
}

function downloadFile(v,charName) {
	var _this = v;
	var fileName = $(_this).parent().find('p').text();
	//调用ajax，入参文件名、ip、临时目录
	var path = "fe743_download.jsp?fileName=" + fileName + "&charName=" + charName;
	var ret = window.open(path);
}

//校验业务限制 
function chkBusinessLimit(orderType,poSpec){
  var result = true;
  if(orderType=="open_submit"&&poSpec=="1010402"){//当订单类型为开通单提交，商品规格为公众服务云业务时， 
    result = chkCharaNumberInfo();
  }
  return result;
}

//校验产品属性值列表 的属性值校验是否通过
function chkCharaNumberInfo(){
  var chkResult = true;
  $("div[id^='productspecqry_sub']").each(function(){
	  var val = $(this).find("#1116011009").val(); //1116011009 所对应的属性值
	  var chkFlag= $(this).find("#chkCharacterNumberFlag").val()//是否已经校验通过
  	if((typeof(val) != 'undefined')&&(typeof(val) != 'undefined')){
  	  if(val!=""&&chkFlag=="N"){
  	    rdShowMessageDialog("预约订单号输入错误或者没有点击查询按钮进行校验！");
		    chkResult = false;
  	  }
  	}
  });
  return chkResult;
}
function checkktcx_1101634025(obj){
	var str1101634025 = $(obj).val();
	$("#1101631019").blur(function(){checkElement($("#1101631019")[0])});
	$("#1101632011").blur(function(){checkElement($("#1101632011")[0])});
	$("#1101634005").blur(function(){checkElement($("#1101634005")[0])});
	if(str1101634025=="是"){
		$("#1101631019").attr("v_must","1");
		$("#1101631019").after('<font id="myfont" class="orange">*</font>');
		$("#1101631019").attr("disabled","");
		$("#1101632011").attr("v_must","1");
		$("#1101632011").after('<font id="myfont" class="orange">*</font>');
		$("#1101632011").attr("disabled","");
		$("#1101634004").val("http://112.33.1.29:9000");
		$("#1101634004").attr("readonly","readonly");
		$("#1101634004").attr("disabled","");
		$("#1101634005").attr("v_must","1");
		$("#1101634005").after('<font id="myfont" class="orange">*</font>');
		$("#1101634005").attr("disabled","");
	}
	else{
		$("font[id='myfont']").remove();
		$("#1101631019").attr("v_must","0");
		$("#1101631019").val("");
		$("#1101631019").attr("disabled","disabled");
		$("#1101632011").attr("v_must","0");
		$("#1101632011").val("");
		$("#1101632011").attr("disabled","disabled");
		$("#1101634004").val("");
		$("#1101634004").attr("disabled","disabled");
		$("#1101634005").attr("v_must","0");
		$("#1101634005").val("");
		$("#1101634005").attr("disabled","disabled");
	}
}

function checkktcx_1101644006(obj){
	var str1101634025 = $(obj).val();
	$("#1101644007").blur(function(){checkElement($("#1101644007")[0])});
	$("#1101644010").blur(function(){checkElement($("#1101644010")[0])});
	$("#1101644008").blur(function(){checkElement($("#1101644008")[0])});
	if(str1101634025=="是"){
		$("#1101644007").attr("v_must","1");
		$("#1101644007").after('<font id="myfont" class="orange">*</font>');
		$("#1101644007").attr("disabled","");
		$("#1101644010").attr("v_must","1");
		$("#1101644010").after('<font id="myfont" class="orange">*</font>');
		$("#1101644010").attr("disabled","");
		$("#1101644008").attr("v_must","1");
		$("#1101644008").after('<font id="myfont" class="orange">*</font>');
		$("#1101644008").attr("disabled","");
	}
	else{
		$("font[id='myfont']").remove();
		$("#1101644007").attr("v_must","0");
		$("#1101644007").val("");
		$("#1101644007").attr("disabled","disabled");
		$("#1101644010").attr("v_must","0");
		$("#1101644010").val("");
		$("#1101644010").attr("disabled","disabled");
		$("#1101644008").attr("v_must","0");
		$("#1101644008").val("");
		$("#1101644008").attr("disabled","disabled");
	}
}

var rstJson = {input:{}};
var sceneId = '';//ҵ�������
var proSceneId = '';//��Ʒ�����
var insOfferId = '';//��Ʒ������ϵ����
var waNo = '';//����������
var in_ChanceId = '';//����������  ��woNo
var fromType = '';// liujian 2013-5-17 10:43:56 �鿴��Դ����һ��ҵ���Ǵ�esop������ ���esop��Դ
var fileMapping = {};//���Ե��ļ��ϴ���name:area_count_code_seq ,value:*******.***�����������ļ��ϴ���name:poAttFile_1,value:***.***��
var hideAddProBtn = false;
var hideEcCodeBtn = false;
var areaFunctions = {};
var mainAreaArray = new Array();
var ProductOrder = {};
var checkboxArray = new Array();
var sceneObj={};//name:SceneId,value=sceneType//Ϊ�˱�ʶ��֧�����Ϊ2����ʾʵ��������������ʾʵ������
//ע��������������д���������doProcess�¼���������ȫ�ֱ���
/*
	name:areaId,
	value : parentId
	eg. ProductOrderRatePlans�е�select�ĸ��ڵ�
	name:ProductOrderRatePlans,
	value : parentId
*/
var selectParent = {};
var ratePlansGroup ;
//var planSelectParentID = '';
//var subAreasJson = '';//����ҳ���json��	
//����ύjson
function rstSubmit() {
	//ƴ��json��
	//getcustomerObj();//�ͻ�������Ϣ
	//getBusinessSceneObj();ҵ�񳡾�
	//getContactorInfoObj();//��Ʒ��������ϵ����Ϣ
	//getPOAttachmentObj();//��Ʒ������Ӧ�ĸ�����Ϣ 
	//getPOOrderChargesObj();//��Ʒһ��������
	//getpoorderinfoObj();//��Ʒ������Ϣ
	//getPOOrderRatePolicysObj();//�ײ�
	//getproductspecqryObj();//��Ʒ���
	//getPOAuditObj();//ҵ��������Ϣ
	//getBaseInfoObj();//fe743.jsp ��û�����Ϣ
	
	
	
	if(mainAreaArray.length > 0) {
		for(var i=0,len = mainAreaArray.length;i<len;i++) {
			new Function('get' + mainAreaArray[i] + 'Obj'+ '()')();
		}	
	}
	getBaseInfoObj();
	getBusinessSceneObj();//��ó���
	$('#json1').val(JSON2.stringify(rstJson));
	 
}

function setJson1Val(data) {
	$('#json1').val(data);	
}

function isArray(o) {   
  return Object.prototype.toString.call(o) === '[object Array]';    
} 
/*
 * Array�·���removeElByValue
 * ɾ�������еĶ��󣬸ö����name������valֵ
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
 * Array�·���indexOfByValue
 * �ж϶����name���Ե�valֵ���Ƿ����Array��
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
 * Array�·���getElByValue
 * ��������еĶ��󣬸ö����name������valֵ
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
//��ʵ��Provinceһ��
function SingleSelectObj(name,value) {
	this.name = name;
	this.value = value;	
}
	    
function Province(code,name) {
	this.code = code;
	this.name = name;
}
var provArr = [
	new Province('100','����'),new Province('290','����'), new Province('311','�ӱ�'),
	new Province('351','ɽ��'),new Province('371','����'),new Province('431','����'),
	new Province('451','������'),new Province('471','���ɹ�'),new Province('531','ɽ��'),
	new Province('551','����'),new Province('571','�㽭'),new Province('200','�㶫'),
	new Province('591','����'),new Province('731','����'),new Province('771','����'),
	new Province('791','����'),new Province('851','����'),new Province('871','����'),
	new Province('891','����'),new Province('898','����'),new Province('931','����'),
	new Province('951','����'),new Province('210','�Ϻ�'),new Province('971','�ຣ'),
	new Province('991','�½�'),new Province('000','���޹�˾'),new Province('220','���'),
	new Province('230','����'),new Province('240','����'),new Province('250','����'),
	new Province('270','����'),new Province('280','�Ĵ�')
];

//wanghf �����񴫵�json����ȥ�����ӷ��񷢹����Ķ���ģ����������
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

//wanghf ����form��������ֵ
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
//��jsp���صĴ���Ƭ�ηŵ�div����
function initArea(areaId) {
	$("#" + areaId + "AreaTitle").show();
	$("#" + areaId + "AreaLoading").show();
	$("#" + areaId + "Area").hide();
	//ajaxInit_" + areaId + "Area.jsp �ļ��´���
	var packet = new AJAXPacket("module/ajaxInit_" + areaId + "Area.jsp", "���ڳ�ʼ�������Ե�......");
	//liujian ��Ӳ���	
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

//�л� ��ʾ���
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
	
	//��ȡareaId��productspecqry_sub_ruleId_count_Area
	var temps = split(areaId,'_');
	if(temps.length == 4) {
		var count = temps[3];
		//'sub_' + sval + '_' +  count + '_Area'
		//ɾ������
		//2.1 ��ù��Id����ɾ���ĸ�����id
		var ruleId = temps[2];
		var mainAreaId = areaId.substring(areaId.indexOf("_")+1,areaId.length-1);//֮����-1����Ϊ��ȥ��β�ġ�_��
		//2.2 ɾ��areaFunctions�ж�Ӧ�ļ�¼
		var mas = areaFunctions[ruleId].mainArea;
		//2.2.1���mainAreaֻ�д�һ����¼����ɾ����Ʒ���ֵ����
		if(mas.length == 1 && mas[0] == mainAreaId) {
			delete areaFunctions[ruleId];
			var m = 0;
			for(var i in areaFunctions) {
				m++;
			}
			if(m == 0) {
				//ȷ�ϰ�ť���ܵ��
				setBtnDisabled();
			} 
		}else {
		//2.2.2ֻɾ��mainAreaIdһ����¼
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
//wanghfa �õ�����div��title
function getArea(areaId, titleName, marginTop,marginLeft) {	//����id��������⣬����ǰ��λ��Сpx
	var packet = new AJAXPacket("module/ajaxInit_area.jsp", "���ڳ�ʼ�������Ե�......");
	packet.data.add("areaId", areaId);
	packet.data.add("titleName", titleName);
	packet.data.add("marginTop", marginTop);
	packet.data.add("marginLeft", marginLeft);
	core.ajax.sendPacketHtml(packet, function(data) {
		$("#startDiv").append(data);
	});
	packet = null;
}

function getOnlyTitleArea(areaId, titleName, marginTop,marginLeft,parentId,delFlag) {	//����id��������⣬����ǰ��λ��Сpx
	var packet = new AJAXPacket("module/ajaxInit_area.jsp", "���ڳ�ʼ�������Ե�......");
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
	//ajaxInit_" + areaId + "Area.jsp �ļ��´���
	var packet = new AJAXPacket("module/ajaxInit_" + areaId + "Area.jsp", "���ڳ�ʼ�������Ե�......");
	//liujian ��Ӳ���	
	packet.data.add("areaId", areaId);
	packet.data.add("parentId", parentId);
	//liujian 2012-8-17 16:14:01 ������;�Ĳ�Ʒ������
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
function getInnerArea(areaId, titleName, marginTop,marginLeft,parentId) {	//����id��������⣬����ǰ��λ��Сpx
	var packet = new AJAXPacket("module/ajaxInit_area.jsp", "���ڳ�ʼ�������Ե�......");
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
//���÷���Ĺ�������
//fileFlag һ��ҳ��Ϊ1������ҳ��Ϊ2
function getServiceMsg(serviceName, backMethod,fileFlag) {
	var srvFile = "module/ajaxGetServiceMsg.jsp";
	if(fileFlag == 2 || fileFlag == '2') {
		srvFile = "ajaxGetServiceMsg.jsp";	
	}
	var packet = new AJAXPacket(srvFile, "���ڳ�ʼ�������Ե�......");	
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

//��footer��������ť���п��ƣ�������ˢ��ҳ��
function controlBtn(flag) {
	$("#submitBtn").attr("disabled", flag);
	$("#backBtn").attr("disabled", flag);
	$("#closeBtn").attr("disabled", flag);
}

//wanghf ����ĳһ��Ԫ�ز����ã������޸ģ�TODO������tagName����
//TODO �Ƿ���Լ�������
function unAvailable(eleId) {
	var eleTagName = ($("#" + eleId).get(0).tagName);
	if (eleTagName == "SELECT") {
		$("#" + eleId).attr("disabled", true);
	}
}





//������
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

//����json��������ȫ��
function getHtmlSegment(obj,id) {
	var htmlSegment = new Array();
	var mi = 0;
	for(var i=0,len=obj.length;i<len;i++) {
		var el = obj[i];
		//1. �жϱ�����
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
			//�ж�һϵ�е�����
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
			
			//����һЩ�����������ť��������� begin
			if(in_ChanceId != null && in_ChanceId != "null" && in_ChanceId != '') {
			}else if(!hideEcCodeBtn && el.ElementName == 'EC���ſͻ�����') {
				htmlSegment.push('&nbsp;&nbsp;<input type="button" class="b_text" name="getCustomerBtn" id="getCustomerBtn" value="��ѯ" onclick="getCustomer();">');
			}else if(!hideEcCodeBtn && el.ElementName == '��Ʒ������ϵ����'){
			}
			if(el.ElementName == '��Ʒ������ϵ����') {
				htmlSegment.push('&nbsp;&nbsp;<input type="button" class="b_text" name="getInsBtn" id="getCustomerBtn" value="��ѯ" onclick="getInstance();">');
			}
			//����һЩ�����������ť��������� end
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
				//�趨select�Ƿ����ѡ��
				var updateStr = '';
				attr = el.EUpdate;
				if(!isBlack(attr) && attr == '0') {
					updateStr =' disabled= "disabled" ';
				}
				htmlSegment.push('<select  onmouseover="FixWidth(this);" v_must="1" name="' + el.ElementCode +'" id=""' + updateStr + ' group="'+el.ElementGroup+'" >');
				if(arrLen == 0) {
					htmlSegment.push('<option value="">��ѡ��</option>');
				}else {
					attr = el.EValue;
					for(var j=0;j<arrLen;j++) {
						if(attr == values[j]) {
							//�趨ѡ����
							htmlSegment.push('<option value="' + values[j] + '" selected= "selected">' + names[j] + '</option>');
						}else {
							htmlSegment.push('<option value="' + values[j] + '">' + names[j] + '</option>');
						}
					}
					
				}
				htmlSegment.push('</select>');
				
			}
			if(el.ElementName == '��Ʒ�����' || el.ElementName == '��Ʒ������ϵ����') {
				htmlSegment.push('&nbsp;&nbsp;<input type="button" class="b_text" name="addRuleBtn" id="addRuleBtn" value="���" onclick="addRule();">');
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

//TODO �����б������
/*
	var $opt = {
		json : json[0], //json����
		tableId : '_table', //����ӵ�bodyid
		showAddBtn : false,//�Ƿ���ʾ����ӡ�������ť
		showDelBtn : false,//�Ƿ���ʾ��ɾ����������ť
		showTitleOnly : true//�Ƿ�ֻ��ʾthead
	}
*/
//�����б������
	var areaTrHtml = {};
	// name : area ������
	// value : ����ӵ�html�ֶ�
	function setListHtml($opt) {
		var _json = $opt.json;
		var body_id = $opt.tableId;
		var containerPath = _json.ContainerPath;
		var addBtnFlag = isBlack($opt.showAddBtn) ? false : $opt.showAddBtn;
		var delBtnFlag = isBlack($opt.showDelBtn) ? false : $opt.showDelBtn;
		var titleOnlyFlag = isBlack($opt.showTitleOnly) ? false : $opt.showTitleOnly;
		var addHiddenFlag = isBlack($opt.addHiddenInput) ? false : $opt.addHiddenInput;
		var tbody_id = 'tbody_' + containerPath; //�趨tbodyid
		//ѭ��һ�����飬��ȡthead�ĸ���
		//˳�����json�����ݵĵ�һ��group���Ⱥ�˳��
		var $head = {};
		var tdLen = 0;//������
		var $body = new Array();
		var headSmt = new Array();
		var bodySmt = new Array();
		var marker = "Group_";//��ı�ʶλ
		var group = {};
		//group���� Group_  ��ͷ
		// { 
		//	Group_ElementGroup : [],
		//	Group_ElementGroup : [],
		// }
		//��ȡ����group����
		for(var i=0,len=_json.Elements.length;i<len;i++) {
			var el = _json.Elements[i];
			var groupNo = el.ElementGroup;
			if(isBlack(group[marker + groupNo]) || group[marker + groupNo].length == 0) {
				group[marker + groupNo] = new Array();
			}
			group[marker + groupNo].push(el);
		}
		
		//����״̬����һ�ζ�ȡgroup������thead
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
				//�����ж���
				var $td = {}; 
				//$td {
				//			el.ElementCode : el.EValue
				//			type           : el.FormType
				//			names          : el.SelShow 
				//          values         : el.SelValue
				//		}
				//�ж�������ж���
				*/
				$tr.push(el);
			}
			time++;
			//tbody��������ж���
			$body.push($tr);
		}
		
		//��ҳ�����htmlƬ��
		//1. thead segment
		headSmt.push('<thead><tr align="center">');
		for(var h in $head) {
			headSmt.push('<th>');
			headSmt.push($head[h]);
			headSmt.push('</th>');
		}
		//��Ӳ�����
		if(delBtnFlag) {
			tdLen++;
			headSmt.push('<th>');
			headSmt.push('����');
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
						//addHiddenFlag ���һ�����ʷ�
						var _$td = setTdHtml(_td,addHiddenFlag,m);
						bodySmt.push(_$td.tbody);
						bodyAddHtml.push(_$td.tbodyAdd);
						//ɾ�����󣬽�ʡ�´β�ѯ��ʱ��
						_tr.splice(k, 1);
						break;
					}
				}
				if(delBtnFlag) {
					bodySmt.push('<td>');
					bodySmt.push('<input type="button" value="ɾ��" name="delRecordBtn" class="b_text" onclick="delRecord(this)" />'); 
					bodySmt.push('</td>');
					bodyAddHtml.push('<td>');
					bodyAddHtml.push('<input type="button" value="ɾ��" name="delRecordBtn" class="b_text" onclick="delRecord(this)" />'); 
					bodyAddHtml.push('</td>');
				}
				//��¼tr����ӵ�htmlƬ��
				bodyAddHtml.push('</tr>');
				if(trTime == 0) {
					areaTrHtml[containerPath] =  bodyAddHtml.join('');
				}
				trTime++;
				bodySmt.push('</tr>');
			}
		}
		bodySmt.push('</tbody>');
		//��ӡ���ӡ���ť
		if(addBtnFlag) {
			bodySmt.push('<tbody><tr><td>');
			bodySmt.push('<input type="button" value="���" name="addRecordBtn" class="b_text" onclick="addRecord(\'' + containerPath + '\',\'' + body_id + '\')" />');
			bodySmt.push('</td></tr></tbody>');
		}
		$('#' + body_id).append(headSmt.join(''));
		$('#' + body_id).append(bodySmt.join(''));
	}
//���ñ�����
	function setTdHtml($td,addHiddenFlag,m) {
		var $tdHtml = {};
		var $tdHead = new Array();
		var $tdBody = new Array();
		var el = $td;
		//1. �жϱ�����
		var attr = '';
		var type = el.FormType;
		//����tbody��td
		if(isBlack(type) || type.toLocaleLowerCase() == 'text') {
			var mustFlag = false;
			$tdBody.push('<td><input type="input" ');
			//�ж�һϵ�е�����
			//ElementGroup��ElementCode û�ӽ�ȥ
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
			attr = el.EUpdate;//0�ǲ��ɣ�1�ǿ����޸�
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
			//����һЩ�����������ť��������� end
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
				//�趨select�Ƿ����ѡ��
				var updateStr = '';
				if(!isBlack(el.EUpdate) && el.EUpdate == '0') {
					updateStr =' disabled= "disabled" ';
				}				
				$tdBody.push('<select onmouseover="FixWidth(this);" name="' + el.ElementCode + '"' + updateStr + ' v_must="1" >');
				if(arrLen == 0) {
					$tdBody.push('<option value="">��ѡ��</option>');
				}else {
					for(var j=0;j<arrLen;j++) {
						if(el.EValue == values[j]) {
							//�趨ѡ����
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
			//EValue��ֵ�Ϳ�������
			if(el.EValue){
				$tdBody.push('<a href="#" onclick="downloadFile(this,\'' + el.EValue + '\');"><p>' + el.EValue + '</p></a>');
			}
			//EUpdate==0�����ϴ��ļ�
			if(el.EUpdate == '0') {
				
			}else {
				//�ϴ���Ŀǰֻ�и���
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
		//��ȡthead��td
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
	//���ManageNode��ManageNodeGet
	function setNodeListHtml($opt) {
		var _json = $opt.json;
		var body_id = $opt.tableId;
		var containerPath = _json.ContainerPath;
		var addBtnFlag = isBlack($opt.showAddBtn) ? false : $opt.showAddBtn;
		var delBtnFlag = isBlack($opt.showDelBtn) ? false : $opt.showDelBtn;
		var titleOnlyFlag = isBlack($opt.showTitleOnly) ? false : $opt.showTitleOnly;
		var addHiddenFlag = isBlack($opt.addHiddenInput) ? false : $opt.addHiddenInput;
		var tbody_id = 'tbody_' + containerPath; //�趨tbodyid
		//ѭ��һ�����飬��ȡthead�ĸ���
		//˳�����json�����ݵĵ�һ��group���Ⱥ�˳��
		var $head = {};
		var tdLen = 0;//������
		var $body = new Array();
		var headSmt = new Array();
		var bodySmt = new Array();
		var marker = "Group_";//��ı�ʶλ
		var group = {};
		//group���� Group_  ��ͷ
		// { 
		//	Group_ElementGroup : [],
		//	Group_ElementGroup : [],
		// }
		//��ȡ����group����
		for(var i=0,len=_json.Elements.length;i<len;i++) {
			var el = _json.Elements[i];
			var groupNo = el.ElementGroup;
			if(isBlack(group[marker + groupNo]) || group[marker + groupNo].length == 0) {
				group[marker + groupNo] = new Array();
			}
			group[marker + groupNo].push(el);
		}
		//����״̬����һ�ζ�ȡgroup������thead
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
				
				//�����ж���
				//var $td = {}; 
				//$td {
				//			el.ElementCode : el.EValue
				//			type           : el.FormType
				//			names          : el.SelShow 
				//          values         : el.SelValue
				//		}
				//�ж�������ж���
			
				$tr.push(el);
			}
			time++;
			//tbody��������ж���
			$body.push($tr);
		}
		
		//��ҳ�����htmlƬ��
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
		//��Ӳ�����
		if(delBtnFlag) {
			tdLen++;
			headSmt.push('<th>');
			headSmt.push('����');
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
						//addHiddenFlag ���һ�����ʷ�
						//hiddenFlag ��Թ�������
						var _$td = setTdHtml(_td,addHiddenFlag,m);
						bodySmt.push(_$td.tbody);
						bodyAddHtml.push(_$td.tbodyAdd);
						//ɾ�����󣬽�ʡ�´β�ѯ��ʱ��
						_tr.splice(k, 1);
						break;
					}
				}
				if(delBtnFlag) {
					bodySmt.push('<td>');
					bodySmt.push('<input type="button" value="ɾ��" name="delRecordBtn" class="b_text" onclick="delRecord(this)" />'); 
					bodySmt.push('</td>');
					bodyAddHtml.push('<td>');
					bodyAddHtml.push('<input type="button" value="ɾ��" name="delRecordBtn" class="b_text" onclick="delRecord(this)" />'); 
					bodyAddHtml.push('</td>');
				}
				//��¼tr����ӵ�htmlƬ��
				bodyAddHtml.push('</tr>');
				if(trTime == 0) {
					areaTrHtml[containerPath] =  bodyAddHtml.join('');
				}
				trTime++;
				bodySmt.push('</tr>');
			}
		}
		bodySmt.push('</tbody>');
		//��ӡ���ӡ���ť
		if(addBtnFlag) {
			bodySmt.push('<tbody><tr><td>');
			bodySmt.push('<input type="button" value="���" name="addRecordBtn" class="b_text" onclick="addRecord(\'' + containerPath + '\',\'' + body_id + '\')" />');
			bodySmt.push('</td></tr></tbody>');
		}
		$('#' + body_id).append(headSmt.join(''));
		$('#' + body_id).append(bodySmt.join(''));
	}
	//��Ӽ�¼��
	function addRecord(containerPath,bodyId) {
		$('#tbody_' + containerPath).append(areaTrHtml[containerPath]);
	}
	//ɾ����ǰ��¼��
	function delRecord(k) {
		$(k).parents("tr").remove();
	}
	
	function setTdHtml2($td,parentId,vsum) {
		var $tdHtml = {};
		var $tdHead = new Array();
		var $tdBody = new Array();
		var el = $td;
		//1. �жϱ�����
		var attr = '';
		var type = el.CharacterType;
		//����tbody��td
		//fieldCode���漰
		//"MultipleAble": "",��Ӧtype��checkbox
		//"ShowFlag": "",0����ʾ��""����1��ʾ��Ĭ����ʾ
				
		if(isBlack(type) || type.toLocaleLowerCase() == 'text') {
			var mustFlag = false;
			$tdBody.push('<td>');	
			$tdBody.push('<input type="input" ');
			//�ж�һϵ�е�����
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
			/***  begin  ���ڷ�����ҵ���Ż�@2014/8/11 ***/
			if(el.CharacterNumber=="1116013001"){
				$tdBody.push(' v_id="resRebateType_'+vsum+'" ');
			}
			if(el.CharacterNumber=="1116013002"){ //���Լƻ���ʼ����
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
			/***  end  ���ڷ�����ҵ���Ż�@2014/8/11 ***/
			 $tdBody.push("/>");
			//����һЩ�����������ť��������� end
			
			if(mustFlag) {
				$tdBody.push('<font class="orange">*</font>');
			}
			
			/***  begin  ���ڷ�����ҵ���Ż�@2014/8/11 ***/
			if(!mustFlag && ( el.CharacterNumber=="1116013002" || el.CharacterNumber=="1116013003") ){
				$tdBody.push('<font v_id="orangeFlag_'+vsum+'" class="orange"></font> ');
			}
			if(el.CharacterNumber=="1116013005"){
				$tdBody.push(' <font v_id="feeText_'+vsum+'" class="orange"></font>');
			}
			if(el.CharacterNumber=="1116011009"){
			  $tdBody.push('&nbsp;&nbsp;<input type="button" class="b_text" name="getCustBtn" id="getCustBtn" value="��ѯ" onclick="getProdProperty(this);"> &nbsp;&nbsp;');
			}
			/***  end  ���ڷ�����ҵ���Ż�@2014/8/11 ***/
			
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
				//�趨select�Ƿ����ѡ��
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
					$tdBody.push('<option value="-1">��ѡ��</option>');
				}else {
					for(var j=0;j<arrLen;j++) {
						if(el.DefaultValue == values[j]) {
							//�趨ѡ����
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
			//ReadOnly==1�����ϴ��ļ�
			if(el.ReadOnly == '1') {
				//DefaultValue��������
				if(el.DefaultValue){
					$tdBody.push('<a href="#" onclick="downloadFile(this,\'' + el.CharacterNumber + '\');"><p>' + el.DefaultValue + '</p></a>');
				}
			}else {
				//DefaultValue��������
				if(el.DefaultValue){
					$tdBody.push('<a href="#" onclick="downloadFile(this,\'' + el.CharacterNumber + '\');"><p>' + el.DefaultValue + '</p></a>');
				}
				
				var charNum= el.CharacterNumber;
				var _temp = '';
				if(charNum == '999033717') {
					//����ʡ�ϴ���Ա��ϸ�ļ�.xls
					_temp = '<a href="detail.xls">����ģ��</a>';
				}else if(charNum == '999033734') {
					//����ȷ�Ϸ�����ϸ����
					_temp = '<a href="submit.xls">����ģ��</a>';
				}else if(charNum == '999033735') {
					//���뿪ͨ������ϸ����
					_temp = '<a href="open.xls">����ģ��</a>';
				}
				//liujian 2012-9-7 14:37:21 �������ģ�� ��������ʡ��ҵӦ�ÿ�ҵ�� begin 
				else if(charNum == '9116014560') {
					_temp = '<a href="card_detail.xls">����ģ��</a>';
				}else if(charNum == '9116014556') {
					_temp = '<a href="card_open.xls">����ģ��</a>';
				/*2013/12/19 9:01:48 gaopeng  �����·��Ż���������ҵ��֧��ʵʩ������֪ͨ ����ģ�����ع���*/
				}else if(charNum == '1113035011') {
					_temp = '<a href="callcenter.xls">����ģ��</a>';
				}
				//liujian 2012-9-7 14:37:21 �������ģ�� end
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
			//liujian 2012-8-20 14:47:21 type=checkbox[]����������Ϊ�ָ��������type=checkbox����checkbox[]��ָ���Ϊ","
			//1.չʾ 2.��ѡ
			var _id=parentId + '_' + el.CharacterNumber;
			var _pId = 'p'+_id;
			if(el.ReadOnly == '1') {
				$tdBody.push('<td>');
				$tdBody.push('	<input id="' + _id + '" class="InputGrey"  type="text" readonly="readonly" value="' + el.DefaultValue + '" />');
				$tdBody.push('</td>');
			}else {
				$tdBody.push('<td id="' + _pId + '" style="float:left;position: relative;">');	
				$tdBody.push('<input id="' + _id + '" class="ListText"  type="text" readonly="readonly" value="��ѡ��" />');
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
		//��ȡthead��td
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
	var option0 = new Option("--��ѡ��--","");
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

//�����ļ���(ʱ���)
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
	//����ajax������ļ�����ip����ʱĿ¼
	var path = "fe743_download.jsp?fileName=" + fileName + "&charName=" + charName;
	var ret = window.open(path);
}

//У��ҵ������ 
function chkBusinessLimit(orderType,poSpec){
  var result = true;
  if(orderType=="open_submit"&&poSpec=="1010402"){//����������Ϊ��ͨ���ύ����Ʒ���Ϊ���ڷ�����ҵ��ʱ�� 
    result = chkCharaNumberInfo();
  }
  return result;
}

//У���Ʒ����ֵ�б� ������ֵУ���Ƿ�ͨ��
function chkCharaNumberInfo(){
  var chkResult = true;
  $("div[id^='productspecqry_sub']").each(function(){
	  var val = $(this).find("#1116011009").val(); //1116011009 ����Ӧ������ֵ
	  var chkFlag= $(this).find("#chkCharacterNumberFlag").val()//�Ƿ��Ѿ�У��ͨ��
  	if((typeof(val) != 'undefined')&&(typeof(val) != 'undefined')){
  	  if(val!=""&&chkFlag=="N"){
  	    rdShowMessageDialog("ԤԼ����������������û�е����ѯ��ť����У�飡");
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
	if(str1101634025=="��"){
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
	if(str1101634025=="��"){
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

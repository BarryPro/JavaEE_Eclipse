function StateSynInfo() {	//工单状态同步信息
	this.poOrderNumber = "";
	this.stateType = "";
	this.respPersons = new Array();
	this.productOrderInfos = new Array();
	this.customerNumber = "";
	this.poSpecNumber = "";
	this.synTime = "";
	this.notes = ""
	
	this.addRespPerson = function(vNname, vPhone, vDepartment) {
		var respPerson = new RespPerson();
		respPerson.name = vNname;
		respPerson.phone = vPhone;
		respPerson.department = vDepartment;
		this.respPersons[this.respPersons.length] = respPerson;
	};
	this.addProductOrderInfo = function(vProductId, vCircuitCode, vResult, vReason, vCustomContact, vCustomContactPhone, vPlanCompTime) {
		var productOrderInfo = new ProductOrderInfo();
		productOrderInfo.productId = vProductId;
		productOrderInfo.circuitCode = vCircuitCode;
		productOrderInfo.result = vResult
		productOrderInfo.reason = vReason;
		productOrderInfo.customContact = vCustomContact;
		productOrderInfo.customContactPhone = vCustomContactPhone;
		productOrderInfo.planCompTime = vPlanCompTime;
		this.productOrderInfos[this.productOrderInfos.length] = productOrderInfo;
	};
	this.getProductOrderInfos = function() {
		return this.productOrderInfos;
	};
	
}
function RespPerson() {	//当前状态负责人信息
	this.name = "";
	this.phone = "";
	this.department = "";
}
function ProductOrderInfo() {	//一条产品信息
	this.productId = "";
	this.circuitCode = "";
	this.result = "";
	this.reason = "";
	this.customContact = "";
	this.customContactPhone = "";
	this.planCompTime = "";
	this.provCustMags = new Array();
	this.custInfos = new Array();
	this.dealInfos = new Array();
	this.prodInfoModifies = new Array();
	
	this.addProvCustMag = function(vMagType, vMagName, vMagPhone) {
		var vProvCustMag = new ProvCustMag();
		vProvCustMag.magType = vMagType;
		vProvCustMag.magName = vMagName;
		vProvCustMag.magPhone = vMagPhone;
		this.provCustMags[this.provCustMags.length] = vProvCustMag;
	};
	this.addCustInfos = function(vCustType, vCustCode, vCustName) {
		var vCustInfo = new CustInfo();
		vCustInfo.custType = vCustType;
		vCustInfo.custCode = vCustCode;
		vCustInfo.custName = vCustName;
		this.custInfos[this.custInfos.length] = vCustInfo;
	};
	this.addDealInfos = function(vDealSide, vDealDatail, vAttachment, vAttachmentFile) {
		var vDealInfo = new DealInfo();
		vDealInfo.dealSide = vDealSide;
		vDealInfo.dealDatail = vDealDatail;
		vDealInfo.attachment = vAttachment;
		vDealInfo.attachmentFile = vAttachmentFile;
		this.dealInfos[this.dealInfos.length] = vDealInfo;
	};
	this.addProdInfoModify = function(vModiType, vModiValue) {
		var vProdInfoModify = new ProdInfoModify();
		vProdInfoModify.modiType = vModiType;
		vProdInfoModify.modiValue = vModiValue;
		this.prodInfoModifies[this.prodInfoModifies.length] = vProdInfoModify;
	};
}
function ProvCustMag() {	//产品对应的客户经理
	this.magType = "";
	this.magName = "";
	this.magPhone = "";
}
function CustInfo() {	//产品受理涉及的客户信息
	this.custType = "";
	this.custCode = "";
	this.custName = "";
}
function DealInfo() {	//产品落实情况
	this.dealSide = "";
	this.dealDatail = "";
	this.attachment = "";	//文件名
	this.attachmentFile = "";	//web服务器路径+文件名
	//this.attachmentLocalFile = "";	//本地路径
}
function ProdInfoModify() {	//产品信息修正
	this.modiType = "";
	this.modiValue = "";
}


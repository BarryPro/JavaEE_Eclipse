/*
 * 功能: 省内携号
 * 版本: 1.0
 * 日期: 2012/3/15 10:45:32
 * 作者: zhangyan
 * 版权: si-tech
 * update:
*/

/*公共信息*/

function pubicinfo(){};
pubicinfo.prototype.setOpCode = function(opCode){
	this.opCode = opCode;
};
pubicinfo.prototype.getOpCode = function(){
	return this.opCode;
};

pubicinfo.prototype.setLoginNo = function(loginNo){
	this.loginNo = loginNo;
};
pubicinfo.prototype.getLoginNo = function(){
	return this.loginNo;
};


pubicinfo.prototype.setOp_note = function(op_note){
	this.op_note = op_note;
};
pubicinfo.prototype.getOp_note = function(){
	return this.op_note;
};

pubicinfo.prototype.setPay_money = function(pay_money){
	this.pay_money = pay_money;
};
pubicinfo.prototype.getPay_money = function(){
	return this.pay_money;
};


pubicinfo.prototype.setCreate_accept = function(create_accept){
	this.create_accept = create_accept;
};
pubicinfo.prototype.getCreate_accept = function(){
	return this.create_accept;
};
pubicinfo.prototype.setPhone_no = function(phone_no){
	this.phone_no = phone_no;
};
pubicinfo.prototype.getPhone_no = function(){
	return this.phone_no;
};

/*业务参数*/
function param(){};

/*参数5 操作标示*/
param.prototype.setOp_flag = function(op_flag){
	this.op_flag = op_flag;
};
param.prototype.getOp_flag = function(){
	return this.op_flag;
};
/*参数6 生效时间*/
param.prototype.setBegin_time = function(begin_time){
	this.begin_time = begin_time;
};
param.prototype.getBegin_time = function(){
	return this.begin_time;
};

/*参数8 资费代码*/
param.prototype.setNewofferid = function(newofferid){
	this.newofferid = newofferid;
};
param.prototype.getNewofferid = function(){
	return this.newofferid;
};

/*参数9 小区代码*/
param.prototype.setAreacode = function(areacode){
	this.areacode = areacode;
};
param.prototype.getAreacode = function(){
	return this.areacode;
};

/*参数1 老流水
param.prototype.setBack_accept = function(back_accept){
	this.back_accept = back_accept;
};
param.prototype.getBack_accept = function(){
	return this.back_accept;
}; */

/*参数8 特服代码*/
param.prototype.setProduct_id = function(product_id){
	this.product_id = product_id;
};
param.prototype.getProduct_id = function(){
	return this.product_id;
}; 

/*参数7 失效时间*/
param.prototype.setEnd_time = function(end_time){
	this.end_time = end_time;
};
param.prototype.getEnd_time = function(){
	return this.end_time;
}; 

/*参数 操作类型 申请06  冲正07*/
param.prototype.setOper = function(oper){
	this.oper = oper;
};
param.prototype.getOper = function(){
	return this.oper;
}; 
/*参数 busitype */
param.prototype.setBusitype = function(busitype){
	this.busitype = busitype;
};
param.prototype.getBusitype = function(){
	return this.busitype;
}; 

/*参数 group_id */
param.prototype.setGroup_id = function(group_id){
	this.group_id = group_id;
};
param.prototype.getGroup_id = function(){
	return this.group_id;
}; 

/*参数 in_group_id */
param.prototype.setIn_group_id = function(in_group_id){
	this.in_group_id = in_group_id;
};
param.prototype.getIn_group_id = function(){
	return this.in_group_id;
}; 

/*参数 send_status */
param.prototype.setSend_status = function(send_status){
	this.send_status = send_status;
};
param.prototype.getSend_status = function(){
	return this.send_status;
}; 

/*参数 sms_release */
param.prototype.setSms_release = function(sms_release){
	this.sms_release = sms_release;
};
param.prototype.getSms_release = function(){
	return this.sms_release;
}; 


/*参数 back_accept */
param.prototype.setBack_accept = function(back_accept){
	this.back_accept = back_accept;
};
param.prototype.getBack_accept = function(){
	return this.back_accept;
};

/*办理的业务*/
function business(){};

business.prototype.setFuncname = function(funcname){
	this.funcname = funcname;
};
business.prototype.getFuncname = function(){
	return this.funcname;
};

business.prototype.getParam = function()
{ 
	 return this.param;
};
business.prototype.setParam = function(Param){
	this.param = Param;
};

/*资费信息*/
function OfferList (){
	this.busiLength 	= 0;
	this.business 	= [];	
};
OfferList.prototype.getBusiness = function(i)
{ 
	 return this.business[i];
};
OfferList.prototype.setBusiness = function(business){
	this.business[this.busiLength++] = business;
};

OfferList.prototype.getPubicinfo = function()
{ 
	return this.pubicinfo;
};
OfferList.prototype.setPubicinfo = function(pubicinfo){
	this.pubicinfo = pubicinfo;
};


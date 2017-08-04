/*
 * 功能: 转售号码
 * 版本: 1.0
 * 日期: 2016/5/27 14:50:44
 * 作者: gaopeng
 * 版权: si-tech
 * update:
*/

/*业务参数*/
function param(){};

/*审批公文编号*/
param.prototype.setAPPROVAL_ID = function(APPROVAL_ID){
	this.APPROVAL_ID = APPROVAL_ID;
};
param.prototype.getAPPROVAL_ID = function(){
	return this.APPROVAL_ID;
};

/*员工编号*/
param.prototype.setLOGIN_NO = function(LOGIN_NO){
	this.LOGIN_NO = LOGIN_NO;
};
param.prototype.getLOGIN_NO = function(){
	return this.LOGIN_NO;
};

/*证件类型*/
param.prototype.setID_TYPE = function(ID_TYPE){
	this.ID_TYPE = ID_TYPE;
};
param.prototype.getID_TYPE = function(){
	return this.ID_TYPE;
};

/*证件号码*/
param.prototype.setID_NUM = function(ID_NUM){
	this.ID_NUM = ID_NUM;
};
param.prototype.getID_NUM = function(){
	return this.ID_NUM;
};

/*客户名称*/
param.prototype.setCUST_NAME = function(CUST_NAME){
	this.CUST_NAME = CUST_NAME;
};
param.prototype.getCUST_NAME = function(){
	return this.CUST_NAME;
};

/*证件地址*/
param.prototype.setCUST_ADDR = function(CUST_ADDR){
	this.CUST_ADDR = CUST_ADDR;
};
param.prototype.getCUST_ADDR = function(){
	return this.CUST_ADDR;
};

/*联系电话*/
param.prototype.setPHONE_NO = function(PHONE_NO){
	this.PHONE_NO = PHONE_NO;
};
param.prototype.getPHONE_NO = function(){
	return this.PHONE_NO;
};
/*SIM卡号*/
param.prototype.setSIM_NO = function(SIM_NO){
	this.SIM_NO = SIM_NO;
};
param.prototype.getSIM_NO = function(){
	return this.SIM_NO;
};
/*SIM卡号*/
param.prototype.setiCardNo = function(iCardNo){
	this.iCardNo = iCardNo;
};
param.prototype.getiCardNo = function(){
	return this.iCardNo;
};




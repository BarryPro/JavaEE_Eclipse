/*
 * ����: ת�ۺ���
 * �汾: 1.0
 * ����: 2016/5/27 14:50:44
 * ����: gaopeng
 * ��Ȩ: si-tech
 * update:
*/

/*ҵ�����*/
function param(){};

/*�������ı��*/
param.prototype.setAPPROVAL_ID = function(APPROVAL_ID){
	this.APPROVAL_ID = APPROVAL_ID;
};
param.prototype.getAPPROVAL_ID = function(){
	return this.APPROVAL_ID;
};

/*Ա�����*/
param.prototype.setLOGIN_NO = function(LOGIN_NO){
	this.LOGIN_NO = LOGIN_NO;
};
param.prototype.getLOGIN_NO = function(){
	return this.LOGIN_NO;
};

/*֤������*/
param.prototype.setID_TYPE = function(ID_TYPE){
	this.ID_TYPE = ID_TYPE;
};
param.prototype.getID_TYPE = function(){
	return this.ID_TYPE;
};

/*֤������*/
param.prototype.setID_NUM = function(ID_NUM){
	this.ID_NUM = ID_NUM;
};
param.prototype.getID_NUM = function(){
	return this.ID_NUM;
};

/*�ͻ�����*/
param.prototype.setCUST_NAME = function(CUST_NAME){
	this.CUST_NAME = CUST_NAME;
};
param.prototype.getCUST_NAME = function(){
	return this.CUST_NAME;
};

/*֤����ַ*/
param.prototype.setCUST_ADDR = function(CUST_ADDR){
	this.CUST_ADDR = CUST_ADDR;
};
param.prototype.getCUST_ADDR = function(){
	return this.CUST_ADDR;
};

/*��ϵ�绰*/
param.prototype.setPHONE_NO = function(PHONE_NO){
	this.PHONE_NO = PHONE_NO;
};
param.prototype.getPHONE_NO = function(){
	return this.PHONE_NO;
};
/*SIM����*/
param.prototype.setSIM_NO = function(SIM_NO){
	this.SIM_NO = SIM_NO;
};
param.prototype.getSIM_NO = function(){
	return this.SIM_NO;
};
/*SIM����*/
param.prototype.setiCardNo = function(iCardNo){
	this.iCardNo = iCardNo;
};
param.prototype.getiCardNo = function(){
	return this.iCardNo;
};




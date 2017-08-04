
function Prod_msg(){
}
Prod_msg.prototype.setProdLib_DetailId = function(prodLib_DetailId){
	this.prodLib_DetailId = prodLib_DetailId;
};
Prod_msg.prototype.getProdLib_DetailId = function(){
	return this.prodLib_DetailId;
};
Prod_msg.prototype.setProdLib_mark = function(prodLib_mark){
	this.prodLib_mark = prodLib_mark;
};
Prod_msg.prototype.getProdLib_mark = function(){
	return this.prodLib_mark;
};
Prod_msg.prototype.setProdLib_name = function(prodLib_name){
	this.prodLib_name = prodLib_name;
};
Prod_msg.prototype.getProdLib_name = function(){
	return this.prodLib_name;
};
Prod_msg.prototype.setNewofferid = function(newofferid){
	this.newofferid = newofferid;
};
Prod_msg.prototype.getNewofferid = function(){
	return this.newofferid;
};
Prod_msg.prototype.setOffer_name = function(offer_name){
	this.offer_name = offer_name;
};
Prod_msg.prototype.getOffer_name = function(){
	return this.offer_name;
};
Prod_msg.prototype.setProdOrder_amount = function(prodOrder_amount){
	this.prodOrder_amount = prodOrder_amount;
};
Prod_msg.prototype.getProdOrder_amount = function(){
	return this.prodOrder_amount;
};
Prod_msg.prototype.setBegin_time = function(begin_time){
	this.begin_time = begin_time;
};
Prod_msg.prototype.getBegin_time = function(){
	return this.begin_time;
};
Prod_msg.prototype.setEnd_time = function(end_time){
	this.end_time = end_time;
};
Prod_msg.prototype.getEnd_time = function(){
	return this.end_time;
};
Prod_msg.prototype.setDiscount_price = function(discount_price){
	this.discount_price = discount_price;
};
Prod_msg.prototype.getDiscount_price = function(){
	return this.discount_price;
};
Prod_msg.prototype.setTotal_price = function(total_price){
	this.total_price = total_price;
};
Prod_msg.prototype.getTotal_price = function(){
	return this.total_price;
};
Prod_msg.prototype.setDiscount_amount = function(discount_amount){
	this.discount_amount = discount_amount;
};
Prod_msg.prototype.getDiscount_amount = function(){
	return this.discount_amount;
};
Prod_msg.prototype.setSource_amount = function(source_amount){
	this.source_amount = source_amount;
};
Prod_msg.prototype.getSource_amount = function(){
	return this.source_amount;
};
Prod_msg.prototype.setResUnit = function(resUnit){
	this.resUnit = resUnit;
};
Prod_msg.prototype.getResUnit = function(){
	return this.resUnit;
};
Prod_msg.prototype.setOper = function(oper){
	this.oper = oper;
};
Prod_msg.prototype.getOper = function(){
	return this.oper;
};
Prod_msg.prototype.setProd_instId = function(prod_instId){
	this.prod_instId = prod_instId;
};
Prod_msg.prototype.getProd_instId = function(){
	return this.prod_instId;
};
Prod_msg.prototype.setProdTypeId = function(prodTypeId){
	this.prodTypeId = prodTypeId;
};
Prod_msg.prototype.getProdTypeId = function(){
	return this.prodTypeId;
};
Prod_msg.prototype.setTable_date = function(table_date){
	this.table_date = table_date;
};
Prod_msg.prototype.getTable_date = function(){
	return this.table_date;
};
Prod_msg.prototype.setOld_accept = function(old_accept){
	this.old_accept = old_accept;
};
Prod_msg.prototype.getOld_accept = function(){
	return this.old_accept;
};

function TotalSumRes(){
}
TotalSumRes.prototype.setProdTypeId = function(prodTypeId){
	this.prodTypeId = prodTypeId;
};
TotalSumRes.prototype.getProdTypeId = function(){
	return this.prodTypeId;
};
TotalSumRes.prototype.setProdTypeName = function(prodTypeName){
	this.prodTypeName = prodTypeName;
};
TotalSumRes.prototype.getProdTypeName = function(){
	return this.prodTypeName;
};
TotalSumRes.prototype.setProdSumRes = function(prodSumRes){
	this.prodSumRes = prodSumRes;
};
TotalSumRes.prototype.getProdSumRes = function(){
	return this.prodSumRes;
};
TotalSumRes.prototype.setProdResUnit = function(prodResUnit){
	this.prodResUnit = prodResUnit;
};
TotalSumRes.prototype.getProdResUnit = function(){
	return this.prodResUnit;
};

function Prod_Revolution(){
	this.prodLength = 0;
	this.prod_msgs = [];
	this.sumResLength = 0;
	this.totalSumReses = [];
}
Prod_Revolution.prototype.getProdLength = function(){
	return this.prodLength;
};
Prod_Revolution.prototype.getSumResLength = function(){
	return this.sumResLength;
};
Prod_Revolution.prototype.getProd_msg = function(i){
	return this.prod_msgs[i];
};
Prod_Revolution.prototype.getTotalSumRes = function(i){
	return this.totalSumReses[i];
};
Prod_Revolution.prototype.addProd_msg = function(prod_msg){
	this.prod_msgs[this.prodLength++] = prod_msg;
};
Prod_Revolution.prototype.setProd_msg = function(i,prod_msg){
	this.prod_msgs[i] = prod_msg;
};
Prod_Revolution.prototype.addTotalSumRes = function(totalSumRes){
	this.totalSumReses[this.sumResLength++] = totalSumRes;
};

Prod_Revolution.prototype.setCreate_accept = function(create_accept){
	this.create_accept = create_accept;
};
Prod_Revolution.prototype.getCreate_accept = function(){
	return this.create_accept;
};
Prod_Revolution.prototype.setChnsource = function(chnsource){
	this.chnsource = chnsource;
};
Prod_Revolution.prototype.getChnsource = function(){
	return this.chnsource;
};
Prod_Revolution.prototype.setOpCode = function(opCode){
	this.opCode = opCode;
};
Prod_Revolution.prototype.getOpCode = function(){
	return this.opCode;
};
Prod_Revolution.prototype.setLoginNo = function(loginNo){
	this.loginNo = loginNo;
};
Prod_Revolution.prototype.getLoginNo = function(){
	return this.loginNo;
};
Prod_Revolution.prototype.setPassword = function(password){
	this.password = password;
};
Prod_Revolution.prototype.getPassword = function(){
	return this.password;
};
Prod_Revolution.prototype.setPhone_no = function(phone_no){
	this.phone_no = phone_no;
};
Prod_Revolution.prototype.getPhone_no = function(){
	return this.phone_no;
};
Prod_Revolution.prototype.setPass_word = function(pass_word){
	this.pass_word = pass_word;
};
Prod_Revolution.prototype.getPass_word = function(){
	return this.pass_word;
};
Prod_Revolution.prototype.setPay_money = function(pay_money){
	this.pay_money = pay_money;
};
Prod_Revolution.prototype.getPay_money = function(){
	return this.pay_money;
};
Prod_Revolution.prototype.setOp_note = function(op_note){
	this.op_note = op_note;
};
Prod_Revolution.prototype.getOp_note = function(){
	return this.op_note;
};
Prod_Revolution.prototype.setIpAddr = function(ipAddr){
	this.ipAddr = ipAddr;
};
Prod_Revolution.prototype.getIpAddr = function(){
	return this.ipAddr;
};
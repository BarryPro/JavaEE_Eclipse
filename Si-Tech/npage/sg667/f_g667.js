function jqk (){};
jqk.prototype.setInput=function(input)
{
	this.input=input;	
}
jqk.prototype.getInput=function()
{
	return this.input;	
}

function input()
{
	this.ProdInfoAddLen 	= 0;
	this.ProdInfoAdd 		= [];	
	
	this.ProdInfoDelLen 	= 0;
	this.ProdInfoDel 		= [];		
};

input.prototype.getProdInfoAdd = function(i)
{ 
	 return this.ProdInfoAdd[i];
};
input.prototype.setProdInfoAdd = function(ProdInfoAdd){
	this.ProdInfoAdd[this.ProdInfoAddLen++] = ProdInfoAdd;
};

input.prototype.getProdInfoDel = function(i)
{ 
	 return this.ProdInfoDel[i];
};
input.prototype.setProdInfoDel = function(ProdInfoDel){
	this.ProdInfoDel[this.ProdInfoDelLen++] = ProdInfoDel;
};

input.prototype.setOrgCode             =function(OrgCode             ){ this.OrgCode             =OrgCode         ;};
input.prototype.setIpAddress           =function(IpAddress           ){ this.IpAddress           =IpAddress       ;};
input.prototype.setOpNote              =function(OpNote              ){ this.OpNote              =OpNote          ;};
input.prototype.setOrgId               =function(OrgId               ){ this.OrgId               =OrgId           ;};
input.prototype.setBelongCode          =function(BelongCode          ){ this.BelongCode          =BelongCode      ;};
input.prototype.setGroupId             =function(GroupId             ){ this.GroupId             =GroupId         ;};
input.prototype.setIdIccid             =function(IdIccid             ){ this.IdIccid             =IdIccid         ;};
input.prototype.setUnitId              =function(UnitId              ){ this.UnitId              =UnitId          ;};
input.prototype.setCustomerNumber      =function(CustomerNumber      ){ this.CustomerNumber      =CustomerNumber  ;};
input.prototype.setIdNo                =function(IdNo                ){ this.IdNo                =IdNo            ;};
input.prototype.setCustName            =function(CustName            ){ this.CustName            =CustName        ;};
input.prototype.setUserNo              =function(UserNo              ){ this.UserNo              =UserNo          ;};
input.prototype.setProdInstID          =function(ProdInstID          ){ this.ProdInstID          =ProdInstID      ;};
input.prototype.setSubsID              =function(SubsID              ){ this.SubsID              =SubsID          ;};
input.prototype.setOfferId             =function(OfferId             ){ this.OfferId             =OfferId         ;};
input.prototype.setProdID              =function(ProdID              ){ this.ProdID              =ProdID          ;};
input.prototype.setOldOfferId          =function(OldOfferId          ){ this.OldOfferId          =OldOfferId      ;};
input.prototype.setOldProdID           =function(OldProdID           ){ this.OldProdID           =OldProdID       ;};
           
input.prototype.getOrgCode             =function(){ return this.OrgCode       ;};
input.prototype.getIpAddress           =function(){ return this.IpAddress     ;};
input.prototype.getOpNote              =function(){ return this.OpNote        ;};
input.prototype.getOrgId               =function(){ return this.OrgId         ;};
input.prototype.getBelongCode          =function(){ return this.BelongCode    ;};
input.prototype.getGroupId             =function(){ return this.GroupId       ;};
input.prototype.getIdIccid             =function(){ return this.IdIccid       ;};
input.prototype.getUnitId              =function(){ return this.UnitId        ;};
input.prototype.getCustomerNumber      =function(){ return this.CustomerNumber;};
input.prototype.getIdNo                =function(){ return this.IdNo          ;};
input.prototype.getCustName            =function(){ return this.CustName      ;};
input.prototype.getUserNo              =function(){ return this.UserNo        ;};
input.prototype.getProdInstID          =function(){ return this.ProdInstID    ;};
input.prototype.getSubsID              =function(){ return this.SubsID        ;};
input.prototype.getOfferId             =function(){ return this.OfferId       ;};
input.prototype.getProdID              =function(){ return this.ProdID        ;};

function ProdInfoAdd()
{
	this.ProdAttrInfoLen 	= 0;
	this.ProdAttrInfo	 	= [];
	this.ProdServiceAttrInfoLen 	= 0;
	this.ProdServiceAttrInfo	 	= [];
};
ProdInfoAdd.prototype.getProdServiceAttrInfo = function(i)
{ 
	 return this.ProdServiceAttrInfo[i];
};
ProdInfoAdd.prototype.setProdServiceAttrInfo = function(ProdServiceAttrInfo){
	this.ProdServiceAttrInfo[this.ProdServiceAttrInfoLen++] = ProdServiceAttrInfo;
};

ProdInfoAdd.prototype.getProdAttrInfo = function(i)
{ 
	 return this.ProdAttrInfo[i];
};
ProdInfoAdd.prototype.setProdAttrInfo = function(ProdAttrInfo){
	this.ProdAttrInfo[this.ProdAttrInfoLen++] = ProdAttrInfo;
};

ProdInfoAdd.prototype.setOfferId             =function(OfferId             ){ this.OfferId             =OfferId       ;};
ProdInfoAdd.prototype.setProdID              =function(ProdID              ){ this.ProdID              =ProdID        ;};
ProdInfoAdd.prototype.setPkgProdID           =function(PkgProdID           ){ this.PkgProdID           =PkgProdID     ;};
ProdInfoAdd.prototype.setProdInstID          =function(ProdInstID          ){ this.ProdInstID          =ProdInstID    ;};

ProdInfoAdd.prototype.getOfferId             =function(){ return this.OfferId    ;};
ProdInfoAdd.prototype.getProdID              =function(){ return this.ProdID     ;};
ProdInfoAdd.prototype.getPkgProdID           =function(){ return this.PkgProdID  ;};
ProdInfoAdd.prototype.getProdInstID          =function(){ return this.ProdInstID ;};

function ProdInfoDel()
{
	this.ProdAttrInfoLen 	= 0;
	this.ProdAttrInfo	 	= [];
	this.ProdServiceAttrInfoLen 	= 0;
	this.ProdServiceAttrInfo	 	= [];
}
ProdInfoDel.prototype.getProdAttrInfo = function(i)
{ 
	 return this.ProdAttrInfo[i];
};
ProdInfoDel.prototype.setProdAttrInfo = function(ProdAttrInfo){
	this.ProdAttrInfo[this.ProdAttrInfoLen++] = ProdAttrInfo;
};

ProdInfoDel.prototype.getProdServiceAttrInfo = function(i)
{ 
	 return this.ProdServiceAttrInfo[i];
};
ProdInfoDel.prototype.setProdServiceAttrInfo = function(ProdServiceAttrInfo){
	this.ProdServiceAttrInfo[this.ProdServiceAttrInfoLen++] = ProdServiceAttrInfo;
};
ProdInfoDel.prototype.setOfferId             =function(OfferId             ){ this.OfferId             =OfferId       ;};
ProdInfoDel.prototype.setProdID              =function(ProdID              ){ this.ProdID              =ProdID        ;};
ProdInfoDel.prototype.setPkgProdID           =function(PkgProdID           ){ this.PkgProdID           =PkgProdID     ;};
ProdInfoDel.prototype.setProdInstID          =function(ProdInstID          ){ this.ProdInstID          =ProdInstID    ;};
ProdInfoDel.prototype.setOpType              =function(OpType              ){ this.OpType              =OpType        ;};


ProdInfoDel.prototype.getOfferId             =function(){ return this.OfferId    ;};
ProdInfoDel.prototype.getProdID              =function(){ return this.ProdID     ;};
ProdInfoDel.prototype.getPkgProdID           =function(){ return this.PkgProdID  ;};
ProdInfoDel.prototype.getProdInstID          =function(){ return this.ProdInstID ;};
ProdInfoDel.prototype.getOpType              =function(){ return this.OpType     ;};


function ProdAttrInfo(){};
ProdAttrInfo.prototype.setServiceID             =function(ServiceID             ){ this.ServiceID             =ServiceID       ;};
ProdAttrInfo.prototype.setAttrKey              =function(AttrKey              ){ this.AttrKey              =AttrKey        ;};
ProdAttrInfo.prototype.setAttrValue           =function(AttrValue           ){ this.AttrValue           =AttrValue     ;};

ProdAttrInfo.prototype.getAttrValue             =function(){ return this.AttrValue    ;};
ProdAttrInfo.prototype.getAttrKey              =function(){ return this.AttrKey     ;};
ProdAttrInfo.prototype.getAttrValue           =function(){ return this.AttrValue  ;};

function ProdServiceAttrInfo(){};
ProdServiceAttrInfo.prototype.setServiceID             =function(ServiceID             ){ this.ServiceID             =ServiceID       ;};
ProdServiceAttrInfo.prototype.setAttrKey              =function(AttrKey              ){ this.AttrKey              =AttrKey        ;};
ProdServiceAttrInfo.prototype.setAttrValue           =function(AttrValue           ){ this.AttrValue           =AttrValue     ;};

ProdServiceAttrInfo.prototype.getAttrValue             =function(){ return this.AttrValue    ;};
ProdServiceAttrInfo.prototype.getAttrKey              =function(){ return this.AttrKey     ;};
ProdServiceAttrInfo.prototype.getAttrValue           =function(){ return this.AttrValue  ;};

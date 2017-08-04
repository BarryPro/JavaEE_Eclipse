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
	this.MemInfoLen 	= 0;
	this.MemInfo 		= [];	
};

input.prototype.getMemInfo = function(i)
{ 
	 return this.MemInfo[i];
};
input.prototype.setMemInfo = function(MemInfo){
	this.MemInfo[this.MemInfoLen++] = MemInfo;
};

input.prototype.setOrgCode                          =function (OrgCode                         ){ this.OrgCode                          =OrgCode           ;};              
input.prototype.setIpAddress                        =function (IpAddress                       ){ this.IpAddress                        =IpAddress         ;};              
input.prototype.setOpNote                           =function (OpNote                          ){ this.OpNote                           =OpNote            ;};              
input.prototype.setOrgId                            =function (OrgId                           ){ this.OrgId                            =OrgId             ;};              
input.prototype.setBelongCode                       =function (BelongCode                      ){ this.BelongCode                       =BelongCode        ;};              
input.prototype.setGroupId                          =function (GroupId                         ){ this.GroupId                          =GroupId           ;};              
input.prototype.setIdIccid                          =function (IdIccid                         ){ this.IdIccid                          =IdIccid           ;};              
input.prototype.setCustomerNumber                   =function (CustomerNumber                  ){ this.CustomerNumber                   =CustomerNumber    ;};              
input.prototype.setUnitId                           =function (UnitId                          ){ this.UnitId                           =UnitId            ;};              
input.prototype.setECProdInstID                     =function (ECProdInstID                    ){ this.ECProdInstID                     =ECProdInstID      ;};              
input.prototype.setECSubsID                         =function (ECSubsID                        ){ this.ECSubsID                         =ECSubsID          ;};               

input.prototype.getOrgCode                         =function(){ return this.OrgCode             ;};            
input.prototype.getIpAddress                       =function(){ return this.IpAddress           ;};            
input.prototype.getOpNote                          =function(){ return this.OpNote              ;};            
input.prototype.getOrgId                           =function(){ return this.OrgId               ;};            
input.prototype.getBelongCode                      =function(){ return this.BelongCode          ;};            
input.prototype.getGroupId                         =function(){ return this.GroupId             ;};            
input.prototype.getIdIccid                         =function(){ return this.IdIccid             ;};            
input.prototype.getCustomerNumber                  =function(){ return this.CustomerNumber      ;};            
input.prototype.getUnitId                          =function(){ return this.UnitId              ;};            
input.prototype.getECProdInstID                    =function(){ return this.ECProdInstID        ;};            
input.prototype.getECSubsID                        =function(){ return this.ECSubsID            ;};            

function MemInfo()
{
	this.ProdInfoAddLen 	= 0;
	this.ProdInfoAdd 		= [];	
	
	this.ProdInfoDelLen 	= 0;
	this.ProdInfoDel 		= [];			
};
MemInfo.prototype.getProdInfoAdd = function(i)
{ 
	 return this.ProdInfoAdd[i];
};
MemInfo.prototype.setProdInfoAdd = function(ProdInfoAdd){
	this.ProdInfoAdd[this.ProdInfoAddLen++] = ProdInfoAdd;
};

MemInfo.prototype.getProdInfoDel = function(i)
{ 
	 return this.ProdInfoDel[i];
};
MemInfo.prototype.setProdInfoDel = function(ProdInfoDel){
	this.ProdInfoDel[this.ProdInfoDelLen++] = ProdInfoDel;
};

MemInfo.prototype.setPhoneNo             =function(PhoneNo             ){ this.PhoneNo             =PhoneNo             ;};
MemInfo.prototype.setSubsID              =function(SubsID              ){ this.SubsID              =SubsID              ;};
MemInfo.prototype.setOfferId             =function(OfferId             ){ this.OfferId             =OfferId             ;};
MemInfo.prototype.setProdID              =function(ProdID              ){ this.ProdID              =ProdID              ;};
MemInfo.prototype.setProdInstID          =function(ProdInstID          ){ this.ProdInstID          =ProdInstID          ;};
MemInfo.prototype.setProvinceID          =function(ProvinceID          ){ this.ProvinceID          =ProvinceID          ;};

MemInfo.prototype.getPhoneNo             =function(){ return this.PhoneNo             ;};
MemInfo.prototype.getSubsID              =function(){ return this.SubsID              ;};
MemInfo.prototype.getOfferId             =function(){ return this.OfferId             ;};
MemInfo.prototype.getProdID              =function(){ return this.ProdID              ;};
MemInfo.prototype.getProdInstID          =function(){ return this.ProdInstID          ;};
MemInfo.prototype.getProvinceID          =function(){ return this.ProvinceID          ;};

function ProdInfoAdd()
{
	this.ProdAttrInfoLen 	= 0;
	this.ProdAttrInfo	 	= [];
	this.ProdServiceAttrInfoLen 	= 0;
	this.ProdServiceAttrInfo	 	= [];
};
ProdInfoAdd.prototype.getProdAttrInfo = function(i)
{ 
	 return this.ProdAttrInfo[i];
};
ProdInfoAdd.prototype.setProdAttrInfo = function(ProdAttrInfo){
	this.ProdAttrInfo[this.ProdAttrInfoLen++] = ProdAttrInfo;
};

ProdInfoAdd.prototype.getProdServiceAttrInfo = function(i)
{ 
	 return this.ProdServiceAttrInfo[i];
};
ProdInfoAdd.prototype.setProdServiceAttrInfo = function(ProdServiceAttrInfo){
	this.ProdServiceAttrInfo[this.ProdServiceAttrInfoLen++] = ProdServiceAttrInfo;
};
ProdInfoAdd.prototype.setProdInstID             =function(ProdInstID             ){ this.ProdInstID             =ProdInstID             ;};
ProdInfoAdd.prototype.setOfferId             =function(OfferId             ){ this.OfferId             =OfferId             ;};
ProdInfoAdd.prototype.setSubsID          =function(SubsID          ){ this.SubsID          =SubsID          ;};
ProdInfoAdd.prototype.setPkgProdID          =function(PkgProdID          ){ this.PkgProdID          =PkgProdID          ;};
ProdInfoAdd.prototype.setProdID          =function(ProdID           ){ this.ProdID           =ProdID           ;};

ProdInfoAdd.prototype.getProdInstID             =function(){ return this.ProdInstID             ;};
ProdInfoAdd.prototype.getSubsID              =function(){ return this.SubsID              ;};
ProdInfoAdd.prototype.getOfferId             =function(){ return this.OfferId             ;};
ProdInfoAdd.prototype.getPkgProdID          =function(){ return this.PkgProdID          ;};
ProdInfoAdd.prototype.getProdID          =function(){ return this.ProdID          ;};

function ProdInfoDel()
{
	this.ProdAttrInfoLen 	= 0;
	this.ProdAttrInfo	 	= [];		
};
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
ProdInfoDel.prototype.setProdInstID             =function(ProdInstID             ){ this.ProdInstID             =ProdInstID             ;};
ProdInfoDel.prototype.setOfferId             =function(OfferId             ){ this.OfferId             =OfferId             ;};
ProdInfoDel.prototype.setSubsID          =function(SubsID          ){ this.SubsID          =SubsID          ;};
ProdInfoDel.prototype.setPkgProdID          =function(PkgProdID          ){ this.PkgProdID          =PkgProdID          ;};
ProdInfoDel.prototype.setProdID          =function(ProdID           ){ this.ProdID           =ProdID           ;};
ProdInfoDel.prototype.setOpType              =function(OpType              ){ this.OpType              =OpType        ;};


ProdInfoDel.prototype.getProdInstID             =function(){ return this.ProdInstID             ;};
ProdInfoDel.prototype.getSubsID              =function(){ return this.SubsID              ;};
ProdInfoDel.prototype.getOfferId             =function(){ return this.OfferId             ;};
ProdInfoDel.prototype.getPkgProdID          =function(){ return this.PkgProdID          ;};
ProdInfoDel.prototype.getProdID          =function(){ return this.ProdID     ;};
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



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
	this.ProdInfoLen 	= 0;
	this.ProdInfo 		= [];	
	
	this.OtherInfoLen 	= 0;
	this.OtherInfo 		= [];	
};

input.prototype.getProdInfo = function(i)
{ 
	 return this.ProdInfo[i];
};
input.prototype.setProdInfo = function(ProdInfo){
	this.ProdInfo[this.ProdInfoLen++] = ProdInfo;
};

input.prototype.getOtherInfo = function(i)
{ 
	 return this.OtherInfo[i];
};
input.prototype.setOtherInfo = function(OtherInfo){
	this.OtherInfo[this.OtherInfoLen++] = OtherInfo;
};


jqk.prototype.setIpAddress      =function(  IpAddress     ){   this.IpAddress        =IpAddress        ;};
jqk.prototype.setOrgId          =function(  OrgId         ){   this.OrgId            =OrgId            ;};
jqk.prototype.setIdIccid        =function(  IdIccid       ){   this.IdIccid          =IdIccid          ;};
jqk.prototype.setCustomerNumber =function(  CustomerNumber){   this.CustomerNumber   =CustomerNumber   ;};
jqk.prototype.setUnitId         =function(  UnitId        ){   this.UnitId           =UnitId           ;};
jqk.prototype.setECProdInstID   =function(  ECProdInstID  ){   this.ECProdInstID     =ECProdInstID     ;};
jqk.prototype.setECSubsID       =function(  ECSubsID      ){   this.ECSubsID         =ECSubsID         ;};
jqk.prototype.setSa             =function(SA                  ){ this.SA                  =SA                  ;};
jqk.prototype.setMemDiscount    =function(MemDiscount         ){ this.MemDiscount         =MemDiscount                  ;};
jqk.prototype.setPayFlag        =function(  PayFlag      ){   this.PayFlag         =PayFlag         ;};
                                                                    
jqk.prototype.getIpAddress        =function() { return this.IpAddress      ;};  
jqk.prototype.getIdIccid          =function() { return this.IdIccid        ;};  
jqk.prototype.getCustomerNumber   =function() { return this.CustomerNumber ;};  
jqk.prototype.getUnitId           =function() { return this.UnitId         ;};  
jqk.prototype.getECProdInstID     =function() { return this.ECProdInstID   ;};  
jqk.prototype.getECSubsID         =function() { return this.ECSubsID       ;};  
jqk.prototype.getSa               =function(){ return this.SA                   ;};
jqk.prototype.getMemDiscount      =function(){ return this.MemDiscount                   ;};
jqk.prototype.getPayFlag             =function(){ return this.PayFlag                   ;};





function ProdInfo()
{
	this.ProdAttrInfoLen 	= 0;
	this.ProdAttrInfo	 	= [];
	this.ProdServiceAttrInfoLen	=0;
	this.ProdServiceAttrInfo    =[];
};

ProdInfo.prototype.getProdAttrInfo = function(i)
{ 
	 return this.ProdAttrInfo[i];
};
ProdInfo.prototype.setProdAttrInfo = function(ProdAttrInfo){
	this.ProdAttrInfo[this.ProdAttrInfoLen++] = ProdAttrInfo;
};

ProdInfo.prototype.getProdServiceAttrInfo = function(i)
{ 
	 return this.ProdServiceAttrInfo[i];
};
ProdInfo.prototype.setProdServiceAttrInfo = function(ProdServiceAttrInfo){
	this.ProdServiceAttrInfo[this.ProdServiceAttrInfoLen++] = ProdServiceAttrInfo;
};

ProdInfo.prototype.setOfferId          =function(OfferId         ){this.OfferId          =OfferId  ;};         
ProdInfo.prototype.setProdID           =function(ProdID          ){this.ProdID           =ProdID  ;};         
ProdInfo.prototype.setPkgProdID        =function(PkgProdID       ){this.PkgProdID        =PkgProdID ;};         
ProdInfo.prototype.setProdInstID       =function(ProdInstID      ){this.ProdInstID       =ProdInstID;};          

ProdInfo.prototype.getOfferId          =function(){return this.OfferId    ;};       
ProdInfo.prototype.getProdID           =function(){return this.ProdID    ;};       
ProdInfo.prototype.getPkgProdID        =function(){return this.PkgProdID   ;};       
ProdInfo.prototype.getProdInstID       =function(){return this.ProdInstID  ;};       

function ProdAttrInfo(){};
ProdAttrInfo.prototype.setServiceID 	=function (ServiceID 		){this.ServiceID 	=ServiceID 	 ;};
ProdAttrInfo.prototype.setAttrKey 		=function (AttrKey 			){this.AttrKey 		=AttrKey 	 ;};
ProdAttrInfo.prototype.setAttrValue 	=function (AttrValue 		){this.AttrValue 	=AttrValue 	 ;};

ProdAttrInfo.prototype.getServiceID 	=function(){ return this.ServiceID 	;};
ProdAttrInfo.prototype.getAttrKey 		=function(){ return this.AttrKey 	;};
ProdAttrInfo.prototype.getAttrValue 	=function(){ return this.AttrValue 	;};

function ProdServiceAttrInfo(){};
ProdServiceAttrInfo.prototype.setServiceID 	=function (ServiceID 		){this.ServiceID 	=ServiceID 	 ;};
ProdServiceAttrInfo.prototype.setAttrKey 		=function (AttrKey 			){this.AttrKey 		=AttrKey 	 ;};
ProdServiceAttrInfo.prototype.setAttrValue 	=function (AttrValue 		){this.AttrValue 	=AttrValue 	 ;};

ProdServiceAttrInfo.prototype.getServiceID 	=function(){ return this.ServiceID 	;};
ProdServiceAttrInfo.prototype.getAttrKey 		=function(){ return this.AttrKey 	;};
ProdServiceAttrInfo.prototype.getAttrValue 	=function(){ return this.AttrValue 	;};

function OtherInfo(){};                    
OtherInfo.prototype.setInfoCode 	=function (InfoCode 		){this.InfoCode 	=InfoCode 	 ;};
OtherInfo.prototype.setInfoValue 	=function (InfoValue 			){this.InfoValue 		=InfoValue 	 ;};

OtherInfo.prototype.getInfoCode 	=function(){ return this.InfoCode 	;};
OtherInfo.prototype.getInfoValue	=function(){ return this.InfoValue 	;};
                   
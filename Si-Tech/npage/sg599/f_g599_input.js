/*
 * 功能: 集团物联网业务开通 
 * 版本: 1.0
 * 日期: 2013/4/19 9:31:46
 * 作者: zhangyan
 * 版权: si-tech
 * update:
*/

function ProdAttrInfo(){};
ProdAttrInfo.prototype.setServiceID=function(ServiceID)
{
	this.ServiceID=ServiceID;
};

ProdAttrInfo.prototype.getServiceID=function()
{
	return this.ServiceID;
};

ProdAttrInfo.prototype.setAttrKey=function(AttrKey)
{
	this.AttrKey=AttrKey;
};

ProdAttrInfo.prototype.getAttrKey=function()
{
	return this.AttrKey;
};
ProdAttrInfo.prototype.setAttrValue=function(AttrValue)
{
	this.AttrValue=AttrValue;
};

ProdAttrInfo.prototype.getAttrValue=function()
{
	return this.AttrValue;
};


function ProdServiceAttrInfo(){};
ProdServiceAttrInfo.prototype.setServiceID=function(ServiceID)
{
	this.ServiceID=ServiceID;
};

ProdServiceAttrInfo.prototype.getServiceID=function()
{
	return this.ServiceID;
};

ProdServiceAttrInfo.prototype.setAttrKey=function(AttrKey)
{
	this.AttrKey=AttrKey;
};

ProdServiceAttrInfo.prototype.getAttrKey=function()
{
	return this.AttrKey;
};
ProdServiceAttrInfo.prototype.setAttrValue=function(AttrValue)
{
	this.AttrValue=AttrValue;
};

ProdServiceAttrInfo.prototype.getAttrValue=function()
{
	return this.AttrValue;
};


function ProdInfo()
{
	this.ProdAttrInfoLen	=0;
	this.ProdAttrInfo		=[];
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



ProdInfo.prototype.setOfferId=function(OfferId)
{
	this.OfferId=OfferId;
};
ProdInfo.prototype.setOfferName=function(OfferName)
{
	this.OfferName=OfferName;
};
ProdInfo.prototype.setProdID=function(ProdID)
{
	this.ProdID=ProdID;
};
ProdInfo.prototype.setPkgProdID=function(PkgProdID)
{
	this.PkgProdID=PkgProdID;
};
ProdInfo.prototype.setProdInstID=function(ProdInstID)
{
	this.ProdInstID=ProdInstID;
};
ProdInfo.prototype.setSubsID=function(SubsID)
{
	this.SubsID=SubsID;
};

ProdInfo.prototype.getOfferId=function()
{
	return this.OfferId;
};
ProdInfo.prototype.getOfferName=function()
{
	return this.OfferName;
};
ProdInfo.prototype.getProdID=function()
{
	return this.ProdID;
};
ProdInfo.prototype.getPkgProdID=function()
{
	return this.PkgProdID;
};
ProdInfo.prototype.getProdInstID=function()
{
	return this.ProdInstID;
};
ProdInfo.prototype.getSubsID=function()
{
	return this.SubsID;
};

function ECBaseServCode(){};

ECBaseServCode.prototype.setBaseServCode = function(BaseServCode)
{
	this.BaseServCode = BaseServCode;
};
ECBaseServCode.prototype.setBaseServCodeProp = function(BaseServCodeProp)
{
	this.BaseServCodeProp = BaseServCodeProp;
};
ECBaseServCode.prototype.setBizServMode = function(BizServMode)
{
	this.BizServMode = BizServMode;
};

ECBaseServCode.prototype.getBaseServCode = function()
{
	return this.BaseServCode;
};
ECBaseServCode.prototype.getBaseServCodeProp = function()
{
	return this.BaseServCodeProp;
};          
ECBaseServCode.prototype.getBizServMode = function()
{
	return this.BizServMode;
};

function MgrInfo(){};

MgrInfo.prototype.setMgrID = function(MgrID)
{
	this.MgrID = MgrID;
};
MgrInfo.prototype.setMgrName = function(MgrName)
{
	this.MgrName = MgrName;
};
MgrInfo.prototype.setMgrMSISDN = function(MgrMSISDN)
{
	this.MgrMSISDN = MgrMSISDN;
};

MgrInfo.prototype.getMgrName = function()
{
	return this.MgrName;
};
MgrInfo.prototype.getInfoCode = function()
{
	return this.InfoCode;
};          
MgrInfo.prototype.getMgrMSISDN = function()
{
	return this.MgrMSISDN;
};

function OtherInfo(){};

OtherInfo.prototype.setInfoCode = function(InfoCode)
{
	this.InfoCode = InfoCode;
};
OtherInfo.prototype.setInfoValue = function(InfoValue)
{
	this.InfoValue = InfoValue;
};	

OtherInfo.prototype.getInfoCode = function(){
	return this.InfoCode;
};
OtherInfo.prototype.getInfoValue = function()
{
	return this.InfoValue;
};

function jqk (){};
jqk.prototype.setInput=function(input)
{
	this.input=input;	
}
jqk.prototype.getInput=function()
{
	return this.input;	
}

function input ()
{
	this.ProdInfoLen 	= 0;
	this.ProdInfo 		= [];	
	
	this.ECBaseServCodeLen 	= 0;
	this.ECBaseServCode	 	= [];		
	
	this.MgrInfoLen 	= 0;
	this.MgrInfo 		= [];		
	
	this.OtherInfoLen 	= 0;
	this.OtherInfo 		= [];	
};

input.prototype.setGroupId=function(GroupId)
{
	this.GroupId=GroupId
};
input.prototype.getGroupId = function(){
	return this.GroupId;
};        	
input.prototype.setBelongCode=function(BelongCode)
{
	this.BelongCode=BelongCode
};
input.prototype.getBelongCode = function(){
	return this.BelongCode;
};     	
input.prototype.setOrgId=function(OrgId)
{
	this.OrgId=OrgId
};
input.prototype.getOrgId = function(){
	return this.OrgId;
};    	
input.prototype.setOpNote=function(OpNote)
{
	this.OpNote=OpNote
};
input.prototype.getOpNote = function(){
	return this.OpNote;
};    	
input.prototype.setIpAddress=function(IpAddress)
{
	this.IpAddress=IpAddress
};
input.prototype.getIpAddress = function(){
	return this.IpAddress;
};
    	
input.prototype.setOrgCode=function(OrgCode)
{
	this.OrgCode=OrgCode
};
input.prototype.getOrgCode = function(){
	return this.OrgCode;
};

input.prototype.getOtherInfo = function(i)
{ 
	 return this.OtherInfo[i];
};
input.prototype.setOtherInfo = function(OtherInfo){
	this.OtherInfo[this.OtherInfoLen++] = OtherInfo;
};
input.prototype.getMgrInfo = function(i)
{ 
	 return this.MgrInfo[i];
};
input.prototype.setMgrInfo = function(MgrInfo){
	this.MgrInfo[this.MgrInfoLen++] = MgrInfo;
};
input.prototype.getECBaseServCode = function(i)
{ 
	 return this.ECBaseServCode[i];
};
input.prototype.setECBaseServCode = function(ECBaseServCode){
	this.ECBaseServCode[this.ECBaseServCodeLen++] = ECBaseServCode;
};
input.prototype.getProdInfo = function(i)
{ 
	 return this.ProdInfo[i];
};
input.prototype.setProdInfo = function(ProdInfo){
	this.ProdInfo[this.ProdInfoLen++] = ProdInfo;
};
/*input set*/
input.prototype.setIdIccid = function(IdIccid)
{
	this.IdIccid = IdIccid;
};
input.prototype.setCustId=function(CustId)
{
	this.CustId=CustId;
};
input.prototype.setUnitId=function(UnitId)
{
	this.UnitId=UnitId
};
input.prototype.setCustomerNumber=function(CustomerNumber)
{
	this.CustomerNumber=CustomerNumber
};
input.prototype.setCustName=function(CustName)
{
	this.CustName=CustName
};
input.prototype.setSrvCode=function(SrvCode)
{
	this.SrvCode=SrvCode
};
input.prototype.setOfferId=function(OfferId)
{
	this.OfferId=OfferId
};
input.prototype.setProdID=function(ProdID)
{
	this.ProdID=ProdID
};
input.prototype.setProdInstID=function(ProdInstID)
{
	this.ProdInstID=ProdInstID
};
input.prototype.setSubsID=function(SubsID)
{
	this.SubsID=SubsID
};
input.prototype.setBizServCode=function(BizServCode)
{
	this.BizServCode=BizServCode
};
input.prototype.setAuthMode=function(AuthMode)
{
	this.AuthMode=AuthMode
};
input.prototype.setIndustryID=function(IndustryID)
{
	this.IndustryID=IndustryID
};
input.prototype.setISTextSign=function(ISTextSign)
{
	this.ISTextSign=ISTextSign
};
input.prototype.setDefaultSignLang=function(DefaultSignLang)
{
	this.DefaultSignLang=DefaultSignLang
};
input.prototype.setTextSignEn=function(TextSignEn)
{
	this.TextSignEn=TextSignEn
};
input.prototype.setTextSignZh=function(TextSignZh)
{
	this.TextSignZh=TextSignZh
};

input.prototype.setIdNo=function(IdNo)
{
	this.IdNo=IdNo
};
input.prototype.getIdNo = function(){
	return this.IdNo;
};

/*input get*/
input.prototype.getIdIccid = function(){
	return this.IdIccid;
};
input.prototype.getCustId = function()
{
	return this.CustId;
};
input.prototype.getUnitId = function()
{
	return this.UnitId;
};
input.prototype.getCustomerNumber = function()
{
	return this.CustomerNumber;
};
input.prototype.getCustName = function()
{
	return this.CustName;
};
input.prototype.getSrvCode = function()
{
	return this.SrvCode;
};
input.prototype.getOfferId = function()
{
	return this.OfferId;
};
input.prototype.getProdID = function()
{
	return this.ProdID;
};
input.prototype.getProdInstID = function()
{
	return this.ProdInstID;
};
input.prototype.getSubsID = function()
{
	return this.SubsID;
};
input.prototype.getBizServCode = function()
{
	return this.BizServCode;
};
input.prototype.getAuthMode = function()
{
	return this.AuthMode;
};
input.prototype.getIndustryID = function()
{
	return this.IndustryID;
};
input.prototype.getISTextSign = function()
{
	return this.ISTextSign;
};
input.prototype.getDefaultSignLang = function()
{
	return this.DefaultSignLang;
};
input.prototype.getTextSignEn = function()
{
	return this.TextSignEn;
};
input.prototype.getTextSignZh = function()
{
	return this.TextSignZh;
};

input.prototype.setSA=function(SA)
{
	this.SA=SA;
};
input.prototype.getSA = function()
{
	return this.SA;
};
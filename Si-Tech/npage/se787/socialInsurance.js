/*
 * 功能: 社保通
 * 版本: 1.0
 * 日期: 2012/4/24 20:14:45
 * 作者: zhangyan
 * 版权: si-tech
 * update:
*/
	    
/*绑定人信息*/
function bind(){};
bind.prototype.setGid=function(gid){
	this.gid=gid;
}
bind.prototype.getGid=function(){
	return this.gid;
}

bind.prototype.setNid=function(nid){
	this.nid=nid;
}
bind.prototype.getNid=function(){
	return this.nid;
}
bind.prototype.setName=function(name){
	this.name=name;
}
bind.prototype.getName=function(){
	return this.name;
}
/*基本信息*/
function base(){};

base.prototype.setAddr=function(addr){
	this.addr=addr;
}
base.prototype.getAddr=function(){
	return this.addr;
}

base.prototype.setBgid=function(bgid){
	this.bgid=bgid;
}
base.prototype.getBgid=function(){
	return this.bgid;
}

base.prototype.setBname=function(bname){
	this.bname=bname;
}
base.prototype.getBname=function(){
	return this.bname;
}

base.prototype.setDeviceId=function(deviceId){
	this.deviceId=deviceId;
}
base.prototype.getDeviceId=function(){
	return this.deviceId;
}
base.prototype.setMobile=function(mobile){
	this.mobile=mobile;
}
base.prototype.getMobile=function(){
	return this.mobile;
}


/*社保信息*/
function siList(){
	this.bindLength =0;
	this.bind		=[];	
};

siList.prototype.setBase=function(base){
	this.base=base	;
}

siList.prototype.getBase=function(){
	return this.base;	
}
siList.prototype.setBind=function(bind){
	this.bind[this.bindLength++]=bind;	
}
siList.prototype.getBind=function(){
	return this.bind[i];	
}
/*******************************************************
 * 文件名： ajaxService.js
 * 修改人： 张无溢
 * 修改时间：2008-09-20
 * 修改内容：新增,用于跨域Ajax访问
 ********************************************************/
AJAXService=function(){
 
}

/*
*进行跨域的异步操作
*@param objet service 服务的地址
*@param String methodName 服务的方法名
*@param Object param 方法参数，可以是一个对象。
*@path  String path 跨域的dwr地址 如：http://10.204.16.104:7001/sitechcallcenter/dwr
*/

AJAXService.prototype.executeRemoteService=function(service,methodName,param,path){
 dwr.engine.setActiveReverseAjax(true);
 dwr.engine.setRpcType(dwr.engine.ScriptTag);
 service._path = path
 var method = service[methodName];
 var data=null;
 try{
   if(param==null){
     method(function(_data){data=_data; alert(_data)});
   }else{
     method(param,function(_data){data=_data;alert(_data)});
   }
 }finally{
  
 }
 return data
}

/*
*进行本地的ajax访问，用dwr方式
*@param objet service 服务的地址
*@param String methodName 服务的方法名
*@param Object param 方法参数，可以是一个对象。
*@param boolean asyn 同步异步标示 如果true表示异步，如果是false表示同步
*/
AJAXService.prototype.executeLocalService=function(service,methodName,param,asyn){
 dwr.engine.setActiveReverseAjax(true);
 var method = service[methodName];
 var data=null;
 if(!asyn){
  dwr.engine.setAsync(false);
 }
 try{
   if(param==null){
     method(function(_data){data=_data});
   }else{
     method(param,function(_data){data=_data});
   }
 }finally{
   dwr.engine.setAsync(true); 
 }
 return data
}

/*
*进行操作日志的录入。跨域操作。
*
*/

AJAXService.prototype.executeRemoteLog=function(op_code,login_no,ip_adr,call_id,path){
 commonService._path = path
 var method = commonService["saveLog"];
 var data=null;
 var param={}
 param.op_code=op_code;
 param.login_no=login_no;
 param.ip_adr=ip_adr;
 param.call_id=call_id;
 try{
   if(param==null){
     method(function(_data){data=_data;});
   }else{
     method(param,function(_data){data=_data;alert(_data)});
   }
 }finally{
  
 }
 return data
}

/*
进行操作日志的录入。本地操作。
*/
AJAXService.prototype.executeLocalLog=function(op_code,login_no,ip_adr,call_id){
 dwr.engine.setActiveReverseAjax(true);
 var method = commonService["saveLog"];
 var data=null;
 dwr.engine.setAsync(false);
 var param={}
 param.op_code=op_code;
 param.login_no=login_no;
 param.ip_adr=ip_adr;
 param.call_id=call_id;
 try{
   if(param==null){
     method(function(_data){data=_data});
   }else{
     method(param,function(_data){data=_data});
   }
 }finally{
   dwr.engine.setAsync(true); 
 }
 return data
}

/*******************************************************
 * �ļ����� ajaxService.js
 * �޸��ˣ� ������
 * �޸�ʱ�䣺2008-09-20
 * �޸����ݣ�����,���ڿ���Ajax����
 ********************************************************/
AJAXService=function(){
 
}

/*
*���п�����첽����
*@param objet service ����ĵ�ַ
*@param String methodName ����ķ�����
*@param Object param ����������������һ������
*@path  String path �����dwr��ַ �磺http://10.204.16.104:7001/sitechcallcenter/dwr
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
*���б��ص�ajax���ʣ���dwr��ʽ
*@param objet service ����ĵ�ַ
*@param String methodName ����ķ�����
*@param Object param ����������������һ������
*@param boolean asyn ͬ���첽��ʾ ���true��ʾ�첽�������false��ʾͬ��
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
*���в�����־��¼�롣���������
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
���в�����־��¼�롣���ز�����
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

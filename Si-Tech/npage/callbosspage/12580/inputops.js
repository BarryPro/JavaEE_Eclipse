
//页面手机号码验证
function f_check_mobile(value){      
	//chengh 验证移动手机号段
	var regu =/^[1]([3][4-9]{1}|59|58|50|57|51|52|88|47)[0-9]{8}$/;
	//var regu =/(^1(3\d|5[38950])\d{8}$)/;
  var re = new RegExp(regu);   
	if (re.test( value )) {   
		return true;
	}
	return false;      
}

//验证数字。用于预约服务时间间隔设置时间的验证
function isNumber(oNum) 
{ 
  if(!oNum) return false; 
  var strP=/^\d+(\.\d+)?$/; 
  if(!strP.test(oNum)) return false; 
  try{ 
  if(parseFloat(oNum)!=oNum) return false; 
  } 
  catch(ex) 
  { 
   return false; 
  } 
  return true; 
}

//判断时间是否不符合规则：如 19:20:19
function judagetime(vo)
{
    
    var reg = new RegExp("[0-1][\\d]:[0-5][\\d]:[0-5][\\d]|2[0-3]:[0-5][\\d]:[0-5][\\d]","ig");
    if(!reg.test(vo))
    {
        
        return false;
    }
    return true;
   
}
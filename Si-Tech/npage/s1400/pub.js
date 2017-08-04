function changeDateFormat(sDate)
{
		year = sDate.substring(0,4);
		month= sDate.substring(4,6);
		day= sDate.substring(6,8);
		
		return year+"-"+month+"-"+day;
	
}
function isValidTime(sDateTime)
{
	//时间格式为：YYYYMMDD HH:MM:SS
	var sTmp = "";
	var iYear = 0;
	var iMonth = 0;
	var iDay = 0;
	var iHour = 0;
	var iMinute = 0;
	var iSecond = 0;
	  
	  if ( (sDateTime.length > 17 ) ||
	       (sDateTime.length < 8)   ||
	       ( (sDateTime.length >= 9) && (sDateTime.length <= 12) ) ||
	       (sDateTime.length == 15) 
	     )
	  {
	    return -1;
	  }
	  
	  if (sDateTime.length > 8)
	  {
	    if (sDateTime.charAt(8) != ' ')
	    {
	      return -2;
	    }
	    if (sDateTime.charAt(11) != ':')
	    {
	      return -3;
	    }
	    if (sDateTime.length > 15)
	    {
	      if (sDateTime.charAt(14) != ':')
	      {
	        return -4;
	      }
	    }
	  }
	  
	  sTmp = sDateTime.substring(0,4);
	  if (isNaN(sTmp))
	  {
	    return -5;
	  }
	  iYear = parseInt(sTmp, 10);
	  
	  sTmp = sDateTime.substring(4,6);
	  if (isNaN(sTmp))
	  {
	    return -6;
	  }
	  iMonth = parseInt(sTmp, 10);
	  
	  sTmp = sDateTime.substring(6,8);
	  if (isNaN(sTmp))
	  {
	    return -7;
	  }
	  iDay = parseInt(sTmp, 10);
	  
	  sTmp = sDateTime.substring(9,11);
	  if (isNaN(sTmp))
	  {
	    return -8;
	  }
	  if (sTmp != "")
	    iHour = parseInt(sTmp, 10);
	  else
	    iHour = 0;
	  
	  sTmp = sDateTime.substring(12,14);
	  if (isNaN(sTmp) && sTmp != "")
	  {
	    return -9;
	  }
	  if (sTmp != "")
	    	iMinute = parseInt(sTmp, 10);
	  else
	    	iMinute = 0;
	  
	  sTmp = sDateTime.substring(15,17);
	  if (isNaN(sTmp) && sTmp != "")
	  {
	    	return -10;
	  }
	  if (sTmp != "")
	    	iSecond = parseInt(sTmp, 10);
	  else
	    	iSecond = 0;
	  
	  if (iYear < 1900)
	  {
	    	rdShowMessageDialog("年应大于1900年");
	    	return -11;
	  }
	
	  if (iMonth < 1 || iMonth > 12)
	  {
	    	rdShowMessageDialog("月应在1到12之间");
	    	return -12;
	  }
	
	  if ((iMonth == 1)||(iMonth == 3)||(iMonth == 5)||(iMonth == 7)||(iMonth == 8)||(iMonth == 10)||(iMonth == 12))
	  {
	    	if (iDay > 31) return -13;
	  }
	  else if (iMonth == 2)
	  {
		    if (iDay > 29) return -14;
		    if (iDay == 29)
		    {
		     	 //判断是否是闰年
		      	if (!((iYear % 4 == 0) && ((iYear % 100 != 0) || (iYear % 400 == 0))))
		      	{
		       		return -15;
		      	}
		    }
	  }
	  else
	  {
	    	if (iDay > 30) return -16;
	  }
	  
	  if (iHour < 0 || iHour > 23)
	  {
	    	return -17;
	  }
	  if (iMinute < 0 || iMinute > 59)
	  {
	    	return -18;
	  }
	  if (iSecond < 0 || iSecond > 59)
	  {
	    	return -19;
	  }
	  
	  return 0;
}

function isKeyNumberdot(ifdot) 
{       
    var s_keycode=(navigator.appname=="Netscape")?event.which:event.keyCode;
	if(ifdot==0)
		if(s_keycode>=48 && s_keycode<=57 )
			return true;
		else 
			return false;
    else
    {
		if((s_keycode>=48 && s_keycode<=57) || s_keycode==46)
		{
		      return true;
		}
		else if(s_keycode==45)
		{
		    rdShowMessageDialog('不允许输入负值,请重新输入!');
		    return false;
		}
		else
			  return false;
    }       
}
function isValidYYYYMM(sDateTime)
{
	//时间格式为：YYYYMM
	var sTmp = "";
	var iYear = 0;
	var iMonth = 0;
	var iDay = 0;
	var iHour = 0;
	var iMinute = 0;
	var iSecond = 0;
	  
	if ( (sDateTime.length > 6 ) || (sDateTime.length < 6) )
	{
		return -1;
	}
	  
	sTmp = sDateTime.substring(0,4);
	if (isNaN(sTmp))
	{
	  return -5;
	}
	iYear = parseInt(sTmp, 10);
	  
	sTmp = sDateTime.substring(4,6);
	if (isNaN(sTmp))
	{
	   return -6;
	}
	iMonth = parseInt(sTmp, 10);
	  
	if (iYear < 1900)
	{
	  	rdShowMessageDialog("年应大于1900年");
	   	return -11;
	}
	
	if (iMonth < 1 || iMonth > 12)
	{
	   	rdShowMessageDialog("月应在1到12之间");
	   	return -12;
	}
	  
	return 0;
}
function isValidYYYYMMDD(sDateTime)
{
	//时间格式为：YYYYMMDD
	var sTmp = "";
	var iYear = 0;
	var iMonth = 0;
	var iDay = 0;
	var iHour = 0;
	var iMinute = 0;
	var iSecond = 0;
	  
	if ( (sDateTime.length > 8 ) || (sDateTime.length < 8) )
	{
		return -1;
	}
	  
	sTmp = sDateTime.substring(0,4);
	if (isNaN(sTmp))
	{
	  return -5;
	}
	iYear = parseInt(sTmp, 10);
	  
	sTmp = sDateTime.substring(4,6);
	if (isNaN(sTmp))
	{
	   return -6;
	}
	iMonth = parseInt(sTmp, 10);
	 
	sTmp = sDateTime.substring(6,8);
	if (isNaN(sTmp))
	{
	   return -6;
	}
	iDay = parseInt(sTmp, 10); 
	
	if (iYear < 1900)
	{
	  	rdShowMessageDialog("年应大于1900年");
	   	return -11;
	}
	
	if (iMonth < 1 || iMonth > 12)
	{
	   	rdShowMessageDialog("月应在1到12之间");
	   	return -12;
	}
	
	if ((iMonth == 1)||(iMonth == 3)||(iMonth == 5)||(iMonth == 7)||(iMonth == 8)||(iMonth == 10)||(iMonth == 12))
	{
	   	if (iDay > 31) return -13;
	}
	else if (iMonth == 2)
	{
	   if (iDay > 29) return -14;
	    if (iDay == 29)
	    {
	     	 //判断是否是闰年
	      	if (!((iYear % 4 == 0) && ((iYear % 100 != 0) || (iYear % 400 == 0))))
	      	{
	       		return -15;
	      	}
	    }
	}
	else
	{
	   	if (iDay > 30) return -16;
	}
	  
	return 0;
}

//消除回车键提交的功能。
function keyEnter(iKeyCode){

    var srcElement=window.event.srcElement;
    if(srcElement.name=="save" || iKeyCode==-1) {
 document.forms[0].submit();
 return true;
    }

    if(iKeyCode!=13) return false;
    if (srcElement.tagName=="INPUT"||srcElement.tagName=="SELECT"){
 if(srcElement.className=="button")
 srcElement.onClick();
        else{
            var i = 0
            while (srcElement!=srcElement.form.elements[i])
                i++
            srcElement.form.elements[i+1].focus();
        }
    }
    return false;
}
//定义应用全局的变量
var SUCC_CODE   = "0";                  //自己应用程序定义
var ERROR_CODE  = "1";                  //自己应用程序定义
var YE_SUCC_CODE = "0000";              //根据营业系统定义而修改


//检测集团号码
function isGrpId(S)
{
        if(S==null) return false;
        
        if(!isAllNumber(S))
                return false;
        if (!(S.length==10))
                return false;
        
        return true;
        
}

//检测集团联系电话
function isGrpTelephone(S)
{
        if(S==null) return false;
        
        if(!isAllNumber(S))
                return false;
        if ( S.length>18)
                return false;
        
        return true;
        
}

//检测集团管理流程的接入码
function isAdmNo(S)
{
        if(S==null) return false;
        
        if(!isAllNumber(S))
                return false;
        if ( S.length>10)
                return false;
        
        return true;
        
}

//检测呼叫话务员转接号码
function isGrpTransNo(S)
{
        if(S==null) return false;
        
        if(!isAllNumber(S))
                return false;
        if ( S.length>18)
                return false;
        
        return true;
        
}

//检测呼叫话务员转接号码
function isTransNo(S)
{
        if(S==null) return false;
        
        if(!isAllNumber(S))
                return false;
        if ( S.length>18)
                return false;
        
        return true;
        
}
//检测数值
function isNum(S)
{
        if(S==null) return false;
        
        if(!isAllNumber(S))
                return false;
        
        return true;
        
}

//检测数字的范围
function isOverRange(S , low , hight)
{
        if(S==null) return false;
        
        if(!isAllNumber(S))
                return false;
        
        if( (S < low ) || (S > hight ) )
                return false;
        
        return true;
        
        
}

//检测数字的范围:开区间
function isLsRange(S , low )
{
        if(S==null) return false;
        
        if(!isAllNumber(S))
                return false;
        
        if( (S < low )  )
                return false;
        
        return true;
        
        
}
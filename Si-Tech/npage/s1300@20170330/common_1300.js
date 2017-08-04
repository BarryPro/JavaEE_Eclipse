/***
 * a    no input
 * b    number
 * c    positive number
 * d    integer
 * e    positive integer
 * f    length of string  > p1
 */

function dataValid(flag,v,p1){
	switch(flag){
		case 'a':
			re = /^\s*$/;
			return re.test(v);
			break;
		case 'b':
			re = /^(-|\+)?\d+(\.\d+)?$/;
			return re.test(v);
			break;
		case 'c':
			re = /^\d+(\.\d+)?$/;
			return re.test(v);
			break;
		case 'd':
			re = /^(-|\+)?\d+$/;
			return re.test(v);
			break;
		case 'e':
			re = /^\d+$/;
			return re.test(v);
			break;
		case 'f':
			return getISOLength(v) > p1 ? true : false;
			break;
	}
	return false;
}


function formatAsMoney(mnt) {
    mnt -= 0;
    mnt = (Math.round(mnt*100))/100;
    return (mnt == Math.floor(mnt)) ? mnt + '.00' 
              : ( (mnt*10 == Math.floor(mnt*10)) ? 
                       mnt + '0' : mnt);
}


function trim(s){
	if(s == null || String(s) == "undefined") return "";
	return s.replace(/(^\s*)|(\s*$)/g, "");
}


function isNumberString (InString,RefString)
{
if(InString.length==0) return (false);
for (Count=0; Count < InString.length; Count++)  {
	TempChar= InString.substring (Count, Count+1);
	if (RefString.indexOf (TempChar, 0)==-1)  
	return (false);
}
   return (true);
}

function isKeyNumberdot(ifdot) 
{       
    var s_keycode=(navigator.appname=="Netscape")?event.which:event.keyCode;
	if(ifdot==0) {
		if(s_keycode>=48 && s_keycode<=57) {
			return true;
		} else {
			return false;
		}
    } else if (ifdot==1) {
		if((s_keycode>=48 && s_keycode<=57) || s_keycode==46) {
		      return true;
		} else if(s_keycode==45) {
		    rdShowMessageDialog('不允许输入负值,请重新输入!');
		    return false;
		} else {
		    return false;
		}
    } else if (ifdot==2) {
        if((s_keycode>=48 && s_keycode<=57) || s_keycode==46 || s_keycode==45) {
		      return true;
		} else {
		    return false;
		}
    }
}

/*
 function isKeyNumberdot(ifdot) 
{       
    var s_keycode=(navigator.appname=="Netscape")?event.which:event.keyCode;
	if(ifdot==0)
		if(s_keycode>=48 && s_keycode<=57)
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
*/
 
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

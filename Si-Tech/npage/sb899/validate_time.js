function checkElement1(obj)
{
	var objVal = obj.value.trim();
	var objLen = objVal.len();
	var flag = false;
	if(obj.v_must=="1"){
		if (objVal.len()==0){
		   showTip(obj,"不能为空！");
		   flag = true;
		   return false;
		}
	}
	if(!flag){
		if(objLen!=0){
			  if(obj.v_type == "new_date"){ 
				obj.v_format = "yyyyMMdd HH:mm:ss";
				if(!forDate1(obj)){
					return false;
				}
			} 
		}
	}
    hiddenTip(obj);
    return true;
}

function forDate1(obj)
{    
    var val = obj.value;
    var format = obj.v_format;
	var date=getDateFromFormat1(val,format);
	if (date==0) { 
		showTip(obj,"格式为'"+format+"'！");
		return false; 
	}
	hiddenTip(obj);
	return true;
}
function getDateFromFormat1(val,format) 
 {
	val=val+"";
	format=format+"";
	var i_val=0;
	var i_format=0;
	var c="";
	var token="";
	var token2="";
	var x,y;
	var now=new Date();
	var year=now.getYear();
	var month=now.getMonth()+1;
	var date=1;
	var hh=now.getHours();
	var mm=now.getMinutes();
	var ss=now.getSeconds();
 
	while (i_format < format.length) 
	{
		// Get next token from format string
		c=format.charAt(i_format);
		token="";
		while ((format.charAt(i_format)==c) && (i_format < format.length)) {
			token += format.charAt(i_format++);
			}
		// Extract contents of value based on format token
		if (token=="yyyy" ) 
		{
			 x=4;y=4; 
			 year=getInt(val,i_val,x,y);
			 if (year==null) { return 0; }
			 i_val += year.length;
			 
		}
		else if (token=="MM") 
		{
			month=getInt(val,i_val,token.length,2);
			if(month==null||(month<1)||(month>12)){return 0;}
			i_val+=month.length;
		}
		else if (token=="dd") 
		{
			date=getInt(val,i_val,token.length,2);
			if(date==null||(date<1)||(date>31)){return 0;}
			i_val+=date.length;
		}
 
		else if (token=="HH")
		{
			hh=getInt(val,i_val,token.length,2);
			if(hh==null||(hh<0)||(hh>23)){return 0;}
			i_val+=hh.length;
		}
		else if (token=="mm") 
		{
			mm=getInt(val,i_val,token.length,2);
			if(mm==null||(mm<0)||(mm>59)){return 0;}
			i_val+=mm.length;
		}
		else if (token=="ss") 
		{
			ss=getInt(val,i_val,token.length,2);
			if(ss==null||(ss<0)||(ss>59)){return 0;}
			i_val+=ss.length;
		}
	 
		else 
		{
			if (val.substring(i_val,i_val+token.length)!=token) {return 0;}
			else {i_val+=token.length;}
		}
	}//while end
	// If there are any trailing characters left in the value, it doesn't match
	if (i_val != val.length) { return 0; }
	// Is date valid for month?
	if (month==2) 
	{
		// Check for leap year
		if ( ( (year%4==0)&&(year%100 != 0) ) || (year%400==0) ) 
		{ // leap year
			if (date > 29){ return 0; }
		}
		else { if (date > 28) { return 0; } }
	}
	if ((month==4)||(month==6)||(month==9)||(month==11)) 
	{
		if (date > 30) { return 0; }
	}
 
	var newdate=new Date(year,month-1,date,hh,mm,ss);
	return newdate.getTime();
}

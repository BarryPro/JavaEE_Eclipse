<!--
var interval="|";
var dot=".";
var emailSymbol="@";
var fixPhoneInterval="-";
var yearLowerLimit=1900;
var yearUpperLimit=2050;
var intUpperLimit=2147483647;
/*
var specialChar="`~!@#$%^&*()-_=+;:\\|\'\",<.>/?";
*/
var specialChar="\\\'\"|";
var notCodeChar="\\\'\"|";

/*
以下变量定义用于查询模块，其中 b : base
*/
var bAllNo='00000000000'+'         ';	// 11 个零 9 个空格
var bPhoneNo='00000000000';				// 11 个零
var bBillYm='190001';					
var bDate='19000101';
var bAgentCode='       ';				// 7 个空格
var bAccept='1          ';				// 1 个一 10 个空格
var bOpCode='    ';						// 4 个空格
var bResCode='  ';						// 2 个空格
var bLoginNo='    ';					// 6 个空格
var bFeeCode='    ';					// 4 个空格

/***********************************************************************
        函数    ：joint()
        实现功能：用于连接查询索引字符串
        创建者  ：Tophill（张坤）        
        创建时间：2002.06.25
***********************************************************************/
function joint(){
	var args=joint.arguments;
	var tmpStr="";
	for (i=0;i<args.length;i++)
		tmpStr+=args[i];
	tmpStr=tmpStr+interval+tmpStr+interval;
	return tmpStr;	
}

/***********************************************************************
        函数    ：unValid()
        实现功能：用于无效时返回
        创建者  ：Tophill（张坤）        
        创建时间：2002.03.29         
***********************************************************************/
function unValid(){
	var args=unValid.arguments[0];
	if (args.disabled==false)
		args.focus();
	return false;	
}

/***********************************************************************
        函数    ：disableAll()、enableAll() 
        实现功能：页面文本框和选择框禁用和解禁，
                  但输入参数不受影响。
        创建者  ：Tophill（张坤）        
        创建时间：2002.03.29         
***********************************************************************/
function disableAll(){
	var args=disableAll.arguments;
	for (i=0;i<document.all.length;i++){
		if (document.all[i].type=="select-one" || document.all[i].type=="select-mutiple" || document.all[i].type=="textarea" || document.all[i].type=="text")
			document.all[i].disabled=true;
	}
	for (i=0;i<args.length;i++){
		eval("document.all."+args[i]+".disabled=false");	
	}
}

function enableAll(){
	var args=enableAll.arguments;
	for (i=0;i<document.all.length;i++){
		if (document.all[i].type=="select-one" || document.all[i].type=="select-mutiple" || document.all[i].type=="textarea" || document.all[i].type=="text")
			document.all[i].disabled=false;
	}
	for (i=0;i<args.length;i++){
		eval("document.all."+args[i]+".disabled=true");	
	}	
}

/***********************************************************************
        函数    ：disablePart()、enablePart() 
        实现功能：指定页面文本框和选择框禁用和解禁，
        创建者  ：Tophill（张坤）        
        创建时间：2002.03.30         
***********************************************************************/
function disablePart(){
	var args=disablePart.arguments;
	for (i=0;i<args.length;i++){
		eval("document.all."+args[i]+".disabled=true");	
	}
}

function enablePart(){
	var args=enablePart.arguments;
	for (i=0;i<args.length;i++){
		eval("document.all."+args[i]+".disabled=false");	
	}	
}

/***********************************************************************
        函数    ：openWindow
        实现功能：用于打开给定属性子窗口的函数
        创建者  ：Tophill（张坤）        
        创建时间：2002.03.29         
***********************************************************************/
function openWindow(){
	var winFile = openWindow.arguments[0];
	var winName = openWindow.arguments[1];
	var winStyle = openWindow.arguments[2];
	window.open(winFile,winName,winStyle);		
}

/***********************************************************************
        函数    ：isPhoneNo()
        实现功能：判断手机号码的有效性
        创建者  ：Tophill（张坤）        
        创建时间：2002.04.27         
***********************************************************************/
function isPhoneNo(){
	var args=isPhoneNo.arguments;
	if (args[0].value=="" || args[0].value==null){
		alert("请输入"+args[1]+"！");	
		return unValid(args[0]);			
	}
	else if (isNaN(args[0].value)){
		alert(args[1]+"应该是数字型！");	
		return unValid(args[0]);	
	}
	else if (args[0].value.length!=11){
		alert(args[1]+"长度应该为 11 位！");	
		return unValid(args[0]);		
	}
	else if ((parseInt(args[0].value.substring(0,3),10)<133 || parseInt(args[0].value.substring(0,3),10)>139)&&(parseInt(args[0].value.substring(0,3),10)!=159)&&(parseInt(args[0].value.substring(0,3),10)!=158))
	{
		alert(args[1]+"范围应该在133~139之间,或是159号段,或是158号段！");
		return unValid(args[0]);	
	}	
	else 
		return true;
	return true;		
}

/***********************************************************************
        函数    ：isName()
        实现功能：判断名称的有效性
        创建者  ：Tophill（张坤）        
        创建时间：2002.05.02         
***********************************************************************/
function isName(){
	var args=isName.arguments;
	var errorFlag=false;
	if (args[0].value=="" || args[0].value==null){
		alert("请输入"+args[1]+"！");	
		return unValid(args[0]);			
	}
	else{
		for (i=0;i<args[0].value.length;i++){
			for (j=0;j<specialChar.length;j++){
				if (args[0].value.charAt(i)==specialChar.charAt(j)){
					errorFlag=true;
					break;	
				}	
			}	
		}
		if (errorFlag){
			alert(args[1]+"中含有特殊字符！");	
			return unValid(args[0]);				
		}
	}
	return true;		
}

/***********************************************************************
        函数    ：isCode()
        实现功能：判断代码的有效性
        创建者  ：Tophill（张坤）        
        创建时间：2002.05.21         
***********************************************************************/
function isCode(){
	var args=isCode.arguments;
	var errorFlag=false;
	if (args[0].value=="" || args[0].value==null){
		alert("请输入"+args[1]+"！");	
		return unValid(args[0]);			
	}
	else{
		for (i=0;i<args[0].value.length;i++){
			for (j=0;j<specialChar.length;j++){
				if (args[0].value.charAt(i)==notCodeChar.charAt(j)){
					errorFlag=true;
					break;	
				}	
			}	
		}
		if (errorFlag){
			alert(args[1]+"中含有特殊字符！");	
			return unValid(args[0]);				
		}
	}
	return true;		
}

/***********************************************************************
        函数    ：isIdIccid()
        实现功能：判断身份证的有效性
        创建者  ：Tophill（张坤）        
        创建时间：2002.05.02         
***********************************************************************/
function isIdIccid(){
	var args=isIdIccid.arguments;
	if (args[0].value=="" || args[0].value==null){
		alert("请输入"+args[1]+"！");	
		return unValid(args[0]);			
	}
	else if (isNaN(args[0].value.substring(0,15))){
		alert(args[1]+"的前15位应该是数字型！");	
		return unValid(args[0]);	
	}
	else if (args[0].value.length!=15 && args[0].value.length!=18){
		alert(args[1]+"长度应该为 15 位或者 18 位！");	
		return unValid(args[0]);		
	}
	else if (args[0].value.length==15){
		if (!isDateStr("19"+args[0].value.substring(6,12),args[1])){
			return unValid(args[0]);	
		}
	}
	else if (args[0].value.length==18){
		if (!isDateStr(args[0].value.substring(6,14),args[1])){
			return unValid(args[0]);	
		}
	}		
	else 
		return true;
	return true;		
}

/***********************************************************************
        函数    ：isEmail()
        实现功能：判断 Email 的有效性
        创建者  ：Tophill（张坤）        
        创建时间：2002.05.02         
***********************************************************************/
function isEmail(){
	var args=isEmail.arguments;
	var emailSymbolIndex=0;
	if (args[0].value=="" || args[0].value==null){
		alert("请输入"+args[1]+"！");	
		return unValid(args[0]);			
	}
	else {
		for (i=0;i<args[0].value.length;i++){
			if (args[0].value.charAt(i)==emailSymbol){
				emailSymbolIndex=i;
				break;	
			}				
		}	
		if (emailSymbolIndex<=0 || emailSymbolIndex>=args[0].value.length-1){
			alert("所输入的"+args[1]+"不正确！");	
			return unValid(args[0]);	
		}
	}
	return true;		
}

/***********************************************************************
        函数    ：isMobilePhoneNo()
        实现功能：判断手机号码的有效性
        创建者  ：Tophill（张坤）        
        创建时间：2002.04.27         
***********************************************************************/
function isMobilePhoneNo(){
	var args=isMobilePhoneNo.arguments;
	if (args[0].value=="" || args[0].value==null){
		alert("请输入"+args[1]+"！");	
		return unValid(args[0]);			
	}
	else if (isNaN(args[0].value)){
		alert(args[1]+"应该是数字型！");	
		return unValid(args[0]);	
	}
	else if (args[0].value.length!=11){
		alert(args[1]+"长度应该为 11 位！");	
		return unValid(args[0]);		
	}
	else if (parseInt(args[0].value.substring(0,3),10)<130 || parseInt(args[0].value.substring(0,3),10)>139){
		alert(args[1]+"范围应该在130~139之间！");
		return unValid(args[0]);
	}	
	else 
		return true;
	return true;		
}

/***********************************************************************
        函数    ：isFixPhoneNo()
        实现功能：判断固定电话的有效性
        创建者  ：Tophill（张坤）        
        创建时间：2002.05.02         
***********************************************************************/
function isFixPhoneNo(){
	var args=isFixPhoneNo.arguments;
	var phoneNoArr=splitFixPhoneNo(args[0].value);
	if (phoneNoArr.length==1){
		alert(args[1]+"应该包含区号，格式为 xxxx-xxxxxxx！");	
		return unValid(args[0]);		
	}
	if (phoneNoArr.length>3){
		alert(args[1]+"错误！");	
		return unValid(args[0]);
	}
	if (phoneNoArr.length==2){
		if (!intRange(phoneNoArr[0],args[1]+"区号",0,"0","0999"))
			return false;
		if (!intRange(phoneNoArr[1],args[1]+"电话号",0,"0","99999999"))
			return false;
	}
	if (phoneNoArr.length==3){
		if (!intRange(phoneNoArr[0],args[1]+"区号",0,"0","0999"))
			return false;
		if (!intRange(phoneNoArr[1],args[1]+"电话号",0,"0","99999999"))
			return false;
		if (!intRange(phoneNoArr[2],args[1]+"分机号",0,"0","9999"))
			return false;			
	}	
	return true;		
}

/***********************************************************************
        函数    ：isCommPhoneNo()
        实现功能：判断普通电话的有效性（包括手机和固定电话）
        创建者  ：Tophill（张坤）        
        创建时间：2002.05.02         
***********************************************************************/
function isCommPhoneNo(){
	var args=isCommPhoneNo.arguments;
	var fixPhoneFlag=false;
	if (args[0].value=="" || args[0].value==null){
		alert("请输入"+args[1]+"！");	
		return unValid(args[0]);			
	}	
	for (i=0;i<args[0].value.length;i++){
		if (args[0].value.charAt(i)==fixPhoneInterval){
			fixPhoneFlag=true;
			break;
		}
	}
	if (!(parseInt(args[0].value.substring(0,3),10)>=130 && parseInt(args[0].value.substring(0,3),10)<=139))
		fixPhoneFlag=true;
		
	if (fixPhoneFlag)
		return(isFixPhoneNo(args[0],args[1]));
	else 
		return(isMobilePhoneNo(args[0],args[1]));
	return true;		
}

/***********************************************************************
        函数    ：intRange
        实现功能：整数及其范围有效性判断(也可用于浮点数)
        创建者  ：Tophill（张坤）        
        创建时间：2002.04.10         
        args[0]:数值
        args[1]:名称
        args[2]:长度
        args[3]:下限
        args[4]:上限
***********************************************************************/
function intRange(){
	var args=intRange.arguments;
	var inputFloatFlag=false;
	var floatFlag=false;
	if (args[0]=="" || args[0]==null){
		alert("请输入"+args[1]+"！");	
		return false;					
	}	
	else if (isNaN(args[0])){
		alert(args[1]+"应该是数字型！");	
		return false;
	}	
	else if (parseFloat(args[2],10)!=0 && args[0].length!=parseFloat(args[2],10)){
		alert(args[1]+"长度应该为 " + args[2] + " 位！");	
		return false;					
	}
	else if (parseFloat(args[0],10)<parseFloat(args[3],10)){
		alert(args[1]+"应该大于等于 "+ args[3] +" ！");	
		return false;							
	}
	else if (parseFloat(args[0],10)>parseFloat(args[4],10)){
		alert(args[1]+"应该小于等于 "+ args[4] +" ！");	
		return false;							
	}	
	else{
		for(i=0;i<args[3].length;i++){
			if (args[3].charAt(i)==dot){
				floatFlag=true;
				break;
			}
		}
		if (!floatFlag){
			for(i=0;i<args[4].length;i++){
				if (args[4].charAt(i)==dot){
					floatFlag=true;
					break;
				}
			}		
		}
		if (!floatFlag){
			for(i=0;i<args[0].length;i++){
				if (args[0].charAt(i)==dot){
					floatFlag=true;
					break;
				}
			}	
			//if (floatFlag){
				//alert(args[1]+"应该为整型！");
				//return false;
			//}
		}
	} 

	return true;
}

/***********************************************************************
        函数    ：isTime
        实现功能：时间有效性判断，时间格式为 13:40:00
        创建者  ：Tophill（张坤）        
        创建时间：2002.04.10         
***********************************************************************/
function isTime(){
	var args=isTime.arguments;
	if (args[0].value=="" || args[0].value==null){
		alert("请输入"+args[1]+"！");	
		return unValid(args[0]);			
	}
	else if (args[0].value.length!=8){
		alert(args[1]+"长度应该为 8 位！");	
		return unValid(args[0]);					
	}
	else if (args[0].value.substring(2,3)!=":" || args[0].value.substring(5,6)!=":"){
		alert(args[1]+"的格式应该为：13:40:00 ！");	
		return unValid(args[0]);							
	}
	else if (!intRange(args[0].value.substring(0,2),args[1]+"的小时",2,"00","23")){
		return unValid(args[0]);							
	}
	else if (!intRange(args[0].value.substring(3,5),args[1]+"的分钟",2,"00","59")){
		return unValid(args[0]);							
	}
	else if (!intRange(args[0].value.substring(6,8),args[1]+"的秒",2,"00","59")){
		return unValid(args[0]);							
	}	
	else 
		return true;
	return true;		
}

/***********************************************************************
        函数    ：isDateStr
        实现功能：日期字符串有效性判断
        创建者  ：Tophill（张坤）        
        创建时间：2002.05.02         
***********************************************************************/
function isDateStr(){
	var args=isDateStr.arguments;
	if (args[0]=="" || args[0]==null){
		alert("请输入"+args[1]+"！");	
		return false;
	}
	else if (isNaN(args[0])){
		alert(args[1]+"应该是数字型！");
		return false;
	}	
	else if (args[0].length!=8){
		alert(args[1]+"长度应该为 8 位！");
		return false;
	}
	else if (parseInt(args[0].substring(0,4),10)<yearLowerLimit){
		alert(args[1]+"应该大于 "+yearLowerLimit+" 年！");
		return false;
	}
	else if (parseInt(args[0].substring(0,4),10)>yearUpperLimit){
		alert(args[1]+"应该小于 "+yearUpperLimit+" 年！");
		return false;
	} 
	else if (parseInt(args[0].substring(4,6),10)<1){
		alert(args[1]+"的月份应该大于 1 ！");
		return false;
	}
	else if (parseInt(args[0].substring(4,6),10)>12){
		alert(args[1]+"的月份应该小于 12 ！");
		return false;
	}
	else if (parseInt(args[0].substring(6,8),10)<1){
		alert(args[1]+"的日期应该大于 1 ！");
		return false;
	}
	else {
		var months=parseInt(args[0].substring(4,6),10)
		if (months==1 || months==3 || months==5 || months==7 || months==8 || months==10 || months==12){
			if (parseInt(args[0].substring(6,8),10)>31){
				alert(args[1]+"的日期应该小于 31 ！");
				return false;
			}
		}
		else if (months==4 || months==6 ||months==9 || months==11){
			if (parseInt(args[0].substring(6,8),10)>30){
				alert(args[1]+"的日期应该小于 30 ！");
				return false;
			}			
		}
		else if (months==2 && ((parseInt(args[0].substring(0,4),10)%4==0)
		        &&((parseInt(args[0].substring(0,4),10)%100!=0)
		        ||(parseInt(args[0].substring(0,4),10)%400==0)))) {
		    if (parseInt(args[0].substring(6,8),10)>29){
				alert(args[1]+"的日期应该小于 29 ！");
				return false;
			}						
		}
		else if (months==2 && !((parseInt(args[0].substring(0,4),10)%4==0)
		        &&((parseInt(args[0].substring(0,4),10)%100!=0)
		        ||(parseInt(args[0].substring(0,4),10)%400==0)))){
        	if (parseInt(args[0].substring(6,8),10)>28){
				alert(args[1]+"的日期应该小于 28 ！");
				return false;
			}						
		}		
	}
	return true;
}

/***********************************************************************
        函数    ：isDate
        实现功能：日期有效性判断
        创建者  ：Tophill（张坤）        
        创建时间：2002.03.29         
***********************************************************************/
function isDate(){
	var args=isDate.arguments;
	if (args[0].value=="" || args[0].value==null){
		alert("请输入"+args[1]+"！");	
		return unValid(args[0]);
	}
	else if (isNaN(args[0].value)){
		alert(args[1]+"应该是数字型！");
		return unValid(args[0]);
	}	
	else if (args[0].value.length!=8){
		alert(args[1]+"长度应该为 8 位！");
		return unValid(args[0]);
	}
	else if (parseInt(args[0].value.substring(0,4),10)<yearLowerLimit){
		alert(args[1]+"应该大于 "+yearLowerLimit+" 年！");
		return unValid(args[0]);		
	}
	else if (parseInt(args[0].value.substring(0,4),10)>yearUpperLimit){
		alert(args[1]+"应该小于 "+yearUpperLimit+" 年！");
		return unValid(args[0]);		
	} 
	else if (parseInt(args[0].value.substring(4,6),10)<1){
		alert(args[1]+"的月份应该大于 1 ！");
		return unValid(args[0]);				
	}
	else if (parseInt(args[0].value.substring(4,6),10)>12){
		alert(args[1]+"的月份应该小于 12 ！");
		return unValid(args[0]);		
	}
	else if (parseInt(args[0].value.substring(6,8),10)<1){
		alert(args[1]+"的日期应该大于 1 ！");
		return unValid(args[0]);				
	}
	else {
		var months=parseInt(args[0].value.substring(4,6),10)
		if (months==1 || months==3 || months==5 || months==7 || months==8 || months==10 || months==12){
			if (parseInt(args[0].value.substring(6,8),10)>31){
				alert(args[1]+"的日期应该小于 31 ！");
				return unValid(args[0]);										
			}
		}
		else if (months==4 || months==6 ||months==9 || months==11){
			if (parseInt(args[0].value.substring(6,8),10)>30){
				alert(args[1]+"的日期应该小于 30 ！");
				return unValid(args[0]);										
			}			
		}
		else if (months==2 && ((parseInt(args[0].substring(0,4),10)%4==0)
		        &&((parseInt(args[0].substring(0,4),10)%100!=0)
		        ||(parseInt(args[0].substring(0,4),10)%400==0)))){ 
			if (parseInt(args[0].value.substring(6,8),10)>29){
				alert(args[1]+"的日期应该小于 29 ！");
				return unValid(args[0]);										
			}						
		}
		else if (months==2 && !((parseInt(args[0].substring(0,4),10)%4==0)
		        &&((parseInt(args[0].substring(0,4),10)%100!=0)
		        ||(parseInt(args[0].substring(0,4),10)%400==0)))){ 		    
			if (parseInt(args[0].value.substring(6,8),10)>28){
				alert(args[1]+"的日期应该小于 28 ！");
				return unValid(args[0]);										
			}						
		}		
	}
	return true;
}

/***********************************************************************
        函数    ：isPhoneNos
        实现功能：手机号有效性判断（用于支持模糊查询）
        创建者  ：Tophill（张坤）        
        创建时间：2002.05.04         
***********************************************************************/
function isPhoneNos(){
	var args=isPhoneNos.arguments;
	if (args[0].value=="" || args[0].value==null){
		alert("请输入"+args[1]+"！");	
		return unValid(args[0]);			
	}
	else if (isNaN(args[0].value)){
		alert(args[1]+"应该是数字型！");	
		return unValid(args[0]);	
	}
	else if (args[0].value.length<7){
		alert(args[1]+"长度最少应该为 7 位！");	
		return unValid(args[0]);		
	}
	else if (args[0].value.length>11){
		alert(args[1]+"长度最大应该为 11 位！");	
		return unValid(args[0]);		
	}	
	else if ((parseInt(args[0].value.substring(0,3),10)<133 || parseInt(args[0].value.substring(0,3),10)>139)&&( parseInt(args[0].value.substring(0,3),10)!=159)&&( parseInt(args[0].value.substring(0,3),10)!=158))
	{
		alert(args[1]+"范围应该在133~139之间,或是159,158号段！");
		return unValid(args[0]);	
	}	
	else 
		return true;
	return true;				
}

/***********************************************************************
        函数    ：isIdIccids
        实现功能：身份证有效性判断（用于支持模糊查询）
        创建者  ：Tophill（张坤）        
        创建时间：2002.05.04         
***********************************************************************/
function isIdIccids(){
	var args=isIdIccids.arguments;
	if (args[0].value=="" || args[0].value==null){
		alert("请输入"+args[1]+"！");	
		return unValid(args[0]);			
	}
	else if (isNaN(args[0].value)){
		alert(args[1]+"应该是数字型！");	
		return unValid(args[0]);	
	}
	else if (args[0].value.length<8){
		alert(args[1]+"长度最少应该为 8 位！");	
		return unValid(args[0]);		
	}
	else if (args[0].value.length>18){
		alert(args[1]+"长度最大应该为 18 位！");	
		return unValid(args[0]);		
	}	
	else 
		return true;
	return true;		
}

/***********************************************************************
        函数    ：isInt
        实现功能：整数有效性判断
        创建者  ：Tophill（张坤）        
        创建时间：2002.03.29         
***********************************************************************/
function isInt(){
	var arg1=isInt.arguments[0];
	var arg2=isInt.arguments[1];
	if (arg1.value=="" || arg1.value==null){
		alert("请输入"+arg2+"！");
		return unValid(arg1);
	}
	else if (isNaN(arg1.value)){
		alert(arg2+"应该为数字型！")
		return unValid(arg2);
	}
	else
		return true;
}

function isSimNo(){
	var args=isSimNo.arguments;	
	if (args[0].value=="" || args[0].value==null){
		alert("请输入"+args[1]+"！");	
		return unValid(args[0]);			
	}
	else if (isNaN(args[0].value.substring(0,10)) || isNaN(args[0].value.substring(10,20))){
		alert(args[1]+"应该是数字型！");	
		return unValid(args[0]);	
	}
	else if (args[0].value.length!=20){
		alert(args[1]+"长度应该为 20 位！");	
		return unValid(args[0]);		
	}
	else 
		return true;
	return true;	
}

function splitField(){
	args=splitField.arguments[0];
	var tmpArray=new Array();
	if (args==null || args.length<1 || args=="" || args=="NULL" || args=="null" || args=="Null")
		return tmpArray;
	args=args.substring(0,args.length-1);
	return args.split(interval);
}

function splitFixPhoneNo(){
	args=splitFixPhoneNo.arguments;
	var tmpArray=new Array();
	if (args[0]==null || args[0].length<1 || args[0]=="" || args[0]=="NULL" || args[0]=="null" || args[0]=="Null")
		return tmpArray;
	args[0]=args[0].substring(0,args[0].length);
	return args[0].split(fixPhoneInterval);
}

function trMouseOver(){
	var args=trMouseOver.arguments;
	var cursorHand="hand";
	var darkBlue="#99CCFF";
	args[0].style.backgroundColor=darkBlue;
	args[0].style.cursor=cursorHand;
}

function trMouseOut(){
	var args=trMouseOut.arguments;
	var lithtBlue="#E1F0FF";
	args[0].style.backgroundColor=lithtBlue;
}

function selectAll(){
	var args=selectAll.arguments[0];
	var found=false;
	if (args == null || args == "")
		return;	
	with(document.forms[0]){
		for (i=0;i<elements.length;i++){
			if (elements[i].name==args){
				found=true;
				break;	
			}
		}
		if (!found)
			return;
		for (i=0;i<eval(args+".length");i++){
			eval(args+"["+i+"].checked=true");
		}
		eval(args+".checked=true");
	}
}

function selectNone(){
	var args=selectNone.arguments[0];
	var found=false;
	if (args == null || args == "")
		return;	
	with(document.forms[0]){
		for (i=0;i<elements.length;i++){
			if (elements[i].name==args){
				found=true;
				break;	
			}
		}
		if (!found)
			return;
		for (i=0;i<eval(args+".length");i++){
			eval(args+"["+i+"].checked=false");
		}
	}
}

/***********************************************************************
        函数    ：intToStr
        实现功能：整数转换成指定长度字符串
        创建者  ：Tophill（张坤）        
        创建时间：2002.05.29         
***********************************************************************/
function intToStr(){
	var args=intToStr.arguments;
	var result=args[0]+"";
	for (i=(args[0]+"").length;i<args[1];i++){
		result="0"+result;	
	}
	return result;
}

/***********************************************************************
        函数    ：isBillDate
        实现功能：结算年月的有效性判断
        创建者  ：Tophill（张坤）        
        创建时间：2002.05.29         
***********************************************************************/
function isBillDate(){ 
	var args=isBillDate.arguments;
	if (args[0].value=="" || args[0].value==null){
		alert("请输入"+args[1]+"！");	
		return unValid(args[0]);
	}
	else if (isNaN(args[0].value.substring(0,6))) {
		alert(args[1]+"应该是数字型！");
		return unValid(args[0]);
	}
	else if (args[0].value.length!=6){
		alert(args[1]+"长度应该为 6 位！");
		return unValid(args[0]);
	}
	else if (parseInt(args[0].value.substring(0,4),10)<yearLowerLimit){
		alert(args[1]+"应该大于 "+yearLowerLimit+" 年！");
		return unValid(args[0]);		
	}       
 	else if (parseInt(args[0].value.substring(0,4),10)>yearUpperLimit){
		alert(args[1]+"应该小于 "+yearUpperLimit+" 年！");
		return unValid(args[0]);		
	} 
	else if (parseInt(args[0].value.substring(4,6),10)<1){
		alert(args[1]+"的月份应该大于 1 ！");
		return unValid(args[0]);				
	}  
	else if (parseInt(args[0].value.substring(4,6),10)>12){
		alert(args[1]+"的月份应该小于 12 ！");
		return unValid(args[0]);		
	}
	return true;
}

/***********************************************************************
        函数    ：isBillYear
        实现功能：结算年的有效性判断
        创建者  ：Tophill（张坤）        
        创建时间：2002.05.29         
***********************************************************************/
function isBillYear(){ 
	var args=isBillYear.arguments;
	if (args[0].value=="" || args[0].value==null){
		alert("请输入"+args[1]+"！");	
		return unValid(args[0]);
	}
	else if (isNaN(args[0].value)) {
		alert(args[1]+"应该是数字型！");
		return unValid(args[0]);
	}
	else if (args[0].value.length!=4){
		alert(args[1]+"长度应该为 4 位！");
		return unValid(args[0]);
	}
	else if (parseInt(args[0].value,10)<yearLowerLimit){
		alert(args[1]+"应该大于 "+yearLowerLimit+" 年！");
		return unValid(args[0]);		
	}       
 	else if (parseInt(args[0].value,10)>yearUpperLimit){
		alert(args[1]+"应该小于 "+yearUpperLimit+" 年！");
		return unValid(args[0]);		
	} 
	return true;
}
--> 

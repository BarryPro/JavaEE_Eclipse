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
���±����������ڲ�ѯģ�飬���� b : base
*/
var bAllNo='00000000000'+'         ';	// 11 ���� 9 ���ո�
var bPhoneNo='00000000000';				// 11 ����
var bBillYm='190001';					
var bDate='19000101';
var bAgentCode='       ';				// 7 ���ո�
var bAccept='1          ';				// 1 ��һ 10 ���ո�
var bOpCode='    ';						// 4 ���ո�
var bResCode='  ';						// 2 ���ո�
var bLoginNo='    ';					// 6 ���ո�
var bFeeCode='    ';					// 4 ���ո�

/***********************************************************************
        ����    ��joint()
        ʵ�ֹ��ܣ��������Ӳ�ѯ�����ַ���
        ������  ��Tophill��������        
        ����ʱ�䣺2002.06.25
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
        ����    ��unValid()
        ʵ�ֹ��ܣ�������Чʱ����
        ������  ��Tophill��������        
        ����ʱ�䣺2002.03.29         
***********************************************************************/
function unValid(){
	var args=unValid.arguments[0];
	if (args.disabled==false)
		args.focus();
	return false;	
}

/***********************************************************************
        ����    ��disableAll()��enableAll() 
        ʵ�ֹ��ܣ�ҳ���ı����ѡ�����úͽ����
                  �������������Ӱ�졣
        ������  ��Tophill��������        
        ����ʱ�䣺2002.03.29         
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
        ����    ��disablePart()��enablePart() 
        ʵ�ֹ��ܣ�ָ��ҳ���ı����ѡ�����úͽ����
        ������  ��Tophill��������        
        ����ʱ�䣺2002.03.30         
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
        ����    ��openWindow
        ʵ�ֹ��ܣ����ڴ򿪸��������Ӵ��ڵĺ���
        ������  ��Tophill��������        
        ����ʱ�䣺2002.03.29         
***********************************************************************/
function openWindow(){
	var winFile = openWindow.arguments[0];
	var winName = openWindow.arguments[1];
	var winStyle = openWindow.arguments[2];
	window.open(winFile,winName,winStyle);		
}

/***********************************************************************
        ����    ��isPhoneNo()
        ʵ�ֹ��ܣ��ж��ֻ��������Ч��
        ������  ��Tophill��������        
        ����ʱ�䣺2002.04.27         
***********************************************************************/
function isPhoneNo(){
	var args=isPhoneNo.arguments;
	if (args[0].value=="" || args[0].value==null){
		alert("������"+args[1]+"��");	
		return unValid(args[0]);			
	}
	else if (isNaN(args[0].value)){
		alert(args[1]+"Ӧ���������ͣ�");	
		return unValid(args[0]);	
	}
	else if (args[0].value.length!=11){
		alert(args[1]+"����Ӧ��Ϊ 11 λ��");	
		return unValid(args[0]);		
	}
	else if ((parseInt(args[0].value.substring(0,3),10)<133 || parseInt(args[0].value.substring(0,3),10)>139)&&(parseInt(args[0].value.substring(0,3),10)!=159)&&(parseInt(args[0].value.substring(0,3),10)!=158))
	{
		alert(args[1]+"��ΧӦ����133~139֮��,����159�Ŷ�,����158�ŶΣ�");
		return unValid(args[0]);	
	}	
	else 
		return true;
	return true;		
}

/***********************************************************************
        ����    ��isName()
        ʵ�ֹ��ܣ��ж����Ƶ���Ч��
        ������  ��Tophill��������        
        ����ʱ�䣺2002.05.02         
***********************************************************************/
function isName(){
	var args=isName.arguments;
	var errorFlag=false;
	if (args[0].value=="" || args[0].value==null){
		alert("������"+args[1]+"��");	
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
			alert(args[1]+"�к��������ַ���");	
			return unValid(args[0]);				
		}
	}
	return true;		
}

/***********************************************************************
        ����    ��isCode()
        ʵ�ֹ��ܣ��жϴ������Ч��
        ������  ��Tophill��������        
        ����ʱ�䣺2002.05.21         
***********************************************************************/
function isCode(){
	var args=isCode.arguments;
	var errorFlag=false;
	if (args[0].value=="" || args[0].value==null){
		alert("������"+args[1]+"��");	
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
			alert(args[1]+"�к��������ַ���");	
			return unValid(args[0]);				
		}
	}
	return true;		
}

/***********************************************************************
        ����    ��isIdIccid()
        ʵ�ֹ��ܣ��ж����֤����Ч��
        ������  ��Tophill��������        
        ����ʱ�䣺2002.05.02         
***********************************************************************/
function isIdIccid(){
	var args=isIdIccid.arguments;
	if (args[0].value=="" || args[0].value==null){
		alert("������"+args[1]+"��");	
		return unValid(args[0]);			
	}
	else if (isNaN(args[0].value.substring(0,15))){
		alert(args[1]+"��ǰ15λӦ���������ͣ�");	
		return unValid(args[0]);	
	}
	else if (args[0].value.length!=15 && args[0].value.length!=18){
		alert(args[1]+"����Ӧ��Ϊ 15 λ���� 18 λ��");	
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
        ����    ��isEmail()
        ʵ�ֹ��ܣ��ж� Email ����Ч��
        ������  ��Tophill��������        
        ����ʱ�䣺2002.05.02         
***********************************************************************/
function isEmail(){
	var args=isEmail.arguments;
	var emailSymbolIndex=0;
	if (args[0].value=="" || args[0].value==null){
		alert("������"+args[1]+"��");	
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
			alert("�������"+args[1]+"����ȷ��");	
			return unValid(args[0]);	
		}
	}
	return true;		
}

/***********************************************************************
        ����    ��isMobilePhoneNo()
        ʵ�ֹ��ܣ��ж��ֻ��������Ч��
        ������  ��Tophill��������        
        ����ʱ�䣺2002.04.27         
***********************************************************************/
function isMobilePhoneNo(){
	var args=isMobilePhoneNo.arguments;
	if (args[0].value=="" || args[0].value==null){
		alert("������"+args[1]+"��");	
		return unValid(args[0]);			
	}
	else if (isNaN(args[0].value)){
		alert(args[1]+"Ӧ���������ͣ�");	
		return unValid(args[0]);	
	}
	else if (args[0].value.length!=11){
		alert(args[1]+"����Ӧ��Ϊ 11 λ��");	
		return unValid(args[0]);		
	}
	else if (parseInt(args[0].value.substring(0,3),10)<130 || parseInt(args[0].value.substring(0,3),10)>139){
		alert(args[1]+"��ΧӦ����130~139֮�䣡");
		return unValid(args[0]);
	}	
	else 
		return true;
	return true;		
}

/***********************************************************************
        ����    ��isFixPhoneNo()
        ʵ�ֹ��ܣ��жϹ̶��绰����Ч��
        ������  ��Tophill��������        
        ����ʱ�䣺2002.05.02         
***********************************************************************/
function isFixPhoneNo(){
	var args=isFixPhoneNo.arguments;
	var phoneNoArr=splitFixPhoneNo(args[0].value);
	if (phoneNoArr.length==1){
		alert(args[1]+"Ӧ�ð������ţ���ʽΪ xxxx-xxxxxxx��");	
		return unValid(args[0]);		
	}
	if (phoneNoArr.length>3){
		alert(args[1]+"����");	
		return unValid(args[0]);
	}
	if (phoneNoArr.length==2){
		if (!intRange(phoneNoArr[0],args[1]+"����",0,"0","0999"))
			return false;
		if (!intRange(phoneNoArr[1],args[1]+"�绰��",0,"0","99999999"))
			return false;
	}
	if (phoneNoArr.length==3){
		if (!intRange(phoneNoArr[0],args[1]+"����",0,"0","0999"))
			return false;
		if (!intRange(phoneNoArr[1],args[1]+"�绰��",0,"0","99999999"))
			return false;
		if (!intRange(phoneNoArr[2],args[1]+"�ֻ���",0,"0","9999"))
			return false;			
	}	
	return true;		
}

/***********************************************************************
        ����    ��isCommPhoneNo()
        ʵ�ֹ��ܣ��ж���ͨ�绰����Ч�ԣ������ֻ��͹̶��绰��
        ������  ��Tophill��������        
        ����ʱ�䣺2002.05.02         
***********************************************************************/
function isCommPhoneNo(){
	var args=isCommPhoneNo.arguments;
	var fixPhoneFlag=false;
	if (args[0].value=="" || args[0].value==null){
		alert("������"+args[1]+"��");	
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
        ����    ��intRange
        ʵ�ֹ��ܣ��������䷶Χ��Ч���ж�(Ҳ�����ڸ�����)
        ������  ��Tophill��������        
        ����ʱ�䣺2002.04.10         
        args[0]:��ֵ
        args[1]:����
        args[2]:����
        args[3]:����
        args[4]:����
***********************************************************************/
function intRange(){
	var args=intRange.arguments;
	var inputFloatFlag=false;
	var floatFlag=false;
	if (args[0]=="" || args[0]==null){
		alert("������"+args[1]+"��");	
		return false;					
	}	
	else if (isNaN(args[0])){
		alert(args[1]+"Ӧ���������ͣ�");	
		return false;
	}	
	else if (parseFloat(args[2],10)!=0 && args[0].length!=parseFloat(args[2],10)){
		alert(args[1]+"����Ӧ��Ϊ " + args[2] + " λ��");	
		return false;					
	}
	else if (parseFloat(args[0],10)<parseFloat(args[3],10)){
		alert(args[1]+"Ӧ�ô��ڵ��� "+ args[3] +" ��");	
		return false;							
	}
	else if (parseFloat(args[0],10)>parseFloat(args[4],10)){
		alert(args[1]+"Ӧ��С�ڵ��� "+ args[4] +" ��");	
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
				//alert(args[1]+"Ӧ��Ϊ���ͣ�");
				//return false;
			//}
		}
	} 

	return true;
}

/***********************************************************************
        ����    ��isTime
        ʵ�ֹ��ܣ�ʱ����Ч���жϣ�ʱ���ʽΪ 13:40:00
        ������  ��Tophill��������        
        ����ʱ�䣺2002.04.10         
***********************************************************************/
function isTime(){
	var args=isTime.arguments;
	if (args[0].value=="" || args[0].value==null){
		alert("������"+args[1]+"��");	
		return unValid(args[0]);			
	}
	else if (args[0].value.length!=8){
		alert(args[1]+"����Ӧ��Ϊ 8 λ��");	
		return unValid(args[0]);					
	}
	else if (args[0].value.substring(2,3)!=":" || args[0].value.substring(5,6)!=":"){
		alert(args[1]+"�ĸ�ʽӦ��Ϊ��13:40:00 ��");	
		return unValid(args[0]);							
	}
	else if (!intRange(args[0].value.substring(0,2),args[1]+"��Сʱ",2,"00","23")){
		return unValid(args[0]);							
	}
	else if (!intRange(args[0].value.substring(3,5),args[1]+"�ķ���",2,"00","59")){
		return unValid(args[0]);							
	}
	else if (!intRange(args[0].value.substring(6,8),args[1]+"����",2,"00","59")){
		return unValid(args[0]);							
	}	
	else 
		return true;
	return true;		
}

/***********************************************************************
        ����    ��isDateStr
        ʵ�ֹ��ܣ������ַ�����Ч���ж�
        ������  ��Tophill��������        
        ����ʱ�䣺2002.05.02         
***********************************************************************/
function isDateStr(){
	var args=isDateStr.arguments;
	if (args[0]=="" || args[0]==null){
		alert("������"+args[1]+"��");	
		return false;
	}
	else if (isNaN(args[0])){
		alert(args[1]+"Ӧ���������ͣ�");
		return false;
	}	
	else if (args[0].length!=8){
		alert(args[1]+"����Ӧ��Ϊ 8 λ��");
		return false;
	}
	else if (parseInt(args[0].substring(0,4),10)<yearLowerLimit){
		alert(args[1]+"Ӧ�ô��� "+yearLowerLimit+" �꣡");
		return false;
	}
	else if (parseInt(args[0].substring(0,4),10)>yearUpperLimit){
		alert(args[1]+"Ӧ��С�� "+yearUpperLimit+" �꣡");
		return false;
	} 
	else if (parseInt(args[0].substring(4,6),10)<1){
		alert(args[1]+"���·�Ӧ�ô��� 1 ��");
		return false;
	}
	else if (parseInt(args[0].substring(4,6),10)>12){
		alert(args[1]+"���·�Ӧ��С�� 12 ��");
		return false;
	}
	else if (parseInt(args[0].substring(6,8),10)<1){
		alert(args[1]+"������Ӧ�ô��� 1 ��");
		return false;
	}
	else {
		var months=parseInt(args[0].substring(4,6),10)
		if (months==1 || months==3 || months==5 || months==7 || months==8 || months==10 || months==12){
			if (parseInt(args[0].substring(6,8),10)>31){
				alert(args[1]+"������Ӧ��С�� 31 ��");
				return false;
			}
		}
		else if (months==4 || months==6 ||months==9 || months==11){
			if (parseInt(args[0].substring(6,8),10)>30){
				alert(args[1]+"������Ӧ��С�� 30 ��");
				return false;
			}			
		}
		else if (months==2 && ((parseInt(args[0].substring(0,4),10)%4==0)
		        &&((parseInt(args[0].substring(0,4),10)%100!=0)
		        ||(parseInt(args[0].substring(0,4),10)%400==0)))) {
		    if (parseInt(args[0].substring(6,8),10)>29){
				alert(args[1]+"������Ӧ��С�� 29 ��");
				return false;
			}						
		}
		else if (months==2 && !((parseInt(args[0].substring(0,4),10)%4==0)
		        &&((parseInt(args[0].substring(0,4),10)%100!=0)
		        ||(parseInt(args[0].substring(0,4),10)%400==0)))){
        	if (parseInt(args[0].substring(6,8),10)>28){
				alert(args[1]+"������Ӧ��С�� 28 ��");
				return false;
			}						
		}		
	}
	return true;
}

/***********************************************************************
        ����    ��isDate
        ʵ�ֹ��ܣ�������Ч���ж�
        ������  ��Tophill��������        
        ����ʱ�䣺2002.03.29         
***********************************************************************/
function isDate(){
	var args=isDate.arguments;
	if (args[0].value=="" || args[0].value==null){
		alert("������"+args[1]+"��");	
		return unValid(args[0]);
	}
	else if (isNaN(args[0].value)){
		alert(args[1]+"Ӧ���������ͣ�");
		return unValid(args[0]);
	}	
	else if (args[0].value.length!=8){
		alert(args[1]+"����Ӧ��Ϊ 8 λ��");
		return unValid(args[0]);
	}
	else if (parseInt(args[0].value.substring(0,4),10)<yearLowerLimit){
		alert(args[1]+"Ӧ�ô��� "+yearLowerLimit+" �꣡");
		return unValid(args[0]);		
	}
	else if (parseInt(args[0].value.substring(0,4),10)>yearUpperLimit){
		alert(args[1]+"Ӧ��С�� "+yearUpperLimit+" �꣡");
		return unValid(args[0]);		
	} 
	else if (parseInt(args[0].value.substring(4,6),10)<1){
		alert(args[1]+"���·�Ӧ�ô��� 1 ��");
		return unValid(args[0]);				
	}
	else if (parseInt(args[0].value.substring(4,6),10)>12){
		alert(args[1]+"���·�Ӧ��С�� 12 ��");
		return unValid(args[0]);		
	}
	else if (parseInt(args[0].value.substring(6,8),10)<1){
		alert(args[1]+"������Ӧ�ô��� 1 ��");
		return unValid(args[0]);				
	}
	else {
		var months=parseInt(args[0].value.substring(4,6),10)
		if (months==1 || months==3 || months==5 || months==7 || months==8 || months==10 || months==12){
			if (parseInt(args[0].value.substring(6,8),10)>31){
				alert(args[1]+"������Ӧ��С�� 31 ��");
				return unValid(args[0]);										
			}
		}
		else if (months==4 || months==6 ||months==9 || months==11){
			if (parseInt(args[0].value.substring(6,8),10)>30){
				alert(args[1]+"������Ӧ��С�� 30 ��");
				return unValid(args[0]);										
			}			
		}
		else if (months==2 && ((parseInt(args[0].substring(0,4),10)%4==0)
		        &&((parseInt(args[0].substring(0,4),10)%100!=0)
		        ||(parseInt(args[0].substring(0,4),10)%400==0)))){ 
			if (parseInt(args[0].value.substring(6,8),10)>29){
				alert(args[1]+"������Ӧ��С�� 29 ��");
				return unValid(args[0]);										
			}						
		}
		else if (months==2 && !((parseInt(args[0].substring(0,4),10)%4==0)
		        &&((parseInt(args[0].substring(0,4),10)%100!=0)
		        ||(parseInt(args[0].substring(0,4),10)%400==0)))){ 		    
			if (parseInt(args[0].value.substring(6,8),10)>28){
				alert(args[1]+"������Ӧ��С�� 28 ��");
				return unValid(args[0]);										
			}						
		}		
	}
	return true;
}

/***********************************************************************
        ����    ��isPhoneNos
        ʵ�ֹ��ܣ��ֻ�����Ч���жϣ�����֧��ģ����ѯ��
        ������  ��Tophill��������        
        ����ʱ�䣺2002.05.04         
***********************************************************************/
function isPhoneNos(){
	var args=isPhoneNos.arguments;
	if (args[0].value=="" || args[0].value==null){
		alert("������"+args[1]+"��");	
		return unValid(args[0]);			
	}
	else if (isNaN(args[0].value)){
		alert(args[1]+"Ӧ���������ͣ�");	
		return unValid(args[0]);	
	}
	else if (args[0].value.length<7){
		alert(args[1]+"��������Ӧ��Ϊ 7 λ��");	
		return unValid(args[0]);		
	}
	else if (args[0].value.length>11){
		alert(args[1]+"�������Ӧ��Ϊ 11 λ��");	
		return unValid(args[0]);		
	}	
	else if ((parseInt(args[0].value.substring(0,3),10)<133 || parseInt(args[0].value.substring(0,3),10)>139)&&( parseInt(args[0].value.substring(0,3),10)!=159)&&( parseInt(args[0].value.substring(0,3),10)!=158))
	{
		alert(args[1]+"��ΧӦ����133~139֮��,����159,158�ŶΣ�");
		return unValid(args[0]);	
	}	
	else 
		return true;
	return true;				
}

/***********************************************************************
        ����    ��isIdIccids
        ʵ�ֹ��ܣ����֤��Ч���жϣ�����֧��ģ����ѯ��
        ������  ��Tophill��������        
        ����ʱ�䣺2002.05.04         
***********************************************************************/
function isIdIccids(){
	var args=isIdIccids.arguments;
	if (args[0].value=="" || args[0].value==null){
		alert("������"+args[1]+"��");	
		return unValid(args[0]);			
	}
	else if (isNaN(args[0].value)){
		alert(args[1]+"Ӧ���������ͣ�");	
		return unValid(args[0]);	
	}
	else if (args[0].value.length<8){
		alert(args[1]+"��������Ӧ��Ϊ 8 λ��");	
		return unValid(args[0]);		
	}
	else if (args[0].value.length>18){
		alert(args[1]+"�������Ӧ��Ϊ 18 λ��");	
		return unValid(args[0]);		
	}	
	else 
		return true;
	return true;		
}

/***********************************************************************
        ����    ��isInt
        ʵ�ֹ��ܣ�������Ч���ж�
        ������  ��Tophill��������        
        ����ʱ�䣺2002.03.29         
***********************************************************************/
function isInt(){
	var arg1=isInt.arguments[0];
	var arg2=isInt.arguments[1];
	if (arg1.value=="" || arg1.value==null){
		alert("������"+arg2+"��");
		return unValid(arg1);
	}
	else if (isNaN(arg1.value)){
		alert(arg2+"Ӧ��Ϊ�����ͣ�")
		return unValid(arg2);
	}
	else
		return true;
}

function isSimNo(){
	var args=isSimNo.arguments;	
	if (args[0].value=="" || args[0].value==null){
		alert("������"+args[1]+"��");	
		return unValid(args[0]);			
	}
	else if (isNaN(args[0].value.substring(0,10)) || isNaN(args[0].value.substring(10,20))){
		alert(args[1]+"Ӧ���������ͣ�");	
		return unValid(args[0]);	
	}
	else if (args[0].value.length!=20){
		alert(args[1]+"����Ӧ��Ϊ 20 λ��");	
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
        ����    ��intToStr
        ʵ�ֹ��ܣ�����ת����ָ�������ַ���
        ������  ��Tophill��������        
        ����ʱ�䣺2002.05.29         
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
        ����    ��isBillDate
        ʵ�ֹ��ܣ��������µ���Ч���ж�
        ������  ��Tophill��������        
        ����ʱ�䣺2002.05.29         
***********************************************************************/
function isBillDate(){ 
	var args=isBillDate.arguments;
	if (args[0].value=="" || args[0].value==null){
		alert("������"+args[1]+"��");	
		return unValid(args[0]);
	}
	else if (isNaN(args[0].value.substring(0,6))) {
		alert(args[1]+"Ӧ���������ͣ�");
		return unValid(args[0]);
	}
	else if (args[0].value.length!=6){
		alert(args[1]+"����Ӧ��Ϊ 6 λ��");
		return unValid(args[0]);
	}
	else if (parseInt(args[0].value.substring(0,4),10)<yearLowerLimit){
		alert(args[1]+"Ӧ�ô��� "+yearLowerLimit+" �꣡");
		return unValid(args[0]);		
	}       
 	else if (parseInt(args[0].value.substring(0,4),10)>yearUpperLimit){
		alert(args[1]+"Ӧ��С�� "+yearUpperLimit+" �꣡");
		return unValid(args[0]);		
	} 
	else if (parseInt(args[0].value.substring(4,6),10)<1){
		alert(args[1]+"���·�Ӧ�ô��� 1 ��");
		return unValid(args[0]);				
	}  
	else if (parseInt(args[0].value.substring(4,6),10)>12){
		alert(args[1]+"���·�Ӧ��С�� 12 ��");
		return unValid(args[0]);		
	}
	return true;
}

/***********************************************************************
        ����    ��isBillYear
        ʵ�ֹ��ܣ����������Ч���ж�
        ������  ��Tophill��������        
        ����ʱ�䣺2002.05.29         
***********************************************************************/
function isBillYear(){ 
	var args=isBillYear.arguments;
	if (args[0].value=="" || args[0].value==null){
		alert("������"+args[1]+"��");	
		return unValid(args[0]);
	}
	else if (isNaN(args[0].value)) {
		alert(args[1]+"Ӧ���������ͣ�");
		return unValid(args[0]);
	}
	else if (args[0].value.length!=4){
		alert(args[1]+"����Ӧ��Ϊ 4 λ��");
		return unValid(args[0]);
	}
	else if (parseInt(args[0].value,10)<yearLowerLimit){
		alert(args[1]+"Ӧ�ô��� "+yearLowerLimit+" �꣡");
		return unValid(args[0]);		
	}       
 	else if (parseInt(args[0].value,10)>yearUpperLimit){
		alert(args[1]+"Ӧ��С�� "+yearUpperLimit+" �꣡");
		return unValid(args[0]);		
	} 
	return true;
}
--> 

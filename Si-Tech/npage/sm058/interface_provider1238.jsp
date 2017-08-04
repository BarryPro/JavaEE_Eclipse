 <html>
 
<script language="JavaScript">
	var sfznamess1238="";
	var sfzcodess1238="";
	var sfzIDaddressss1238="";
	var sfzbir_dayss1238="";
	var sfzsexss1238="";
	var sfzidValidDate_objss1238="";
	var sfzpicturespathss1238="";
	 
function RecogNewIDOnly_twoss()
{

	
//扫描二代身份证
document.all.card_flag.value ="1";
var picName = getCuTime();
var fso = new ActiveXObject("Scripting.FileSystemObject");  //取系统文件对象
tmpFolder = fso.GetSpecialFolder(0); //取得系统安装目录
var strtemp= tmpFolder+"";
var filep1 = strtemp.substring(0,1)//取得系统目录盘符
var cre_dir = filep1+":\\custID";//创建目录

//判断文件夹是否存在，不存在则创建目录
if(!fso.FolderExists(cre_dir)) {
var newFolderName = fso.CreateFolder(cre_dir);  
}
		try{   
	
	 if( objIDCard11.LibIsLoaded() )
    {
	objIDCard11.ImageFileName =  cre_dir +"\\"+picName+"_" +document.all.custId.value +"_two.jpg";
	objIDCard11.SaveResultFile = true;
	objIDCard11.Content = 63;
	if( objIDCard11.RecogNewIDCardALL() )
		{
	    var name = objIDCard11.GetName();//姓名
			var code =  objIDCard11.GetNumber();//身份证号
			var sex = objIDCard11.GetSex();//性别
			var minzu = objIDCard11.GetPeople();//民族
			var bir_day = objIDCard11.GetBirthday();//生日
			var IDaddress  =  objIDCard11.GetAddress();//身份证地址
			
			document.all.custName.value =name;//姓名
			document.all.idIccid.value =code;//身份证号
			document.all.idAddr.value =IDaddress;//身份证地址
			document.all.idAddrH.value =document.all.idAddr.value;//身份证地址
			
			
			var temp_day = bir_day +"";
			
			
			var year_num = temp_day.indexOf("年");			
			var year_temp = temp_day.substring(0,year_num);			
			
			var month_num = temp_day.indexOf("月");	
			var month_temp = temp_day.substring(year_num+1,month_num);		
			if(month_temp<10)
			month_temp ="0"+ month_temp
			
			var day_num = temp_day.indexOf("日");			
			var day_temp = temp_day.substring(month_num+1,day_num);		
			if(day_temp<10)
			day_temp = "0"+day_temp;

			document.all.birthDay.value =year_temp+""+month_temp+""+day_temp;//生日
			
			document.all.birthDayH.value = document.all.birthDay.value;
			
			
			if(sex=="男"){
		  		document.all.custSex.value="1";//性别
		  		}
		  else if(sex=="女"){
		  		document.all.custSex.value="2";//性别
		  		}
		  else{
		  		document.all.custSex.value="3";//性别
		  	 }
		 
		  document.all.idSexH.value= document.all.custSex.value;
		  document.all.pic_name.value =  cre_dir +"\\"+picName+"_" +document.all.custId.value +"_two.jpg";
		  document.all.sf_flag.value ="success";//扫描成功标志
		  document.all.but_flag.value ="1";
		  
			
		  changeCardAddr(document.all.idAddr);
		  /*gaopeng 扫描二代身份证按钮*/
		  document.all.card2flag.value="1";
		  pubM032Cfm();
	}
        else
	{
            rdShowMessageDialog( objIDCard11.GetLastErrorInfo() ,0);
	}
    }
    else
    {
        rdShowMessageDialog( objIDCard11.GetLastErrorInfo(),0 );
    }
    	}catch(e){
		rdShowMessageDialog("未连接扫描仪！",0);
	}
}

function RecogNewIDOnly_oness()
{
	document.all.card_flag.value ="1";
	
	var picName = getCuTime();
	//扫描一代身份证
var fso = new ActiveXObject("Scripting.FileSystemObject");  //取系统文件对象
								
tmpFolder = fso.GetSpecialFolder(0); //取得系统安装目录
var strtemp= tmpFolder+"";
var filep1 = strtemp.substring(0,1)//取得系统目录盘符
var cre_dir = filep1+":\\custID";//创建目录

//判断文件夹是否存在，不存在则创建目录
if(!fso.FolderExists(cre_dir)) {
var newFolderName = fso.CreateFolder(cre_dir);  
}

		try{   
	
	 if( objIDCard11.LibIsLoaded() )
    {
	objIDCard11.ImageFileName = cre_dir +"\\"+picName+"_"+ document.all.custId.value +"_one.jpg";
	objIDCard11.SaveResultFile = true;
	objIDCard11.Content = 63;
	if( objIDCard11.RecogIDCardExALL() )
		{
			
	    var name = objIDCard11.GetName();
			var code =  objIDCard11.GetNumber();
			var sex = objIDCard11.GetSex();
			var minzu = objIDCard11.GetPeople();
			var bir_day = objIDCard11.GetBirthday();
			var IDaddress  =  objIDCard11.GetAddress();
			
			document.all.custName.value =name;//姓名
			document.all.idIccid.value =code;//身份证号
			document.all.idAddr.value =IDaddress;//身份证地址
			document.all.idAddrH.value =IDaddress;//身份证地址

			
			var temp_day = bir_day +"";//
			var year_num = temp_day.indexOf("年");			
			var year_temp = temp_day.substring(0,year_num);	
			var month_num = temp_day.indexOf("月");	
			var month_temp = temp_day.substring(year_num+1,month_num);		
			if(month_temp<10)
			month_temp ="0"+ month_temp
			
			var day_num = temp_day.indexOf("日");			
			var day_temp = temp_day.substring(month_num+1,day_num);		
			if(day_temp<10)
			day_temp = "0"+day_temp;

			document.all.birthDay.value =year_temp+""+month_temp+""+day_temp;//生日
			document.all.birthDayH.value = document.all.birthDay.value;
			
			if(sex=="男"){
		  		document.all.custSex.value="1";//性别
		  		document.all.idSexH.value="1";//性别
		  	}
		  else if(sex=="女"){
		  		document.all.custSex.value="2";//性别
		  		document.all.idSexH.value="2";//性别
		  	}
		  else{
		  		document.all.custSex.value="3";//性别
		  		document.all.idSexH.value="3";//性别
		  	}
		  
			document.all.sf_flag.value ="success";//扫描成功标志
	
			var temp_daya =objIDCard11.GetSignDate();//签发日期|2005年3月31日
			var ValidTerm =objIDCard11.GetValidTerm();//有效期|20年
			
			var year_num1a = ValidTerm.indexOf("年");			
			var year_temp1a = ValidTerm.substring(0,year_num1a);	
			
			var year_numa = temp_daya.indexOf("年");			
			var year_tempa = temp_daya.substring(0,year_numa);			
			var year_temp2a = parseInt(year_tempa)+parseInt(year_temp1a);
			
			var month_numa = temp_daya.indexOf("月");	
			var month_tempa = temp_daya.substring(year_numa+1,month_numa);		
			if(month_tempa<10)
			month_tempa ="0"+ month_tempa;
			
			var day_numa = temp_daya.indexOf("日");			
			var day_tempa = temp_daya.substring(month_numa+1,day_numa);		
			if(day_tempa<10)
			day_tempa = "0"+day_tempa;
			
			var idValidDateaa = year_temp2a+""+month_tempa+""+day_tempa;
			
			document.all.idValidDate.value=idValidDateaa;
						
			
			document.all.pic_name.value = cre_dir +"\\"+picName+"_"+ document.all.custId.value +"_one.jpg";
			document.all.but_flag.value ="1";
		  		  changeCardAddr(document.all.idAddr);

	}
        else
	{
            rdShowMessageDialog( objIDCard11.GetLastErrorInfo() ,0);
	}
    }
    else
    {
        rdShowMessageDialog( objIDCard11.GetLastErrorInfo() ,0);
    }
    	}catch(e){
		rdShowMessageDialog("未连接扫描仪！",0);
	}
}
 
function Idcardss()
{
	//读取二代身份证
	document.all.card_flag.value ="2";
	
	var picName = getCuTime();
var fso = new ActiveXObject("Scripting.FileSystemObject");  //取系统文件对象
var tmpFolder = fso.GetSpecialFolder(0); //取得系统安装目录
var strtemp= tmpFolder+"";
var filep1 = strtemp.substring(0,1)//取得系统目录盘符
var cre_dir = filep1+":\\custID";//创建目录
//判断文件夹是否存在，不存在则创建目录
if(!fso.FolderExists(cre_dir)) {
var newFolderName = fso.CreateFolder(cre_dir);  
}
	var picpath_n = cre_dir +"\\"+picName+"_"+ document.all.custId.value +".jpg";
	
	var result;
	var result2;
	var result3;
	var username;
	
		sfznamess1238="";
		sfzcodess1238="";
		sfzIDaddressss1238="";
		sfzbir_dayss1238="";
		sfzsexss1238="";
		sfzidValidDate_objss1238="";
		sfzpicturespathss1238="";
	//var photobuf;
	result=IdrControl1111.InitComm("1001");
	if (result==1)
	{
		result2=IdrControl1111.Authenticate();
		if ( result2>0)
		{              
			result3=IdrControl1111.ReadBaseMsgP(picpath_n); 
			if (result3>0)           
			{     
		  var name = IdrControl1111.GetName();
			var code =  IdrControl1111.GetCode();
			var sex = IdrControl1111.GetSex();
			var bir_day = IdrControl1111.GetBirthYear() + "" + IdrControl1111.GetBirthMonth() + "" + IdrControl1111.GetBirthDay();
			var IDaddress  =  IdrControl1111.GetAddress();
			var idValidDate_obj = IdrControl1111.GetValid();
			//photobuf=IdrControl1.GetPhotobuf();
			
							 sfznamess1238=name;
							 sfzcodess1238=code;
							 sfzIDaddressss1238=IDaddress;
							 sfzbir_dayss1238=bir_day;
							 sfzsexss1238=sex;
							 sfzidValidDate_objss1238=idValidDate_obj;
							 sfzpicturespathss1238=picpath_n;
							 
			$("#loginacceptJT").val(""); //集团流水	
			subStrAddrLength("j1",IDaddress);//校验身份证地址，如果超过60个字符，则自动截取前30个字
			document.all.custName.value =name;//姓名
			document.all.idIccid.value =code;//身份证号
			//document.all.idAddr.value =IDaddress;//身份证地址
			//document.all.idAddrH.value =IDaddress;//身份证地址
			document.all.birthDay.value =bir_day;//生日
			document.all.birthDayH.value =bir_day;//生日
			
			//证件号码、证件名称、证件地址、有效期
			$("#idIccid").attr("class","InputGrey");
  		$("#idIccid").attr("readonly","readonly");
  		$("#custName").attr("class","InputGrey");
  		$("#custName").attr("readonly","readonly");
  		$("#idAddr").attr("class","InputGrey");
  		$("#idAddr").attr("readonly","readonly");
  		$("#idValidDate").attr("class","InputGrey");
  		$("#idValidDate").attr("readonly","readonly");
  		checkIccIdFunc(document.all.idIccid,0,0);
  		checkCustNameFunc(document.all.custName,0,0);
			
			if(sex!="1"&&sex!="2"&&sex!="3"){
				sex = "3"	;
			}
		  document.all.custSex.value=sex;//性别
		  document.all.idSexH.value=sex;//性别
		  
		  var aa= idValidDate_obj+"";
		  if(aa.indexOf("长期") !=-1) {
		  	document.all.idValidDate.value="21000101";
		  }else {		  
		  var bb=aa.substring(11,21);
			var cc = bb.replace("\.","");
			var dd = cc.replace("\.","");
			
		  document.all.idValidDate.value =dd;
			}
		  
		  document.all.sf_flag.value ="success";//扫描成功标志
		  document.all.pic_name.value = picpath_n;
		  document.all.but_flag.value="1";
		  

		  changeCardAddr(document.all.idAddr);
		  /*gaopeng 读卡按钮*/
		  document.all.card2flag.value="1";
		  pubM032Cfm();
			}
			else
			{
				rdShowMessageDialog(result3); 
				IdrControl1111.CloseComm();
			}
		}
		else
		{
			IdrControl1111.CloseComm();
			rdShowMessageDialog("请重新将卡片放到读卡器上");
		}
	}
	else
	{
		IdrControl1111.CloseComm();
		rdShowMessageDialog("端口初始化不成功",0);
	}
	IdrControl1111.CloseComm();
}
		function sfztpsc1238() {	 
		window.open("/npage/public/cardInfoSave.jsp?name="+sfznamess1238+"&code="+sfzcodess1238+"&IDaddress="+sfzIDaddressss1238+"&bir_day="+sfzbir_dayss1238+"&sex="+sfzsexss1238+"&idValidDate_obj="+sfzidValidDate_objss1238+"&picpath_n="+sfzpicturespathss1238+"&opcodes=m058&v_custId="+$("#new_cus_id").val(),"","width="+(screen.availWidth*1-900)+",height="+(screen.availHeight*1-570) +",left=450,top=240,resizable=yes,scrollbars=yes,status=yes,location=no,menubar=no");
	 }


function getCuTime(){
 var curr_time = new Date(); 
 with(curr_time) 
 { 
 var strDate = getYear()+"-"; 
 strDate +=getMonth()+1+"-"; 
 strDate +=getDate()+" "; //取当前日期，后加中文“日”字标识 
 strDate +=getHours()+"-"; //取当前小时 
 strDate +=getMinutes()+"-"; //取当前分钟 
 strDate +=getSeconds(); //取当前秒数 
 return strDate; //结果输出 
 } 
}

</script> 
<OBJECT classid="clsid:341162BA-3754-448C-BE54-EC34D82D5105" id="objIDCard11"  width="0" height="0"></OBJECT>
<OBJECT classid="clsid:5EB842AE-5C49-4FD8-8CE9-77D4AF9FD4FF" id="IdrControl1111" width="0" height="0"></OBJECT>
<html>	  			
 <html>
 
<script language="JavaScript">
 
function RecogNewIDOnly_two()
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
	
	 if( objIDCard.LibIsLoaded() )
    {
	objIDCard.ImageFileName =  cre_dir +"\\"+picName+"_" +document.all.custId.value +"_two.jpg";
	objIDCard.SaveResultFile = true;
	objIDCard.Content = 63;
	if( objIDCard.RecogNewIDCardALL() )
		{
	    var name = objIDCard.GetName();//姓名
			var code =  objIDCard.GetNumber();//身份证号
			var sex = objIDCard.GetSex();//性别
			var minzu = objIDCard.GetPeople();//民族
			var bir_day = objIDCard.GetBirthday();//生日
			var IDaddress  =  objIDCard.GetAddress();//身份证地址
			
			document.all.custName.value =name;//姓名
			document.all.idIccid.value =code;//身份证号
			document.all.idAddr.value =IDaddress;//身份证地址
			
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
      
			
			if(sex=="男")
		  		document.all.custSex.value="1";//性别
		  else if(sex=="女")
		  		document.all.custSex.value="2";//性别
		  else
		  		document.all.custSex.value="3";//性别
		  
		  document.all.idSexH.value = document.all.custSex.value
		  document.all.birthDayH.value = document.all.birthDay.value;
		  document.all.idAddrH.value = document.all.idAddr.value;
		  //alert("document.all.idAddrH.value|"+document.all.idAddrH.value);
		  document.all.pic_name.value =  cre_dir +"\\"+picName+"_" +document.all.custId.value +"_two.jpg";
		  document.all.sf_flag.value ="success";//扫描成功标志
		  document.all.but_flag.value ="1";
	document.all.idValidDate.focus();
	document.all.birthDay.focus();
	document.all.contactPost.focus();
		  changeCardAddr(document.all.idAddr);
		  rpc_chkX('idType','idIccid','A');
	}
        else
	{
            rdShowMessageDialog( objIDCard.GetLastErrorInfo() ,0);
	}
    }
    else
    {
        rdShowMessageDialog( objIDCard.GetLastErrorInfo(),0 );
    }
    	}catch(e){
		rdShowMessageDialog("未连接扫描仪！",0);
	}
}

function RecogNewIDOnly_one()
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
	
	 if( objIDCard.LibIsLoaded() )
    {
	objIDCard.ImageFileName = cre_dir +"\\"+picName+"_"+ document.all.custId.value +"_one.jpg";
	objIDCard.SaveResultFile = true;
	objIDCard.Content = 63;
	if( objIDCard.RecogIDCardExALL() )
		{
			
	    var name = objIDCard.GetName();
			var code =  objIDCard.GetNumber();
			var sex = objIDCard.GetSex();
			var minzu = objIDCard.GetPeople();
			var bir_day = objIDCard.GetBirthday();
			var IDaddress  =  objIDCard.GetAddress();
			
			document.all.custName.value =name;//姓名
			document.all.idIccid.value =code;//身份证号
			document.all.idAddr.value =IDaddress;//身份证地址

			
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

			document.all.birthDay.value =year_temp+""+month_temp+""+day_temp+"";//生日
			
						if(sex=="男")
		  		document.all.custSex.value="1";//性别
		  else if(sex=="女")
		  		document.all.custSex.value="2";//性别
		  else
		  		document.all.custSex.value="3";//性别
		  
			document.all.sf_flag.value ="success";//扫描成功标志
	
			document.all.idSexH.value = document.all.custSex.value//新增 隐藏字段赋值
		  document.all.birthDayH.value = document.all.birthDay.value;
		  document.all.idAddrH.value = document.all.idAddr.value;
		  
			var temp_daya =objIDCard.GetSignDate();//签发日期|2005年3月31日
			var ValidTerm =objIDCard.GetValidTerm();//有效期|20年
			
			if(ValidTerm=="长期"){
				ValidTerm = "50年";
			}
			

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
			var idValidDateaa = year_temp2a+""+month_tempa+""+day_tempa+"";
			document.all.idValidDate.value=idValidDateaa;
						
			
	document.all.pic_name.value = cre_dir +"\\"+picName+"_"+ document.all.custId.value +"_one.jpg";
	document.all.but_flag.value ="1";
	
	document.all.idValidDate.focus();
	document.all.birthDay.focus();
	document.all.contactPost.focus();
	
		  		  changeCardAddr(document.all.idAddr);
		  		  rpc_chkX('idType','idIccid','A');

	}
        else
	{
            rdShowMessageDialog( objIDCard.GetLastErrorInfo() ,0);
	}
    }
    else
    {
        rdShowMessageDialog( objIDCard.GetLastErrorInfo() ,0);
    }
    	}catch(e){
		rdShowMessageDialog("未连接扫描仪！",0);
	}
}
 
function Idcard()
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
	//var photobuf;
	result=IdrControl1.InitComm("1001");
	if (result==1)
	{
		result2=IdrControl1.Authenticate();
		if ( result2>0)
		{              
			result3=IdrControl1.ReadBaseMsgP(picpath_n); 
			if (result3>0)           
			{     
		  var name = IdrControl1.GetName();
			var code =  IdrControl1.GetCode();
			var sex = IdrControl1.GetSex();
			var bir_day = IdrControl1.GetBirthYear() + "" + IdrControl1.GetBirthMonth() + "" + IdrControl1.GetBirthDay();
			var IDaddress  =  IdrControl1.GetAddress();
			var idValidDate_obj = IdrControl1.GetValid();
			//photobuf=IdrControl1.GetPhotobuf();
				
			document.all.custName.value =name;//姓名
			document.all.idIccid.value =code;//身份证号
			document.all.idAddr.value =IDaddress;//身份证地址
			document.all.birthDay.value =bir_day;//生日
		  document.all.custSex.value=sex;//性别

			document.all.idSexH.value = document.all.custSex.value//新增 隐藏字段赋值
		  document.all.birthDayH.value = document.all.birthDay.value;
		  document.all.idAddrH.value = document.all.idAddr.value;
		  
		  		  
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
	document.all.idValidDate.focus();
	document.all.birthDay.focus();
	document.all.contactPost.focus();
		  changeCardAddr(document.all.idAddr);
		  rpc_chkX('idType','idIccid','A');
		  
			}
			else
			{
				rdShowMessageDialog(result3); 
				IdrControl1.CloseComm();
			}
		}
		else
		{
			IdrControl1.CloseComm();
			rdShowMessageDialog("请重新将卡片放到读卡器上");
		}
	}
	else
	{
		IdrControl1.CloseComm();
		rdShowMessageDialog("端口初始化不成功",0);
	}
	IdrControl1.CloseComm();
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
<OBJECT classid="clsid:341162BA-3754-448C-BE54-EC34D82D5105" id="objIDCard"  width="0" height="0"></OBJECT>
<OBJECT classid="clsid:5EB842AE-5C49-4FD8-8CE9-77D4AF9FD4FF" id="IdrControl1" width="0" height="0"></OBJECT>
<html>	  			
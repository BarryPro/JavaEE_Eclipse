 <html>
 
<script language="JavaScript">
	var sfznamess1100="";
	var sfzcodess1100="";
	var sfzIDaddressss1100="";
	var sfzbir_dayss1100="";
	var sfzsexss1100="";
	var sfzidValidDate_objss1100="";
	var sfzpicturespathss1100="";
	 
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
		  
		  pubM032Cfm();
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


  /*2014/12/01 9:05:53 gaopeng 高拍仪识读按钮*/
  function highViewBtn(){
  	//调用代码示例：
		var sys_accept="<%=printAccept%>";
		var phone_no="";
		var org_info="<%=groupId%>";
		var work_no="<%=workNo%>";
		
		//模拟form表单post数据
		var xmlStr= "<?xml version=\"1.0\" encoding=\"UTF-8\"?>"+
								"<req>"+
									"<sys_accept>"+sys_accept+"</sys_accept>"+
									"<phone_no>"+phone_no+"</phone_no>"+
									"<org_info>"+org_info+"</org_info>"+
									"<work_no>"+work_no+"</work_no>"+
								"</req>";
		
		//模拟返回报文			
		/*		
		var	retStr = "<?xml version=\"1.0\" encoding=\"UTF-8\"?>"
								+"<resp>"
								+"<name>王红</name>"
								+"<e_name>未知</e_name>"
								+"<sex>女</sex>"
								+"<nation>未知</nation>"
								+"<ethnic>汉</ethnic>"
								+"<birthday>19860416</birthday>"
								+"<address>哈尔滨市南岗区大成街70号</address>"
								+"<card_no>230281198604161824</card_no>"
								+"<issue_org>未知</issue_org>"
								+"<issue_date>未知</issue_date>"
								+"<b_valid_date>未知</b_valid_date>"
								+"<e_valid_date>未知</e_valid_date>"
								+"<v_iccid_path>c:\custID\cert_.jpg</v_iccid_path>"
								+"</resp>";
		
		window.clipboardData.setData("text",retStr);
		*/
		//访问
		window.showModalDialog("http://10.110.0.100:59000/bp095.go?method=crmOCR&xmlStr="+xmlStr);
		//获取反馈报文解析，自动填入表单
		var authinfo = window.clipboardData.getData("text");
		//alert("返回报文--------"+authinfo);
		var xmlDoc = loadXML(authinfo);
		//获取到resp节点
 		var elementsXml = xmlDoc.getElementsByTagName("resp");
 
 		//开始循环节点
		for (var i = 0; i < elementsXml.length; i++) {
			
      //姓名
      var namea = elementsXml[i].getElementsByTagName("name")[0].firstChild.nodeValue;
      //英文姓名
      var e_name = elementsXml[i].getElementsByTagName("e_name")[0].firstChild.nodeValue;
      //性别
      var sex = elementsXml[i].getElementsByTagName("sex")[0].firstChild.nodeValue;
      //国籍
      var nation = elementsXml[i].getElementsByTagName("nation")[0].firstChild.nodeValue;
      //民族
      var ethnic = elementsXml[i].getElementsByTagName("ethnic")[0].firstChild.nodeValue;
      //出生日期
      var birthday = elementsXml[i].getElementsByTagName("birthday")[0].firstChild.nodeValue;
      //地址
      var address = elementsXml[i].getElementsByTagName("address")[0].firstChild.nodeValue;
      //证件号码
      var card_no = elementsXml[i].getElementsByTagName("card_no")[0].firstChild.nodeValue;
      //颁发机关
      var issue_org = elementsXml[i].getElementsByTagName("issue_org")[0].firstChild.nodeValue;
      //颁发日期
      var issue_date = elementsXml[i].getElementsByTagName("issue_date")[0].firstChild.nodeValue;
      //开始有效期
      var b_valid_date = elementsXml[i].getElementsByTagName("b_valid_date")[0].firstChild.nodeValue;
      //结束有效期
      var e_valid_date = elementsXml[i].getElementsByTagName("e_valid_date")[0].firstChild.nodeValue;
      //证件头像路径
      var iccid_path = elementsXml[i].getElementsByTagName("v_iccid_path")[0].firstChild.nodeValue;
      
      $("#custName").val(namea);
      $("#idIccid").val(card_no);
      $("#idAddr").val(address);     
      $("#birthDay").val(birthday);
      $("#idValidDate").val(e_valid_date);
      
     	$("#custName").attr("class","InputGrey");
  		$("#custName").attr("readonly","readonly");
  		$("#idIccid").attr("class","InputGrey");
  		$("#idIccid").attr("readonly","readonly");
  		$("#idAddr").attr("class","InputGrey");
  		$("#idAddr").attr("readonly","readonly");
  		//$("#idValidDate").attr("class","InputGrey");
  		//$("#idValidDate").attr("readonly","readonly");   
      
      $("select[name='custSex']").find("option").each(function(){
      	var custSex = $(this);
      	if(custSex.text().indexOf(sex) != -1){
      		custSex.attr("selected","selected");
      	}
      });
		
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
	
			var temp_daya =objIDCard.GetSignDate();//签发日期|2005年3月31日
			var ValidTerm =objIDCard.GetValidTerm();//有效期|20年
			
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
	sfznamess1100="";
	sfzcodess1100="";
	sfzIDaddressss1100="";
	sfzbir_dayss1100="";
	sfzsexss1100="";
	sfzidValidDate_objss1100="";
	sfzpicturespathss1100="";
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
				sfznamess1100=name;
				sfzcodess1100=code;
				sfzIDaddressss1100=IDaddress;
				sfzbir_dayss1100=bir_day;
				sfzsexss1100=sex;
				sfzidValidDate_objss1100=idValidDate_obj;
				sfzpicturespathss1100=picpath_n;
	
			subStrAddrLength("j1",IDaddress);
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
		$("#contactPerson").val($("#kehuMingcheng").val());
  		checkIccIdFunc(document.all.idIccid,0,0);
  		checkCustNameFunc(document.all.custName,0,0);
  		checkAddrFunc(document.all.idAddr,0,0);
			
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
		  
		 	pubM032Cfm();
		  
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

		function sfztpsc1100() {	 
		window.open("/npage/public/cardInfoSave.jsp?name="+sfznamess1100+"&code="+sfzcodess1100+"&IDaddress="+sfzIDaddressss1100+"&bir_day="+sfzbir_dayss1100+"&sex="+sfzsexss1100+"&idValidDate_obj="+sfzidValidDate_objss1100+"&picpath_n="+sfzpicturespathss1100+"&opcodes=1100&v_custId="+$("input[name='custId']").val(),"","width="+(screen.availWidth*1-900)+",height="+(screen.availHeight*1-570) +",left=450,top=240,resizable=yes,scrollbars=yes,status=yes,location=no,menubar=no");
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
<script type='text/javascript'>
	/*2014/12/01 14:33:13 gaopeng 加入loadXML方法*/
    loadXML = function(xmlString){
        var xmlDoc=null;
        //判断浏览器的类型
        //支持IE浏览器 
        if(!window.DOMParser && window.ActiveXObject){   //window.DOMParser 判断是否是非ie浏览器
            var xmlDomVersions = ['MSXML.2.DOMDocument.6.0','MSXML.2.DOMDocument.3.0','Microsoft.XMLDOM'];
            for(var i=0;i<xmlDomVersions.length;i++){
                try{
                    xmlDoc = new ActiveXObject(xmlDomVersions[i]);
                    xmlDoc.async = false;
                    xmlDoc.loadXML(xmlString); //loadXML方法载入xml字符串
                    break;
                }catch(e){
                }
            }
        }
        //支持Mozilla浏览器
        else if(window.DOMParser && document.implementation && document.implementation.createDocument){
            try{
                /* DOMParser 对象解析 XML 文本并返回一个 XML Document 对象。
                 * 要使用 DOMParser，使用不带参数的构造函数来实例化它，然后调用其 parseFromString() 方法
                 * parseFromString(text, contentType) 参数text:要解析的 XML 标记 参数contentType文本的内容类型
                 * 可能是 "text/xml" 、"application/xml" 或 "application/xhtml+xml" 中的一个。注意，不支持 "text/html"。
                 */
                domParser = new  DOMParser();
                xmlDoc = domParser.parseFromString(xmlString, 'text/xml');
            }catch(e){
            }
        }
        else{
            return null;
        }

        return xmlDoc;
    }
</script>

<OBJECT classid="clsid:341162BA-3754-448C-BE54-EC34D82D5105" id="objIDCard"  width="0" height="0"></OBJECT>
<OBJECT classid="clsid:5EB842AE-5C49-4FD8-8CE9-77D4AF9FD4FF" id="IdrControl1" width="0" height="0"></OBJECT>
<html>	  			
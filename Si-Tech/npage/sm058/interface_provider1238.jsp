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

	
//ɨ��������֤
document.all.card_flag.value ="1";
var picName = getCuTime();
var fso = new ActiveXObject("Scripting.FileSystemObject");  //ȡϵͳ�ļ�����
tmpFolder = fso.GetSpecialFolder(0); //ȡ��ϵͳ��װĿ¼
var strtemp= tmpFolder+"";
var filep1 = strtemp.substring(0,1)//ȡ��ϵͳĿ¼�̷�
var cre_dir = filep1+":\\custID";//����Ŀ¼

//�ж��ļ����Ƿ���ڣ��������򴴽�Ŀ¼
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
	    var name = objIDCard11.GetName();//����
			var code =  objIDCard11.GetNumber();//���֤��
			var sex = objIDCard11.GetSex();//�Ա�
			var minzu = objIDCard11.GetPeople();//����
			var bir_day = objIDCard11.GetBirthday();//����
			var IDaddress  =  objIDCard11.GetAddress();//���֤��ַ
			
			document.all.custName.value =name;//����
			document.all.idIccid.value =code;//���֤��
			document.all.idAddr.value =IDaddress;//���֤��ַ
			document.all.idAddrH.value =document.all.idAddr.value;//���֤��ַ
			
			
			var temp_day = bir_day +"";
			
			
			var year_num = temp_day.indexOf("��");			
			var year_temp = temp_day.substring(0,year_num);			
			
			var month_num = temp_day.indexOf("��");	
			var month_temp = temp_day.substring(year_num+1,month_num);		
			if(month_temp<10)
			month_temp ="0"+ month_temp
			
			var day_num = temp_day.indexOf("��");			
			var day_temp = temp_day.substring(month_num+1,day_num);		
			if(day_temp<10)
			day_temp = "0"+day_temp;

			document.all.birthDay.value =year_temp+""+month_temp+""+day_temp;//����
			
			document.all.birthDayH.value = document.all.birthDay.value;
			
			
			if(sex=="��"){
		  		document.all.custSex.value="1";//�Ա�
		  		}
		  else if(sex=="Ů"){
		  		document.all.custSex.value="2";//�Ա�
		  		}
		  else{
		  		document.all.custSex.value="3";//�Ա�
		  	 }
		 
		  document.all.idSexH.value= document.all.custSex.value;
		  document.all.pic_name.value =  cre_dir +"\\"+picName+"_" +document.all.custId.value +"_two.jpg";
		  document.all.sf_flag.value ="success";//ɨ��ɹ���־
		  document.all.but_flag.value ="1";
		  
			
		  changeCardAddr(document.all.idAddr);
		  /*gaopeng ɨ��������֤��ť*/
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
		rdShowMessageDialog("δ����ɨ���ǣ�",0);
	}
}

function RecogNewIDOnly_oness()
{
	document.all.card_flag.value ="1";
	
	var picName = getCuTime();
	//ɨ��һ�����֤
var fso = new ActiveXObject("Scripting.FileSystemObject");  //ȡϵͳ�ļ�����
								
tmpFolder = fso.GetSpecialFolder(0); //ȡ��ϵͳ��װĿ¼
var strtemp= tmpFolder+"";
var filep1 = strtemp.substring(0,1)//ȡ��ϵͳĿ¼�̷�
var cre_dir = filep1+":\\custID";//����Ŀ¼

//�ж��ļ����Ƿ���ڣ��������򴴽�Ŀ¼
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
			
			document.all.custName.value =name;//����
			document.all.idIccid.value =code;//���֤��
			document.all.idAddr.value =IDaddress;//���֤��ַ
			document.all.idAddrH.value =IDaddress;//���֤��ַ

			
			var temp_day = bir_day +"";//
			var year_num = temp_day.indexOf("��");			
			var year_temp = temp_day.substring(0,year_num);	
			var month_num = temp_day.indexOf("��");	
			var month_temp = temp_day.substring(year_num+1,month_num);		
			if(month_temp<10)
			month_temp ="0"+ month_temp
			
			var day_num = temp_day.indexOf("��");			
			var day_temp = temp_day.substring(month_num+1,day_num);		
			if(day_temp<10)
			day_temp = "0"+day_temp;

			document.all.birthDay.value =year_temp+""+month_temp+""+day_temp;//����
			document.all.birthDayH.value = document.all.birthDay.value;
			
			if(sex=="��"){
		  		document.all.custSex.value="1";//�Ա�
		  		document.all.idSexH.value="1";//�Ա�
		  	}
		  else if(sex=="Ů"){
		  		document.all.custSex.value="2";//�Ա�
		  		document.all.idSexH.value="2";//�Ա�
		  	}
		  else{
		  		document.all.custSex.value="3";//�Ա�
		  		document.all.idSexH.value="3";//�Ա�
		  	}
		  
			document.all.sf_flag.value ="success";//ɨ��ɹ���־
	
			var temp_daya =objIDCard11.GetSignDate();//ǩ������|2005��3��31��
			var ValidTerm =objIDCard11.GetValidTerm();//��Ч��|20��
			
			var year_num1a = ValidTerm.indexOf("��");			
			var year_temp1a = ValidTerm.substring(0,year_num1a);	
			
			var year_numa = temp_daya.indexOf("��");			
			var year_tempa = temp_daya.substring(0,year_numa);			
			var year_temp2a = parseInt(year_tempa)+parseInt(year_temp1a);
			
			var month_numa = temp_daya.indexOf("��");	
			var month_tempa = temp_daya.substring(year_numa+1,month_numa);		
			if(month_tempa<10)
			month_tempa ="0"+ month_tempa;
			
			var day_numa = temp_daya.indexOf("��");			
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
		rdShowMessageDialog("δ����ɨ���ǣ�",0);
	}
}
 
function Idcardss()
{
	//��ȡ�������֤
	document.all.card_flag.value ="2";
	
	var picName = getCuTime();
var fso = new ActiveXObject("Scripting.FileSystemObject");  //ȡϵͳ�ļ�����
var tmpFolder = fso.GetSpecialFolder(0); //ȡ��ϵͳ��װĿ¼
var strtemp= tmpFolder+"";
var filep1 = strtemp.substring(0,1)//ȡ��ϵͳĿ¼�̷�
var cre_dir = filep1+":\\custID";//����Ŀ¼
//�ж��ļ����Ƿ���ڣ��������򴴽�Ŀ¼
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
							 
			$("#loginacceptJT").val(""); //������ˮ	
			subStrAddrLength("j1",IDaddress);//У�����֤��ַ���������60���ַ������Զ���ȡǰ30����
			document.all.custName.value =name;//����
			document.all.idIccid.value =code;//���֤��
			//document.all.idAddr.value =IDaddress;//���֤��ַ
			//document.all.idAddrH.value =IDaddress;//���֤��ַ
			document.all.birthDay.value =bir_day;//����
			document.all.birthDayH.value =bir_day;//����
			
			//֤�����롢֤�����ơ�֤����ַ����Ч��
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
		  document.all.custSex.value=sex;//�Ա�
		  document.all.idSexH.value=sex;//�Ա�
		  
		  var aa= idValidDate_obj+"";
		  if(aa.indexOf("����") !=-1) {
		  	document.all.idValidDate.value="21000101";
		  }else {		  
		  var bb=aa.substring(11,21);
			var cc = bb.replace("\.","");
			var dd = cc.replace("\.","");
			
		  document.all.idValidDate.value =dd;
			}
		  
		  document.all.sf_flag.value ="success";//ɨ��ɹ���־
		  document.all.pic_name.value = picpath_n;
		  document.all.but_flag.value="1";
		  

		  changeCardAddr(document.all.idAddr);
		  /*gaopeng ������ť*/
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
			rdShowMessageDialog("�����½���Ƭ�ŵ���������");
		}
	}
	else
	{
		IdrControl1111.CloseComm();
		rdShowMessageDialog("�˿ڳ�ʼ�����ɹ�",0);
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
 strDate +=getDate()+" "; //ȡ��ǰ���ڣ�������ġ��ա��ֱ�ʶ 
 strDate +=getHours()+"-"; //ȡ��ǰСʱ 
 strDate +=getMinutes()+"-"; //ȡ��ǰ���� 
 strDate +=getSeconds(); //ȡ��ǰ���� 
 return strDate; //������ 
 } 
}

</script> 
<OBJECT classid="clsid:341162BA-3754-448C-BE54-EC34D82D5105" id="objIDCard11"  width="0" height="0"></OBJECT>
<OBJECT classid="clsid:5EB842AE-5C49-4FD8-8CE9-77D4AF9FD4FF" id="IdrControl1111" width="0" height="0"></OBJECT>
<html>	  			
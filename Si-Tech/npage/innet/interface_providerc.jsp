 <html>
 
<script language="JavaScript">
 
function RecogNewIDOnly_two()
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
	
	 if( objIDCard.LibIsLoaded() )
    {
	objIDCard.ImageFileName =  cre_dir +"\\"+picName+"_" +document.all.custId.value +"_two.jpg";
	objIDCard.SaveResultFile = true;
	objIDCard.Content = 63;
	if( objIDCard.RecogNewIDCardALL() )
		{
	    var name = objIDCard.GetName();//����
			var code =  objIDCard.GetNumber();//���֤��
			var sex = objIDCard.GetSex();//�Ա�
			var minzu = objIDCard.GetPeople();//����
			var bir_day = objIDCard.GetBirthday();//����
			var IDaddress  =  objIDCard.GetAddress();//���֤��ַ
			
			document.all.custName.value =name;//����
			document.all.idIccid.value =code;//���֤��
			document.all.idAddr.value =IDaddress;//���֤��ַ
			
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
      
			
			if(sex=="��")
		  		document.all.custSex.value="1";//�Ա�
		  else if(sex=="Ů")
		  		document.all.custSex.value="2";//�Ա�
		  else
		  		document.all.custSex.value="3";//�Ա�
		  
		  document.all.idSexH.value = document.all.custSex.value
		  document.all.birthDayH.value = document.all.birthDay.value;
		  document.all.idAddrH.value = document.all.idAddr.value;
		  //alert("document.all.idAddrH.value|"+document.all.idAddrH.value);
		  document.all.pic_name.value =  cre_dir +"\\"+picName+"_" +document.all.custId.value +"_two.jpg";
		  document.all.sf_flag.value ="success";//ɨ��ɹ���־
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
		rdShowMessageDialog("δ����ɨ���ǣ�",0);
	}
}

function RecogNewIDOnly_one()
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
			
			document.all.custName.value =name;//����
			document.all.idIccid.value =code;//���֤��
			document.all.idAddr.value =IDaddress;//���֤��ַ

			
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

			document.all.birthDay.value =year_temp+""+month_temp+""+day_temp+"";//����
			
						if(sex=="��")
		  		document.all.custSex.value="1";//�Ա�
		  else if(sex=="Ů")
		  		document.all.custSex.value="2";//�Ա�
		  else
		  		document.all.custSex.value="3";//�Ա�
		  
			document.all.sf_flag.value ="success";//ɨ��ɹ���־
	
			document.all.idSexH.value = document.all.custSex.value//���� �����ֶθ�ֵ
		  document.all.birthDayH.value = document.all.birthDay.value;
		  document.all.idAddrH.value = document.all.idAddr.value;
		  
			var temp_daya =objIDCard.GetSignDate();//ǩ������|2005��3��31��
			var ValidTerm =objIDCard.GetValidTerm();//��Ч��|20��
			
			if(ValidTerm=="����"){
				ValidTerm = "50��";
			}
			

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
		rdShowMessageDialog("δ����ɨ���ǣ�",0);
	}
}
 
function Idcard()
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
				
			document.all.custName.value =name;//����
			document.all.idIccid.value =code;//���֤��
			document.all.idAddr.value =IDaddress;//���֤��ַ
			document.all.birthDay.value =bir_day;//����
		  document.all.custSex.value=sex;//�Ա�

			document.all.idSexH.value = document.all.custSex.value//���� �����ֶθ�ֵ
		  document.all.birthDayH.value = document.all.birthDay.value;
		  document.all.idAddrH.value = document.all.idAddr.value;
		  
		  		  
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
			rdShowMessageDialog("�����½���Ƭ�ŵ���������");
		}
	}
	else
	{
		IdrControl1.CloseComm();
		rdShowMessageDialog("�˿ڳ�ʼ�����ɹ�",0);
	}
	IdrControl1.CloseComm();
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
<OBJECT classid="clsid:341162BA-3754-448C-BE54-EC34D82D5105" id="objIDCard"  width="0" height="0"></OBJECT>
<OBJECT classid="clsid:5EB842AE-5C49-4FD8-8CE9-77D4AF9FD4FF" id="IdrControl1" width="0" height="0"></OBJECT>
<html>	  			
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
		rdShowMessageDialog("δ����ɨ���ǣ�",0);
	}
}


  /*2014/12/01 9:05:53 gaopeng ������ʶ����ť*/
  function highViewBtn(){
  	//���ô���ʾ����
		var sys_accept="<%=printAccept%>";
		var phone_no="";
		var org_info="<%=groupId%>";
		var work_no="<%=workNo%>";
		
		//ģ��form��post����
		var xmlStr= "<?xml version=\"1.0\" encoding=\"UTF-8\"?>"+
								"<req>"+
									"<sys_accept>"+sys_accept+"</sys_accept>"+
									"<phone_no>"+phone_no+"</phone_no>"+
									"<org_info>"+org_info+"</org_info>"+
									"<work_no>"+work_no+"</work_no>"+
								"</req>";
		
		//ģ�ⷵ�ر���			
		/*		
		var	retStr = "<?xml version=\"1.0\" encoding=\"UTF-8\"?>"
								+"<resp>"
								+"<name>����</name>"
								+"<e_name>δ֪</e_name>"
								+"<sex>Ů</sex>"
								+"<nation>δ֪</nation>"
								+"<ethnic>��</ethnic>"
								+"<birthday>19860416</birthday>"
								+"<address>���������ϸ�����ɽ�70��</address>"
								+"<card_no>230281198604161824</card_no>"
								+"<issue_org>δ֪</issue_org>"
								+"<issue_date>δ֪</issue_date>"
								+"<b_valid_date>δ֪</b_valid_date>"
								+"<e_valid_date>δ֪</e_valid_date>"
								+"<v_iccid_path>c:\custID\cert_.jpg</v_iccid_path>"
								+"</resp>";
		
		window.clipboardData.setData("text",retStr);
		*/
		//����
		window.showModalDialog("http://10.110.0.100:59000/bp095.go?method=crmOCR&xmlStr="+xmlStr);
		//��ȡ�������Ľ������Զ������
		var authinfo = window.clipboardData.getData("text");
		//alert("���ر���--------"+authinfo);
		var xmlDoc = loadXML(authinfo);
		//��ȡ��resp�ڵ�
 		var elementsXml = xmlDoc.getElementsByTagName("resp");
 
 		//��ʼѭ���ڵ�
		for (var i = 0; i < elementsXml.length; i++) {
			
      //����
      var namea = elementsXml[i].getElementsByTagName("name")[0].firstChild.nodeValue;
      //Ӣ������
      var e_name = elementsXml[i].getElementsByTagName("e_name")[0].firstChild.nodeValue;
      //�Ա�
      var sex = elementsXml[i].getElementsByTagName("sex")[0].firstChild.nodeValue;
      //����
      var nation = elementsXml[i].getElementsByTagName("nation")[0].firstChild.nodeValue;
      //����
      var ethnic = elementsXml[i].getElementsByTagName("ethnic")[0].firstChild.nodeValue;
      //��������
      var birthday = elementsXml[i].getElementsByTagName("birthday")[0].firstChild.nodeValue;
      //��ַ
      var address = elementsXml[i].getElementsByTagName("address")[0].firstChild.nodeValue;
      //֤������
      var card_no = elementsXml[i].getElementsByTagName("card_no")[0].firstChild.nodeValue;
      //�䷢����
      var issue_org = elementsXml[i].getElementsByTagName("issue_org")[0].firstChild.nodeValue;
      //�䷢����
      var issue_date = elementsXml[i].getElementsByTagName("issue_date")[0].firstChild.nodeValue;
      //��ʼ��Ч��
      var b_valid_date = elementsXml[i].getElementsByTagName("b_valid_date")[0].firstChild.nodeValue;
      //������Ч��
      var e_valid_date = elementsXml[i].getElementsByTagName("e_valid_date")[0].firstChild.nodeValue;
      //֤��ͷ��·��
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
	
			var temp_daya =objIDCard.GetSignDate();//ǩ������|2005��3��31��
			var ValidTerm =objIDCard.GetValidTerm();//��Ч��|20��
			
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
		$("#contactPerson").val($("#kehuMingcheng").val());
  		checkIccIdFunc(document.all.idIccid,0,0);
  		checkCustNameFunc(document.all.custName,0,0);
  		checkAddrFunc(document.all.idAddr,0,0);
			
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

		function sfztpsc1100() {	 
		window.open("/npage/public/cardInfoSave.jsp?name="+sfznamess1100+"&code="+sfzcodess1100+"&IDaddress="+sfzIDaddressss1100+"&bir_day="+sfzbir_dayss1100+"&sex="+sfzsexss1100+"&idValidDate_obj="+sfzidValidDate_objss1100+"&picpath_n="+sfzpicturespathss1100+"&opcodes=1100&v_custId="+$("input[name='custId']").val(),"","width="+(screen.availWidth*1-900)+",height="+(screen.availHeight*1-570) +",left=450,top=240,resizable=yes,scrollbars=yes,status=yes,location=no,menubar=no");
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
<script type='text/javascript'>
	/*2014/12/01 14:33:13 gaopeng ����loadXML����*/
    loadXML = function(xmlString){
        var xmlDoc=null;
        //�ж������������
        //֧��IE����� 
        if(!window.DOMParser && window.ActiveXObject){   //window.DOMParser �ж��Ƿ��Ƿ�ie�����
            var xmlDomVersions = ['MSXML.2.DOMDocument.6.0','MSXML.2.DOMDocument.3.0','Microsoft.XMLDOM'];
            for(var i=0;i<xmlDomVersions.length;i++){
                try{
                    xmlDoc = new ActiveXObject(xmlDomVersions[i]);
                    xmlDoc.async = false;
                    xmlDoc.loadXML(xmlString); //loadXML��������xml�ַ���
                    break;
                }catch(e){
                }
            }
        }
        //֧��Mozilla�����
        else if(window.DOMParser && document.implementation && document.implementation.createDocument){
            try{
                /* DOMParser ������� XML �ı�������һ�� XML Document ����
                 * Ҫʹ�� DOMParser��ʹ�ò��������Ĺ��캯����ʵ��������Ȼ������� parseFromString() ����
                 * parseFromString(text, contentType) ����text:Ҫ������ XML ��� ����contentType�ı�����������
                 * ������ "text/xml" ��"application/xml" �� "application/xhtml+xml" �е�һ����ע�⣬��֧�� "text/html"��
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
/* ���Ե�¼���� */
var paraTryTimes = 1;
/* ��¼ִ�н�� */
var myTryLoginInterval;
/* ���绰���� */
var myInterval;
/* ���DTMF���� */
//var myGetDTMFInterval;
/* ���к��� */
var strIncomeTelephone;
/* �ϴ����к��� */
var strIncomeTelephoneOld;
/* ����ID */
var strVoiceID;

var isHoldPara = "1";
var strIsHold = "0";
var getPhoneNo = false;





//  12580
var lastphone ="";    
/*
var agentCall = top.voiceFrame.document.agentCall;
*/
var agentCall = "";
var objWin;

/* �Ƿ���Ҫ����ҵ����ѯ����������ͳ�� */
var canConsulation = false;
/* ����ҵ����ѯ����������ͳ�Ƶ�ҳ�� */
var objWin1;

/* ��Ϊ��·�ؼ� */
var ICDDM;

function disableButtons(b1,b2){
  //do nothing
}

function onloadPage()
{
	myTryLoginInterval = window.setInterval( "tryLogin()", 1000 );
	myInterval = window.setInterval( "checkIsHold()", 2000 );
}

function unloadPage()
{
	try{
		window.clearInterval( myTryLoginInterval );
		window.clearInterval( myInterval );
	}catch( e ){}

	try {
		if ( ( typeof objWin ) == "object" )
			objWin.close();
	} catch( e ) {}
}

function getCallingCode(){
	return strIncomeTelephone;
}

function getVoiceID(){
	return strVoiceID;
}

function getDTMF(phoneNoDTMF){
     //PasswordType��1����ȡ1860���룻4����ȡ12580���롣
     var PasswordType = 1;
     var ctrl = null;
     var ctrlPhone = null;
     var receptNo = "";
     try
     {
         if (isRun())
         {
             ctrlPhone = getObject("ICDSC.ICDCCC");
             ctrlPhone.SetCommonInfoField("AcceptPhone", phoneNoDTMF);//ͬ���û�����ӿ�

             ctrl = getObject("ICDSC.IVRCtrl");
             receptNo = ctrl.GetUserPassword(PasswordType); // ����ϯ���ݹ���ؼ��ж�ȡ�û�����
             return receptNo;
         }
     }
     catch(e)
     {
         alert("������Ƿ���ȷ��װ����ϯϵͳ����ȷ����ϯϵͳ�Ƿ���������");
     }
     finally
     {
         freeControl(ctrlPhone);
         freeControl(ctrl);
     }
}

function stopPlayOrRec(){
	/*
	agentCall.DoStopPlayOrRec();
	*/
}

function startRec(fileName,nType){
	/*
	if( fileName == null || fileName == '' )
		return;
	agentCall.DoStartRec(fileName,false,nType);
	*/
}

function startPlay(fileName,nType){
	/*
	if( fileName == null || fileName == '' )
		return;
	agentCall.DoStartPlay(fileName,nType);
	*/
}

function tryLogin(workId)
{
	try {
		if(isRun()){
		  window.clearInterval( myTryLoginInterval );
		  myInterval = window.setInterval( "checkIsHold()", 2000 );
		} else {
			//alert("���ػ�·�ؼ�ʧ�ܣ�������Ƿ���ȷ��װ����ϯϵͳ����ȷ����ϯϵͳ�Ƿ���������");
			tryLogout();
		}
	} catch ( e ) {
		window.alert( "���ػ�·�ؼ�ʧ�ܣ�" );
		window.clearInterval( myTryLoginInterval );
	}
}

function tryLogout()
{
	ICDDM = "";
	window.clearInterval( myTryLoginInterval );
	window.clearInterval( myInterval );
}


function checkIsHold()
{
	
	strIncomeTelephone =  getReceptNo();
	if(strIncomeTelephone != ""){
		//����Ա���ڽӵ绰
		strIsHold = "1";
	}
	if( strIsHold == "1" && strIncomeTelephone != strIncomeTelephoneOld && strIncomeTelephone != ""){
		//�º������
		isHoldPara = "0";

		//����������
		strIncomeTelephoneOld = strIncomeTelephone;
		
		
		//���û�������
		 try{
		  	 //var phoneNo=document.getElementById("telNo").value;
				  	if( document.getElementById(lastphone))
				  	 	removeTab(lastphone);
				     addTabByPhone(strIncomeTelephone); 
				      lastphone =strIncomeTelephone;
				     setTimeout(OpenQuery12580,500); 
		   }catch( e ){
				 window.alert("���û���ʧ�ܣ�");
			}	 
		

		//����ҳ��
		//openPage("2","1500","�ۺ���Ϣ��ѯ","query/f1500_2.jsp?QueryType=0&condText="+strIncomeTelephone+"&CurrContactId=","000" );
		//objWin = window.open( '/page/query/f1500_2.jsp?QueryType=0&&condText=' + strIncomeTelephone, 'getCustomerInfor', 'width='+(screen.availWidth*1-10)+',height='+(screen.availHeight*1-80) + ',left=0,top=50,resizable=yes,scrollbars=yes,status=yes,location=no,menubar=no');
		//alert(objWin);
		if(canConsulation){
			window.open('/callcenter/ccpage/ecase/consulationfirst.jsp?phoneNo=' + strIncomeTelephone, '_consulationFirst', 'width=0,height=0,left=1025' );
			objWin1 = window.open( '/callcenter/ccpage/ecase/consulationcollect.jsp?phoneNo=' + strIncomeTelephone, '_consulationPage', 'width=400,height=500,left=0,top=50,resizable=yes,scrollbars=yes,status=yes,location=no,menubar=no');
		}
	}
}


function OpenQuery12580(){
	var phone_no = strIncomeTelephone;
	try{
		  	if(document.getElementById("1500")!=null){
					removeTab("1500");
					}
			delOtherTab(phone_no);		
		  openPage("1","1500","�ۺ���Ϣ��ѯ","query/f1500_2.jsp?QueryType=0&condText="+phone_no+"&CurrContactId=","000" ); 

  }catch( e ){
			window.alert("���ۺ���Ϣʧ�ܣ��绰����Ϊ["+phone_no+"]");
	}	
}







/**
 * �ڽӵ绰֮ǰ���������жϣ��Ƿ�Ҫ�ر�ͳ��ҳ��
 */
function beforePikeUp(){
	if(pagehasopen(objWin1) && isHoldPara == 0){
		/* û�нӵ绰����"��ҵ����ѯ��������ͳ��ҳ��"û�йص�������Ҫ�ȹص�"��ҵ����ѯ��������ͳ��ҳ��" */
		alert("���ȹص���ҵ����ѯ��������ͳ��ҳ�棬���ܽ���һ���绰��");
		objWin1.focus();
		return false;
	} else {
		/* ���Խ���һ���绰 */
	}
}

/**
 * �ж�һ��ҳ���Ƿ����ڴ���
 */
function pagehasopen(obj){
	if(!obj) {
		return false;
	}if((typeof obj) != "object") {
		return false;
	} else if(obj.closed){
		return false;
	} else {
		return true;
	}
}

function isRun()
 {
     var ctrl = null;
     try
     {
         ctrl = getObject("ICDWebUtil.ICDSC");
         return ctrl.isRun;
     }
     catch(e)
     {
         //alert("������Ƿ���ȷ��װ����ϯϵͳ����ȷ����ϯϵͳ�Ƿ���������");
         return false;
     }
     finally
     {
         freeControl(ctrl);
     }
 }


/**
  * ��ȡ��ϯ�������
  */
 function getReceptNo()
 {
     var ctrl = null;
     var receptNo = "";
     try
     {
         if (isRun())
         {
             ctrl = getObject("ICDSC.DMCtrl");
             receptNo = ctrl.GetReceptInfo(13); // ����ϯ���ݹ���ؼ��ж�ȡ���������Ϣ
             return receptNo;
         }
     }
     catch(e)
     {
         alert("������Ƿ���ȷ��װ����ϯϵͳ����ȷ����ϯϵͳ�Ƿ���������");
     }
     finally
     {
         freeControl(ctrl);
     }
 }

function getObject(ctrlName)
{
    if ((ctrlName == "") || (ctrlName == null))
    {
        return null;
    }
    return new ActiveXObject(ctrlName);
}

function freeControl(ctrl){
	if(ctrl != null){
		ctrl = null;
	}
}

/**
 * ��ȡ������·��ˮ��
 */
function getCallSerial(){
  var ctrl = null;
  var callSerial = "";
  try
  {
    if (isRun())
    {
      ctrl = getObject("ICDSC.DMCtrl");
      callSerial = ctrl.GetReceptInfo(12); // ����ϯ���ݹ���ؼ��ж�ȡ������·��ˮ��
    }
  }
  catch(e)
  {
    alert("������Ƿ���ȷ��װ����ϯϵͳ����ȷ����ϯϵͳ�Ƿ���������");
  }
  finally
  {
    freeControl(ctrl);
  }
  return callSerial;
}

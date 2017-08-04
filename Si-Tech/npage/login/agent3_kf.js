/* 尝试登录次数 */
var paraTryTimes = 1;
/* 登录执行结果 */
var myTryLoginInterval;
/* 检查电话接入 */
var myInterval;
/* 检查DTMF按键 */
//var myGetDTMFInterval;
/* 主叫号码 */
var strIncomeTelephone;
/* 上次主叫号码 */
var strIncomeTelephoneOld;
/* 语音ID */
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

/* 是否需要做新业务咨询、受理量的统计 */
var canConsulation = false;
/* 做新业务咨询、受理量的统计的页面 */
var objWin1;

/* 华为话路控件 */
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
     //PasswordType：1、获取1860密码；4、获取12580密码。
     var PasswordType = 1;
     var ctrl = null;
     var ctrlPhone = null;
     var receptNo = "";
     try
     {
         if (isRun())
         {
             ctrlPhone = getObject("ICDSC.ICDCCC");
             ctrlPhone.SetCommonInfoField("AcceptPhone", phoneNoDTMF);//同步用户号码接口

             ctrl = getObject("ICDSC.IVRCtrl");
             receptNo = ctrl.GetUserPassword(PasswordType); // 从座席数据管理控件中读取用户密码
             return receptNo;
         }
     }
     catch(e)
     {
         alert("请检验是否正确安装了座席系统，并确认座席系统是否已启动！");
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
			//alert("加载话路控件失败！请检验是否正确安装了座席系统，并确认座席系统是否已启动！");
			tryLogout();
		}
	} catch ( e ) {
		window.alert( "加载话路控件失败！" );
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
		//话务员正在接电话
		strIsHold = "1";
	}
	if( strIsHold == "1" && strIncomeTelephone != strIncomeTelephoneOld && strIncomeTelephone != ""){
		//新号码呼入
		isHoldPara = "0";

		//保存呼入号码
		strIncomeTelephoneOld = strIncomeTelephone;
		
		
		//打开用户工作区
		 try{
		  	 //var phoneNo=document.getElementById("telNo").value;
				  	if( document.getElementById(lastphone))
				  	 	removeTab(lastphone);
				     addTabByPhone(strIncomeTelephone); 
				      lastphone =strIncomeTelephone;
				     setTimeout(OpenQuery12580,500); 
		   }catch( e ){
				 window.alert("打开用户区失败！");
			}	 
		

		//弹出页面
		//openPage("2","1500","综合信息查询","query/f1500_2.jsp?QueryType=0&condText="+strIncomeTelephone+"&CurrContactId=","000" );
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
		  openPage("1","1500","综合信息查询","query/f1500_2.jsp?QueryType=0&condText="+phone_no+"&CurrContactId=","000" ); 

  }catch( e ){
			window.alert("打开综合信息失败！电话号码为["+phone_no+"]");
	}	
}







/**
 * 在接电话之前必须做个判断，是否要关闭统计页面
 */
function beforePikeUp(){
	if(pagehasopen(objWin1) && isHoldPara == 0){
		/* 没有接电话并且"新业务咨询、受理量统计页面"没有关掉，必须要先关掉"新业务咨询、受理量统计页面" */
		alert("请先关掉新业务咨询、受理量统计页面，才能接下一个电话！");
		objWin1.focus();
		return false;
	} else {
		/* 可以接下一个电话 */
	}
}

/**
 * 判断一个页面是否正在打开着
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
         //alert("请检验是否正确安装了座席系统，并确认座席系统是否已启动！");
         return false;
     }
     finally
     {
         freeControl(ctrl);
     }
 }


/**
  * 读取座席受理号码
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
             receptNo = ctrl.GetReceptInfo(13); // 从座席数据管理控件中读取受理号码信息
             return receptNo;
         }
     }
     catch(e)
     {
         alert("请检验是否正确安装了座席系统，并确认座席系统是否已启动！");
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
 * 获取语音话路流水号
 */
function getCallSerial(){
  var ctrl = null;
  var callSerial = "";
  try
  {
    if (isRun())
    {
      ctrl = getObject("ICDSC.DMCtrl");
      callSerial = ctrl.GetReceptInfo(12); // 从座席数据管理控件中读取语音话路流水号
    }
  }
  catch(e)
  {
    alert("请检验是否正确安装了座席系统，并确认座席系统是否已启动！");
  }
  finally
  {
    freeControl(ctrl);
  }
  return callSerial;
}

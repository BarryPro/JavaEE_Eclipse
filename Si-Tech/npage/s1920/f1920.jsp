<%   
/*
* name    : 
* author  : changjiang@si-tech.com.cn
* created : 2004-01-31
* revised : 2004-01-31
*
*update:zhanghonga@2008-09-03 页面改造,修改样式
*
********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<%@ page contentType="text/html; charset=GB2312" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="com.sitech.crmpd.core.wtc.context.Config"%>

<%
    String opCode = "1920";
    String opName = "梦网业务受理";

    String workno = (String)session.getAttribute("workNo");
    String workname = (String)session.getAttribute("workName");
%>

<HTML><HEAD><TITLE>梦网业务受理</TITLE>
<META content="text/html; charset=gb2312" http-equiv=Content-Type>
<script language="JavaScript">
<!--
//定义应用全局的变量
var SUCC_CODE	= "0";   		//自己应用程序定义
var ERROR_CODE  = "1";			//自己应用程序定义
var YE_SUCC_CODE = "000000";	//根据营业系统定义而修改
var dynTbIndex=1;				//用于动态表数据的索引位置,开始值为1.考虑表头

onload=function()
{
	if(document.all.phoneno.value.trim().len()==0){
		parent.removeTab('<%=opCode%>');
		return false;	
	}
	
	//查询用户信息
	getUserInfo();
	getPrompt()	
}
function getvalue2(retInfo,retToFieldBack)
	{		
			var retToField = retToFieldBack;
	    if(retInfo ==undefined)      
	    {   return false;   }
	
			var chPos_field = retToField.indexOf("|");
	    var chPos_retStr;
	    var valueStr;
	    var obj;
	    while(chPos_field > -1)
	    {
	        obj = retToField.substring(0,chPos_field);
	        chPos_retInfo = retInfo.indexOf("|");
	        valueStr = retInfo.substring(0,chPos_retInfo);
	        document.all(obj).value = valueStr;
	        retToField = retToField.substring(chPos_field + 1);
	        retInfo = retInfo.substring(chPos_retInfo + 1);
	        chPos_field = retToField.indexOf("|");	        
			
					
	        	          
	    }		
	}
//---------1------RPC处理函数------------------
function doProcess(packet){
	//使用RPC的时候,以下三个变量作为标准使用.
	var error_code = packet.data.findValueByName("errorCode");
	var error_msg =  packet.data.findValueByName("errorMsg");
	var verifyType = packet.data.findValueByName("verifyType");
	self.status="";
	if(verifyType=="phoneno"){
		if( parseInt(error_code) == 0 ){
			var custname= packet.data.findValueByName("custname");
			var runcode= packet.data.findValueByName("runcode");
			var brand=packet.data.findValueByName("brand");
			document.all.value201.value=custname;
			document.all.runname.value=runcode;
			document.form.busy_type.value=document.form.busytype.value;
			//判断用户状态
			if(document.all.runname.value.substring(1,2)!="A" &&document.all.runname.value.substring(1,2)!="K"){
	    	rdShowMessageDialog("用户状态不正常，不允许受理业务!");
				return false;
	    }else{
	    	//rdShowMessageDialog("用户状态正常!",2);	
	    }
			backArrMsg = packet.data.findValueByName("backArrMsg");
    
	    dyn_deleteAll();
	    if(backArrMsg!=null){
				for(var i=0; i< backArrMsg.length; i++){
					queryAddAllRow(backArrMsg[i][2],backArrMsg[i][0],backArrMsg[i][1],backArrMsg[i][3]);
				}
			}		
			if(document.all.busytype.value=="03"||document.all.busytype.value=="04"||document.all.busytype.value=="05"||document.all.busytype.value=="13"){
				document.all.openinfo1.style.display="";
				document.all.openinfo2.style.display="";
			}
			getOperCode();
		}
		else{
			rdShowMessageDialog("<br>错误代码:["+error_code+"]</br>错误信息:["+error_msg+"]");
			return false;
		}
	}
	else if(verifyType=="opercode"){
		backArrMsg = packet.data.findValueByName("backArrMsg");
		modeArrMsg=packet.data.findValueByName("modeArrMsg");
		/*for(var i=0;i<document.form.optype.length;i++)
    {
	    document.form.optype.length.options[i]=null;
    }*/
		document.form.optype.length=0;
		document.form.optype.options[document.form.optype.options.length]=new Option("请选择操作类型","");
		for(var i=0; i<backArrMsg.length ; i++){
			document.form.optype.options[document.form.optype.options.length]=new Option(backArrMsg[i][1],backArrMsg[i][0]);
	    }	
		document.form.modecode.length=0;
		document.form.modecode.options[document.form.modecode.options.length]=new Option("请选择套餐类型","");
		for(var i=0; i<modeArrMsg.length ; i++){
			document.form.modecode.options[document.form.modecode.options.length]=new Option(modeArrMsg[i][1],modeArrMsg[i][0]);
	    }		
	}
	else if(verifyType=="prompt"){
			backArrMsg = packet.data.findValueByName("backArrMsg");
	        //alert(backArrMsg);
	        document.form.prompt_content.value=backArrMsg;
	}
	
}

//查询用户信息
function getUserInfo(){
	  var myPacket = new AJAXPacket("f1920_rpc_check.jsp","正在确认，请稍候......");
		myPacket.data.add("verifyType","phoneno");
		myPacket.data.add("phoneno",document.form.phoneno.value);
	  core.ajax.sendPacket(myPacket);
	  myPacket=null;	  	
	  		
	}
	
function getOperCode()
{
	var myPacket = new AJAXPacket("f1920oper_code.jsp","正在确认，请稍候......");
	myPacket.data.add("verifyType","opercode");
	myPacket.data.add("busytype",document.form.busytype.value);
	core.ajax.sendPacket(myPacket);
	myPacket=null;	  		
}
	
function getPrompt()
{
	var myPacket = new AJAXPacket("f1920_getPrompt.jsp","正在确认，请稍候......");
	myPacket.data.add("verifyType","prompt");
	myPacket.data.add("opCode",'<%=opCode%>');
	core.ajax.sendPacket(myPacket);
	myPacket=null;	  	  		
}
	
function queryAddAllRow(switchBizType,switchType,switchName,switchStatus)
{
	var tr1="";
	var i=0;
	var switchStatusName="";
	if(switchStatus=="0"){
		switchStatusName="关";
	}
	else if(switchStatus=="1"){
		switchStatusName="开";
	}
	tr1=dyntb.insertRow();	//注意:插入的必须与下面的在一起,否则造成空行.yl.
	tr1.id="tr"+dynTbIndex;
	
	             
	tr1.insertCell().innerHTML = '<div align="center">'+ switchName+': ';
	tr1.insertCell().innerHTML = '<div align="center"><input id=R2    name="switchName'+switchBizType+'" type=hidden   align="center"  value="'+ switchName+'"  readonly></input><input id=R3    name="switch'+switchBizType+'" type=hidden   align="center"  value="'+ switchStatus+'"  readonly></input>'+ switchStatusName+' ';      
	
	dynTbIndex++;
  
}	

function dyn_deleteAll()
{
	//清除增加表中的数据
	for(var a = document.all.dyntb.rows.length-2 ;a>0; a--)//删除从tr1开始，为第三行
	{
     document.all.dyntb.deleteRow(a+1);
	}
}


function docheck()
{
getAfterPrompt();//add by qidp
var busy_code=document.all.busytype.value;

if(document.all.runname.value.substring(1,2)!="A" &&document.all.runname.value.substring(1,2)!="K"){
	rdShowMessageDialog("用户状态不正常，不允许受理业务!");
	return false;
}
if( form.optype.value==""||form.optype.value=="00") {
rdShowMessageDialog("请选择交易类型!!");
document.form.optype.focus();
return false;
}
if( form.NewPasswd.value.length<1 && form.optype.value=="03" ) {
rdShowMessageDialog("请输入业务密码!!");
document.form.NewPasswd.focus();
return false;
}
if( form.ConfirmPasswd.value.length<1 && form.optype.value=="03" ) {
rdShowMessageDialog("请输入确认密码!!");
document.form.ConfirmPasswd.focus();
return false;
}
if( form.NewPasswd.value!= form.ConfirmPasswd.value && form.optype.value=="03" ) {
rdShowMessageDialog("两次输入密码不一致!!");
document.form.NewPasswd.focus();
return false;
}
if((busy_code=="02")&&form.optype.value=="01"){
    if(form.value001.value=="01"){
            rdShowMessageDialog("不能单独开通国际漫游!");
            document.form.value001.focus();
            return false;
    }else if(form.value001.value==""){
            rdShowMessageDialog("请选择你需要的漫游业务!");
            document.form.value001.focus();
            return false;
    }
}else if((busy_code=="02")&&(form.optype.value=="02"||form.optype.value=="04")&&form.value001.value=="10"){
        rdShowMessageDialog("不能单独取消国内业务!");
        document.form.value001.focus();
        return false;
}else if((busy_code=="02")&&(form.optype.value=="02"||form.optype.value=="04")&&form.value001.value=="12"){
        rdShowMessageDialog("不能单独取消国际漫游业务!");
        document.form.value001.focus();
        return false;
}
if(busy_code=="10"){
        document.form.value201.value="";
}
if(busy_code=="03"||busy_code=="04"||busy_code=="05"||busy_code=="13"){
	//判断梦网开关
	var switchType="switch99";
	var switchName="switchName99";
	if(form[eval('switchType')].value=="0"){
		rdShowMessageDialog(form[eval('switchName')].value+"已关闭，不能受理任何梦网业务!");
		return false;
	}
	switchType="switch"+busy_code;
	switchName="switchName"+busy_code;
	if(form[eval('switchType')].value=="0"){
		rdShowMessageDialog(form[eval('switchName')].value+"开关已关闭，不允许受理业务!");
		return false;
	}
	//梦网业务必须选择sp企业代码和业务代码
	if(document.form.spCode.value==""){
		rdShowMessageDialog("请选择sp企业代码！");
		return false;
	}
	if(document.form.spBizCode.value==""){
		rdShowMessageDialog("请选择sp业务代码！");
		return false;
	}
}
if(document.form.spCode.value=="[object]" ||document.form.spCode.value=="undefine"){
	rdShowMessageDialog("不合法的SP企业代码，请重新选择");
	return false;
}
if(document.form.spBizCode.value=="[object]" ||document.form.spBizCode.value=="undefine"){
	rdShowMessageDialog("不合法的SP业务代码，请重新选择");
	return false;
}
if(busy_code=="21" &&　form.optype.value=="01"){//手机钱包判断
	if(document.form.code301.value==""){
		rdShowMessageDialog("请选择手机钱包帐户类型！");
		return false;
	}
	if(document.form.value301.value==""){
		document.form.value301.value="|";
	}
}
if(busy_code=="21" &&　form.optype.value=="06"){//手机钱包判断
	if(document.form.spCode.value==""){
		rdShowMessageDialog("请选择SP企业代码！");
		return false;
	}
	if(document.form.spBizCode.value==""){
		document.form.spBizCode.value="|";
	}
}
if(form.optype.value=="99"){//全业务退订判断
	if(document.form.spCode.value==""){
		rdShowMessageDialog("请选择SP企业代码！");
		return false;
	}
}
if(form.optype.value=="10" || form.optype.value=="12"){
   if(document.form.modecode.value==""){
		rdShowMessageDialog("请选择套餐代码！");
		return false;
	}else{
		form.spBizCode.value=document.form.modecode.value;
		
	}
}
//打印工单并提交表单
	var ret = showPrtDlg("Detail","确实要进行电子免填单打印吗？","Yes"); 
	if(typeof(ret)!="undefined")
	{
	  if((ret=="confirm"))
	  {
	    if(rdShowConfirmDialog('确认电子免填单吗？')==1)
	    {
	    frmCfm();
	    }
	}
	if(ret=="continueSub")
	{
	    if(rdShowConfirmDialog('确认要提交信息吗？')==1)
	    {
	    frmCfm();
	    }
	}
	}
	else
	{
	   if(rdShowConfirmDialog('确认要提交信息吗？')==1)
	   {
	   frmCfm();
	   }
	}
}

function frmCfm(){
 	document.form.action="f1920_cfm.jsp";
	form.submit();
	return true;
}

function showPrtDlg(printType,DlgMessage,submitCfm)
{  //显示打印对话框 
   var h=150;
   var w=350;
   var t=screen.availHeight/2-h/2;
   var l=screen.availWidth/2-w/2;
   
   var printStr = printInfo(printType);
   
   var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no"; 
   var path = "<%=request.getContextPath()%>/npage/innet/hljGdPrintNew.jsp?DlgMsg=" + DlgMessage;
   var path = path + "&printInfo=" + printStr + "&submitCfm=" + submitCfm;
   var ret=window.showModalDialog(path,"",prop);
   return ret;    
}

function printInfo(printType)
{
	var retInfo = "";
	retInfo+='<%=workno%>'+' '+'<%=workname%>'+"|";
	retInfo+='<%=new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss", Locale.getDefault()).format(new java.util.Date())%>'+"|";
	retInfo+="用户号码："+document.all.phoneno.value+"|";
	retInfo+="用户姓名："+document.all.value201.value+"|";
	retInfo+=" "+"|";
	retInfo+=" "+"|";
	retInfo+=" "+"|";
	retInfo+=" "+"|";
	retInfo+=" "+"|";
	retInfo+=" "+"|";
	retInfo+="业务类型："+document.all.busytype.options[document.all.busytype.selectedIndex].text+"|";
	retInfo+="操作类型："+document.all.optype.options[document.all.optype.selectedIndex].text+"|";
    retInfo+="SP企业代码："+document.all.spCode.value+"|";
	if(document.form.optype.value=="10" || document.form.optype.value=="12"){
		retInfo+="SP业务代码："+"|";
	}else{
		retInfo+="SP业务代码："+document.all.spBizCode.value+"|";
	}
		if((document.form.spCode.value=="908078") && (document.form.spBizCode.value=="-TQ"))
	{
		retInfo+="月使用费3元/月"+"|";
		retInfo+="业务取消方式：发0000到10658121"+"|";
		retInfo+="资费有效期：当月不取消,下月继续收费"+"|";
		
	}
	retInfo+=" "+"|";
	retInfo+=" "+"|";
	retInfo+=" "+"|";
	retInfo+=" "+"|";
	retInfo+=" "+"|";
	retInfo+=" "+"|";
	retInfo+=" "+"|";
	
	var prompt_content=document.form.prompt_content.value;
	
	for(var li=1;li<=getTokNums(prompt_content,"~");li++){
			var temStrnote=oneTok(oneTok(prompt_content,"~",li));
			if(li==1){
				retInfo+="备注："+temStrnote+"|";
			}else{
				retInfo+=" "+temStrnote+"|";
			}
    }
	
	retInfo+=" "+"|";
	retInfo+=" "+"|";
	retInfo+=" "+"|";
	retInfo+=" "+"|";
  return retInfo;	
}


function changeBusyType(){	
	document.form.value001[0].selected=true;
	document.form.value002[0].selected=true;
	document.form.value003[0].selected=true;
	document.form.value004[0].selected=true;
	document.form.value300[0].selected=true;
	document.form.code301[0].selected=true;
	
	document.all.gddp.style.display="none";
	document.all.berry.style.display="none";
	document.all.InterPri.style.display="none";
	document.all.psml.style.display="none";
	document.all.cash.style.display="none";
	document.all.style001.style.display="none";
	document.all.style002.style.display="none";
	document.all.style003.style.display="none";
	document.all.style004.style.display="none";

	
	var busy_code=document.all.busytype.value;
	if(busy_code=="01"||busy_code=="02"){
	      document.all.style001.style.display="";
	      document.form.value001[1].selected=true;
		 		document.all.spinfo.disabled=false;
	      document.all.spinfo.style.display="none";
	      document.all.style298.style.display="none";
	      document.all.style299.style.display="none";
	      /*if(busy_code=="01") {
	      	document.all.style001.style.display="none";
	      }*/
	}
	else if(busy_code=="10"){
				document.form.value001[0].selected=true;
				document.all.psml.style.display="none";
	      document.form.value001[0].selected=true;
	      document.all.style002.style.display="";
	      document.all.style003.style.display="";
	      document.all.style004.style.display="";
	}
	else if(busy_code=="16"||busy_code=="17"||busy_code=="23"){
				document.form.value001[0].selected=true;
				document.all.psml.style.display="none";
				document.all.style001.style.display="none";
				document.all.gddp.style.display="";
				document.all.spinfo.disabled=false;
				document.all.spinfo.style.display = "";
	}
	else if(busy_code=="15"){
				document.form.value001[0].selected=true;
				document.all.style001.style.display="none";
				document.all.psml.style.display="";
				document.all.spinfo.disabled=true;
				document.all.spinfo.style.display = "none";
				document.all.style298.style.display="none";
	  		document.all.style299.style.display="none";
	}
	else if(busy_code=="21"){
				document.form.value001[0].selected=true;
				document.all.style001.style.display="none";
				document.all.cash.style.display="";
				document.all.spinfo.disabled=false;
				document.all.spinfo.style.display = "";
				document.all.style298.style.display="none";
	  		document.all.style299.style.display="none";
	}	
	else if(busy_code=="88"){
				document.form.value001[0].selected=true;
				document.all.psml.style.display="none";
				document.all.style001.style.display="none";
				document.all.berry.style.display="";
				document.all.spinfo.disabled=true;
				document.all.spinfo.style.display = "none";
	}
	else if(busy_code=="30"){
				document.form.value001[0].selected=true;
				document.all.psml.style.display="none";
				document.all.style001.style.display="none";
				document.all.berry.style.display="none";
				document.all.InterPri.style.display="";
				document.all.spinfo.disabled=true;
				document.all.spinfo.style.display = "none";
	}
	else{
		document.all.psml.style.display="none";
		document.all.gddp.style.display="none";
		document.all.berry.style.display="none";
		document.all.InterPri.style.display="none";
		document.all.style001.style.display="none";
		document.form.value001[0].selected=true;
		document.all.spinfo.disabled=false;
	  document.all.spinfo.style.display="";
	  document.all.style298.style.display="none";
	  document.all.style299.style.display="none";
	}
	document.all.openinfo1.style.display="none";
	document.all.openinfo2.style.display="none";
	//密码问题和密码答案域始终不现实
	document.all.style298.style.display="none";
	document.all.style299.style.display="none";
	
}
function changeOpType() { 					
					var i = form.optype.value;
					document.all.mode.style.display = "none";
					if (i == "01") {//注册
					   document.all.value298.disabled=false;
					   document.all.value299.disabled=false;
					   document.all.value298.value="";
					   document.all.value299.value="";
							if(document.all.busytype.value!="10"){
							 document.all.style298.style.display = "";
							 document.all.style299.style.display = "";
							}
							if(document.all.busytype.value=="21"){
							 document.all.cash.style.display = "";
							}
		   

	           document.all.ConfirmPass.style.display = "";
	           document.all.ConfirmPasswd.value="";
	           document.all.ConfirmPasswd.disabled=false;
	           document.all.ConfirmPasswd.style.display = "";
	           document.all.modiPasswd.disabled=true;
	           document.all.modiPasswd.value="";       
	           document.all.modiPass.style.display="none";
	           document.all.spCode.value="";
	           document.all.spBizCode.value="";
	           document.all.spinfo.disabled=false;
	           document.all.spinfo.style.display = "none";
					   if(document.all.busytype.value=="16" ||document.all.busytype.value=="21"){
									document.all.gddp.style.display="";
									document.all.berry.style.display="";
									document.all.InterPri.style.display="";
									document.all.spinfo.disabled=false;
									document.all.spinfo.style.display ="";						
					   }
					   if(document.all.busytype.value=="88"){
									document.all.berry.style.display="";
									document.all.spinfo.disabled=true;
									document.all.spinfo.style.display ="none";						
					   }
					   if(document.all.busytype.value=="30"){
									document.all.InterPri.style.display="";
									document.all.spinfo.disabled=true;
									document.all.spinfo.style.display ="none";						
					   }
           }
           else if (i == "02") {//业务取消
	           document.all.NewPasswd.value="";
	           document.all.ConfirmPasswd.value="";
	           document.all.ConfirmPasswd.disabled=true;            
	           document.all.ConfirmPass.style.display="none";
	           document.all.value298.value="";
	           document.all.value299.value="";
	           document.all.value298.disabled=true;
	           document.all.value299.disabled=true;
	           document.all.style298.style.display = "none";
	           document.all.style299.style.display = "none";
	           document.all.modiPasswd.disabled=true;
	           document.all.modiPasswd.value="";       
	           document.all.modiPass.style.display="none";
	           document.all.spCode.value="";
	           document.all.spBizCode.value="";
	           document.all.spinfo.disabled=false;
	           document.all.spinfo.style.display = "none";
					   document.all.gddp.style.display="none";
					   if(document.all.busytype.value=="88")
					   {
					        document.all.berry.style.display="";
					   }
					    else
					    {
					        document.all.berry.style.display="none";
					    }
					   document.all.InterPri.style.display="none";
					   document.all.cash.style.display = "none";
					   if(document.all.busytype.value=="16"){
					   				document.all.gddp.style.display="";
									document.all.berry.style.display="";
									document.all.InterPri.style.display="";
									  document.all.spinfo.disabled=false;
	           				document.all.spinfo.style.display = "";							    
					   }
					   if(document.all.busytype.value=="21"){
									  document.all.spinfo.disabled=false;
	           				document.all.spinfo.style.display = "";							    
					   }

          }
        else if (i == "03") {//修改密码
           document.all.modiPasswd.disabled=false;
           document.all.modiPasswd.value="";       
           document.all.modiPass.style.display="";
           document.all.NewPasswd.value="";
           document.all.ConfirmPasswd.disabled=false;
           document.all.ConfirmPasswd.value="";    
           document.all.ConfirmPass.style.display="";
           document.all.value298.disabled=true;
           document.all.value299.disabled=true;
           document.all.value298.value="";
           document.all.value299.value="";
           document.all.style298.style.display = "none";
           document.all.style299.style.display = "none";
           document.all.value001.value="";
           document.all.style001.style.display = "none";
           document.all.spCode.value="";
           document.all.spBizCode.value="";
           document.all.spinfo.disabled=false;
           document.all.spinfo.style.display = "none";
           document.all.cash.style.display = "none";
           }
        else if (i == "08") {//资料变更
           document.all.NewPasswd.value="";
           document.all.ConfirmPasswd.value="";
           document.all.ConfirmPasswd.disabled=true;
           document.all.ConfirmPass.style.display="none";                  
           document.all.value298.value="";
           document.all.value299.value="";
			     if(document.all.busytype.value=="16"){
							document.all.gddp.style.display="";
							document.all.berry.style.display="";
							document.all.InterPri.style.display="";
							document.all.spinfo.disabled=false;
							document.all.spinfo.style.display =true;
								    
					 }
	   			 if(document.all.busytype.value!="10"){
	           document.all.value298.disabled=false;
	           document.all.value299.disabled=false;
	           document.all.style298.style.display = "";
	           document.all.style299.style.display = "";
           }
           document.all.modiPasswd.disabled=true;
           document.all.modiPasswd.value="";       
           document.all.modiPass.style.display="none";
           document.all.spCode.value="";
           document.all.spBizCode.value="";
           document.all.spinfo.disabled=false;
           document.all.spinfo.style.display = "none";
           document.all.cash.style.display = "none";
           
       }
        else if (i == "10" || i == "12") {//套餐申请套餐取消
	           document.all.NewPasswd.value="";
	           document.all.ConfirmPasswd.value="";
	           document.all.ConfirmPasswd.disabled=true;            
	           document.all.ConfirmPass.style.display="none";
	           document.all.value298.value="";
	           document.all.value299.value="";
	           document.all.value298.disabled=true;
	           document.all.value299.disabled=true;
	           document.all.style298.style.display = "none";
	           document.all.style299.style.display = "none";
	           document.all.modiPasswd.disabled=true;
	           document.all.modiPasswd.value="";       
	           document.all.modiPass.style.display="none";
	           document.all.spCode.value="";
	           document.all.spBizCode.value="";
	           document.all.spinfo.disabled=false;
	           document.all.spinfo.style.display = "none";
	           document.all.mode.style.display = "";
					   document.all.gddp.style.display="none";
					   document.all.berry.style.display="none";
					   document.all.InterPri.style.display="none";
					   document.all.cash.style.display = "none";
					   document.all.style001.style.display = "none";
					   if(document.all.busytype.value=="16"){
					   				document.all.gddp.style.display="";
									document.all.berry.style.display="";
									document.all.InterPri.style.display="";
									  document.all.spinfo.disabled=false;
	           				document.all.spinfo.style.display = "";							    
					   }
					   if(document.all.busytype.value=="21"){
									  document.all.spinfo.disabled=false;
	           				document.all.spinfo.style.display = "";							    
					   }

          }
       else {//其他
           document.all.NewPasswd.value="";
           document.all.ConfirmPasswd.value="";
           document.all.ConfirmPasswd.disabled=true;            
           document.all.ConfirmPass.style.display="none";
           document.all.value298.value="";
           document.all.value299.value="";
           document.all.value298.disabled=true;
           document.all.value299.disabled=true;
           document.all.style298.style.display = "none";
           document.all.style299.style.display = "none";
           document.all.modiPasswd.disabled=true;
           document.all.modiPasswd.value="";       
           document.all.modiPass.style.display="none";   
           document.all.spCode.value="";
	         document.all.spBizCode.value="";  
	         document.all.mode.style.display = "none";
           document.all.spinfo.disabled=false;
           document.all.spinfo.style.display = "";
           document.all.cash.style.display = "none";
           if(i == "06" &&(document.all.busytype.value=="16"||document.all.busytype.value=="17"||document.all.busytype.value=="23")){
           		document.all.gddp.style.display="";
				if(document.all.busytype.value=="88"){
				document.all.berry.style.display="";
				}
					if(document.all.busytype.value=="30"){
				document.all.InterPri.style.display="";
				}
           }
           else{
           		document.all.gddp.style.display="none";
				document.all.berry.style.display="none";
				document.all.InterPri.style.display="none";
           }
        }
        //密码问题和密码答案域始终不现实
                
				document.all.style298.style.display="none";
				document.all.style299.style.display="none";
				
} 

		
function getSpInfo(){
    var h=480;
    var w=800;
    var t=screen.availHeight/2-h/2;
    var l=screen.availWidth/2-w/2;
    var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no";
	//if(document.all.busytype.value=="61"){
			//document.all.busytype.value=="16";
	//}
    var str=window.open('f1920_rpc_getSpCode.jsp?busytype='+document.all.busytype.value+'&phoneno='+document.all.phoneno.value+'&optype='+document.all.optype.value+'&retToField=spCode|',"newwindow",prop);
}
			
			
			function getSpBizInfo(val){
        if(val.length<=0 ||val=="undefined"||val=="[object]"){
                rdShowMessageDialog("请先选择企业代码！");
                document.form.spCode.value="";
                document.form.spQuery.focus();
                return false;
        }
        var h=480;
        var w=773;
        var t=screen.availHeight/2-h/2;
        var l=screen.availWidth/2-w/2;
        var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no";
        var str=window.open('f1920_rpc_getSpBzCode.jsp?busytype='+document.all.busytype.value+'&phoneno='+document.all.phoneno.value+'&optype='+document.all.optype.value+'&spcode='+val+'&retToField=spBizCode|',"newwindow",prop);
        if(str==""||str=="undefined"){
                rdShowMessageDialog("请选择业务代码代码！");
                document.form.spBizCode.value="";
                document.form.spBizQuery.focus();
                return false;
        }
}
//-->
</script>
</HEAD>

<BODY>
<FORM action="" method=post name=form>
<input type="hidden" name="busy_type" value="1">
<input type="hidden" name="custpassword" value="">
<input type="hidden" name="busy_name" value="">
<input type="hidden" name="prompt_content" value="">
<%@ include file="/npage/include/header.jsp" %>
<div class="title">
    <div id="title_zi">梦网业务受理</div>
</div> 
 
<table cellspacing="0">
<tr>
    <td width="13%" class="blue">
         服务号码 
    </td>
    <td colspan="3">
        <input type="text" name="phoneno" class="InputGrey" value="<%=activePhone%>" readonly>
    </td>
</tr>
<tr>
    <td width="13%" class="blue">
         用户姓名 
    </td>
    <td>
        <input type="hidden" class="InputGrey" readonly name="code201" value="201">
        <input type="text" class="InputGrey" readonly name="value201" value="">
    </td>
    <td class="blue">
         运行状态 
    </td>
    <td>
        <input type="text"  class="InputGrey" readonly name="runname" value="">
    </td>
</tr>
<tr>
    <td width="13%" class="blue">
         业务类别 
    </td>
    <td colspan="3">
    	<select name="busytype" onChange="changeBusyType()">
        <option value="00">请选择业务类别</option>
        <wtc:qoption name="sPubSelect" outnum="2">
				<wtc:sql>select oprcode,oprname from oneboss.sOBBizType where regtype='0' order by oprcode asc</wtc:sql>
				</wtc:qoption>
			</select>
			&nbsp;&nbsp;
      <input type="button" name="query" class="b_text" value="查询" onclick="getUserInfo()">
    </td>
</tr>

<tr id="openinfo1" style="display:none">
    <td colspan="4">
    	<B>
        <div align="center">梦网业务开关状态信息 
    	</B>
    </td>
</tr>
<tr id="openinfo2" style="display:none">
    <td colspan="4">
        <table cellspacing="0" id="dyntb">
            <tr align='center'>
                <th>
                     开关类型 
                </th>
                <th>
                     开关状态 
                </th>
            </tr>
            <tr id="tr0" align='center' style="display:none">
                <td>
                		<input type="text" align="left" id="R1" value="">
                </td>
                <td>
                    <input type="text" align="left" id="R2" value="">
                </td>
            </tr>
        </table>
    </td>
</tr>
<tr>
    <td width="13%" class="blue">
         交易类型 
    </td>
    <td colspan="3">
        <select name="optype" onChange="changeOpType()">
            <option value="">请选择交易类型</option>
        </select>
    </td>
</tr>
<tr id="spinfo" style="display:none">
    <td width="13%" class="blue">
         SP企业代码 
    </td>
    <td>
        <input type="text" name="spCode" value="">&nbsp;&nbsp;<input type="button" class="b_text" name="spQuery" value="查询" onclick="getSpInfo()">
    </td>
    <td class="blue">
         SP业务代码 
    </td>
    <td>
    	<input type="text" name="spBizCode" value="">
    	<input class="b_text" type="button"  class="b_text" name="spBipQuery" value="查询" onclick="getSpBizInfo(document.form.spCode.value)">
    </td>
</tr>
<tr>
    <td width="13%" class="blue">
         业务密码 
    </td>
    <td colspan="3"><input type="password" maxlength="6" name="NewPasswd"></td>
</tr>
<tr id="ConfirmPass">
    <td width="13%" class="blue">
         密码确认 
    </td>
    <td colspan="3">
        <input type="password" maxlength="6" name="ConfirmPasswd">
    </td>
</tr>
<tr id="modiPass" style="display:none">
    <td width="13%" class="blue">
         新业务密码 
    </td>
    <td colspan="3">
        <input type="password" maxlength="6" name="modiPasswd">
    </td>
</tr>
<tr id="style298" style="display:none">
    <td width="13%" class="blue">
         密码问题 
    </td>
    <td colspan="3">
        <input type="hidden" readonly name="code298" value="298">
        <input type="text" name="value298">
    </td>
</tr>
<tr id="style299" style="display:none">
    <td width="13%" class="blue">
         密码答案 
    </td>
    <td colspan="3">
        <input type="hidden" readonly name="code299" value="299">
        <input type="text" name="value299">
    </td>
</tr>
<tr id="style002" style="display:none">
    <td width="13%" class="blue">
         密码使用方式 
    </td>
    <td colspan="3">
        <input type="hidden" readonly name="code002" value="002">
        <select name="value002">
            <option value="" selected>请选择密码使用方式</option>
            <option value="1">使用密码</option>
            <option value="0">不使用密码</option>
        </select>
    </td>
</tr>
<tr id="style003" style="display:none">
    <td width="13%" class="3" class="blue">
         套餐编号 
    </td>
    <td colspan="3">
        <input type="hidden" readonly name="code003" value="003">
        <select name="value003">
            <option value="" selected>请选择套餐编号</option>
            <option value="01">01套餐</option>
            <option value="02">02套餐</option>
        </select>
    </td>
</tr>
<tr id="style004" style="display:none">
    <td width="13%" class="blue">
         同步逻辑 
    </td>
    <td colspan="3">
        <input type="hidden" readonly name="code004" value="004">
        <select name="value004">
            <option value="" selected>请选择同步逻辑</option>
            <option value="1">以服务器为准</option>
            <option value="0">以终端为准</option>
            <option value="2">互相忽略</option>
        </select>
    </td>
</tr>
<!--17201相关属性-->
<tr id="style001" style="display:none">
    <td width="13%" class="blue">
         漫游方式 
    </td>
    <td colspan="3">
        <input type="hidden" readonly name="code001" value="001">
        <select name="value001">
            <option value="" selected>请选择漫游方式</option>
            <option value="10">仅国内漫游</option>
            <option value="01">仅国际漫游</option>
            <option value="11">国内国际漫游</option>
            <option value="12">追加国际漫游</option>
        </select>
    </td>
</tr>
<!--通用下载相关-->
<tr id="gddp" style="display:none">
    <td width="13%" class="blue">
         套餐包号 
    </td>
    <td>
        <input type="text" name="PackNumb" value="">
    </td>
    <td class="blue">
         增值业务代码 
    </td>
    <td>
        <input type="text" name="ServCode" value="">
    </td>
</tr>
<!--BlackBerry相关-->
<tr id="berry" style="display:none">
    <td width="13%" class="blue">
         用户IMSI 
    </td>
    <td>
        <input type="text" name="code005" value="">
    </td>
    <td class="blue">
         申请业务类型 
    </td>
    <td>
        <select name="value005">
            <option value="" selected>请选择业务类别</option>
            <option value="01">01- 集团客户业务</option>
            <option value="02">02- 集团客户扩展业务</option>
        </select>
    </td>
</tr>
<!--国际漫游优选相关-->
<tbody id="InterPri" style="display:none">
    <tr>

        <td width="13%" class="blue">
             用户IMSI 
        </td>
        <td>
            <input type="text" name="code006" value="">
        </td>
        <td class="blue">
             城市 
        </td>
        <td>
            <input type="text" name="code007" value="451">
        </td>
    </tr>
    <tr>
        <td class="blue">
             合作代码 
        </td>
        <td>
            <input type="text" name="code008" value="852">
        </td>

        <td class="blue">
             合作网络名称 
        </td>
        <td>
            <input type="text" name="code009" value="HKGSM">
        </td>
    </tr>
    <tr>
        <td class="blue">
             生效时间[YYYYMMDD] 
        </td>
        <td>
            <input type="text" name="code010" value="">
        </td>
        <td colspan="2"/>
    </tr>
</tbody>
<!--PUSHMAIL相关-->
<tr id="psml" style="display:none">
    <td width="13%" class="blue">
         业务类别 
    </td>
    <td colspan="3">
        <input type="hidden" readonly name="code300" value="300">
        <select name="value300">
            <option value="" selected>请选择业务类别</option>
            <option value="01">集团业务</option>
            <option value="02">个人业务</option>
        </select>
    </td>
</tr>
<tr id="mode" style="display:none">
    <td width="13%" class="blue">
         套餐类别 
    </td>
    <td colspan="3">
    	<select name="modecode">
        <option value="">请选择套餐类型</option>
	    </select>
	  </td>
</tr>
<!--手机钱包相关-->
<tr id="cash" style="display:none">
    <td width="13%" class="blue">
         帐户类别 
    </td>
    <td>
        <select name="code301">
            <option value="" selected>请选择帐户类别</option>
            <option value="001">银行帐户</option>
            <option value="002">充值帐户</option>
            <option value="003">话费帐户</option>
        </select>
    </td>
    <td width="13%" class="blue">
         帐户号码 
    </td>
    <td>
        <input type="text" name="value301" value="">
    </td>
</tr>
</table>
<table cellspacing="0">
    <tbody>
        <tr>
            <td id="footer">
                <input type="hidden" name="bizType" value="">
                <input name=sure type=button value=确认 onclick="docheck()" class="b_foot">
                &nbsp;
                <input name=clear type=reset value=清除 class="b_foot">
                &nbsp;
                <input name=reset type=reset value=关闭 onClick="parent.removeTab('<%=opCode%>')" class="b_foot">
            </td>
        </tr>
    </tbody>
</table>
<%@ include file="/npage/include/footer.jsp" %>
</FORM>
</BODY>
</HTML>

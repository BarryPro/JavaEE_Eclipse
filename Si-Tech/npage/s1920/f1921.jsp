<%
/********************
 version v2.0
 开发商: si-tech
 update hejw@2009-1-13
********************/
%>
<%
  String opCode = "1921";
  String opName = "手机报业务受理";
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http//www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http//www.w3.org/1999/xhtml">
	
<%@ page contentType="text/html;charset=Gb2312"%>
<%@ include file="/npage/include/public_title_name.jsp" %>

<!----------------------包含所需java 文件---->


<%
		String phoneNo = request.getParameter("activePhone");
        String regionCode = (String)session.getAttribute("regCode");
%>
	 <wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="region" routerValue="<%=regionCode%>"  id="sysAcceptl" /> 
	 	
	 	<%
	 	String printAccept = sysAcceptl;
	 	%>
<HTML><HEAD><TITLE>手机报业务受理</TITLE>
<META content="text/html; charset=gb2312" http-equiv=Content-Type>
<!--
<META content=no-cache http-equiv=Pragma>
<META content=no-cache http-equiv=Cache-Control>
-->
<script language="JavaScript">
<!--
//定义应用全局的变量
var SUCC_CODE	= "0";   		//自己应用程序定义
var ERROR_CODE  = "1";			//自己应用程序定义
var YE_SUCC_CODE = "000000";		//根据营业系统定义而修改
var dynTbIndex=1;				//用于动态表数据的索引位置,开始值为1.考虑表头



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
	    }
			backArrMsg = packet.data.findValueByName("backArrMsg");
			/*for(var i=0;i<document.form.optype.length;i++)
	    {
		    document.form.optype.length.options[i]=null;
	    }*/	    
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
		/*for(var i=0;i<document.form.optype.length;i++)
    {
	    document.form.optype.length.options[i]=null;
    }*/
    document.form.optype.length=0;
    document.form.optype.options[document.form.optype.options.length]=new Option("请选择操作类型","");
		for(var i=0; i<backArrMsg.length ; i++){
			if(backArrMsg[i][0]=="06"){
			document.form.optype.options[document.form.optype.options.length]=new Option(backArrMsg[i][1],backArrMsg[i][0]);
			}
		}		
	}
	
}

function getUserInfo()
{
		if(form.busytype.value.length<=0 ||form.busytype.value=="00"){
			rdShowMessageDialog("请选择业务类别!");
			return false;
		}
		/*if(form.phoneno.value.length<11 || isNumberString(form.phoneno.value,"1234567890")!=1) {
			rdShowMessageDialog("请输入手机号码,长度为11位数字!!");
			document.form.phoneno.focus();
			return false;
		}
		else if (parseInt(form.phoneno.value.substring(0,2),10)!=15 && (parseInt(form.phoneno.value.substring(0,3),10)<134 || parseInt(form.phoneno.value.substring(0,3),10)>139)){
			rdShowMessageDialog("请输入134-139,或15开头的手机号码!!");
			document.form.phoneno.focus();
			return false;
		}*/
if(!forMobil(document.form.phoneno)){
		return false;
}
	
	  var myPacket = new AJAXPacket("f1920_rpc_check.jsp","正在确认，请稍候......");
	
		myPacket.data.add("verifyType","phoneno");
		myPacket.data.add("phoneno",document.form.phoneno.value);
		myPacket.data.add("passwd","");
		    	    
	  core.ajax.sendPacket(myPacket);
	  myPacket = null;
	  		
	}
	
function getOperCode()
{
	  var myPacket = new AJAXPacket("f1920oper_code.jsp","正在确认，请稍候......");
	
		myPacket.data.add("verifyType","opercode");
		myPacket.data.add("busytype",document.form.busytype.value);
		    	    
	  core.ajax.sendPacket(myPacket);
	  myPacket = null;
	  		
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
	
	             
	tr1.insertCell().innerHTML = '<div align="center">'+ switchName+':</div>';
	tr1.insertCell().innerHTML = '<div align="center"><input id=R2    name="switchName'+switchBizType+'" type=hidden   align="center"  value="'+ switchName+'"  readonly></input><input id=R3    name="switch'+switchBizType+'" type=hidden   align="center"  value="'+ switchStatus+'"  readonly></input>'+ switchStatusName+'</div>';      
	
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

function isKeyNumberdot(ifdot) 
{       
    var s_keycode=(navigator.appname=="Netscape")?event.which:event.keyCode;
        if(ifdot==0)
                if(s_keycode>=48 && s_keycode<=57)
                        return true;
                else 
                        return false;
    else
    {
        if((s_keycode>=48 && s_keycode<=57) || s_keycode==46)
        {
              return true;
        }
        else if(s_keycode==45)
        {
            rdShowMessageDialog('不允许输入负值,请重新输入!');
            return false;
        }
        else
                  return false;
    }       
}
function form_load()
{
	document.all.gddp.style.display="none";
	var busy_code=document.all.busytype.value;
	if(busy_code=="01"||busy_code=="02"){
	        document.all.style001.style.display="";
	        document.form.value001[1].selected=true;
			 		document.all.spinfo.disabled=false;
	        document.all.spinfo.style.display="";
	        document.all.style298.style.display="none";
	        document.all.style299.style.display="none";
	        if(busy_code=="01") {
	        	document.all.style001.style.display="none";
	        }
	}
	else if(busy_code=="10"){
	        document.form.value001[0].selected=true;
	        document.all.style002.style.display="";
	        document.all.style003.style.display="";
	        document.all.style004.style.display="";
	}
	else if(busy_code=="17"){
					document.all.gddp.style.display="";
					document.all.spinfo.disabled=false;
					document.all.spinfo.style.display = "";
	}
	
}

function isNumberString (InString,RefString)
{
if(InString.length==0) return (false);
for (Count=0; Count < InString.length; Count++)  {
        TempChar= InString.substring (Count, Count+1);
        if (RefString.indexOf (TempChar, 0)==-1)  
        return (false);
}
return (true);
}

function docheck()
{
	getAfterPrompt();
   var busy_code=document.all.busytype.value;
   //测试使用 document.all.spBizCode.value="10085";

/*
if(form.phoneno.value.length<11 || isNumberString(form.phoneno.value,"1234567890")!=1) {
rdShowMessageDialog("请输入手机号码,长度为11位数字!!");
document.form.phoneno.focus();
return false;
}
else if (parseInt(form.phoneno.value.substring(0,2),10)!=15 && (parseInt(form.phoneno.value.substring(0,3),10)<134 || parseInt(form.phoneno.value.substring(0,3),10)>139)){
rdShowMessageDialog("请输入134-139,或15开头的手机号码 !!",0);
document.form.phoneno.focus();
return false;
}*/

if(!forMobil(document.form.phoneno)){
		return false;
}

if(document.all.runname.value.substring(1,2)!="A" &&document.all.runname.value.substring(1,2)!="K"){
	rdShowMessageDialog("用户状态不正常，不允许受理业务!",0);
	return false;
}
if( form.optype.value==""||form.optype.value=="00") {
rdShowMessageDialog("请选择交易类型!!",0);
document.form.optype.focus();
return false;
}
if( form.NewPasswd.value.length<1 && form.optype.value=="03" ) {
rdShowMessageDialog("请输入业务密码!!",0);
document.form.NewPasswd.focus();
return false;
}
if( form.ConfirmPasswd.value.length<1 && form.optype.value=="03" ) {
rdShowMessageDialog("请输入确认密码!!",0);
document.form.ConfirmPasswd.focus();
return false;
}
if( form.NewPasswd.value!= form.ConfirmPasswd.value && form.optype.value=="03" ) {
rdShowMessageDialog("两次输入密码不一致!!",0);
document.form.NewPasswd.focus();
return false;
}
//else if((busy_code=="01"||busy_code=="02")&&form.optype.value=="01"){
if((busy_code=="02")&&form.optype.value=="01"){
    if(form.value001.value=="01"){
            rdShowMessageDialog("不能单独开通国际漫游!",0);
            document.form.value001.focus();
            return false;
    }else if(form.value001.value==""){
            rdShowMessageDialog("请选择你需要的漫游业务!",0);
            document.form.value001.focus();
            return false;
    }
}
//else if((busy_code=="01"||busy_code=="02")&&(form.optype.value=="02"||form.optype.value=="04")&&form.value001.value=="10"){
else if((busy_code=="02")&&(form.optype.value=="02"||form.optype.value=="04")&&form.value001.value=="10"){
        rdShowMessageDialog("不能单独取消国内业务!",0);
        document.form.value001.focus();
        return false;
}
//else if((busy_code=="01"||busy_code=="02")&&(form.optype.value=="02"||form.optype.value=="04")&&form.value001.value=="12"){
else if((busy_code=="02")&&(form.optype.value=="02"||form.optype.value=="04")&&form.value001.value=="12"){
        rdShowMessageDialog("不能单独取消国际漫游业务!",0);
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
	if(typeof(form[eval('switchType')])!="undefined")
	{
	if(form[eval('switchType')].value=="0"){
		rdShowMessageDialog(form[eval('switchName')].value+"已关闭，不能受理任何梦网业务!",0);
		return false;
	}
	}
	switchType="switch"+busy_code;
	switchName="switchName"+busy_code;
	if(typeof(form[eval('switchType')])!="undefined")
	{
	if(form[eval('switchType')].value=="0"){
		rdShowMessageDialog(form[eval('switchName')].value+"开关已关闭，不允许受理业务!",0);
		return false;
	}
	}
	//梦网业务必须选择sp企业代码和业务代码
	if(document.form.spCode.value==""){
		rdShowMessageDialog("请选择sp企业代码！",0);
		return false;
	}
	if(document.form.spBizCode.value==""){
		rdShowMessageDialog("请选择sp业务代码！",0);
		return false;
	}
}
if(document.form.spCode.value=="[object]" ||document.form.spCode.value=="undefine"){
	rdShowMessageDialog("不合法的SP企业代码，请重新选择",0);
	return false;
}
if(document.form.spBizCode.value=="[object]" ||document.form.spBizCode.value=="undefine"){
	rdShowMessageDialog("不合法的SP业务代码，请重新选择",0);
	return false;
}
if(busy_code=="21" &&　form.optype.value=="01"){//手机钱包判断
	if(document.form.code301.value==""){
		rdShowMessageDialog("请选择手机钱包帐户类型！",0);
		return false;
	}
	if(document.form.value301.value==""){
		document.form.value301.value="|";
	}
}
if(busy_code=="21" &&　form.optype.value=="02"){//手机钱包判断
	if(document.form.spCode.value==""){
		rdShowMessageDialog("请选择SP企业代码！",0);
		return false;
	}
	if(document.form.spBizCode.value==""){
		document.form.spBizCode.value="|";
	}
}
if(form.optype.value=="99"){//全业务退订判断
	if(document.form.spCode.value==""){
		rdShowMessageDialog("请选择SP企业代码！",0);
		return false;
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
 	document.form.action="f1921_cfm.jsp";
	form.submit();
	return true;
}

function showPrtDlg(printType,DlgMessage,submitCfm)
{  //显示打印对话框 
   var h=150;
   var w=350;
   var t=screen.availHeight/2-h/2;
   var l=screen.availWidth/2-w/2;
   var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no"; 
   var printStr = printInfo(printType);
   
     var pType="subprint";                     // 打印类型print 打印 subprint 合并打印
     var billType="1";                      //  票价类型1电子免填单、2发票、3收据
     var sysAccept =<%=printAccept%>;                       // 流水号
     var printStr = printInfo(printType);   //调用printinfo()返回的打印内容
     var mode_code=null;                        //资费代码
     var fav_code=null;                         //特服代码
     var area_code=null;                        //小区代码
     var opCode =   "<%=opCode%>";                         //操作代码
     var phoneNo = <%=phoneNo%>;                            //客户电话
    var path = "<%=request.getContextPath()%>/npage/innet/hljBillPrint_jc.jsp?DlgMsg=" + DlgMessage+ "&submitCfm=" + submitCfm;
		var path=path+"&mode_code="+mode_code+"&fav_code="+fav_code+"&area_code="+area_code+"&opCode=<%=opCode%>&sysAccept="+sysAccept+"&phoneNo="+phoneNo+"&submitCfm="+submitCfm+"&pType="+pType+"&billType="+billType+ "&printInfo=" + printStr;
		var ret=window.showModalDialog(path,printStr,prop);   
		
   return ret;    
}

function printInfo(printType)
{
	  	var retInfo = "";
		var note_info1 = "";
		var note_info2 = "";
		var note_info3 = "";
		var note_info4 = "";
		var opr_info = "";
		var cust_info = "";
		
	cust_info+="手机号码："+document.all.phoneno.value+"|";
	cust_info+="客户姓名："+document.all.value201.value+"|";

	opr_info+="业务类型："+document.all.busytype.options[document.all.busytype.selectedIndex].text+"|";
	opr_info+="操作类型："+document.all.optype.options[document.all.optype.selectedIndex].text+"|";
  opr_info+="SP企业代码："+document.all.spCode.value+"|";
	opr_info+="SP业务代码："+document.all.spBizCode.value+"|";

	note_info1+="备注：|";

		
	  retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
    retInfo=retInfo.replace(new RegExp("#","gm"),"%23"); //把“#"替换为url格式
    return retInfo;
}

function getinfo()
{
/*if( form.phoneno.value.length<11 || isNumberString(form.phoneno.value,"1234567890")!=1 ) {
rdShowMessageDialog("请输入手机号码,长度为11位数字 !!",0);
document.form.phoneno.focus();
return false;
}
else if (parseInt(form.phoneno.value.substring(0,2),10)!=15 && (parseInt(form.phoneno.value.substring(0,3),10)<134 || parseInt(form.phoneno.value.substring(0,3),10)>139)){
rdShowMessageDialog("请输入15,134-139开头的手机号码 !!",0);
document.form.phoneno.focus();
return false;
}*/
if(!forMobil(document.form.phoneno)){
		return false;
}
else {
        var h=480;
        var w=650;
        var t=screen.availHeight/2-h/2;
        var l=screen.availWidth/2-w/2;
        var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no";
        var str=window.showModalDialog('getinfo.jsp?phoneno='+document.form.phoneno.value+'&passWord='+'&optype=02',"",prop);
        
        if( typeof(str) != "undefined" ){
                if (parseInt(str)==0){
                        rdShowMessageDialog("没有找到对应的客户！",0);
                        document.form.phoneno.focus();
                        return false;}
                else {var chPos_str = str.indexOf("|");
                        document.all.value201.value=str.substring(0,chPos_str);
                        var str2 = str.substring(chPos_str+1);
                        var chPos_str2 = str2.indexOf("|");
                        document.all.custpassword.value=str2.substring(0,chPos_str2);
                        document.all.runname.value=str2.substring(chPos_str2+1);
                        if(document.all.runname.value!="正常"){
                                rdShowMessageDialog("用户状态为《"+document.all.runname.value+"》，不允许进行业务受理",0);
                                document.form.phoneno.focus();
                                return false;
                        } 
                        return true;
                        }
        return true;
      }
  }
}
function changeBusyType(){	
	document.form.value001[0].selected=true;
	document.form.value002[0].selected=true;
	document.form.value003[0].selected=true;
	document.form.value004[0].selected=true;
	document.form.value300[0].selected=true;
	document.form.code301[0].selected=true;
	
	document.all.gddp.style.display="none";
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
	else{
		document.all.psml.style.display="none";
		document.all.gddp.style.display="none";
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
									document.all.spinfo.disabled=false;
									document.all.spinfo.style.display ="";						
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
					   document.all.cash.style.display = "none";
					   if(document.all.busytype.value=="16"){
					   				document.all.gddp.style.display="";
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
           document.all.spinfo.disabled=false;
           document.all.spinfo.style.display = "";
           document.all.cash.style.display = "none";
           if(i == "06" &&(document.all.busytype.value=="16"||document.all.busytype.value=="17"||document.all.busytype.value=="23")){
           		document.all.gddp.style.display="";
           }
           else{
           		document.all.gddp.style.display="none";
           }
        }
        //密码问题和密码答案域始终不现实
				document.all.style298.style.display="none";
				document.all.style299.style.display="none";
				
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
	
function getvalue(retInfo,retToFieldBack)
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
	        
	        //以下为自定义代码
	    }		
	}	
function getSpInfo(){
        var h=480;
        var w=773;
        var t=screen.availHeight/2-h/2;
        var l=screen.availWidth/2-w/2;
        var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no";
        var str=window.open('f1920_rpc_getSpCode.jsp?busytype='+document.all.busytype.value+'&phoneno='+document.all.phoneno.value+'&optype='+document.all.optype.value+'&retToField=spCode|',"newwindow",prop);
        //document.form.spCode.value=str;
}
function getSpBizInfo(val){
	
        if(val.length<=0 ||val=="undefined"||val=="[object]"){
                rdShowMessageDialog("请先选择企业代码！",0);
                document.form.spCode.value="";
                return false;
        }
        var h=480;
        var w=773;
        var t=screen.availHeight/2-h/2;
        var l=screen.availWidth/2-w/2;
        var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no";
        var str=window.open('f1920_rpc_getSpBzCode.jsp?busytype='+document.all.busytype.value+'&phoneno='+document.all.phoneno.value+'&optype='+document.all.optype.value+'&spcode='+val+'&retToField=spBizCode|',"",prop);
        if(str==""||str=="undefined"){
                rdShowMessageDialog("请选择业务代码代码！",0);
                document.form.spBizCode.value="";
                document.form.spBizQuery.focus();
                return false;
        }
        //document.form.spBizCode.value=str;
        
}
//-->
</script>
</HEAD>

<BODY>
<FORM action="s4234_select.jsp" method=post name=form>
	<%@ include file="/npage/include/header.jsp" %>                         
	<div class="title">
		<div id="title_zi">手机报业务受理</div>
	</div>
<input type="hidden" name="busy_type"  value="1">
<input type="hidden" name="custpassword"  value="">
<input type="hidden" name="busy_name"  value="">
<input type="hidden" name="printAccept"  value="<%=printAccept%>">
 
              <table  cellspacing="0"> 
              	<tr> 
								  <td width="13%" class="blue"><div align="right">业务类别</div></td>
                  <td width="39%"> <select name="busytype"     onChange="changeBusyType()">
                  <option  value="05">中国手机报</option>
                  </select>
                  <td width="13%">&nbsp;</td>
                  <td width="39%">&nbsp;</td>
                </tr>
                  
                <tr> 
                  <td width="13%" class="blue"><div align="right">手机号码</div></td>
                  <td> 
                    <input type="text" name="phoneno" maxlength="11"  onKeyPress="return isKeyNumberdot(0)" value =<%=phoneNo%>  Class="InputGrey" readOnly >
                  </td>
                  <td class="blue">&nbsp;</td>
                  <td>
                    &nbsp;
                    <input type="button" class="b_text" name="query" value="查询" onclick="getUserInfo()">
                  </td>
                </tr>                        
                <tr> 
                  <td width="13%" class="blue"><div align="right">用户姓名</div></td>
                  <td>
                    <input type="hidden"  readonly  class="InputGrey" name="code201" value="201">
                    <input type="text"  readonly class="InputGrey" name="value201" value="">
                  </td>
                  <td class="blue"><div align="right">运行状态</div></td>
                  <td>
                    <input type="text" readonly  class="InputGrey" name="runname" value="">
                  </td>
                </tr> 
                <tr id="openinfo1"   style="display:none"> 
	            		<td colspan="4"  class="blue"><B><div align="center">梦网业务开关状态信息</div></B></td>
          			</tr>  
                <tr id="openinfo2"   style="display:none"> 
	            		<td colspan="4" >
	            			<table width="98%"  id="dyntb">
			                <tr> 
			                  <th><div align="center">开关类型</div></th>
			                  <th><div align="center">开关状态</div></th>
			                </tr>
			                <tr id="tr0" style="display:none"> 
			                  <td><div align="center"> 
			                      <input type="text" align="left" id="R1" value="">
			                    </div></td>
			                  <td><div align="center"> 
			                      <input type="text" align="left" id="R2" value="">
			                    </div></td>                              
			                </tr>                
	             	 		</table>
	             	 	</td>
          			</tr>                        
                <tr> 
                  <td width="13%" class="blue"><div align="right">交易类型</div></td>
                  <td width="39%">
                      <select name="optype"    onChange="changeOpType()">
      									<option  value="">请选择交易类型</option>                      
                      </select>
                  </td>
                  <td>&nbsp;</td>
                  <td>&nbsp;</td>
                </tr>
                <tr id="spinfo" style="display:none">
                  <td width="13%" class="blue"><div align="right">SP企业代码</div></td>
                  <td>
                    <select name="spCode"  >
      									<option value="801234" selected>801234->中国移动通信</option>                      
                     </select>
                  </td>
                  <td class="blue"><div align="right">SP业务代码</div></td>
                  <td>
                     <input type="text" name="spBizCode" value="" readonly class="InputGrey" ><input type="button" class="b_text" name="spBipQuery" value="查询" onclick="getSpBizInfo(document.form.spCode.value)">
                  </td>
                </tr>
                <tr id="NewPasswd" style="display:none"> 
                  <td width="13%" class="blue"><div align="right">业务密码</div></td>
                  <td><input type="password" maxlength="6" name="NewPasswd"></td>
                  <td></td>
                  <td></td>
                </tr>
                <tr id="ConfirmPass"> 
                  <td width="13%" class="blue"><div align="right">密码确认</div></td>
                  <td>
                    <input type="password"  maxlength="6" name="ConfirmPasswd">
                  </td>
                  <td>&nbsp;</td>
                  <td>&nbsp;</td>
                </tr>
                <tr id="modiPass" style="display:none"> 
                  <td width="13%" class="blue"><div align="right">新业务密码</div></td>
                  <td>
                    <input type="password"  maxlength="6" name="modiPasswd">
                  </td>
                  <td></td>
                  <td></td>
                </tr>
                <tr id ="style298" style="display:none"> 
                  <td width="13%" class="blue"><div align="right">密码问题</div></td>
                  <td>
                                        <input type="hidden"  readonly class="InputGrey"  name="code298" value="298">
                    <input type="text"   name="value298">
                  </td>
                  <td></td>
                  <td>
                  </td>
                </tr>
                <tr id ="style299"  style="display:none"> 
                  <td width="13%" class="blue"><div align="right">密码答案</div></td>
                  <td>
                    <input type="hidden"  readonly  class="InputGrey" name="code299" value="299">
                    <input type="text"   name="value299">
                  </td>
                  <td></td>
                  <td></td>
                </tr>
                <tr id="style002" style="display:none"> 
                  <td width="13%" class="blue"><div align="right">密码使用方式</div></td>
                  <td> 
                                        <input type="hidden"  readonly  class="InputGrey" name="code002" value="002">
                                                <select name="value002">
                                                <option value="" selected>请选择密码使用方式</option>
                      <option value="1">使用密码</option>
                      <option value="0">不使用密码</option>
                    </select>
                  </td>
                  <td></td>
                  <td></td>
                </tr>                           
                <tr id="style003" style="display:none"> 
                  <td width="13%" class="blue"><div align="right">套餐编号</div></td>
                  <td> 
                    <input type="hidden"  readonly  class="InputGrey" name="code003" value="003">
                    <select name="value003">
                      <option value="" selected>请选择套餐编号</option>
                      <option value="01">01套餐</option>
                      <option value="02">02套餐</option>
                    </select>
                  </td>
                  <td></td>
                  <td></td> 
                </tr>
                <tr id="style004" style="display:none"> 
                  <td width="13%" class="blue"><div align="right">同步逻辑</div></td>
                  <td> 
                    <input type="hidden"  readonly  class="InputGrey" name="code004" value="004">
                    <select name="value004">
                      <option value="" selected>请选择同步逻辑</option>
                      <option value="1">以服务器为准</option>
                      <option value="0">以终端为准</option>
                      <option value="2">互相忽略</option>
                    </select>
                  </td>
                  <td></td>
                  <td></td> 
                </tr>
                <!--17201相关属性-->
                <tr id="style001" style="display:none"> 
                  <td width="13%" class="blue"><div align="right">漫游方式</div></td>
                  <td> 
                    <input type="hidden"  readonly  class="InputGrey" name="code001" value="001">
                    <select name="value001">
                      <option value="" selected>请选择漫游方式</option>
                      <option value="10">仅国内漫游</option>
                      <option value="01">仅国际漫游</option>
                      <option value="11">国内国际漫游</option>
                      <option value="12">追加国际漫游</option>
                    </select>
                  </td>
                  <td></td>
                  <td></td>
                </tr>
                <!--通用下载相关-->
                <tr id="gddp" style="display:none"> 
                  <td width="13%" class="blue"><div align="right">套餐包号</div></td>
                  <td> 
                    <input type="text"  name="PackNumb" value="">
                  </td>
                  <td class="blue"><div align="right">增值业务代码</div></td>
                  <td> 
                    <input type="text"  name="ServCode" value="">
                  </td>
                </tr>
                <!--PUSHMAIL相关-->
                <tr id="psml" style="display:none"> 
                  <td width="13%" class="blue"><div align="right">PushMail业务类别</div></td>
                  <td> 
                    <input type="hidden"  readonly  class="InputGrey" name="code300" value="300">
                    <select name="value300">
                      <option value="" selected>请选择业务类别</option>
                      <option value="01">集团业务</option>
                      <option value="02">个人业务</option>
                    </select>
                  </td>
                  <td></td>
                  <td></td>
                </tr>
                <!--手机钱包相关-->
                <tr id="cash" style="display:none"> 
                  <td width="13%" class="blue"><div align="right">帐户类别</div></td>
                  <td> 
                    <select name="code301">
                      <option value="" selected>请选择帐户类别</option>
                      <option value="001">银行帐户</option>
                      <option value="002">充值帐户</option>
                      <option value="003">话费帐户</option>
                    </select>
                  </td>
                  <td width="13%" class="blue"><div align="right">帐户号码</div></td>
                  <td> 
                    <input type="text"  name="value301" value="">
                  </td>
                </tr>
              </table>
            	<table  cellspacing="0">
              <tbody> 
              <tr > 
                <td align=center width="100%"> 
                  <input type="hidden"  name="bizType" value="">
                  <input  name=sure type=button class="b_foot" value=确认 onclick="docheck()"> 
                                  &nbsp;
                  <input  name=clear type=reset class="b_foot"  value=清除>
                                  &nbsp;
                  <input  name=reset type=reset  class="b_foot" value=关闭 onClick="removeCurrentTab()">
		  
                </td>
              </tr>
              </tbody> 
            	</table>
 
<%@ include file="/npage/include/footer.jsp" %>
</FORM>

</BODY>

</HTML>

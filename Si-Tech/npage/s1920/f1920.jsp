<%   
/*
* name    : 
* author  : changjiang@si-tech.com.cn
* created : 2004-01-31
* revised : 2004-01-31
*
*update:zhanghonga@2008-09-03 ҳ�����,�޸���ʽ
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
    String opName = "����ҵ������";

    String workno = (String)session.getAttribute("workNo");
    String workname = (String)session.getAttribute("workName");
%>

<HTML><HEAD><TITLE>����ҵ������</TITLE>
<META content="text/html; charset=gb2312" http-equiv=Content-Type>
<script language="JavaScript">
<!--
//����Ӧ��ȫ�ֵı���
var SUCC_CODE	= "0";   		//�Լ�Ӧ�ó�����
var ERROR_CODE  = "1";			//�Լ�Ӧ�ó�����
var YE_SUCC_CODE = "000000";	//����Ӫҵϵͳ������޸�
var dynTbIndex=1;				//���ڶ�̬�����ݵ�����λ��,��ʼֵΪ1.���Ǳ�ͷ

onload=function()
{
	if(document.all.phoneno.value.trim().len()==0){
		parent.removeTab('<%=opCode%>');
		return false;	
	}
	
	//��ѯ�û���Ϣ
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
//---------1------RPC������------------------
function doProcess(packet){
	//ʹ��RPC��ʱ��,��������������Ϊ��׼ʹ��.
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
			//�ж��û�״̬
			if(document.all.runname.value.substring(1,2)!="A" &&document.all.runname.value.substring(1,2)!="K"){
	    	rdShowMessageDialog("�û�״̬������������������ҵ��!");
				return false;
	    }else{
	    	//rdShowMessageDialog("�û�״̬����!",2);	
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
			rdShowMessageDialog("<br>�������:["+error_code+"]</br>������Ϣ:["+error_msg+"]");
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
		document.form.optype.options[document.form.optype.options.length]=new Option("��ѡ���������","");
		for(var i=0; i<backArrMsg.length ; i++){
			document.form.optype.options[document.form.optype.options.length]=new Option(backArrMsg[i][1],backArrMsg[i][0]);
	    }	
		document.form.modecode.length=0;
		document.form.modecode.options[document.form.modecode.options.length]=new Option("��ѡ���ײ�����","");
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

//��ѯ�û���Ϣ
function getUserInfo(){
	  var myPacket = new AJAXPacket("f1920_rpc_check.jsp","����ȷ�ϣ����Ժ�......");
		myPacket.data.add("verifyType","phoneno");
		myPacket.data.add("phoneno",document.form.phoneno.value);
	  core.ajax.sendPacket(myPacket);
	  myPacket=null;	  	
	  		
	}
	
function getOperCode()
{
	var myPacket = new AJAXPacket("f1920oper_code.jsp","����ȷ�ϣ����Ժ�......");
	myPacket.data.add("verifyType","opercode");
	myPacket.data.add("busytype",document.form.busytype.value);
	core.ajax.sendPacket(myPacket);
	myPacket=null;	  		
}
	
function getPrompt()
{
	var myPacket = new AJAXPacket("f1920_getPrompt.jsp","����ȷ�ϣ����Ժ�......");
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
		switchStatusName="��";
	}
	else if(switchStatus=="1"){
		switchStatusName="��";
	}
	tr1=dyntb.insertRow();	//ע��:����ı������������һ��,������ɿ���.yl.
	tr1.id="tr"+dynTbIndex;
	
	             
	tr1.insertCell().innerHTML = '<div align="center">'+ switchName+': ';
	tr1.insertCell().innerHTML = '<div align="center"><input id=R2    name="switchName'+switchBizType+'" type=hidden   align="center"  value="'+ switchName+'"  readonly></input><input id=R3    name="switch'+switchBizType+'" type=hidden   align="center"  value="'+ switchStatus+'"  readonly></input>'+ switchStatusName+' ';      
	
	dynTbIndex++;
  
}	

function dyn_deleteAll()
{
	//������ӱ��е�����
	for(var a = document.all.dyntb.rows.length-2 ;a>0; a--)//ɾ����tr1��ʼ��Ϊ������
	{
     document.all.dyntb.deleteRow(a+1);
	}
}


function docheck()
{
getAfterPrompt();//add by qidp
var busy_code=document.all.busytype.value;

if(document.all.runname.value.substring(1,2)!="A" &&document.all.runname.value.substring(1,2)!="K"){
	rdShowMessageDialog("�û�״̬������������������ҵ��!");
	return false;
}
if( form.optype.value==""||form.optype.value=="00") {
rdShowMessageDialog("��ѡ��������!!");
document.form.optype.focus();
return false;
}
if( form.NewPasswd.value.length<1 && form.optype.value=="03" ) {
rdShowMessageDialog("������ҵ������!!");
document.form.NewPasswd.focus();
return false;
}
if( form.ConfirmPasswd.value.length<1 && form.optype.value=="03" ) {
rdShowMessageDialog("������ȷ������!!");
document.form.ConfirmPasswd.focus();
return false;
}
if( form.NewPasswd.value!= form.ConfirmPasswd.value && form.optype.value=="03" ) {
rdShowMessageDialog("�����������벻һ��!!");
document.form.NewPasswd.focus();
return false;
}
if((busy_code=="02")&&form.optype.value=="01"){
    if(form.value001.value=="01"){
            rdShowMessageDialog("���ܵ�����ͨ��������!");
            document.form.value001.focus();
            return false;
    }else if(form.value001.value==""){
            rdShowMessageDialog("��ѡ������Ҫ������ҵ��!");
            document.form.value001.focus();
            return false;
    }
}else if((busy_code=="02")&&(form.optype.value=="02"||form.optype.value=="04")&&form.value001.value=="10"){
        rdShowMessageDialog("���ܵ���ȡ������ҵ��!");
        document.form.value001.focus();
        return false;
}else if((busy_code=="02")&&(form.optype.value=="02"||form.optype.value=="04")&&form.value001.value=="12"){
        rdShowMessageDialog("���ܵ���ȡ����������ҵ��!");
        document.form.value001.focus();
        return false;
}
if(busy_code=="10"){
        document.form.value201.value="";
}
if(busy_code=="03"||busy_code=="04"||busy_code=="05"||busy_code=="13"){
	//�ж���������
	var switchType="switch99";
	var switchName="switchName99";
	if(form[eval('switchType')].value=="0"){
		rdShowMessageDialog(form[eval('switchName')].value+"�ѹرգ����������κ�����ҵ��!");
		return false;
	}
	switchType="switch"+busy_code;
	switchName="switchName"+busy_code;
	if(form[eval('switchType')].value=="0"){
		rdShowMessageDialog(form[eval('switchName')].value+"�����ѹرգ�����������ҵ��!");
		return false;
	}
	//����ҵ�����ѡ��sp��ҵ�����ҵ�����
	if(document.form.spCode.value==""){
		rdShowMessageDialog("��ѡ��sp��ҵ���룡");
		return false;
	}
	if(document.form.spBizCode.value==""){
		rdShowMessageDialog("��ѡ��spҵ����룡");
		return false;
	}
}
if(document.form.spCode.value=="[object]" ||document.form.spCode.value=="undefine"){
	rdShowMessageDialog("���Ϸ���SP��ҵ���룬������ѡ��");
	return false;
}
if(document.form.spBizCode.value=="[object]" ||document.form.spBizCode.value=="undefine"){
	rdShowMessageDialog("���Ϸ���SPҵ����룬������ѡ��");
	return false;
}
if(busy_code=="21" &&��form.optype.value=="01"){//�ֻ�Ǯ���ж�
	if(document.form.code301.value==""){
		rdShowMessageDialog("��ѡ���ֻ�Ǯ���ʻ����ͣ�");
		return false;
	}
	if(document.form.value301.value==""){
		document.form.value301.value="|";
	}
}
if(busy_code=="21" &&��form.optype.value=="06"){//�ֻ�Ǯ���ж�
	if(document.form.spCode.value==""){
		rdShowMessageDialog("��ѡ��SP��ҵ���룡");
		return false;
	}
	if(document.form.spBizCode.value==""){
		document.form.spBizCode.value="|";
	}
}
if(form.optype.value=="99"){//ȫҵ���˶��ж�
	if(document.form.spCode.value==""){
		rdShowMessageDialog("��ѡ��SP��ҵ���룡");
		return false;
	}
}
if(form.optype.value=="10" || form.optype.value=="12"){
   if(document.form.modecode.value==""){
		rdShowMessageDialog("��ѡ���ײʹ��룡");
		return false;
	}else{
		form.spBizCode.value=document.form.modecode.value;
		
	}
}
//��ӡ�������ύ��
	var ret = showPrtDlg("Detail","ȷʵҪ���е��������ӡ��","Yes"); 
	if(typeof(ret)!="undefined")
	{
	  if((ret=="confirm"))
	  {
	    if(rdShowConfirmDialog('ȷ�ϵ��������')==1)
	    {
	    frmCfm();
	    }
	}
	if(ret=="continueSub")
	{
	    if(rdShowConfirmDialog('ȷ��Ҫ�ύ��Ϣ��')==1)
	    {
	    frmCfm();
	    }
	}
	}
	else
	{
	   if(rdShowConfirmDialog('ȷ��Ҫ�ύ��Ϣ��')==1)
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
{  //��ʾ��ӡ�Ի��� 
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
	retInfo+="�û����룺"+document.all.phoneno.value+"|";
	retInfo+="�û�������"+document.all.value201.value+"|";
	retInfo+=" "+"|";
	retInfo+=" "+"|";
	retInfo+=" "+"|";
	retInfo+=" "+"|";
	retInfo+=" "+"|";
	retInfo+=" "+"|";
	retInfo+="ҵ�����ͣ�"+document.all.busytype.options[document.all.busytype.selectedIndex].text+"|";
	retInfo+="�������ͣ�"+document.all.optype.options[document.all.optype.selectedIndex].text+"|";
    retInfo+="SP��ҵ���룺"+document.all.spCode.value+"|";
	if(document.form.optype.value=="10" || document.form.optype.value=="12"){
		retInfo+="SPҵ����룺"+"|";
	}else{
		retInfo+="SPҵ����룺"+document.all.spBizCode.value+"|";
	}
		if((document.form.spCode.value=="908078") && (document.form.spBizCode.value=="-TQ"))
	{
		retInfo+="��ʹ�÷�3Ԫ/��"+"|";
		retInfo+="ҵ��ȡ����ʽ����0000��10658121"+"|";
		retInfo+="�ʷ���Ч�ڣ����²�ȡ��,���¼����շ�"+"|";
		
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
				retInfo+="��ע��"+temStrnote+"|";
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
	//����������������ʼ�ղ���ʵ
	document.all.style298.style.display="none";
	document.all.style299.style.display="none";
	
}
function changeOpType() { 					
					var i = form.optype.value;
					document.all.mode.style.display = "none";
					if (i == "01") {//ע��
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
           else if (i == "02") {//ҵ��ȡ��
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
        else if (i == "03") {//�޸�����
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
        else if (i == "08") {//���ϱ��
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
        else if (i == "10" || i == "12") {//�ײ������ײ�ȡ��
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
       else {//����
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
        //����������������ʼ�ղ���ʵ
                
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
                rdShowMessageDialog("����ѡ����ҵ���룡");
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
                rdShowMessageDialog("��ѡ��ҵ�������룡");
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
    <div id="title_zi">����ҵ������</div>
</div> 
 
<table cellspacing="0">
<tr>
    <td width="13%" class="blue">
         ������� 
    </td>
    <td colspan="3">
        <input type="text" name="phoneno" class="InputGrey" value="<%=activePhone%>" readonly>
    </td>
</tr>
<tr>
    <td width="13%" class="blue">
         �û����� 
    </td>
    <td>
        <input type="hidden" class="InputGrey" readonly name="code201" value="201">
        <input type="text" class="InputGrey" readonly name="value201" value="">
    </td>
    <td class="blue">
         ����״̬ 
    </td>
    <td>
        <input type="text"  class="InputGrey" readonly name="runname" value="">
    </td>
</tr>
<tr>
    <td width="13%" class="blue">
         ҵ����� 
    </td>
    <td colspan="3">
    	<select name="busytype" onChange="changeBusyType()">
        <option value="00">��ѡ��ҵ�����</option>
        <wtc:qoption name="sPubSelect" outnum="2">
				<wtc:sql>select oprcode,oprname from oneboss.sOBBizType where regtype='0' order by oprcode asc</wtc:sql>
				</wtc:qoption>
			</select>
			&nbsp;&nbsp;
      <input type="button" name="query" class="b_text" value="��ѯ" onclick="getUserInfo()">
    </td>
</tr>

<tr id="openinfo1" style="display:none">
    <td colspan="4">
    	<B>
        <div align="center">����ҵ�񿪹�״̬��Ϣ 
    	</B>
    </td>
</tr>
<tr id="openinfo2" style="display:none">
    <td colspan="4">
        <table cellspacing="0" id="dyntb">
            <tr align='center'>
                <th>
                     �������� 
                </th>
                <th>
                     ����״̬ 
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
         �������� 
    </td>
    <td colspan="3">
        <select name="optype" onChange="changeOpType()">
            <option value="">��ѡ��������</option>
        </select>
    </td>
</tr>
<tr id="spinfo" style="display:none">
    <td width="13%" class="blue">
         SP��ҵ���� 
    </td>
    <td>
        <input type="text" name="spCode" value="">&nbsp;&nbsp;<input type="button" class="b_text" name="spQuery" value="��ѯ" onclick="getSpInfo()">
    </td>
    <td class="blue">
         SPҵ����� 
    </td>
    <td>
    	<input type="text" name="spBizCode" value="">
    	<input class="b_text" type="button"  class="b_text" name="spBipQuery" value="��ѯ" onclick="getSpBizInfo(document.form.spCode.value)">
    </td>
</tr>
<tr>
    <td width="13%" class="blue">
         ҵ������ 
    </td>
    <td colspan="3"><input type="password" maxlength="6" name="NewPasswd"></td>
</tr>
<tr id="ConfirmPass">
    <td width="13%" class="blue">
         ����ȷ�� 
    </td>
    <td colspan="3">
        <input type="password" maxlength="6" name="ConfirmPasswd">
    </td>
</tr>
<tr id="modiPass" style="display:none">
    <td width="13%" class="blue">
         ��ҵ������ 
    </td>
    <td colspan="3">
        <input type="password" maxlength="6" name="modiPasswd">
    </td>
</tr>
<tr id="style298" style="display:none">
    <td width="13%" class="blue">
         �������� 
    </td>
    <td colspan="3">
        <input type="hidden" readonly name="code298" value="298">
        <input type="text" name="value298">
    </td>
</tr>
<tr id="style299" style="display:none">
    <td width="13%" class="blue">
         ����� 
    </td>
    <td colspan="3">
        <input type="hidden" readonly name="code299" value="299">
        <input type="text" name="value299">
    </td>
</tr>
<tr id="style002" style="display:none">
    <td width="13%" class="blue">
         ����ʹ�÷�ʽ 
    </td>
    <td colspan="3">
        <input type="hidden" readonly name="code002" value="002">
        <select name="value002">
            <option value="" selected>��ѡ������ʹ�÷�ʽ</option>
            <option value="1">ʹ������</option>
            <option value="0">��ʹ������</option>
        </select>
    </td>
</tr>
<tr id="style003" style="display:none">
    <td width="13%" class="3" class="blue">
         �ײͱ�� 
    </td>
    <td colspan="3">
        <input type="hidden" readonly name="code003" value="003">
        <select name="value003">
            <option value="" selected>��ѡ���ײͱ��</option>
            <option value="01">01�ײ�</option>
            <option value="02">02�ײ�</option>
        </select>
    </td>
</tr>
<tr id="style004" style="display:none">
    <td width="13%" class="blue">
         ͬ���߼� 
    </td>
    <td colspan="3">
        <input type="hidden" readonly name="code004" value="004">
        <select name="value004">
            <option value="" selected>��ѡ��ͬ���߼�</option>
            <option value="1">�Է�����Ϊ׼</option>
            <option value="0">���ն�Ϊ׼</option>
            <option value="2">�������</option>
        </select>
    </td>
</tr>
<!--17201�������-->
<tr id="style001" style="display:none">
    <td width="13%" class="blue">
         ���η�ʽ 
    </td>
    <td colspan="3">
        <input type="hidden" readonly name="code001" value="001">
        <select name="value001">
            <option value="" selected>��ѡ�����η�ʽ</option>
            <option value="10">����������</option>
            <option value="01">����������</option>
            <option value="11">���ڹ�������</option>
            <option value="12">׷�ӹ�������</option>
        </select>
    </td>
</tr>
<!--ͨ���������-->
<tr id="gddp" style="display:none">
    <td width="13%" class="blue">
         �ײͰ��� 
    </td>
    <td>
        <input type="text" name="PackNumb" value="">
    </td>
    <td class="blue">
         ��ֵҵ����� 
    </td>
    <td>
        <input type="text" name="ServCode" value="">
    </td>
</tr>
<!--BlackBerry���-->
<tr id="berry" style="display:none">
    <td width="13%" class="blue">
         �û�IMSI 
    </td>
    <td>
        <input type="text" name="code005" value="">
    </td>
    <td class="blue">
         ����ҵ������ 
    </td>
    <td>
        <select name="value005">
            <option value="" selected>��ѡ��ҵ�����</option>
            <option value="01">01- ���ſͻ�ҵ��</option>
            <option value="02">02- ���ſͻ���չҵ��</option>
        </select>
    </td>
</tr>
<!--����������ѡ���-->
<tbody id="InterPri" style="display:none">
    <tr>

        <td width="13%" class="blue">
             �û�IMSI 
        </td>
        <td>
            <input type="text" name="code006" value="">
        </td>
        <td class="blue">
             ���� 
        </td>
        <td>
            <input type="text" name="code007" value="451">
        </td>
    </tr>
    <tr>
        <td class="blue">
             �������� 
        </td>
        <td>
            <input type="text" name="code008" value="852">
        </td>

        <td class="blue">
             ������������ 
        </td>
        <td>
            <input type="text" name="code009" value="HKGSM">
        </td>
    </tr>
    <tr>
        <td class="blue">
             ��Чʱ��[YYYYMMDD] 
        </td>
        <td>
            <input type="text" name="code010" value="">
        </td>
        <td colspan="2"/>
    </tr>
</tbody>
<!--PUSHMAIL���-->
<tr id="psml" style="display:none">
    <td width="13%" class="blue">
         ҵ����� 
    </td>
    <td colspan="3">
        <input type="hidden" readonly name="code300" value="300">
        <select name="value300">
            <option value="" selected>��ѡ��ҵ�����</option>
            <option value="01">����ҵ��</option>
            <option value="02">����ҵ��</option>
        </select>
    </td>
</tr>
<tr id="mode" style="display:none">
    <td width="13%" class="blue">
         �ײ���� 
    </td>
    <td colspan="3">
    	<select name="modecode">
        <option value="">��ѡ���ײ�����</option>
	    </select>
	  </td>
</tr>
<!--�ֻ�Ǯ�����-->
<tr id="cash" style="display:none">
    <td width="13%" class="blue">
         �ʻ���� 
    </td>
    <td>
        <select name="code301">
            <option value="" selected>��ѡ���ʻ����</option>
            <option value="001">�����ʻ�</option>
            <option value="002">��ֵ�ʻ�</option>
            <option value="003">�����ʻ�</option>
        </select>
    </td>
    <td width="13%" class="blue">
         �ʻ����� 
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
                <input name=sure type=button value=ȷ�� onclick="docheck()" class="b_foot">
                &nbsp;
                <input name=clear type=reset value=��� class="b_foot">
                &nbsp;
                <input name=reset type=reset value=�ر� onClick="parent.removeTab('<%=opCode%>')" class="b_foot">
            </td>
        </tr>
    </tbody>
</table>
<%@ include file="/npage/include/footer.jsp" %>
</FORM>
</BODY>
</HTML>

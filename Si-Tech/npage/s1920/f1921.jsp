<%
/********************
 version v2.0
 ������: si-tech
 update hejw@2009-1-13
********************/
%>
<%
  String opCode = "1921";
  String opName = "�ֻ���ҵ������";
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http//www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http//www.w3.org/1999/xhtml">
	
<%@ page contentType="text/html;charset=Gb2312"%>
<%@ include file="/npage/include/public_title_name.jsp" %>

<!----------------------��������java �ļ�---->


<%
		String phoneNo = request.getParameter("activePhone");
        String regionCode = (String)session.getAttribute("regCode");
%>
	 <wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="region" routerValue="<%=regionCode%>"  id="sysAcceptl" /> 
	 	
	 	<%
	 	String printAccept = sysAcceptl;
	 	%>
<HTML><HEAD><TITLE>�ֻ���ҵ������</TITLE>
<META content="text/html; charset=gb2312" http-equiv=Content-Type>
<!--
<META content=no-cache http-equiv=Pragma>
<META content=no-cache http-equiv=Cache-Control>
-->
<script language="JavaScript">
<!--
//����Ӧ��ȫ�ֵı���
var SUCC_CODE	= "0";   		//�Լ�Ӧ�ó�����
var ERROR_CODE  = "1";			//�Լ�Ӧ�ó�����
var YE_SUCC_CODE = "000000";		//����Ӫҵϵͳ������޸�
var dynTbIndex=1;				//���ڶ�̬�����ݵ�����λ��,��ʼֵΪ1.���Ǳ�ͷ



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
			rdShowMessageDialog("<br>�������:["+error_code+"]</br>������Ϣ:["+error_msg+"]");
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
    document.form.optype.options[document.form.optype.options.length]=new Option("��ѡ���������","");
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
			rdShowMessageDialog("��ѡ��ҵ�����!");
			return false;
		}
		/*if(form.phoneno.value.length<11 || isNumberString(form.phoneno.value,"1234567890")!=1) {
			rdShowMessageDialog("�������ֻ�����,����Ϊ11λ����!!");
			document.form.phoneno.focus();
			return false;
		}
		else if (parseInt(form.phoneno.value.substring(0,2),10)!=15 && (parseInt(form.phoneno.value.substring(0,3),10)<134 || parseInt(form.phoneno.value.substring(0,3),10)>139)){
			rdShowMessageDialog("������134-139,��15��ͷ���ֻ�����!!");
			document.form.phoneno.focus();
			return false;
		}*/
if(!forMobil(document.form.phoneno)){
		return false;
}
	
	  var myPacket = new AJAXPacket("f1920_rpc_check.jsp","����ȷ�ϣ����Ժ�......");
	
		myPacket.data.add("verifyType","phoneno");
		myPacket.data.add("phoneno",document.form.phoneno.value);
		myPacket.data.add("passwd","");
		    	    
	  core.ajax.sendPacket(myPacket);
	  myPacket = null;
	  		
	}
	
function getOperCode()
{
	  var myPacket = new AJAXPacket("f1920oper_code.jsp","����ȷ�ϣ����Ժ�......");
	
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
		switchStatusName="��";
	}
	else if(switchStatus=="1"){
		switchStatusName="��";
	}
	tr1=dyntb.insertRow();	//ע��:����ı������������һ��,������ɿ���.yl.
	tr1.id="tr"+dynTbIndex;
	
	             
	tr1.insertCell().innerHTML = '<div align="center">'+ switchName+':</div>';
	tr1.insertCell().innerHTML = '<div align="center"><input id=R2    name="switchName'+switchBizType+'" type=hidden   align="center"  value="'+ switchName+'"  readonly></input><input id=R3    name="switch'+switchBizType+'" type=hidden   align="center"  value="'+ switchStatus+'"  readonly></input>'+ switchStatusName+'</div>';      
	
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
            rdShowMessageDialog('���������븺ֵ,����������!');
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
   //����ʹ�� document.all.spBizCode.value="10085";

/*
if(form.phoneno.value.length<11 || isNumberString(form.phoneno.value,"1234567890")!=1) {
rdShowMessageDialog("�������ֻ�����,����Ϊ11λ����!!");
document.form.phoneno.focus();
return false;
}
else if (parseInt(form.phoneno.value.substring(0,2),10)!=15 && (parseInt(form.phoneno.value.substring(0,3),10)<134 || parseInt(form.phoneno.value.substring(0,3),10)>139)){
rdShowMessageDialog("������134-139,��15��ͷ���ֻ����� !!",0);
document.form.phoneno.focus();
return false;
}*/

if(!forMobil(document.form.phoneno)){
		return false;
}

if(document.all.runname.value.substring(1,2)!="A" &&document.all.runname.value.substring(1,2)!="K"){
	rdShowMessageDialog("�û�״̬������������������ҵ��!",0);
	return false;
}
if( form.optype.value==""||form.optype.value=="00") {
rdShowMessageDialog("��ѡ��������!!",0);
document.form.optype.focus();
return false;
}
if( form.NewPasswd.value.length<1 && form.optype.value=="03" ) {
rdShowMessageDialog("������ҵ������!!",0);
document.form.NewPasswd.focus();
return false;
}
if( form.ConfirmPasswd.value.length<1 && form.optype.value=="03" ) {
rdShowMessageDialog("������ȷ������!!",0);
document.form.ConfirmPasswd.focus();
return false;
}
if( form.NewPasswd.value!= form.ConfirmPasswd.value && form.optype.value=="03" ) {
rdShowMessageDialog("�����������벻һ��!!",0);
document.form.NewPasswd.focus();
return false;
}
//else if((busy_code=="01"||busy_code=="02")&&form.optype.value=="01"){
if((busy_code=="02")&&form.optype.value=="01"){
    if(form.value001.value=="01"){
            rdShowMessageDialog("���ܵ�����ͨ��������!",0);
            document.form.value001.focus();
            return false;
    }else if(form.value001.value==""){
            rdShowMessageDialog("��ѡ������Ҫ������ҵ��!",0);
            document.form.value001.focus();
            return false;
    }
}
//else if((busy_code=="01"||busy_code=="02")&&(form.optype.value=="02"||form.optype.value=="04")&&form.value001.value=="10"){
else if((busy_code=="02")&&(form.optype.value=="02"||form.optype.value=="04")&&form.value001.value=="10"){
        rdShowMessageDialog("���ܵ���ȡ������ҵ��!",0);
        document.form.value001.focus();
        return false;
}
//else if((busy_code=="01"||busy_code=="02")&&(form.optype.value=="02"||form.optype.value=="04")&&form.value001.value=="12"){
else if((busy_code=="02")&&(form.optype.value=="02"||form.optype.value=="04")&&form.value001.value=="12"){
        rdShowMessageDialog("���ܵ���ȡ����������ҵ��!",0);
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
	if(typeof(form[eval('switchType')])!="undefined")
	{
	if(form[eval('switchType')].value=="0"){
		rdShowMessageDialog(form[eval('switchName')].value+"�ѹرգ����������κ�����ҵ��!",0);
		return false;
	}
	}
	switchType="switch"+busy_code;
	switchName="switchName"+busy_code;
	if(typeof(form[eval('switchType')])!="undefined")
	{
	if(form[eval('switchType')].value=="0"){
		rdShowMessageDialog(form[eval('switchName')].value+"�����ѹرգ�����������ҵ��!",0);
		return false;
	}
	}
	//����ҵ�����ѡ��sp��ҵ�����ҵ�����
	if(document.form.spCode.value==""){
		rdShowMessageDialog("��ѡ��sp��ҵ���룡",0);
		return false;
	}
	if(document.form.spBizCode.value==""){
		rdShowMessageDialog("��ѡ��spҵ����룡",0);
		return false;
	}
}
if(document.form.spCode.value=="[object]" ||document.form.spCode.value=="undefine"){
	rdShowMessageDialog("���Ϸ���SP��ҵ���룬������ѡ��",0);
	return false;
}
if(document.form.spBizCode.value=="[object]" ||document.form.spBizCode.value=="undefine"){
	rdShowMessageDialog("���Ϸ���SPҵ����룬������ѡ��",0);
	return false;
}
if(busy_code=="21" &&��form.optype.value=="01"){//�ֻ�Ǯ���ж�
	if(document.form.code301.value==""){
		rdShowMessageDialog("��ѡ���ֻ�Ǯ���ʻ����ͣ�",0);
		return false;
	}
	if(document.form.value301.value==""){
		document.form.value301.value="|";
	}
}
if(busy_code=="21" &&��form.optype.value=="02"){//�ֻ�Ǯ���ж�
	if(document.form.spCode.value==""){
		rdShowMessageDialog("��ѡ��SP��ҵ���룡",0);
		return false;
	}
	if(document.form.spBizCode.value==""){
		document.form.spBizCode.value="|";
	}
}
if(form.optype.value=="99"){//ȫҵ���˶��ж�
	if(document.form.spCode.value==""){
		rdShowMessageDialog("��ѡ��SP��ҵ���룡",0);
		return false;
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
 	document.form.action="f1921_cfm.jsp";
	form.submit();
	return true;
}

function showPrtDlg(printType,DlgMessage,submitCfm)
{  //��ʾ��ӡ�Ի��� 
   var h=150;
   var w=350;
   var t=screen.availHeight/2-h/2;
   var l=screen.availWidth/2-w/2;
   var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no"; 
   var printStr = printInfo(printType);
   
     var pType="subprint";                     // ��ӡ����print ��ӡ subprint �ϲ���ӡ
     var billType="1";                      //  Ʊ������1���������2��Ʊ��3�վ�
     var sysAccept =<%=printAccept%>;                       // ��ˮ��
     var printStr = printInfo(printType);   //����printinfo()���صĴ�ӡ����
     var mode_code=null;                        //�ʷѴ���
     var fav_code=null;                         //�ط�����
     var area_code=null;                        //С������
     var opCode =   "<%=opCode%>";                         //��������
     var phoneNo = <%=phoneNo%>;                            //�ͻ��绰
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
		
	cust_info+="�ֻ����룺"+document.all.phoneno.value+"|";
	cust_info+="�ͻ�������"+document.all.value201.value+"|";

	opr_info+="ҵ�����ͣ�"+document.all.busytype.options[document.all.busytype.selectedIndex].text+"|";
	opr_info+="�������ͣ�"+document.all.optype.options[document.all.optype.selectedIndex].text+"|";
  opr_info+="SP��ҵ���룺"+document.all.spCode.value+"|";
	opr_info+="SPҵ����룺"+document.all.spBizCode.value+"|";

	note_info1+="��ע��|";

		
	  retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
    retInfo=retInfo.replace(new RegExp("#","gm"),"%23"); //�ѡ�#"�滻Ϊurl��ʽ
    return retInfo;
}

function getinfo()
{
/*if( form.phoneno.value.length<11 || isNumberString(form.phoneno.value,"1234567890")!=1 ) {
rdShowMessageDialog("�������ֻ�����,����Ϊ11λ���� !!",0);
document.form.phoneno.focus();
return false;
}
else if (parseInt(form.phoneno.value.substring(0,2),10)!=15 && (parseInt(form.phoneno.value.substring(0,3),10)<134 || parseInt(form.phoneno.value.substring(0,3),10)>139)){
rdShowMessageDialog("������15,134-139��ͷ���ֻ����� !!",0);
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
                        rdShowMessageDialog("û���ҵ���Ӧ�Ŀͻ���",0);
                        document.form.phoneno.focus();
                        return false;}
                else {var chPos_str = str.indexOf("|");
                        document.all.value201.value=str.substring(0,chPos_str);
                        var str2 = str.substring(chPos_str+1);
                        var chPos_str2 = str2.indexOf("|");
                        document.all.custpassword.value=str2.substring(0,chPos_str2);
                        document.all.runname.value=str2.substring(chPos_str2+1);
                        if(document.all.runname.value!="����"){
                                rdShowMessageDialog("�û�״̬Ϊ��"+document.all.runname.value+"�������������ҵ������",0);
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
	//����������������ʼ�ղ���ʵ
	document.all.style298.style.display="none";
	document.all.style299.style.display="none";
}
function changeOpType() { 					
					var i = form.optype.value;
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
									document.all.spinfo.disabled=false;
									document.all.spinfo.style.display ="";						
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
        //����������������ʼ�ղ���ʵ
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
	        
	        //����Ϊ�Զ������
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
                rdShowMessageDialog("����ѡ����ҵ���룡",0);
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
                rdShowMessageDialog("��ѡ��ҵ�������룡",0);
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
		<div id="title_zi">�ֻ���ҵ������</div>
	</div>
<input type="hidden" name="busy_type"  value="1">
<input type="hidden" name="custpassword"  value="">
<input type="hidden" name="busy_name"  value="">
<input type="hidden" name="printAccept"  value="<%=printAccept%>">
 
              <table  cellspacing="0"> 
              	<tr> 
								  <td width="13%" class="blue"><div align="right">ҵ�����</div></td>
                  <td width="39%"> <select name="busytype"     onChange="changeBusyType()">
                  <option  value="05">�й��ֻ���</option>
                  </select>
                  <td width="13%">&nbsp;</td>
                  <td width="39%">&nbsp;</td>
                </tr>
                  
                <tr> 
                  <td width="13%" class="blue"><div align="right">�ֻ�����</div></td>
                  <td> 
                    <input type="text" name="phoneno" maxlength="11"  onKeyPress="return isKeyNumberdot(0)" value =<%=phoneNo%>  Class="InputGrey" readOnly >
                  </td>
                  <td class="blue">&nbsp;</td>
                  <td>
                    &nbsp;
                    <input type="button" class="b_text" name="query" value="��ѯ" onclick="getUserInfo()">
                  </td>
                </tr>                        
                <tr> 
                  <td width="13%" class="blue"><div align="right">�û�����</div></td>
                  <td>
                    <input type="hidden"  readonly  class="InputGrey" name="code201" value="201">
                    <input type="text"  readonly class="InputGrey" name="value201" value="">
                  </td>
                  <td class="blue"><div align="right">����״̬</div></td>
                  <td>
                    <input type="text" readonly  class="InputGrey" name="runname" value="">
                  </td>
                </tr> 
                <tr id="openinfo1"   style="display:none"> 
	            		<td colspan="4"  class="blue"><B><div align="center">����ҵ�񿪹�״̬��Ϣ</div></B></td>
          			</tr>  
                <tr id="openinfo2"   style="display:none"> 
	            		<td colspan="4" >
	            			<table width="98%"  id="dyntb">
			                <tr> 
			                  <th><div align="center">��������</div></th>
			                  <th><div align="center">����״̬</div></th>
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
                  <td width="13%" class="blue"><div align="right">��������</div></td>
                  <td width="39%">
                      <select name="optype"    onChange="changeOpType()">
      									<option  value="">��ѡ��������</option>                      
                      </select>
                  </td>
                  <td>&nbsp;</td>
                  <td>&nbsp;</td>
                </tr>
                <tr id="spinfo" style="display:none">
                  <td width="13%" class="blue"><div align="right">SP��ҵ����</div></td>
                  <td>
                    <select name="spCode"  >
      									<option value="801234" selected>801234->�й��ƶ�ͨ��</option>                      
                     </select>
                  </td>
                  <td class="blue"><div align="right">SPҵ�����</div></td>
                  <td>
                     <input type="text" name="spBizCode" value="" readonly class="InputGrey" ><input type="button" class="b_text" name="spBipQuery" value="��ѯ" onclick="getSpBizInfo(document.form.spCode.value)">
                  </td>
                </tr>
                <tr id="NewPasswd" style="display:none"> 
                  <td width="13%" class="blue"><div align="right">ҵ������</div></td>
                  <td><input type="password" maxlength="6" name="NewPasswd"></td>
                  <td></td>
                  <td></td>
                </tr>
                <tr id="ConfirmPass"> 
                  <td width="13%" class="blue"><div align="right">����ȷ��</div></td>
                  <td>
                    <input type="password"  maxlength="6" name="ConfirmPasswd">
                  </td>
                  <td>&nbsp;</td>
                  <td>&nbsp;</td>
                </tr>
                <tr id="modiPass" style="display:none"> 
                  <td width="13%" class="blue"><div align="right">��ҵ������</div></td>
                  <td>
                    <input type="password"  maxlength="6" name="modiPasswd">
                  </td>
                  <td></td>
                  <td></td>
                </tr>
                <tr id ="style298" style="display:none"> 
                  <td width="13%" class="blue"><div align="right">��������</div></td>
                  <td>
                                        <input type="hidden"  readonly class="InputGrey"  name="code298" value="298">
                    <input type="text"   name="value298">
                  </td>
                  <td></td>
                  <td>
                  </td>
                </tr>
                <tr id ="style299"  style="display:none"> 
                  <td width="13%" class="blue"><div align="right">�����</div></td>
                  <td>
                    <input type="hidden"  readonly  class="InputGrey" name="code299" value="299">
                    <input type="text"   name="value299">
                  </td>
                  <td></td>
                  <td></td>
                </tr>
                <tr id="style002" style="display:none"> 
                  <td width="13%" class="blue"><div align="right">����ʹ�÷�ʽ</div></td>
                  <td> 
                                        <input type="hidden"  readonly  class="InputGrey" name="code002" value="002">
                                                <select name="value002">
                                                <option value="" selected>��ѡ������ʹ�÷�ʽ</option>
                      <option value="1">ʹ������</option>
                      <option value="0">��ʹ������</option>
                    </select>
                  </td>
                  <td></td>
                  <td></td>
                </tr>                           
                <tr id="style003" style="display:none"> 
                  <td width="13%" class="blue"><div align="right">�ײͱ��</div></td>
                  <td> 
                    <input type="hidden"  readonly  class="InputGrey" name="code003" value="003">
                    <select name="value003">
                      <option value="" selected>��ѡ���ײͱ��</option>
                      <option value="01">01�ײ�</option>
                      <option value="02">02�ײ�</option>
                    </select>
                  </td>
                  <td></td>
                  <td></td> 
                </tr>
                <tr id="style004" style="display:none"> 
                  <td width="13%" class="blue"><div align="right">ͬ���߼�</div></td>
                  <td> 
                    <input type="hidden"  readonly  class="InputGrey" name="code004" value="004">
                    <select name="value004">
                      <option value="" selected>��ѡ��ͬ���߼�</option>
                      <option value="1">�Է�����Ϊ׼</option>
                      <option value="0">���ն�Ϊ׼</option>
                      <option value="2">�������</option>
                    </select>
                  </td>
                  <td></td>
                  <td></td> 
                </tr>
                <!--17201�������-->
                <tr id="style001" style="display:none"> 
                  <td width="13%" class="blue"><div align="right">���η�ʽ</div></td>
                  <td> 
                    <input type="hidden"  readonly  class="InputGrey" name="code001" value="001">
                    <select name="value001">
                      <option value="" selected>��ѡ�����η�ʽ</option>
                      <option value="10">����������</option>
                      <option value="01">����������</option>
                      <option value="11">���ڹ�������</option>
                      <option value="12">׷�ӹ�������</option>
                    </select>
                  </td>
                  <td></td>
                  <td></td>
                </tr>
                <!--ͨ���������-->
                <tr id="gddp" style="display:none"> 
                  <td width="13%" class="blue"><div align="right">�ײͰ���</div></td>
                  <td> 
                    <input type="text"  name="PackNumb" value="">
                  </td>
                  <td class="blue"><div align="right">��ֵҵ�����</div></td>
                  <td> 
                    <input type="text"  name="ServCode" value="">
                  </td>
                </tr>
                <!--PUSHMAIL���-->
                <tr id="psml" style="display:none"> 
                  <td width="13%" class="blue"><div align="right">PushMailҵ�����</div></td>
                  <td> 
                    <input type="hidden"  readonly  class="InputGrey" name="code300" value="300">
                    <select name="value300">
                      <option value="" selected>��ѡ��ҵ�����</option>
                      <option value="01">����ҵ��</option>
                      <option value="02">����ҵ��</option>
                    </select>
                  </td>
                  <td></td>
                  <td></td>
                </tr>
                <!--�ֻ�Ǯ�����-->
                <tr id="cash" style="display:none"> 
                  <td width="13%" class="blue"><div align="right">�ʻ����</div></td>
                  <td> 
                    <select name="code301">
                      <option value="" selected>��ѡ���ʻ����</option>
                      <option value="001">�����ʻ�</option>
                      <option value="002">��ֵ�ʻ�</option>
                      <option value="003">�����ʻ�</option>
                    </select>
                  </td>
                  <td width="13%" class="blue"><div align="right">�ʻ�����</div></td>
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
                  <input  name=sure type=button class="b_foot" value=ȷ�� onclick="docheck()"> 
                                  &nbsp;
                  <input  name=clear type=reset class="b_foot"  value=���>
                                  &nbsp;
                  <input  name=reset type=reset  class="b_foot" value=�ر� onClick="removeCurrentTab()">
		  
                </td>
              </tr>
              </tbody> 
            	</table>
 
<%@ include file="/npage/include/footer.jsp" %>
</FORM>

</BODY>

</HTML>

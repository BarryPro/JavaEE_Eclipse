<%
/********************
 * version v2.0
 * ������: si-tech
 * update by qidp @ 2009-02-05
 ********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page contentType= "text/html;charset=GBK" %>
<%
        String opCode = "9113";
        String opName = "�û���Ϣ����������";
        String workNo = (String)session.getAttribute("workNo");
        String workName = (String)session.getAttribute("workName");
        String regionCode=(String)session.getAttribute("regCode");
        /*yanpx@20100903Ϊ�ͷ� ����ӡ������ ��ʼ*/
        String accountType = (String)session.getAttribute("accountType"); //1 ΪӪҵ���� 2 Ϊ�ͷ�����
        /*����*/
        
        String op_name =  "�û���Ϣ����������";
        
        //ArrayList arr = (ArrayList)session.getAttribute("allArr");
        //String[][] baseInfo = (String[][])arr.get(0);
        
        String[][] temfavStr=(String[][])session.getAttribute("favInfo");
        String[] favStr=new String[temfavStr.length];
        for(int i=0;i<favStr.length;i++)
        favStr[i]=temfavStr[i][0].trim();
        boolean pwrf=false;
        boolean hfrf=false;
        String passFlag="true";
        /*�ļ�����ӪҵԱ������*/
        String power_right=(String)session.getAttribute("powerRight");
        System.out.println("--------------power_right==="+power_right);
        if(Integer.parseInt(power_right.trim())>=0){
                pwrf=true;
        }
%>
<wtc:sequence name="sPubSelect" key="sMaxSysAccept" id="loginAccept" />
<%
System.out.println("--------------loginAccept==="+loginAccept);
%>

<html xmlns="http://www.w3.org/1999/xhtml">
<HEAD><TITLE><%=op_name%></TITLE>
        
<script language="JavaScript">
<!--

//����Ӧ��ȫ�ֵı���
var SUCC_CODE   = "0";                  //�Լ�Ӧ�ó�����
var ERROR_CODE  = "1";                  //�Լ�Ӧ�ó�����
var YE_SUCC_CODE = "000000";            //����Ӫҵϵͳ������޸�
var dynTbIndex=1;                               //���ڶ�̬�����ݵ�����λ��,��ʼֵΪ1.���Ǳ�ͷ

var js_pwFlag="true";

//core.loadUnit("debug");
//core.loadUnit("rpccore"); 

onload=function()
{               
        //core.rpc.onreceive = doProcess;       
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
                        var idNo=packet.data.findValueByName("idNo");
                        document.all.value201.value=custname;
                        document.all.runname.value=runcode;
                        document.form.busy_type.value=document.form.busytype.value;
                        document.all.idNo.value=idNo;
                        //�ж��û�״̬
                        if(document.all.runname.value.substring(1,2)!="A" &&document.all.runname.value.substring(1,2)!="K"){
                						rdShowMessageDialog("�û�״̬������������������ҵ��!",0);
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
                                document.all.openinfo3.style.display="";
                                document.all.dyntb.style.display="";
                        }else{
                            document.all.openinfo1.style.display="none";
                                document.all.openinfo3.style.display="none";
                                document.all.dyntb.style.display="none";
                        }
                        //qucc add wlan�����Ϊ8λ
                        var busy_code=document.all.busytype.value;
                        if(busy_code=="02" || busy_code=="92"){
								        	//����������󳤶�
									        document.all.NewPasswd.maxLength="8";
									        document.all.ConfirmPasswd.maxLength="8";
									        document.all.modiPasswd.maxLength="8";
								        }
                        getOperCode();
                }
                else{
                        rdShowMessageDialog("<br>�������:["+error_code+"]</br>������Ϣ:["+error_msg+"]",0);
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
						document.form.optype.options[document.form.optype.options.length]=new Option(backArrMsg[i][1],backArrMsg[i][0]);
					}
        }
        
}

function trim(val)
{
        var exp = /(^\s+)|(\s+$)/g;
        var resVal = val.replace(exp,"");
        return resVal;
}

function getUserInfo()
{
        document.all.style005.style.display = "none";// wugl add 20090207
        /*
        if(form.busytype.value.length<=0 ||form.busytype.value=="00"){
                rdShowMessageDialog("��ѡ��ҵ�����!");
                return false;
        }
        */
        if(form.phoneno.value.length<11 || isNumberString(form.phoneno.value,"1234567890")!=1) {
                rdShowMessageDialog("�������ֻ�����,����Ϊ11λ����!!");
                document.form.phoneno.focus();
                return false;
        }
        else if (!forMobil(form.phoneno)){
                
                document.form.phoneno.focus();
                return false;
        }
        /* ningtn CRM�ͷ�ϵͳ���ܵ�����
        else if(js_pwFlag=="false" && trim(form.accountpassword.value).length<6) {
                rdShowMessageDialog("������6λ�ǿ��û�����!!");
                document.form.accountpassword.focus();
                return false;
        }
        */
        //������
        var accountpassword=document.form.accountpassword.value;
        if(js_pwFlag=="true"){
                accountpassword="";
        }
        
        var myPacket = new AJAXPacket("f9113_rpc_check.jsp","����ȷ�ϣ����Ժ�......");
        
        myPacket.data.add("verifyType","phoneno");
        myPacket.data.add("phoneno",document.form.phoneno.value);
        myPacket.data.add("passwd",accountpassword);
        core.ajax.sendPacket(myPacket);
        myPacket = null;             
}

function getOperCode()
{
        var myPacket = new AJAXPacket("f9113_oper_code.jsp","����ȷ�ϣ����Ժ�......");
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
        tr1=dyntb.insertRow();  //ע��:����ı������������һ��,������ɿ���.yl.
        tr1.id="tr"+dynTbIndex;
        
           
cell = tr1.insertCell();
cell.colSpan = 2;       
cell.innerHTML='<div align="center">'+ switchName+'</div>';
        //tr1.insertCell().innerHTML = '<div align="center">'+ switchName+'</div>';
cell2 = tr1.insertCell();
cell2.colSpan = 2; 
cell2.innerHTML='<div align="center"><input id=R2    name="switchName'+switchBizType+'" type=hidden   align="center"  value="'+ switchName+'"  readonly></input><input id=R3    name="switch'+switchBizType+'" type=hidden   align="center"  value="'+ switchStatus+'"  readonly></input>'+ switchStatusName+'</div>';      
        //tr1.insertCell().innerHTML = '<div align="center"><input id=R2    name="switchName'+switchBizType+'" type=hidden   align="center"  value="'+ switchName+'"  readonly></input><input id=R3    name="switch'+switchBizType+'" type=hidden   align="center"  value="'+ switchStatus+'"  readonly></input>'+ switchStatusName+'</div>';      
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

function dochecke177(packet){
	var errorCode = packet.data.findValueByName("errorCode");
	if(errorCode =="000000"){
		var returncode = packet.data.findValueByName("returncode");
		if(returncode=="000000") 
		{
			form.checkflag.value = "0";
			form.checkmsg.value = "success";
		}
		else 
		{
			form.checkflag.value = "1";
			form.checkmsg.value = "�𾴵Ŀͻ������������˶������ʷ��е������Ѱ���������ҵ�񣬵������˶������������Ȼ������ȡ����ѯ10086";
		}
	}
	else
	{
		form.checkflag = "2";
		form.checkmsg.value = "��ѯ���ʷ��Ƿ����������ҵ��ʱʧ��";
		return false;

	}
}

function checkOfferSP()
{
	if(document.form.spCode.value=="801234"&&document.form.spBizCode.value=="110301")
	{
		var packet = new AJAXPacket("<%=request.getContextPath()%>/npage/s1141/checkQuitType.jsp","���Ժ�...");
		packet.data.add("phoneno","<%=activePhone%>");
		packet.data.add("seseq","80007");
		core.ajax.sendPacket(packet,dochecke177);
		packet =null;
	}
}

function docheck()
{

        if(form.opnote.value.length<1){
                        form.opnote.value=form.phoneno.value+form.optype.options[form.optype.selectedIndex].innerText+form.busytype.options[form.busytype.selectedIndex].innerText+"ҵ��";                      
        }
        var busy_code=document.all.busytype.value;
        
        if(form.phoneno.value.length<11 || isNumberString(form.phoneno.value,"1234567890")!=1) {
        rdShowMessageDialog("�������ֻ�����,����Ϊ11λ����!!");
        document.form.phoneno.focus();
        return false;
        }
        else if (parseInt(form.phoneno.value.substring(0,2),10)!=15 && parseInt(form.phoneno.value.substring(0,3),10)!=188 && parseInt(form.phoneno.value.substring(0,3),10)!=147 && parseInt(form.phoneno.value.substring(0,2),10)!=18 && (parseInt(form.phoneno.value.substring(0,3),10)<134 || parseInt(form.phoneno.value.substring(0,3),10)>139)){
        rdShowMessageDialog("������134-139,15��ͷ���ֻ����� !!");
        document.form.phoneno.focus();
        return false;
        }
        if(document.all.runname.value.substring(1,2)!="A" &&document.all.runname.value.substring(1,2)!="K"){
                rdShowMessageDialog("�û�״̬������������������ҵ��!");
                return false;
        }
        if( form.optype.value==""||form.optype.value=="00") {
        rdShowMessageDialog("��ѡ��������!!");
        document.form.optype.focus();
        return false;
        }
        if( form.NewPasswd.value.length<1 && form.optype.value=="03" && document.all.busytype.value!="78") {
        rdShowMessageDialog("������ҵ������!!");
        document.form.NewPasswd.focus();
        return false;
        }
        if( form.ConfirmPasswd.value.length<1 && form.optype.value=="03" && document.all.busytype.value!="78") {
        rdShowMessageDialog("������ȷ������!!");
        document.form.ConfirmPasswd.focus();
        return false;
        }
        if( (document.all.biz_passwd.style.display==""&&document.all.ConfirmPass.style.display=="")&&(form.NewPasswd.value!="" || form.ConfirmPasswd.value!="")&&form.NewPasswd.value!= form.ConfirmPasswd.value) {
        rdShowMessageDialog("�����������벻һ��!!");
        document.form.NewPasswd.focus();
        return false;
        }
        //else if((busy_code=="01"||busy_code=="02")&&form.optype.value=="01"){
        /*if((busy_code=="02")&&form.optype.value=="01"){
            if(form.value001.value=="01"){
                    rdShowMessageDialog("���ܵ�����ͨ��������!");
                    document.form.value001.focus();
                    return false;
            }else
            if(form.value001.value==""){
                    rdShowMessageDialog("��ѡ������Ҫ������ҵ��!");
                    document.form.value001.focus();
                    return false;
            }
        }
        //else if((busy_code=="01"||busy_code=="02")&&(form.optype.value=="02"||form.optype.value=="04")&&form.value001.value=="10"){
        else if((busy_code=="02")&&(form.optype.value=="02"||form.optype.value=="04")&&form.value001.value=="10"){
                rdShowMessageDialog("���ܵ���ȡ������ҵ��!");
                document.form.value001.focus();
                return false;
        }
        //else if((busy_code=="01"||busy_code=="02")&&(form.optype.value=="02"||form.optype.value=="04")&&form.value001.value=="12"){
        else 
        }*/
        if((busy_code=="02")&&(form.optype.value=="02"||form.optype.value=="04")&&form.value001.value=="12"){
                rdShowMessageDialog("ȡ������ѡ��׷�ӹ����Զ���֤!");
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
                //if(form[eval('switchType')].value=="0"){
                //      rdShowMessageDialog(form[eval('switchName')].value+"�ѹرգ����������κ�����ҵ��!");
                //      return false;
                //}
                switchType="switch"+busy_code;
                switchName="switchName"+busy_code;
                if(form[eval('switchType')].value=="0"){
                        rdShowMessageDialog(form[eval('switchName')].value+"�����ѹرգ�����������ҵ��!");
                        return false;
                }
                if(form.optype.value!="99"){
                        //����ҵ�����ѡ��sp��ҵ�����ҵ�����
                        if(document.form.spCode.value==""){
                                rdShowMessageDialog("��ѡ��sp��ҵ���룡");
                                return false;
                        }
                        if(form.optype.value!="89"){
                                if(document.form.spBizCode.value==""){
                                        rdShowMessageDialog("��ѡ��spҵ����룡");
                                        return false;
                                }
                        }
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
        if(busy_code=="51"){//�����������ж�
            if(document.form.value302.value==""){
                    rdShowMessageDialog("�����������ID");
                    return false;
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
        if(form.optype.value=="11"){//ȫҵ���˶��ж�
                if(document.form.thirdNo.value=="" || document.form.thirdNo.value.length!=11 || (document.form.thirdNo.value.substring(0,2) != "13" && document.form.thirdNo.value.substring(0,2) != "15")){
                        rdShowMessageDialog("��������ȷ�������ֻ��ţ�");
                        return false;
                }
                if(document.form.oprSource.value==""){
                        rdShowMessageDialog("�������������룡");
                        return false;
                }
        }
        checkOfferSP();
        if(form.checkflag.value=="1")
       	{
       		if(rdShowConfirmDialog(form.checkmsg.value)!=1)
       		{
       			return false;
       		}
       	}
       	else if(form.checkflag.value=="2")
       	{
       		rdShowMessageDialog(form.checkmsg.value);
       		return false;
       	}



        //��ӡ�������ύ��
        if("<%=accountType%>" !="2"){
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
    	}else{
           if(rdShowConfirmDialog('ȷ��Ҫ�ύ��Ϣ��')==1)
           {
           frmCfm();
           }    	
    	}
}

function frmCfm(){
        document.form.action="f9113_2.jsp";
        form.submit();
        document.form.sure.disabled = true;
        return true;
}

function showPrtDlg(printType,DlgMessage,submitCfm)
{  //��ʾ��ӡ�Ի��� 
	var h=210;
	var w=400;
	var t=screen.availHeight/2-h/2;
	var l=screen.availWidth/2-w/2;
	var pType="subprint";
	var billType="1";
	var sysAccept = "<%=loginAccept%>";
	var phone_no = form.phoneno.value;
	var mode_code = null;
	var fav_code = null;
	var area_code = null;
   
	var printStr = printInfo(printType);
   
	var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no"; 
	var path = "<%=request.getContextPath()%>/npage/innet/hljBillPrint_jc_hw.jsp?DlgMsg=" + DlgMessage;
	var path = path+"&mode_code="+mode_code+"&fav_code="+fav_code+"&area_code="+area_code+"&opCode=<%=opCode%>"+"&sysAccept="+sysAccept+"&phoneNo="+phone_no+"&submitCfm="+submitCfm+"&pType="+pType+"&billType="+billType+ "&printInfo=" + printStr;
	var ret=window.showModalDialog(path,printStr,prop);
	return ret;    
}

function printInfo(printType)
{
    var cust_info="";  //�ͻ���Ϣ
	var opr_info="";   //������Ϣ
	var note_info1=""; //��ע1
	var note_info2=""; //��ע2
	var note_info3=""; //��ע3
	var note_info4=""; //��ע4
	var retInfo = "";  //��ӡ����
		
	cust_info+="�ͻ�������	"+document.all.value201.value+"|";
	cust_info+="�ֻ����룺	"+document.all.phoneno.value+"|";
	opr_info+="ҵ�����ͣ�"+document.all.busytype.options[document.all.busytype.selectedIndex].text+"|";
	opr_info+="�������ͣ�"+document.all.optype.options[document.all.optype.selectedIndex].text+"|";
	opr_info+="SP��ҵ���룺"+document.all.spCode.value+"|";
	opr_info+="SPҵ����룺"+document.all.spBizCode.value+"|";
	retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
	retInfo = retInfo.replace(new RegExp("#","gm"), "%23");
	return retInfo; 
}

function changeBusyType(){      
        //document.all.phoneno.value="";
        document.all.accountpassword.value="";
        document.all.code201.value="";
        //document.all.runname.value="";
        //document.all.value201.value="";
        document.all.openinfo1.style.display="none";
        document.all.openinfo3.style.display="none";
        document.all.dyntb.style.display="none";
        document.all.optype.value="";
        document.all.spCode.value="";
        document.all.spBizCode.value="";
        document.all.NewPasswd.value="";
        document.all.ConfirmPasswd.value="";
        document.all.opnote.value="";
        
        document.form.value001[0].selected=true;
        document.form.value002[0].selected=true;
        document.form.value003[0].selected=true;
        document.form.value004[0].selected=true;
        document.form.value300[0].selected=true;
        document.form.code301[0].selected=true;
        
        document.all.gddp.style.display="none";
        document.all.psml.style.display="none";
        document.all.cash.style.display="none";
        document.all.cmgp.style.display="none";
        
        document.all.style001.style.display="none";
        document.all.style002.style.display="none";
        document.all.style003.style.display="none";
        document.all.style004.style.display="none";
        //��������Ĭ�ϳ���
        document.all.NewPasswd.maxLength="6";
        document.all.ConfirmPasswd.maxLength="6";
        document.all.modiPasswd.maxLength="6";
        var busy_code=document.all.busytype.value;
        if(busy_code=="01"||busy_code=="02"){
                document.all.style001.style.display="";
                //document.form.value001[1].selected=true;
                document.all.spinfo.disabled=false;
                document.all.spinfo.style.display="none";
                document.all.style298.style.display="none";
                document.all.style299.style.display="none";
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
        else if(busy_code=="51"){
            document.all.cibp.style.display="";
            document.all.biz_passwd.style.display="none";
            document.all.ConfirmPass.style.display="none";
            document.all.spinfo.disabled=false;
            document.all.spinfo.style.display = "";
    	}
        else{
           	    document.all.cibp.style.display="none";
                document.all.psml.style.display="none";
                document.all.gddp.style.display="none";
                document.all.style001.style.display="none";
                document.form.value001[0].selected=true;
                document.all.spinfo.disabled=false;
                document.all.spinfo.style.display="";
                document.all.style298.style.display="none";
                document.all.style299.style.display="none";
        }
        if(busy_code=="02" || busy_code=="92"){
        	//����������󳤶�
	        document.all.NewPasswd.maxLength="8";
	        document.all.ConfirmPasswd.maxLength="8";
	        document.all.modiPasswd.maxLength="8";
        }
        document.all.openinfo1.style.display="none";
        document.all.openinfo3.style.display="none";
        document.all.dyntb.style.display="none";
        //����������������ʼ�ղ���ʵ
        document.all.style298.style.display="none";
        document.all.style299.style.display="none";
        /**** ningtn CRM�ͷ�ϵͳ****/
        getUserInfo();
        
}

function changeOpType() {       
        var i = form.optype.value;
        var biz = form.busytype.value;
        document.form.opnote.value="";
        document.all.style005.style.display = "none";
        document.all.spbizinfo3.style.display = "";
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
                if(document.all.busytype.value=="88"){//BLACKBERRY
                    document.all.style003.style.display="";
                    document.all.value001.value="";
                }
                if(document.all.busytype.value=="01"||document.all.busytype.value=="02"){
                        document.all.style001.style.display = "";
                        document.all.value001[0].selected=true;
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
                document.all.cmgp.style.display = "none";
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
                document.all.cmgp.style.display = "none";
                if(document.all.busytype.value=="16"){
                        document.all.gddp.style.display="";
                        document.all.spinfo.disabled=false;
                        document.all.spinfo.style.display = "";                                                     
                }
                if(document.all.busytype.value=="21"){
                        document.all.spinfo.disabled=false;
                        document.all.spinfo.style.display = "";                                                     
                }
                if(document.all.busytype.value=="01"||document.all.busytype.value=="02"){
                        document.all.style001.style.display = "";
                        document.all.value001[1].selected=true;
                }
                if(document.all.busytype.value=="88"){//BLACKBERRY
                    document.all.value001.value="";
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
                document.all.cmgp.style.display = "none";
              
                if(document.all.busytype.value=="78"){
               			 document.all.gddp.style.display="none";
                     document.all.spinfo.disabled=false;
                     document.all.spinfo.style.display =""; 
                     document.all.ConfirmPass.style.display="none";
                     document.all.modiPass.style.display="none";
                }
        }
        else if (i == "09") {//�޸�����
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
                document.all.cmgp.style.display = "none";
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
                document.all.cmgp.style.display = "none";
        }  
        else if (i == "89"){//SP�˶�
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
                document.all.spinfo1.colSpan = "3";
                document.all.spinfo3.style.display = "none";
                document.all.spbizinfo3.style.display = "none";
                document.all.cash.style.display = "none";
                document.all.cmgp.style.display = "none";
                if(i == "06" &&(document.all.busytype.value=="16"||document.all.busytype.value=="17"||document.all.busytype.value=="23")){
                        document.all.gddp.style.display="";
                }
                else{
                        document.all.gddp.style.display="none";
                }
                if(i == "21" && document.all.busytype.value=="28"){//��Ϸƽ̨��ֵ
                        document.all.cmgp.style.display = "";                   
                }
                /* wugl 20090617 ��ʱ��������ҵ��
                if(i=="11" && (biz=="04" || biz=="05")){
                        document.all.style005.style.display = "";
                }
                */
        }
        else if (i == "99"){//ȫҵ���˶�
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
                document.all.spinfo3.style.display = "none";
                document.all.spbizinfo3.style.display = "none";
                
                document.all.cash.style.display = "none";
                document.all.cmgp.style.display = "none";
                if(i == "06" &&(document.all.busytype.value=="16"||document.all.busytype.value=="17"||document.all.busytype.value=="23")){
                        document.all.gddp.style.display="";
                }
                else{
                        document.all.gddp.style.display="none";
                }
                if(i == "21" && document.all.busytype.value=="28"){//��Ϸƽ̨��ֵ
                        document.all.cmgp.style.display = "";                   
                }
                /* wugl 20090617 ��ʱ��������ҵ��
                if(i=="11" && (biz=="04" || biz=="05")){
                        document.all.style005.style.display = "";
                }
                */
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
                document.all.spinfo1.colSpan = "1";
                document.all.spinfo3.style.display = "";
                document.all.cash.style.display = "none";
                document.all.cmgp.style.display = "none";
                document.all.value001.value="";
                document.all.style001.style.display = "none";
                if(i == "06" &&(document.all.busytype.value=="16"||document.all.busytype.value=="17"||document.all.busytype.value=="23")){
                        document.all.gddp.style.display="";
                }
                else{
                        document.all.gddp.style.display="none";
                }
                if(i == "21" && document.all.busytype.value=="28"){//��Ϸƽ̨��ֵ
                        document.all.cmgp.style.display = "";                   
                }
                /* wugl 20090617 ��ʱ��������ҵ��
                if(i=="11" && (biz=="04" || biz=="05")){
                        document.all.style005.style.display = "";
                }
                if(i=="07" && (biz=="04" || biz=="05")){
                        document.all.style005.style.display = "";
                }
                if(i=="14" && (biz=="04" || biz=="05")){
                        document.all.style005.style.display = "";
                }
                if(i=="15" && (biz=="04" || biz=="05")){
                        document.all.style005.style.display = "";
                }
                */
        }
        //����������������ʼ�ղ���ʵ
        document.all.style298.style.display="none";
        document.all.style299.style.display="none";

}

function form_load()
{
	
        document.all.gddp.style.display="none";
        var busy_code=document.all.busytype.value;
        if(busy_code=="01"||busy_code=="02"){
                document.all.style001.style.display="";
                //document.form.value001[1].selected=true;
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
        
function getSpInfo(){
        var idNo=document.all.idNo.value;
    if(idNo.length<=0){
        rdShowMessageDialog("���Ȳ�ѯ�ֻ���Ϣ��",0);
        return false;
    }
    var optype=document.all.optype.value;
    if(optype.length<=0){
        rdShowMessageDialog("����ѡ�������ͣ�",0);
        return false;
    }
    var idFlag=idNo.substring(idNo.length-1,idNo.length);
    var phoneNo=document.all.phoneno.value;
    var busytype=document.all.busytype.value;
    var pageTitle = "SP��ҵ��Ϣ��ѯ";
        var fieldName = "sp��ҵ����|sp��ҵ����|sp��ҵӢ������|";
        var sqlStr ="select a.SPID,decode(a.SPNAME,null,a.spshortname,a.SPNAME) SPNAME,a.spenname from DDSMPSPINFO a,sOBSpType b where trim(a.spid) between b.beginspid and b.endspid and a.SPSTATUS='A' and a.BIZTYPE= :busytype and a.spid in (select distinct c.spid from DDSMPSPBIZINFO c where c.BIZSTATUS='A')";
        var varStr="busytype="+busytype;
        if(optype=="99" ||optype=="07"||optype=="02"){
                sqlStr ="select a.SPID,decode(a.SPNAME,null,a.spshortname,a.SPNAME) SPNAME,a.spenname from DDSMPSPINFO a,sOBSpType b where trim(a.spid) between b.beginspid and b.endspid and a.BIZTYPE= :busytype and a.spid in (select distinct c.spid from DDSMPORDERMSG"+idFlag+" c where c.phone_no=:phoneNo and c.opr_code<>'02' and c.opr_code<>'07' and c.opr_code<>'17')";
                varStr="busytype="+busytype+",phoneNo="+phoneNo;
        }
        if(optype=="04"){
                sqlStr ="select a.SPID,decode(a.SPNAME,null,a.spshortname,a.SPNAME) SPNAME,a.spenname from DDSMPSPINFO a,sOBSpType b where trim(a.spid) between b.beginspid and b.endspid and a.BIZTYPE= :busytype and a.spid in (select distinct c.spid from DDSMPORDERMSG"+idFlag+" c where c.phone_no=:phoneNo and c.opr_code<>'06' and c.opr_code<>'05' and c.opr_code<>'01')";
                varStr="busytype="+busytype+",phoneNo="+phoneNo;
        }
        if(optype=="05"){
                sqlStr ="select a.SPID,decode(a.SPNAME,null,a.spshortname,a.SPNAME) SPNAME,a.spenname from DDSMPSPINFO a,sOBSpType b where trim(a.spid) between b.beginspid and b.endspid and a.BIZTYPE= :busytype and a.spid in (select distinct c.spid from DDSMPORDERMSG"+idFlag+" c where c.phone_no=:phoneNo and c.opr_code<>'04')";
                varStr="busytype="+busytype+",phoneNo="+phoneNo;
        }
        var selType = "S";    //'S'��ѡ��'M'��ѡ
        var retQuence = "3|0|1|2|";
        var retToField = "spCode|";
        var serviceName="TlsPubSelCrm";
        var routerKey="userno";
        var routerValue=idNo;
        if(PubSimpSel_BD(pageTitle,fieldName,sqlStr,varStr,selType,retQuence,retToField,serviceName,routerKey,routerValue));
}

function getSpBizInfo(val){
    if(val.length<=0 ||val=="undefined"||val=="[object]"){
        rdShowMessageDialog("����ѡ����ҵ���룡",0);
        document.form.spCode.value="";
        document.form.spQuery.focus();
        return false;
    }
    var idNo=document.all.idNo.value;
    if(idNo.length<=0){
        rdShowMessageDialog("���Ȳ�ѯ�ֻ���Ϣ��",0);
        return false;
    }
    var optype=document.all.optype.value;
    if(optype.length<=0){
        rdShowMessageDialog("����ѡ�������ͣ�",0);
        return false;
    }
    var busytype=document.all.busytype.value;
    var idFlag=idNo.substring(idNo.length-1,idNo.length);
    var spCode=document.all.spCode.value;
    var phoneNo=document.all.phoneno.value;
    
    var pageTitle = "SPҵ����Ϣ��ѯ";
        var fieldName = "spҵ�����|spҵ������|ҵ������|";
        var sqlStr ="select b.bizcode,b.servname,b.BIZDESC from DDSMPSPINFO a,DDSMPSPBIZINFO b where  a.SPID=b.SPID and  b.BIZSTATUS='A' and a.SPID=:spid";
        var varStr="spid="+spCode;
        
        if(optype=="99" ||optype=="07"||optype=="02"){
                sqlStr ="select b.bizcode,b.servname,b.BIZDESC from DDSMPSPINFO a,DDSMPSPBIZINFO b where  a.SPID=b.SPID and a.SPID=:spid and b.bizcode in (select c.bizcode from DDSMPORDERMSG"+idFlag+" c where c.phone_no=:phoneNo and c.opr_code<>'02' and c.opr_code<>'07' and c.opr_code<>'17')";
                varStr="spid="+spCode+",phoneNo="+phoneNo;
        }
        if(optype=="04"){
                sqlStr ="select b.bizcode,b.servname,b.BIZDESC from DDSMPSPINFO a,DDSMPSPBIZINFO b where  a.SPID=b.SPID and a.SPID=:spid and b.bizcode in (select distinct c.bizcode from DDSMPORDERMSG"+idFlag+" c where c.phone_no=:phoneNo and c.opr_code<>'06' and c.opr_code<>'05' and c.opr_code<>'01')";
                varStr="spid="+spCode+",phoneNo="+phoneNo;
        }
        if(optype=="05"){
                sqlStr ="select b.bizcode,b.servname,b.BIZDESC from DDSMPSPINFO a,DDSMPSPBIZINFO b where  a.SPID=b.SPID and a.SPID=:spid and b.bizcode in (select distinct c.bizcode from DDSMPORDERMSG"+idFlag+" c where c.phone_no=:phoneNo and c.opr_code<>'04')";
                varStr="spid="+spCode+",phoneNo="+phoneNo;
        }
        var selType = "S";    //'S'��ѡ��'M'��ѡ
        var retQuence = "3|0|1|2|";
        var retToField = "spBizCode|";
        var serviceName="TlsPubSelCrm";
        var routerKey="userno";
        var routerValue=idNo;
        if(PubSimpSel_BD(pageTitle,fieldName,sqlStr,varStr,selType,retQuence,retToField,serviceName,routerKey,routerValue));
}

function spBizQry(){
        var busytype=document.all.busytype.value;
        var optype = document.all.optype.value;
        var spBizCode= document.all.spBizCode.value;
        var spCode= document.all.spCode.value;
        var phoneno= document.all.phoneno.value;
        var thirdNo= document.all.thirdNo.value;
        if(busytype=="00"){
                rdShowMessageDialog("��ѡ��ҵ�����ͣ�");
                return false;
        }
        if(optype==""){
                rdShowMessageDialog("��ѡ�������ͣ�");
                return false;
        }
        if(spCode==""){
                rdShowMessageDialog("��ѡ��SP���룡");
                return false;
        }
        var path1 ="../s9126/f9126_1.jsp?bizType="+busytype+"&optype="+optype+"&spCode="+spCode+"&spBizCode="+spBizCode+"&ifCall=true"+"&phoneno="+phoneno+"&thirdNo="+thirdNo;
        window.open(path1,"newwindow","height=450, width=790,top=50,left=200,scrollbars=yes, resizable=no,location=no, status=yes");

}

function spQry(){
	var busytype=document.all.busytype.value;
	var optype = document.all.optype.value;
	var spCode= document.all.spCode.value;
	var phoneno= document.all.phoneno.value;
	
	if(busytype=="00"){
			rdShowMessageDialog("��ѡ��ҵ�����ͣ�");
			return false;
	}
	
	if(optype==""){
			rdShowMessageDialog("��ѡ�������ͣ�");
			return false;
	}
	
	var path ="../s9125/f9125_2.jsp?bizType="+busytype+"&optype="+optype+"&spCode="+spCode+"&ifCall=true"+"&phoneno="+phoneno;
	window.open(path,"newwindow","height=450, width=790,top=50,left=200,scrollbars=yes, resizable=no,location=no, status=yes");     
}

function chgPhone(){
        document.all.accountpassword.value="";
        document.all.code201.value="";
        document.all.runname.value="";
        document.all.value201.value="";
        document.all.openinfo1.style.display="none";
        document.all.openinfo3.style.display="none";
        document.all.dyntb.style.display="none";
        document.all.optype.value="";
        document.all.spCode.value="";
        document.all.spBizCode.value="";
        document.all.NewPasswd.value="";
        document.all.ConfirmPasswd.value="";
        document.all.opnote.value="";
}

$(document).ready(function(){
	getUserInfo();
});


//-->
</script>

</HEAD>

<BODY>
        <FORM action="" method=post name=form id="frm1">
            <%@ include file="/npage/include/header.jsp"%>
        <div class="title">
        <div id="title_zi">�û���Ϣ����������</div>
    </div>
                <input type="hidden" name="busy_type"  value="1">
                <input type="hidden" name="custpassword"  value="">
                <input type="hidden" name="busy_name"  value="">
                <input type="hidden" name="busy_name"  value="">
                <input type="hidden" name="checkflag"  value="0">
                <input type="hidden" name="checkmsg"  value="">
                <input type="hidden" name="loginAccept" value="<%=loginAccept%>" /> 
<table cellSpacing="0"> 
                <tr> 
                	<td class=blue>�ֻ�����</td>
                  <td> 
                    <input type="text" name="phoneno" id="phoneno" 
                    	readonly value ="<%=activePhone%>" onchange="chgPhone()">
                    <input type="hidden" name="accountpassword"  maxlength="6" />
                  </td>
									<td class=blue>ҵ�����</td>
									<td> 
										<select name="busytype"  class="button"   onChange="changeBusyType()">
											<option value="00">��ѡ��ҵ�����</option>
											<wtc:qoption  name="sPubSelect"  routerKey="region"  routerValue="<%=regionCode%>"  outnum="2">
											  <wtc:sql>
											          select oprcode,oprname from sOBBizType where regtype='0' order by oprname asc
											  </wtc:sql>
											</wtc:qoption>
										</select>
									</td>
                </tr>
                <tr> 
                  <td class=blue><div >�û�����</div></td>
                  <td>
                    <input type="text"  readonly name="value201" value="">
                    <input type="hidden" class="button" readonly name="code201" value="201">
                  </td>
                  <td class=blue><div >����״̬</div></td>
                  <td>
                    <input type="text" readonly name="runname" value="">
                  </td>
                </tr> 
                <tr id="openinfo1"  style="display:none"> 
                        <th colspan="4" align="center">����ҵ�񿪹�״̬��Ϣ</th>
                        </tr>  
                        <tbody id="dyntb" align="center">
                        <tr id="openinfo3" style="display:none"> 
                          <td class=blue align="center" colspan=2><B>��������</B></td>
                          <td class=blue align="center" colspan=2><B>����״̬</B></td>
                        </tr>
                        <tr id="tr0" style="display:none"> 
                          <td colspan=2><div align="center"> 
                              <input type="text" align="left" id="R1" value="">
                            </div></td>
                          <td colspan=2><div align="center"> 
                              <input type="text" align="left" id="R2" value="">
                            </div></td>                           
                        </tr>                
                        </tbody>
                <tr> 
                  <td class=blue><div >��������</div></td>
                  <td colspan=3>
                      <select name="optype"  class="button"  onChange="changeOpType()">
                      	<option class="button" value="">��ѡ��������</option>                      
                      </select>
                  </td>
                </tr>
                <tr id="style005"  style="display:none"> 
                  <td class=blue>�����ֻ���</td>
                  <td colspan="3"> 
                    <input type="text" name="thirdNo" v_type="mobilephone" maxlength="11">
                  </td>
                </tr>  
                <tr id="spinfo"  style="display:none">
                  <td class=blue><div >SP��ҵ����</div></td>
                  <td id="spinfo1">
                    <input type="text" name="spCode" value="" maxlength="6">
                        <input type="button" class="b_text" name="spQuery" value="��ѯ" onclick="spQry()">
                  </td>
                  <td id="spbizinfo3" class=blue><div >SPҵ�����</div></td>
                  <td id="spinfo3">
                                                                                <input type="text" name="spBizCode" value="" maxlength="12">
                        <input type="button" class="b_text" name="spBipQuery" value="��ѯ" onclick="spBizQry()">
                  </td>
                </tr>
                <tr id="biz_passwd"> 
                  <td class=blue><div >ҵ������</div></td>
                  <td colspan=3><input type="password" maxlength="6" name="NewPasswd"></td>
                </tr>
                <tr id="ConfirmPass" > 
                  <td class=blue><div >����ȷ��</div></td>
                  <td colspan=3>
                    <input type="password"  maxlength="6" name="ConfirmPasswd">
                  </td>
                </tr>
                <tr id="modiPass"  style="display:none"> 
                  <td class=blue><div >��ҵ������</div></td>
                  <td colspan=3>
                    <input type="password"  maxlength="6" name="modiPasswd">
                  </td>
                </tr>
                <tr id ="style298"  style="display:none"> 
                  <td class=blue><div >��������</div></td>
                  <td colspan=3>
                    <input type="text"   name="value298">
                    <input type="hidden" class="button" readonly name="code298" value="298">
                  </td>
                </tr>
                <tr id ="style299"  style="display:none"> 
                  <td class=blue><div >�����</div></td>
                  <td colspan=3>
                    <input type="text"   name="value299">
                    <input type="hidden" class="button" readonly name="code299" value="299">
                  </td>
                </tr>
                <tr id="style002"  style="display:none"> 
                  <td class=blue><div >����ʹ�÷�ʽ</div></td>
                  <td colspan=3> 
                    <select name="value002">
                            <option value="" selected>��ѡ������ʹ�÷�ʽ</option>
                            <option value="1">ʹ������</option>
                            <option value="0">��ʹ������</option>
                    </select>
                    <input type="hidden" class="button" readonly name="code002" value="002">
                  </td>
                </tr> 
                        
                <tr id="style003"  style="display:none"> 
                  <td class=blue><div >�ײͱ��</div></td>
                  <td colspan=3> 
                    <select name="value003">
                      <option value="" selected>��ѡ���ײͱ��</option>
                      <option value="01">���ſͻ�ҵ��</option>
                      <option value="02">���ſͻ���չҵ��</option>
                    </select>
                    <input type="hidden" class="button" readonly name="code003" value="003">
                  </td> 
                </tr>
                <tr id="style004"  style="display:none"> 
                  <td class=blue><div >ͬ���߼�</div></td>
                  <td colspan=3> 
                    <select name="value004">
                      <option value="" selected>��ѡ��ͬ���߼�</option>
                      <option value="1">�Է�����Ϊ׼</option>
                      <option value="0">���ն�Ϊ׼</option>
                      <option value="2">�������</option>
                    </select>
                    <input type="hidden" class="button" readonly name="code004" value="004">
                  </td>
                </tr>
                <!--17201�������-->
                <tr id="style001"  style="display:none"> 
                  <td class=blue><div >���η�ʽ</div></td>
                  <td colspan=3> 
                    <select name="value001" >
                      <option value="10" selected>���ڹ�������Web��֤</option>
                      <option value="11" >���ڹ�����ͬ�Զ���֤</option>
                      <option value="12" >׷�ӹ����Զ���֤</option>
                    </select>
                    <input type="hidden" class="button" readonly name="code001" value="001">
                  </td>
                </tr>
                <!--ͨ���������-->
                <tr id="gddp"  style="display:none"> 
                  <td class=blue><div >�ײͰ���</div></td>
                  <td> 
                    <input type="text"  name="PackNumb" value="">
                  </td>
                  <td class=blue><div >��ֵҵ�����</div></td>
                  <td> 
                    <input type="text"  name="ServCode" value="">
                  </td>
                </tr>
                <!--PUSHMAIL���-->
                <tr id="psml"  style="display:none"> 
                  <td class=blue><div >PushMailҵ�����</div></td>
                  <td colspan=3> 
                    <select name="value300">
                      <option value="" selected>��ѡ��ҵ�����</option>
                      <option value="01">����ҵ��</option>
                      <option value="02">����ҵ��</option>
                    </select>
                    <input type="hidden" class="button" readonly name="code300" value="300">
                  </td>
                </tr>
                <!--�ֻ�Ǯ�����-->
                <tr id="cash"  style="display:none"> 
                  <td class=blue><div >�ʻ����</div></td>
                  <td> 
                    <select name="code301">
                      <option value="" selected>��ѡ���ʻ����</option>
                      <option value="001">�����ʻ�</option>
                      <option value="002">��ֵ�ʻ�</option>
                      <option value="003">�����ʻ�</option>
                    </select>
                  </td>
                  <td class=blue><div >�ʻ�����</div></td>
                  <td> 
                    <input type="text"  name="value301" value="">
                  </td>
                </tr>
                <!--��Ϸƽ̨���-->
                <tr id="cmgp"  style="display:none"> 
                  <td class=blue><div >��ֵ���</div></td>
                  <td colspan=3> <input type="text"  name="cmgp001" value="">
                  </td>
                </tr>
                <!--�������������-->
                <tbody id="cibp" style="display:none">
                <tr id="cibp01"> 
                  <td class=blue><div >������id</div></td>
                  <td> <input type="text"  name="value302" value="">
                       <input type="hidden" class="button" readonly name="code302" value="302">
                  </td>
                  <td class=blue><div >��������</div></td>
                  <td> <input type="text"  name="value304" value="">
                       <input type="hidden" class="button" readonly name="code304" value="304">
                  </td>
                </tr>
                <tr id="cibp02"> 
                  <td class=blue><div >����˺�</div></td>
                  <td> <input type="text"  name="value303" value="">                      
                  	   <input type="hidden" class="button" readonly name="code303" value="303">
                  </td>
                  <td class=blue><div >װ����ַ</div></td>
                  <td colspan=3> <input type="text"  name="value305" value="" size="60" maxlength="40" class="InputGrey">
                                 <input type="hidden" class="button" readonly name="code305" value="305">
                  </td>
                </tr>
                </tbody>
                <tr> 
                  <td class=blue><div >��ע</div></td>
                  <td colspan="3"> <input type="text"  name="opnote" value="" size="60" maxlength="40" class="InputGrey" readOnly>
                  </td>
                </tr>
              <tr> 
                <td align=center id="footer" colspan="4"> 
                  <input type="hidden" class="button" name="bizType" value="">
                  <input type="hidden" class="button" name="idNo" value="">
                  <input type="hidden" name="oprSource" value="08">
                  <input class="b_foot" name=sure type=button value=ȷ�� onclick="docheck()">
                                  &nbsp;
                  <input class="b_foot" name=clear type="reset" value=���  />
                                  &nbsp;
                  <input class="b_foot" name=reset type=reset value=�ر� onClick="removeCurrentTab()">
                  
                </td>
              </tr>
          </table>
      <%@include  file="/npage/include/footer.jsp"%>
</FORM>
</BODY>
</HTML>

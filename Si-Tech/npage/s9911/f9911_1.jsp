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
        	String opCode = "9911";
          String opName = "�ֻ�������������";
          
        String workNo = (String)session.getAttribute("workNo");
        String workName = (String)session.getAttribute("workName");
        String regionCode=(String)session.getAttribute("regCode");
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
        
        String accountType = (String)session.getAttribute("accountType");
        if(accountType==null) accountType = "1";
        System.out.println("------------------accountType-------------------"+accountType);
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

var js_pwFlag="false";
js_pwFlag="<%=pwrf%>";

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
                        getOperCode();
                }
                else{
                        rdShowMessageDialog("<br>�������:["+error_code+"]</br>������Ϣ:["+error_msg+"]",0);
                        return false;
                }
        }
        else if(verifyType=="opercode"){
                backArrMsg = packet.data.findValueByName("backArrMsg");
 
               
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
        if(form.busytype.value.length<=0 ||form.busytype.value=="00"){
                rdShowMessageDialog("��ѡ��ҵ�����!");
                return false;
        }
        if(form.phoneno.value.length<11 || isNumberString(form.phoneno.value,"1234567890")!=1) {
                rdShowMessageDialog("�������ֻ�����,����Ϊ11λ����!!");
                document.form.phoneno.focus();
                return false;
        }
        else if (!forMobil(form.phoneno)){
                
                document.form.phoneno.focus();
                return false;
        }
        else if(js_pwFlag=="false" && trim(form.accountpassword.value).length<6) {
                rdShowMessageDialog("������6λ�ǿ��û�����!!");
                document.form.accountpassword.focus();
                return false;
        }
        //������
        var accountpassword=document.form.accountpassword.value;
        if(js_pwFlag=="true"){
                accountpassword="";
        }
        var myPacket = new AJAXPacket("f9911_rpc_check.jsp","����ȷ�ϣ����Ժ�......");
        
        myPacket.data.add("verifyType","phoneno");
        myPacket.data.add("phoneno",document.form.phoneno.value);
        myPacket.data.add("passwd",accountpassword);
        core.ajax.sendPacket(myPacket);
        myPacket = null;                
}

function getOperCode()
{
        var myPacket = new AJAXPacket("f9911_oper_code.jsp","����ȷ�ϣ����Ժ�......");
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
        else if (parseInt(form.phoneno.value.substring(0,2),10)!=15 && parseInt(form.phoneno.value.substring(0,3),10)!=188 && parseInt(form.phoneno.value.substring(0,2),10)!=18 && (parseInt(form.phoneno.value.substring(0,3),10)<134 || parseInt(form.phoneno.value.substring(0,3),10)>139)){
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
         
       
 
        //else if((busy_code=="01"||busy_code=="02")&&form.optype.value=="01"){
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
        }
        //else if((busy_code=="01"||busy_code=="02")&&(form.optype.value=="02"||form.optype.value=="04")&&form.value001.value=="10"){
        else if((busy_code=="02")&&(form.optype.value=="02"||form.optype.value=="04")&&form.value001.value=="10"){
                rdShowMessageDialog("���ܵ���ȡ������ҵ��!");
                document.form.value001.focus();
                return false;
        }
        //else if((busy_code=="01"||busy_code=="02")&&(form.optype.value=="02"||form.optype.value=="04")&&form.value001.value=="12"){
        else if((busy_code=="02")&&(form.optype.value=="02"||form.optype.value=="04")&&form.value001.value=="12"){
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
        
        if(document.all.busytype.value=="Y2") document.all.busytypeHit.value = "YX20"; //���ݿ����ֶγ������2λ����������
				if(document.all.busytype.value=="Y5") document.all.busytypeHit.value = "YX5"; //���ݿ����ֶγ������2λ����������
				if(document.all.busytype.value=="16") document.all.busytypeHit.value = "YX"; //���ݿ����ֶγ������2λ����������
								
				if(document.all.optype.value=="23"){
					document.all.busytypeHit.value = "KT" + document.all.busytypeHit.value;
				}else if(document.all.optype.value=="24"){
					document.all.busytypeHit.value = "QX" + document.all.busytypeHit.value;
				}else if(document.all.optype.value=="25"){
					document.all.busytypeHit.value = "HFYX";
				}
				
        document.form.action="f9911_2.jsp";
        form.submit();
        document.form.sure.disabled = true;
        return true;
}

function showPrtDlg(printType,DlgMessage,submitCfm)
{  //��ʾ��ӡ�Ի��� 
   var h=198;
   var w=400;
   var t=screen.availHeight/2-h/2;
   var l=screen.availWidth/2-w/2;
   
   var printStr = printInfo(printType);
   
   var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no"; 
   var path = "<%=request.getContextPath()%>/npage/innet/hljPrint.jsp?DlgMsg=" + DlgMessage;
   var path = path + "&printInfo=" + printStr + "&submitCfm=" + submitCfm;
   var ret=window.showModalDialog(path,"",prop);
   return ret;    
}

function printInfo(printType)
{
        var retInfo = "";
        retInfo+=" "+"|";
        retInfo+=" "+"|";
        retInfo+=" "+"|";
        retInfo+=" "+"|";
        retInfo+=" "+"|";
        retInfo+=" "+"|";
        retInfo+=" "+"|";
        retInfo+=" "+"|";
        retInfo+=" "+"|";
        retInfo+=" "+"|";
        retInfo+=" "+"|";
        retInfo+=" "+"|";
        retInfo+=" "+"|";
        retInfo+=" "+"|";
        retInfo+=" "+"|";
        retInfo+=" "+"|";
        retInfo+=" "+"|";
        retInfo+=" "+"|";
        retInfo+=" "+"|";
        retInfo+='����Ա��<%=workNo%>'+' '+'<%=workName%>'+"        ";  
        retInfo+='����ʱ�䣺<%=new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss", Locale.getDefault()).format(new java.util.Date())%>'+"|";
        retInfo+="�û����룺"+document.all.phoneno.value+"|";
        retInfo+="�û�������"+document.all.value201.value+"|";
        retInfo+="ҵ�����ͣ�"+document.all.busytype.options[document.all.busytype.selectedIndex].text+"|";
        retInfo+="�������ͣ�"+document.all.optype.options[document.all.optype.selectedIndex].text+"|";
        retInfo+=" "+"|";
        retInfo+=" "+"|";
        retInfo+=" "+"|";
        retInfo+=" "+"|";
        return retInfo; 
}

function changeBusyType(){      
        document.all.phoneno.value="";
        document.all.accountpassword.value="";
        document.all.code201.value="";
        document.all.runname.value="";
        document.all.value201.value="";
        document.all.openinfo1.style.display="none";
        document.all.openinfo3.style.display="none";
        document.all.dyntb.style.display="none";
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

        document.all.iChnSourceTr.style.display = "none";
                
        
        var busy_code=document.all.busytype.value;
        if(busy_code=="01"||busy_code=="02"){
                document.all.style001.style.display="";
                document.form.value001[1].selected=true;
                document.all.spinfo.disabled=false;
                document.all.style298.style.display="none";
                document.all.style299.style.display="none";
        }
        else if(busy_code=="10"){
                document.form.value001[0].selected=true;
                document.all.psml.style.display="none";
                document.form.value001[0].selected=true;
                document.all.style002.style.display="";
                document.all.style003.style.display="";
                document.all.style004.style.display="";
        }
        else if(busy_code=="17"||busy_code=="23"){
                document.form.value001[0].selected=true;
                document.all.psml.style.display="none";
                document.all.style001.style.display="none";
                document.all.gddp.style.display="";
        }
        else if(busy_code=="15"){
                document.form.value001[0].selected=true;
                document.all.style001.style.display="none";
                document.all.psml.style.display="";
                document.all.style298.style.display="none";
                document.all.style299.style.display="none";
        }
        else if(busy_code=="21"){
                document.form.value001[0].selected=true;
                document.all.style001.style.display="none";
                document.all.cash.style.display="";
                document.all.style298.style.display="none";
                document.all.style299.style.display="none";
        }
        else if(busy_code=="16"||busy_code=="Y2"||busy_code=="Y5"){
        	      document.form.value001[0].selected=true;
                document.all.style001.style.display="none";
                document.all.style298.style.display="none";
                document.all.style299.style.display="none";
                
                document.all.iChnSourceTr.style.display = "";
                
        	
        }else{
                document.all.psml.style.display="none";
                document.all.gddp.style.display="none";
                document.all.style001.style.display="none";
                document.form.value001[0].selected=true;
                document.all.style298.style.display="none";
                document.all.style299.style.display="none";
        }
        document.all.openinfo1.style.display="none";
        document.all.openinfo3.style.display="none";
        document.all.dyntb.style.display="none";
        //����������������ʼ�ղ���ʵ
        document.all.style298.style.display="none";
        document.all.style299.style.display="none";
}

function changeOpType() {       
        var i = form.optype.value;
        var biz = form.busytype.value;
        document.form.opnote.value="";
        document.all.style005.style.display = "none";
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
                if(document.all.busytype.value=="01"||document.all.busytype.value=="02"){
                        document.all.style001.style.display = "";
                }
                
                document.all.modiPasswd.disabled=true;
                document.all.modiPasswd.value="";       
                document.all.modiPass.style.display="none";
                document.all.cmgp.style.display = "none";
                if(document.all.busytype.value=="16" ||document.all.busytype.value=="21"){
                        document.all.gddp.style.display="";
                }
    }
        else if (i == "02") {//ҵ��ȡ��
                document.all.value298.value="";
                document.all.value299.value="";
                document.all.value298.disabled=true;
                document.all.value299.disabled=true;
                document.all.style298.style.display = "none";
                document.all.style299.style.display = "none";
                document.all.modiPasswd.disabled=true;
                document.all.modiPasswd.value="";       
                document.all.modiPass.style.display="none";
                document.all.gddp.style.display="none";
                document.all.cash.style.display = "none";
                document.all.cmgp.style.display = "none";
                if(document.all.busytype.value=="16"){
                        document.all.gddp.style.display="";
                }
                if(document.all.busytype.value=="21"){
                }
                if(document.all.busytype.value=="01"||document.all.busytype.value=="02"){
                        document.all.style001.style.display = "";
                }
        }
        else if (i == "03") {//�޸�����
                document.all.modiPasswd.disabled=false;
                document.all.modiPasswd.value="";       
                document.all.modiPass.style.display="";
                document.all.value298.disabled=true;
                document.all.value299.disabled=true;
                document.all.value298.value="";
                document.all.value299.value="";
                document.all.style298.style.display = "none";
                document.all.style299.style.display = "none";
                document.all.value001.value="";
                document.all.style001.style.display = "none";
                document.all.cash.style.display = "none";
                document.all.cmgp.style.display = "none";
        }
        else if (i == "09") {//�޸�����
                document.all.modiPasswd.disabled=false;
                document.all.modiPasswd.value="";       
                document.all.modiPass.style.display="";
                document.all.value298.disabled=true;
                document.all.value299.disabled=true;
                document.all.value298.value="";
                document.all.value299.value="";
                document.all.style298.style.display = "none";
                document.all.style299.style.display = "none";
                document.all.value001.value="";
                document.all.style001.style.display = "none";
                document.all.cash.style.display = "none";
                document.all.cmgp.style.display = "none";
        }
        else if (i == "08") {//���ϱ��
                document.all.value298.value="";
                document.all.value299.value="";
                if(document.all.busytype.value=="16"){
                document.all.gddp.style.display="";
                
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
                document.all.cash.style.display = "none";
                document.all.cmgp.style.display = "none";
        }  
        else if (i == "89"){//SP�˶�
                document.all.value298.value="";
                document.all.value299.value="";
                document.all.value298.disabled=true;
                document.all.value299.disabled=true;
                document.all.style298.style.display = "none";
                document.all.style299.style.display = "none";
                document.all.modiPasswd.disabled=true;
                document.all.modiPasswd.value="";       
                document.all.modiPass.style.display="none";   
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
                document.all.value298.value="";
                document.all.value299.value="";
                document.all.value298.disabled=true;
                document.all.value299.disabled=true;
                document.all.style298.style.display = "none";
                document.all.style299.style.display = "none";
                document.all.modiPasswd.disabled=true;
                document.all.modiPasswd.value="";       
                document.all.modiPass.style.display="none";   
                
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
                document.all.value298.value="";
                document.all.value299.value="";
                document.all.value298.disabled=true;
                document.all.value299.disabled=true;
                document.all.style298.style.display = "none";
                document.all.style299.style.display = "none";
                document.all.modiPasswd.disabled=true;
                document.all.modiPasswd.value="";       
                document.all.modiPass.style.display="none";   
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
                document.form.value001[1].selected=true;
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
        }
        
}       
        
 

function chgPhone(){
        document.all.accountpassword.value="";
        document.all.code201.value="";
        document.all.runname.value="";
        document.all.value201.value="";
        document.all.openinfo1.style.display="none";
        document.all.openinfo3.style.display="none";
        document.all.dyntb.style.display="none";
        document.all.opnote.value="";
}

//-->
</script>

</HEAD>

<BODY>
        <FORM action="" method=post name=form>
            <%@ include file="/npage/include/header.jsp"%>
        <div class="title">
        <div id="title_zi">�û���Ϣ����������</div>
    </div>
                <input type="hidden" name="busy_type"  value="1">
                <input type="hidden" name="custpassword"  value="">
                <input type="hidden" name="busy_name"  value="">
                
 
                                	
<table cellSpacing="0"> 
	
                <tr> 
                                  <td class=blue>ҵ�����</td>
                  <td colspan=3> 
                  	
                  	<select name="busytype"     onChange="changeBusyType()">
                  	
                  	<%if(!accountType.equals("2")){%>
                  		<option value="16">�ֻ�������Ѱ�</option>
                  	<%}else{%>
                  		<option value="16">�ֻ�������Ѱ�</option>
		                  <option value="Y5">�ֻ�����5Ԫ��</option>
		                  <option value="Y2">�ֻ�����20Ԫ��</option>
                  	<%}%>
                  
                   
                  </select>
                </tr>
                  
                <tr> 
                  <td class=blue>�ֻ�����</td>
                  <td> 
                    <input type="text" name="phoneno" id="phoneno" maxlength="11" onKeyDown="if(event.keyCode==13)document.all.accountpassword.focus()" onKeyPress="return isKeyNumberdot(0)" onchange="chgPhone()">
                  </td>
                  <td class=blue><div >�û�����</div></td>
                  <td>
                    <input type="password" name="accountpassword"  maxlength="6" onKeyDown="if(event.keyCode==13)getUserInfo()">
                    <input class="b_text" type="button" name="query" value="��ѯ" onclick="getUserInfo()">
                  </td>
                </tr>                        
                <tr> 
                  <td class=blue><div >�û�����</div></td>
                  <td>
                    <input type="text"  readonly name="value201" value="">
                    <input type="hidden"  readonly name="code201" value="201">
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
                      <select name="optype"    onChange="changeOpType()">
                      	  <option  value="23" selected>��ͨ����</option>                      
                          <option  value="25">�ָ�����</option>                      
                          <option  value="24">ȡ������</option>                      
                      </select>
                  </td>
                </tr>
                
                <tr id="iChnSourceTr"  style="display:none">
                	<td class="blue">
                		������ʶ
                	</td>
                	
                	<td colspan="3">
                		<select id="iChnSource" name="iChnSource">
                			<option value="01">BOSS</option>
                			<option value="02">����Ӫҵ��</option>
                			<option value="03">����Ӫҵ��</option>
                			<option value="04">����Ӫҵ��</option>
                			<option value="05">��ý���ѯ��</option>
                			<option value="06">10086</option>

                		</select>
                	</td>
                	
                </tr>
                <tr id="style005"  style="display:none"> 
                  <td class=blue>�����ֻ���</td>
                  <td colspan="3"> 
                    <input type="text" name="thirdNo" v_type="mobilephone" maxlength="11">
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
                    <input type="hidden"  readonly name="code298" value="298">
                  </td>
                </tr>
                <tr id ="style299"  style="display:none"> 
                  <td class=blue><div >�����</div></td>
                  <td colspan=3>
                    <input type="text"   name="value299">
                    <input type="hidden"  readonly name="code299" value="299">
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
                    <input type="hidden"  readonly name="code002" value="002">
                  </td>
                </tr> 
                        
                <tr id="style003"  style="display:none"> 
                  <td class=blue><div >�ײͱ��</div></td>
                  <td colspan=3> 
                    <select name="value003">
                      <option value="" selected>��ѡ���ײͱ��</option>
                      <option value="01">01�ײ�</option>
                      <option value="02">02�ײ�</option>
                    </select>
                    <input type="hidden"  readonly name="code003" value="003">
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
                    <input type="hidden"  readonly name="code004" value="004">
                  </td>
                </tr>
                <!--17201�������-->
                <tr id="style001"  style="display:none"> 
                  <td class=blue><div >���η�ʽ</div></td>
                  <td colspan=3> 
                    <select name="value001">
                      <option value="" selected>��ѡ�����η�ʽ</option>
                      <option value="10">����������</option>
                      <option value="01">����������</option>
                      <option value="11">���ڹ�������</option>
                      <option value="12">׷�ӹ�������</option>
                    </select>
                    <input type="hidden"  readonly name="code001" value="001">
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
                    <input type="hidden"  readonly name="code300" value="300">
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
                <tr> 
                  <td class=blue><div >��ע</div></td>
                  <td colspan="3"> <input type="text"  name="opnote" value="" size="60" maxlength="40" class="InputGrey" readOnly>
                  </td>
                </tr>
              <tr> 
                <td align=center id="footer" colspan="4"> 
                  <input type="hidden"  name="bizType" value="">
                  <input type="hidden"  name="idNo" value="">
                  <input type="hidden"   name="busytypeHit"  id="busytypeHit" value="">
                  
                  <input type="hidden" name="oprSource" value="08">
                  <input class="b_foot" name=sure type=button value=ȷ�� onclick="docheck()">
                                  &nbsp;
                  <input class="b_foot" name=clear type=reset value=���>
                                  &nbsp;
                  <input class="b_foot" name=reset type=reset value=�ر� onClick="removeCurrentTab()">
                  
                </td>
              </tr>
          </table>
      <%@include  file="/npage/include/footer.jsp"%>
</FORM>
</BODY>
</HTML>

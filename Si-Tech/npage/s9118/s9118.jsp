
<%
/********************
 * version v2.0
 * ������: si-tech
 * update by qidp @ 2009-02-05
 ********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ include file="/npage/include/public_title_name.jsp"%>
<%@ page contentType="text/html;charset=GBK"%>
<%@ page import="com.sitech.boss.util.page.*"%>

<%
        String opCode = "9118";
        String opName = "����������ҵ������";
        String workNo = (String)session.getAttribute("workNo");
        String workName = (String)session.getAttribute("workName");
        String regionCode=(String)session.getAttribute("regCode");
    	String result[][] = null;
    	String newresult[][] = null;
    	
    	int iPageNumber = request.getParameter("pageNumber")==null?1:Integer.parseInt(request.getParameter("pageNumber"));
    	int iPageSize = 25;
    	int iStartPos = (iPageNumber-1)*iPageSize;
    	int iEndPos = iPageNumber*iPageSize;
    	
    	int recNum = 0;
    	int newrecNum = 0;
        /*yanpx@20100903Ϊ�ͷ� ����ӡ������ ��ʼ*/
        String accountType = (String)session.getAttribute("accountType"); //1 ΪӪҵ���� 2 Ϊ�ͷ�����
        /*����*/
        
        String op_name =  "����������ҵ������";
        
        ArrayList arr = (ArrayList)session.getAttribute("allArr");
        String[][] baseInfo = (String[][])arr.get(0);
        
        String loginNo = baseInfo[0][2];
       
        
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
        String sql = "select ds.spid,ds.bizcode,ds.biztype from ddsmpordermsg d,ddsmpspbizinfo ds where d.phone_no = '"+activePhone+"' and d.serv_code = '51' and d.opr_code in ('06','05','04','01') and d.spid = ds.spid and d.bizcode = ds.bizcode order by ds.bizcode";
%>
<wtc:sequence name="sPubSelect" key="sMaxSysAccept" id="loginAccept" />
<wtc:pubselect name="sPubSelect" routerKey="region"
	routerValue="<%=regionCode%>" outnum="3">
	<wtc:sql>
		<%=sql %>
	</wtc:sql>
</wtc:pubselect>
<wtc:array id="callData" scope="end" />
<%
	result = callData;
%>

<html xmlns="http://www.w3.org/1999/xhtml">
<HEAD>
<TITLE><%=op_name%></TITLE>

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
                        var idType=packet.data.findValueByName("idtype");
                        var iccid=packet.data.findValueByName("iccid");
                        document.all.value201.value=custname;
                        document.all.runname.value=runcode;
                        document.form.busy_type.value=document.form.busytype.value;
                        document.all.idNo.value=idNo;
                        document.all.idtype.value=idType;
                        document.all.iccid.value=iccid;
                        
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
                       	getRhCount();
                       	getYxCount();
                        getCibpInfo();
                }
                else{
                        rdShowMessageDialog("<br>�������:["+error_code+"]</br>������Ϣ:["+error_msg+"]",0);
                        return false;
                }
        }
        else if(verifyType=="cibpInfo"){
					backArrMsg = packet.data.findValueByName("backArrMsg");
					var despositAct = packet.data.findValueByName("despositAct");
					
					if(despositAct!=""){
						document.all.value313.value=despositAct;
					}
					
					var yximeicount = packet.data.findValueByName("yximeicount");
					document.all.yximeicount.value=yximeicount;
					
					
					
					for(var i=0; i<backArrMsg.length ; i++){
						if(backArrMsg[i][0]=="302"){
							 document.all.value302.value=backArrMsg[i][1];
						}
						else if(backArrMsg[i][0]=="303"){
							 document.all.value303.value=backArrMsg[i][1];
						}
						else if(backArrMsg[i][0]=="304"){
							 document.all.value304.value=backArrMsg[i][1];
						}
						else if(backArrMsg[i][0]=="305"){
							 document.all.value305.value=backArrMsg[i][1];
						}
						else if(backArrMsg[i][0]=="306"){
							 document.all.value306.value=backArrMsg[i][1];
						}
						else if(backArrMsg[i][0]=="311"){
							 document.all.value311.value=backArrMsg[i][1];
						}
						else if(backArrMsg[i][0]=="312"){
							 document.all.value312.value=backArrMsg[i][1];
						}
					}
					if(despositAct=="" && document.all.value311.value==""){//û��Ѻ����ˮ ��imeiΪ�� ����Ҫ��Ѻ��
							document.all.yajinflag.value='1';
					}else{
							document.all.yajinflag.value='0';
					}
        }
        else if(verifyType=="newspinfo"){
        	backArrMsg = packet.data.findValueByName("backArrMsg");
        	clearRow("newSpinfoTable",1);
        	clearRow("dgSpinfoTable",1);
        	for(var i=0;i<backArrMsg.length;i++){
            		var trTemp = document.getElementById("newSpinfoTable").insertRow();
    				trTemp.insertCell().innerHTML = backArrMsg[i][0];
    				trTemp.insertCell().innerHTML = backArrMsg[i][1];
    				trTemp.insertCell().innerHTML = backArrMsg[i][2];
    				if(backArrMsg[i][3]=="2"){
    					trTemp.insertCell().innerHTML = "����";
        			}
    				else if(backArrMsg[i][3]=="1"){
    					trTemp.insertCell().innerHTML = "����/�����Ʒ�";
        			}
    				trTemp.insertCell().innerHTML = "<input type='button' class='b_text' name='spCfm' value='����' onclick='dinggou("+document.getElementById("newSpinfoTable").rows.length+")'>";
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
				var msg = "";
				if(backArrMsg[i][0]=="08"){
					msg = "�����л���";
				}
				else if(backArrMsg[i][0]=="09"){
					msg = "���ձ��";
				}
				else msg = 	backArrMsg[i][1];
				document.form.optype.options[document.form.optype.options.length]=new Option(msg,backArrMsg[i][0]);
			}
				}
        else if(verifyType=="rhcount"){
					backArrMsg = packet.data.findValueByName("backArrMsg");
					document.all.rhcount.value=backArrMsg[0][0];
				}
        else if(verifyType=="yxcount"){
					backArrMsg = packet.data.findValueByName("backArrMsg");
					document.all.yxcount.value=backArrMsg[0][0];
				}
        else if(verifyType=="kdInfo"){

					
          if( parseInt(error_code,10) == 0 ){

						backArrMsg = packet.data.findValueByName("backArrMsg");
						document.all.value305.value=backArrMsg[0][2];
					}else{

							 rdShowMessageDialog("<br>�������:["+error_code+"]</br>������Ϣ:[����˺Ų�ѯʧ��"+error_msg+"]",0);
                        return false;
					}
				}else if(verifyType=="checkImei"){
					backArrMsg = packet.data.findValueByName("backArrMsg");
					var inputName = packet.data.findValueByName("inputName");
					
					if(backArrMsg.length>0){
						document.getElementById(inputName).value=backArrMsg[0][1];
					}else{

						if(document.all.optype.value=="08" && inputName=="value302"){
							
						}else{
							rdShowMessageDialog("������Ϣ:IMEI���ڿ���ǻ���ħ�ٺ��޷�����",0);
							 return false;
						}
						//document.getElementById(inputName).value="";
//						document.all.value302.value="";
                       
					}
				
        }
        
}
function deleteRow(msgId, obj) {
	var tableTemp = document.getElementById(msgId).children[0];
	tableTemp.deleteRow(obj.parentElement.parentElement.rowIndex);
}
function dinggou(index){
	var row = document.getElementById("newSpinfoTable").rows[index-1];
	var dgSpinfoTable = document.getElementById("dgSpinfoTable").rows;
	for (var i = 1; i < dgSpinfoTable.length; i++) {
		if(dgSpinfoTable[i].cells[1].innerHTML == row.cells[1].innerHTML)
		{
			rdShowMessageDialog("����["+row.cells[1].innerHTML+"]�Ѿ�����",0);
			return;
		}
	}
	var trTemp = document.getElementById("dgSpinfoTable").insertRow();
	 for(var j=0;j<row.cells.length-1;j++){  
         trTemp.insertCell().innerHTML = row.cells[j].innerHTML;
     } 
	trTemp.insertCell().innerHTML = "<input type='button' class='b_text' name='' id='' value='ɾ��' onclick='deleteRow(\"dgSpinfoTable\", this)'/>";
}
function clearRow(id,a){ 
	   var length= document.getElementById(id).rows.length; 
	   for( var i=a; i<length; i++ ) 
	   { 
		   document.getElementById(id).deleteRow(a);
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
function getRhCount()
{
        var myPacket = new AJAXPacket("f9118_rhcount.jsp","����ȷ�ϣ����Ժ�......");
        myPacket.data.add("verifyType","rhcount");
        myPacket.data.add("phoneno",document.form.phoneno.value);
        core.ajax.sendPacket(myPacket);
        myPacket = null;                
}
function getYxCount()
{
        var myPacket = new AJAXPacket("f9118_yxcount.jsp","����ȷ�ϣ����Ժ�......");
        myPacket.data.add("verifyType","yxcount");
        myPacket.data.add("phoneno",document.form.phoneno.value);
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
function getCibpInfo()
{
        var myPacket = new AJAXPacket("s9118_getCibpInfo.jsp","����ȷ�ϣ����Ժ�......");
        myPacket.data.add("verifyType","cibpInfo");
        myPacket.data.add("phoneno",document.form.phoneno.value);
        core.ajax.sendPacket(myPacket);
        myPacket = null;                
}
function getKdInfo(id)
{
		if(id!=""&&id!=null){
	        var myPacket = new AJAXPacket("s9118_getKdInfo.jsp","����ȷ�ϣ����Ժ�......");
	        myPacket.data.add("verifyType","kdInfo");
	        myPacket.data.add("netcode",id);
	        myPacket.data.add("loginNo",document.form.loginNo.value);
	        myPacket.data.add("phoneno",document.form.phoneno.value);
	        core.ajax.sendPacket(myPacket);
	        myPacket = null;
		}                
} 
function checkImei(id,name,type)
{

		//document.all.value302.value="12345678901234567890123456789"+id;
		if(id!=""&&id!=null){
	        var myPacket = new AJAXPacket("s9118_checkImei.jsp","����ȷ�ϣ����Ժ�......");
	        myPacket.data.add("verifyType","checkImei");
	        myPacket.data.add("imei",id);
	        myPacket.data.add("inputName",name);
	        myPacket.data.add("imeiType",type);
	        core.ajax.sendPacket(myPacket);
	        myPacket = null;
		}              
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

function docheck(printflag)
{

		var spidlist = "";
		var bizcodelist = "";
		var billingtypelist = "";

		var oldspidlist = "";
		var oldbizcodelist = "";
        if(form.phoneno.value.length<11 || isNumberString(form.phoneno.value,"1234567890")!=1) {
        rdShowMessageDialog("�������ֻ�����,����Ϊ11λ����!!");
        document.form.phoneno.focus();
        return false;
        }
        
        //else if (parseInt(form.phoneno.value.substring(0,2),10)!=15 && parseInt(form.phoneno.value.substring(0,3),10)!=188 && parseInt(form.phoneno.value.substring(0,3),10)!=147 && parseInt(form.phoneno.value.substring(0,2),10)!=18 && (parseInt(form.phoneno.value.substring(0,3),10)<134 || parseInt(form.phoneno.value.substring(0,3),10)>139)){
        //rdShowMessageDialog("������134-139,15��ͷ���ֻ����� !!");
        //document.form.phoneno.focus();
        //return false;
        //}
        if(document.all.runname.value.substring(1,2)!="A" &&document.all.runname.value.substring(1,2)!="K"){
                rdShowMessageDialog("�û�״̬������������������ҵ��!");
                return false;
        }
        if( form.optype.value==""||form.optype.value=="00") {
        rdShowMessageDialog("��ѡ��������!!");
        document.form.optype.focus();
        return false;
        }
        if(form.optype.value=="06"||form.optype.value=="07") {
	        if(form.spCode.value==""||form.spBizCode.value==""){
	       	 rdShowMessageDialog("��ѡ����ҵ���뼰ҵ�����!");
	            return false;
	        }
        }
		
        if(form.optype.value=="09") {
	        if(form.spCode.value==""){
	       	 rdShowMessageDialog("��ѡ����ҵ���벢����ҵ����Ϣ��ѡ�񶩹�");
	            return false;
	        }
        }
		
				if(form.optype.value=="06") {
					var stdIMEI = form.value311.value;
	        if(stdIMEI.length<=0) {
	            rdShowMessageDialog("IMEI����Ϊ��");
	            document.form.value311.focus();
	            return false;
	        }
      	}
        var stbId = form.value302.value;
        if(stbId.length!=32) {
            rdShowMessageDialog("������ID����Ϊ32λ������������IMEI��Ϣ");
            document.form.value302.focus();
            return false;
        }

		
        var kdzh = form.value303.value;
        if((kdzh==""||kdzh==null)&&form.optype.value!="07") {
            rdShowMessageDialog("���������˺�");
            document.form.value303.focus();
            return false;
        }
		
      //����ͨ 20160310�޸� ȥ���ж�
       // if(form.spCode.value == "699212"&&stbId.substr(12,1)!="2"){
        	//rdShowMessageDialog("������ID����,����ͨƷ�ƻ�����ID��ʮ��λ������Ϊ2");
           // document.form.value302.focus();
            //return false;
       // }
        //δ������
        //if(form.spCode.value == "699213"&&stbId.substr(12,1)!="3"){
        	//rdShowMessageDialog("������ID����,δ��Ʒ�ƻ�����ID��ʮ��λ������Ϊ3");
           // document.form.value302.focus();
           //return false;
        //}
         if(form.optype.value=="06" ||(form.optype.value=="08" && document.form.yajinflag.value =="1")) {
            if(form.value307.value==""){
	            rdShowMessageDialog("������Ѻ��(���0-200)");
	            document.form.value307.focus();
	            return false;
            }
            else if(isNaN(form.value307.value)){
            	rdShowMessageDialog("Ѻ����������ȷ������(���0-200)");
                document.form.value307.focus();
                return false;
            }
            else if(form.value307.value>200||form.value307.value<0){
            	rdShowMessageDialog("Ѻ����������ȷ������(���0-200)");
                document.form.value307.focus();
                return false;
             }
        }
        if(form.optype.value=="08") {
            if(form.value312.value==""){
	            rdShowMessageDialog("�����и���������д�»�����IMEI");
	            document.form.value312.focus();
	            return false;
            }
            else if(form.value306.value.length!=32){
            	rdShowMessageDialog("�»�����ID����32λ����������д�»�����IMEI");
                document.form.value312.focus();
                return false;
            }
        }
       	//
       	if(document.all.optype.value=="09"){
           	var flag = false;
	        var dgSpinfoTable = document.getElementById("dgSpinfoTable").rows;
	    	for (var i = 1; i < dgSpinfoTable.length; i++) {
		    	if(dgSpinfoTable[i].cells[1].innerHTML=="20830000"){
			    	flag = true;
			    }
	    		spidlist = spidlist + dgSpinfoTable[i].cells[0].innerHTML+";";
	    		bizcodelist = bizcodelist + dgSpinfoTable[i].cells[1].innerHTML+";";
	    		if(dgSpinfoTable[i].cells[3].innerHTML=="����"){
	    			billingtypelist = billingtypelist +"2"+";";
	    		}
	    		else{
	    			billingtypelist = billingtypelist +"1"+";";
	           }
	    	}
	    	var ShowId = document.getElementById("ShowId").rows;
	       	for (var i = 1; i < ShowId.length; i++) {
	       		oldspidlist = oldspidlist + ShowId[i].cells[0].innerHTML+";";
	       		oldbizcodelist = oldbizcodelist + ShowId[i].cells[1].innerHTML+";";
	       	}

	        if(flag==false) {
	            rdShowMessageDialog("���Ʒ�Ʊ�������Ʒ�ƻ�����");
	            return false;
	        }
	    	document.all.strspid.value = spidlist;
	        document.all.strbizcode.value = bizcodelist;
	        document.all.strbillingtype.value = billingtypelist;
	
	        document.all.stroldspid.value = oldspidlist;
	        document.all.stroldbizcode.value = oldbizcodelist;
       	}
		if(printflag==0){
	        print();
		}
      //��ӡ�������ύ��
      	else {
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
		    if(form.value307.value>0){
	          	 if(rdShowConfirmDialog('ȷ��Ҫ��ӡ�վ���')==1)
	             {
	             	print();
	             }
		    }
      	}
}

function frmCfm(){
		if(document.all.optype.value=="08"||document.all.optype.value=="09"){
        	document.form.action="s9118_cfm.jsp";
		}
		else document.form.action="s9118_cfm2.jsp";
        form.submit();
        document.form.sure.disabled = true;
        return true;
}
//���תΪ����
function toChnWord(n) {
    if (!/^(0|[1-9]\d*)(\.\d+)?$/.test(n))
         return "���ݷǷ�";
    var unit = "ǧ��ʰ��ǧ��ʰ��Ǫ��ʰԪ�Ƿ�", str = "";
         n += "00";
    var p = n.indexOf('.');
    if (p >= 0)
         n = n.substring(0, p) + n.substr(p+1, 2);
         unit = unit.substr(unit.length - n.length);
    for (var i=0; i < n.length; i++)
         str += '��Ҽ��������½��ƾ�'.charAt(n.charAt(i)) + unit.charAt(i);
    return str.replace(/��(Ǫ|��|ʰ|��)/g, "��").replace(/(��)+/g, "��").replace(/��(��|��|Ԫ)/g, "$1").replace(/(��)��|Ҽ(ʰ)/g, "$1$2").replace(/^Ԫ��?|���/g, "").replace(/Ԫ$/g, "Ԫ��");
}
//��Ʊ��ӡ����
function print(){
	if(document.all.optype.value!="06" && document.all.optype.value!="08"){
		rdShowMessageDialog('ֻ�з��񶩹�������Ҫ��ӡ�վ�!');
        return false;
    }
	var depositFee = form.value307.value;
	var depositFeeBig = toChnWord(depositFee);
	var phoneNo = form.phoneno.value;
	//var loginAccept = "<%=loginAccept%>";
	var loginAccept = document.all.value313.value;
	var custName = document.all.value201.value;
	var boxId = document.all.value302.value;
	var netCode = document.all.value303.value;
	var idtype = document.all.idtype.value;
	var iccid = document.all.iccid.value;
	
	var busiId = "";
	var h=210;
	var w=400;
	var t=screen.availHeight/2-h/2;
	var l=screen.availWidth/2-w/2;
	var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no"; 
	window.showModalDialog("<%=request.getContextPath()%>/npage/s9118/f4793_print.jsp?loginAccept=<%=loginAccept%>"
				+"&custName="+custName+"&smName=&phoneNo="+phoneNo+"&depositFee="+depositFee+"&depositFeeBig="+depositFeeBig+"&boxId="+boxId+"&netCode="+netCode+"&idtype="+idtype+"&iccid="+iccid
				,'ħ�ٺ�Ѻ���վݴ�ӡ�ɹ�',prop);
	window.close();
	rdShowMessageDialog('��ӡ�ɹ�!');
	
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
	var spname = "";
	
		
	cust_info+="�ͻ�������	"+document.all.value201.value+"|";
	cust_info+="�ֻ����룺	"+document.all.phoneno.value+"|";
	opr_info+="ҵ�����ͣ�"+document.all.busytype.options[document.all.busytype.selectedIndex].text+"|";
	opr_info+="�������ͣ�"+document.all.optype.options[document.all.optype.selectedIndex].text+"|";
	opr_info+="SP��ҵ���룺"+document.all.spCode.value+"|";
	opr_info+="SPҵ����룺"+document.all.spBizCode.value+"|";
	if(document.all.spCode.value=="699212"){
		spname = "����ͨ";
	}
	else if(document.all.spCode.value=="699213"){
		spname = "δ��";
	}
	opr_info+="��ע:����ҵ��:ħ�ٺ�-"+spname+"-����-10Ԫ"+"|";
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
        if((i=="09"||i=="07")&&(document.all.rhcount.value>0||document.all.yxcount.value>0)){
            var notice = "";
            if(document.all.rhcount.value>0){
            	notice = "�ں��ײ��û�";
            }
            if(document.all.yxcount.value>0){
            	notice = "�Ѱ����ض�Ӫ�������û�";
            }
            if(i=="09") rdShowMessageDialog(notice+"�����Ա������",0);
            else if(i=="07") rdShowMessageDialog(notice+"�������˶�",0);
          	form.optype.value = "";
          	 return false;
        }
       if(i=="08" && document.all.yximeicount.value>0){
       		rdShowMessageDialog("Ӫ��������ħ�ٺͲ����Ի����л���",0);
       		form.optype.value = "";
          return false;
       }
       if(i=="06" || (i=="08" && document.form.yajinflag.value =="1")){
    	   document.all.yajin.style.display = "";
       }
       else {
       		document.all.yajin.style.display = "none";
       }
       if(i=="06"||i=="07"||i=="09"){
    	   document.all.spinfo.style.display = "";
       }
       else document.all.spinfo.style.display = "none";
       if(i=="08"&&document.all.value302.value!=""){
    	   //document.all.value306.value="003903FF00210070";
    	   document.all.value311.readOnly=true;
    	  
        }else{
        	 document.all.value311.readOnly=false;
        }
      if(i=="09"){
	   	      document.all.dgSpinfoTable.style.display = "";
	   	      document.all.newSpinfoTable.style.display = "";
	   		  document.form.spBizCode.disabled = true;
	   		  document.form.spBipQuery.disabled = true;
	   		  document.form.value306.value = "";
      }
      else{
   	   document.all.dgSpinfoTable.style.display = "none";
   	   document.all.newSpinfoTable.style.display = "none";
   	   document.form.spBizCode.disabled = false;
  		document.form.spBipQuery.disabled = false;
      }
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
function spvalueChange(){
	if(document.all.optype.value=="06"||document.all.optype.value=="09"){
		if(document.all.spCode.value=="699212"){
			document.all.value302.value="003903FF00210070";
			}
		else if(document.all.spCode.value=="699213"){
			document.all.value302.value="003903FF00210070";
		}
	}
}
function spinfoChange(){
	//spvalueChange();
	if(document.all.spCode.value!=""){
		  var myPacket = new AJAXPacket("s9118_getNewSpInfo.jsp","����ȷ�ϣ����Ժ�......");
	        myPacket.data.add("verifyType","newspinfo");
	        myPacket.data.add("spid",document.all.spCode.value);
	        core.ajax.sendPacket(myPacket);
	        myPacket = null;
	}
}
$(document).ready(function(){
	getUserInfo();
});


//-->
</script>

</HEAD>

<BODY>
<FORM action="" method=post name=form id="frm1"><%@ include
	file="/npage/include/header.jsp"%>
<div class="title">
<div id="title_zi">����������ҵ������</div>
</div>
<input type="hidden" name="busy_type" value="1"> <input
	type="hidden" name="custpassword" value=""> <input
	type="hidden" name="busy_name" value=""> <input type="hidden"
	name="busy_name" value=""> <input type="hidden"
	name="checkflag" value="0"> <input type="hidden"
	name="checkmsg" value=""> <input type="hidden"
	name="loginAccept" value="<%=loginAccept%>" />
	<input type="hidden" name="rhcount" value="">
	<input type="hidden" name="yxcount" value="">
	<input type="hidden" name="yximeicount" value="">
	<input type="hidden" name="yajinflag" value="">
	
	<input type="hidden" name="dgflag" value="0">
		<input type="hidden" name="idtype" value="">
		<input type="hidden" name="iccid" value="">
		
		<input type="hidden" name="loginNo" id="loginNo" value="<%=loginNo%>">
	
<table cellSpacing="0">
	<tr>
		<td class=blue>�ֻ�����</td>
		<td><input type="text" name="phoneno" id="phoneno" readonly
			value="<%=activePhone%>" onchange="chgPhone()" size="40"> <input
			type="hidden" name="accountpassword" maxlength="6" /></td>
		<td class=blue>ҵ�����</td>
		<td><select name="busytype" class="button" style="width:250px">
			<option value="51">����������</option>
		</select></td>
	</tr>
	<tr>
		<td class=blue>
		<div>�û�����</div>
		</td>
		<td><input type="text" readonly name="value201" value="" size="40">
		<input type="hidden" class="button" readonly name="code201"
			value="201"></td>
		<td class=blue>
		<div>����״̬</div>
		</td>
		<td><input type="text" readonly name="runname" value="" size="40">
		</td>
	</tr>
	<tr id="openinfo1" style="display: none">
		<th colspan="4" align="center">����ҵ�񿪹�״̬��Ϣ</th>
	</tr>
	<tbody id="dyntb" align="center">
		<tr id="openinfo3" style="display: none">
			<td class=blue align="center" colspan=2><B>��������</B></td>
			<td class=blue align="center" colspan=2><B>����״̬</B></td>
		</tr>
		<tr id="tr0" style="display: none">
			<td colspan=2>
			<div align="center"><input type="text" align="left" id="R1"
				value=""></div>
			</td>
			<td colspan=2>
			<div align="center"><input type="text" align="left" id="R2"
				value=""></div>
			</td>
		</tr>
	</tbody>
	<tr>
		<td class=blue>
		<div>��������</div>
		</td>
		<td colspan=3><select name="optype" class="button" onChange="changeOpType()" style="width:250px">
			<option class="button" value="">��ѡ��������</option>
		</select></td>
	</tr>
	<tr id="spinfo"  style="display:none">
                  <td class=blue><div >SP��ҵ����</div></td>
                  <td id="spinfo1">
                  <!-- onpropertychange="spinfoChange()" -->
                    <input type="text" name="spCode" value="" maxlength="6"  onpropertychange="spinfoChange()" size="40">
                        <input type="button" class="b_text" name="spQuery" value="��ѯ" onclick="spQry()">
                  </td>
                  <td id="spbizinfo3" class=blue><div >SPҵ�����</div></td>
                  <td id="spinfo3">
                         <input type="text" name="spBizCode" value="" maxlength="12" size="40">
                        <input type="button" class="b_text" name="spBipQuery" value="��ѯ" onclick="spBizQry()">
                  </td>
     </tr>
	<tr id="style005" style="display: none">
		<td class=blue>�����ֻ���</td>
		<td colspan="3"><input type="text" name="thirdNo"
			v_type="mobilephone" maxlength="11"></td>
	</tr>
	<tr id="modiPass" style="display: none">
		<td class=blue>
		<div>��ҵ������</div>
		</td>
		<td colspan=3><input type="password" maxlength="6"
			name="modiPasswd"></td>
	</tr>
	<tr id="style298" style="display: none">
		<td class=blue>
		<div>��������</div>
		</td>
		<td colspan=3><input type="text" name="value298"> <input
			type="hidden" class="button" readonly name="code298" value="298">
		</td>
	</tr>
	<tr id="style299" style="display: none">
		<td class=blue>
		<div>�����</div>
		</td>
		<td colspan=3><input type="text" name="value299"> <input
			type="hidden" class="button" readonly name="code299" value="299">
		</td>
	</tr>
	<tr id="style002" style="display: none">
		<td class=blue>
		<div>����ʹ�÷�ʽ</div>
		</td>
		<td colspan=3><select name="value002">
			<option value="" selected>��ѡ������ʹ�÷�ʽ</option>
			<option value="1">ʹ������</option>
			<option value="0">��ʹ������</option>
		</select> <input type="hidden" class="button" readonly name="code002"
			value="002"></td>
	</tr>

	<tr id="style003" style="display: none">
		<td class=blue>
		<div>�ײͱ��</div>
		</td>
		<td colspan=3><select name="value003">
			<option value="" selected>��ѡ���ײͱ��</option>
			<option value="01">���ſͻ�ҵ��</option>
			<option value="02">���ſͻ���չҵ��</option>
		</select> <input type="hidden" class="button" readonly name="code003"
			value="003"></td>
	</tr>
	<tr id="style004" style="display: none">
		<td class=blue>
		<div>ͬ���߼�</div>
		</td>
		<td colspan=3><select name="value004">
			<option value="" selected>��ѡ��ͬ���߼�</option>
			<option value="1">�Է�����Ϊ׼</option>
			<option value="0">���ն�Ϊ׼</option>
			<option value="2">�������</option>
		</select> <input type="hidden" class="button" readonly name="code004"
			value="004"></td>
	</tr>
	<!--17201�������-->
	<tr id="style001" style="display: none">
		<td class=blue>
		<div>���η�ʽ</div>
		</td>
		<td colspan=3><select name="value001">
			<option value="10" selected>���ڹ�������Web��֤</option>
			<option value="11">���ڹ�����ͬ�Զ���֤</option>
			<option value="12">׷�ӹ����Զ���֤</option>
		</select> <input type="hidden" class="button" readonly name="code001"
			value="001"></td>
	</tr>
	<!--ͨ���������-->
	<tr id="gddp" style="display: none">
		<td class=blue>
		<div>�ײͰ���</div>
		</td>
		<td><input type="text" name="PackNumb" value=""></td>
		<td class=blue>
		<div>��ֵҵ�����</div>
		</td>
		<td><input type="text" name="ServCode" value=""></td>
	</tr>
	<!--PUSHMAIL���-->
	<tr id="psml" style="display: none">
		<td class=blue>
		<div>PushMailҵ�����</div>
		</td>
		<td colspan=3><select name="value300">
			<option value="" selected>��ѡ��ҵ�����</option>
			<option value="01">����ҵ��</option>
			<option value="02">����ҵ��</option>
		</select> <input type="hidden" class="button" readonly name="code300"
			value="300"></td>
	</tr>
	<!--�ֻ�Ǯ�����-->
	<tr id="cash" style="display: none">
		<td class=blue>
		<div>�ʻ����</div>
		</td>
		<td><select name="code301">
			<option value="" selected>��ѡ���ʻ����</option>
			<option value="001">�����ʻ�</option>
			<option value="002">��ֵ�ʻ�</option>
			<option value="003">�����ʻ�</option>
		</select></td>
		<td class=blue>
		<div>�ʻ�����</div>
		</td>
		<td><input type="text" name="value301" value=""></td>
	</tr>
	<!--��Ϸƽ̨���-->
	<tr id="cmgp" style="display: none">
		<td class=blue>
		<div>��ֵ���</div>
		</td>
		<td colspan=3><input type="text" name="cmgp001" value="">
		</td>
	</tr>
	<!--�������������-->
	<tbody id="cibp">
		<tr id="cibp01">
			<td class=blue>
			<div>������IMEI</div>
			</td>
			<td><input type="text" name="value311" value="" size="40" maxlength="32" onblur="checkImei(this.value,'value302','1')"> 
				<input type="hidden" class="button"  name="code311" value="311">
			</td>
			<td class=blue>
			<div>�»�����IMEI</div>
			</td>
			<td><input type="text" name="value312" value="" size="40" maxlength="32" onblur="checkImei(this.value,'value306','2')"> 
					<input type="hidden" class="button"  name="code312" value="312">
			</td>
		</tr>
		<tr id="cibp03">
			<td class=blue>
			<div>������ID</div>
			</td>
			<td>
				<input id="value302" type="text" name="value302" value="" size="40" maxlength="32" readonly="readonly"> 
				<input type="hidden" class="button"  name="code302" value="302">
			</td>
			<td class=blue>
			<div>�»�����ID</div>
			</td>
			<td>
					<input id="value306" type="text" name="value306" value="" size="40" maxlength="32" readonly="readonly"> 
					<input type="hidden" class="button"  name="code306" value="306">
			</td>
		</tr>
		<tr id="cibp02">
			<td class=blue>
			<div>����˺�</div>
			</td>
			<td><input type="text" name="value303" value="" size="40" maxlength="32" onblur="getKdInfo(this.value)"> 
				<input type="hidden" class="button"  name="code303" value="303">
				
			</td>
			<td class=blue>
			<div>��������</div>
			</td>
			<td><input type="text" name="value304" value="" size="40" maxlength="6" > <input
				type="hidden" class="button"  name="code304" value="304">
			</td>
		</tr>
		<tr id ="yajin" style="display:none">
			<td class=blue>
			<div>Ѻ��</div>
			</td>
			<td colspan="3">
			<input type="text" name="value307" value="" size="40" maxlength="6" >
			<input type="hidden" name="value313" value="<%=loginAccept%>">
			</td>
		</tr>
		<tr id="cibp02">
			<td class=blue>
			<div>װ����ַ</div>
			</td>
			<td  colspan="3"><input type="text" name="value305" value=""
				size="60" maxlength="40" class="InputGrey"> <input
				type="hidden" class="button" readonly name="code305" value="305">
			</td>
		</tr>
		
	</tbody>
</table>
<div class="title">
<div id="title_zi">�Ѱ���ҵ����Ϣ</div>
</div>
<table cellspacing="0" id="ShowId">
	<tr id="ShowTotalId">
		<th>
		<div align="center" width="25%">SP��ҵ����</div>
		</th>
		<th>
		<div align="center" width="25%">ҵ�����</div>
		</th>
		<th>
		<div align="center" width="25%">ҵ������</div>
		</th>
	</tr>
	<%
              	if(result!= null)
              	{
			    	recNum = result.length ;
				}
			 	if(recNum<1){%>
	<tr>
		<td colspan="12" align="center"><b><font class="orange">�޲�ѯ���</font></td>
	</tr>
	<%}else{%>
	<%
          		for(int i=0;i<recNum;i++){
                String tdClass = "";            
                if (i%2==0){
                     tdClass = "Grey";
                }
		  	  %>
	<tr onmouseout="this.style.backgroundColor=''"
		onmouseover="this.style.backgroundColor='#E8E8E8';;this.style.cursor='hand'">
		<td class="<%=tdClass%>">
		<%=result[i][0]%>
		</td>
		<td class="<%=tdClass%>">
		<%=result[i][1]%>
		</td>
		<td class="<%=tdClass%>">
		<%=result[i][2]%>
		</td>
	</tr>
	<%}}%>
</table>
<div class="title">
<div id="title_zi">��ҵ����Ϣ</div>
</div>
<table id="newSpinfoTable" cellSpacing="0" style="display: none">
	<!--<tr id="style05">
		<td class="blue" colspan=6><input type="text" name="spCode"
			value="" maxlength="6" onpropertychange="spinfoChange()"><input
			type="button" class="b_text" name="spQuery" value="��ѯ"
			onclick="spQry()"></td>
	</tr>
	--><tr id="ShowTotalId">
		<th>
		<div align="center">SP��ҵ����</div>
		</th>
		<th>
		<div align="center">ҵ�����</div>
		</th>
		<th>
		<div align="center">ҵ������</div>
		</th>
		<th>
		<div align="center">�Ʒ�����</div>
		</th>
		<th>
		<div align="center">����</div>
		</th>
	</tr>
</table>
<div class="title">
<div id="title_zi">�����б�</div>
</div>
<table id="dgSpinfoTable" cellSpacing="0" style="display: none">
	<tr id="ShowTotalId">
		<th>
		<div align="center">SP��ҵ����</div>
		</th>
		<th>
		<div align="center">ҵ�����</div>
		</th>
		<th>
		<div align="center">ҵ������</div>
		</th>
		<th>
		<div align="center">�Ʒ�����</div>
		</th>
		<th>
		<div align="center">����</div>
		</th>
	</tr>
</table>
<table cellspacing="0">
	<tr>
		<td align=center id="footer" colspan="4"><input type="hidden"
			class="button" name="bizType" value=""><input type="hidden"
			class="button" name="idNo" value=""><input type="hidden"
			name="oprSource" value="08"><input class="b_foot" name=sure
			type=button value=ȷ�� onclick="docheck()"> &nbsp; <input
			class="b_foot" name=reset type=reset value=�ر�
			onClick="removeCurrentTab()"> </td>
	</tr>
		<input type="hidden" class="button" name="strspid" value="">
        <input type="hidden" class="button" name="strbizcode" value="">
        <input type="hidden" class="button" name="strbillingtype" value="">
        <input type="hidden" class="button" name="stroldspid" value="">
        <input type="hidden" class="button" name="stroldbizcode" value="">
</table>
<%@include file="/npage/include/footer.jsp"%></FORM>
</BODY>
</HTML>

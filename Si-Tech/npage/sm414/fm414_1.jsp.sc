<%
/********************
 
 -->>���������ˡ�ʱ�䡢ģ��Ĺ���
 -------------------------����-----------�ξ�ΰ(hejwa)2016-10-10 10:45:20------------------
 ����ʡ��ħ�ٺ͵���������������
 
 
 -------------------------��̨��Ա��liyang--------------------------------------------
 
********************/
%>
              

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http//www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http//www.w3.org/1999/xhtml">
<%@ include file="/npage/include/public_title_name.jsp" %> 

<%
	String opCode    = WtcUtil.repNull(request.getParameter("opCode"));
  String opName    = WtcUtil.repNull(request.getParameter("opName"));
  
  String workNo     = (String)session.getAttribute("workNo");
  String password   = (String)session.getAttribute("password");
  String regionCode = (String)session.getAttribute("regCode");
  
	String currentDate = new java.text.SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date());
%> 
<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="region" routerValue="<%=regionCode%>"  id="loginAccept" /> 
<%	
	String custName = "";
	String pp_name  = "";
	String vIdType  = "";
	String id_iccid = "";
	String vIdTypeName  = "";
	
	/*
          ��ѯ�ͻ���Ϣ��������
  */
   String paraAray[] = new String[9];
   paraAray[0]=loginAccept;
   paraAray[1]="01";
   paraAray[2]=opCode;
   paraAray[3]=workNo;
   paraAray[4]=password;
   paraAray[5]=activePhone;
   paraAray[6]="";
   paraAray[7]="";
   paraAray[8]="ͨ��phoneNo[" + activePhone + "]��ѯ�ͻ���Ϣ";
%>


	
<wtc:service name="sUserCustInfo" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode2" retmsg="retMsg2" outnum="40" >
      <wtc:param value="<%=paraAray[0]%>"/>
      <wtc:param value="<%=paraAray[1]%>"/>
      <wtc:param value="<%=paraAray[2]%>"/>
      <wtc:param value="<%=paraAray[3]%>"/>
      <wtc:param value="<%=paraAray[4]%>"/>
      <wtc:param value="<%=paraAray[5]%>"/>
      <wtc:param value="<%=paraAray[6]%>"/>
      <wtc:param value="<%=paraAray[7]%>"/>
      <wtc:param value="<%=paraAray[8]%>"/>
      <wtc:param value=""/>
      <wtc:param value=""/>
      <wtc:param value=""/>
      <wtc:param value=""/>
  </wtc:service>
<wtc:array id="result_t2" scope="end" />

<%

String custBrandName = "";
        if("000000".equals(retCode2)){
                if(result_t2.length>0){
                        custName = result_t2[0][5];
                        pp_name  = result_t2[0][38];
                        vIdType  = result_t2[0][12];
                        id_iccid = result_t2[0][13];
                        
                  if (pp_name.equals("gn")) {
										custBrandName = "ȫ��ͨ";
									} else if (pp_name.equals("zn")) {
										custBrandName = "������";
									} else if (pp_name.equals("dn")) {
										custBrandName = "���еش�";
									} 
									
									
									
									if("0".equals(vIdType)) {
										vIdTypeName="���֤";
								  }else if("1".equals(vIdType)) {
								  	vIdTypeName="����֤";
								 	}else if("2".equals(vIdType)) {
								 		vIdTypeName="����֤";
								 	}else if("3".equals(vIdType)) {
								 		vIdTypeName="�۰�ͨ��֤";
								 	}else if("4".equals(vIdType)) {
								 		vIdTypeName="����֤";
								 	}else if("5".equals(vIdType)) {
								 		vIdTypeName="̨��ͨ��֤";
								 	}else if("6".equals(vIdType)) {
								 		vIdTypeName="���������";
								 	}else if("7".equals(vIdType)) {
								 		vIdTypeName="����";
								 	}else if("8".equals(vIdType)) {
								 		vIdTypeName="Ӫҵִ��";
								 	}else if("9".equals(vIdType)) {
								 		vIdTypeName="����";
								 	}else if("A".equals(vIdType)) {
								 		vIdTypeName="��֯��������";
								 	}else if("B".equals(vIdType)) {
								 		vIdTypeName="��λ����֤��";
								 	}else if("C".equals(vIdType)) {
								 		vIdTypeName="��λ֤��";
								 	}else if("00".equals(vIdType)) {
								 		vIdTypeName="���֤";
								 	}    
									
									
									
									
                }
        }else{
%>
                <script language="JavaScript">
                        rdShowMessageDialog("���û����������û���״̬��������");
                        removeCurrentTab();
                </script>
<%              
        }
%>   	
<%@ page contentType="text/html;charset=GBK"%>
<HTML><HEAD><TITLE><%=opName%></TITLE>
<SCRIPT language=JavaScript>



//����ˢ��ҳ��
function reSetThis(){
	  location = location;	
}



/*-------------------------------------------m414-----------------��ʼ------------------------------*/

var public_opCode = "";

function sm414_go_getAddr(bt){
		if($(bt).val().trim()=="") return;
		
	  var packet = new AJAXPacket("fm414_GetCfmLoginAddr.jsp","���Ժ�...");
        packet.data.add("cfm_login",$(bt).val().trim());//
    core.ajax.sendPacket(packet,sm414_do_getAddr);
    packet =null;		
}
function sm414_do_getAddr(packet){
    var error_code = packet.data.findValueByName("code");//���ش���
    var error_msg =  packet.data.findValueByName("msg");//������Ϣ

    if(error_code!="000000"){//���÷���ʧ��
      rdShowMessageDialog(error_code+":"+error_msg);
	    return;
    }else{//�����ɹ�
    	var retArray =  packet.data.findValueByName("retArray");
    	if(retArray.length==0){
    		rdShowMessageDialog("����Ŀ���˺Ų���ȷ");
    		$("#sm414_BroadbandAccount").val("");
    		$("#sm414_InstalledAddr").val("");
    	}else{
    		$("#sm414_InstalledAddr").val(retArray[0][0]);
    	}
    }
}



//�ύ����
function sm414_go_Cfm(){
 		
		if(!checkElement(document.msgFORM.sm414_imei_no)) return;
		if(!checkElement(document.msgFORM.sm414_deposit)) return;
		if(!checkElement(document.msgFORM.sm414_BroadbandAccount)) return;
		if(!checkElement(document.msgFORM.sm414_InstalledAddr)) return;
		
		
		if(parseInt(document.msgFORM.sm414_deposit.value.trim())<0||parseInt(document.msgFORM.sm414_deposit.value.trim())>200){
			document.msgFORM.sm414_deposit.value = "";
			rdShowMessageDialog("Ѻ����0-200Ԫ֮�䣬����������");
			return;
		}
 
		
		var ret = sm414_showPrtDlg("Detail","ȷʵҪ���е��������ӡ��","Yes"); 
		
		sm414_show_Bill_Prt();
		
		if(rdShowConfirmDialog("ȷ��Ҫ�ύ��Ϣ��")!=1) return;
		
		
    var packet = new AJAXPacket("fm414_Cfm.jsp","���Ժ�...");
        packet.data.add("opCode",public_opCode);//
        packet.data.add("phoneNo","<%=activePhone%>");//
        packet.data.add("iImeiCode",$("#sm414_imei_no").val());//
        packet.data.add("iCfmLogin",$("#sm414_BroadbandAccount").val());//
        packet.data.add("iAddress",$("#sm414_InstalledAddr").val());//
        packet.data.add("iDepositFee",$("#sm414_deposit").val());//
        packet.data.add("loginAccept","<%=loginAccept%>");//
        
        
    core.ajax.sendPacket(packet,sm414_do_Cfm);
    packet =null;		
}
function sm414_do_Cfm(packet){
    var error_code = packet.data.findValueByName("code");//���ش���
    var error_msg =  packet.data.findValueByName("msg");//������Ϣ

    if(error_code!="000000"){//���÷���ʧ��
      rdShowMessageDialog(error_code+":"+error_msg);
	    return;
    }else{//�����ɹ�
	    rdShowMessageDialog("�����ɹ�",2);
    	reSetThis();
    }
}



function sm414_showPrtDlg(printType,DlgMessage,submitCfm){  //��ʾ��ӡ�Ի��� 
	  var h=180;
	  var w=350;
	  var t=screen.availHeight/2-h/2;
	  var l=screen.availWidth/2-w/2;		   	   
	  var pType="subprint";             				 	//��ӡ���ͣ�print ��ӡ subprint �ϲ���ӡ
	  var billType="1";              				 			  //Ʊ�����ͣ�1���������2��Ʊ��3�վ�
	  var sysAccept ="<%=loginAccept%>";             	//��ˮ��
	    var printStr = sm414_printInfo(printType);
	  
		                      //����printinfo()���صĴ�ӡ����
	  var mode_code=null;           							  //�ʷѴ���
	  var fav_code=null;                				 		//�ط�����
	  var area_code=null;             				 		  //С������
	  var opCode=public_opCode ;                   			 	//��������
	  var phoneNo="<%=activePhone%>";                  //�ͻ��绰
	  
	  var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no";
	  var path = "<%=request.getContextPath()%>/npage/innet/hljBillPrint_jc_hw.jsp?DlgMsg=" + DlgMessage;
	  path+="&mode_code="+mode_code+
	  	"&fav_code="+fav_code+"&area_code="+area_code+
	  	"&opCode="+public_opCode+"&sysAccept="+sysAccept+
	  	"&phoneNo="+phoneNo+
	  	"&submitCfm="+submitCfm+"&pType="+
	  	pType+"&billType="+billType+ "&printInfo=" + printStr;
	  var ret=window.showModalDialog(path,printStr,prop);
	  return ret;
}				
//��ӡģ��idΪ��122
function sm414_printInfo(printType){
	  var cust_info="";
	  var opr_info="";
	  var note_info1="";
	  var note_info2="";
	  var note_info3="";
	  var note_info4="";
	  var retInfo = "";
	  
	  cust_info+="�ֻ����룺   "+"<%=activePhone%>"+"|";
	  cust_info+="�ͻ�������   "+"<%=custName%>"+"|";
	  
	  
	  opr_info += "ҵ�����ͣ�����������|";
	  opr_info += "������ˮ: "+"<%=loginAccept%>" +"|";
	  opr_info += "�������ͣ����񶩹�|";
	  
		note_info1 += "��ע��"+"����ҵ��ħ�ٺ�-δ��-������-10Ԫ|";
		
	  retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
	  retInfo=retInfo.replace(new RegExp("#","gm"),"%23");
	  return retInfo;
}


//��ӡ��Ʊ

function sm414_show_Bill_Prt(){
	 		
			var  billArgsObj = new Object();
			$(billArgsObj).attr("10001","<%=workNo%>");     //����
			$(billArgsObj).attr("10002","<%=new java.text.SimpleDateFormat("yyyy",Locale.getDefault()).format(new java.util.Date())%>");
			$(billArgsObj).attr("10003","<%=new java.text.SimpleDateFormat("MM",Locale.getDefault()).format(new java.util.Date())%>");
			$(billArgsObj).attr("10004","<%=new java.text.SimpleDateFormat("dd",Locale.getDefault()).format(new java.util.Date())%>");
			$(billArgsObj).attr("10005","<%=custName%>");   //�ͻ�����
			$(billArgsObj).attr("10006","ħ�ٺ�Ѻ��");    //ҵ�����
			
			$(billArgsObj).attr("10008","<%=activePhone%>");    //�û�����
			$(billArgsObj).attr("10015", $("#sm414_deposit").val());   //���η�Ʊ���
			$(billArgsObj).attr("10016", $("#sm414_deposit").val());   //��д���ϼ�
			$(billArgsObj).attr("10017","*");        //���νɷѣ��ֽ�
			/*10028 10029 ����ӡ*/
		  $(billArgsObj).attr("10028","");   //�����Ӫ������ƣ�
			$(billArgsObj).attr("10029","");	 //Ӫ������	
			$(billArgsObj).attr("10030","<%=loginAccept%>");   //��ˮ�ţ�--ҵ����ˮ
			$(billArgsObj).attr("10036",public_opCode);   //��������
			/**/

			
			/*�ͺŲ���*/
			$(billArgsObj).attr("10061","");	       //�ͺ�
			$(billArgsObj).attr("10062","");	//˰��
			$(billArgsObj).attr("10063","");	//˰��	   
	    $(billArgsObj).attr("10071","6");	//
	 		$(billArgsObj).attr("10076", $("#sm414_deposit").val());
 			
 			$(billArgsObj).attr("10083", "<%=vIdTypeName%>"); //֤������
 			$(billArgsObj).attr("10084", "<%=id_iccid%>"); //֤������
 			$(billArgsObj).attr("10086", "�𾴵Ŀͻ�����������ҵ���˶���ȡ������ֹҵ��ʹ�õĲ���ʱ����Я�����վݡ���Ч���֤��������ҵ��ʱ����ħ�ٺ��ն˵��ƶ�ָ������Ӫҵ������Ѻ���˻�������"); //��ע
 			$(billArgsObj).attr("10065", $("#sm414_BroadbandAccount").val()); //����˺�
 			$(billArgsObj).attr("10087", $("#sm414_imei_no").val()); //imei����
 			 

			$(billArgsObj).attr("10041", "ħ�ٺ��ն�Ѻ�����");           //Ʒ�����
			$(billArgsObj).attr("10042","̨");                   //��λ
			$(billArgsObj).attr("10043","1");	                   //����
			$(billArgsObj).attr("10044",$("#sm414_deposit").val());	                //����
			
			 			
 			$(billArgsObj).attr("10085", "zsj"); //���������ȡ��ʽ ֻ������ӡ�վݵĿ�
 			$(billArgsObj).attr("10072","1"); //1--������Ʊ  2--�����෢Ʊ  2--�˷��෢Ʊ

 			$(billArgsObj).attr("10088",public_opCode); //�վ�ģ��
 			
 			
			var h=210;
			var w=400;
			var t=screen.availHeight/2-h/2;
			var l=screen.availWidth/2-w/2;
			var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no" 
			var path = "/npage/public/pubBillPrintCfm_YGZ.jsp?dlgMsg=" + "ȷʵҪ���з�Ʊ��ӡ��";
			var loginAccept = "<%=loginAccept%>";
			var path = path +"&loginAccept="+loginAccept+"&opCode="+public_opCode+"&submitCfm=submitCfm";
			var ret = window.showModalDialog(path,billArgsObj,prop);		

} 



/*-------------------------------------------m414-----------------����------------------------------*/




/*-------------------------------------------m415-----------------��ʼ------------------------------*/



function sm415_go_Cfm(){
		var iImeiCode  = "";
		var iOldAccept = "";
		
		
		var radioObj = $("#sm415_chg_imei_tab input[type='radio']:checked");
		if(radioObj.html()!=null){
			iImeiCode = radioObj.parent().parent().find("td:eq(1)").text().trim();
			iOldAccept = radioObj.parent().parent().find("td:eq(2)").text().trim();
		}
		
		//alert("iImeiCode=["+iImeiCode+"]"+"\n"+"iOldAccept=["+iOldAccept+"]");
		
		if(iImeiCode==""||iOldAccept==""){
			rdShowMessageDialog("��ѡ��Ҫ�˶��ļ�¼");
			treurn;
		}
		
		var ret = sm415_showPrtDlg("Detail","ȷʵҪ���е��������ӡ��","Yes"); 
		
		if(rdShowConfirmDialog("ȷ��Ҫ�ύ��Ϣ��")!=1) return;
		
		
		
				
    var packet = new AJAXPacket("fm415_Cfm.jsp","���Ժ�...");
        packet.data.add("opCode",public_opCode);//
        packet.data.add("phoneNo","<%=activePhone%>");//
        packet.data.add("iImeiCode",iImeiCode);//
        packet.data.add("iOldAccept",iOldAccept);//
        packet.data.add("loginAccept","<%=loginAccept%>");//
    core.ajax.sendPacket(packet,sm415_do_Cfm);
    packet =null;		
}
function sm415_do_Cfm(packet){
    var error_code = packet.data.findValueByName("code");//���ش���
    var error_msg =  packet.data.findValueByName("msg");//������Ϣ

    if(error_code!="000000"){//���÷���ʧ��
      rdShowMessageDialog(error_code+":"+error_msg,0);
	    return;
    }else{//�����ɹ�
	    rdShowMessageDialog("�����ɹ�",2);
    	reSetThis();
    }
}






function sm415_showPrtDlg(printType,DlgMessage,submitCfm){  //��ʾ��ӡ�Ի��� 
	  var h=180;
	  var w=350;
	  var t=screen.availHeight/2-h/2;
	  var l=screen.availWidth/2-w/2;		   	   
	  var pType="subprint";             				 	//��ӡ���ͣ�print ��ӡ subprint �ϲ���ӡ
	  var billType="1";              				 			  //Ʊ�����ͣ�1���������2��Ʊ��3�վ�
	  var sysAccept =<%=loginAccept%>;             	//��ˮ��
	  
	  var printStr = "";
	  printStr = sm415_printInfo();
	  
		                      //����printinfo()���صĴ�ӡ����
	  var mode_code=null;           							  //�ʷѴ���
	  var fav_code=null;                				 		//�ط�����
	  var area_code=null;             				 		  //С������
	  var opCode=public_opCode;                   			 	//��������
	  var phoneNo="<%=activePhone%>";                  //�ͻ��绰
	  
	  var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no";
	  var path = "<%=request.getContextPath()%>/npage/innet/hljBillPrint_jc_hw.jsp?DlgMsg=" + DlgMessage;
	  path+="&mode_code="+mode_code+
	  	"&fav_code="+fav_code+"&area_code="+area_code+
	  	"&opCode="+public_opCode+"&sysAccept="+sysAccept+
	  	"&phoneNo="+phoneNo+
	  	"&submitCfm="+submitCfm+"&pType="+
	  	pType+"&billType="+billType+ "&printInfo=" + printStr;
	  var ret=window.showModalDialog(path,printStr,prop);
	  return ret;
}				

//��ӡģ��idΪ��122  
function sm415_printInfo(){
	  var cust_info="";
	  var opr_info="";
	  var note_info1="";
	  var note_info2="";
	  var note_info3="";
	  var note_info4="";
	  var retInfo = "";
	  
	  cust_info+="�ֻ����룺   "+"<%=activePhone%>"+"|";
	  cust_info+="�ͻ�������   "+"<%=custName%>"+"|";
	  
  
	  opr_info += "ҵ�����ͣ�����������" + "|";
	  opr_info += "������ˮ: "+"<%=loginAccept%>" +"|";
	  opr_info += "�������ͣ������˶�|";
	  
	  note_info1 += "��ע��"+"�˶�ҵ��ħ�ٺ�-δ��-������-10Ԫ|";
	  
	  retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
	  retInfo=retInfo.replace(new RegExp("#","gm"),"%23");
	  return retInfo;
}


//��ȡ���е�imei�б�
function sm415_go_getIMEI_list(){
	  var packet = new AJAXPacket("fm415_getImeiList.jsp","���Ժ�...");
        packet.data.add("opCode",public_opCode);//
        packet.data.add("phoneNo","<%=activePhone%>");//
    core.ajax.sendPacket(packet,sm415_do_getImeiList);
    packet =null;
}

// �ص�
function sm415_do_getImeiList(packet){
	var code = packet.data.findValueByName("code"); //���ش���
	var msg = packet.data.findValueByName("msg"); //������Ϣ
	if(code=="000000"){//��ѯ�ɹ���̬չʾ�б�
			var retArray = packet.data.findValueByName("retArray");
			//��ȡ����ɹ�����̬ƴ���б�
			var trObjdStr = "";
			for(var i=0;i<retArray.length;i++){
						trObjdStr += "<tr>"+
														 "<td><input type='radio' name='imei_chg_dio'   /></td>"+ //
														 "<td>"+retArray[i][0]+"</td>"+ //
														 "<td>"+retArray[i][1]+"</td>"+ //
														 "<td>"+retArray[i][2]+"</td>"+ //
														 "<td>"+retArray[i][3]+"</td>"+//
												 "</tr>";
			}
			if("m415"==public_opCode){
				$("#sm415_chg_imei_tab tr:gt(0)").remove();
				$("#sm415_chg_imei_tab tr:eq(0)").after(trObjdStr);
			}else{
				$("#sm416_chg_imei_tab tr:gt(0)").remove();
				$("#sm416_chg_imei_tab tr:eq(0)").after(trObjdStr);
			}
			
	}else{
		  rdShowMessageDialog("��ѯʧ�ܣ�"+code+"��"+msg,0);
	}
}


/*-------------------------------------------m415-----------------����------------------------------*/





/*-------------------------------------------m416-----------------��ʼ------------------------------*/


function sm416_go_Cfm(){
		var iOldImeiCode  = "";
		var iOldAccept    = "";
		
		
		var radioObj = $("#sm416_chg_imei_tab input[type='radio']:checked");
		if(radioObj.html()!=null){
			iOldImeiCode = radioObj.parent().parent().find("td:eq(1)").text().trim();
			iOldAccept = radioObj.parent().parent().find("td:eq(2)").text().trim();
		}
		
		//alert("iImeiCode=["+iImeiCode+"]"+"\n"+"iOldAccept=["+iOldAccept+"]");
		
		if(iOldImeiCode==""||iOldAccept==""){
			rdShowMessageDialog("��ѡ��Ҫ����ļ�¼");
			treurn;
		}
		
		if(!checkElement(document.msgFORM.sm416_imei_no)) return;
		
 
		
		
		var ret = sm416_showPrtDlg("Detail","ȷʵҪ���е��������ӡ��","Yes"); 
		
		
		if(rdShowConfirmDialog("ȷ��Ҫ�ύ��Ϣ��")!=1) return;
    var packet = new AJAXPacket("fm416_Cfm.jsp","���Ժ�...");
        packet.data.add("opCode",public_opCode);//
        packet.data.add("phoneNo","<%=activePhone%>");//
        packet.data.add("iOldImeiCode",iOldImeiCode);//
        packet.data.add("iImeiCode",$("#sm416_imei_no").val().trim());//
        packet.data.add("iOldAccept",iOldAccept);//
         packet.data.add("loginAccept","<%=loginAccept%>");//
    core.ajax.sendPacket(packet,sm416_do_Cfm);
    packet =null;		
}
function sm416_do_Cfm(packet){
    var error_code = packet.data.findValueByName("code");//���ش���
    var error_msg =  packet.data.findValueByName("msg");//������Ϣ

    if(error_code!="000000"){//���÷���ʧ��
      rdShowMessageDialog(error_code+":"+error_msg,0);
	    return;
    }else{//�����ɹ�
	    rdShowMessageDialog("�����ɹ�",2);
    	reSetThis();
    }
}





function sm416_showPrtDlg(printType,DlgMessage,submitCfm){  //��ʾ��ӡ�Ի��� 
	  var h=180;
	  var w=350;
	  var t=screen.availHeight/2-h/2;
	  var l=screen.availWidth/2-w/2;		   	   
	  var pType="subprint";             				 	//��ӡ���ͣ�print ��ӡ subprint �ϲ���ӡ
	  var billType="1";              				 			  //Ʊ�����ͣ�1���������2��Ʊ��3�վ�
	  var sysAccept =<%=loginAccept%>;             	//��ˮ��
	  
	  var printStr = sm416_printInfo(printType);
	  
		                      //����printinfo()���صĴ�ӡ����
	  var mode_code=null;           							  //�ʷѴ���
	  var fav_code=null;                				 		//�ط�����
	  var area_code=null;             				 		  //С������
	  var opCode=public_opCode;                   			 	//��������
	  var phoneNo="<%=activePhone%>";                  //�ͻ��绰
	  
	  var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no";
	  var path = "<%=request.getContextPath()%>/npage/innet/hljBillPrint_jc_hw.jsp?DlgMsg=" + DlgMessage;
	  path+="&mode_code="+mode_code+
	  	"&fav_code="+fav_code+"&area_code="+area_code+
	  	"&opCode="+public_opCode+"&sysAccept="+sysAccept+
	  	"&phoneNo="+phoneNo+
	  	"&submitCfm="+submitCfm+"&pType="+
	  	pType+"&billType="+billType+ "&printInfo=" + printStr;
	  var ret=window.showModalDialog(path,printStr,prop);
	  return ret;
}				

//��ӡģ��idΪ��122 ����imei
function sm416_printInfo(printType){
	  var cust_info="";
	  var opr_info="";
	  var note_info1="";
	  var note_info2="";
	  var note_info3="";
	  var note_info4="";
	  var retInfo = "";

		var iOldImeiCode  = "";
		var iOldAccept    = "";
		
		
		var radioObj = $("#sm416_chg_imei_tab input[type='radio']:checked");
		if(radioObj.html()!=null){
			iOldImeiCode = radioObj.parent().parent().find("td:eq(1)").text().trim();
			iOldAccept = radioObj.parent().parent().find("td:eq(2)").text().trim();
		}
		
			  
	  cust_info+="�ֻ����룺   "+"<%=activePhone%>"+"|";
	  cust_info+="�ͻ�������   "+"<%=custName%>"+"|";
	  
  
	  opr_info += "����ҵ�񣺻����������ն˱��" + "|";
	  opr_info += "������ˮ: "+"<%=loginAccept%>" +"    ԭIMEI��" +iOldImeiCode+"    �ն�IMEI��"+$("#sm416_imei_no").val().trim()+"|";
	  
	  
	  retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
	  retInfo=retInfo.replace(new RegExp("#","gm"),"%23");
	  return retInfo;
}


/*-------------------------------------------m416-----------------����------------------------------*/




$(document).ready(function(){
	$("#radio_<%=opCode%>").click();
	if("m415"=="<%=opCode%>"||"m416"=="<%=opCode%>"){
		sm415_go_getIMEI_list();
	}
});

function pub_set_radio(bt,check_opCode){
	$(bt).prev().click();
	public_opCode = check_opCode;
}
function show_p_div(bt,check_opCode){
	$("div[id^=div_show_]").hide();
	$("#div_show_"+$(bt).val()).show();
	public_opCode = check_opCode;
}
</SCRIPT>
</HEAD>	
<BODY>
<FORM name="msgFORM" action="" method="post"> 
	<%@ include file="/npage/include/header.jsp" %>	
<div class="title"><div id="title_zi"><%=opName%></div></div>

<!----------------------------------------------��������-----------------��ʼ----------------------------->
<table cellSpacing="0">
	<tr>
		<td class="blue" align="center">
			<input type="radio"   value="m414" name="radio_check" style="cursor:hand" onclick="show_p_div(this,'m414')" />
			<span style="cursor:hand" id="radio_m414" onclick="pub_set_radio(this,'m414')">m414��ħ�ٺ϶���</span>
			&nbsp;&nbsp;
			<input type="radio"   value="m415" name="radio_check" style="cursor:hand" onclick="show_p_div(this,'m415'),sm415_go_getIMEI_list()" />
			<span style="cursor:hand" id="radio_m415" onclick="pub_set_radio(this,'m415')">m415��ħ�ٺ��˶�</span>
			&nbsp;&nbsp;
			<input type="radio"  value="m416" name="radio_check" style="cursor:hand"  onclick="show_p_div(this,'m416'),sm415_go_getIMEI_list()" />
			<span style="cursor:hand" id="radio_m416" onclick="pub_set_radio(this,'m416')">m416��ħ�ٺ�IMEI���</span>
		</td>
	</tr>
</table>


<table cellSpacing="0">
	<tr>
	    <td class="blue" width="15%">�ֻ�����</td>
		  <td width="35%">
			    <%=activePhone%>
		  </td>
		  <td class="blue" width="15%">�ͻ�����</td>
		  <td width="35%">
			    <%=custName%>
		  </td>
	</tr>
</table>


<!----------------------------------------------��������-----------------����----------------------------->


<!----------------------------------------------m414-----------------��ʼ----------------------------->
<div id="div_show_m414"> 
	
	
<table cellSpacing="0">
	<tr>
		  <td class="blue" width="15%">����������</td>
		  <td width="35%">
			    <select id="sm414_InternetTV"  >
			    	<option value="δ������">δ������</option>
			    </select>
		  </td>
		  <td class="blue" width="15%">IMEI��</td>
		  <td>
			    <input type="text"  value=""  v_minlength="15" v_maxlength="15"  name="sm414_imei_no" id="sm414_imei_no" v_must="1" v_type="0_9"   onblur="checkElement(this)" maxlength="15" />
		  </td>
	</tr>
	<tr>
		  <td class="blue" width="15%">����ģʽ</td>
		  <td width="35%">
			    <select id="sm414_SaleType"  >
			    	<option value="Ѻ��">Ѻ��</option>
			    </select>
		  </td>
		  <td class="blue" width="15%">Ѻ��</td>
		  <td>
			    <input type="text"  value="" name="sm414_deposit" id="sm414_deposit" v_must="1" v_type="money"   onblur="checkElement(this)" maxlength="32" />
			    <font class="orange">0-200Ԫ</font>
		  </td>
	</tr>
 
	<tr>
		  <td class="blue" width="15%">����˺�</td>
		  <td width="35%"colspan="3" >
			   <input type="text"  value="" name="sm414_BroadbandAccount" id="sm414_BroadbandAccount" v_must="1" v_type="string"   onblur="checkElement(this),sm414_go_getAddr(this)" maxlength="20" />
		  </td>
	</tr>	  
	<tr>
		  <td class="blue" width="15%">װ����ַ</td>
		  <td width="35%"colspan="3" >
			    <input type="text"  value="" name="sm414_InstalledAddr" id="sm414_InstalledAddr" v_must="1" v_type="string"   onblur="checkElement(this)"  maxlength="256" size="80"/>
		  </td>
	</tr>
 
 	
</table>


<table cellSpacing="0">
	 <tr>
	 	<td id="footer">
	 		<input type="button" class="b_foot" value="ȷ��" onclick="sm414_go_Cfm()"            />
	 		<input type="button" class="b_foot" value="����" onclick="reSetThis()"         /> 
			<input type="button" class="b_foot" value="�ر�" onclick="removeCurrentTab()"  /> 
	 	</td>
	</tr>
</table>


</div>
<!----------------------------------------------m414-----------------����----------------------------->





<!----------------------------------------------m415-----------------��ʼ----------------------------->
<div id="div_show_m415"> 

<table cellSpacing="0" >
	<tr>
		  <td class="blue" width="15%">����ģʽ</td>
		  <td width="35%">
			    <select id="sm415_SaleType"  >
			    	<option value="Ѻ��">Ѻ��</option>
			    </select>
		  </td>
		  <td class="blue" width="15%">&nbsp;</td>
		  <td>
			    &nbsp;
		  </td>
	</tr>
	
</table>
<div class="title"><div id="title_zi">����б�</div></div>

<table cellSpacing="0" id="sm415_chg_imei_tab">
	<tr>
		<th width="20%">ѡ��</th>
		<th width="20%">IMEI��</th>
		<th width="20%">������ˮ</th>
		<th width="20%">����ʱ��</th>
		<th width="20%">Ѻ��</th>
	</tr>
</table>

<table cellSpacing="0">
	 <tr>
	 	<td id="footer">
	 		<input type="button" class="b_foot" value="ȷ��" onclick="sm415_go_Cfm()"            />
	 		<input type="button" class="b_foot" value="����" onclick="reSetThis()"         /> 
			<input type="button" class="b_foot" value="�ر�" onclick="removeCurrentTab()"  /> 
	 	</td>
	</tr>
</table>
<table cellSpacing="0">
	<tr>
		  <td> <font class="orange">��ȥ��g836-Ѻ�𷵻�ҵ�񡯽������Ѻ�𷵻�</font></td>
	</tr>
</table>
</div>
<!----------------------------------------------m415-----------------����----------------------------->	






<!----------------------------------------------m416-----------------��ʼ----------------------------->
<div id="div_show_m416"> 

<table cellSpacing="0" >
	<tr>
		  <td class="blue" width="15%">����ģʽ</td>
		  <td width="35%">
			    <select id="sm415_SaleType"  >
			    	<option value="Ѻ��">Ѻ��</option>
			    </select>
		  </td>
		  <td class="blue" width="15%">��IMEI��</td>
		  <td width="35%" colspan="3">
		  	<input type="text"  value="" v_minlength="15" v_maxlength="15"  name="sm416_imei_no" id="sm416_imei_no" v_must="1" v_type="0_9"   onblur="checkElement(this)"  maxlength="15" />
		  </td>
	</tr>
	 
</table>
<div class="title"><div id="title_zi">����б�</div></div>

<table cellSpacing="0" id="sm416_chg_imei_tab">
	<tr>
		<th width="20%">ѡ��</th>
		<th width="20%">IMEI��</th>
		<th width="20%">������ˮ</th>
		<th width="20%">����ʱ��</th>
		<th width="20%">Ѻ��</th>
	</tr>
</table>

	


<table cellSpacing="0">
	 <tr>
	 	<td id="footer">
	 		<input type="button" class="b_foot" value="ȷ��" onclick="sm416_go_Cfm()"            />
	 		<input type="button" class="b_foot" value="����" onclick="reSetThis()"         /> 
			<input type="button" class="b_foot" value="�ر�" onclick="removeCurrentTab()"  /> 
	 	</td>
	</tr>
</table>

</div>
<!----------------------------------------------m416-----------------����----------------------------->	
 
			
<%@ include file="/npage/include/footer.jsp" %>
</FORM>
</BODY>
</HTML>
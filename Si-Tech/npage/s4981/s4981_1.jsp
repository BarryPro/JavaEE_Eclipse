 <!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%                           
  /*
   * ����: 
   * �汾: 
   * ����: 2010-4-14 9:24
   * ����: lijy
   * ��Ȩ: si-tech
   * update:
  */
%>
<%response.setHeader("Pragma","No-cache");
response.setHeader("Cache-Control","no-cache");
response.setDateHeader("Expires", 0);
response.flushBuffer();%>
<%
String cccTime=new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss", Locale.getDefault()).format(new java.util.Date());
String workNo = (String)session.getAttribute("workNo");
String workName = (String)session.getAttribute("workName");
String orgCode = (String)session.getAttribute("orgCode");
String regionCode = orgCode.substring(0,2);
String ip_Addr = (String)session.getAttribute("ipAddr");
String password = (String)session.getAttribute("password");
String opCode = request.getParameter("opCode")==null?"4981":request.getParameter("opCode");
String opName = request.getParameter("opName")==null?"����ƻ�":request.getParameter("opName");
String dateStr2 =  new java.text.SimpleDateFormat("yyyyMMdd").format(new java.util.Date());
activePhone= activePhone==null? "":activePhone;
String sqlStr1="select  a.region_name from sregioncode a where a.region_code='"+regionCode+"'";
String userRegionName="";
%>
<wtc:pubselect name="sPubSelect" outnum="1">
		<wtc:sql><%=sqlStr1%></wtc:sql>
</wtc:pubselect>
<wtc:array id="result1" scope="end"/>	
<%
  if(retCode.equals("000000") && result1.length > 0){
      userRegionName=result1[0][0];
	}
%>
<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="region" routerValue="<%=regionCode%>"  id="sysAcceptl" /> 	
<%
System.out.println("-----------------------sysAcceptl---------------------------"+sysAcceptl);
%>	
<HEAD><TITLE><%=opName%></TITLE>
<SCRIPT type=text/javascript>	
var flag="0";//��ѯ������û���Ϣ�ı�־ 0��ʾδ��ѯ����1��ʾ�鵽
$(document).ready(function () {
	buttonShow();
	});
	//����û���Ϣ��ѯ
function getUserInfo()
{
	var cfmLogin="";
	var phoneNo="";
	if(document.all.query_type[0].checked)
	{
		cfmLogin=document.all.query_content.value;
	}else if(document.all.query_type[1].checked){
		phoneNo=document.all.query_content.value;
	}
	var myPacket = new AJAXPacket("getKdUserInfo.jsp", "����У�飬���Ժ�......");
		   myPacket.data.add("loginAccept", document.all.sysAcceptl.value);
		   myPacket.data.add("opCode", <%=opCode%>);
		   myPacket.data.add("workNo",document.all.workNo.value );
		   myPacket.data.add("password",document.all.password.value );
		   myPacket.data.add("phoneNo",phoneNo);
		   myPacket.data.add("cfmLogin",cfmLogin);
		   core.ajax.sendPacket(myPacket,doGetUserInfo);
       myPacket = null;
}
function doGetUserInfo(packet)
{
   var retCode = packet.data.findValueByName("retCode");
   var retMessage = packet.data.findValueByName("retMessage");
   if(retCode=="000000"){ 
    		 document.all.phone_no.value= packet.data.findValueByName("Phoneno");  
    		 document.all.id_no.value=packet.data.findValueByName("id_no");  
    		 document.all.sm_name.value=packet.data.findValueByName("Sm_name");  
    		 document.all.sm_code.value=packet.data.findValueByName("Sm_code");  
    		 document.all.vModeName.value=packet.data.findValueByName("Modename");  
    		 document.all.vModeCode.value=packet.data.findValueByName("Modecode");    
    		 document.all.run_name.value=packet.data.findValueByName("Run_name");  
    		 document.all.run_code.value=packet.data.findValueByName("Run_code");  
    		 //document.all.vOweFee.value=packet.data.findValueByName("Owefee");  
    		 document.all.vAttrName.value=packet.data.findValueByName("Attname");  
    		 //document.all.vCustAttr.value=packet.data.findValueByName("Custattr");  
    		 document.all.areaNameOld.value=packet.data.findValueByName("Areaname");  
    		 document.all.areaCodeOld.value=packet.data.findValueByName("Areacode");  
    		 document.all.vOpenDate.value=packet.data.findValueByName("vOpenDate");  
    		 document.all.cfm_login.value=packet.data.findValueByName("Cfmlogin");  
    		 document.all.vCfmPwd.value=packet.data.findValueByName("Cfmpwd");   
    		 document.all.detailAddrOld.value=packet.data.findValueByName("Detailaddr");  
    		 document.all.BandWidthOld.value=packet.data.findValueByName("BandWidth");  
    		 //�ͻ���Ϣ
    		 document.all.userName.value=packet.data.findValueByName("Cust_name");  
    		 document.all.Custaddress.value=packet.data.findValueByName("Cust_address");  
    		 document.all.Contractno.value=packet.data.findValueByName("Contractno");  
    		 document.all.RegionCode.value=packet.data.findValueByName("RegionCode");  
    		 document.all.RegionName.value=packet.data.findValueByName("RegionName");  
    		 //���þ���Դ��ѯ
    		 getOldResByCfmLogin();
   }else{
    			rdShowMessageDialog(retMessage,0);	
    			return;	
   }
 
     
}
//��ȡ����Դ��Ϣ
function getOldResByCfmLogin( )
{
	var myPacket = new AJAXPacket("../se276/ajax_getOldResByCfmLogin1.jsp", "����У�飬���Ժ�......");
		   myPacket.data.add("cfmLogin", document.all.cfm_login.value);
		   core.ajax.sendPacket(myPacket,doGetOldResByCfmLogin);
                     myPacket = null;
}
function doGetOldResByCfmLogin(packet)
{
	var retCode = packet.data.findValueByName("retCode");
         var retMessage = packet.data.findValueByName("retMessage");
         var retContent=packet.data.findValueByName("retContent");
         if(retCode=="000000"){
           var fieldContent=retContent.split(",");
           var records=fieldContent[2].split("=");
           var record=records[1].split("%");
	            if(!(record[0]=="1") && !(record[0]=="2")){
			            document.all.deviceTypeOld.value= record[0];
			            document.all.deviceCodeOld.value=record[1];
			            document.all.modelOld.value= record[2];
			            document.all.factoryOld.value= record[3];
			            document.all.ipAddressOld.value= record[4];
			            document.all.deviceInAddressOld.value= record[5];
			            document.all.portCodeOld.value= record[6];
			            document.all.portTypeOld.value= record[7]; 
			            document.all.cctIdOld.value= record[8];
			             flag="1";          
	         }else{
	         	rdShowMessageDialog("��ѯ����Դ��Ϣʧ��",0);
	         	return false;
	        }
        } else{
        	rdShowMessageDialog(retMessage,0);
        	return false;
        }
}

function oneTok(str,tok,loc)
{
   var temStr=str;
	 var temLoc;
	 var temLen;
   for(ii=0;ii<loc-1;ii++)
	{
       temLen=temStr.length;
       temLoc=temStr.indexOf(tok);
       temStr=temStr.substring(temLoc+1,temLen);
 	}
	if(temStr.indexOf(tok)==-1)
	  return temStr;
	else
    return temStr.substring(0,temStr.indexOf(tok));
}	
function buttonShow()
{
	if(document.all.isYzResource.value=="0")
	{	
    if(document.all.isGetAreaResource.value=="1")
		{
			document.all.yz_resource.disabled=false;
		}else if (document.all.isDoNoResource.value=="1")
		{
			document.all.yz_resource.disabled=true;
		}else if ((document.all.isDoNoResource.value !="1") && (document.all.isGetAreaResource.value!="1") )
		{
			document.all.query_res.disabled=false;
			document.all.yz_resource.disabled=true;
		}
			
	}
	else{
			document.all.query_res.disabled=true;
	}
}
function idleResInfo()
{
	document.all.area_nameh.value=  "";
	document.all.area_codeh.value=  "";
	document.all.areaAddr.value=  "";	
	//document.all.bandWidth.value="";
	document.all.enter_type.value=  "";
	document.all.standardCode.value="";
	document.all.standardContent.value="";
	
	document.all.deviceType.value="";
	document.all.deviceCode.value="";
	document.all.model.value="";
	document.all.factory.value="";
  document.all.ipAddress.value="";
  document.all.deviceInAddress.value="";
  document.all.portType.value="";
  document.all.portCode.value="";
  document.all.cctId.value="";
  document.all.cctName.value="";
}
/*���С����ѯ*/
function queryResource()
{ 
	 idleResInfo();
   if(document.all.isYzResource.value!="1"){
		      var path ="../se276/queryResource1.jsp?opCode="+"<%=opCode%>";
		      window.open(path,'С����Դ��ѯ','width=840px,height=600px,left=100,top=50,resizable=yes,scrollbars=yes,status=yes,location=no,menubar=no');
    }else{	 
    		yzResource();//�ͷ���Դ 	
    }
} 
function returnResBack(retInfo)
{   
	var resPre=retInfo.substr(0,2);
	var resContent=retInfo.substr(2,retInfo.length-1);
  if (resPre =="3%"){//���豸�޶˿�
  }else if (resPre =="4%"){//���豸�ж˿�
  		document.all.area_nameh.value=  oneTok(resContent, "|", 1);
			document.all.area_codeh.value=  oneTok(resContent, "|", 2);
			document.all.areaAddr.value=  oneTok(resContent, "|", 3);	
			//document.all.bandWidth.value=oneTok(resContent, "|", 4);
			document.all.enter_type.value=  oneTok(resContent, "|", 5);
			document.all.standardCode.value=oneTok(resContent, "|", 6);
			document.all.standardContent.value=oneTok(resContent, "|",7);
			
			document.all.deviceType.value=oneTok(resContent, "|", 8);
		  document.all.deviceCode.value=oneTok(resContent, "|", 9);
		  document.all.model.value=oneTok(resContent, "|", 10);
		  document.all.factory.value=oneTok(resContent, "|", 11);
    	document.all.ipAddress.value=oneTok(resContent, "|", 12);
    	document.all.deviceInAddress.value=oneTok(resContent, "|", 13);
    	document.all.portType.value=oneTok(resContent, "|", 14);
    	document.all.portCode.value=oneTok(resContent, "|", 15);
    	document.all.cctId.value=oneTok(resContent, "|", 16);
    	//document.all.cctId.value="001";
    	/*if(document.all.cctId.value != ""){
			    var packet = new AJAXPacket("ajaxGetCctName.jsp","���Ժ�...");
					packet.data.add("cctId",document.all.cctId.value);
					core.ajax.sendPacket(packet,doAjaxGetCctName);
					packet = null;
    	}*/
    	document.all.isGetAreaResource.value="1";
    	buttonShow();
  }
     
}
function doAjaxGetCctName(packet)
{
	var retCode = packet.data.findValueByName("retCode");
  var retMsg = packet.data.findValueByName("retMsg");
  var cctName = packet.data.findValueByName("cctName");
  if(retCode == "000000")
  {
  	document.all.cctName.value=cctName;	
  }
  else
  {
  	rdShowMessageDialog(retMsg,0);
  }
}
//��ԴԤռ
function yzResource( )
{
	if(flag=="1"){
		if(document.all.isGetAreaResource.value=="0"){
		       rdShowMessageDialog("û��ѡ����Դ����ѡ����Դ");
		       return false;
		}else if(document.all.contactPhone.value==null || document.all.contactPhone.value=="" || document.all.contactPhone.value=="0"){
		  	rdShowMessageDialog("��ϵ���벻����Ϊ�գ�������");
		  	document.all.contactPhone.focus();
		  	return false;
		 }else if(document.all.contactCustName.value==null || document.all.contactCustName.value=="" || document.all.contactCustName.value=="0"){
		  	rdShowMessageDialog("��ϵ�˲�����Ϊ�գ�������");
		  	document.all.contactCustName.focus();
		  	return false;
		 }
		 else if(document.all.enter_addr.value==null || document.all.enter_addr.value==""){
			rdShowMessageDialog("��װ��ַ������Ϊ�գ�������");
			document.all.enter_addr.focus();
			return false;
		 }
		if(document.all.isYzResource.value=="1")
		{
			rdShowMessageDialog("���û���Ԥռ��Դ,���Ҫ����Ԥռ��ȷ��Ҫ�ͷ�ԭ����Դ��",1);
		  var myPacket = new AJAXPacket("../se276/ajax_yzResource1.jsp", "����У�飬���Ժ�......");
				myPacket.data.add("serviceOrder","40007" );
				myPacket.data.add("type", "2" );
				myPacket.data.add("businessCity",  "<%=userRegionName%> ");
				myPacket.data.add("businessArea","");/*ҵ����������*/
				myPacket.data.add("businessDemand","");/*ҵ����������*/
				myPacket.data.add("productApplyUses","����ƻ���Դ�ͷ�");/*��;*/
				
				myPacket.data.add("loginNo", "<%=workNo%>");
				myPacket.data.add("applyId","");/*����ϵͳ��������*/
				
				myPacket.data.add("productName", "");
				myPacket.data.add("productCode", document.all.cfm_login.value);
				myPacket.data.add("productType","12");/*��Ʒ����*/
				myPacket.data.add("productState","");/*��Ʒҵ��״̬*/
				myPacket.data.add("validateTime","");/*����Чʱ��*/
				myPacket.data.add("relatedProductCode","");/*������Ʒ*/
				
				myPacket.data.add("account", document.all.cfm_login.value);
				myPacket.data.add("password","null");/*����*/
				myPacket.data.add("customerName", document.all.userName.value);
				myPacket.data.add("customerAddress", document.all.detailAddrOld.value);
				myPacket.data.add("customerGrade","");/*�û�����*/
				myPacket.data.add("customerLinkMan","");/*�û���ϵ��*/
				myPacket.data.add("customerPhone", "");
				myPacket.data.add("customerMail","");/*��ϵ����*/
				myPacket.data.add("customerCode",document.all.cfm_login.value);/*�û����*/
				myPacket.data.add("newCustomerName",document.all.userName.value);/*���û���������*/
				myPacket.data.add("newCustomerAddress",document.all.enter_addr.value);/*���û���ַ*/
				myPacket.data.add("newCustomerPhone",document.all.contactPhone.value);/*����ϵ�绰*/
				myPacket.data.add("stdAddress",document.all.standardContent.value);/*�û���׼��ַ*/
				myPacket.data.add("newRate","");/*�¿������*/
				myPacket.data.add("oldRate","");/*�ɿ������*/
				
				myPacket.data.add("serviceType","17");/*��������*/	
				myPacket.data.add("deviceName", document.all.deviceType.value );
				myPacket.data.add("deviceId", document.all.deviceCode.value );
				myPacket.data.add("portName", document.all.portType.value);
				myPacket.data.add("portId", document.all.portCode.value);
	
				myPacket.data.add("collType","");/*��������*/
				myPacket.data.add("broadBandObject","");/*�������*/
				myPacket.data.add("opNote", "��Դ�ͷ�");/*��ע*/
						
				myPacket.data.add("opCode", "<%=opCode%>");
				core.ajax.sendPacket(myPacket,doYzResource);
				myPacket = null;
		                                                               
		}else if(document.all.isYzResource.value=="0"){
			var myPacket = new AJAXPacket("../se276/ajax_yzResource1.jsp", "����У�飬���Ժ�......");  
				myPacket.data.add("serviceOrder","40007"  );
				myPacket.data.add("type", "0" );
				myPacket.data.add("businessCity",  "<%=userRegionName%> ");
				myPacket.data.add("businessArea","");/*ҵ����������*/
				myPacket.data.add("businessDemand","");/*ҵ����������*/
				myPacket.data.add("productApplyUses","���������ԴԤռ");/*��;*/
				
				myPacket.data.add("loginNo", "<%=workNo%>");
				myPacket.data.add("applyId","");/*����ϵͳ��������*/
				
				myPacket.data.add("productName", "");
				myPacket.data.add("productCode", document.all.cfm_login.value);
				myPacket.data.add("productType","12");/*��Ʒ����*/
				myPacket.data.add("productState","");/*��Ʒҵ��״̬*/
				myPacket.data.add("validateTime","");/*����Чʱ��*/
				myPacket.data.add("relatedProductCode","");/*������Ʒ*/
				
				myPacket.data.add("account", document.all.cfm_login.value);
				myPacket.data.add("password","null");/*����*/
				myPacket.data.add("customerName", document.all.userName.value);
				myPacket.data.add("customerAddress", document.all.detailAddrOld.value);
				myPacket.data.add("customerGrade","");/*�û�����*/
				myPacket.data.add("customerLinkMan","");/*�û���ϵ��*/
				myPacket.data.add("customerPhone","");
				myPacket.data.add("customerMail","");/*��ϵ����*/
				myPacket.data.add("customerCode",document.all.cfm_login.value);/*�û����*/
				myPacket.data.add("newCustomerName",document.all.userName.value);/*���û�����*/
				myPacket.data.add("newCustomerAddress",document.all.enter_addr.value);/*���û���ַ*/
				myPacket.data.add("newCustomerPhone",document.all.contactPhone.value);/*����ϵ�绰*/
				myPacket.data.add("stdAddress",document.all.standardContent.value);/*�û���׼��ַ*/
				myPacket.data.add("newRate","");/*�¿������*/
				myPacket.data.add("oldRate","");/*�ɿ������*/
				
				myPacket.data.add("serviceType","17");/*��������*/	
				myPacket.data.add("deviceName", document.all.deviceType.value );
				myPacket.data.add("deviceId", document.all.deviceCode.value );
				myPacket.data.add("portName", document.all.portType.value);
				myPacket.data.add("portId", document.all.portCode.value);
	
				myPacket.data.add("collType","");/*��������*/
				myPacket.data.add("broadBandObject","");/*�������*/
				myPacket.data.add("opNote", "��ԴԤռ");/*��ע*/
						
				myPacket.data.add("opCode", "<%=opCode%>");
				core.ajax.sendPacket(myPacket,doYzResource);
				myPacket = null;	                                                             
		}
	}else if(flag=="0"){
		rdShowMessageDialog("û�в�ѯ������û�,����Դ��Ϣ��������Ԥռ��Դ");
	}	
} 
function doYzResource(packet)
{
	var retCode = packet.data.findValueByName("retCode");
	var retMsg = packet.data.findValueByName("retMsg");
	var retContent = packet.data.findValueByName("retContent");
	var iType = packet.data.findValueByName("iType");
     if(iType=="0"){          
          if(retCode=="000000" ){	
          	var retValue=retContent.split(",");
            var retContent=retValue[2].split("=");
            
            if(retContent[1]=="0"){//�ж��Ƿ�Ԥռ�ɹ�
				       	//��Щ����򲻿ɱ༭
				       	document.all.contactCustName.readOnly=true;
				       	document.all.contactPhone.readOnly=true;
				       	document.all.enter_addr.readOnly=true;
				       	//��Щ��ť������
				       	document.all.isYzResource.value="1";  
				       	rdShowMessageDialog("��ԴԤռ�ɹ�",2);
				       	buttonShow();
			       }else{
			      			rdShowMessageDialog("��ԴԤռʧ��",0);
			      	}     
			     }else {                                       
			       	 rdShowMessageDialog(retMsg,0); 
			       	 document.all.isYzResource.value="0"; 
			     }
     }else if(iType=="2"){
	     if(retCode=="000000"  ){	
		     	var retValue=retContent.split(",");
		      var retContent=retValue[2].split("=");
		      if(retContent[1]=="0"){ 
             idleResInfo();
			    	  //��Щ������������	
			    	 document.all.contactCustName.readOnly=false;	    	  
				     document.all.contactPhone.readOnly=false;
				     document.all.enter_addr.readOnly=false;
			    	 //��Щ��ť������ʹ��
			    	 document.all.isYzResource.value="0"; 
			    	 document.all.isGetAreaResource.value="0";
			    	 rdShowMessageDialog("��Դ�ͷųɹ�",1);
			   	 	 buttonShow();
			   	
		      }else{
		       rdShowMessageDialog("��Դ�ͷ�ʧ��",0); 
		       return false;
		      } 
	     }else{
		     	rdShowMessageDialog(retMsg,0);  
		     	document.all.isYzResource.value="1"; 
	     }
	   }
}	
/*�ύ����*/
function commitJsp(){
    if(f4981.contactPhone.value.trim().length == 0){
            rdShowMessageDialog("��ϵ�绰����Ϊ�գ�");
            document.all.contactPhone.focus();
            return false;
       }
    if(f4981.enter_addr.value.trim().length == 0){
            rdShowMessageDialog("����ϸ��װ��ַ����Ϊ�գ�");
            document.all.enter_addr.focus();
            return false;
       }
      if(f4981.construct_request.value.trim().length == 0){
            document.all.construct_request.value="��";
       }
      if(f4981.appointvTime.value.trim().length == 0){
            rdShowMessageDialog("ԤԼ����ʱ�䲻��Ϊ�գ�");
            document.all.appointvTime.focus();
            return false;
       }
       if((document.all.isYzResource.value!="1") && (document.all.isDoNoResource.value !="1")){
						rdShowMessageDialog("û��Ԥռ��Դ������Ԥռ��Դ����!");
						return false;  
			 }
			 if(forDate(document.all.appointvTime)){
	  		rdShowMessageDialog("ԤԼ����ʱ���ʽ����ȷ��");
	      document.all.appointvTime.focus();
	      return false;
	     }
			 if(!forDate(document.all.appointvTime)){
			  	if($(document.getElementById("appointvTime")).val() < "<%=dateStr2%>")
			  	{
			  		rdShowMessageDialog("ԤԼ����ʱ�䲻��С�ڵ�ǰʱ�䣡");
			  		return false;
			    }
			 }else if(!check(f4981)){
				    return false;
			 }
			
			    
       // showPrtDlg("Detail","ȷʵҪ���е��������ӡ��","Yes");
			if(rdShowConfirmDialog('ȷ��Ҫ�ύ<%=opName%>��Ϣ��')==1)
			{
					document.all.vSystemNote.value="����Ա<%=workNo%>���û�<%=activePhone%>"+"����<%=opName%>����";
					var vOpNote=document.all.vOpNote.value.trim();
					if(vOpNote.length==0){
						  document.all.vOpNote.value=document.all.vSystemNote.value;
			    }
			      conf();
			}
}
function conf()
{
	document.f4981.action="s4981_Cfm.jsp"; 
	f4981.submit();
}
//���������ӡ
function showPrtDlg(printType,DlgMessage,submitCfm)
{  
   var h=198;
   var w=350;
   var t=screen.availHeight/2-h/2;
   var l=screen.availWidth/2-w/2;
   var pType="subprint";
   var billType="1";
   var sysAccept = "<%=sysAcceptl%>";
   var phone_no	= $("input[name='phone_no']").val();
   
   var mode_code = document.all.vModeCode.value;
   mode_code = mode_code.replace(/,/ig,"~");
   
   
   var fav_code = null;
   var area_code = null;
   var printStr = printInfo(printType);

   var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no"; 
   var path = "<%=request.getContextPath()%>/npage/innet/hljBillPrint_jc.jsp?DlgMsg=" + DlgMessage;
   var path=path+"&mode_code="+mode_code+"&fav_code="+fav_code+"&area_code="+area_code+"&opCode=<%=opCode%>&sysAccept="+sysAccept+"&phoneNo="+""+"&submitCfm="+submitCfm+"&pType="+pType+"&billType="+billType+ "&printInfo=" + printStr;
   window.showModalDialog(path,printStr,prop);
}
//��ӡ��Ϣ
function printInfo(printType)
{
   var retInfo = "";
   var cust_info="";
	 var opr_info="";
	 var note_info1="";
	 var note_info2="";
	 
		
    cust_info+="�ͻ�������	"+document.all.userName.value+"|";
    cust_info+="�ֻ����룺	"+$("input[name='phone_no']").val().trim()+"|";
    cust_info+="�ͻ���ַ��	"+document.all.Custaddress.value+"|";
		
		var cTime = "<%=cccTime%>";	
		opr_info+="ҵ������ʱ�䣺"+cTime+"  "+"�û�Ʒ��:"+"���"+"|";
     
		opr_info+="����ҵ�񣺿���ƻ�"+"  "+"������ˮ��"+document.all.sysAcceptl.value+"|";			
	
   note_info1+="��ע��"+document.all.vOpNote.value+"|";
 
	retInfo = strcat(cust_info,opr_info,note_info1);
         retInfo=retInfo.replace(new RegExp("#","gm"),"%23");
 	return retInfo;	
}
function closeWindow()
{
	clearWindow();
  parent.removeTab(<%=opCode%>);
}
function clearWindow()
{
	 if(document.all.isYzResource.value=="1"){
		 yzResource();
   }
   $("#f4981").find("input[type='text']").val("");
   buttonShow();    
}

</SCRIPT>		
</HEAD>
<body>
<form method=post name="f4981" id="f4981">
<%@ include file="/npage/include/header.jsp" %>

<div class="title">
 <div id="title_zi">�û���Ϣ</div>	  
</div>
<table  cellSpacing="0">
	<tr>
  	<td class="Blue">��ѯ����</td>
    <td>
    	<input type="radio" id="query_type" name="query_type" value="0" >�����½�˺�
      <input type="radio" id="query_type" name="query_type" value="1"  checked>�û�����
    </td>
    <td>
    	<input type="text" id="query_content" name="query_content" value="<%=activePhone%>"/>
    </td>
    <td colspan="3">
    	<input type="button" class="b_text" value="��ѯ" onclick="getUserInfo()"/>
    </td> 
  </tr>
  <tr>    	         
	  <td  class="Blue"> �������</td>																																					
	  <td>																																					
	   <input type="text"  name="phone_no" readonly> 																																					
	  </td>	
    <td class="Blue"> �����½�˺�</td>
    <td>     	
    	<input type="text" value="" name="cfm_login" size=25 readonly>
   	  <input type="hidden" value="" name="vCfmPwd" readonly>
    </td>
    <td   class="Blue">�û�״̬</td> 	
    <td>	
     <input type="text" value="" name="run_name" readonly>
     <input type="hidden" value="" name="run_code" readonly>
    </td>	
  </tr>	
  <tr>																																	
	  <td   class="Blue">ҵ������</td>																																					
	  <td>																																					
	    <input type="text" value="" name="sm_name"  id="sm_name" readonly>																																					
	    <input type="hidden" value="" name="sm_code"  id="sm_code" readonly>																																					
	  </td>																																					
	  <td  class="Blue">�ʷ�����</td>																																					
	  <td>																																					
	  	<input type="text" value="" name="vModeName"  id="vModeName" readonly>																																					
	  	<input type="hidden" value="" name="vModeCode"  id="vModeCode" readonly>																																					
	  </td>	
	  <td  class="Blue">��ʼʱ�� </td>  
    <td>      
      <input type="text" name="vOpenDate"  value="" readonly>
    </td> 																																				
  </tr>
	<tr>
   <td class="Blue" > ԭ��װ��ַ</td>
	 <td  colspan=5>
	 	<input  id="Text2" type="text" readonly value="" size="80" name="detailAddrOld"  v_maxlength="60"  v_type="string" maxlength="60" onkeyup="value=value.replace(/[@#$%!^&*()<>?|]/g,'');" index="9" onblur="checkElement(this)">
   </td>
  </tr>	
</table>


<div class="title">
 <div id="title_zi">����Դ��Ϣ</div>	  
</div>
<table cellSpacing="0">
	<tr>
  	<td  class="Blue">�豸����</td>
    <td >
	  	<input id="deviceTypeOld" name="deviceTypeOld" readonly>
    </td>
    <td  class="Blue">�˿�����</td>
   <td>
		 <input id="portTypeOld" name="portTypeOld" readonly>
   </td>
   <td  class="Blue">�豸��װ��ַ</td>  
   <td> 
   	<input id="deviceInAddressOld" name="deviceInAddressOld" size=50 readonly> 
   </td>
	</tr>  
</table>



<div class="title">
 <div id="title_zi">����Դ��Ϣ</div>	  
</div>
<table cellspacing="0" >  
   <tr >    
   	  <td colspan='6' align='center'> 
				 <input type="button" class="b_text" name="query_res" value="С����Դ��ѯ" onClick="queryResource()" >
				 <input type="button" class="b_text" name="yz_resource" value="��ԴԤռ" onClick="yzResource()">
      </td>
   </tr>
   <tr>
		<td class="Blue" width="10%">��ϵ��</td>  
    <td>
        <input id="contactCustName" name="contactCustName" ><font class="orange">*</font>
    </td> 
    <td class="Blue" >��ϵ�绰</td>  
    <td> 
        <input id="contactPhone" name="contactPhone" onKeyPress="return isKeyNumberdot(0)" ><font class="orange">*</font>
    </td> 
    <td class="Blue">С������</td>  
    <td> 
        <input type="text"    id="area_nameh" name="area_nameh" readonly> 
        <input type="hidden"  name="area_codeh"  readOnly>  
    </td> 
   </tr>  
   <tr>
   	<td class="Blue" >����ϸ��װ��ַ</td>
	  <td colspan='6'>
			<input  id="Text2" type="text" size="80" name="enter_addr"  v_type="string"  onkeyup="value=value.replace(/[@#$%!^&*()<>?|]/g,'');" index="9"  ><font class="orange">*</font>
	  </td>
  </tr>    
   <tr>
      <td  class="Blue">���ž�����</td>
      <td>
         <input type="text"  id="cctName" name="cctName"  readOnly>
      </td>
      <td  class="Blue">��׼��ַ</td>
      <td>
         <input type="text"  id="standardContent" name="standardContent" size=50 readOnly>
      </td>
      <td  class="Blue"> ���뷽ʽ</td>
	    <td> 
	         <input id="enter_type" name="enter_type"  readonly>
	    </td> 
   </tr>
   <tr>
	   <td  class="Blue"> �豸����</td>
     <td>
	        <input id="deviceType" name="deviceType" readonly>
     </td>
     <td class="Blue">  �豸��װ��ַ</td>  
     <td> 
        <input id="deviceInAddress" name="deviceInAddress"  size=50 readonly> 
     </td> 
     <td  class="Blue"> �˿�����</TD>
     <td>
	        <input id="portType" name="portType" readonly>
     </td>
   </tr>   
   <tr>
   	<td class="Blue">ʩ��Ҫ��</td>
    <td colspan=3>
    	<input type="text" name="construct_request"  size=60>
    </td>
    <td class="Blue">ԤԼ����ʱ��</td>
	  <td>
	  	<input type="text" name="appointvTime" id="appointvTime" ><font class="orange">(*��ʽYYYYMMDD)</font>
		</td>	
   </tr>	  
</table>

<!--��ע-->
<table cellspacing="0" >
	<tr>
     <td class="Blue" width="15%"> ϵͳ��ע</td>
		 <td>
		 	 <input  id="Text2" type="text" size="60" name="vSystemNote"  v_maxlength="60"  v_type="string" maxlength="60" onkeyup="value=value.replace(/[@#$%!^&*()<>?|]/g,'');" index="9" onblur="checkElement(this)" readonly>
     </td>
  </tr>		  
  <tr>
  	<td class="Blue" width="15%">�û���ע</td>
		<td width="89%">
		  	<input  id="Text2" type="text" size="60" name="vOpNote"  v_maxlength="60"  v_type="string" maxlength="60" onkeyup="value=value.replace(/[@#$%!^&*()<>?|]/g,'');" index="9" onblur="checkElement(this)">
		</td>
	</tr>      
</table>

<table  cellSpacing="0">
	<tr> 
		<td id="footer" align=center>
		  <input class="b_foot" name="button_1"  onmouseup="commitJsp()" onKeyUp="if(event.keyCode==13)commitJsp()" type=button value="ȷ��"  >
		  <input class="b_foot" name=clearwindow onClick="clearWindow()" type=button value="���" >
		  <input class="b_foot" name=back onClick="closeWindow()" type=button value="�ر�" >
		</td>
  </tr>
</table> 	

<input type="hidden"  id="workNo" name="workNo"  value="<%=workNo%>" >
<input type="hidden"  id="password" name="password"  value="<%=password%>" > 
<input type="hidden"  id="opCode" name="opCode"  value="<%=opCode%>" >
<input type="hidden"  id="ipAddr" name="ipAddr"  value="<%=ip_Addr%>" >			    
<input type="hidden" name="sysAcceptl" id="sysAcceptl" value="<%=sysAcceptl%>" /> <!--��ˮ-->

<!--��Դ��ѯ��ʶ-->
<input type="hidden"  id="isDoNoResource" name="isDoNoResource"  value="0" >
<input type="hidden"  id="isGetAreaResource" name="isGetAreaResource"  value="0" >
<input type="hidden"  id="isYzResource" name="isYzResource"  value="0" >
<!--�û���Ϣ-->
<input type="hidden"  id="id_no" name="id_no"  value="" >
<input type="hidden"  id="userName" name="userName"  value="0" >   
<input type="hidden"  id="Custaddress" name="Cust_address"  value="0" > 
<input type="hidden"  id="Contractno" name="Contractno"  value="0" >
<input type="hidden"  id="RegionCode" name="RegionCode"  value="0" >
<input type="hidden"  id="RegionName" name="RegionName"  value="0" >
<input type="hidden"  id="vAttrName" name="vAttrName"  value="0" >

<!--��Դ��Ϣ-->
<input type="hidden" value="" id="areaNameOld" name="areaNameOld"  >
<input type="hidden" value="" id="areaCodeOld" name="areaCodeOld"   >
<input type="hidden"  id="areaAddr" name="areaAddr"  ><!--С����ַ-->
<input type="hidden"  id="standardCode" name="standardCode"  ><!--��׼��ַ����-->
<input type="hidden"  id="bandWidth" name="bandWidth"  >
<input type="hidden"  id="BandWidthOld" name="BandWidthOld"  >
<input type="hidden" id="ipAddress" name="ipAddress"  >
<input type="hidden" id="ipAddressOld" name="ipAddressOld"  >
<input type="hidden" id="deviceCode" name="deviceCode" > 
<input type="hidden" id="deviceCodeOld" name="deviceCodeOld"  > 
<input type="hidden" id="portCode" name="portCode"  > 
<input type="hidden" id="portCodeOld" name="portCodeOld"  > 
<input type="hidden" id="model" name="model"  >
<input type="hidden" id="modelOld" name="modelOld"  >
<input type="hidden" id="factory" name="factory"  > 
<input type="hidden"id="factoryOld" name="factoryOld"  > 
<input type="hidden"id="cctId" name="cctId"  > 
<input type="hidden"id="cctIdOld" name="cctIdOld"  > 
<%@ include file="/npage/include/footer.jsp" %> 
</form>
</body>
</html>	

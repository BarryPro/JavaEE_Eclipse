<%
/********************
 version v2.0
������: si-tech
*
*update:zhanghonga@2008-08-22 ҳ�����,�޸���ʽ
*
********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	
<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>

<%        
		String opCode = "1104";
		String opName = "��ͨ����";
    String workNo = (String)session.getAttribute("workNo");
    String workName = (String)session.getAttribute("workName");
    String Department = (String)session.getAttribute("orgCode");
    String belongCode = Department.substring(0,7);
    String ip_Addr = (String)session.getAttribute("ipAddr");
    String regionCode = Department.substring(0,2);
		String rowNum = "16";
		String getAcceptFlag = "";
%>
<!------------------------------------------------------------->

<html>
<head>
<title>�ͻ�����</title>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
</head>

<SCRIPT type=text/javascript>
	var numStr="0123456789"; 
	onload=function(){
	  document.all.newCust.focus();
	  if(typeof(frm1100.oldCust)!="undefined"){   //�ж��Ƿ��ǲ��ϻ�
	    if(frm1100.oldCust.checked == true){	
	        var obj="tbs"+9;           
	        document.all(obj).style.display="";
	    }
	  } 
	
	  if((typeof(frm1100.idType)!="undefined")&&(typeof(frm1100.idIccid)!="undefined")){//��ԭ���ύǰ��֤������   	
	  	change_idType();	
	  }  
	}

function for0_9(obj) //�ж��ַ��Ƿ���0��9���������
{  
	
    if (!forString(obj)){
	  ltflag = 1;
	  obj.select();
	  obj.focus();
	  return false;
	}else{
	  if (obj.value.length == 0){
	    return true;
	  }
	}    
	if (!isMadeOf(obj.value,numStr)){
      flag = 1;
      rdShowMessageDialog("'" + obj.v_name + "'��ֵ����ȷ�����������֣�");
	  obj.select();
	  obj.focus();
	  return false;
    }	
	return true;	
}
function isMadeOf(val,str)
{

	var jj;
	var chr;
	for (jj=0;jj<val.length;++jj){
		chr=val.charAt(jj);
		if (str.indexOf(chr,0)==-1)
			return false;			
	}
	
	return true;
}

function doProcess(packet)
{
    //AJAX������findValueByName
    var retType = packet.data.findValueByName("retType");
    var retCode = packet.data.findValueByName("retCode"); 
    var retMessage = packet.data.findValueByName("retMessage"); 
    self.status="";
		if(retCode.trim()=="")
		{
	     rdShowMessageDialog("����"+retType+"����ʱʧ�ܣ�");
	     return false;
		}
    //---------------------------------------    
    if(retType == "ClientId")
    {
            //�õ��½��ͻ�ID
        var retnewId = packet.data.findValueByName("retnewId");
        if(retCode=="000000")
        {
            document.frm1100.custId.value = retnewId;
            document.frm1100.temp_custId.value = retnewId;
            document.frm1100.districtCode.focus();
						document.frm1100.districtCode.focus();
						document.all.read_idCard_one.disabled=false;//���֤ɨ�谴ť 2009-8-13 17:05 hejwa����
						document.all.read_idCard_two.disabled=false;
						document.all.scan_idCard_two.disabled=false;
		 
        }
        else
        {
        		retMessage = retMessage + "[errorCode1:" + retCode + "]";
            rdShowMessageDialog(retMessage);
						return false;
        }       
     }
    //-----------------------------------------
    if(retType == "checkPwd")
    {
        //��������У��
        var retResult = packet.data.findValueByName("retResult");
				frm1100.checkPwd_Flag.value = retResult; 
	    	if(frm1100.checkPwd_Flag.value == "false")
	    {
	    	rdShowMessageDialog("�ϼ��ͻ�����У��ʧ�ܣ����������룡");
	    	frm1100.parentPwd.value = "";
	    	frm1100.parentPwd.focus();
	    	frm1100.checkPwd_Flag.value = "false";	    	
	    	return false;	        	
	    }else{
				rdShowMessageDialog("�ϼ��ͻ�����У��ɹ���");
			}
			
		//Ϊ�������������ж�
		if("09" == "<%=regionCode%>"){
			if(document.frm1100.parentPwd.value == "000000"||document.frm1100.parentPwd.value == "111111"||document.frm1100.parentPwd.value == "222222"
		 	 ||document.frm1100.parentPwd.value == "333333"||document.frm1100.parentPwd.value == "444444"||document.frm1100.parentPwd.value == "555555"
		 	 ||document.frm1100.parentPwd.value == "666666"||document.frm1100.parentPwd.value == "777777"||document.frm1100.parentPwd.value == "888888"
		 	 ||document.frm1100.parentPwd.value == "999999"||document.frm1100.parentPwd.value == "123456")
	   		{
	   			rdShowMessageDialog("������ڼ򵥣����޸ĺ��ٰ���ҵ��");
	   			return false;
	   		}
	   	}	
     }        
    //----------------------------------------
    if(retType == "getInfo_withID")
    {
        clear_CustInfo();  
        if(retCode == "000000")
        {
           var retInfo = packet.data.findValueByName("retInfo");
           if(retInfo != "")
           {       
               for(i=0;i<7;i++)
               {           
                    var chPos = retInfo.indexOf("|");
                    valueStr = retInfo.substring(0,chPos);
                    retInfo = retInfo.substring(chPos+1);
                    var obj = "in" + i;
                    document.all(obj).value = valueStr;
                } 
             }
			 else
			 {
			   rdShowMessageDialog("�ͻ������ڣ�");  
			   return false;
			 }
         }           
         else
         {
             retMessage = retMessage + "[errorCode2:" + retCode + "]";
             rdShowMessageDialog(retMessage);
			 			 return false;
         }
     }
	 
	 
	 if(retType=="chkX"){
	    var retObj = packet.data.findValueByName("retObj");
			if(retCode == "000000"){
					rdShowMessageDialog("��֤ͨ��!");			
          document.all.print.disabled=false;
          document.all.uploadpic_b.disabled=false;
		  }else if(retCode=="100001"){
         retMessage = "��ʾ ��"+retMessage;
         rdShowMessageDialog(retMessage);
         document.all.uploadpic_b.disabled=false;
	 			 return true;
      }else{
				 retMessage = "����" + retCode + "��"+retMessage;			 
	       rdShowMessageDialog(retMessage);
			   document.all.print.disabled=true;
			   document.all.uploadpic_b.disabled=true;
				 document.all(retObj).focus();
				 return false;
		}
	}
   //=================================================================
}
//--------------------------------------------
//����ϼ��ͻ���Ϣ
function clear_CustInfo()
{
        for(i=0;i<6;i++)
        {          
                var obj = "in" + i;
                document.all(obj).value = "";
        }
}
//--------------------------------------------
function init(){
	if("09" == "<%=regionCode%>"){
		var divPassword = document.getElementById("divPassword");	
			divPassword.style.display="none";
	}
}

function check_newCust(){
	
	if("09" == "<%=regionCode%>"){
		var divPassword = document.getElementById("divPassword");	
			divPassword.style.display="none";
	} 
	
		if(document.all.idType.value=="0"){
			document.all("card_id_type").style.display=""; 
			} 
	  if(document.all.custQuery.disabled==true){document.all.custQuery.disabled=false}
     frm1100.parentId.v_type="";
	    document.all.Reset.click();
         //�½��ͻ�����������
        if(document.frm1100.newCust.checked == true){
        window.document.frm1100.oldCust.checked = false;
        var temp1="tbs"+9;           
            document.all(temp1).style.display = "none";
            window.document.frm1100.parentId.value = "";
            window.document.frm1100.parentPwd.value = "";
            window.document.frm1100.parentName.value = "";
            window.document.frm1100.parentAddr.value = "";
            window.document.frm1100.parentIdType.value = "";
            window.document.frm1100.parentIdidIccid.value = "";
        }
}
function check_oldCust(){
	if("09" == "<%=regionCode%>"){
		var divPassword = document.getElementById("divPassword");	
			divPassword.style.display="none";
	}
	
	document.all.Reset.click();
	document.all.oldCust.checked=true;
	document.all("card_id_type").style.display="none";  
         //���ͻ�����������    
    if(document.frm1100.oldCust.checked == true)
    {
        window.document.frm1100.newCust.checked = false;
        var temp2="tbs"+9;           
            document.all(temp2).style.display="";
    }
}

function change(){      
        //�Ը�������������Ŀ���       
        var ic = document.frm1100.ownerType.options[document.frm1100.ownerType.selectedIndex].value;       
		if(ic=="01")
	    { 
          document.all("tb0").style.display="";   
		   document.all("tb1").style.display="none";      
		   document.all("td2").style.display="none";
		}
		else if(ic=="02")
	    {
         document.all("tb0").style.display="none";
		   document.all("tb1").style.display="none";
  		   document.all("td2").style.display="none";   
		}       
		else if(ic=="03")
		{
         document.all("tb0").style.display="none";
		   document.all("tb1").style.display="none";
  		   document.all("td2").style.display="";   		
		}
}

	function change_idType(){
	    var Str = document.frm1100.idType.value;
	    
	    var oldCustType = document.frm1100.oldCust.checked;
	    var newCustType = document.frm1100.newCust.checked;
	    
			if(oldCustType){	   
			document.all("card_id_type").style.display="none";  
			}else if(newCustType){
	    if(Str=="0")
	     { 
	     	document.all("card_id_type").style.display="";    
	    	document.frm1100.idIccid.v_type = "idcard";   
	    	}
	    else
	    { 
	    	document.all("card_id_type").style.display="none";  
	    	document.frm1100.idIccid.v_type = "string";   
	    	}
	    	
	    }
	}
function change_custPwd()
{
    check_HidPwd(frm1100.parentPwd.value,"show",frm1100.in1.value.trim(),"hid");
    /*
    if(frm1100.checkPwd_Flag.value != "true");
    {
    	rdShowMessageDialog("�ϼ��ͻ�����У��ʧ�ܣ����������룡");
    	frm1100.parentPwd.value = "";
    	frm1100.parentPwd.focus();
    	return false;	        	
    }
    frm1100.checkPwd_Flag.value = "false"; 
    */
}
//------------------------------------
function printCommit(){
	
				var obj = null;
		//��ȷ�ϴ�ӡ����������ڴ�ӡ��Ʊ
        if(frm1100.oldCust.checked == true)
        {	//���ϻ��������ж�
        	//parentId parentPwd parentIdidIccid parentName
        	
        	if(document.frm1100.parentIdidIccid.value.trim().len()==0){
        		rdShowMessageDialog("�ϼ��ͻ�֤�����벻��Ϊ��!");
        		return false;	
        	}
        	
        	if(document.frm1100.parentName.value.trim().len()==0){
        		rdShowMessageDialog("�ϼ��ͻ����Ʋ���Ϊ��!");
        		return false;	
        	}

        	if(document.frm1100.parentId.value.trim().len()==0){
        		rdShowMessageDialog("�ϼ��ͻ�ID����Ϊ��!");
        		return false;	
        	}
       	
	        if(frm1100.parentId.value == "")
	        {	
	        	rdShowMessageDialog("ѡ���ϻ����ͻ�ID����Ϊ�գ�");
	        	frm1100.parentId.focus();
	        	return false;
	        }
	     
	        if(frm1100.parentIdidIccid.value == "")
	        {	
	        	rdShowMessageDialog("ѡ���ϻ����ͻ�֤�����벻��Ϊ�գ�");
	        	frm1100.parentIdidIccid.focus();
	        	return false;
	        }
	        if(frm1100.parentName.value == "")
	        {	
	        	rdShowMessageDialog("ѡ���ϻ����ͻ����Ʋ���Ϊ�գ�");
	        	frm1100.parentName.focus();
	        	return false;
	        }
	        if(document.frm1100.parentName.value.trim().indexOf('~')>0)
			{
				rdShowMessageDialog("�ϼ��ͻ��������зǷ��ַ�'~'�����޸ģ�",0);
				return false;
			}	
			if(document.frm1100.parentAddr.value.trim().indexOf('~')>0)
			{
				rdShowMessageDialog("�ϼ��ͻ���ַ���зǷ��ַ�'~'�����޸ģ�",0);
				return false;
			}		  
        }
        
        
        //�������½���,���ǲ��ϻ�,��Ҫ��֤�Ĳ���
		    if(frm1100.newCust.checked ==true||frm1100.oldCust.checked==true){
					if(document.frm1100.custId.value.trim().len()==0){
						rdShowMessageDialog("�ͻ�ID����Ϊ��!");
						return false;
					}
					
					if(document.frm1100.custName.value.trim().len()==0){
						rdShowMessageDialog("�ͻ����Ʋ���Ϊ��!");
						return false;
					}
					if(document.frm1100.custName.value.trim().indexOf('~')>0)
					{
						rdShowMessageDialog("�ͻ��������зǷ��ַ�'~'�����޸ģ�",0);
						return false;
					}	
					if(document.frm1100.idIccid.value.trim().len()==0){
						rdShowMessageDialog("֤�����벻��Ϊ��!");
						return false;
					}	
					
					if(document.frm1100.contactPerson.value.trim().indexOf('~')>0)
					{
						rdShowMessageDialog("��ϵ���������зǷ��ַ�'~'�����޸ģ�",0);
						return false;
					}	
					if(document.frm1100.contactPhone.value.trim().indexOf('~')>0)
					{
						rdShowMessageDialog("��ϵ�˵绰���зǷ��ַ�'~'�����޸ģ�",0);
						return false;
			
					}
						
					if(document.frm1100.idAddr.value.trim().len()==0){
						rdShowMessageDialog("֤����ַ����Ϊ��!");
						return false;
					}	
					if(document.frm1100.idAddr.value.trim().indexOf('~')>0)
					{
						rdShowMessageDialog("֤����ַ���зǷ��ַ�'~'�����޸ģ�",0);
						return false;
					}	
					if(document.frm1100.contactPhone.value.trim().len()==0){
						rdShowMessageDialog("��ϵ�˵绰����Ϊ��!");
						return false;
					}			
		
					if(document.frm1100.contactAddr.value.trim().len()==0){
						rdShowMessageDialog("��ϵ�˵�ַ����Ϊ��!");
						return false;
					}	
					if(document.frm1100.contactAddr.value.trim().indexOf('~')>0)
					{
						rdShowMessageDialog("��ϵ�˵�ַ���зǷ��ַ�'~'�����޸ģ�",0);
						return false;
					}	
					if(document.frm1100.contactMAddr.value.trim().len()==0){
						rdShowMessageDialog("��ϵ��ͨѶ��ַ����Ϊ��!");
						return false;
					}	
					if(document.frm1100.contactMAddr.value.trim().indexOf('~')>0)
					{
						rdShowMessageDialog("��ϵ��ͨѶ��ַ���зǷ��ַ�'~'�����޸ģ�",0);
						return false;
					}						
				}
        
        
        if(frm1100.newCust.checked ==true){
					frm1100.parentId.v_type="";
				}
				
        change_idType();   //�жϿͻ�֤�������Ƿ������֤
         
        if(frm1100.contactMail.value.trim() == "")
        {
					frm1100.contactMail.value = "";       	
        }
        //�ж����ա�֤����Ч����Ч��	birthDay	idValidDate
        obj = "tb" + 0;
        obj1 = "tb" + 1;
        if((typeof(frm1100.birthDay)!="undefined")&&
           (frm1100.birthDay.value != "")&&
           (document.all(obj).style.display == ""))
        {	
        	if(forDate(frm1100.birthDay) == false)
        	{	return false;		}
        }else if((typeof(frm1100.yzrq)!="undefined")&&
           (frm1100.yzrq.value != "")&&
           (document.all(obj1).style.display == ""))
        {	
        	if(forDate(frm1100.yzrq) == false)
        	{	return false;		}			
        }


 var upflag =document.all.up_flag.value;
if(upflag==3&&(document.all.but_flag.value =="1"))
{
	rdShowMessageDialog("��ѡ��jpg����ͼ���ļ�");
	return false;
	}
if(upflag==4&&(document.all.but_flag.value =="1"))
{
	rdShowMessageDialog("����ɨ����ȡ֤����Ϣ");
	return false;
	}
	
	
if(upflag==5&&(document.all.but_flag.value =="1"))
{
	rdShowMessageDialog("��ѡ�����һ��ɨ����ȡ֤�������ɵ�֤��ͼ���ļ�"+document.all.pic_name.value);
	return false;
	}
			
if((document.all.but_flag.value =="1")&&document.all.upbut_flag.value=="0"){
	rdShowMessageDialog("�����ϴ����֤��Ƭ",0);
	return false;
	}
			
				var d= (new Date().getFullYear().toString()+(((new Date().getMonth()+1).toString().length>=2)?(new Date().getMonth()+1).toString():("0"+(new Date().getMonth()+1)))+(((new Date().getDate()).toString().length>=2)?(new Date().getDate()):("0"+(new Date().getDate()))).toString());
		
				if(frm1100.idValidDate.value.trim().len()>0){		 
		       if(forDate(frm1100.idValidDate)==false) return false;
		
				   if(to_date(frm1100.idValidDate)<=d)
				   {
					  		rdShowMessageDialog("֤����Ч�ڲ������ڵ�ǰʱ�䣬���������룡");
			          document.all.idValidDate.focus();
					  		document.all.idValidDate.select();
				      	return false;
				   }
				}

				if(document.all.ownerType.options[document.all.ownerType.selectedIndex].text=="����")
				{
		             if(document.all.birthDay.value.trim().len()>0)
				     {
				       if(to_date(frm1100.birthDay)>=d)
				       {
					     		 rdShowMessageDialog("���������ڲ������ڵ�ǰʱ�䣬���������룡");
			             document.all.birthDay.focus();
					         document.all.birthDay.select();
				           return false;
				       }
					 }
				}else{
						 document.all.birthDay.v_type="";
		         if(document.all.yzrq.value.trim().len()>0)
				     {
				       if(to_date(frm1100.yzrq)<=d)
				       {
					     			rdShowMessageDialog("Ӫҵִ����Ч�ڲ������ڵ�ǰʱ�䣬���������룡");
			              document.all.yzrq.focus();
					     			document.all.yzrq.select();
				         		return false;
				       }
					 }
				}
				 
	     if(document.all.custPwd.value.trim().len()>0){
			     if(document.all.custPwd.value.length!=6){
		   				rdShowMessageDialog("�ͻ����볤������");
	            document.all.custPwd.focus();
		   				return false;
				 		}
			      if(checkPwd(document.frm1100.custPwd,document.frm1100.cfmPwd)==false){
				    	return false;
				  	}
		  	}
		  	
	      var t = null;
	      var i;
	      if(document.frm1100.newCust.checked == true){
	           document.frm1100.parentId.value = document.frm1100.custId.value;
	           sysNote = "�½���:" + document.frm1100.ownerType.value + ":�ͻ�ID[" + 
	           document.frm1100.custId.value + "]:�ϼ��ͻ�[" + 
	           document.frm1100.custId.value + "]";
	      }else{
	      		 sysNote = "���ϻ�:" + document.frm1100.ownerType.value + ":�ͻ�ID[" + 
	           document.frm1100.custId.value + "]:�ϼ��ͻ�[" + 
	           document.frm1100.parentId.value + "]";
	      }
	      document.frm1100.sysNote.value = sysNote;
				if(document.all.opNote.value.trim().len()==0){
	         document.all.opNote.value="����Ա<%=workNo%>"+"�Կͻ�"+document.all.custId.value.trim()+"("+document.all.ownerType.options[document.all.ownerType.selectedIndex].text+")���пͻ�����ҵ��"
				}
	      showPrtDlg("Detail","ȷʵҪ���е��������ӡ��","Yes");   
}

function chkValid()
{
     var d= (new Date().getFullYear().toString()+(((new Date().getMonth()+1).toString().length>=2)?(new Date().getMonth()+1).toString():("0"+(new Date().getMonth()+1)))+(((new Date().getDate()).toString().length>=2)?(new Date().getDate()):("0"+(new Date().getDate()))).toString());

	 if(frm1100.idValidDate.value.trim().len()>0)
	 {		 
        if(forDate(frm1100.idValidDate)==false) return false;

	    if(to_date(frm1100.idValidDate)<=d)
	    {
		  rdShowMessageDialog("֤����Ч�ڲ������ڵ�ǰʱ�䣬���������룡");
	      document.all.idValidDate.focus();
		  	document.all.idValidDate.select();
	      return false;
	    }
	}
}

/*** dujl add at 20090806 for R_HLJMob_cuisr_CRM_PD3_2009_0314@���ڹ淶�ͻ����������л��������зǷ��ַ�У������� ****/
function feifa(textName)
{
	if(textName.value != "")
	{
		if((textName.value.indexOf("~")) != -1 || (textName.value.indexOf("|")) != -1 || (textName.value.indexOf(";")) != -1)
		{
			rdShowMessageDialog("����������Ƿ��ַ������������룡");
			textName.value = "";
 	  		return;
		}
	}
}

function to_date(obj)
{
  var theTotalDate="";
  var one="";
  var flag="0123456789";
  for(i=0;i<obj.value.length;i++)
  { 
     one=obj.value.charAt(i);
     if(flag.indexOf(one)!=-1)
		 theTotalDate+=one;
  }
  return theTotalDate;
}
//-------------------------------------------------------
function printInfo(printType)
{
    var retInfo = "";
    if(printType == "Detail")
    {	//��ӡ�������
<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="workno"  routerValue="<%=workNo%>" id="printAccept"/>    	
        var getAcceptFlag = "<%=getAcceptFlag%>";
        if(getAcceptFlag == "failed")
        {	return "failed";	}
	    //retInfo = retInfo + "10|2|0|0|��ӡ��ˮ:  " + "<%=printAccept%>" + "|";
		
		//��ӡ�������
        retInfo+=frm1100.custId.value+"|";
		retInfo+='<%=new java.text.SimpleDateFormat("yyyy-MM-dd", Locale.getDefault()).format(new java.util.Date())%>'+"|";
		retInfo+= frm1100.custName.value+"|";
		//retInfo+=" |";
		retInfo+=frm1100.contactPhone.value+"|";
		retInfo+= frm1100.contactAddr.value+"|";
		retInfo+=frm1100.idIccid.value+"|";
		retInfo+=" "+"|";
		retInfo+= "�ͻ�������*|";

		retInfo+=document.all.sysNote.value+"|";
		retInfo+=document.all.opNote.value+"|";
        
		retInfo+=" |";

		//��������Ϣ(oneTok:12-15)
        retInfo+=document.all.assu_name.value+"|";
		retInfo+=document.all.assu_phone.value+"|";
		retInfo+=document.all.assu_idAddr.value+"|";
		retInfo+=document.all.assu_idIccid.value+"|";


	}  
    if(printType == "Bill")
    {	//��ӡ��Ʊ
	}
	return retInfo;	
}
//-----------------------------------------------------------
function showPrtDlg(printType,DlgMessage,submitCfm)
{ 
   with(document.all)
   {	
			if(frm1100.idValidDate.value =="")
			{
				frm1100.idValidDate.value="20500101";
			}
			if(frm1100.birthDay.value =="")
			{
				frm1100.birthDay.value="19000101";
			}
			var i;
			var obj = null;
			for(i=0;i<frm1100.length;i++)
			{
				 obj = frm1100.elements[i];
				if(obj.value == "")
				{
					frm1100.elements[i].value="unknow";
				}
			}
		
		   window.opener.document.all.str1.value=custId.value+"~<%=regionCode%>"+districtCode.value+"999"+"~"+custName.value+"~"+custPwd.value+"~"+custStatus.value+"~"+"00"+"~"+ownerType.value+"~"+custAddr.value+"~";
		   window.opener.document.all.str2.value=idType.value+"~"+idIccid.value+"~"+idAddr.value+"~"+idValidDate.value+"~";
		   window.opener.document.all.str3.value=contactPerson.value+"~"+contactPhone.value+"~"+contactAddr.value+"~"+contactPost.value+"~"+contactMAddr.value+"~"+contactFax.value+"~"+contactMail.value+"~";
		   window.opener.document.all.str4.value="<%=Department%>"+"~"+parentId.value+"~"+custSex.value+"~"+birthDay.value+"~"+professionId.value+"~"+vudyXl.value+"~"+custAh.value+"~"+custXg.value+"~";
		   window.opener.document.all.str5.value="1104"+"~"+"<%=workNo%>"+"~"+sysNote.value+"~"+opNote.value+"~"+ip_Addr.value+"~"+oriGrpNo.value+"~";
	
		   window.opener.document.all.idIccid.value=document.all.idIccid.value;
	      window.opener.document.all.custName.value=document.all.custName.value;
		   window.opener.document.all.idType.value=document.all.idType.options[document.all.idType.selectedIndex].text;
		   window.opener.document.all.custId.value=document.all.custId.value;
		   window.opener.document.all.custAddr.value=document.all.custAddr.value;
	 
    }
	 window.close();
}
//--------------------------------------
function checkPwd(obj1,obj2)
{
        //����һ����У��,����У��
        var pwd1 = obj1.value;
        var pwd2 = obj2.value;
        if(pwd1 != pwd2)
        {
                var message = "'����'��'Ч������'��һ�£����������룡";
                rdShowMessageDialog(message);
                if(obj1.type != "hidden")
                {   obj1.value = "";    }
                if(obj2.type != "hidden")
                {   obj2.value = "";    }
                obj1.focus();
                return false;
        }
				var iccid = document.frm1100.idIccid.value;
				var len = document.frm1100.idIccid.value.length;
				var iccid1 = iccid.substr(len-4,4);
				var pass = "00"+iccid1;
			   	if("<%=regionCode%>"=="09"){
					if(pwd1 == "000000"||pwd1 == "111111"||pwd1 == "222222"
				 	 ||pwd1 == "333333"||pwd1 == "444444"||pwd1 == "555555"
					 ||pwd1 == "666666"||pwd1 == "777777"||pwd1 == "888888"
				 	 ||pwd1 == "999999"||pwd1 == "123456")
			  		 {
			           		rdShowMessageDialog("������ڼ򵥣����������ã�");
					   		return false;
			   		 }
			   	}else{
			   	 	 if(pwd1 == "000000"||pwd1 == "001234"||pwd1 == pass)
			  		 {
			           		rdShowMessageDialog("������ڼ򵥣��뼰ʱ�޸ģ�");
					   		return false;
			   		 }
			   	}
			   	 
		    return true;
}
//-----------------------------------
function check_HidPwd(Pwd1,Pwd1Type,Pwd2,Pwd2Type)
{
	/*
  		Pwd1,Pwd2:����
  		wd1Type:����1�����ͣ�Pwd2Type������2������      show:���룻hid������
  	
	if(Pwd1.trim().len()==0)
	{
        rdShowMessageDialog("�ͻ����벻��Ϊ�գ�");
        frm1100.custPwd.focus();
		return false;
	}
    else 
	{
	   if(Pwd2.trim().len()==0)
	   {
         rdShowMessageDialog("ԭʼ�ͻ�����Ϊ�գ���˶����ݣ�");
         frm1100.custPwd.focus();
		 		 return false;
	   }
	}*/

    var checkPwd_Packet = new AJAXPacket("pubCheckPwd.jsp","���ڽ�������У�飬���Ժ�......");
    checkPwd_Packet.data.add("retType","checkPwd");
	checkPwd_Packet.data.add("Pwd1",Pwd1);
	checkPwd_Packet.data.add("Pwd1Type",Pwd1Type);
	checkPwd_Packet.data.add("Pwd2",Pwd2.trim());
	checkPwd_Packet.data.add("Pwd2Type",Pwd2Type);
	core.ajax.sendPacket(checkPwd_Packet);
	checkPwd_Packet=null;
	
	if("<%=regionCode%>"=="09"){
		if(pwd1 == "000000"||pwd1 == "111111"||pwd1 == "222222"
		 ||pwd1 == "333333"||pwd1 == "444444"||pwd1 == "555555"
		 ||pwd1 == "666666"||pwd1 == "777777"||pwd1 == "888888"
		 ||pwd1 == "999999"||pwd1 == "123456")
		{
			rdShowMessageDialog("������ڼ򵥣����޸ĺ��ٰ���ҵ��");
			return false;
		}
	}
			
}
//-----------------------------------------------------------
function getId()
{
    //�õ��ͻ�ID
        document.frm1100.custId.readonly = true;
        document.frm1100.custQuery.disabled = true;   
    	var getUserId_Packet = new AJAXPacket("f1100_getId.jsp","���ڻ�ÿͻ�ID�����Ժ�......");
    	getUserId_Packet.data.add("retType","ClientId");
        getUserId_Packet.data.add("region_code","<%=regionCode%>");
        getUserId_Packet.data.add("idType","0");
        getUserId_Packet.data.add("oldId","0");
        core.ajax.sendPacket(getUserId_Packet);
        getUserId_Packet=null;
}
//-----------------------------------------
function choiceSelWay()
{	
 	//ѡ��ͻ���Ϣ�Ĳ�ѯ��ʽ
	if(frm1100.parentId.value != "")
	{	//���ͻ�ID���в�ѯ
		getInfo_withId();	
		return true;
	}
	if(frm1100.parentIdidIccid.value != "")
	{	
 		getInfo_IccId();
		return true;
	}
	if(frm1100.parentName.value != "")
	{	
		getInfo_withName();
		return true;
	}
 	rdShowMessageDialog("�ͻ���Ϣ������ID��֤����������ƽ��в�ѯ��������������������Ϊ��ѯ������");
}
//------------------------------------------------------------------------
function getInfo_withId()
{
    //���ݿͻ�ID�õ������Ϣ
    if(document.frm1100.parentId.value == "")
    {
        rdShowMessageDialog("������ͻ�ID��");
        return false;
    }
	/**
	else
	{
	  if(document.all.parentId.value.trim().len()!=10)
	  {
         rdShowMessageDialog("�ͻ�ID��������");
         return false;
	  }
	}
	*/
    if(for0_9(frm1100.parentId) == false)
    {	
    	frm1100.parentId.value = "";
    	return false;	
    }
    var getIdPacket = new AJAXPacket("fpsb_rpc.jsp","���ڻ���ϼ��ͻ���Ϣ�����Ժ�......");
        var parentId = document.frm1100.parentId.value;
        getIdPacket.data.add("retType","getInfo_withID");
        getIdPacket.data.add("fieldNum","6");
        getIdPacket.data.add("sqlStr",parentId);
        core.ajax.sendPacket(getIdPacket);
        delete(getIdPacket); 
}   

//------------------------------------------------------------
function PubSimpSel(pageTitle,fieldName,sqlStr,selType,retQuence,retToField)
{
    /*
    ����1(pageTitle)����ѯҳ�����
    ����2(fieldName)�����������ƣ���'|'�ָ��Ĵ�
    ����3(sqlStr)��sql���
    ����4(selType)������'S' rediobutton 'M' checkbox
    ����5(retQuence)����������Ϣ������������� �������ʶ����'|'�ָ�����"3|0|2|3"��ʾ����3����0��2��3
    ����6(retToField))������ֵ����������,��'|'�ָ�
    */
    var path = "pubGetCustInfo.jsp";  //���벻��ʾ
    path = path + "?sqlStr=" + sqlStr + "&retQuence=" + retQuence;
    path = path + "&fieldName=" + fieldName + "&pageTitle=" + pageTitle;
    path = path + "&selType=" + selType;  
    /*
    var ret = window.open (path, "���д���", 
                "height=400, width=500,left=200, top=200,toolbar=no,menubar=no, scrollbars=yes, resizable=no, location=no, status=yes"); 
        ret.opener.bankCode.value = "1111111111";
        */      
    retInfo = window.showModalDialog(path,"","dialogWidth:45;dialogHeight:35;");
    clear_CustInfo();  
    if(typeof(retInfo)=="undefined")   
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
//-----------------------------------------------------
function custInfoQuery(pageTitle,fieldName,sqlStr,selType,retQuence,retToField)
{
    /*
    ����1(pageTitle)����ѯҳ�����
    ����2(fieldName)�����������ƣ���'|'�ָ��Ĵ�
    ����3(sqlStr)��sql���
    ����4(selType)������1 rediobutton 2 checkbox
    ����5(retQuence)����������Ϣ������������� �������ʶ����'|'�ָ�����"3|0|2|3"��ʾ����3����0��2��3
    ����6(retToField))������ֵ����������,��'|'�ָ�
    */
    var path = "psbgetCustInfo.jsp";   //����Ϊ*
    path = path + "?sqlStr=" + sqlStr + "&retQuence=" + retQuence;
    path = path + "&fieldName=" + fieldName + "&pageTitle=" + pageTitle;
    path = path + "&selType=" + selType;  

    var retInfo = window.showModalDialog(path,"","dialogWidth:70;dialogHeight:35;");
    if(typeof(retInfo) == "undefined")     
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
	rpc_chkX("parentIdType","parentIdidIccid","A");
}
//--------------------add by baixf 20080221 ��Ҫ039
function custInfoQueryJustSee(pageTitle,fieldName,sqlStr,selType,retQuence,retToField)
{
    /*
    ����1(pageTitle)����ѯҳ�����
    ����2(fieldName)�����������ƣ���'|'�ָ��Ĵ�
    ����3(sqlStr)��sql���
    ����4(selType)������1 rediobutton 2 checkbox
    ����5(retQuence)����������Ϣ������������� �������ʶ����'|'�ָ�����"3|0|2|3"��ʾ����3����0��2��3
    ����6(retToField))������ֵ����������,��'|'�ָ�
    */
    var path = "psbgetCustInfo2.jsp";   //����Ϊ*
    path = path + "?sqlStr=" + sqlStr + "&retQuence=" + retQuence;
    path = path + "&fieldName=" + fieldName + "&pageTitle=" + pageTitle;
    path = path + "&selType=" + selType;  

    var retInfo = window.showModalDialog(path,"","dialogWidth:60;dialogHeight:35;");
    if(typeof(retInfo) == "undefined")     
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
	rpc_chkX("parentIdType","parentIdidIccid","A");
}
//-------------------------------------------------
function getInfo_withName()
{ 
        ////���ݿͻ����Ƶõ������Ϣ
    if(document.frm1100.parentName.value == "")
    {
        rdShowMessageDialog("������ͻ����ƣ�");
        return false;
    }
    var pageTitle = "�ͻ���Ϣ��ѯ";
    var fieldName = "�ͻ�ID|�ͻ�����|����ʱ��|֤������|֤������|�ͻ���ַ|��������|�ͻ�����|";
    var sqlStr = "CUST_NAME="+frm1100.parentName.value;
    var selType = "S";    //'S'��ѡ��'M'��ѡ
    var retQuence = "7|0|1|3|4|5|6|7|";
    var retToField = "in0|in4|in3|in2|in5|in6|in1|"; 
    custInfoQuery(pageTitle,fieldName,sqlStr,selType,retQuence,retToField)                           
}

//-------------------------------------------------
function getInfo_IccId()
{ 
    //���ݿͻ�֤������õ������Ϣ
    if(document.frm1100.parentIdidIccid.value.trim().len() == 0)
    {
        rdShowMessageDialog("������ͻ�֤�����룡");
        return false;
    }
	else if(document.frm1100.parentIdidIccid.value.trim().len() < 5)
	{
        rdShowMessageDialog("֤�����볤������������λ����");
        return false;
	}

    var pageTitle = "�ͻ���Ϣ��ѯ";
    var fieldName = "�ͻ�ID|�ͻ�����|����ʱ��|֤������|֤������|�ͻ���ַ|��������|�ͻ�����|";
    var sqlStr = "ID_ICCID="+document.frm1100.parentIdidIccid.value; 
    var selType = "S";    //'S'��ѡ��'M'��ѡ
    var retQuence = "7|0|1|3|4|5|6|7|";
    var retToField = "in0|in4|in3|in2|in5|in6|in1|";
    custInfoQuery(pageTitle,fieldName,sqlStr,selType,retQuence,retToField);                    
}
//---------------add by baixf 20080221 ����039 �����ͻ�ʱ���Բ�ѯ¼������֤��ϵͳ�е�ʹ����Ϣ��
function getInfo_IccId_JustSee()
{ 

		if(document.all.idType.options[document.all.idType.selectedIndex].text.trim()=="���֤"){
			if(!forIdCard(document.all.idIccid)){
		   				return false;
			}
		}else{
			hiddenTip(document.all.idIccid);
		}
		
    //���ݿͻ�֤������õ������Ϣ
    if(document.frm1100.idIccid.value.trim().len() == 0)
    {
        rdShowMessageDialog("������ͻ�֤�����룡");
        return false;
    }else if(document.frm1100.idIccid.value.trim().len() < 5){
        rdShowMessageDialog("֤�����볤������������λ����");
        return false;
	  }

    var pageTitle = "�ͻ���Ϣ��ѯ";
    var fieldName = "�������|����ʱ��|֤������|֤������|������|״̬|";
    var sqlStr = "ID_ICCID="+document.frm1100.idIccid.value; 
    var selType = "S";    //'S'��ѡ��'M'��ѡ
    var retQuence = "7|0|1|3|4|5|6|7|";
    var retToField = "in0|in4|in3|in2|in5|in6|in1|";
    custInfoQueryJustSee(pageTitle,fieldName,sqlStr,selType,retQuence,retToField);                    
}

function get_inPara()
{
    //��֯���˵Ĳ���
    var inPara_Str = "";    
        inPara_Str = inPara_Str + document.frm1100.temp_custId.value + "|"; 
        inPara_Str = inPara_Str + document.frm1100.regionCode.value + "|" + document.frm1100.districtCode.value + "|";
        inPara_Str = inPara_Str + document.frm1100.custName.value + "|"; 
        inPara_Str = inPara_Str + document.frm1100.custPwd.value + "|"; 
        inPara_Str = inPara_Str + document.frm1100.custStatus.value + "|"; 
        inPara_Str = inPara_Str + document.frm1100.custGrade.value + "|"; 
        inPara_Str = inPara_Str + document.frm1100.ownerType.value + "|"; 
        inPara_Str = inPara_Str + document.frm1100.custAddr.value + "|";
        var tempStr = document.frm1100.idType.value; 
        inPara_Str = inPara_Str + tempStr.substring(0,tempStr.indexOf("|")) + "|"; 
        inPara_Str = inPara_Str + document.frm1100.idIccid.value + "|"; 
        inPara_Str = inPara_Str + document.frm1100.idAddr.value + "|"; 
        inPara_Str = inPara_Str + document.frm1100.idValidDate.value + "|"; 
        inPara_Str = inPara_Str + document.frm1100.contactPerson.value + "|"; 
        inPara_Str = inPara_Str + document.frm1100.contactPhone.value + "|"; 
        inPara_Str = inPara_Str + document.frm1100.contactAddr.value + "|"; 
        inPara_Str = inPara_Str + document.frm1100.contactPost.value + "|"; 
        inPara_Str = inPara_Str + document.frm1100.contactMAddr.value + "|"; 
        inPara_Str = inPara_Str + document.frm1100.contactFax.value + "|"; 
        inPara_Str = inPara_Str + document.frm1100.contactMail.value + "|"; 
        inPara_Str = inPara_Str + document.frm1100.unitCode.value + "|"; //��������
        inPara_Str = inPara_Str + document.frm1100.parentId.value + "|"; 
        inPara_Str = inPara_Str + document.frm1100.custSex.value + "|";  //�ͻ��Ա�
        inPara_Str = inPara_Str + document.frm1100.birthDay.value + "|"; 
        inPara_Str = inPara_Str + document.frm1100.professionId.value + "|"; 
        inPara_Str = inPara_Str + document.frm1100.vudyXl.value + "|"; //ѧ��
        inPara_Str = inPara_Str + document.frm1100.custAh.value + "|"; //�ͻ����� 
        inPara_Str = inPara_Str + document.frm1100.custXg.value + "|"; //�ͻ�ϰ��
        inPara_Str = inPara_Str + document.frm1100.unitXz.value + "|"; //��λ����
        inPara_Str = inPara_Str + document.frm1100.yzlx.value + "|"; //ִ������
        inPara_Str = inPara_Str + document.frm1100.yzhm.value + "|"; //ִ�պ���
        inPara_Str = inPara_Str + document.frm1100.yzrq.value + "|"; //ִ����Ч��
        inPara_Str = inPara_Str + document.frm1100.frdm.value + "|"; //���˴���
        inPara_Str = inPara_Str + document.frm1100.groupCharacter.value + "|";//Ⱥ����Ϣ
        inPara_Str = inPara_Str + "1100" + "|";
        inPara_Str = inPara_Str + document.frm1100.workno.value + "|";  
        inPara_Str = inPara_Str + document.frm1100.sysNote.value + "|";
        inPara_Str = inPara_Str + document.frm1100.opNote.value + "|";  
        document.frm1100.inParaStr.value = inPara_Str;
}

//---------------------------------------------------
function jspReset()
{
    //ҳ��ؼ���ʼ��    
    var obj = null;
    var t = null;
        var i;
    for (i=0;i<document.frm1100.length;i++)
    {    
                obj = document.frm1100.elements[i];                                              
                packUp(obj); 
            obj.disabled = false;
    }
    document.frm1100.commit.disabled = "none"; 
} 
//----------------------------------------------------       
function jspCommit()
{
         //ҳ���ύ
         document.frm1100.commit.disabled = "none";
         action="f1100_2.jsp"
         frm1100.submit();   //����������������ύ
}
//------------------------------------------------
function change_ConPerson()
{   //��ϵ��������ͻ����Ƹ������ı�
	frm1100.contactPerson.value = frm1100.custName.value;
}
function change_ConAddr()
{   //��ϵ��������ͻ����Ƹ������ı�
	frm1100.contactAddr.value = frm1100.custAddr.value;
	frm1100.contactMAddr.value = frm1100.custAddr.value;
}
//------------------------------------------------


//��֤�Ƿ��Ǻ�����
function rpc_chkX(x_type,x_no,chk_kind)
{
  var obj_type=document.all(x_type);
  var obj_no=document.all(x_no);
  var idname="";

  if(obj_type.type=="text")
  {
    idname=obj_type.value.trim();
  }else if(obj_type.type=="select-one"){
    idname=obj_type.options[obj_type.selectedIndex].text.trim();  
  }

  if(obj_no.value.trim().len()>0){
    if(obj_no.value.trim().len()<5){
      rdShowMessageDialog("֤�����볤����������5λ����");
	  	obj_no.focus();
  	  return false;
		}else{
	      if(idname=="���֤"){
			      if(!forIdCard(obj_no)){
		   				return false;
						}
		   }else{
		   		hiddenTip(obj_no);
		   }
		}
  }else{
  	return;
  } 

  var x_idType = getX_idno(idname);
  var myPacket = new AJAXPacket("../../npage/innet/chkX.jsp","������֤��������Ϣ�����Ժ�......");
  myPacket.data.add("retType","chkX");
  myPacket.data.add("retObj",x_no);
  myPacket.data.add("x_idType",x_idType);
  myPacket.data.add("x_idNo",obj_no.value);
  myPacket.data.add("x_chkKind",chk_kind);
  core.ajax.sendPacket(myPacket);
  myPacket=null;
}

//����֤�����Ʒ����ʵ�������
function getX_idno(xx)
{
  if(xx==null) return "0";
  
  if(xx=="���֤") return "0";
  else if(xx=="����֤") return "1";
  else if(xx=="��ʻ֤") return "2";
  else if(xx=="����֤") return "4";
  else if(xx=="ѧ��֤") return "5";
  else if(xx=="��λ") return "6";
  else if(xx=="У԰") return "7";
  else if(xx=="Ӫҵִ��") return "8";
  else return "0";
}
 
		
function chcek_pic()
{
	
var pic_path = document.all.filep.value;
	
var d_num = pic_path.indexOf("\.");
var file_type = pic_path.substring(d_num+1,pic_path.length);
//�ж��Ƿ�Ϊjpg���� //�����豸����ͼƬ�̶�Ϊjpg����
if(file_type.toUpperCase()!="JPG")
{ 
		rdShowMessageDialog("��ѡ��jpg����ͼ���ļ�");
		document.all.up_flag.value=3;
		document.all.print.disabled=true;
		resetfilp();
	return ;
	}

	var pic_path_flag= document.all.pic_name.value;
	
	if(pic_path_flag=="")
	{
	rdShowMessageDialog("����ɨ����ȡ֤����Ϣ");
	document.all.up_flag.value=4;
	document.all.print.disabled=true;
	resetfilp();
	return;
}
	else
		{
			if(pic_path!=pic_path_flag)
			{
			rdShowMessageDialog("��ѡ�����һ��ɨ����ȡ֤�������ɵ�֤��ͼ���ļ�"+pic_path_flag);
			document.all.up_flag.value=5;
			document.all.print.disabled=true;
			resetfilp();
		return;
		}
		else{
			document.all.up_flag.value=2;
			}
			}
			
	}
	
	
	function uploadpic(){
	if(document.all.filep.value==""){
		rdShowMessageDialog("��ѡ��Ҫ�ϴ���ͼƬ",0);
		return;
		}
	if(document.all.but_flag.value=="0"){
		rdShowMessageDialog("����ɨ����ȡͼƬ",0);
		return;
		}
	frm1100.target="upload_frame"; 
	
	var actionstr ="f1100_1upp.jsp?custId="+document.frm1100.custId.value+
									"&regionCode="+document.frm1100.regionCode.value+
									"&filep_j="+document.frm1100.filep.value+
									"&card_flag="+document.all.card_flag.value+ 
									"&but_flag="+document.all.but_flag.value+
									"&idSexH="+document.all.idSexH.value+
									"&custName="+document.all.custName.value+
									"&idAddrH="+document.all.idAddrH.value+
									"&birthDayH="+document.all.birthDayH.value+
									"&custId="+document.all.custId.value+
									"&idIccid="+document.all.idIccid.value+
									"&workno="+document.all.workno.value+
									"&upflag=1";
									
									
	frm1100.action = actionstr; 
	document.all.upbut_flag.value="1";
	frm1100.submit()
	resetfilp();
	}
	
	function resetfilp(){
		document.getElementById("filep").outerHTML = document.getElementById("filep").outerHTML;
		}	
		
function changeCardAddr(obj){
	if(document.all.ownerType.value=="01"){
		document.all.custAddr.value=obj.value;
		document.all.contactAddr.value=obj.value;
		document.all.contactMAddr.value=obj.value;
	}
}
</SCRIPT>


<body onload="init()">
<FORM method=post name="frm1100" action="f1100_2.jsp"  onKeyUp="chgFocus(frm1100)"   ENCTYPE="multipart/form-data" >

			<%@ include file="/npage/include/header_pop.jsp" %>     	
							<div class="title">
								<div id="title_zi">��ѡ���������</div>
							</div>
              <table cellspacing="0">
                <tbody> 
                <tr> 
                  <td width="16%" class="blue">��������</td>
                  <td class="blue"> 
                    <input name="newCust" onClick="check_newCust()" type="radio" value="new" checked index="2">
                    �½��� 
                    <input type="radio" name="oldCust" onClick="check_oldCust()" value="old" index="3">
                    ���ϻ� </td>
                </tr>
                </tbody> 
              </table>                                
              <table id=tbs9 cellspacing="0" style="display:none">
                <tbody> 
                <tr> 
                  <td width="16%" class="blue">�ϼ��ͻ�֤������</td>
                  <td width="34%"> 
                    <input id=in2 name=parentIdidIccid maxlength="20" onKeyUp="if(event.keyCode==13)getInfo_IccId();" index="4">
                    <font class="orange">*</font> 
                    <input name=IDQuery type=button class="b_text" style="cursor:hand" onClick="choiceSelWay()" id="custIdQuery" value=��Ϣ��ѯ>
                  </td>
                  <td width="16%" align="left" class="blue">�ϼ��ͻ�����</td>
                  <td width="34%"> 
					    			<jsp:include page="/npage/common/pwd_1.jsp">
		                <jsp:param name="width1" value="16%"  />
		                <jsp:param name="width2" value="34%"  />
		                <jsp:param name="pname" value="parentPwd"  />
		                <jsp:param name="pwd" value="12345"  />
	 	                </jsp:include>
                    <input name=custQuery2 type=button class="b_text" onClick="change_custPwd();" style="cursor:hand" id="accountIdQuery" value=У��>
                  </td>
                </tr>
                <tr> 
                  <td class="blue">�ϼ��ͻ�����</td>
                  <td> 
                    <input id=in4 name=parentName onKeyUp="if(event.keyCode==13)getInfo_withName();" size=35  maxlength="60">
                    <font class="orange">*</font> 
                  </td>
                  <td class="blue">�ϼ��ͻ�֤������</td>
                  <td> 
                    <input id=in3 name=parentIdType readonly>
                  </td>
                </tr>
                <tr> 
                  <td height="17" class="blue">�ϼ��ͻ�ID</td>
                  <td height="17"> 
                    <input id="in0" name="parentId" v_type="0_9" v_must=1 v_minlength=10 v_maxlength=14  maxlength="14" onKeyUp="if(event.keyCode==13)getInfo_withId();" onblur="checkElement(this)">
                    <font class="orange">*</font> 
                  </td>
                  <td height="17" class="blue">�ϼ��ͻ���ַ</td>
                  <td height="17"> 
                    <input id=in5 size=35 name=parentAddr   readonly maxlength="60">
                  </td>
                </tr>
                </tbody> 
              </table>
              <table cellSpacing="0">
                <tbody> 
                <tr> 
                  <td width=16% class="blue">�ͻ����</td>
                  <td width=34%> 
                    <select align="left" name=ownerType onchange="change()" width=50 index="6">
			       <%
			                String sqlStr ="select TYPE_CODE,TYPE_NAME from sCustTypeCode Order By TYPE_CODE";
			       %>
			       					<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>"  retcode="retCode1" retmsg="retMsg1" outnum="2">
											<wtc:sql><%=sqlStr%></wtc:sql>
											</wtc:pubselect>
											<wtc:array id="sVerifyTypeArr" scope="end" />
			       <%
											 for(int i=0;i<sVerifyTypeArr.length;i++){
								         if("02".equals(sVerifyTypeArr[i][0])||"04".equals(sVerifyTypeArr[i][0])) {
								            continue;
								         }
								         out.println("<option class='button' value='" + sVerifyTypeArr[i][0] + "'>" + sVerifyTypeArr[i][1] + "</option>");
											 }
							%>
                    </select>
                  </td>
                  <td width=16% class="blue">�ͻ�ID</td>
                  <td width="34%"> 
                    <input name=custId v_type="0_9" v_must=1 v_name="�ͻ�ID" maxlength="12" readonly>
                    <font class="orange">*</font> 
                    <input name=custQuery type=button class="b_text" onmouseup="getId();" onkeyup="if(event.keyCode==13)getId();" style="cursor:hand" id="accountIdQuery" value=��� index="7">
                  </td>
                </tr>
                <tr> 
                  <td class="blue">�ͻ���������</td>
                  <td> 
                    <select align="left" name=districtCode width=50 index="8">
                    	<wtc:qoption name="sPubSelect" outnum="2">
											<wtc:sql>select trim(DISTRICT_CODE),DISTRICT_NAME from  SDISCODE Where region_code='<%=regionCode%>' order by DISTRICT_CODE</wtc:sql>
											</wtc:qoption>
                    </select>
                  </td>
                  <td class="blue">�ͻ�����</td>
                  <td> 
                    <input name=custName v_must=1 v_maxlength=60 v_type="string" v_name="�ͻ�����" onchange="change_ConPerson()"  maxlength="60" size=30 index="9" onkeyup="feifa(this);" onblur="checkElement(this)">
                    <font class="orange">*</font> 
                  </td>
                </tr>
                <tr> 
                  <td width=16% class="blue">֤������</td>
                  <td width=34%> 
                    <select align="left" name=idType onChange="change_idType()" width=50 index="10">
                    	<wtc:qoption name="sPubSelect" outnum="2">
											<wtc:sql>select trim(ID_TYPE), ID_NAME from sIdType order by id_type</wtc:sql>
											</wtc:qoption>
                    </select>
                  </td>
                  <td width=16% class="blue">֤������</td>
                  <td width=34%> 
                    <input name=idIccid v_must=1 v_minlength=5 v_maxlength=20 v_type="string" v_name="֤������" onChange="change_idType()" maxlength="18"  index="11" onblur="if(checkElement(this));feifa(this);{rpc_chkX('idType','idIccid','A')}" >
                    <font class="orange">*</font> 
                    <input name=IDQueryJustSee type=button class="b_text" style="cursor:hand" onClick="getInfo_IccId_JustSee()" id="custIdQueryJustSee" value=��Ϣ��ѯ >
                  </td>
                </tr>
                
	 <TR id="card_id_type"><!-- hejwa�������֤ɨ�衢��ȡ 2009-8-13 15:06-->
	    
      <td colspan=2 align=center>
  			<input type="button" name="read_idCard_one" class="b_text"   value="ɨ��һ�����֤" onClick="RecogNewIDOnly_one()" disabled>
				<input type="button" name="read_idCard_two" class="b_text"   value="ɨ��������֤" onClick="RecogNewIDOnly_two()"disabled>
				<input type="button" name="scan_idCard_two" class="b_text"   value="����" onClick="Idcard()" disabled>
  			
				</td>
  <td  class="blue">
      	֤����Ƭ�ϴ�
      </td>
      <td>
      	
				 <input type="file" name="filep" id="filep" onchange="chcek_pic();" >    &nbsp;
				 
				 <iframe name="upload_frame" id="upload_frame" style="display:none"></iframe>
				
				<input type="hidden" name="idSexH" value="1">
  			<input type="hidden" name="birthDayH" value="20090625">
  			<input type="hidden" name="idAddrH" value="������">
  			
				 <input type="button" name="uploadpic_b" class="b_text"   value="�ϴ���Ƭ" onClick="uploadpic()"  disabled>
      	
      	</td>
     </tr>
                <tr> 
                  <td class="blue">֤����ַ</td>
                  <td> 
                    <input name=idAddr v_must=1 v_type="string" maxlength="60" v_maxlength=60 size=35 index="12" onblur="if(checkElement(this)){document.all.custAddr.value=this.value;document.all.contactAddr.value=this.value;document.all.contactMAddr.value=this.value;}">
                    <font class="orange">*</font> </td>
                  <td class="blue">֤����Ч��</td>
                  <td> 
                    <input name=idValidDate v_must=0 v_maxlength=8 v_type="date"  maxlength=8 size="8" index="13" onblur="if(checkElement(this)){chkValid();}"> 
                  </td>
                </tr>
								<tr id ="divPassword" style="display:;"> 
								   	<jsp:include page="/npage/common/pwd_3.jsp">
									  <jsp:param name="width1" value="16%"  />
									  <jsp:param name="width2" value="34%"  />
									  <jsp:param name="pname" value="custPwd"  />
									  <jsp:param name="pcname" value="cfmPwd"  />
								   	</jsp:include>
			    		</div>
                <tr> 
                  <td class="blue">�ͻ�״̬</td>
                  <td colspan="3"> 
                    <select align="left" name=custStatus width=50 index="16">
	                    	<wtc:qoption name="sPubSelect" outnum="2">
												<wtc:sql>select trim(STATUS_CODE),STATUS_NAME from sCustStatusCode order by STATUS_CODE</wtc:sql>
												</wtc:qoption>
                    </select>
                    <select  align="left" name=custGrade width=50 index="17" style="display:none">
	                    	<wtc:qoption name="sPubSelect" outnum="2">
												<wtc:sql>select trim(OWNER_CODE), TYPE_NAME from sCustGradeCode where REGION_CODE ='<%=regionCode%>' order by OWNER_CODE</wtc:sql>
												</wtc:qoption>
                    </select>
                  </td>
                </tr>
                <tr> 
                  <td class="blue">�ͻ���ַ</td>
                  <td colspan="3"> 
                    <input name=custAddr v_type="string" v_must=0 v_maxlength=60  onchange="change_ConAddr()" maxlength="60" size=35 index="18">
                  </td>
                </tr>
                <tr> 
                  <td class="blue">��ϵ������</td>
                  <td> 
                    <input name=contactPerson v_must=0 v_type="string"  maxlength="20" size=20 index="19" v_maxlength="20">                    
                  </td>
                  <td class="blue">��ϵ�˵绰</td>
                  <td> 
                    <input name=contactPhone v_must=1 v_type="phone"  maxlength="20"  index="20" size="20" onblur="checkElement(this)">
                    <font class="orange">*</font> 
                  </td>
                </tr>
                <tr> 
                  <td class="blue">��ϵ�˵�ַ</td>
                  <td> 
                    <input name=contactAddr  v_must=1 v_type="string" maxlength="60" v_maxlength=60 size=35 index="21" onblur="if(checkElement(this)){document.all.contactMAddr.value=this.value;}">
                    <font class="orange">*</font> </td>
                  <td class="blue">��ϵ���ʱ�</td>
                  <td> 
                    <input name=contactPost v_must=0 v_type="zip"  maxlength="6"  index="22" size="20" onblur="checkElement(this)">                    
                  </td>
                </tr>
                <tr> 
                  <td class="blue">��ϵ�˴���</td>
                  <td> 
                    <input name=contactFax v_must=0 v_type="phone"  maxlength="20"  index="23" size="20" onblur="checkElement(this)">
                  </td>
                  <td class="blue">��ϵ��E_MAIL</td>
                  <td> 
                    <input name=contactMail v_must=0 v_type="email" maxlength="30" size=30 index="24" onblur="checkElement(this)">
                  </td>
                </tr>
                <tr> 
                  <td class="blue">��ϵ��ͨѶ��ַ</td>
                  <td colspan="3"> 
                    <input name=contactMAddr v_must=1 v_maxlenth=60 v_type="string"  maxlength="60" size=35 index="25" onblur="checkElement(this)">
                    <font class="orange">*</font> 
                  </td>
                </tr>
                </tbody> 
              </table> 
                                        
              <table id=tb0 cellSpacing="0">
                <tbody> 
                <tr> 
                  <td width=16% class="blue">�ͻ��Ա�</td>
                  <td width=34%> 
                    <select align="left" name=custSex width=50 index="26">
	                    	<wtc:qoption name="sPubSelect" outnum="2">
												<wtc:sql>select trim(SEX_CODE), SEX_NAME from ssexcode order by SEX_CODE</wtc:sql>
												</wtc:qoption>                    	
                    </select>
                  </td>
                  <td width=16% class="blue">��������</td>
                  <td width="34%"> 
                    <input name=birthDay maxlength=8 index="27"  v_must=0 v_maxlength=8 v_type="date"  size="8" onblur="checkElement(this)"> 
                  </td>
                </tr>
                <tr> 
                  <td class="blue">ְҵ���</td>
                  <td> 
                    <select align="left" name=professionId width=50 index="28">
                    	<wtc:qoption name="sPubSelect" outnum="2">
											<wtc:sql>select trim(PROFESSION_ID), PROFESSION_NAME from sprofessionid order by PROFESSION_ID DESC</wtc:sql>
											</wtc:qoption>                    	
                    </select>
                  </td>
                  <td class="blue">ѧ��</td>
                  <td> 
                    <select align="left" name=vudyXl width=50 index="29">
                    	<wtc:qoption name="sPubSelect" outnum="2">
											<wtc:sql>select trim(WORK_CODE), TYPE_NAME from SWORKCODE Where region_code ='<%=regionCode%>' order by work_code DESC</wtc:sql>
											</wtc:qoption>                     	
                    </select>
                  </td>
                </tr>
                <tr> 
                  <td class="blue">�ͻ�����</td>
                  <td> 
                    <input name=custAh v_must=0 maxlength="20"  index="30" size="20">
                  </td>
                  <td class="blue">�ͻ�ϰ��</td>
                  <td> 
                    <input name=custXg v_must=0 maxlength="20"  index="31">
                  </td>
                </tr>
                </tbody> 
              </table>                                
        
              <table id=tb1 cellSpacing="0" style="display:none">
                <tbody> 
                <tr> 
                  <td width=16% class="blue">��λ����</td>
                  <td width=34%> 
                    <select align="left" name=unitXz width=50 index="32">
                    	<wtc:qoption name="sPubSelect" outnum="2">
											<wtc:sql>select trim(TYPE_CODE), TYPE_NAME from sunittype order by TYPE_CODE</wtc:sql>
											</wtc:qoption>                    	
                    </select>
                  </td>
                  <td width=16% class="blue">Ӫҵִ������</td>
                  <td width=34%> 
                    <select align="left" name=yzlx width=50 index="33">
                    	<wtc:qoption name="sPubSelect" outnum="2">
											<wtc:sql>select trim(LINCENT_TYPE), TYPE_NAME from slicencetype order by LINCENT_TYPE</wtc:sql>
											</wtc:qoption> 
                    </select>
                  </td>
                </tr>
                <tr> 
                  <td class="blue">Ӫҵִ�պ���</td>
                  <td> 
                    <input name=yzhm maxlength="20"  index="34">
                  </td>
                  <td class="blue">Ӫҵִ����Ч��</td>
                  <td> 
                    <input name=yzrq  index="35" v_must=0 v_maxlength=8 v_type="date" maxlength=8 size="8" onblur="checkElement(this)">
                  </td>
                </tr>
                <tr> 
                  <td class="blue">���˴���</td>
                  <td COLSPAN="3"> 
                    <input name=frdm maxlength="20"  index="36">
                  </td>
                </tr>
                </tbody> 
              </table>
			     		<table cellspacing="0" style="display:none">
                <tr> 
							     <td width=16% class="blue">ԭ���ź�</td>
			             <td width=84%>
			             		<input name=oriGrpNo maxlength="10"  index="37" v_must=0 v_maxlength=10 v_type=0_9 v_name="ԭ���ź�">
								   </td>
							   </tr>				
							  </table>
              <table cellSpacing="0">
                <tbody> 
                <tr style="display:none"> 
                  <td width=16% class="blue">ϵͳ��ע</td>
                  <td> 
                    <input name=sysNote size=60 readonly maxlength="30">
                  </td>
                </tr>
                <tr> 
                  <td width="16%" class="blue">�û���ע</td>
                  <td> 
                    <input name=opNote size=60 maxlength="30" index="38"  v_must=0 v_maxlength=60 v_type="string" onblur="checkElement(this)">
                  </td>
                </tr>
                </tbody> 
              </table>   
                           
			        <table cellspacing="0">
			          <tbody>
			            <tr> 
				            <td id="footer"> 
				              <input class="b_foot" name=print  onmouseup="printCommit()" onkeyup="if(event.keyCode==13)printCommit()"  type=button value=ȷ��  index="39" >
							        <input class="b_foot" name=reset type=button  onclick="frm1100.action='f1100_1c.jsp';frm1100.submit();" value=��� index="40">
							        <input class="b_foot" name=back type=button onclick="window.close()" value=�ر� index="41">
				              <input class="b_foot" type="reset" name="Reset" value="Reset" style="display:none">
				            </td>
			            </tr>
			          </tbody>
			        </table>
 					<%@ include file="/npage/include/footer_pop.jsp" %>
<!--/wl:cache-->
  <input type="hidden" name="ReqPageName" value="f1100_1">
  <input type="hidden" name="workno" value=<%=workNo%>>
  <input type="hidden" name="regionCode" value=<%=regionCode%>> 
  <input type="hidden" name="unitCode" value=<%=Department%>>
  <input type="hidden" id=in6 name="belongCode" value=<%=belongCode%>>  
  <input type="hidden" id=in1 name="hidPwd" v_name="ԭʼ����">
  <input type="hidden" name="hidCustPwd">  			<!--���ܺ�Ŀͻ�����-->
  <input type="hidden" name="temp_custId">
  <input type="hidden" name="ip_Addr" value=<%=ip_Addr%>>
  <input type="hidden" name="inParaStr" >
  <input type="hidden" name="checkPwd_Flag" value="false">		<!--����У���־-->
  
  <input type="hidden" name="regionCodeFlg" value=<%=regionCode%>>
  <input type="hidden" name="assu_name" value="">
  <input type="hidden" name="assu_phone" value="">
  <input type="hidden" name="assu_idAddr" value="">
  <input type="hidden" name="assu_idIccid" value="">
  <input type="hidden" name="assu_conAddr" value="">
  <input type="hidden" name="assu_idType" value="">
  <input type="hidden" name="card_flag" value="">  <!--���֤������־-->
  <input type="hidden" name="pa_flag" value="">  <!--֤����־-->
  <input type="hidden" name="m_flag" value="">   <!--ɨ����߶�ȡ��־������ȷ���ϴ�ͼƬʱ���ͼƬ��-->
  <input type="hidden" name="sf_flag" value="">   <!--ɨ���Ƿ�ɹ���־-->
  <input type="hidden" name="pic_name" value="">   <!--��ʶ�ϴ��ļ�������-->
	<input type="hidden" name="up_flag" value="0">
	<input type="hidden" name="but_flag" value="0"> <!--��ť�����־-->
	<input type="hidden" name="upbut_flag" value="0"> <!--�ϴ���ť�����־-->
   <jsp:include page="/npage/common/pwd_comm.jsp"/>
</form>
</body>
<%@ include file="interface_providerc.jsp" %>   
</html>

 <%
	/********************
	 version v2.0
	������: si-tech
	update:anln@2009-01-15 ҳ�����,�޸���ʽ
	********************/
%> 

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="java.text.*"%>

<%
	    ArrayList arrSession = (ArrayList)session.getAttribute("allArr");
	    String[][] baseInfoSession = (String[][])arrSession.get(0);
	    String[][] otherInfoSession = (String[][])arrSession.get(2);
	    
	    String opCode = "3212";	
	    String opName = "����ɾ�����ų�Ա";	//header.jsp��Ҫ�Ĳ���   
	
	    String loginNo=(String)session.getAttribute("workNo");    //���� 
            String loginName =(String)session.getAttribute("workName");//��������  
	    String orgCode = (String)session.getAttribute("orgCode");                        
            String regionCode = (String)session.getAttribute("regCode");  
	    String ip_Addr = request.getRemoteAddr();
	    String  GroupId = (String)session.getAttribute("groupId");       
            String  OrgId = (String)session.getAttribute("orgId");  	    
	    String regionName = otherInfoSession[0][5];
	    
            /*int recordNum = 0;       
        
            SPubCallSvrImpl callView = new SPubCallSvrImpl();

    	    int	LISTROWS=16;*/
			
	    //���й���Ȩ�޼���
%>
<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="region" routerValue="<%=regionCode%>"  id="loginAccept" /> 
<%
	List al = null;

	int  isGetDataFlag = 1;	//0����ȷ,��������. add by yl.
	String errorMsg ="";
	String tmpStr="";

	
	StringBuffer  insql = new StringBuffer();
	
dataLabel:
	while(1==1){	

			
	
	isGetDataFlag = 0;
 break;
 }	


	 errorMsg = "ȡ���ݴ���"+Integer.toString(isGetDataFlag);	    
	 //System.out.println(errorMsg);
%>

<%if( isGetDataFlag != 0 ){%>
<script language="JavaScript">
<!--
	rdShowMessageDialog("<%=errorMsg%>");
	window.close();
	window.opener.focus();
//-->
</script>
<%}%>


<html>
	<head>
		<title>����ɾ�����ų�Ա</title>
<script language="JavaScript">
<!--
	//����Ӧ��ȫ�ֵı���
	var SUCC_CODE	= "0";   		//�Լ�Ӧ�ó�����
	var ERROR_CODE  = "1";			//�Լ�Ӧ�ó�����
	var YE_SUCC_CODE = "0000";		//����Ӫҵϵͳ������޸�
	var dynTbIndex=1;				//���ڶ�̬�����ݵ�����λ��,��ʼֵΪ1.���Ǳ�ͷ
	
	var oprType_Add = "a";
    var oprType_Upd = "u";
    var oprType_Del = "d";
    var oprType_Qry = "q";
    
    var TOKEN="|";

            
    	//core.loadUnit("debug");
	//core.loadUnit("rpccore"); 
	onload=function()
	{		
		init();
		//core.rpc.onreceive = doProcess;	
	}

	function reset_globalVar()
	{
	  dynTbIndex=1;							
	}
	
	function init()
	{	
		//����ѯȥ����style.display="none"; by yl.2004-2-10.
		document.frm.GRPIDQRY.style.display = "none";
		document.frm.GRPNAME.style.display = "none";
		document.frm.addNoQry.style.display = "none";
			
		document.all.addRecordNum.value = document.all.dyntb.rows.length-2;
		
	}

	function readSubStr(srcStr,token,msg)
	{
		var retInfo="";
	 	var chPos=0;
	 	var valueStr="";
		retInfo = srcStr;	
		chPos = retInfo.indexOf(token);

		while(chPos > -1)
		{	
			valueStr = retInfo.substring(0,chPos);
			doBackCheck(valueStr,msg);
			//alert("|"+valueStr+"|");
	        retInfo = retInfo.substring(chPos + 1);
	        chPos = retInfo.indexOf(token);
	        if(!(chPos > -1)) 
	        	break;	 
	    }	
	    if( retInfo != "")
	    {
			//alert("retInfo="+retInfo+"|");
			valueStr = retInfo;
			doBackCheck(valueStr,msg);
		}
		 
	}
			
	//---------1------RPC������------------------
	function doProcess(packet)
	{
		//ʹ��RPC��ʱ��,��������������Ϊ��׼ʹ��.
		error_code = packet.data.findValueByName("errorCode");
		error_msg =  packet.data.findValueByName("errorMsg");
		verifyType = packet.data.findValueByName("verifyType");
		var backArrMsg = packet.data.findValueByName("backArrMsg");		
		var backArrMsg1 = packet.data.findValueByName("backArrMsg1");
		
		self.status="";

		if(verifyType=="confirm")
		{
			if( parseInt(error_code) == 0 )
			{
				
				rdShowMessageDialog("ȷ����Ϣ����,��˲�!!");
				//wuxy add 20090217
				document.frm.confirm.disabled=true;				
				var retInfo="";
				var chPos=0;
				var valueStr="";
	 
				//����ɹ�������
				succData = backArrMsg;
				failData = backArrMsg1;
				readSubStr(succData,TOKEN,"�ɹ�");
				readSubStr(failData,TOKEN,"ʧ��");							
				document.frm.fileName.value = backArrMsg1;
							
			}
			else
			{
				rdShowMessageDialog("<br>������룺"+error_code+"</br>������Ϣ��"+error_msg);
				return false;
			}
		}
		else if(verifyType=="phoneno")
		{	
			if( parseInt(error_code) == 0 )
			{ 		
				var num = backArrMsg;
				if( parseInt(num) == 0 )
				{
					//rdShowMessageDialog("�����ڴ��ֻ�����������û�!!");
					 if (rdShowConfirmDialog("�����ڴ��ֻ�����������û�!!"+"<br>�Ƿ񱣴������Ϣ��")==1)	
              			 	{	
               				var patherr="f3210_2_printxls.jsp";
					patherr= patherr + "?phoneNo=" +document.frm.addNo.value;
					patherr= patherr + "&returnMsg=" +"�����ڴ��ֻ�����������û�!!";
					patherr = patherr +"&unitID=" + document.all.GRPID.value;
					patherr = patherr +"&op_Code=" + "3212" + "&orgCode=" + document.frm.orgCode.value;
               	        		//patherr= patherr + "&grpName=" +document.all.unit_id.options[document.all.unit_id.selectedIndex].text;
               	                       
               	       			 window.open(patherr);   
               	  			}      
					
					document.frm.addNo.select();
					document.frm.addNo.focus();
					return false;		
						
				}
				else
				{
					dynAddRow();
				}
			}
			else
			{
				//rdShowMessageDialog("<br>������룺"+error_code+"</br>������Ϣ��"+error_msg);
				 if (rdShowConfirmDialog("<br>������룺"+error_code+"</br>������Ϣ��"+error_msg+"<br>�Ƿ񱣴������Ϣ��")==1)	
              			 	{	
               				var patherr="f3210_2_printxls.jsp";
					patherr= patherr + "?phoneNo=" +document.frm.addNo.value;
					patherr= patherr + "&returnMsg=" +error_msg;
					patherr = patherr +"&unitID=" + document.all.GRPID.value;
					patherr = patherr +"&op_Code=" + "3212" + "&orgCode=" + document.frm.orgCode.value;
               	        		//patherr= patherr + "&grpName=" +document.all.unit_id.options[document.all.unit_id.selectedIndex].text;
               	                       
               	       			 window.open(patherr);   
               	  			}      
				return false;
			}
		}
		else if(verifyType=="shortno")
		{	
			if( parseInt(error_code) == 0 )
			{ 			
				var num = backArrMsg;
				if( parseInt(num) == 0 )
				{
					//rdShowMessageDialog("�˼��Ų����ڴ˶̺ź���!!");
					if (rdShowConfirmDialog("�����ڴ��ֻ�����������û�!!"+"<br>�Ƿ񱣴������Ϣ��")==1)	
              			 	{	
               				var patherr="f3210_2_printxls.jsp";
					patherr= patherr + "?phoneNo=" +document.frm.addNo.value;
					patherr= patherr + "&returnMsg=" +"�˼��Ų����ڴ˶̺ź���!!";
					patherr = patherr +"&unitID=" + document.all.GRPID.value;
					patherr = patherr +"&op_Code=" + "3212" + "&orgCode=" + document.frm.orgCode.value;
               	        		//patherr= patherr + "&grpName=" +document.all.unit_id.options[document.all.unit_id.selectedIndex].text;
               	                       
               	       			 window.open(patherr);   
               	  			}      
					//document.frm.addNo.select();
					//document.frm.addNo.focus();
					//return false;	
					dynAddRow();						
				}
				else
				{
					dynAddRow();
				}
			}
			else
			{
				//rdShowMessageDialog("<br>������룺"+error_code+"</br>������Ϣ��"+error_msg);
				if (rdShowConfirmDialog("<br>������룺"+error_code+"</br>������Ϣ��"+error_msg+"<br>�Ƿ񱣴������Ϣ��")==1)	
              			 	{	
               				var patherr="f3210_2_printxls.jsp";
					patherr= patherr + "?phoneNo=" +document.frm.addNo.value;
					patherr= patherr + "&returnMsg=" +error_msg;
					patherr = patherr +"&unitID=" + document.all.GRPID.value;
					patherr = patherr +"&op_Code=" + "3212" + "&orgCode=" + document.frm.orgCode.value;
               	        		//patherr= patherr + "&grpName=" +document.all.unit_id.options[document.all.unit_id.selectedIndex].text;
               	                       
               	       			 window.open(patherr);   
               	  			}      
				return false;
			}
		}	
	}

	function doBackCheck(add_no,add_value)
	{
		var tmp_addNo="";
		for(var a = document.all.dyntb.rows.length-2 ;a>0; a--)//ɾ����tr1��ʼ��Ϊ������
		{
			tmp_addNo = document.all.R1[a].value;
			if((tmp_addNo.trim() == add_no.trim()))
			{
				document.all.R2[a].value = add_value;
			  	break;
			}			           
		}
        return true;
    }
    			
	function fillSelectUseValue_noArr(fillObject,indValue)
	{	
			for(var i=0;i<document.all(fillObject).options.length;i++){
				if(document.all(fillObject).options[i].value == indValue){
					document.all(fillObject).options[i].selected = true;
					break;
				}
			}							
	}

	function check_phone()
	{

 		var sqlBuf=""; 		
		var myPacket = new AJAXPacket("CallCommONESQL.jsp","������֤�û����룬���Ժ�......");		
		var update_no_type = document.frm.updateNoType[document.frm.updateNoType.selectedIndex].value;
    		var realAddNo1=document.frm.addNo.value.trim();
		if( document.frm.GRPID.value == "" )
		{
		  	rdShowMessageDialog("�����뼯�ź�!!");
		  	return false;		 
		 }		
		
		if(!checkElement(document.all.addNo)) 
			return false;
		if( update_no_type == "0" )//�̺�
		{
			var shortNo = document.frm.addNo.value;

			if(shortNo.length > 6 || shortNo.length < 4){
			  	rdShowMessageDialog("�̺ų��ȱ�����4-6λ!!");
			  	document.frm.addNo.select();
			  	document.frm.addNo.focus();
			  	return false;
			}


	        if(shortNo.substr(0,1) !=6)
	       	{
	       		rdShowMessageDialog("�̺��������6��ͷ!");
	       		document.frm.addNo.select();
			  	document.frm.addNo.focus();
	       		return false;
	       	}

	       	if(shortNo.substr(1,1) ==0)
	       	{
	       		rdShowMessageDialog("�̺���ڶ�λ����Ϊ0!");
			  	document.frm.addNo.select();
			  	document.frm.addNo.focus();
	       		return false;
	       	}
	
			sqlBuf = "select count(*) from dvpmnusrmsg  "+
					 " where group_no='"+document.frm.GRPID.value +
			         "' and short_no = '"+document.frm.addNo.value+"'" ;
					
			myPacket.data.add("verifyType","shortno");

			myPacket.data.add("sqlBuf",sqlBuf);
			myPacket.data.add("recv_number",1);
			core.ajax.sendPacket(myPacket);
			myPacket=null;
			//delete(myPacket);	
			
		}
		else
		{
			if((realAddNo1.substring(0,1)=="0")||(realAddNo1.substring(0,3)=="130")||
			(realAddNo1.substring(0,3)=="131")||(realAddNo1.substring(0,3)=="132") ||
			(realAddNo1.substring(0,3)=="133")||(realAddNo1.substring(0,3)=="153") ||
			(realAddNo1.substring(0,3)=="155")||(realAddNo1.substring(0,3)=="156"))
      { 
        
         sqlBuf="select count(*) from dvpmnotherusermsg where phone_no ='"+document.frm.addNo.value+"'";
					
      }else
      {
   		     sqlBuf="select count(*) from dcustmsg where phone_no ='"+document.frm.addNo.value+"'" +
					" and substr(run_code,2,1 ) in ('A','B','C','D','E','F','G','H','I','K','L','M','O') "; //diling update@2011/10/24 ����һ��O״̬
	     }
			     myPacket.data.add("verifyType","phoneno");
			     myPacket.data.add("sqlBuf",sqlBuf);
			     myPacket.data.add("recv_number",1);
			     core.ajax.sendPacket(myPacket);
			     myPacket=null;
			     //delete(myPacket);	
		}			
		
	}
	
	function dynAddRow()
	{
		var phone_no="";
		var isdn_no="";
		var user_name="";
		var id_card="";
		var note="";
		var add_no="";

	    var tmpStr="";

		  add_no = document.all.addNo.value;
		  
		  if(!checkElement(document.all.addNo)) return false;		  		    	  
 
	queryAddAllRow(0,add_no);	  	
		
	}	

	function queryAddAllRow(add_type,add_no)
	{
	var tr1="";
	var i=0;
	var tmp_flag=false;
	var exec_status="";


	  tmp_flag = verifyUnique(add_no);
	  if(tmp_flag == false)
	  {
	  	rdShowMessageDialog("�Ѿ���һ��'���Ӻ���'��ͬ������!!");
	  	return false;	  
	  }
	  
      tr1=dyntb.insertRow();	//ע�⣺����ı������������һ��,������ɿ���.yl.
	  tr1.id="tr"+dynTbIndex;
	  	    
  	  tr1.insertCell().innerHTML = '<div align="center"><input id=R0    type=checkBox    size=4 value="ɾ��" onClick="dynDelRow()" ></input></div>';         
      tr1.insertCell().innerHTML = '<div align="center"><input id=R1   class=InputGrey type=text   value="'+ add_no+'"  readonly></input></div>';
      tr1.insertCell().innerHTML = '<div align="center"><input id=R2    class=InputGrey  type=text   value="'+ exec_status+'"  readonly></input></div>';

	  dynTbIndex++;
	  document.all.addNo.value = "";

	  
	  document.all.addRecordNum.value = document.all.dyntb.rows.length-2;
	}

	function dynDelRow()
	{

		for(var a = document.all.dyntb.rows.length-2 ;a>0; a--)//ɾ����tr1��ʼ��Ϊ������
		{
	        if(document.all.R0[a].checked == true)
	        {
	            document.all.dyntb.deleteRow(a+1);
	            break;
	        }
		}
		document.all.addRecordNum.value = document.all.dyntb.rows.length-2;
		
	}


	function dyn_deleteAll()
	{
		//������ӱ��е�����
		for(var a = document.all.dyntb.rows.length-2 ;a>0; a--)//ɾ����tr1��ʼ��Ϊ������
		{
	            document.all.dyntb.deleteRow(a+1);
		}
		document.all.addRecordNum.value = document.all.dyntb.rows.length-2;		 	
	}	
	
	function verifyUnique(add_no)
	{
		var tmp_addNo="";


					
		for(var a = document.all.dyntb.rows.length-2 ;a>0; a--)//ɾ����tr1��ʼ��Ϊ������
		{
			  tmp_addNo = document.all.R1[a].value;
		
			  if( (tmp_addNo.trim() == add_no.trim())){
			  		return false;
			  	}			
			 	           
		}
         
           return true;
    }

	
	function PubSimpSel_self(pageTitle,fieldName,sqlStr,selType,retQuence,retToField)
	{
	 
	    var path = "<%=request.getContextPath()%>/npage/public/fPubSimpSel.jsp";
	    //var path = "../public/fPubSimpSel.jsp";
	    path = path + "?sqlStr=" + sqlStr + "&retQuence=" + retQuence;
	    path = path + "&fieldName=" + fieldName + "&pageTitle=" + pageTitle;
	    path = path + "&selType=" + selType;  
	
	    retInfo = window.showModalDialog(path);
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
	}

	function call_addNoQry()
	{
	    var pageTitle = "���ų�Ա�����ѯ";               
	    var fieldName = "�̺�|��ʵ����|���ź�|";
		var sqlStr ="";
		var update_no_type = document.frm.updateNoType[document.frm.updateNoType.selectedIndex].value;
    		var realAddNo=document.frm.addNo.value.trim();
	 if( document.frm.GRPID.value == "" )
	 {
	  	rdShowMessageDialog("�����뼯�ź�!!");
	  	return false;		 
	 }
	 if(("0".equals(realAddNo.substring(0,1)))||("130".equals(realAddNo.substring(0,3)))
        ||("131".equals(realAddNo.substring(0,3)))||("132".equals(realAddNo.substring(0,3)))
        ||("133".equals(realAddNo.substring(0,3)))||("153".equals(realAddNo.substring(0,3)))
        ||("155".equals(realAddNo.substring(0,3)))||("156".equals(realAddNo.substring(0,3)))){ //���ƶ�����
        sqlStr = "select short_no,real_no,group_no from dvpmnotherusermsg  "+
				 " where group_no="+document.frm.GRPID.value;	
   }else
   	{
   		sqlStr = "select short_no,real_no,group_no from dvpmnusrmsg  "+
				 " where group_no="+document.frm.GRPID.value;
   	}
		
		
		if( update_no_type == "0" ){//�̺�
			sqlStr =  sqlStr + " and short_no like '"+encodeURI("%" +document.frm.addNo.value.trim())+"%'" ;
		}
		else{//��ʵ����
			sqlStr =  sqlStr + " and real_no like '"+encodeURI("%" +document.frm.addNo.value.trim())+"%'" ;		
		}    		
				
	   sqlStr = sqlStr + " order by short_no " ; 				

	    var selType = "S";    //'S'��ѡ��'M'��ѡ      
	    var retQuence = "3|0|1|2|";             
	    var retToField = "";


	    if( update_no_type == "0" ){//�̺�
	    	retToField = "addNo|tmpAddRealNo|GRPID|";
	    }else{
	    	retToField = "tmpAddShortNo|addNo|GRPID|";
	    }
	    	    
	    PubSimpSel_self(pageTitle,fieldName,sqlStr,selType,retQuence,retToField); 
	    
	    	    	    					
	}
	
	function call_GRPIDQRY()
	{
	    var pageTitle = "���źŲ�ѯ";               
	    var fieldName = "���ź�|��������|";
	    				
		var sqlStr ="";

							 
		sqlStr = "select group_no,trim(group_name)"+
				 " from  dVPMNGRPMSG  "+
				 " where  ";

		sqlStr = sqlStr +"  group_no like '"+encodeURI("%" +document.frm.GRPID.value.trim())+"%'" +	
						 " and group_name like '%" +document.frm.GRPNAME.value.trim()+"%'" ;	
			 
		sqlStr = sqlStr + " order by group_no " ;
		
	    var selType = "S";    //'S'��ѡ��'M'��ѡ      
	    var retQuence = "2|0|1|";             
	    var retToField = "GRPID|GRPNAME|"; 
	 	    
	    PubSimpSel_self(pageTitle,fieldName,sqlStr,selType,retQuence,retToField); 	
	    
	    	    
	}

	function doValid()
	{
	var update_no_type = document.frm.updateNoType[document.frm.updateNoType.selectedIndex].value;
	
		with(document.frm)
		{
		 if(update_no_type == "0")//�̺��б�
		 {
			if(isNullMy("GRPID")){rdShowMessageDialog("���źŲ���Ϊ��!",1); return false;}	
		 }    	    
				
		}
		
		return true;
	}
	
	function judge_valid()
	{


		//1.��鵥������
	 	if( !doValid() ) return false;
	 	
	 	if(!checkElement(document.all.GRPID)) return false;
			
		return true;
	}



	function isNullMy(obj)
	{
		if( document.all(obj).value == "" )
		{
			document.all(obj).focus();
			return true;
		}
		else{
			return false;			
			}		
	}

		
	function resetJsp()
	{

	
		init();
		
	 with(document.frm)
	 {
	 	GRPID.value			= "";
	 	GRPNAME.value		= "";
	 	addNo.value			= "";
	 	
	 	//SUCCESSNUM.value	= "";
	 	//FAILNUM.value		= "";
	 	//SKIPNUM.value		= "";
	 	//INEXISTNUM.value	= "";
	 	opNote.value		= "";


	 }
	
		dyn_deleteAll();
		reset_globalVar();	
	    //wuxy add 20090217
		document.frm.confirm.disabled=false;
	}
	
	function commitJsp()
	{
	    var ind1Str ="";
	    var ind2Str ="";
	    var ind3Str ="";
	    var ind4Str ="";
	    var ind5Str ="";  
		var tmpStr="";
		var procSql = "";
				
		if( !judge_valid() )
		{
			return false;
		}

		if( dyntb.rows.length == 2){//������û������
			rdShowMessageDialog("������û������,����������!!");
			return false;
		}else{

			for(var a=1; a<document.all.R0.length ;a++)//ɾ����tr1��ʼ��Ϊ������
			{
				ind1Str =ind1Str +document.all.R1[a].value+"|";
			}						
		}
	
		//2.��form�������ֶθ�ֵ
		document.all.tmpR1.value = ind1Str;		

		//4.�ύҳ��
	 	tmpStr = "ɾ�� " + "����";
	 	document.frm.opCode.value="3212";	 		 
		document.frm.opNote.value =  tmpStr;
		
		
		
		 var ret = showPrtDlg("Detail","ȷʵҪ���е��������ӡ��","Yes"); 
	    if(typeof(ret)!="undefined")
		{
	        if((ret=="confirm"))
	        {
	          if(rdShowConfirmDialog('ȷ�ϵ����������ȷ��,���ύ����ҵ��!')==1)
	          {
	             var myPacket = new AJAXPacket("f3212_rpc_confirm.jsp?loginAccept=<%=loginAccept%>&op_note="+document.frm.opNote.value,"����ȷ�ϣ����Ժ�......");
	
				 myPacket.data.add("verifyType","confirm");	
				 myPacket.data.add("loginNo",document.frm.loginNo.value);	
				 myPacket.data.add("orgCode",document.frm.orgCode.value);	
				 myPacket.data.add("opCode",document.frm.opCode.value);	
				 myPacket.data.add("GRPID",document.frm.GRPID.value);	
				 myPacket.data.add("updateNoType",document.frm.updateNoType.value);	
				 myPacket.data.add("tmpR1",document.frm.tmpR1.value);	
				 myPacket.data.add("group_id",document.frm.group_id.value);	
				 myPacket.data.add("org_id",document.frm.org_id.value);	
				 myPacket.data.add("IpAddr",document.frm.IpAddr.value);	
				     	    
	    		 core.ajax.sendPacket(myPacket);
	    		 myPacket=null
	    		 //delete(myPacket);
	          }
		    }
		    if(ret=="continueSub")
		    {
	          if(rdShowConfirmDialog('ȷ��Ҫ�ύ��Ϣ��')==1)
	          {
	           	 var myPacket = new AJAXPacket("f3212_rpc_confirm.jsp?loginAccept=<%=loginAccept%>&op_note="+document.frm.opNote.value,"����ȷ�ϣ����Ժ�......");
	
				 myPacket.data.add("verifyType","confirm");	
				 myPacket.data.add("loginNo",document.frm.loginNo.value);	
				 myPacket.data.add("orgCode",document.frm.orgCode.value);	
				 myPacket.data.add("opCode",document.frm.opCode.value);	
				 myPacket.data.add("GRPID",document.frm.GRPID.value);	
				 myPacket.data.add("updateNoType",document.frm.updateNoType.value);	
				 myPacket.data.add("tmpR1",document.frm.tmpR1.value);	
				 myPacket.data.add("group_id",document.frm.group_id.value);	
				 myPacket.data.add("org_id",document.frm.org_id.value);	
				 myPacket.data.add("IpAddr",document.frm.IpAddr.value);	
				     	    
	    		 core.ajax.sendPacket(myPacket);
	    		 myPacket=null
	    		 //delete(myPacket);
	          }
		    }
		  }
		  else
	      {
	        if(rdShowConfirmDialog('ȷ��Ҫ�ύ��Ϣ��')==1)
	        {
	             var myPacket = new AJAXPacket("f3212_rpc_confirm.jsp?loginAccept=<%=loginAccept%>&op_note="+document.frm.opNote.value,"����ȷ�ϣ����Ժ�......");
	
				 myPacket.data.add("verifyType","confirm");	
				 myPacket.data.add("loginNo",document.frm.loginNo.value);	
				 myPacket.data.add("orgCode",document.frm.orgCode.value);	
				 myPacket.data.add("opCode",document.frm.opCode.value);	
				 myPacket.data.add("GRPID",document.frm.GRPID.value);	
				 myPacket.data.add("updateNoType",document.frm.updateNoType.value);	
				 myPacket.data.add("tmpR1",document.frm.tmpR1.value);	
				 myPacket.data.add("group_id",document.frm.group_id.value);	
				 myPacket.data.add("org_id",document.frm.org_id.value);	
				 myPacket.data.add("IpAddr",document.frm.IpAddr.value);	
				     	    
	    		 core.ajax.sendPacket(myPacket);
	    		 myPacket=null
	    		 //delete(myPacket);
	        }
	      }					
	}
				
	function printInfo(printType)
	{		
	
			
		  	var retInfo = "";
	      retInfo+='<%=loginNo%>  <%=loginName%>'+"|";
	      retInfo+='<%=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(Calendar.getInstance().getTime())%>'+"|";
	      
		  retInfo+="���ű�ţ�"+document.all.GRPID.value+"|";
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
	      
	      retInfo+="����ҵ��"+"����ɾ�����ų�Ա"+"|";
	      retInfo+=" "+"|";
	      retInfo+="ɾ���ļ��ų�Ա�ֻ�����: "+(document.all.tmpR1.value).replace(/\|/g,",")+"|";
		    retInfo+=" "+"|";
		    retInfo+=" "+"|";
		    retInfo+=" "+"|";
	      retInfo+=" "+"|";
	      retInfo+=" "+"|";
	
		  return retInfo;
	}

	 function showPrtDlg(printType,DlgMessage,submitCfm)
	{  //��ʾ��ӡ�Ի��� 
	     var h=162;
	     var w=352;
	     var t=screen.availHeight/2-h/2;
	     var l=screen.availWidth/2-w/2;
	   
	     var printStr = printInfo(printType);
	   
	     var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no"; 
	     var path = "/npage/innet/hljGdPrint.jsp?DlgMsg=" + DlgMessage;
	     var path = path + "&printInfo=" + printStr + "&submitCfm=" + submitCfm;
	     var ret=window.showModalDialog(path,"",prop);
	     return ret;     
	}				
//-->
</script>
</head>
<body>
<form name="frm" method="post" action="">
		<%@ include file="/npage/include/header.jsp" %>     	
		<div class="title">
			<div id="title_zi">����ɾ�����ų�Ա</div>
		</div>        
        <table cellspacing="0">        
          <tr> 
            <td width="16%" class="blue">��������</td>
            <td width="36%">
             	<input name="noUse" type="text" class="InputGrey" id="noUse" value="ɾ��"  readonly> 
            </td>
            <td width="16%" class="blue">���д���</td>
            <td width="34%">
            	<input name="regionName" type="text" class="InputGrey" id="regionName" value="<%=regionName%>" maxlength="2" readonly> 
            </td>
          </tr>
          
          <tr> 
            <td width="16%" class="blue">���ű��</td>
            <td colspan="3"> 
            	<input name="GRPID" type="text"  id="GRPID" size="10" maxlength="10" v_must=1 v_type=0_9 v_minlength=10  > 
              	<input name="GRPNAME" type="text"  id="GRPNAME" maxlength="36"> 
              	<font class="orange">*</font>
               <input name="GRPIDQRY" type="button" class="b_text" id="GRPIDQRY" onClick="call_GRPIDQRY()" value="��ѯ"></td>
          </tr>
          </table>
          <br>
           <div class="title">
			<div id="title_zi">�������Ӻ�����Ϣ</div>
	   </div>       
          <table cellspacing="0"> 
          <tr> 
            <td width="16%" class="blue">��ѡ���������</td>
            <td width="36%">
            	<select name="updateNoType">
	                <option value="0">0--&gt;�̺��б�</option>
	                <option value="1" selected >1--&gt;��ʵ�����б�</option>
              	</select>
             </td>
            <td class="blue" width="16%">���Ӻ���</td>
            <td>
            	<input name="addNo" type="text"  id="addNo" maxlength="12" v_must=1 v_type=0_9 v_minlength=1   > 
              	<input name="addNoQry" type="button" class="b_text" id="addNoQry" value="��ѯ" onClick="call_addNoQry()">
           </td>
          </tr>
          <tr> 
            <td width="16%" class="blue">�ļ���</td>
            <td colspan="3">
            	<input name="fileName" type="text"  class="InputGrey" id="fileName" size="60" maxlength="60" readonly>
            </td>
          </tr>              
          <tr> 
            <td width="16%" >
            	<input name="addCondConfirm" type="button" class="b_text" id="addCondConfirm" value="����" onClick="check_phone()"></td>
            <td>&nbsp;</td>
            <td class="blue">�����Ӽ�¼��</td>
            <td> 
              <input name="addRecordNum" type="text" class="InputGrey" id="addRecordNum" value="" size=7 readonly></td>
          </tr>          
          <table>
          
           <table cellspacing="0" id="dyntb">
                <tr> 
                  <td class="blue">ɾ������</td>
                  <td class="blue"> ���Ӻ���</td>
                  <td class="blue">ִ��״̬</td>
                </tr>
                <tr id="tr0" style="display:none">
                  <td>
                      	<input type="checkBox" id="R0" value="">
                  </td>
                  <td>
                      <input type="text" id="R1" value="">
                  </td>
                  <td>
                      <input type="text" id="R2" value="">
                  </td>                    
                </tr>
              </table>  
	  <table cellspacing="0">
	          <tr> 
	            <td width="16%" class="blue">��Ϣ��ע</td>
	            <td colspan="3">
	            	<input name="opNote" type="text" class="InputGrey" id="opNote" size="60" maxlength="60" readonly >
	            </td>
	          </tr>
          </table>
          
          
          <table cellspacing="0">
			    <tr> 
			    	<td id="footer"> 
			    		<input name="confirm" id="confirm" type="button" class="b_foot" value="ȷ��" onClick="commitJsp()">
			    		&nbsp;
			                <input name="reset" type="button" class="b_foot" value="���" onClick="resetJsp()">
			                &nbsp; 
			                <input name="back" onClick="removeCurrentTab()" type="button" class="b_foot" value="�ر�">
			                &nbsp;
			   	</td>
			    </tr>
  	</table>
  	<%@ include file="/npage/include/footer.jsp" %>	
  	<input type="hidden" name="loginNo" id="loginNo" value="<%=loginNo%>">
  	<input type="hidden" name="loginName" id="loginName" value="">
  	<input type="hidden" name="opCode" id="opCode" value="">
  	<input type="hidden" name="orgCode" id="orgCode" value="<%=orgCode%>">
  	<input type="hidden" name="regionCode" id="regionCode" value="<%=regionCode%>">
  	<input type="hidden" name="IpAddr" id="IpAddr" value="<%=ip_Addr%>">

  	<input type="hidden" name="tmpLOCKFLAG" id="tmpLOCKFLAG" value="">
  	<input type="hidden" name="tmpUSERTYPE" id="tmpUSERTYPE" value="">
  	<input type="hidden" name="tmpCURFEETYPE" id="tmpCURFEETYPE" value="">
  	<input type="hidden" name="tmpFEETYPE" id="tmpFEETYPE" value="">
  	  	
  	<input type="hidden" name="STATUS" id="STATUS" value="">
  	<input type="hidden" name="FEEFLAG" id="FEEFLAG" value="">
  	<input type="hidden" name="USERPIN" id="USERPIN" value="">
  	
  	<input type="hidden" name="tmpR1" id="tmpR1" value="">
  	<input type="hidden" name="tmpR2" id="tmpR2" value="">
  	<input type="hidden" name="tmpR3" id="tmpR3" value="">
  	<input type="hidden" name="tmpR4" id="tmpR4" value="">
  	<input type="hidden" name="tmpR5" id="tmpR5" value="">
    	<input type="hidden" name="org_id" id="org_id" value="<%=OrgId%>">
    	<input type="hidden" name="group_id" id="group_id" value="<%=GroupId%>">

  	<input type="hidden" name="tmpAddShortNo" id="tmpAddShortNo" value="">
	<input type="hidden" name="tmpAddRealNo" id="tmpAddRealNo" value="">
  	
  	<input type="hidden" name="NUMLIST" id="NUMLIST" value="">   
  	
	
</form>
</body>
</html>

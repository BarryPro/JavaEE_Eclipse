 <%
	/********************
	 version v2.0
	������: si-tech
	update:anln@2009-02-04 ҳ�����,�޸���ʽ
	********************/
%>  

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType= "text/html;charset=gb2312" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="java.text.*" %>

<%  
	String opCode = "5252";	
	String opName = "�ʻ�����";	//header.jsp��Ҫ�Ĳ���   
	
		//ArrayList retArray = new ArrayList();
	String[][] result = new String[][]{};
 	//S1100View callView = new S1100View();   
 	String printAccept = ""; 
%>
<%
	String workNo = (String)session.getAttribute("workNo");    //���� 
	String loginPwd    = (String)session.getAttribute("password"); //��������
	String workName =(String)session.getAttribute("workName");//��������  	   
	String regionCode = (String)session.getAttribute("regCode");  
	String ip_Addr = (String)session.getAttribute("ipAddr");
	String Department = (String)session.getAttribute("orgCode");
	String belongCode = Department.substring(0,7);
	
        String rowNum = "1000";        
	String agentPaper = "";	
	if(request.getParameter("agentPaper")!=null){
		System.out.println("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$");
		agentPaper = request.getParameter("agentPaper");
	}
	
	
%>

    <wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="region" routerValue="<%=regionCode%>" id="loginAccept"/>

	<HEAD>
		<TITLE>�ʻ����� </TITLE>			
		<script type="text/javascript">

		onload=function()
		{
		   
		    document.all.idIccid.focus();		
			if(typeof(frm1102.accountId)!="undefined") 
			{	if(frm1102.accountId.value != "")            ////�ָ����ύǰ�Ļ���ʻ�ID��ť��ʾ״̬
				{	frm1102.accountIdQuery.disabled = true; }
			}		
			//core.rpc.onreceive = doProcess;	
		}
		//---------1------RPC������------------------
		function doProcess(packet)
		{	
		    //RPC������findValueByName
		    var retType = packet.data.findValueByName("retType");
		    var retCode = packet.data.findValueByName("retCode"); 
		    var retMessage = packet.data.findValueByName("retMessage");	
		    self.status="";
		    
		    var msg = packet.data.findValueByName("msg");
			   if(retType == "AccountId")
				 {
			        var retnewId = packet.data.findValueByName("retnewId");
			    	if(retCode=="000000")
			    	{
			       		//document.all.accountName.focus();			 		
			    	    document.frm1102.accountId.value = retnewId;
				        document.frm1102.accountIdQuery.disabled = true; 		    	 
			    	}
			    	else
			    	{
			    	    retMessage = retMessage + "[errorCode1:" + retCode + "]";
			    		rdShowMessageDialog(retMessage,0);
						return false;
			    	}	
				 }
		    //-----------------------------------------
		    if(retType == undefined)
		    {
		        //��������У��
		      var retResult = packet.data.findValueByName("retResult");
		      if(retResult!="000000"){
		      	frm1102.checkPwd_Flag.value = false;
		      }else{
		      	frm1102.checkPwd_Flag.value = true;
		      } 
			    //frm1102.checkPwd_Flag.value = retResult; 
			    if(frm1102.checkPwd_Flag.value == "false")
			    {
			    	rdShowMessageDialog("�ͻ�����У��ʧ�ܣ����������룡",0);
			    	frm1102.custPwd.value = "";
			    	frm1102.custPwd.focus();
			    	frm1102.checkPwd_Flag.value = "false";	    	
			    	return false;	        	
			    }		
				else
					{
			 		   rdShowMessageDialog("�ͻ�����У��ɹ���",2);
			 		   frm1102.newPwd.value=frm1102.custPwd.value;
			   		 frm1102.cfmPwd.value=frm1102.custPwd.value;
					   document.all.accountIdQuery.disabled=false;	      
					}
		
		    }
			//------------------------------------
			if(retType == "getInfo_withID")
			{
			    clear_CustInfo();
			    if(retCode == "000000") {
			        var retInfo = packet.data.findValueByName("retInfo");
			        
			        if(retInfo != "") {
			            for(var i = 0; i < 7; i ++){
                            document.all('in' + i).value = retInfo[0][i];
			            }
			        }
			    }else {
			        retMessage = retMessage + "[errorCode2:" + retCode + "]";
		    		rdShowMessageDialog(retMessage,0);
					return false;
			    }
			}
			if(retType=="chkX")
			{
		        var retObj = packet.data.findValueByName("retObj");
		
				if(retCode == "000000")
		        {
		         // document.all.print.disabled=false;
				}
		        else
		        {
		             retMessage = "����" + retCode + "��"+retMessage;			 
		             rdShowMessageDialog(retMessage,0);
					 document.all.print.disabled=true;
					 document.all(retObj).focus();
					 return false;
		        }
			}
		   
		   /*
		   //-----------------------------------
		   if(retType == "AccountId")
			{
		       var retnewId = packet.data.findValueByName("retnewId");
		    	if(retCode=="000000")
		    	{
		       		//document.all.accountName.focus();			 		
		    	    document.frm1102.accountId.value = retnewId;
			        document.frm1102.accountIdQuery.disabled = true; 		    	 
		    	}
		    	else
		    	{
		    	    retMessage = retMessage + "[errorCode1:" + retCode + "]";
		    		rdShowMessageDialog(retMessage,0);
					return false;
		    	}	
			}
		  //-----------------------------------
		  if(retType == "getInfo_withID")
			{
			    clear_CustInfo();
			    if(retCode == "000000") {
			        var retInfo = packet.data.findValueByName("retInfo");
			        
			        if(retInfo != "") {
			            for(var i = 0; i < 7; i ++){
                            document.all('in' + i).value = retInfo[0][i];
			            }
			        }
			    }else {
			        retMessage = retMessage + "[errorCode2:" + retCode + "]";
		    		rdShowMessageDialog(retMessage,0);
					return false;
			    }
			}
			//-----------------------------------
			if(retType=="chkX")
			{
		        var retObj = packet.data.findValueByName("retObj");
		
				if(retCode == "000000")
		        {
		         // document.all.print.disabled=false;
				}
		        else
		        {
		             retMessage = "����" + retCode + "��"+retMessage;			 
		             rdShowMessageDialog(retMessage,0);
					 document.all.print.disabled=true;
					 document.all(retObj).focus();
					 return false;
		        }
			} 
			
			//----------------------------
				if(retType == undefined)
		    {
		    	alert("У������");
		        //��������У��
		      var retResult = packet.data.findValueByName("retResult");
		      alert(retResult);
			   	frm1102.checkPwd_Flag.value = retResult; 
			    if(frm1102.checkPwd_Flag.value == "false")
			    {
			    	rdShowMessageDialog("�ͻ�����У��ʧ�ܣ����������룡",0);
			    	frm1102.custPwd.value = "";
			    	frm1102.custPwd.focus();
			    	frm1102.checkPwd_Flag.value = "false";	    	
			    	return false;	        	
			    }else{
		 		   rdShowMessageDialog("�ͻ�����У��ɹ���",2);
		 		   frm1102.newPwd.value=frm1102.custPwd.value;
		   		 frm1102.cfmPwd.value=frm1102.custPwd.value;
				   document.all.accountIdQuery.disabled=false;	      
				 }
			}
			*/
		   
		   /*
			if(retCode=="")
			{
		       rdShowMessageDialog("����"+retType+"����ʱʧ�ܣ�",0);
		       return false;
			}
			if(msg!="" || msg !="undefined" || msg !=null || msg !=" "){
					rdShowMessageDialog(msg,0);
					return false;	
			}
			*/
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
		//-----------------------------------------------------		
		function choiceSelWay()
		{	//ѡ��ͻ���Ϣ�Ĳ�ѯ��ʽ			
			if(frm1102.custId.value != "")
			{	//���ͻ�ID���в�ѯ
				getInfo_withId();	
				return true;
			}
			 document.all.accountIdQuery2.disabled=false;
			if(frm1102.idIccid.value != "")
			{	
				getInfo_IccId();
				return true;
			}
			if(frm1102.custName.value != "")
			{	
				getInfo_withName();
				return true;
			}
			
			rdShowMessageDialog("�ͻ���Ϣ������ID��֤����������ƽ��в�ѯ��������������������Ϊ��ѯ������",0);
			 
		}
				//-----------------------------------------------------
		function getInfo_withId()
		{
			
		    //���ݿͻ�ID�õ������Ϣ
		    
		    if(document.frm1102.custId.value == "")
		    {
		        rdShowMessageDialog("������ͻ�ID��",0);
		        return false;
		    }
		    if(forNonNegInt(frm1102.custId) == false)
		    {	
		    	frm1102.custId.value = "";
		    	return false;	
		    }    
		    
		    var custId =  document.frm1102.custId.value;
		    
		    var getIdPacket = new AJAXPacket("f5252_ajax_1.jsp", "���ڻ�ÿͻ���Ϣ�����Ժ�...");
			getIdPacket.data.add("retType","getInfo_withID");
			getIdPacket.data.add("serviceName","sCustTypeQry");
			getIdPacket.data.add("outnum","7");
			getIdPacket.data.add("inputParamsLength","8");
			
			getIdPacket.data.add("inParams0","<%=loginAccept%>");
			getIdPacket.data.add("inParams1","01");
			getIdPacket.data.add("inParams2","<%=opCode%>");
			getIdPacket.data.add("inParams3","<%=workNo%>");
			getIdPacket.data.add("inParams4","<%=loginPwd%>");
			getIdPacket.data.add("inParams5","");
			getIdPacket.data.add("inParams6","");
			getIdPacket.data.add("inParams7",custId);
			/**
			getIdPacket.data.add("sqlStr","select to_char(a.CUST_ID),a.CUST_PASSWD,a.ID_ICCID,b.ID_NAME,a.CUST_NAME," +
			            " a.CUST_ADDRESS,a.REGION_CODE||a.DISTRICT_CODE||a.TOWN_CODE" + 
			            " from DCUSTDOC a,SIDTYPE b where a.CUST_ID=" + custId
		                + " and b.ID_TYPE = a.ID_TYPE and rownum<500 ");
		    */
			core.ajax.sendPacket(getIdPacket);
			getIdPacket=null;
		} 
		
		//-----------------------------------------------------
		/*
		    ����1(pageTitle)����ѯҳ�����
		    ����2(fieldName)�����������ƣ���'|'�ָ��Ĵ�
		    ����3(sqlStr)��sql���
		    ����4(selType)������1 rediobutton 2 checkbox
		    ����5(retQuence)����������Ϣ������������� �������ʶ����'|'�ָ�����"3|0|2|3"��ʾ����3����0��2��3
		    ����6(retToField))������ֵ����������,��'|'�ָ�
		*/
	
		//-------------------------------------------------
		function getInfo_withName()
		{ 
		  
		  	if(document.frm1102.custName.value == "")
		    {
		        rdShowMessageDialog("������ͻ����ƣ�",0);
		        return false;
		    }
		    /**
		    var pageTitle = "�ͻ���Ϣ��ѯ";
		    var fieldName = "�ͻ�ID|�ͻ�����|����ʱ��|֤������|֤������|�ͻ���ַ|��������|�ͻ�����|";
		    var sqlStr = "select to_char(a.CUST_ID),a.CUST_NAME,to_char(a.CREATE_TIME,'YYYY-MM-DD HH24:MI:SS'),b.ID_NAME,a.ID_ICCID," +
			             " a.CUST_ADDRESS,a.REGION_CODE||a.DISTRICT_CODE||a.TOWN_CODE,a.CUST_PASSWD" + 
			             " from DCUSTDOC a,SIDTYPE b where " +
			             " a.CUST_NAME like '" + document.frm1102.custName.value + "%' and b.ID_TYPE = a.ID_TYPE  and rownum<500 order by a.cust_name asc,a.create_time desc ";
		    var selType = "S";              //'S'��ѡ��'M'��ѡ
		    var retQuence = "7| 0|  1|  3|  4|  5|  6|  7|";
		    var retToField = "in0|in4|in3|in2|in5|in6|in1|";
		    */
		    var path = "selectCustMsg.jsp";
		    path = path + "?custName=" + document.frm1102.custName.value;
		    
		    custInfoQueryAdd(path);     	       	   
		}
		
		function custInfoQueryAdd(path){
		    retInfo = window.showModalDialog(path,"","dialogWidth:45;dialogHeight:35;");
		    
		    if(typeof(retInfo) == "undefined") {
		        return false;
		    }
		    
	        document.all('in0').value = retInfo.in0;
	        document.all('in4').value = retInfo.in1;
	        document.all('in3').value = retInfo.in3;
	        document.all('in2').value = retInfo.in4;
	        document.all('in5').value = retInfo.in5;
	        document.all('in6').value = retInfo.in6;
	        document.all('in1').value = retInfo.in7;
	        
			document.all.accountName.value = retInfo.in1;
			
			rpc_chkX("idType","idIccid","A");
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
		    //var path = "/npage/public/fPubSimpSel.jsp";   //������ʾ
		    var path = "/npage/innet/pubGetCustInfo.jsp";   //����Ϊ*
		    path = path + "?sqlStr=" + sqlStr + "&retQuence=" + retQuence;
		    path = path + "&fieldName=" + fieldName + "&pageTitle=" + pageTitle;
		    path = path + "&selType=" + selType;  
		   
		    retInfo = window.showModalDialog(path,"","dialogWidth:45;dialogHeight:35;");
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
				if(obj=="in4")
				  document.all.accountName.value=valueStr;
		        retToField = retToField.substring(chPos_field + 1);
		        retInfo = retInfo.substring(chPos_retInfo + 1);
		        chPos_field = retToField.indexOf("|");        
		    }
			rpc_chkX("idType","idIccid","A");
		}
		//-------------------------------------------------
		function getInfo_IccId()
		{ 
		  	//���ݿͻ�֤������õ������Ϣ
		  	if((document.frm1102.idIccid.value.trim()).length == 0)
		    {
		        rdShowMessageDialog("������ͻ�֤�����룡",0);
		        return false;
		    }
			else if((document.frm1102.idIccid.value.trim()).length < 5)
			{
		        rdShowMessageDialog("֤�����볤������������λ����",0);
		        return false;
			}
			/**
		    var pageTitle = "�ͻ���Ϣ��ѯ";
		    var fieldName = "�ͻ�ID|�ͻ�����|����ʱ��|֤������|֤������|�ͻ���ַ|��������|�ͻ�����|";
		    var sqlStr = "select to_char(a.CUST_ID),a.CUST_NAME,to_char(a.CREATE_TIME,'YYYY-MM-DD HH24:MI:SS'),b.ID_NAME,a.ID_ICCID," +
			             " a.CUST_ADDRESS,a.REGION_CODE||a.DISTRICT_CODE||a.TOWN_CODE,a.CUST_PASSWD" + 
			             " from DCUSTDOC a,SIDTYPE b where b.ID_TYPE = a.ID_TYPE " +
			             " and a.ID_ICCID = '" + document.frm1102.idIccid.value.trim() + "' and rownum<500 order by a.cust_name asc,a.create_time desc "; 
		    var selType = "S";    //'S'��ѡ��'M'��ѡ
		    var retQuence = "7|0|1|3|4|5|6|7|";
		    var retToField = "in0|in4|in3|in2|in5|in6|in1|";
		    */
		     var path = "selectCustMsg.jsp";
		    path = path + "?iIdIccid=" + document.frm1102.idIccid.value.trim();
		    custInfoQueryAdd(path);    	       	   
		}
		
		//----------------------------------------------------------
		function printCommit()
		{   
			//if(encrypt(frm1102.custPwd.value) != frm1102.in1.value)
			/* if(frm1102.custPwd.value == "")
			{
				rdShowMessageDialog("������ͻ����룡",0);
				frm1102.custPwd.focus();
				return false;		
			} */
			if((frm1102.payCode.value).indexOf("����") > 0)
			{
				if((frm1102.accountNo.value == "")||(frm1102.bankCode.value == "")||(frm1102.postCode.value == ""))
				{
					rdShowMessageDialog("������ص��ʺš�������Ϣ����Ϊ�գ�",0);
					return false;
				}		
			}
			//
			if(check(frm1102))
			{
			    if((document.all.newPwd.value.trim()).length>0)
				{
				  if(document.all.newPwd.value.length!=6)
				  {
				    rdShowMessageDialog("�ʻ����볤������",0);
				    document.all.custPwd.focus();
				    return false;
				  }
		          if(checkPwd(document.frm1102.newPwd,document.frm1102.cfmPwd)==false)
				  return false;
				}
		
		    	sysNote = "�ʻ�����:" + "�ͻ�ID[" + document.frm1102.custId.value + "]�ʻ�ID[" +
		    	         document.frm1102.accountId.value + "]";
		    	         //":�ʺ�[" + document.frm1102.accountNo.value + "]"; 
		    	document.frm1102.sysNote.value = sysNote;
				if((document.all.opNote.value.trim()).length==0)
					{
		              document.all.opNote.value="����Ա[<%=workName%>]"+"�Կͻ�["+document.all.custName.value.trim()+"]�����ʻ�����ҵ��"
					}
		    	showPrtDlg("Detail","ȷʵҪ���е��������ӡ��","Yes");    	    
		    }    
		}
		//---------------------------------------------------
		function getId()
		{
		    //�õ��ʻ�ID
		    var getAccountId_Packet = new AJAXPacket("/npage/innet/f1100_getId.jsp","���ڻ���ʻ�ID�����Ժ�......");
			getAccountId_Packet.data.add("region_code","<%=regionCode%>");
			getAccountId_Packet.data.add("retType","AccountId");
			getAccountId_Packet.data.add("idType","1");
			getAccountId_Packet.data.add("oldId","0");
			core.ajax.sendPacket(getAccountId_Packet);
			//delete(getAccountId_Packet);
			getAccountId_Packet=null;
			
			document.all.print.disabled=false;	
			
		}
		//----------------------------------
		function checkPwd(obj1,obj2)
		{
			//����һ����У��
			var pwd1 = obj1.value;
			var pwd2 = obj2.value;
			if(pwd1 != pwd2)
			{
				var message = "'" + obj1.v_name + "'��'" + obj2.v_name + "'��һ�£����������룡";
				rdShowMessageDialog(message,0);
				obj1.value = "";
				obj2.value = "";
				obj1.focus();
				return false;
			}
			return true;
		}
		//-----------------------------------
		function change_custPwd()
		{   //��֤���루���룩
		    check_HidPwd(frm1102.custPwd.value,"show",frm1102.in1.value.trim(),"hid");
		   	
		}
		//------------------------------------
		function check_HidPwd(Pwd1,Pwd1Type,Pwd2,Pwd2Type)
		{
			/*
		  		Pwd1,Pwd2:����
		  		wd1Type:����1�����ͣ�Pwd2Type������2������      show:���룻hid������
		  	
			if((Pwd1.trim()).length==0)
			{
		        rdShowMessageDialog("�ͻ����벻��Ϊ�գ�",0);
		        frm1102.custPwd.focus();
				return false;
			}
		    else 
			{
			   if((Pwd2.trim()).length==0)
			   {
		         rdShowMessageDialog("ԭʼ�ͻ�����Ϊ�գ���˶����ݣ�",0);
		         frm1102.custPwd.focus();
				 return false;
			   }
			}*/
		
		  var checkPwd_Packet = new AJAXPacket("/npage/public/pubCheckPwd.jsp","���ڽ�������У�飬���Ժ�......");
		  
		  /*
		  checkPwd_Packet.data.add("retType","checkPwd");
			checkPwd_Packet.data.add("Pwd1",Pwd1);
			checkPwd_Packet.data.add("Pwd1Type",Pwd1Type);
			checkPwd_Packet.data.add("Pwd2",Pwd2);
			checkPwd_Packet.data.add("Pwd2Type",Pwd2Type);
			*/
			checkPwd_Packet.data.add("custType","02"); //01:�û�����У�� 02 �ͻ�����У�� 03�ʻ�����У��
			checkPwd_Packet.data.add("phoneNo",frm1102.custId.value);  //�ƶ�����,�ͻ�id,�ʻ�id
			checkPwd_Packet.data.add("custPaswd",frm1102.custPwd.value);//�û�/�ͻ�/�ʻ�����
			checkPwd_Packet.data.add("idType","cn");   //en ����Ϊ���ģ�������� ����Ϊ����
			checkPwd_Packet.data.add("idNum","");       //����
			checkPwd_Packet.data.add("loginNo","");			
		
			core.ajax.sendPacket(checkPwd_Packet);
			//delete(checkPwd_Packet);	
			checkPwd_Packet=null;	
		}
		//-------------------------------------
		function payWayChange()
		{
		    var payWay = document.frm1102.payCode.value;
		    var chPos = payWay.indexOf("����");
		    var obj = "tbBank" + 0;
		    if(chPos > 0)
		    {
		        document.all(obj).style.display = "";
		    }
		    else
		    {
		        document.all(obj).style.display = "none";
		        frm1102.bankCode.value = "";
		        frm1102.postCode.value = "";
		    }
		}
		
		function getBankCode()
		{ 
		  	//���ù���js�õ����д���
		    var pageTitle = "���д����ѯ";
		    var fieldName = "���д���|��������";
		    var sqlStr = "select BANK_CODE,BANK_NAME from sBankCode " +
		                "where REGION_CODE = '" + document.frm1102.unitCode.value.substring(0,2) + "'" +
		                " and DISTRICT_CODE ='" + document.frm1102.unitCode.value.substring(2,4) + "'";
		    if(document.frm1102.bankName.value != "")
		    {
		        sqlStr = sqlStr + " and BANK_NAME like '%" + document.frm1102.bankName.value + "%'";
		    }
		    //sqlStr = sqlStr + " and rowNum <" + <%=rowNum%> ;  
		    var selType = "S";    //'S'��ѡ��'M'��ѡ
		    var retQuence = "0|1";
		    var retToField = "bankCode|bankName|";
		    PubSimpSel(pageTitle,fieldName,sqlStr,selType,retQuence,retToField);        	       	   
		}
		
		function getPostCode()
		{ 
		  	//���ù���js�õ����д���
		    var pageTitle = "�ַ����д����ѯ";
		    var fieldName = "���д���|��������";
		    var sqlStr = "select POST_BANK_CODE,BANK_NAME from sPostCode " +
		                "where REGION_CODE = '" + document.frm1102.unitCode.value.substring(0,2) + "'";
		    if(document.frm1102.postName.value != "")
		    {
		        sqlStr = sqlStr + " and BANK_NAME like '%" + document.frm1102.postName.value + "%'";
		    }
		   // sqlStr = sqlStr + " and rowNum <" + <%=rowNum%> ;  
		    sqlStr = sqlStr + "  order by POST_BANK_CODE " ;
			var selType = "S";    //'S'��ѡ��'M'��ѡ
		    var retQuence = "0|1";
		    var retToField = "postCode|postName|";
		    PubSimpSel(pageTitle,fieldName,sqlStr,selType,retQuence,retToField);   	       	   
		}
		 
		function jspReset()
		{
		        var obj = null;
		        var t = null;
		    	var i;   	
		        for (i=0;i<document.frm1102.length;i++)
		        {    
		    		obj = document.frm1102.elements[i];		 		 		 
		    		packUp(obj); 
		    	    obj.disabled = false;
		         }        
		        document.frm1102.commit.disabled = "none"; 
		}
		//��ӡ��Ϣ---------------------------------------------------
		function printInfo(printType)
		{
		    var retInfo = "";
		    if(printType == "Detail")
		    {	
			<%
		        	//ȡ�ô�ӡ��ˮ		        
			                String sqlStr ="select sMaxSysAccept.nextval as accept from dual";			              
		                %>
		                <wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>"  retcode="retCode1" retmsg="retMsg1" outnum="1">
					<wtc:sql><%=sqlStr%></wtc:sql>
				</wtc:pubselect>
				<wtc:array id="result1" scope="end" />
		                <%
		                if(result1!=null&&result1.length>0){
					result = result1;					    		
				}		              
		                if(result!=null&&result.length>0){
		                	 printAccept = (result[0][0]).trim();
		                }else{%>
		                	<SCRIPT type=text/javascript>
						rdShowMessageDialog('ȡ���������ӡ��ˮʧ�ܣ�',0);
					</SCRIPT>
		                	
		                <%
		                }
		               
		                
		%>          
										
				//��ӡ�������	        	
			
				
				var cust_info=""; //�ͻ���Ϣ
	      			var opr_info=""; //������Ϣ
	      			var retInfo = "";  //��ӡ����
	      			var note_info1=""; //��ע1
	      			var note_info2=""; //��ע2
	      			var note_info3=""; //��ע3
	      			var note_info4=""; //��ע4
	      						
				cust_info+="�ͻ�������   "+frm1102.custName.value+"|";	      		         	
      		         	cust_info+="�ͻ���ַ��   "+frm1102.custAddr.value+"|";
      		         	cust_info+="֤�����룺   "+frm1102.idIccid.value+"|";
				cust_info+= "�ʻ�ID��   "+frm1102.accountId.value+"|";
				cust_info+= "�ʻ����ƣ�   "+frm1102.accountName.value+"|";
				cust_info+= "���ʽ��   "+frm1102.payCode.value+"|";
				
				opr_info+= "��ӡ��ˮ��" + "<%=printAccept%>" + "|";				
				opr_info+= "�ʻ�������*|";
				
				note_info1+="��ע��"+document.all.sysNote.value+"|";
				 retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
  	      			retInfo=retInfo.replace(new RegExp("#","gm"),"%23"); //�ѡ�#"�滻Ϊurl��ʽ
    	      			return retInfo;	
		
			}  
		    if(printType == "Bill")
		    {	//��ӡ��Ʊ
			}
			return retInfo;	
		}
		//-----------------------------------------------------
		function showPrtDlg(printType,DlgMessage,submitCfm)
		{  
			var pType="print";                     // ��ӡ����print ��ӡ subprint �ϲ���ӡ
	     		var billType="1";                      //  Ʊ������1���������2��Ʊ��3�վ�
			var sysAccept ="<%=printAccept%>";                       // ��ˮ��
			var printStr = printInfo(printType);   //����printinfo()���صĴ�ӡ����
			
			var mode_code=null;                        //�ʷѴ���
			var fav_code=null;                         //�ط�����
			var area_code=null;                    //С������
			var opCode =   "<%=opCode%>";                         //��������
			var phoneNo = "";                           //�ͻ��绰	
		
			 //��ʾ��ӡ�Ի��� 
			var h=180;
			var w=350;
			var t=screen.availHeight/2-h/2;
			var l=screen.availWidth/2-w/2;	
			
			 var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no" 	   
		   	var path = "<%=request.getContextPath()%>/npage/innet/hljBillPrint_jc.jsp?DlgMsg=" + DlgMessage+ "&submitCfm=" + submitCfm;
			var path=path+"&mode_code="+mode_code+"&fav_code="+fav_code+"&area_code="+area_code+"&opCode=<%=opCode%>&sysAccept="+sysAccept+"&phoneNo="+phoneNo+"&submitCfm="+submitCfm+"&pType="+pType+"&billType="+billType+ "&printInfo=" + printStr;
			var ret=window.showModalDialog(path,printStr,prop);
			    //if(typeof(ret)!="undefined")
			   {
			       //if((ret=="confirm")&&(submitCfm == "Yes"))
			       {
				       if(rdShowConfirmDialog("ȷ��Ҫ�ύ�ʻ�������Ϣ��")==1)
				       {
					       frm1102.action="f1102_2.jsp";
					       frm1102.submit();
					   }
					}		        
		   }
		}
		
		function jspCommit()
		{
		 		document.frm1102.commit.disabled = "none";
				with(document.frm1102)
				{
						action="f1102_2.jsp"
						submit();
				}		
		}
		
		function rpc_chkX(x_type,x_no,chk_kind)
		{
		  var obj_type=document.all(x_type);
		  var obj_no=document.all(x_no);
		  var idname="";		  
		  if(obj_type.type=="text")
		  {		     
		    idname=obj_type.value.trim();
		  }
		  else if(obj_type.type=="select-one")
		  {		   
		    idname=obj_type.options[obj_type.selectedIndex].text.trim();  
		  }		  
		  if(obj_no.value.trim().length>0)
		  {
		    if(obj_no.value.trim().length<5)
			{
		      rdShowMessageDialog("֤�����볤����������5λ����");
			  obj_no.focus();
		  	  return false;
			}
			else
			{
		      if(idname=="���֤")
			  {
		           //if(checkElement(x_no)==false) return false;
			  }
			}
		  }
		  else 
			return;
		
		  var myPacket = new AJAXPacket("/npage/innet/chkX.jsp","������֤��������Ϣ�����Ժ�......");
		  myPacket.data.add("retType","chkX");
		  myPacket.data.add("retObj",x_no);
		  myPacket.data.add("x_idType",getX_idno(idname));
		  myPacket.data.add("x_idNo",obj_no.value);
		  myPacket.data.add("x_chkKind",chk_kind);
		  core.ajax.sendPacket(myPacket);
		  myPacket=null;
		  //delete(myPacket);
		  
		}
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
		
		</script>		
	</HEAD>
 
<body>
<FORM method=post name="frm1102" action="f1102_2.jsp" onKeyUp="chgFocus(frm1102)">
	<%@ include file="/npage/include/header_pop.jsp" %>
	<div class="title">
		<div id="title_zi">�ʻ�����</div>
	</div>
     <table  cellspacing="0">
          <TBODY> 
                <TR> 
                  	<TD width="16%" class="blue"> 
                   		�ͻ�֤������
                  	</TD>
                  	<TD width="34%"> 
                  		<input id="in2" name=idIccid readonly  Class="InputGrey" v_must=1 v_type="string"  onKeyup="if(event.keyCode==13)getInfo_IccId();" maxlength="20"  index="2">
                    		<font class="orange">*</font>		
                    		<input type="button" name=custIdQuery class="b_text"  onClick="choiceSelWay();"  style="cursor:hand" id="custIdQuery" value="�ͻ���ѯ">
                  	</TD>
                  	<TD width=16% class="blue"> 
                   		�ͻ�����
                  	</TD>
                  	<TD width="34%"> 
				<jsp:include page="/npage/common/pwd_1.jsp">
			                <jsp:param name="width1" value="16%"  />
			                <jsp:param name="width2" value="34%"  />
			                <jsp:param name="pname" value="custPwd"  />
			                <jsp:param name="pwd" value="12345"  />
		 	        </jsp:include>				
	                    	<input name=accountIdQuery2 class="b_text" type=button onClick="change_custPwd();"  value="У��" disabled >
                  	</TD>
                </TR>
                <TR> 
                  	<TD class="blue"> 
                   		�ͻ�����
                  	</TD>
                  	<TD> 
                  		<input id='in4'  name=custName onKeyup="if(event.keyCode==13)getInfo_withName();" maxlength="60" size=33>
                   		<font class="orange">*</font>
                   	</TD>
                       <td class="blue"> 
                   		�ͻ�֤������
                  	</TD>
                  	<TD> 
                    		<input id='in3'  name=idType readonly Class="InputGrey">
                  	</TD>
                </TR>
                <TR> 
                  	<TD class="blue"> 
                   		�ͻ�ID
                  	</TD>
                  	<TD> 
                    		<input id='in0'  name=custId v_type=int v_must=1 onKeyup="if(event.keyCode==13)getInfo_withId();" maxlength="22">
                    		<font class="orange">*</font>
                    	</TD>
                 	<TD class="blue"> 
                   		�ͻ���ַ
                  	</TD>
                  	<TD> 
                    		<input id='in5'  size=35 name=custAddr   readonly Class="InputGrey">
                  	</TD>
                </TR>
                <TR> 
                  	<TD class="blue"> 
                   		�ʻ�ID
                  	</TD>
                  	<TD> 
                    		<input  name=accountId v_must=1 v_type="0_9"  maxlength="22" readonly Class="InputGrey">
                    		<font class="orange">*</font>	
                    		<input name=accountIdQuery type=button class="b_text" onmouseup="getId()" onkeyup="if(event.keyCode==13)getId()"  value=��� index="4" disabled >
                       </TD>
                  	<TD class="blue"> 
                   		�ʻ�����
                  	</TD>
                  	<TD> 
                    		<input name=accountName  v_must=1 v_maxlength=60 v_type="string"  maxlength="60" size=33 index="5">
                    		<font class="orange">*</font>	 
                    	</TD>
                </TR>
		<TR>      
			<jsp:include page="/npage/common/pwd_2.jsp">
			 	<jsp:param name="width1" value="16%"  />
				<jsp:param name="width2" value="34%"  />
				<jsp:param name="pname" value="newPwd"  />
				<jsp:param name="pcname" value="cfmPwd"  />
			 </jsp:include>
		</TR>	
                <TR> 
                  	<TD class="blue"> 
                   		�ʻ�����
                  	</TD>
                  	<TD> 
                    		<select align="left" name=accountType width=50  index="8">
		                      <%
					    //�õ���������ʻ�����
					 	 sqlStr ="select trim(ACCOUNT_TYPE), TYPE_NAME from sAccountType order by ACCOUNT_TYPE"; 
						//retArray = callView.view_spubqry32("2",sqlStr);
					    	//result = (String[][])retArray.get(0);
					    	%>
					    	<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>"  retcode="retCode2" retmsg="retMsg2" outnum="2">
							<wtc:sql><%=sqlStr%></wtc:sql>
						</wtc:pubselect>
						<wtc:array id="result2" scope="end" />
					    	<%
					    		int recordNum=0;
						    	if(result2!=null&&result2.length>0){
						    		result = result2;
						    		recordNum=result.length;
						    	}
						      	
					      	for(int i=0;i<recordNum;i++){
					        	out.println("<option class='button' value='" + result[i][0] + "'>" + result[i][1] + "</option>");
					      	}
					     	 
					%>
                    		</select>
                  </TD>
                  <TD class="blue"> 
                   	���ʽ
                  </TD>
                  <TD> 
                    	<select align="left" name=payCode onchange="payWayChange()" width=50 index="9">
                      		<%
				    //�õ���������ʻ�����
				 
				      		 sqlStr ="select trim(PAY_CODE)||'-'||trim(PAY_NAME),trim(PAY_NAME) from sPayCode where REGION_CODE= '" + regionCode.substring(0,2) +"' order by PAY_CODE";
				      		//retArray = callView.view_spubqry32("2",sqlStr);
				      		%>
				      		<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>"  retcode="retCode3" retmsg="retMsg3" outnum="2">
							<wtc:sql><%=sqlStr%></wtc:sql>
						</wtc:pubselect>
						<wtc:array id="result3" scope="end" />
				      		<%
					      		if(result3!=null&&result3.length>0){
						    		result = result3;					    		
						    	}
				       		//result = (String[][])retArray.get(0);
				      		recordNum = 1;
				      		for(int i=0;i<recordNum;i++){
				        		out.println("<option class='button' value='" + result[0][0] + "'>" + result[0][1] + "</option>");
				      	       }
				%>
                    </select>
                  </TD>
                </TR>
                </TBODY> 
              </TABLE>  
                   
            
              <TABLE id=tbBank0 cellSpacing="0" style="display:none">
                <TBODY> 
	                <TR > 
		                  <TD class="blue"> 
		                   	�ʺ�
		                  </TD>
		                  <TD colspan="3"> 
		                    	<input name=accountNo   maxlength="30" index="10">
		                  </TD>
	                </TR>
                	<TR> 
		                  <TD width=16% class="blue"> 
		                   	���д���
		                  </TD>
		                  <TD width=34%> 
		                    	<input name=bankCode size=12  maxlength="12" readonly  Class="InputGrey">
		                    	<input name=bankName size=13  onkeyup="if(event.keyCode==13)getBankCode();" readonly index="11" Class="InputGrey">
		                    	<input name=bankCodeQuery type=button  id="bankCodeQuery" style="cursor:hand" onClick="getBankCode()" value=��ѯ index="12">
		                  </TD>
		                  <TD width=16% class="blue"> 
		                   	�ַ����д���
		                  </TD>
		                  <TD width=34%> 
			                    <input name=postCode size=12  maxlength="12" readonly Class="InputGrey">
			                    <input name=postName size=13  onkeyup="if(event.keyCode==13)getPostCode();" index="13">
			                    <input name=postCodeQuery type=button  id="postCodeQuery" style="cursor:hand" onClick="getPostCode()" value=��ѯ index="14">
		                  </TD>
                	</TR>
                </TBODY> 
              </TABLE>  	
              <TABLE  cellSpacing="0">
	                <TBODY> 
		                <TR> 
		                 	 <TD width=16% class="blue"> 
		                   		��ʼ����
		                  	</TD>
		                  	<TD> 
		                     		<input  name=beginDate v_type="date"  v_must=1 value="<%=new SimpleDateFormat("yyyyMMdd", Locale.getDefault()).format(new Date())%>" maxlength="20" readonly Class="InputGrey">
		                                <input  name=endDate date  v_must=1 maxlength="20" value="20501231" readonly style="display:none" Class="InputGrey">
		                  	</TD>
		               </TR>	
		                <tr> 
		                	<td class="blue">
		                      		ϵͳ��ע
		                  	</td>
			                <td> 
			                    	<input  name=sysNote size=60 readonly maxlength="60"  Class="InputGrey">
			                </td>
	                	</tr> 
	                	<input name=opNote  type="hidden" size=60 maxlength="60"  index="15" v_must=0 v_maxlength=60 v_type="string" >     	              
	                </TBODY> 
              </TABLE>                             
                      
        	<TABLE  cellSpacing="0">
	          <TBODY>
		            <TR> 
			              <TD id="footer" >
			                    <input class="b_foot_long" name=print  onmouseup="printCommit()" onkeyup="if(event.keyCode==13)printCommit()" type=button value=ȷ��&��ӡ index="16" disabled>
					    <input class="b_foot" name=reset1   type=button onClick="frm1102.reset();" value=��� index="17">
					     <input class="b_foot" name=back   onclick="window.close()" type=button value=�ر� index="18">
					</TD>
		            </TR>
	          </TBODY>
        	</TABLE> 
		  <input type="hidden" id=in1 name="hidPwd" >
		  <input type="hidden" name="hidCustPwd">  <!--�ͻ����ܺ������-->
		  <input type="hidden" name="workno" value=<%=workNo%>>
		  <input type="hidden" name="regionCode" value=<%=regionCode%>> 
		  <input type="hidden" id=in6 name="belongCode" value=<%=belongCode%>>
		  <input type="hidden" name="unitCode" value=<%=Department%>>
		  <input type="hidden" name="ip_Addr" value=<%=ip_Addr%>>
		  <input type="hidden" name="inParaStr" >
		  <input type="hidden" name="checkPwd_Flag" value="false">		<!--����У���־-->
		  <input type="hidden" name="workName" value=<%=workName%> >
 		  <jsp:include page="/npage/common/pwd_comm.jsp"/>
 		  <%@ include file="/npage/include/footer_pop.jsp" %> 
		</form>
	</body>
	<SCRIPT type=text/javascript>
		document.frm1102.idIccid.value = '<%=agentPaper%>';
	
		for(i = 0;i < document.frm1102.accountType.length;i++){
				document.frm1102.accountType.options[i].text = "";
				document.frm1102.accountType.options[i].value = "";
			}
		document.frm1102.accountType.length = 1;
		document.frm1102.accountType.options[0] = new Option("���г�ֵ�ʻ�","a");
	</SCRIPT> 
</html>
                                                                                                                                                                          
<%
/********************
 version v2.0
������: si-tech
********************/
%>

<%
	String opCode = request.getParameter("opCode");
  String opName = request.getParameter("opName");
%>              

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http//www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http//www.w3.org/1999/xhtml">
<%@ include file="/npage/include/public_title_name.jsp" %> 

<%@ page contentType="text/html; charset=gb2312" %>
<%@ taglib uri="weblogic-tags.tld" prefix="wl" %>



<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<%@ page import="com.sitech.boss.pub.*" %>
<%@ page import="com.sitech.boss.pub.config.*" %>
<%@ page import="com.sitech.boss.pub.conn.*" %>
<%@ page import="com.sitech.boss.pub.exception.*" %>
<%@ page import="com.sitech.boss.pub.util.*" %>
<%@ page import="com.sitech.boss.pub.wtc.*" %>
<%@ page import="com.sitech.boss.pub.CallRemoteResultValue" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.io.*" %>

<%        
                String[][] result = new String[][]{};
                String printAccept = "";  
%>
<%
                String workNo = (String)session.getAttribute("workNo");
                String workName = (String)session.getAttribute("workName");
                String Department = (String)session.getAttribute("orgCode");
                String belongCode = Department.substring(0,7);
                String ip_Addr = (String)session.getAttribute("ipAddr");
                String regionCode = (String)session.getAttribute("regCode");
        		String rowNum = "16";
        		String getAcceptFlag = "";
%>
<!------------------------------------------------------------->

<html>
<head>
<title>������������</title>
<meta content=no-cache http-equiv=Pragma>
<meta content=no-cache http-equiv=Cache-Control>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
</head>
<!----------------------------------------------------------------->
 


<SCRIPT type=text/javascript>
 
onload=function(){
        
        
	    if(typeof(frm1100.custId)!="undefined")
	    {   
	        if(frm1100.custId.value != "")      //�ָ����ύǰ�Ŀͻ�ID��ť��ʾ״̬
	        {       frm1100.custQuery.disabled = true;           }
        }
        if((typeof(frm1100.idType)!="undefined")&&(typeof(frm1100.idIccid)!="undefined"))
        {	change_idType();	}  //��ԭ���ύǰ��֤������   
        
}

function doProcess(packet)
{
   	//RPC������findValueByName
    var retType = packet.data.findValueByName("retType");
    var retCode = packet.data.findValueByName("retCode"); 
    var retMessage = packet.data.findValueByName("retMessage"); 
    self.status="";
 
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
        }
        else
        {
            retMessage = retMessage + "[errorCode1:" + retCode + "]";
                rdShowMessageDialog(retMessage,0);
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
	    	rdShowMessageDialog("�ϼ��ͻ�����У��ʧ�ܣ����������룡",0);
	    	frm1100.parentPwd.value = "";
	    	frm1100.parentPwd.focus();
	    	frm1100.checkPwd_Flag.value = "false";	    	
	    	return false;	        	
	    }
		else
		{
			rdShowMessageDialog("�ϼ��ͻ�����У��ɹ���");
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
               //var recordNum = acket.data.findValueByName("recordNum"); 
               //showParentInfo(retInfo);       
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
			   rdShowMessageDialog("�ͻ������ڣ�",0);  
			   return false;
			 }
         }           
         else
         {
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
          document.all.print.disabled=false;
		}
        else if(retCode=="100001")
        {
             retMessage = retCode + "��"+retMessage;			 
             rdShowMessageDialog(retMessage,0);
		     //document.all.print.disabled=true;
			 document.all.print.disabled=false;
			 //document.all(retObj).focus();
			 //return false;
			 return true;
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
   //=================================================================
   
   else if(retType=="4100chgSim"){

	 	
		var WORK_FLOW_DIRECTION = packet.data.findValueByName("WORK_FLOW_DIRECTION");
		var CONFIRM_FLAG = packet.data.findValueByName("CONFIRM_FLAG");
		var CUST_NAME = packet.data.findValueByName("CUST_NAME");
		var CUST_SEX = packet.data.findValueByName("CUST_SEX");
		var CUST_BIRTHDAY= packet.data.findValueByName("CUST_BIRTHDAY");
		var ID_TYPE = packet.data.findValueByName("ID_TYPE");
		var ID_ICCID = packet.data.findValueByName("ID_ICCID");
		var MARK_TRANS_VALUE = packet.data.findValueByName("MARK_TRANS_VALUE");
		var CUST_TYPE = packet.data.findValueByName("CUST_TYPE");
		var VIP_NO = packet.data.findValueByName("VIP_NO");
		var OLD_INNET_TIME = packet.data.findValueByName("OLD_INNET_TIME");
		var LIMIT_OWE = packet.data.findValueByName("LIMIT_OWE");
		var FUNC_LIST = packet.data.findValueByName("FUNC_LIST");
		var DATA_LIST = packet.data.findValueByName("DATA_LIST");
		var TOTAL_MARK = packet.data.findValueByName("TOTAL_MARK");
		var TOTAL_MARK_BEGIN_TIME = packet.data.findValueByName("TOTAL_MARK_BEGIN_TIME");
		var MONTH_CONSUME = packet.data.findValueByName("MONTH_CONSUME");
		var MARRY_STATUS = packet.data.findValueByName("MARRY_STATUS");
		var EDUCATION_GRADE = packet.data.findValueByName("EDUCATION_GRADE");
		var OLD_WORK_ADDRESS = packet.data.findValueByName("OLD_WORK_ADDRESS");
		var OLD_WORK_HEADSHIP = packet.data.findValueByName("OLD_WORK_HEADSHIP");
		var PERSON_LOVING = packet.data.findValueByName("PERSON_LOVING");
		var FAMILY_MEMBER = packet.data.findValueByName("FAMILY_MEMBER");
		var CUST_LEVEL = packet.data.findValueByName("CUST_LEVEL");

		document.all.WORK_FLOW_DIRECTION.value = WORK_FLOW_DIRECTION;
		document.all.CONFIRM_FLAG.value = CONFIRM_FLAG;
		document.all.custName.value = CUST_NAME;
		document.all.custSex.value = CUST_SEX;
		document.all.birthDay.value = CUST_BIRTHDAY;
		document.all.idType.value = ID_TYPE;
		document.all.idIccid.value = ID_ICCID;
		document.all.MARK_TRANS_VALUE.value = MARK_TRANS_VALUE;
		document.all.ownerType.value = CUST_TYPE;
		document.all.VIP_NO.value = VIP_NO;
		document.all.OLD_INNET_TIME.value = OLD_INNET_TIME;
		document.all.LIMIT_OWE.value = LIMIT_OWE;
		document.all.FUNC_LIST.value = FUNC_LIST;
		document.all.DATA_LIST.value = DATA_LIST;
		document.all.TOTAL_MARK.value = TOTAL_MARK;
		document.all.TOTAL_MARK_BEGIN_TIME.value = TOTAL_MARK_BEGIN_TIME;
		document.all.MONTH_CONSUME.value = MONTH_CONSUME;
		document.all.MARRY_STATUS.value = MARRY_STATUS;
		document.all.vudyXl.value = EDUCATION_GRADE;
		document.all.custAddr.value = OLD_WORK_ADDRESS;
		document.all.OLD_WORK_HEADSHIP.value = OLD_WORK_HEADSHIP;
		document.all.custAh.value = PERSON_LOVING;
		document.all.FAMILY_MEMBER.value = FAMILY_MEMBER;
		document.all.custMark.value = TOTAL_MARK;
		document.all.CreditShow.value = LIMIT_OWE;
		document.all.VIPlevel.value = CUST_LEVEL;
		document.all.VIPNo.value = VIP_NO;

    document.all.print.disabled=false;
	}
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

function check_oldCust(){
	document.all.Reset.click();
	document.all.oldCust.checked=true;
         //���ͻ�����������    
    
}

function change(){      
        //�Ը�������������Ŀ���       
        var ic = document.frm1100.ownerType.options[document.frm1100.ownerType.selectedIndex].test;       
		if(ic=="����")
	    { 
          document.all("tb0").style.display="";   
		   document.all("tb1").style.display="none";      
		   document.all("td2").style.display="none";
		}
		else if(ic=="����")
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

function change_idType()
{
    var Str = document.frm1100.idType.value;
    if(Str.indexOf("���֤") > -1)
    {   document.frm1100.idIccid.v_type = "idcard";   }
    else
    {   document.frm1100.idIccid.v_type = "string";   }
}
function change_custPwd()
{   
    check_HidPwd(frm1100.parentPwd.value,"show",(frm1100.in1.value).trim(),"hid");
    /*
    if(frm1100.checkPwd_Flag.value != "true");
    {
    	rdShowMessageDialog("�ϼ��ͻ�����У��ʧ�ܣ����������룡",0);
    	frm1100.parentPwd.value = "";
    	frm1100.parentPwd.focus();
    	return false;	        	
    }
    frm1100.checkPwd_Flag.value = "false"; 
    */
}
//------------------------------------
function printCommit()
{       
		var obj = null;
		//��ȷ�ϴ�ӡ����������ڴ�ӡ��Ʊ
        
        
        change_idType();   //�жϿͻ�֤�������Ƿ������֤ 
        if((frm1100.contactMail.value).trim() == ""){
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
        }
        else if((typeof(frm1100.yzrq)!="undefined")&&
           (frm1100.yzrq.value != "")&&
           (document.all(obj1).style.display == ""))
        {	
        	if(forDate(frm1100.yzrq) == false)
        	{	return false;		}			
        }
		var d= (new Date().getFullYear().toString()+(((new Date().getMonth()+1).toString().length>=2)?(new Date().getMonth()+1).toString():("0"+(new Date().getMonth()+1)))+(((new Date().getDate()).toString().length>=2)?(new Date().getDate()):("0"+(new Date().getDate()))).toString());

		if((frm1100.idValidDate.value).trim().length>0)
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
		if(document.all.ownerType.value=="����")
		{
             if((document.all.birthDay.value).trim().length>0)
		     {
		       if(to_date(frm1100.birthDay)>=d)
		       {
			     rdShowMessageDialog("���������ڲ������ڵ�ǰʱ�䣬���������룡");
	             document.all.birthDay.focus();
			     document.all.birthDay.select();
		         return false;
		       }
			 }
		}
		else
		{
             if((document.all.yzrq.value).trim().length>0)
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

 
        //--------------------------             
        if(check(frm1100))
        {
 		     if((document.all.custPwd.value).trim().length>0)
			  {
			     if(document.all.custPwd.value.length!=6)
				 {
				   rdShowMessageDialog("�ͻ����볤������");
    	           document.all.custPwd.focus();
				   return false;
				 }
			     if(checkPwd(document.frm1100.custPwd,document.frm1100.cfmPwd)==false)
				    return false;
			  }
	        var t = null;
	        var i;
	        
	        //document.frm1100.sysNote.value = sysNote;
			if((document.all.opNote.value).trim().length==0)
			{
              document.all.opNote.value="<%=workName%>"+"�Կͻ�["+(document.all.custName.value).trim()+"]("+document.all.ownerType.value+")���п�������ҵ��";
              document.all.sysNote.value = document.all.opNote.value;
			}
			if((document.all.opNote.value).trim().length>30)
			{
				rdShowMessageDialog("�û���ע��ֵ����ȷ�������д���");
				document.all.opNote.focus();
				return false;
			}
	        //showPrtDlg("Detail","ȷʵҪ��ӡ���������","Yes");
	        
	        if(rdShowConfirmDialog("ȷ��Ҫ�ύ�ͻ�������Ϣ��")==1)
       		{
       			/********************liucm*************************/
       			with(document.all)
   {	
		
		
	   document.all.str1.value=custId.value+"~<%=regionCode%>"+districtCode.value+"999"+"~"+custName.value+"~"+custPwd.value+"~"+custStatus.value+"~"+"00"+"~01~"+custAddr.value+"~";
	   document.all.str2.value="0~"+idIccid.value+"~"+idAddr.value+"~"+idValidDate.value+"~";
	   document.all.str3.value=contactPerson.value+"~"+contactPhone.value+"~"+contactAddr.value+"~"+contactPost.value+"~"+contactMAddr.value+"~"+contactFax.value+"~"+contactMail.value+"~";
	   document.all.str4.value="<%=Department%>"+"~0~0~"+birthDay.value+"~"+professionId.value+"~00~"+custAh.value+"~"+custXg.value+"~";
	   document.all.str5.value="1104"+"~"+"<%=workNo%>"+"~sysNote~"+opNote.value+"~"+ip_Addr.value+"~0~";
 
    }
       			
       			/****************liucmend***********************/
	       		document.frm1100.action="f4101_1.jsp";
	       		document.frm1100.submit();
		   		return true;
	   		}
    	}    
}

function chkValid()
{
     var d= (new Date().getFullYear().toString()+(((new Date().getMonth()+1).toString().length>=2)?(new Date().getMonth()+1).toString():("0"+(new Date().getMonth()+1)))+(((new Date().getDate()).toString().length>=2)?(new Date().getDate()):("0"+(new Date().getDate()))).toString());

	 if((frm1100.idValidDate.value).trim().length>0)
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
//-------------------------------------------------------
function printInfo(printType)
{
    var retInfo = "";
    if(printType == "Detail")
    {	//��ӡ�������
<%
        //ȡ�ô�ӡ��ˮ
        try
        {
                %>
       <wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="region" routerValue="<%=regionCode%>"  id="sysAcceptl" /> 
                <%
                printAccept = sysAcceptl;
        }catch(Exception e){
                out.println("rdShowMessageDialog('ȡϵͳ������ˮʧ�ܣ�',0);");
                getAcceptFlag = "failed";
        }              
%>     	
        var getAcceptFlag = "<%=getAcceptFlag%>";
        if(getAcceptFlag == "failed")
        {	return "failed";	}
		
		//��ӡ�������
		retInfo+= "�ͻ�����:     "+frm1100.custName.value+"|";
		retInfo+= "֤������:     "+frm1100.idIccid.value+"|";
		retInfo+= "֤����ַ:     "+frm1100.idAddr.value+"|";

		retInfo+= "��ϵ������:   "+frm1100.contactPerson.value+"|";
		retInfo+= "��ϵ�˵绰:   "+frm1100.contactPhone.value+"|";
		retInfo+= "��ϵ�˵�ַ:   "+frm1100.contactAddr.value+"|";
		
		
		retInfo+= "��ӡ��ˮ:     " + "<%=printAccept%>" + "|";
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
{  //��ʾ��ӡ�Ի��� 
   var h=150;
   var w=350;
   var t=screen.availHeight/2-h/2;
   var l=screen.availWidth/2-w/2;
   var printStr = printInfo(printType);
   if(printStr == "failed")
   {	return false;	}
   var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no" 
   var path = "gdPrint_1100.jsp?DlgMsg=" + DlgMessage;
   var path = path + "&printInfo=" + printStr + "&submitCfm=" + submitCfm;
   var ret=window.showModalDialog(path,"",prop);

   //if(typeof(ret)!="undefined")
   {
     //if((ret=="confirm")&&(submitCfm == "Yes"))
     {
       if(rdShowConfirmDialog("ȷ��Ҫ�ύ�ͻ�������Ϣ��")==1)
       {
	       frm1100.action="f1100_2.jsp";
	       frm1100.submit();
	   }
     }
   }
}
//--------------------------------------
function checkPwd(obj1,obj2)
{
        //����һ����У��,����У��
        var pwd1 = obj1.value;
        var pwd2 = obj2.value;
        if(pwd1 != pwd2)
        {
                var message = "'" + obj1.v_name + "'��'" + obj2.v_name + "'��һ�£����������룡";
                rdShowMessageDialog(message,0);
                if(obj1.type != "hidden")
                {   obj1.value = "";    }
                if(obj2.type != "hidden")
                {   obj2.value = "";    }
                obj1.focus();
                return false;
        }
        return true;
}
//-----------------------------------
function check_HidPwd(Pwd1,Pwd1Type,Pwd2,Pwd2Type)
{
 
    
	var checkPwd_Packet = new RPCPacket("pubCheckPwd.jsp","���ڽ�������У�飬���Ժ�......");
    checkPwd_Packet.data.add("retType","checkPwd");
	checkPwd_Packet.data.add("Pwd1",Pwd1);
	checkPwd_Packet.data.add("Pwd1Type",Pwd1Type);
	checkPwd_Packet.data.add("Pwd2",(Pwd2).trim());
	checkPwd_Packet.data.add("Pwd2Type",Pwd2Type);
	core.rpc.sendPacket(checkPwd_Packet);
	delete(checkPwd_Packet);		
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
        getUserId_Packet = null;
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
 	rdShowMessageDialog("�ͻ���Ϣ������ID��֤����������ƽ��в�ѯ��������������������Ϊ��ѯ������",0);
}
//------------------------------------------------------------------------
function getInfo_withId()
{
    //���ݿͻ�ID�õ������Ϣ
    if(document.frm1100.parentId.value == "")
    {
        rdShowMessageDialog("������ͻ�ID��",0);
        return false;
    }
	else
	{
	  if((document.all.parentId.value).trim().length>14)
	  {
         rdShowMessageDialog("�ͻ�ID��������",0);
         return false;
	  }
	}
    if(for0_9(frm1100.parentId) == false)
    {	
    	frm1100.parentId.value = "";
    	return false;	
    }
    var getIdPacket = new AJAXPacket("f1100_rpc.jsp","���ڻ���ϼ��ͻ���Ϣ�����Ժ�......");
        var parentId = document.frm1100.parentId.value;
        getIdPacket.data.add("retType","getInfo_withID");
        getIdPacket.data.add("fieldNum","6");
        getIdPacket.data.add("sqlStr","select to_char(a.CUST_ID),a.CUST_PASSWD,a.ID_ICCID,b.ID_NAME,a.CUST_NAME," +
                    " a.CUST_ADDRESS,a.REGION_CODE||a.DISTRICT_CODE||a.TOWN_CODE " + 
                    " from DCUSTDOC a,SIDTYPE b where a.CUST_ID=" +
                    parentId + " and b.ID_TYPE = a.ID_TYPE and rownum<500");
        core.ajax.sendPacket(getIdPacket);
        getIdPacket = null
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
    //var path = "../../page/public/fPubSimpSel.jsp";   //������ʾ
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
    //var path = "../../page/public/fPubSimpSel.jsp";   //������ʾ
    var path = "pubGetCustInfo.jsp";   //����Ϊ*
    path = path + "?sqlStr=" + sqlStr + "&retQuence=" + retQuence;
    path = path + "&fieldName=" + fieldName + "&pageTitle=" + pageTitle;
    path = path + "&selType=" + selType;  
    /*
    var ret = window.open (path, "���д���", 
	        "height=400, width=500,left=200, top=200,toolbar=no,menubar=no, scrollbars=yes, resizable=no, location=no, status=yes"); 
	ret.opener.bankCode.value = "1111111111";
	*/
    var retInfo = window.showModalDialog(path,"","dialogWidth:45;dialogHeight:35;");
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
	rpc_chkX("parentIdType","parentIdidIccid","B");
}
function rpc_chkX(x_type,x_no,chk_kind)
{
  var obj_type=document.all(x_type);
  var obj_no=document.all(x_no);
  var idname="";

  if(obj_type.type=="text")
  {
    idname=(obj_type.value).trim();
  }
  else if(obj_type.type=="select-one")
  {
    idname=(obj_type.options[obj_type.selectedIndex].text).trim();  
  }

  if((obj_no.value).trim().length>0)
  {
    if((obj_no.value).trim().length<5)
	{
      rdShowMessageDialog("֤�����볤����������5λ����");
	  obj_no.focus();
  	  return false;
	}
	else
	{
      if(idname=="���֤")
	  {
        if(checkElement(x_no)==false) return false;
	  }
	}
  }
  else 
	return;

  var myPacket = new AJAXPacket("../../npage/innet/chkX.jsp","������֤��������Ϣ�����Ժ�......");
  myPacket.data.add("retType","chkX");
  myPacket.data.add("retObj",x_no);
  myPacket.data.add("x_idType",getX_idno(idname));
  myPacket.data.add("x_idNo",obj_no.value);
  myPacket.data.add("x_chkKind",chk_kind);
  core.ajax.sendPacket(myPacket);
  myPacket = null;
  
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

//-------------------------------------------------
function getInfo_withName()
{ 
        ////���ݿͻ����Ƶõ������Ϣ
    if(document.frm1100.parentName.value == "")
    {
        rdShowMessageDialog("������ͻ����ƣ�",0);
        return false;
    }
    var pageTitle = "�ͻ���Ϣ��ѯ";
    var fieldName = "�ͻ�ID|�ͻ�����|����ʱ��|֤������|֤������|�ͻ���ַ|��������|�ͻ�����|";
    var sqlStr = "select to_char(a.CUST_ID),a.CUST_NAME,to_char(a.CREATE_TIME,'YYYY-MM-DD HH24:MI:SS'),b.ID_NAME,a.ID_ICCID," +
                     " a.CUST_ADDRESS,a.REGION_CODE||a.DISTRICT_CODE||a.TOWN_CODE," + 
                     " a.CUST_PASSWD from DCUSTDOC a,SIDTYPE b where " +
                     " a.CUST_NAME like '" + frm1100.parentName.value + "%'" +
                     " and b.ID_TYPE = a.ID_TYPE  and rownum<500 order by a.cust_name asc,a.create_time desc ";
    var selType = "S";    //'S'��ѡ��'M'��ѡ
    var retQuence = "7|0|1|3|4|5|6|7|";
    var retToField = "in0|in4|in3|in2|in5|in6|in1|"; 
    custInfoQuery(pageTitle,fieldName,sqlStr,selType,retQuence,retToField)                           
}

//-------------------------------------------------
function getInfo_IccId()
{ 
    //���ݿͻ�֤������õ������Ϣ
    if((document.frm1100.parentIdidIccid.value).trim().length == 0)
    {
        rdShowMessageDialog("������ͻ�֤�����룡",0);
        return false;
    }
	else if((document.frm1100.parentIdidIccid.value).trim().length < 5)
	{
        rdShowMessageDialog("֤�����볤������������λ����",0);
        return false;
	}

    var pageTitle = "�ͻ���Ϣ��ѯ";
    var fieldName = "�ͻ�ID|�ͻ�����|����ʱ��|֤������|֤������|�ͻ���ַ|��������|�ͻ�����|";
    var sqlStr = "������|�ͻ���ַ|��������|�ͻ�����|";
    var sqlStr = "������|�ͻ���ַ|��������|�ͻ�����|";
    var sqlStr = "������|�ͻ���ַ|��������|�ͻ�����|";
    var sqlStr = "select to_char(a.CUST_ID),a.CUST_NAME,to_char(a.CREATE_TIME,'YYYY-MM-DD HH24:MI:SS'),b.ID_NAME,a.ID_ICCID," +
                     " a.CUST_ADDRESS,a.REGION_CODE||a.DISTRICT_CODE||a.TOWN_CODE," + 
                     " a.CUST_PASSWD from DCUSTDOC a,SIDTYPE b where b.ID_TYPE = a.ID_TYPE " +
                     " and  a.ID_ICCID = '" + document.frm1100.parentIdidIccid.value + "'  and rownum<500 order by a.cust_name asc,a.create_time desc "; 
    var selType = "S";    //'S'��ѡ��'M'��ѡ
    var retQuence = "7|0|1|3|4|5|6|7|";
    var retToField = "in0|in4|in3|in2|in5|in6|in1|";
    custInfoQuery(pageTitle,fieldName,sqlStr,selType,retQuence,retToField);                    
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

function getInfo_Cust()
{
    var work_flow_no = document.all.WORK_FLOW_NO.value;
    var regionCode = document.all.regionCode.value;
    var getAccountId_Packet = new AJAXPacket("QrySimNo_4100.jsp","���ڻ����Ϣ�����Ժ�......");
    getAccountId_Packet.data.add("work_flow_no",work_flow_no);
    getAccountId_Packet.data.add("regionCode",regionCode);
		core.ajax.sendPacket(getAccountId_Packet);
		getAccountId_Packet = null
}

</SCRIPT>
<body onMouseDown="hideEvent()" onKeyDown="hideEvent()">
<FORM method=post name="frm1100" action="f1100_2.jsp"  onKeyUp="chgFocus(frm1100)">
 <%@ include file="/npage/include/header.jsp" %>                         

	<div class="title">
		<div id="title_zi">��������</div>
	</div>
	
              <TABLE cellspacing="0">
                <TBODY> 
                	
                <TR > 
                  <TD width="16%" class="blue">  
                    <div align="left">��������</div>
                  </TD>
                  <TD> 
                    <input name="newList" type="radio" value="0" checked index="2">
                    ԤԼ 
                    <input type="radio" name="newList" value="1" index="3">
                    ��Ȩ 
				  </TD>
                </TR>
                 <TR > 
                  <TD width="16%" class="blue"> 
                    <div align="left">������</div>
                  </TD>
                  <TD> 
                    <input id=WORK_FLOW_NO name=WORK_FLOW_NO   index="4">
                    <input name=custQuery  class="b_text" type=button id="custQuery"  onMouseUp="getInfo_Cust();" onKeyUp="if(event.keyCode==13)getInfo_Cust();" style="cursor:hand" value=��ѯ>
                  
				  </TD>
                </TR>
                </TBODY> 
              </TABLE>                                
               
              <TABLE cellSpacing="0" >
                <TBODY> 
                <TR > 
                  <TD width=16% class="blue"> 
                    <div align="left">�ͻ����</div>
                  </TD>
                  <TD width=34%> 
                  	<input type="test" name="ownerType"  readonly value="" v_must=1  onChange="change()">
 
                  </TD>
                  <TD width=16% class="blue"> 
                    <div align="left">�ͻ�ID</div>
                  </TD>
                  <TD width="34%" class="blue"> 
                    <input name=custId v_type="0_9"  v_must=1 v_name="�ͻ�ID" maxlength="14" readonly>
                    <font class="orange">*</font> 
                    <input name=custQuery type=button  onmouseup="getId();" onkeyup="if(event.keyCode==13)getId();" style="cursor:hand" id="accountIdQuery" value=���  class="b_text" index="7">
                  </TD>
                </TR>
                <TR > 
                  <TD class="blue"> 
                    <div align="left">�ͻ���������</div>
                  </TD>
                  <TD> 
                    <select align="left" name=districtCode width=50 index="8">
                      <%
        //�õ��������
        try
        {
                String sqlStr ="select trim(DISTRICT_CODE),DISTRICT_NAME from  SDISCODE Where region_code='" + regionCode + "' order by DISTRICT_CODE";                     
                %>
   <wtc:pubselect name="sPubSelect" outnum="2" retmsg="msg" retcode="code" routerKey="region" routerValue="<%=regionCode%>">
  	 <wtc:sql><%=sqlStr%></wtc:sql>
 	  </wtc:pubselect>
	 <wtc:array id="result_t" scope="end"/> 
                <%
                result = result_t;
                int recordNum = result.length;                  
                for(int i=0;i<recordNum;i++){
                        out.println("<option  value='" + result[i][0] + "'>" + result[i][1] + "</option>");
                }
        }catch(Exception e){
        }              
%>
                    </select>
                  </TD>
                  <TD class="blue"> 
                    <div align="left">�ͻ�����</div>
                  </TD>
                  <TD> 
                    <input name=custName  v_must=1 v_maxlength=60 v_type="string" v_name="�ͻ�����" onchange="change_ConPerson()"  maxlength="60" size=35 index="9">
                    <font class="orange">*</font> </TD>
                </TR>
                <tr > 
                  <td width=16% class="blue"> 
                    <div align="left">֤������</div>
                  </td>
                  <td width=34%> 
                  	<input type="test" name="idType"   readonly value="">
 
                  </td>
                  <td width=16% class="blue"> 
                    <div align="left">֤������</div>
                  </td>
                  <td width=34%> 
                    <input name=idIccid  v_must=1  v_minlength=5 v_maxlength=20 v_type="string" v_name="֤������" maxlength="18"  index="11" onblur="rpc_chkX('idType','idIccid','A')">
                    <font class="orange">*</font> </td>
                </tr>
                <tr > 
                  <td class="blue"> 
                    <div align="left">֤����ַ</div>
                  </td>
                  <td> 
                    <input name=idAddr  v_must=1  v_name="֤����ַ" maxlength="60" v_maxlength=60 size=35 index="12" onblur="document.all.custAddr.value=this.value;document.all.contactAddr.value=this.value;document.all.contactMAddr.value=this.value;">
                    <font class="orange">*</font> </td>
                  <td class="blue"> 
                    <div align="left">֤����Ч��</div>
                  </td>
                  <td> 
                    <input  name=idValidDate v_must=1  v_format=yyyyMMdd  v_maxlength=8 v_type="date" v_name="֤����Ч��" maxlength=8 size="8" index="13" onblur="chkValid();">
  									<font class="orange">*</font>
                  </td>
                </tr>
				
				
			 <TR >      
				   <jsp:include page="/npage/common/pwd_2.jsp">
					  <jsp:param name="width1" value="16%"  />
					  <jsp:param name="width2" value="34%"  />
					  <jsp:param name="pname" value="custPwd"  />
					  <jsp:param name="pcname" value="cfmPwd"  />
			 
				   </jsp:include>
			  </TR>
 
                <TR > 
                  <TD class="blue"> 
                    <div align="left">�ͻ�״̬</div>
                  </TD>
                  <TD colspan="3"> 
                    <select align="left" name=custStatus width=50 index="16">
                      <%
        //�õ��������
        try
        {
                String sqlStr ="select trim(STATUS_CODE),STATUS_NAME from sCustStatusCode order by STATUS_CODE";                      
                %>
 		<wtc:pubselect name="sPubSelect" outnum="2" retmsg="msg" retcode="code" routerKey="region" routerValue="<%=regionCode%>">
  	 <wtc:sql><%=sqlStr%></wtc:sql>
 	  </wtc:pubselect>
	 <wtc:array id="result_t1" scope="end"/>                
                <%
                result = result_t1;
                int recordNum = result.length;                  
                for(int i=0;i<recordNum;i++){
                        out.println("<option  value='" + result[i][0] + "'>" + result[i][1] + "</option>");
                }
        }catch(Exception e){
        }              
%>
                    </select>
                    <select  align="left" name=custGrade width=50 index="17" style="display='none'">
                      <%
        //�õ��������
        try
        {
                String sqlStr ="select trim(OWNER_CODE), TYPE_NAME from sCustGradeCode " + 
                   " where REGION_CODE ='" + regionCode + "' order by OWNER_CODE";   
                   %>
 		<wtc:pubselect name="sPubSelect" outnum="2" retmsg="msg" retcode="code" routerKey="region" routerValue="<%=regionCode%>">
  	 <wtc:sql><%=sqlStr%></wtc:sql>
 	  </wtc:pubselect>
	 <wtc:array id="result_t2" scope="end"/>                      
                   <%               
                result = result_t2;
                int recordNum = result.length;                  
                for(int i=0;i<recordNum;i++){
                        out.println("<option  value='" + result[i][0] + "'>" + result[i][1] + "</option>");
                }
        }catch(Exception e){
        }              
%>
                    </select>
                  </TD>
                </TR>
                <TR > 
                  <TD class="blue"> 
                    <div align="left">�ͻ���ַ</div>
                  </TD>
                  <TD colspan="3"> 
                    <input name=custAddr  v_type="string" v_must=0 v_maxlength=60 v_name="�ͻ���ַ" onchange="change_ConAddr()" maxlength="60" size=35 index="18">
                  </TD>
                </TR>
                <TR > 
                  <TD class="blue"> 
                    <div align="left">��ϵ������</div>
                    <font class="orange">*</font> 
                  </TD>
                  <TD class="blue"> 
                    <input name=contactPerson   v_must=1   v_type="string" v_name="��ϵ������" maxlength="20" size=20 index="19" v_must=0 v_maxlength=20>
                  </TD>
                  <TD class="blue"> 
                    <div align="left">��ϵ�˵绰</div>
                  </TD>
                  <TD> 
                    <input name=contactPhone  v_must=1 v_type="phone" v_name="��ϵ�˵绰" maxlength="20"  index="20" size="20">
                    <font class="orange">*</font> </TD>
                </TR>
                <TR > 
                  <TD class="blue"> 
                    <div align="left">��ϵ�˵�ַ</div>
                  </TD>
                  <TD> 
                    <input name=contactAddr    v_must=1   v_type="string" v_name="��ϵ�˵�ַ" maxlength="60" v_maxlength=60 size=35 index="21" onblur="document.all.contactMAddr.value=this.value;">
                    <font class="orange">*</font> </TD>
                  <TD class="blue"> 
                    <div align="left">��ϵ���ʱ�</div>
                    <font class="orange">*</font>
                  </TD>
                  <TD class="blue"> 
                    <input name=contactPost   v_must=1   v_type="zip" v_name="��ϵ���ʱ�" maxlength="6"  index="22" size="20">
                  </TD>
                </TR>
                <TR > 
                  <TD class="blue"> 
                    <div align="left">��ϵ�˴���</div>
                    <font class="orange">*</font>
                  </TD>
                  <TD class="blue"> 
                    <input name=contactFax   v_must=1  v_type="phone" v_name="��ϵ�˴���" maxlength="20"  index="23" size="20">
                  </TD>
                  <TD class="blue"> 
                    <div align="left">��ϵ��E_MAIL</div>
                  </TD>
                  <TD class="blue"> 
                    <input name=contactMail   v_must=1  v_type="email" v_name="��ϵ��E_MAIL" maxlength="30" size=30 index="24">
                  </TD>
                </TR>
                <TR > 
                  <TD class="blue"> 
                    <div align="left">��ϵ��ͨѶ��ַ</div>
                  </TD>
                  <TD colspan="3" class="blue"> 
                    <input name=contactMAddr  v_must=1 v_maxlenth=60 v_type="string" v_name="��ϵ��ͨѶ��ַ" maxlength="60" size=35 index="25">
                    <font class="orange">*</font> </TD>
                </TR>
                </TBODY> 
              </TABLE> 
                                        
              <TABLE id=tb0 width=100% border=0 align="center" cellSpacing=1 >
                <TBODY> 
                <TR > 
                  <TD width=16% class="blue"> 
                    <div align="left">�ͻ��Ա�</div>
                  </TD>
                  <TD width=34%> 
                  	<input type="test"   v_must=1  name="custSex"  readonly value="">
    
                  </TD>
                  <TD width=16%  class="blue"> 
                    <div align="left">��������</div>
                  </TD>
                  <TD width="34%"> 
                    <input  name=birthDay maxlength=8   v_must=1  index="27" v_format=yyyyMMdd    v_maxlength=8   v_name="��������" size="8">
                    <!--
                    <img src="../../js/common/date/button.gif" style="cursor:hand"  onclick="fPopUpCalendarDlg(birthDay);return false" alt=�������������˵� align=absMiddle >
                -->
                  </TD>
                </TR>
                <TR > 
                  <TD class="blue"> 
                    <div align="left">ְҵ���</div>
                  </TD>
                  <TD> 
                    <select align="left" name=professionId width=50 index="28">
                      <%
        //�õ��������
        try
        {
                String sqlStr ="select trim(PROFESSION_ID), PROFESSION_NAME from sprofessionid order by PROFESSION_ID DESC";                      
                %>
 		<wtc:pubselect name="sPubSelect" outnum="2" retmsg="msg" retcode="code" routerKey="region" routerValue="<%=regionCode%>">
  	 <wtc:sql><%=sqlStr%></wtc:sql>
 	  </wtc:pubselect>
	 <wtc:array id="result_t3" scope="end"/>                    
                <%
                result = result_t3;
                int recordNum = result.length;                  
                for(int i=0;i<recordNum;i++){
                        out.println("<option  value='" + result[i][0] + "'>" + result[i][1] + "</option>");
                }
        }catch(Exception e){
        }          
%>
                    </select>
                  </TD>
                  <TD class="blue"> 
                    <div align="left">ѧ��</div>
                  </TD>
                  <TD> 
                  	<input type="test" name="vudyXl"  readonly value="">
 
                  </TD>
                </TR>
                <TR > 
                  <TD class="blue"> 
                    <div align="left">�ͻ�����</div>
                  </TD>
                  <TD> 
                    <input name=custAh  maxlength="20"  index="30" size="20">
                  </TD>
                  <TD class="blue"> 
                    <div align="left">�ͻ�ϰ��</div>
                  </TD>
                  <TD> 
                    <input name=custXg  maxlength="20"  index="31">
                  </TD>
                </TR>

                <TR > 
                  <TD class="blue"> 
                    <div align="left">�ͻ�����</div>
                  </TD>
                  <TD> 
                    <input name=custMark  maxlength="20"  index="30" size="20">
                  </TD>
                  <TD class="blue"> 
                    <div align="left">���ö�</div>
                  </TD>
                  <TD> 
                    <input name=CreditShow  maxlength="20"  index="31">
                  </TD>
                </TR>
                <TR > 
                  <TD class="blue"> 
                    <div align="left">VIP����</div>
                  </TD>
                  <TD> 
                    <input name=VIPlevel  maxlength="20"  index="30" size="20">
                  </TD>
                  <TD class="blue"> 
                    <div align="left">VIP�����</div>
                  </TD>
                  <TD> 
                    <input name=VIPNo  maxlength="20"  index="31">
                  </TD>
                </TR>
                </TBODY> 
              </TABLE>                                
        
              <TABLE id=tb1   cellSpacing="0" style="display:none">
                <TBODY> 
                <TR > 
                  <TD width=16% class="blue"> 
                    <div align="left">��λ����</div>
                  </TD>
                  <TD width=34%> 
                    <select align="left" name=unitXz width=50 index="32">
                      <%
        //�õ��������
        try
        {
                String sqlStr ="select trim(TYPE_CODE), TYPE_NAME from sunittype order by TYPE_CODE";    
                %>
   <wtc:pubselect name="sPubSelect" outnum="2" retmsg="msg" retcode="code" routerKey="region" routerValue="<%=regionCode%>">
  	 <wtc:sql><%=sqlStr%></wtc:sql>
 	  </wtc:pubselect>
	 <wtc:array id="result_t4" scope="end"/>                   
                <%                
                result = result_t4;
                int recordNum = result.length;                  
                for(int i=0;i<recordNum;i++){
                        out.println("<option  value='" + result[i][0] + "'>" + result[i][1] + "</option>");
                }
        }catch(Exception e){
        }          
%>
                    </select>
                  </TD>
                  <TD width=16% class="blue"> 
                    <div align="left">Ӫҵִ������</div>
                  </TD>
                  <TD width=34%> 
                    <select align="left" name=yzlx width=50 index="33">
                      <%
        //�õ��������
        try
        {
                String sqlStr ="select trim(LINCENT_TYPE), TYPE_NAME from slicencetype order by LINCENT_TYPE";                
                %>
   <wtc:pubselect name="sPubSelect" outnum="2" retmsg="msg" retcode="code" routerKey="region" routerValue="<%=regionCode%>">
  	 <wtc:sql><%=sqlStr%></wtc:sql>
 	  </wtc:pubselect>
	 <wtc:array id="result_t5" scope="end"/>                   
                <%
                result = result_t5;
                int recordNum = result.length;                  
                for(int i=0;i<recordNum;i++){
                        out.println("<option  value='" + result[i][0] + "'>" + result[i][1] + "</option>");
                }
        }catch(Exception e){
        }          
%>
                    </select>
                  </TD>
                </TR>
                <TR > 
                  <TD class="blue"> 
                    <div align="left">Ӫҵִ�պ���</div>
                  </TD>
                  <TD> 
                    <input name=yzhm  maxlength="20"  index="34">
                  </TD>
                  <TD class="blue"> 
                    <div align="left">Ӫҵִ����Ч��</div>
                  </TD>
                  <TD> 
                    <input name=yzrq   index="35" v_must=0 v_maxlength=8 v_type="date" v_name="Ӫҵִ����Ч��" maxlength=8 size="8">
                  </TD>
                </TR>
                <TR > 
                  <TD class="blue"> 
                    <div align="left">���˴���</div>
                  </TD>
                  <TD COLSPAN="3"> 
                    <input name=frdm  maxlength="20"  index="36">
                  </TD>
                </TR>
                </TBODY> 
              </TABLE>
			     <TABLE width=100% id=td2 cellSpacing=0 style="display:none">
            
                <TR > 
				     
                  <TD width=16% class="blue"> 
                    <div align="left">ԭ���ź�</div>
                  </TD>
                  <TD width=84%> 
         			  <div align="left"><input name=oriGrpNo  maxlength="10"  index="37" v_must=0 v_maxlength=10 v_type=0_9 v_name="ԭ���ź�"></div>
					   </td>
				   </tr>
				
				  </table>
              <TABLE cellSpacing=0>
                <TBODY> 
                <TR  style="display='none'"> 
                  <TD width=16% class="blue"> 
                    <div align="left">ϵͳ��ע</div>
                  </TD>
                  <TD> 
                    <input  name=sysNote size=60 readonly maxlength="30">
                  </TD>
                </TR>
                <TR > 
                  <TD width="16%" class="blue"> 
                    <div align="left">�û���ע</div>
                  </TD>
                  <TD> 
                    <input name=opNote  size=60 maxlength="30" index="38"  v_must=0 v_maxlength=60 v_type="string" v_name="�û���ע">
                  </TD>
                </TR>
                </TBODY> 
              </TABLE>                
        <TABLE  cellSpacing=0>
          <TBODY>
            <TR > 
                  <TD align=center > 
                    <input class="b_foot" name=print  onmouseup="printCommit()" onkeyup="if(event.keyCode==13)printCommit()"  type=button value=��һ��  index="39" disabled_h>
			        			<input class="b_foot"   name=reset1 type=button  onclick="frm1100.Reset.click();" value=��� index="40">
			        			<input class="b_foot"   name=back type=button onclick="window.close()" value=�ر� index="41">
                    <input class="b_foot"  type="reset" name="Reset" value="Reset" style="display:none">
                  </TD>
            </TR>
          </TBODY>
        </TABLE>
 
    </td>
  </tr>
</table>
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
  <input type="hidden" name="workName" value=<%=workName%> >
  
  <input type="hidden" name="assu_name" value="">
  <input type="hidden" name="assu_phone" value="">
  <input type="hidden" name="assu_idAddr" value="">
  <input type="hidden" name="assu_idIccid" value="">
  <input type="hidden" name="assu_conAddr" value="">
  <input type="hidden" name="assu_idType" value="">
  
  <input type="hidden" name="str1" value="">
  <input type="hidden" name="str2" value="">
  <input type="hidden" name="str3" value="">
  <input type="hidden" name="str4" value="">
  <input type="hidden" name="str5" value="">
  
  
  
  <input type="hidden" name="parentId" value="0">
  
  <input type="hidden" name="WORK_FLOW_DIRECTION" value="">
  
<input type="hidden" name="CONFIRM_FLAG" value="">
<input type="hidden" name="MARK_TRANS_VALUE" value="">
<input type="hidden" name="VIP_NO" value="">
<input type="hidden" name="OLD_INNET_TIME" value="">
<input type="hidden" name="LIMIT_OWE" value="">
<input type="hidden" name="FUNC_LIST" value="">
<input type="hidden" name="DATA_LIST" value="">
<input type="hidden" name="TOTAL_MARK" value="">
<input type="hidden" name="TOTAL_MARK_BEGIN_TIME" value="">
<input type="hidden" name="MONTH_CONSUME" value="">
<input type="hidden" name="MARRY_STATUS" value=""> 
<input type="hidden" name="OLD_WORK_HEADSHIP" value="">   
<input type="hidden" name="FAMILY_MEMBER" value="">  
  <br>
  <br>
  </td>
 </tr>
 </table>
        <jsp:include page="/npage/common/pwd_comm.jsp"/>
        	<%@ include file="/npage/include/footer.jsp" %>
</form>
</body>
</html>

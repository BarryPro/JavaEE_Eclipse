<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%
/********************
 version v2.0
������: si-tech
ģ��:�˻�����
 update zhaohaitao at 2008.12.23
********************/
%>

<html  xmlns="http://www.w3.org/1999/xhtml">
	
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page contentType="text/html; charset=GBK" %>
<%@ page import="java.io.*" %>
<%@ page import="java.text.*" %>
<%@ page import="org.apache.log4j.Logger"%>
<%@ include file="/npage/public/hwObject.jsp" %> 

<%        
    Logger logger = Logger.getLogger("f1102_1.jsp");
	ArrayList retArray = new ArrayList();
	String printAccept = ""; 
%>
<%
	String opCode = request.getParameter("opCode");
	String opName = request.getParameter("opName");
	
	String workNo = (String)session.getAttribute("workNo");
	String workName = (String)session.getAttribute("workName");
	String Department = (String)session.getAttribute("orgCode");
	String ip_Addr = (String)session.getAttribute("ipAddr");
	String regionCode = (String)session.getAttribute("regCode");
	String orgCode = (String)session.getAttribute("orgCode");
	String belongCode = Department.substring(0,7);
    String rowNum = "1000";
    String sys_Date = "";
	
%>


<HEAD><TITLE>�ʻ�����</TITLE>
</HEAD>

<SCRIPT type=text/javascript>

onload=function()
{
 		 
    document.all.idIccid.focus();		
	if(typeof(frm1102.accountId)!="undefined") 
	{	if(frm1102.accountId.value != "")            ////�ָ����ύǰ�Ļ���ʻ�ID��ť��ʾ״̬
		{	frm1102.accountIdQuery.disabled = true; }
	}		
	
}
//---------1------RPC������------------------
function doProcess(packet)
{	
    //RPC������findValueByName
	var retType = packet.data.findValueByName("retType");
    var retCode = packet.data.findValueByName("retCode"); 
    var retMessage = packet.data.findValueByName("retMessage");	
    self.status="";
	if((retCode).trim()=="")
	{
       rdShowMessageDialog("����"+retType+"����ʱʧ�ܣ�");
       return false;
	}
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
    if(retType == "checkPwd")
    {
        //��������У��
        var retResult = packet.data.findValueByName("retResult");
		frm1102.checkPwd_Flag.value = retResult; 
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
                    document.all(obj).value = valueStr
                }
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
    if(forInt(frm1102.custId) == false)
    {	
    	frm1102.custId.value = "";
    	return false;	
    }    
    
    var getIdPacket = new AJAXPacket("fpsb_rpc.jsp","���ڻ�ÿͻ���Ϣ�����Ժ�......");
	getIdPacket.data.add("retType","getInfo_withID");
	getIdPacket.data.add("fieldNum","7");
	getIdPacket.data.add("sqlStr",document.frm1102.custId.value);
    
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
function PubSimpSel(pageTitle,fieldName,sqlStr,selType,retQuence,retToField)
{   //������ѯ

    var path = "../../npage/public/fPubSimpSel.jsp";
    path = path + "?sqlStr=" + sqlStr + "&retQuence=" + retQuence;
    path = path + "&fieldName=" + fieldName + "&pageTitle=" + pageTitle;
    path = path + "&selType=" + selType;  
    retInfo = window.showModalDialog(path);
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
//-------------------------------------------------
function getInfo_withName()
{ 
  	////���ݿͻ����Ƶõ������Ϣ
    
  	
  	if(document.frm1102.custName.value == "")
    {
        rdShowMessageDialog("������ͻ����ƣ�",0);
        return false;
    }
    
    var pageTitle = "�ͻ���Ϣ��ѯ";
    var fieldName = "�ͻ�ID|�ͻ�����|����ʱ��|֤������|֤������|�ͻ���ַ|��������|�ͻ�����|";
    var sqlStr = "CUST_NAME="+document.frm1102.custName.value;
    var selType = "S";              //'S'��ѡ��'M'��ѡ
    var retQuence = "7|0|1|3|4|5|6|7|";
    var retToField = "in0|in4|in3|in2|in5|in6|in1|";
    custInfoQuery(pageTitle,fieldName,sqlStr,selType,retQuence,retToField);     	       	   
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
    var path = "psbgetCustInfo3.jsp";   //����Ϊ* 
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
	
  if((obj_no.value).trim().len()>0)
  {
    if((obj_no.value).trim().len()<5)
	{
      rdShowMessageDialog("֤�����볤����������5λ����");
	  obj_no.focus();
  	  return false;
	}
	else
	{
      if(idname=="���֤")
	  {
        if(checkElement(obj_no)==false) return false;
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
  myPacket=null;
  
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
function getInfo_IccId()
{ 
  	//���ݿͻ�֤������õ������Ϣ
  	if((document.frm1102.idIccid.value).trim().len() == 0)
    {
        rdShowMessageDialog("������ͻ�֤�����룡",0);
        return false;
    }
	else if((document.frm1102.idIccid.value).trim().len() < 5)
	{
        rdShowMessageDialog("֤�����볤������������λ����",0);
        return false;
	}
    var pageTitle = "�ͻ���Ϣ��ѯ";
    var fieldName = "�ͻ�ID|�ͻ�����|����ʱ��|֤������|֤������|�ͻ���ַ|��������|�ͻ�����|";
    var sqlStr = "ID_ICCID="+(document.frm1102.idIccid.value).trim(); 
    var selType = "S";    //'S'��ѡ��'M'��ѡ
    var retQuence = "7|0|1|3|4|5|6|7|";
    var retToField = "in0|in4|in3|in2|in5|in6|in1|";
    custInfoQuery(pageTitle,fieldName,sqlStr,selType,retQuence,retToField);       	       	   
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
	getAfterPrompt();
	if((frm1102.payCode.value).indexOf("����") > 0)
	{
	    var jfbancode = frm1102.rpt_type.value;
    	frm1102.bankCode.value =jfbancode;
    	var jfbancode1 = frm1102.rpt_type1.value;
    	frm1102.postCode.value =jfbancode1;
		if((frm1102.accountNo.value == "")||(frm1102.bankCode.value == "")||(frm1102.postCode.value == ""))
		{
			rdShowMessageDialog("������ص��ʺš�������Ϣ����Ϊ�գ�",0);
			return false;
		}		
	}
	//
	if(check(frm1102))
	{
	    if((document.all.newPwd.value).trim().len()>0)
		{
		  if(document.all.newPwd.value.length!=6)
		  {
		    rdShowMessageDialog("�ʻ����볤������");
		    document.all.custPwd.focus();
		    return false;
		  }
          if(checkPwd(document.frm1102.newPwd,document.frm1102.cfmPwd)==false)
		  return false;
		}

    	sysNote = "�ʻ�����:" + "�ͻ�ID[" + document.frm1102.custId.value + "]�ʻ�ID[" +
    	         document.frm1102.accountId.value + "]" + "����Ա[<%=workName%>]"+"�Կͻ�["+(document.all.custName.value).trim()+"]�����ʻ�����ҵ��";
    	         //":�ʺ�[" + document.frm1102.accountNo.value + "]"; 
    	document.frm1102.sysNote.value = sysNote;
		
    	showPrtDlg("Detail","ȷʵҪ���е��������ӡ��","Yes");    	    
    }    
}
//---------------------------------------------------
function getId()
{
    //�õ��ʻ�ID
    var getAccountId_Packet = new AJAXPacket("f1100_getId.jsp","���ڻ���ʻ�ID�����Ժ�......");
	getAccountId_Packet.data.add("region_code","<%=regionCode%>");
	getAccountId_Packet.data.add("retType","AccountId");
	getAccountId_Packet.data.add("idType","1");
	getAccountId_Packet.data.add("oldId","0");
	core.ajax.sendPacket(getAccountId_Packet);
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
    check_HidPwd(frm1102.custPwd.value,"show",(frm1102.in1.value).trim(),"hid");
   	
}
//------------------------------------
function check_HidPwd(Pwd1,Pwd1Type,Pwd2,Pwd2Type)
{
	/*
  		Pwd1,Pwd2:����
  		wd1Type:����1�����ͣ�Pwd2Type������2������      show:���룻hid������
  	
	}*/

    var checkPwd_Packet = new AJAXPacket("pubCheckPwd.jsp","���ڽ�������У�飬���Ժ�......");
    checkPwd_Packet.data.add("retType","checkPwd");
	checkPwd_Packet.data.add("Pwd1",Pwd1);
	checkPwd_Packet.data.add("Pwd1Type",Pwd1Type);
	checkPwd_Packet.data.add("Pwd2",Pwd2);
	checkPwd_Packet.data.add("Pwd2Type",Pwd2Type);
	core.ajax.sendPacket(checkPwd_Packet);
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
    var fieldName = "���д���|��������|";
    var sqlStr = "select BANK_CODE,BANK_NAME from sBankCode " +
                "where REGION_CODE = '" + document.frm1102.unitCode.value.substring(0,2) + "'" +
                " and DISTRICT_CODE ='" + document.frm1102.unitCode.value.substring(2,4) + "'";
    if(document.frm1102.bankName.value != "")
    {
        sqlStr = sqlStr + " and BANK_NAME like '%" + document.frm1102.bankName.value + "%'";
    }
    //sqlStr = sqlStr + " and rowNum <" + <%=rowNum%> ;  
    var selType = "S";    //'S'��ѡ��'M'��ѡ
    var retQuence = "2|0|1|";
    var retToField = "bankCode|bankName|";
    PubSimpSel(pageTitle,fieldName,sqlStr,selType,retQuence,retToField);        	       	   
}

function getPostCode()
{ 
  	//���ù���js�õ����д���
    var pageTitle = "�ַ����д����ѯ";
    var fieldName = "���д���|��������|";
    var sqlStr = "select POST_BANK_CODE,BANK_NAME from sPostCode " +
                "where REGION_CODE = '" + document.frm1102.unitCode.value.substring(0,2) + "'";
    if(document.frm1102.postName.value != "")
    {
        sqlStr = sqlStr + " and BANK_NAME like '%" + document.frm1102.postName.value + "%'";
    }
   // sqlStr = sqlStr + " and rowNum <" + <%=rowNum%> ;  
    sqlStr = sqlStr + "  order by POST_BANK_CODE " ;
	var selType = "S";    //'S'��ѡ��'M'��ѡ
    var retQuence = "2|0|1|";
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
//---------------------------------------------------
function printInfo(printType)
{
    var retInfo = "";
    if(printType == "Detail")
    {	
<%
        //ȡ�ô�ӡ��ˮ
        try
        {
                //String sqlStr ="select sMaxSysAccept.nextval as accept from dual";
                //retArray = callView.view_spubqry32("1",sqlStr);
%>
				<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="region" routerValue="<%=regionCode%>"  id="seq"/>
<%
                printAccept = seq;
                //System.out.println("sysAccept======"+seq);
        }catch(Exception e){
                out.println("rdShowMessageDialog('ȡ���������ӡ��ˮʧ�ܣ�',0);");
                
        }              
%>          
		var cust_info=""; //�ͻ���Ϣ
		var opr_info=""; //������Ϣ
		var note_info1=""; //��ע1
		var note_info2=""; //��ע2
		var note_info3=""; //��ע3
		var note_info4=""; //��ע4
		
		cust_info+="�ͻ�������"+frm1102.custName.value+"|";
		cust_info+="�ͻ���ַ��"+frm1102.custAddr.value+"|";
		cust_info+="֤�����룺"+frm1102.idIccid.value+"|";
							
		opr_info+="�ʻ�ID��"+frm1102.accountId.value+"|";
		opr_info+="�ʻ����ƣ�"+frm1102.accountName.value+"|";
		opr_info+="���ʽ��"+frm1102.payCode.value+"|";
		opr_info+="��ӡ��ˮ��"+"<%=printAccept%>"+"|";
		
		note_info1+="��ע��"+document.all.sysNote.value+"|";

		retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
		retInfo=retInfo.replace(new RegExp("#","gm"),"%23"); 

	}  
    if(printType == "Bill")
    {	//��ӡ��Ʊ
	}
	return retInfo;	
}
//-----------------------------------------------------
function showPrtDlg(printType,DlgMessage,submitCfm)
{  //��ʾ��ӡ�Ի��� 
   var h=200;
   var w=400;
   var t=screen.availHeight/2-h/2;
   var l=screen.availWidth/2-w/2;
   
   var pType = "print";                   					  // ��ӡ���ͣ�print ��ӡ subprint �ϲ���ӡ printstore ��ӡ�洢
   var billType="1";                                          //Ʊ�����ͣ�1���������2��Ʊ��3�վ�
   var sysAccept="<%=printAccept%>";                          //��ˮ��
   var printStr=printInfo(printType);                         //����printinfo()���صĴ�ӡ����
   var mode_code=null;                                        //�ʷѴ���
   var fav_code=null;                                         //�ط�����
   var area_code=null;                                        //С������
   var opCode="<%=opCode%>";                                  //��������
   var phoneNo="";                                            //�ͻ��绰

var iccidInfoStr = $("#firstId").val() + "|" + $("#secondId").val();	
var accInfoStr = $("#accInfoHid1").val() + "|" +$("#accInfoHid2").val()+ "|" 
	+$("#accInfoHid3").val()+ "|" +$("#accInfoHid4").val();		




   var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no";
   var path = "<%=request.getContextPath()%>/npage/innet/hljBillPrint_jc_hw.jsp?DlgMsg=" + DlgMessage+ "&submitCfm=" + submitCfm    +"&iccidInfo=" + iccidInfoStr + "&accInfoStr="+accInfoStr;
   path=path+"&mode_code="+mode_code+"&fav_code="+fav_code+"&area_code="+area_code+"&opCode=<%=opCode%>&sysAccept="+sysAccept+"&phoneNo="+phoneNo+"&submitCfm="+submitCfm+"&pType="+pType+"&billType="+billType+ "&printInfo=" + printStr;
   path = path+"&iccidInfo=" + iccidInfoStr + "&accInfoStr="+accInfoStr;

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
</SCRIPT>
<!--**************************************************************************************-->
 
<body>
<FORM method=post name="frm1102" action="f1102_2.jsp" onKeyUp="chgFocus(frm1102)">
<%@ include file="/npage/include/header.jsp" %>   
  	
		<div class="title">
			<div id="title_zi"><%=opName%></div>
		</div>
    
              <TABLE cellspacing="0">
                <TBODY> 
                <TR> 
                  <TD class="blue"> 
                    <div align="left">�ͻ�֤������</div>
                  </TD>
                  <TD> 
                    <input id='in2' name=idIccid v_must=1 v_type="string" onKeyup="if(event.keyCode==13)getInfo_IccId();" index="2">
                    <font color="orange">*</font> 
                    <input name=custIdQuery type=button onClick="choiceSelWay();" class="b_text" style="cursor:hand" id="custIdQuery" value=�ͻ���ѯ>
                  </TD>
                  <TD class="blue"> 
                    <div align="left">�ͻ�����</div>
                  </TD>
                  <TD> 
				    <jsp:include page="/npage/common/pwd_1.jsp">
	                <jsp:param name="width1" value="16%"  />
	                <jsp:param name="width2" value="34%"  />
	                <jsp:param name="pname" value="custPwd"  />
	                <jsp:param name="pwd" value="12345"  />
 	                </jsp:include>
                    <input name=accountIdQuery2 type=button onClick="change_custPwd();" class="b_text" value="У��" disabled >
                  </TD>
                </TR>
                <TR> 
                  <TD class="blue"> 
                    <div align="left">�ͻ�����</div>
                  </TD>
                  <TD> <font color="orange"> 
                    <input id='in4' name=custName onKeyup="if(event.keyCode==13)getInfo_withName();">
                    *</font> </TD>
                  <TD class="blue"> 
                    <div align="left">�ͻ�֤������</div>
                  </TD>
                  <TD> 
                    <input id='in3' class="InputGrey" name=idType v_type="string" v_must="1" readonly>
                  </TD>
                </TR>
                <TR> 
                  <TD class="blue"> 
                    <div align="left">�ͻ�ID</div>
                  </TD>
                  <TD> <font color="orange"> 
                    <input id='in0' name=custId v_type=int v_must=1 onKeyup="if(event.keyCode==13)getInfo_withId();">
                    *</font> </TD>
                  <TD class="blue"> 
                    <div align="left">�ͻ���ַ</div>
                  </TD>
                  <TD> 
                    <input id='in5' class="InputGrey" name=custAddr readonly>
                  </TD>
                </TR>
                <TR> 
                  <TD class="blue"> 
                    <div align="left">�ʻ�ID</div>
                  </TD>
                  <TD> 
                    <input class="InputGrey" name=accountId v_must=1 v_type="0_9" readonly>
                    <font color="orange">*</font> 
                    <input name=accountIdQuery type=button onmouseup="getId()" onkeyup="if(event.keyCode==13)getId()" class="b_text" value=��� index="4" disabled >
                    <br>
                  </TD>
                  <TD class="blue"> 
                    <div align="left">�ʻ�����</div>
                  </TD>
                  <TD> 
                    <input name=accountName v_must=1 v_maxlength=60 v_type="string" index="5">
                    <font color="orange">*</font> </TD>
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
                    <div align="left">�ʻ�����</div>
                  </TD>
                  <TD> 
                    <select align="left" name=accountType width=50  index="8">
                      <%
    //�õ���������ʻ�����
 	try
 	{
      		String sqlStr ="select trim(ACCOUNT_TYPE), TYPE_NAME from sAccountType where account_type=any('0','1','A') order by ACCOUNT_TYPE"; 
      		//retArray = callView.view_spubqry32("2",sqlStr);
%>
			<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>"  retcode="retCode1" retmsg="retMsg1" outnum="2">
			<wtc:sql><%=sqlStr%></wtc:sql>
			</wtc:pubselect>
			<wtc:array id="result2" scope="end" />
<%
      		int recordNum = result2.length;
      		System.out.println("recordNum="+recordNum);
      		for(int i=0;i<recordNum;i++){
        		out.println("<option class='button' value='" + result2[i][0] + "'>" + result2[i][1] + "</option>");
      		}
     	}catch(Exception e){
       		logger.error("Call sunView is Failed!");
     	}          
%>
                    </select>
                  </TD>
                  <TD class="blue"> 
                    <div align="left">���ʽ</div>
                  </TD>
                  <TD> 
                    <select align="left" name=payCode onchange="payWayChange()" width=50 index="9">
                      <%
    //�õ���������ʻ�����
 	try
 	{
      		//String sqlStr ="select trim(PAY_CODE)||'-'||trim(PAY_NAME),trim(PAY_NAME) from sPayCode where REGION_CODE= '" + regionCode.substring(0,2) +"' order by PAY_CODE";
      		String[] inParam = new String[2];
      		inParam[0] = "select trim(PAY_CODE)||'-'||trim(PAY_NAME),trim(PAY_NAME) from sPayCode where REGION_CODE=:regCode order by PAY_CODE";
      		inParam[1] = "regCode="+regionCode.substring(0,2);
      		//retArray = callView.view_spubqry32("2",sqlStr);
%>
			<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode2" retmsg="retMsg2" outnum="2">			
			<wtc:param value="<%=inParam[0]%>"/>	
			<wtc:param value="<%=inParam[1]%>"/>
			</wtc:service>	
			<wtc:array id="result2"  scope="end"/>
<%
      		int recordNum = result2.length;
      		for(int i=0;i<recordNum;i++){
        		out.println("<option class='button' value='" + result2[i][0] + "'>" + result2[i][1] + "</option>");
      		}
     	}catch(Exception e){
       		logger.error("Call sunView is Failed!");
     	}          
%>
                    </select>
                  </TD>
                </TR>
                </TBODY> 
              </TABLE>  
                   
            
              <TABLE id=tbBank0  cellSpacing="0" style="display:none">
                <TBODY> 
                <TR> 
                  <TD class="blue"> 
                    <div align="left">�ʺ�</div>
                  </TD>
                  <TD colspan="3"> 
                    <input name=accountNo index="10">
                  </TD>
                </TR>
                <TR> 
                  <TD class="blue"> 
                    <div align="left">���д���ģ����ѯ</div>
                  </TD>
                  <TD> 
                    
                    <!--<input name=bankName size=13 class="button" onkeyup="if(event.keyCode==13)getBankCode();" readonly index="11">
                    <input name=bankCodeQuery type=button class="b_text" id="bankCodeQuery" style="cursor:hand" onClick="getBankCode()" value=��ѯ index="12">
										-->
										<input type="text" id="searchTextrpt" name="searchTextrpt"  value="�������ѯ����"  size="40" style="padding-top:3px;" onFocus="frm1102.searchTextrpt.value='';clearResults();"  onpropertychange="blurSearchFunc('rpt_type','searchTextrpt','->')" />
										<input type="hidden" name=bankCode size=5 class="button" maxlength="12" readonly >
                  </TD>
                  <TD class="blue"> 
                    <div align="left">�ַ����д���ģ����ѯ</div>
                  </TD>
                  <TD> 
                    <!--
                    <input name=postName size=13 class="button" onkeyup="if(event.keyCode==13)getPostCode();" index="13">
                    <input name=postCodeQuery type=button class="b_text" id="postCodeQuery" style="cursor:hand" onClick="getPostCode()" value=��ѯ index="14">
                    -->
                    <input type="text" id="searchTextrpt1" name="searchTextrpt1"  value="�������ѯ����"  size="40" style="padding-top:3px;" onFocus="frm1102.searchTextrpt1.value='';clearResults();"  onpropertychange="blurSearchFunc('rpt_type1','searchTextrpt1','->')" />
                    <input type="hidden" name=postCode size=5 class="button" maxlength="12" readonly>
                  </TD>
                </TR>
                <tr>
                		<td class="blue">�����б�</td>
								<td>
									<select name=rpt_type  style="width:250px;">
										<wtc:qoption name="sPubSelect" outnum="2">
											<wtc:sql>select BANK_CODE,BANK_CODE||'->'||BANK_NAME from sBankCode where REGION_CODE = '<%=Department.substring(0,2)%>' and DISTRICT_CODE ='<%=Department.substring(2,4)%>'</wtc:sql>
										</wtc:qoption>
									</select>
								</td>
             
                		<td class="blue">�ַ������б�</td>
								<td>
									<select name=rpt_type1  style="width:250px;">
										<wtc:qoption name="sPubSelect" outnum="2">
											<wtc:sql>select POST_BANK_CODE,POST_BANK_CODE||'->'||BANK_NAME from sPostCode where REGION_CODE = '<%=Department.substring(0,2)%>' order by POST_BANK_CODE</wtc:sql>
										</wtc:qoption>
									</select>
								</td>
                </tr>
                </TBODY> 
              </TABLE>  

              <TABLE cellSpacing="0">
                <TBODY> 
                <TR > 
                  <TD class="blue"> 
                    <div align="left">��ʼ����</div>
                  </TD>
                  <TD> 
                     <input class="InputGrey" name=beginDate v_type="date" v_must=1 value="<%=new SimpleDateFormat("yyyyMMdd", Locale.getDefault()).format(new Date())%>" readonly>
                     <input class="InputGrey" name=endDate date v_name="��������" v_must=1 maxlength="20" value="20501231" readonly style="display:none">
                  </TD>
                </TR>
                </TBODY> 
              </TABLE>                              
              <TABLE cellSpacing="0">
                <tr style="display:none"> 
                  <td class="blue"> 
                    <div align="left">ϵͳ��ע</div>
                  </td>
                  <td> 
                    <input class="InputGrey" name=sysNote readonly>
                  </td>
                </tr>
<jsp:include page="/npage/public/hwReadCustCard.jsp">
	<jsp:param name="hwAccept" value="<%=printAccept%>"  />
	<jsp:param name="showBody" value="01"  />
</jsp:include>
              </TABLE>     

                         
        <TABLE cellSpacing="0">
          <TBODY>
            <TR> 
              <TD id="footer">
                    <input class="b_foot" name=print  onmouseup="printCommit()" onkeyup="if(event.keyCode==13)printCommit()" type=button value=ȷ��&��ӡ index="16" disabled>
			        <input class="b_foot" name=reset1   type=button onClick="frm1102.reset();" value=��� index="17">
			        <input class="b_foot" name=back   onclick="removeCurrentTab()" type=button value=�ر� index="18">
			  </TD>
            </TR>
          </TBODY>
        </TABLE>

 
  <input type="hidden" id=in1 name="hidPwd" v_name="ԭʼ����">
  <input type="hidden" name="hidCustPwd">  <!--�ͻ����ܺ������-->
  <input type="hidden" name="workno" value=<%=workNo%>>
  <input type="hidden" name="regionCode" value=<%=regionCode%>> 
  <input type="hidden" id=in6 name="belongCode" value=<%=belongCode%>>
  <input type="hidden" name="unitCode" value=<%=Department%>>
  <input type="hidden" name="ip_Addr" value=<%=ip_Addr%>>
  <input type="hidden" name="inParaStr" >
  <input type="hidden" name="checkPwd_Flag" value="false">		<!--����У���־-->
  <input type="hidden" name="workName" value=<%=workName%> >
  <input type="hidden" name="opCode" value="<%=opCode%>" >
  <input type="hidden" name="opName" value="<%=opName%>" >
  <input type="hidden" name="printAccept" value="<%=printAccept%>">
   <jsp:include page="/npage/common/pwd_comm.jsp"/>
   	<%@ include file="/npage/public/pubSearchText.jsp" %>
   <%@ include file="/npage/include/footer.jsp" %>   
</form>
</body>
</html>

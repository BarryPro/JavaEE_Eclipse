   
<%
/********************
 version v2.0
 ������ si-tech
 update hejw@2009-2-9
********************/
%>
              
<%
  String opCode = "3200";
  String opName = "VPMN���ſ���";
%>              

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http//www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http//www.w3.org/1999/xhtml">
<%@ include file="/npage/include/public_title_name.jsp" %> 
	


<%@ page contentType="text/html;charset=GBK"%>
<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>
<%@ page import="org.apache.log4j.Logger"%>
<%@ page import="com.sitech.boss.pub.*" %>


<%

    ArrayList arr = (ArrayList)session.getAttribute("allArr");
    String[][] baseInfo = (String[][])arr.get(0);
    String[][] agentInfo = (String[][])arr.get(2);
    String[][] pass = (String[][])arr.get(4);
    String ip_Addr = (String)session.getAttribute("ipAddr");
    String workno = (String)session.getAttribute("workNo");
    String workname = (String)session.getAttribute("workName");
    String org_code = (String)session.getAttribute("orgCode");
    String group_id = "";/* add by daixy 20081127,group_id����dCustDoc�е�org_id */
    String OrgId = baseInfo[0][23];
    String nopass  = (String)session.getAttribute("password");
    String Department = baseInfo[0][16];
    String regionCode = (String)session.getAttribute("regCode");
    String districtCode = Department.substring(2,2);
    String agentProvCode = "";
    String servArea = "";
    String powerRight= baseInfo[0][5];
    
    String cust_id = request.getParameter("cust_id")==null?"":request.getParameter("cust_id");//wuxy alter 20090513
    
    Logger logger = Logger.getLogger("f3200.jsp");
    String dateStr = new java.text.SimpleDateFormat("yyyyMMdd").format(new java.util.Date());
    int iDate = Integer.parseInt(dateStr);
    //String addDate = Integer.toString(iDate+1);
    String Date100 = Integer.toString(iDate+1000000);
	String  insql = "select to_char(sysdate+1,'YYYYMMDD') from dual";
	//ArrayList retArrayDate = callView.sPubSelect("1",insql);
	%>
	
	 <wtc:pubselect name="sPubSelect" outnum="1" retmsg="msg" retcode="code" routerKey="region" routerValue="<%=regionCode%>">
  	 <wtc:sql><%=insql%></wtc:sql>
 	  </wtc:pubselect>
	 <wtc:array id="result_tu1" scope="end"/>
	
<%
	String addDate=result_tu1[0][0];

    String sqlStr = "";
    ArrayList retArray = new ArrayList();
    String[][] result = new String[][]{};
%>
<HTML>
<HEAD>
<TITLE>VPMN-���ſ���</TITLE>
</HEAD>
<script language="JavaScript" src="<%=request.getContextPath()%>/npage/s1400/pub.js"></script>
<SCRIPT type=text/javascript>

function doProcess(packet)
{
    var retType = packet.data.findValueByName("retType");
    var retCode = packet.data.findValueByName("retCode");
    self.status="";
    if(retType == "GrpId") //�õ����Ŵ���
    {
        if(retCode == "000000")
        {
            var GrpId = packet.data.findValueByName("GrpId");
            //document.frm.grp_no.value = oneTok(GrpId,"|",1);
            document.frm.TCustId.value = oneTok(GrpId,"|",2);
            document.frm.getGrpNo.disabled = true;
            document.frm.grp_name.focus();
         }
        else
        {
            rdShowMessageDialog("û�еõ����Ŵ���,�����»�ȡ��",0);
				return false;
        }
	}
    if(retType == "GrpNo") //�õ������û����
    {
        if(retCode == "000000")
        {
            var GrpNo = packet.data.findValueByName("GrpNo");
            document.frm.grp_userno.value = GrpNo;
            document.frm.getGrpNo.disabled = true;
         }
        else
        {
            var retMessage = packet.data.findValueByName("retMessage");
            rdShowMessageDialog(retMessage, 0);
        }
	}
    //---------------------------------------
    if(retType == "UserId")
    {
        if(retCode == "000000")
        {
            var retUserId = packet.data.findValueByName("retnewId");    	    
    	    document.frm.grp_id.value = retUserId;
            document.frm.grpQuery.disabled = true;
         }
        else
        {
                rdShowMessageDialog("û�еõ��û�ID,�����»�ȡ��",0);
				return false;
        }
    }
    //---------------------------------------
    if(retType == "AccountId") //�õ��ʻ�ID
    {
        if(retCode == "000000")
        {
            var retnewId = packet.data.findValueByName("retnewId");
            document.frm.account_id.value = retnewId;
            document.frm.accountQuery.disabled = true;
            document.frm.pay_code.disabled = false;
			document.frm.user_passwd.focus();
         }
        else
        {
            rdShowMessageDialog("û�еõ��ʻ�ID,�����»�ȡ��",0);
        }
    }
	//---------------------------------------
     if(retType == "checkPwd") //���ſͻ�����У��
     {
        if(retCode == "000000")
        {
            var retResult = packet.data.findValueByName("retResult");
            if (retResult == "false") {
    	    	rdShowMessageDialog("�ͻ�����У��ʧ�ܣ����������룡",0);
                document.frm.sure.disabled = true;
	        	frm.custPwd.value = "";
	        	frm.custPwd.focus();
    	    	return false;	        	
            } else {
                rdShowMessageDialog("�ͻ�����У��ɹ���",2);
                document.frm.sure.disabled = false;
            }
         }
        else
        {
            rdShowMessageDialog("�ͻ�����У�����������У�飡",0);
    		return false;
        }
     }	

     //---------------------------------------
     if(retType == "ProdAttr")
     {
        if(retCode == "000000")
        {
            var retnums = packet.data.findValueByName("retnums");
            var retname = packet.data.findValueByName("retname");

            if (retnums == 1) { //ֻ��һ����Ʒ���Ե�ʱ�򣬲���Ҫ�û�ѡ��
                document.frm.product_attr.value = retname;
                document.frm.ProdAttrQuery.disabled = true;
            }
            else if (retnums > 1) {
                document.frm.product_attr.value = "";
                document.frm.ProdAttrQuery.disabled = false;
            }
         }
        else
        {
                rdShowMessageDialog("��ѯ��Ʒ���Գ���,�����»�ȡ��",0);
				return false;
        }
    }
}

function check_HidPwd()
{
    var cust_id = document.all.cust_id.value;
    var Pwd1 = document.all.custPwd.value;
    var checkPwd_Packet = new AJAXPacket("/npage/s3432/pubCheckPwd.jsp","���ڽ�������У�飬���Ժ�......");
    checkPwd_Packet.data.add("retType","checkPwd");
	checkPwd_Packet.data.add("cust_id",cust_id);
	checkPwd_Packet.data.add("Pwd1",Pwd1);
	core.ajax.sendPacket(checkPwd_Packet);
	checkPwd_Packet = null;	
}

function getAccountId()
{
	//�õ��ʻ�ID
    var getAccountId_Packet = new AJAXPacket("/npage/innet/f1100_getId.jsp","���ڻ���ʻ�ID�����Ժ�......");
	getAccountId_Packet.data.add("region_code","<%=regionCode%>");
	getAccountId_Packet.data.add("retType","AccountId");
	getAccountId_Packet.data.add("idType","1");
	getAccountId_Packet.data.add("oldId","0");
	core.ajax.sendPacket(getAccountId_Packet);
	getAccountId_Packet = null;
}

//�õ������û����user_no
function getGrpUserNo()
{
    var sm_code = document.frm.sm_code.value;

    //�����ж��Ƿ��Ѿ�ѡ���˷���Ʒ��
    if(document.frm.sm_code.value == "")
    {
        rdShowMessageDialog("������ѡ�����Ʒ�ƣ�",0);
        return false;
    }

    var getgrp_Userno_Packet = new AJAXPacket("/npage/s3432/getGrpUserno.jsp","���ڻ�ü����û���ţ����Ժ�......");
    getgrp_Userno_Packet.data.add("retType","GrpNo");
    getgrp_Userno_Packet.data.add("orgCode","<%=org_code%>");
    getgrp_Userno_Packet.data.add("smCode",sm_code);
    core.ajax.sendPacket(getgrp_Userno_Packet);
    getgrp_Userno_Packet = null;
}

function getUserId()
{
    //�õ������û�ID���͸����û�IDһ��
    var getUserId_Packet = new AJAXPacket("/npage/innet/f1100_getId.jsp","���ڻ���û�ID�����Ժ�......");
	getUserId_Packet.data.add("region_code","<%=regionCode%>");
	getUserId_Packet.data.add("retType","UserId");
	getUserId_Packet.data.add("idType","1");
	getUserId_Packet.data.add("oldId","0");
	core.ajax.sendPacket(getUserId_Packet);
	getUserId_Packet = null;
}

function getAccountId()
{
	//�õ��ʻ�ID
    var getAccountId_Packet = new AJAXPacket("/npage/innet/f1100_getId.jsp","���ڻ���ʻ�ID�����Ժ�......");
	getAccountId_Packet.data.add("region_code","<%=regionCode%>");
	getAccountId_Packet.data.add("retType","AccountId");
	getAccountId_Packet.data.add("idType","1");
	getAccountId_Packet.data.add("oldId","0");
	core.ajax.sendPacket(getAccountId_Packet);
	getAccountId_Packet = null;
}

//���ù������棬���м����ʻ�ѡ��
function getInfo_Acct()
{
    var pageTitle = "�����ʻ�ѡ��";
    var fieldName = "�����û�ID|�����û�����|��Ʒ����|�����ʺ�|";
	var sqlStr = "";
    var selType = "S";    //'S'��ѡ��'M'��ѡ
    var retQuence = "4|0|1|2|3|";
    var retToField = "tmp1|tmp2|tmp3|account_id|"; //����ֻ��Ҫ�����ʺ�
    var cust_id = document.frm.cust_id.value;

    if(document.frm.cust_id.value == "")
    {
        rdShowMessageDialog("����ѡ���ſͻ������ܽ��м����ʻ���ѯ��",0);
        document.frm.iccid.focus();
        return false;
    }

    if(PubSimpSelAcct(pageTitle,fieldName,sqlStr,selType,retQuence,retToField));
}

function PubSimpSelAcct(pageTitle,fieldName,sqlStr,selType,retQuence,retToField)
{
    var path = "/npage/s3432/fpubcustacct_sel.jsp";
    path = path + "?sqlStr=" + sqlStr + "&retQuence=" + retQuence;
    path = path + "&fieldName=" + fieldName + "&pageTitle=" + pageTitle;
    path = path + "&selType=" + selType+"&cust_id=" + document.all.cust_id.value;

    retInfo = window.open(path,"newwindow","height=450, width=650,top=50,left=200,scrollbars=yes, resizable=no,location=no, status=yes");

    document.frm.accountQuery.disabled = false;

    return true;
}

function getvalueacct(retInfo)
{
  var retToField = "tmp1|tmp2|tmp3|account_id|";;
  if(retInfo ==undefined)      
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
    document.frm.pay_code.disabled = true;
}

//���ù������棬���м��ſͻ�ѡ��
function getInfo_Cust()
{
    var pageTitle = "���ſͻ�ѡ��";
    var fieldName = "֤������|�ͻ�ID|�ͻ�����|����ID|��������|������|��ϵ������|������ϵ��ַ|������ϵ�绰|������֯|";
	  var sqlStr = "";
    var selType = "S";    //'S'��ѡ��'M'��ѡ
/** add by daixy 20081127,group_id����dCustDoc�е�org_id    
**    var retQuence = "9|0|1|2|3|4|5|6|7|8|";
**    var retToField = "iccid|cust_id|cust_name|unit_id|unit_name|belong_code|contact|address|telephone|";
**/    
    var retQuence = "10|0|1|2|3|4|5|6|7|8|9|";
    var retToField = "iccid|cust_id|cust_name|unit_id|unit_name|belong_code|contact|address|telephone|group_id|";
    var cust_id = document.frm.cust_id.value;

    if(document.frm.iccid.value == "" &&
       document.frm.cust_id.value == "" &&
       document.frm.unit_id.value == "")
    {
        rdShowMessageDialog("���������֤�š��ͻ�ID����ID���в�ѯ��",0);
        document.frm.iccid.focus();
        return false;
    }

    if(document.frm.cust_id.value != "" && forNonNegInt(frm.cust_id) == false)
    {
    	frm.cust_id.value = "";
        rdShowMessageDialog("���������֣�",0);
    	return false;
    }

    if(document.frm.unit_id.value != "" && forNonNegInt(frm.unit_id) == false)
    {
    	frm.unit_id.value = "";
        rdShowMessageDialog("���������֣�",0);
    	return false;
    }

    if(PubSimpSelCust(pageTitle,fieldName,sqlStr,selType,retQuence,retToField));
}

function PubSimpSelCust(pageTitle,fieldName,sqlStr,selType,retQuence,retToField)
{
    var path = "f3200_cust_sel.jsp";
    path = path + "?sqlStr=" + sqlStr + "&retQuence=" + retQuence;
    path = path + "&fieldName=" + fieldName + "&pageTitle=" + pageTitle;
    path = path + "&selType=" + selType+"&iccid=" + document.all.iccid.value;
    path = path + "&cust_id=" + document.all.cust_id.value;
    path = path + "&unit_id=" + document.all.unit_id.value;

    retInfo = window.open(path,"newwindow","height=450, width=900,top=50,left=200,scrollbars=yes, resizable=no,location=no, status=yes");

	return true;
}

function getvaluecust(retInfo)
{
/** add by daixy 20081127,group_id����dCustDoc�е�org_id  
** var retToField = "iccid|cust_id|cust_name|unit_id|unit_name|belong_code|contact|address|telephone|";
**/
	var retToField = "iccid|cust_id|cust_name|unit_id|unit_name|belong_code|contact|address|telephone|group_id|";
  if(retInfo ==undefined)      
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

    document.all.grp_name.value = document.all.unit_name.value;
    document.frm.sure.disabled = true;
}

//��ѯ��Ʒ����
function query_prodAttr()
{
    var sm_code = document.frm.sm_code.value;

    if(document.frm.sm_code.value == "")
    {
        return false;
    }

    var getInfoPacket = new AJAXPacket("/npage/s3432/fpubprodattr_qry.jsp","���ڲ�ѯ��Ʒ���Դ��룬���Ժ�......");
        getInfoPacket.data.add("retType","ProdAttr");
        getInfoPacket.data.add("sm_code",sm_code);
        core.ajax.sendPacket(getInfoPacket);
        getInfoPacket = null;
}

//���ù������棬���в�Ʒ����ѡ��
function getInfo_ProdAttr()
{
		
    var pageTitle = "��Ʒ����ѡ��";
    var fieldName = "��Ʒ���Դ���|��Ʒ����|";
	var sqlStr = "";
    var selType = "S";    //'S'��ѡ��'M'��ѡ
    var retQuence = "1|0|";
    var retToField = "product_attr|";

    //�����ж��Ƿ��Ѿ�ѡ���˷���Ʒ��
    if(document.frm.sm_code.value == "")
    {
        rdShowMessageDialog("������ѡ�����Ʒ�ƣ�",0);
        return false;
    }

    if(PubSimpSelProdAttr(pageTitle,fieldName,sqlStr,selType,retQuence,retToField));
}

function PubSimpSelProdAttr(pageTitle,fieldName,sqlStr,selType,retQuence,retToField)
{

    var path = "/npage/s3432/fpubprodattr_sel.jsp";
    path = path + "?sqlStr=" + sqlStr + "&retQuence=" + retQuence;
    path = path + "&fieldName=" + fieldName + "&pageTitle=" + pageTitle;
    path = path + "&selType=" + selType;
	path = path + "&op_code=" + document.all.op_code.value;
	path = path + "&sm_code=" + document.all.sm_code.value; 

    retInfo = window.open(path,"newwindow","height=450, width=650,top=50,left=200,scrollbars=yes, resizable=no,location=no, status=yes");

	return true;
}

function getvalueProdAttr(retInfo)
{
  var retToField = "product_attr|";
  if(retInfo ==undefined)      
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
    document.frm.product_code.value = "";
    document.frm.product_append.value = "";
}

function checkUserPwd(obj1,obj2)
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

//���ù������棬���в�Ʒ��Ϣѡ��
function getInfo_Prod()
{
    var pageTitle = "���Ų�Ʒѡ��";
    var fieldName = "��Ʒ����|��Ʒ����|";
	var sqlStr = "";
    var selType = "S";    //'S'��ѡ��'M'��ѡ
    var retQuence = "2|0|1|";
    var retToField = "product_code|product_name|";

    //�����ж��Ƿ��Ѿ�ѡ���˷���Ʒ��
    if(document.frm.sm_code.value == "")
    {
        rdShowMessageDialog("������ѡ�����Ʒ�ƣ�",0);
        return false;
    }
    //�����ж��Ƿ��Ѿ�ѡ���˲�Ʒ����
    if(document.frm.product_attr.value == "")
    {
        rdShowMessageDialog("������ѡ���Ʒ���ԣ�",0);
        return false;
    }

    if(PubSimpSel(pageTitle,fieldName,sqlStr,selType,retQuence,retToField));
}

function PubSimpSel(pageTitle,fieldName,sqlStr,selType,retQuence,retToField)
{
		
    var path = "/npage/s3432/fpubprod_sel.jsp";
    path = path + "?sqlStr=" + sqlStr + "&retQuence=" + retQuence;
    path = path + "&fieldName=" + fieldName + "&pageTitle=" + pageTitle;
    path = path + "&selType=" + selType;
	path = path + "&op_code=" + document.all.op_code.value;
	path = path + "&sm_code=" + document.all.sm_code.value; 
    path = path + "&product_attr=" + document.all.product_attr.value; 

    retInfo = window.open(path,"newwindow","height=450, width=650,top=50,left=200,scrollbars=yes, resizable=no,location=no, status=yes");

	return true;
}

function getvalue(retInfo)
{
  var retToField = "product_code|product_name|";
  if(retInfo ==undefined)      
    {   return false;   }

  document.all.product_code.value = retInfo;
  document.frm.product_append.value = "";
}

//���Ÿ��Ӳ�Ʒѡ��
function getInfo_ProdAppend()
{
    var pageTitle = "���Ÿ��Ӳ�Ʒѡ��";
    var fieldName = "��Ʒ����|��Ʒ����|";
	  var sqlStr = "";
    var selType = "M";    //'S'��ѡ��'M'��ѡ
    var retQuence = "2|0|1|";
    var retToField = "product_append|product_name|";
    var product_code = document.frm.product_code.value;

    //�����ж��Ƿ��Ѿ�ѡ���˷���Ʒ��
    if(document.frm.sm_code.value == "")
    {
        rdShowMessageDialog("������ѡ�����Ʒ�ƣ�",0);
        return false;
    }
    //�����ж��Ƿ��Ѿ�ѡ���˲�Ʒ����
    if(document.frm.product_attr.value == "")
    {
        rdShowMessageDialog("������ѡ���Ʒ���ԣ�",0);
        return false;
    }
    //�����ж��Ƿ��Ѿ������˼�������Ʒ
    if(document.frm.product_code.value == "")
    {
        rdShowMessageDialog("������ѡ��������Ʒ��",0);
        return false;
    }

    if(PubSimpSelAppend(pageTitle,fieldName,sqlStr,selType,retQuence,retToField));
}

function PubSimpSelAppend(pageTitle,fieldName,sqlStr,selType,retQuence,retToField)
{
    var product_code = document.all.product_code.value;
    var chPos = product_code.indexOf("|");
    product_code = product_code.substring(0,chPos);
    var path = "/npage/s3432/fpubprodappend_sel.jsp";
    path = path + "?sqlStr=" + sqlStr + "&retQuence=" + retQuence;
    path = path + "&fieldName=" + fieldName + "&pageTitle=" + pageTitle;
    path = path + "&selType=" + selType;
    path = path + "&showType=" + "Default";
	path = path + "&op_code=" + document.all.op_code.value;
	path = path + "&sm_code=" + document.all.sm_code.value; 
	path = path + "&product_code=" + product_code; 

    retInfo = window.open(path,"newwindow","height=450, width=650,top=50,left=200,scrollbars=yes, resizable=no,location=no, status=yes");

	return true;
}

function getvalueProdAppend(retInfo)
{
  var retToField = "product_append|product_name|";
  if(retInfo ==undefined)      
    {   return false;   }

  document.all.product_append.value = retInfo;
}

//����Ʒ�Ʊ���¼�
function changeSmCode() {
    document.frm.product_attr.value = "";
	document.frm.product_code.value = "";
    document.frm.product_append.value = "";
    document.frm.grp_userno.value = "";
    query_prodAttr();
}

//��Ʒ���Ա���¼�
function changeProdAttr() {
	document.frm.product_code.value = "";
    document.frm.product_append.value = "";
}

//��Ʒ����¼�
function changeProduct() {
    document.frm.product_append.value = "";
}

function call_flags(){
   var h=580;
   var w=1150;
   var t=screen.availHeight/2-h/2;
   var l=screen.availWidth/2-w/2;
   var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no";
	   
	var str=window.showModalDialog('/npage/s3200/group_flags.jsp?flags='+document.frm.flags.value,"",prop);
	   
	if( str != undefined ){
		document.frm.flags.value = str;
	}
	return true;
}

function refMain(){
getAfterPrompt();
    var checkFlag; //ע��javascript��JSP�ж���ı���Ҳ������ͬ,���������ҳ����.

    if (document.frm.grp_name.value.length > 36) {
        rdShowMessageDialog("VPMN�����û������36λ!");
        document.frm.grp_name.select();
        return false;
    }

    //˵��:���ֳ�����,һ���������Ƿ��ǿ�,��һ���������Ƿ�Ϸ�.
    if(check(frm))
    {
        if(  document.frm.grp_userno.value == "" ){
            rdShowMessageDialog("���Ŵ����������!!");
            //document.frm.grp_no.select();
            return false;
        }
        if(  document.frm.grp_name.value == "" ){
            rdShowMessageDialog("��������:"+document.frm.grp_name.value+",��������!!");
            document.frm.grp_name.select();
            return false;
        }
        if(  document.frm.serv_area.value == "" ){
            rdShowMessageDialog("��������ҵ�����ű�������!!");
            document.frm.serv_area.select();
            return false;
        }
        if(  document.frm.inter_fee.value == "" ){
            rdShowMessageDialog("���ڷ���������������!!");
            document.frm.inter_fee.select();
            return false;
        }
        if(  document.frm.out_grpfee.value == "" ){
            rdShowMessageDialog("����������������������!!");
            document.frm.out_grpfee.select();
            return false;
        }
        if(  document.frm.adm_no.value == "" ){
            rdShowMessageDialog("���Ź���������������!!");
            document.frm.adm_no.select();
            return false;
        }
        if(  document.frm.out_fee.value == "" ){
            rdShowMessageDialog("�������������������!!");
            document.frm.out_fee.select();
            return false;
        }
        if(  document.frm.normal_fee.value == "" ){
            rdShowMessageDialog("���Żݷ���������������!!");
            document.frm.normal_fee.select();
            return false;
        }
        if(  document.frm.trans_no.value == "" ){
            rdShowMessageDialog("���л���Աת�Ӻű�������!!");
            document.frm.trans_no.select();
            return false;
        }
        if(  document.frm.max_users.value == "" ){
            rdShowMessageDialog("��������û�����������!!",0);
            document.frm.max_users.select();
            return false;
        }
    
        //2.ת��ҵ����ʼ���ں�ҵ��������ڵ�YYYYMMDD---->YYYY-MM-DD
        if(!forDate(document.frm.srv_start)){
            rdShowMessageDialog("ҵ����ʼ����:"+document.frm.srv_start.value+",���ڲ��Ϸ�!!",0);
            document.frm.srv_start.select();
            return false;
        }
        if(!forDate(document.frm.srv_start)){
            rdShowMessageDialog("ҵ���������:"+document.frm.srv_stop.value+",���ڲ��Ϸ�!!",0);
            document.frm.srv_stop.select();
    
            return false;
        }
        //ҵ����ʼ���ں�ҵ��������ڵ�ʱ��Ƚ�
        checkFlag = dateCompare(document.frm.srv_start.value,document.frm.srv_stop.value);
        if( checkFlag == 1 ){
            rdShowMessageDialog("ҵ���������Ӧ�ô���ҵ����ʼ����!!",0);
            document.frm.srv_stop.select();
            return false;
        }
        //���ڲ���̫�࣬��Ҫͨ��form��post����,���,��Ҫ����������ݸ��Ƶ���������. yl.
        document.frm.chgsrv_start.value = changeDateFormat(document.frm.srv_start.value);
        document.frm.chgsrv_stop.value  = changeDateFormat(document.frm.srv_stop.value);
    
        if( parseInt(document.frm.pmax_close.value) > 5){
            rdShowMessageDialog("�����û����ɼ���ıպ�Ⱥ��:"+document.frm.pmax_close.value+",��Χ[0,5]!!",0);
            document.frm.pmax_close.select();
            return false;
        }
        checkFlag = parseInt(document.frm.max_users.value);
        if(checkFlag < 20 || checkFlag > 1000){
            rdShowMessageDialog("���ſ�ӵ�е�����û���:"+document.frm.max_users.value+",��Χ[20,50000]!!",0);
            document.frm.max_users.select();
            return false;
        }
        checkFlag = isValidYYYYMMDD(document.frm.pkg_day.value);
        if(checkFlag < 0 ){
            rdShowMessageDialog("�ʷ��ײ���Ч����:"+document.frm.pkg_day.value+",���ڲ��Ϸ�!!",0);
            document.frm.pkg_day.select();
            return false;
        }
        //�������ڵ�ǰ����
        checkFlag = dateCompare(document.frm.srv_start.value,document.frm.pkg_day.value);
        if( (checkFlag == 1) || (checkFlag == 0) ){
            rdShowMessageDialog("�������ڵ�ǰ����!!",0);
            document.frm.pkg_day.select();
            return false;
        }
		//��������У��
		function dateCompare(sDate1,sDate2){
	
	if(sDate1>sDate2)	//sDate1 ���� sDate2
		return 1;
	if(sDate1==sDate2)	//sDate1��sDate2 Ϊͬһ��
		return 0;
	return -1;		//sDate1 ���� sDate2
}

		if((document.all.user_passwd.value).trim().length >0)
        {
            if(document.all.user_passwd.value.length!=6)
            {
                rdShowMessageDialog("�ͻ����볤������",0);
                document.all.user_passwd.focus();
                return false;
             }
             if(checkUserPwd(document.frm.user_passwd,document.frm.account_passwd)==false)
                return false;
        }
    		if(document.all.contact.value.length > 9)//luxc20061217 ��ϵ���������9������dvpmngrpmsg//ҳ�治�ֺ�����ĸ
    		{
    				rdShowMessageDialog("��ϵ���������9����!",0);
            document.frm.contact.select();
            return false;
    		}
    
    
        //���ڲ���̫�࣬��Ҫͨ��form��post����,���,��Ҫ����������ݸ��Ƶ���������. yl.
        document.frm.chgpkg_day.value = changeDateFormat(document.frm.pkg_day.value);
        document.frm.sysnote.value = "VPMN���ſ���";
        
        
        var ret = showPrtDlg("Detail","ȷʵҪ���е��������ӡ��","Yes"); 
		    if(typeof(ret)!="undefined")
		     {
		        if((ret=="confirm"))
		        {
		          if(rdShowConfirmDialog('ȷ�ϵ����������ȷ��,���ύ����ҵ��!')==1)
		          {
		             page = "s3200Cfm.jsp";
				         frm.action=page;
				         frm.method="post";
				         frm.submit();
		          }
			      }
			      if(ret=="continueSub")
			      {
		          if(rdShowConfirmDialog('ȷ��Ҫ�ύ��Ϣ��')==1)
		          {
		            page = "s3200Cfm.jsp";
				        frm.action=page;
				        frm.method="post";
				        frm.submit();
		          }
			      }
			    }
			    else
		      {
		        if(rdShowConfirmDialog('ȷ��Ҫ�ύ��Ϣ��')==1)
		        {
		            page = "s3200Cfm.jsp";
				        frm.action=page;
				        frm.method="post";
				        frm.submit();
		        }
		      }
	    /*    
	    page = "s3200Cfm.jsp";
      frm.action=page;
      frm.method="post";
      frm.submit();
	     */   
	}
}


function printInfo(printType)
{		
			var grp_typeIndex=document.all.grp_type.selectedIndex;
			var inter_feeIndex=document.all.inter_fee.selectedIndex;
			var displayIndex=document.all.display.selectedIndex;
			var grp_type=document.all.grp_type.options[grp_typeIndex].text;
			var inter_fee=document.all.inter_fee.options[inter_feeIndex].text;
			var display=document.all.display.options[displayIndex].text;
			
	  	var retInfo = "";
      retInfo+='<%=workno%>  <%=workname%>'+"|";
      retInfo+='<%=new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(Calendar.getInstance().getTime())%>'+"|";
      
      retInfo+="��������"+document.all.grp_name.value+"|";
      retInfo+="���Ŵ���"+document.all.grp_userno.value+"|";
	    retInfo+="��ϵ������"+document.all.contact.value+"|";
      retInfo+="������ϵ��ַ"+document.all.address.value +"|";
      retInfo+="������ϵ�绰: "+document.all.telephone.value+"|";
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
      
      retInfo+="����ҵ��"+"������VPMN����"+"|";
      retInfo+="���ڷ���"+inter_fee+"|";
	    retInfo+="��������û���"+document.all.max_users.value+"|";
	    retInfo+="��ʾ��ʽ			"+display+"|";     
	    retInfo+="��������			"+grp_type+"|";
	    retInfo+="ҵ��ʼʱ��		"+document.all.srv_start.value+"|";
	    retInfo+="ҵ�����ʱ��		"+document.all.srv_stop.value+"|";
	    retInfo+=" "+"|";
	    retInfo+=" "+"|";
      retInfo+=" "+"|";
      retInfo+=" "+"|";

	  return retInfo;
}

 function showPrtDlg(printType,DlgMessage,submitCfm)
{  //��ʾ��ӡ�Ի��� 
     var h=178;
     var w=390;
     var t=screen.availHeight/2-h/2;
     var l=screen.availWidth/2-w/2;
   
     var printStr = printInfo(printType);
   
     var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no"; 
     var path = "<%=request.getContextPath()%>/npage/innet/hljGdPrint.jsp?DlgMsg=" + DlgMessage;
     var path = path + "&printInfo=" + printStr + "&submitCfm=" + submitCfm;
     var ret=window.showModalDialog(path,"",prop);
     return ret;     
}

</script>
<BODY>
<FORM action="" method="post" name="frm" >
	

<%@ include file="/npage/include/header.jsp" %>


	<div class="title">
		<div id="title_zi">VPMN���ſ���</div>
	</div>
<input type="hidden" name="chgsrv_start" value="">
<input type="hidden" name="chgsrv_stop"  value="">
<input type="hidden" name="belong_code"  value="">
<input type="hidden" name="login_accept"  value="0">
<input type="hidden" name="tmp1"  value="">
<input type="hidden" name="tmp2"  value="">
<input type="hidden" name="tmp3"  value="">
<input type="hidden" name="tfFlag" value="n">
<input type="hidden" name="chgpkg_day" value="">
<input type="hidden" name="product_type" value="">
<input type="hidden" name="product_prices" value="">
<input type="hidden" name="service_code" value="">
<input type="hidden" name="service_attr" value="">
<input type="hidden" name="TCustId"  value="">
<input type="hidden" name="unit_name"  value="">
<input type="hidden" name="op_type"  value="1">
<input type="hidden" name="op_code"  value="3200">
<input type="hidden" name="fee_rate"  value="1">
<input type="hidden" name="lock_flag"  value="0">
<input type="hidden" name="busi_type"  value="01">
<input type="hidden" name="use_status"  value="Y">
<input type="hidden" name="cover_region"  value="">
<input type="hidden" name="max_outnumcl"  value="10">
<input type="hidden" name="org_id"  value="<%=OrgId%>">

<input type="hidden" name="group_id"  value="<%=group_id%>">
<input type="hidden" name="chg_flag"  value="N">
<input type="hidden" name="bill_type"  value="0">
<input type="hidden" name="OrgCode"  value="<%=org_code%>">
<input type="hidden" name="region_code"  value="<%=regionCode%>">
<input type="hidden" name="district_code"  value="<%=districtCode%>">
<input type="hidden" name="WorkNo"   value="<%=workno%>">
<input type="hidden" name="NoPass"   value="<%=nopass%>">
<input type="hidden" name="ip_Addr"  value="<%=ip_Addr%>">


        <TABLE cellSpacing="0">
          <TR>
            <TD class="blue">
              <div align="left">���֤��</div>
            </TD>
            <TD class="blue">
                <input name=iccid  id="iccid" size="24" maxlength="18" v_type="string" v_must=1 v_name="���֤��" index="1" onchange="getInfo_Cust()">
                <input name=custQuery type="button" class="b_text" id="custQuery"  onclick="getInfo_Cust();" style="cursor:hand" value=��ѯ>
                 <font class="orange">*</font>
            </TD>
            <TD class="blue" width=18%>���ſͻ�ID</TD>
            <TD class="blue" width=32%><!--wuxy alter 20090513 Ϊ����100���ӹ���������ʾ�ͻ�ID-->
              <input  type="text" name="cust_id" size="20" maxlength="14" value="<%=cust_id%>" v_type="0_9" v_must=1 v_name="�ͻ�ID" index="2">
               <font class="orange">*</font>
            </TD>
          </TR>
          <TR>
            <TD class="blue">
               <div align="left">����ID</div>
            </TD>
            <TD class="blue">
		    <input name=unit_id  id="unit_id" size="24" maxlength="10" value="" v_type="0_9" v_must=1 v_name="����ID" index="3">
             <font class="orange">*</font>
            </TD>
            <TD class="blue" width=18%>���ſͻ�����</TD>
            <TD class="blue" width=32%>
              <input  name="cust_name" size="20" value="" readonly  Class="InputGrey" v_must=1 v_type=string v_name="�ͻ�����" index="4">
               <font class="orange">*</font> </TD>
          </TR>
          <TR>
            <TD class="blue">���ſͻ�����</TD>
            <TD class="blue">
				<jsp:include page="f3200_pwd.jsp">
					<jsp:param name="width1" value="16%"  />
					<jsp:param name="width2" value="34%"  />
					<jsp:param name="pname" value="custPwd"  />
					<jsp:param name="pwd" value=""  />
						<jsp:param name="pvalue" value=""  />
				</jsp:include>
            <input name=chkPass type="button" class="b_text" onClick="check_HidPwd();"  style="cursor:hand" id="chkPass2" value=У��>
             <font class="orange">*</font>
            </TD>
            <TD class="blue">�����û�����</TD>
            <TD class="blue">
              <input name="grp_name" type="text"  size="20" maxlength="60" value="" v_must=1 v_maxlength=60 v_type="string" v_name="�����û�����">
             <font class="orange">*</font>
            </TD>
          </TR>
          <TR>
            <TD class="blue">����Ʒ��</TD>
            <TD class="blue">
<select name="sm_code" id="sm_code" onChange="changeSmCode()" v_must=1 v_type="string" v_name="����Ʒ��" index="10">
<%
        try
        {
                sqlStr = "select distinct a.sm_code, a.sm_name from sSmCode a, sGrpSmCode b where a.sm_code = b.sm_code and a.sm_code = 'vp'";

                //retArray = callView.sPubSelect("2",sqlStr);
                %>
                
 		<wtc:pubselect name="sPubSelect" outnum="2" retmsg="msg" retcode="code" routerKey="region" routerValue="<%=regionCode%>">
  	 <wtc:sql><%=sqlStr%></wtc:sql>
 	  </wtc:pubselect>
	 <wtc:array id="result_tu2" scope="end"/>               
                
                <%
                result = result_tu2;
                int recordNum = result.length;
                if (result[0][0].trim().length() == 0)
                    recordNum = 0;
                for(int i=0;i<recordNum;i++){
                    out.println("<option class='button' value='" + result[i][0] + "'>" + result[i][1] + "</option>");
                }
        }catch(Exception e){
                logger.error("Call sunView is Failed!");
        }
%>  <font class="orange">*</font>
</select>
           </TD>
            <TD class="blue">��Ʒ����</TD>
            <TD class="blue">
              <input  type="text" name="product_attr" size="20" readonly  Class="InputGrey"  onChange="changeProdAttr()" v_must=1 v_type="string" v_name="��Ʒ����">
              <input name="ProdAttrQuery" type="button" class="b_text" id="ProdAttrQuery"   onclick="getInfo_ProdAttr();" value="ѡ��">
			   <font class="orange">*</font>
            </TD>
          </TR>
          <TR>
            <TD class="blue">��������Ʒ</TD>
            <TD class="blue">
              <input  type="text" name="product_code" size="20" value="" readonly  Class="InputGrey" onChange="changeProduct()" v_must=1 v_type="string" v_name="��������Ʒ">
              <input name="prodQuery" type="button" class="b_text" id="ProdQuery"   onclick="getInfo_Prod();" value="ѡ��">
			   <font class="orange">*</font>
            </TD>
            <TD class="blue">���Ÿ��Ӳ�Ʒ</TD>
            <TD class="blue">
              <input  type="text" name="product_append" size="20" value="" readonly  Class="InputGrey" v_must=0 v_type="string" v_name="���Ÿ��Ӳ�Ʒ">
              <input name="ProdAppendQuery" type="button" class="b_text" id="ProdAppendQuery"   onclick="getInfo_ProdAppend();" value="ѡ��">
            </TD>
          </TR>
          <TR>
            <TD class="blue" >���Ų�ƷID</TD>
            <TD class="blue">
              <input name="grp_id" type="text"  size="20" maxlength="12" value="" readonly  Class="InputGrey" v_type="0_9" v_must=1 v_name="�û�ID">
              <input name="grpQuery" type="button" class="b_text" id="grpQuery"   onclick="getUserId();" value="��ȡ">
               <font class="orange">*</font>
            </TD>
            <TD class="blue" >���ű��</TD>
            <TD class="blue">
              <input name="grp_userno" type="text"  size="20" maxlength="12" value="" readonly  Class="InputGrey" v_type="0_9" v_must=1 v_name="�����û����">
              <input name="getGrpNo" type="button" class="b_text"  id="getGrpNo" onclick="getGrpUserNo();" value="���" >
               <font class="orange">*</font>
            </TD>
          </TR>
          <TR>
            <TD class="blue" >�ʻ�ID</TD>
            <TD class="blue">
              <input name="account_id" type="text"  size="20" maxlength="12" value="" readonly  Class="InputGrey" v_type="0_9" v_must=1 v_name="�ʻ�ID">
              <input name="accountQuery" type="button" class="b_text"  id="accountQuery" onclick="getAccountId();"  value="��ȡ" >
              <!--<input name="accountSelect" type="button" class="b_text"  id="accountSelect" onMouseUp="getInfo_Acct();" onKeyUp="if(event.keyCode==13)getInfo_Acct();" value="ѡ��" >-->
               <font class="orange">*</font>
            </TD>
            <TD class="blue" >���ʽ</TD>
            <TD class="blue">
<select name="pay_code" id="pay_code" v_must=1 v_type="string" v_name="���ʽ" index="10">
<%
        try
        {
                sqlStr = "select pay_code, pay_name from sPayCode where region_code = '" + regionCode + "' order by pay_code";
                //retArray = callView.sPubSelect("2",sqlStr);
                %>
                
 		<wtc:pubselect name="sPubSelect" outnum="2" retmsg="msg" retcode="code" routerKey="region" routerValue="<%=regionCode%>">
  	 <wtc:sql><%=sqlStr%></wtc:sql>
 	  </wtc:pubselect>
	 <wtc:array id="result_tu3" scope="end"/>               
                
                <%
                result = result_tu3;
                int recordNum = result.length;
                for(int i=0;i<recordNum;i++){
                    out.println("<option class='button' value='" + result[i][0] + "'>" + result[i][1] + "</option>");
                }
        }catch(Exception e){
                logger.error("Call sunView is Failed!");
        }
%>  <font class="orange">*</font>
</select>
               <font class="orange">*</font>
            </TD>
          </TR>
          <TR>
			<jsp:include page="pwd_2.jsp">
				<jsp:param name="width1" value="16%"  />
				<jsp:param name="width2" value="34%"  />
				<jsp:param name="pname" value="user_passwd"  />
				<jsp:param name="pcname" value="account_passwd"  />
			</jsp:include>
          </TR>
          <TR> 
            <TD class="blue">��������ʡ����</TD>
            <TD class="blue">
<%
        try
        {
                sqlStr = "select AGENT_PROV_CODE from sprovinceCode where run_flag = 'Y'";
                //retArray = callView.sPubSelect("1",sqlStr);
                %>
                
   <wtc:pubselect name="sPubSelect" outnum="1" retmsg="msg" retcode="code" routerKey="region" routerValue="<%=regionCode%>">
  	 <wtc:sql><%=sqlStr%></wtc:sql>
 	  </wtc:pubselect>
	 <wtc:array id="result_tu4" scope="end"/>             
                
                <%
                result =result_tu4;
                if (result.length <= 0)
                {
                	logger.error("��ѯʡ�������ʧ��!");
                }
                agentProvCode = result[0][0];
        }catch(Exception e){
                logger.error("��ѯ����ʡ����ʧ��!");
        }
%>
              <input  type="text" name="province" size="20" value="<%=agentProvCode%>" readonly  Class="InputGrey" v_must=1 v_type="0_9" v_name="��������ʡ����" index="11">
               <font class="orange">*</font>
            </TD>
            <TD class="blue" width="117">ҵ������</TD>
            <TD class="blue" width="253"> 
              
<%
        try
        {
            sqlStr = "select trim(toll_no) from sRegionCode where region_code = '" + regionCode + "'";
            %>
            
     <wtc:pubselect name="sPubSelect" outnum="1" retmsg="msg" retcode="code" routerKey="region" routerValue="<%=regionCode%>">
  	 <wtc:sql><%=sqlStr%></wtc:sql>
 	  </wtc:pubselect>
	 <wtc:array id="result_tu5" scope="end"/>              
            
            <%
            //retArray = callView.sPubSelect("1",sqlStr);
            result = result_tu5;
            int tollNum = result.length;
            if (tollNum <= 0)
            {
            	logger.error("��ѯҵ������ʧ��!");
            }
			servArea = agentProvCode + "0" + result[0][0] + "01";
        }catch(Exception e){
                logger.error("��ѯҵ������ʧ��!");
        }
%>
              <input  type="text" name="serv_area" size="20" value="<%=servArea%>" onKeyPress="return isKeyNumberdot(0)" v_must=1 v_type="0_9" v_name="ҵ������" index="12" readonly  Class="InputGrey">
               <font class="orange">*</font> </TD>
          </TR>
          <TR>
<%
        //�õ��������
        try																			
        {
                sqlStr ="select scp_id from  svpmnscp Where region_code='" + regionCode + "'"; 
               //retArray = callView.sPubSelect("1",sqlStr);
                %>
                
		<wtc:pubselect name="sPubSelect" outnum="1" retmsg="msg" retcode="code" routerKey="region" routerValue="<%=regionCode%>">
  	 <wtc:sql><%=sqlStr%></wtc:sql>
 	  </wtc:pubselect>
	 <wtc:array id="result_tu6" scope="end"/>                
                
                
                <%
                result = result_tu6;
        }catch(Exception e){
                logger.error("Call sunView is Failed!");
        }              
%>
            <TD class="blue">SCP��</TD>
            <TD class="blue">
              <input  type="text" name="scp_id" size="20" onKeyPress="return isKeyNumberdot(0)" value="<%=result[0][0]%>" v_must=1 v_type="0_9" v_name="SCP��" index="13"> (�����в�ͬ)
            </TD>
            <TD class="blue" width="117">��������</TD>
            <TD class="blue" width="253"> 
              <select name="grp_type" id="grp_type">
              <%
                if(workno.equals("aavg21")){
							%>
								<option value="0"selected >0->���ؼ���</option>
                <option value="1">1->ȫʡ����</option>
                <option value="2">2->ȫ������</option>
                <option value="3">3->���ػ�ʡ������</option>
							<%
							}else{
							%>
                <option value="0"selected >0->���ؼ���</option>
              <%}%>
              </select> <font class="orange">*</font>
            </TD>
          </TR>
          <TR>
            <TD class="blue" width="130">��ϵ������</TD>
            <TD class="blue" width="239"> 
              <input name="contact" type="text"  id="contact" size="20"  v_must=0 v_type="string" v_name="��ϵ������" index="14">
            </TD>
            <TD class="blue" width="117">������ϵ��ַ</TD>
            <TD class="blue" width="253"> 
              <input name="address" type="text"  id="address" size="20"  v_must=0 v_type="string" v_name="������ϵ��ַ" index="15">
            </TD>
          </TR>
          <TR> 
            <TD class="blue" width="130">������ϵ�绰</TD>
            <TD class="blue" width="239"> 
              <input name="telephone" type="text"  id="telephone" maxlength=12 onKeyPress="return isKeyNumberdot(0)" size="20" v_must=0 v_type="string" v_name="������ϵ�绰">
            </TD>
            <TD class="blue" width="117">ҵ�񼤻��־</TD>
            <TD class="blue" width="253"> 
              <select name="sub_state" id="sub_state">
                <option value="0" >0->δ����</option>
                <option value="1" selected>1->����</option>
              </select> <font class="orange">*</font>
            </TD>
          </TR>
          <TR> 
            <TD class="blue" width="130">ҵ����ʼ����</TD>
            <TD class="blue" width="239"> 
              <input name="srv_start" type="text"  id="srv_start"  onKeyPress="return isKeyNumberdot(0)" value="<%=dateStr%>" size="20" maxlength="8" v_must=0 v_type="date" v_name="ҵ����ʼ����"  v_format="yyyyMMdd">
            </TD>
            <TD class="blue" width="117">ҵ���������</TD>
            <TD class="blue" width="253"> 
            	<!--update by wangzn Date100-->
              <input name="srv_stop" type="text"  id="srv_stop"  onKeyPress="return isKeyNumberdot(0)" value="20500101" size="20" maxlength="8" v_must=0 v_type="date" v_name="ҵ���������"  v_format="yyyyMMdd" readonly>
            </TD>
          </TR>
          <TR>
            <TD class="blue">�û����ܼ�</TD>
            <TD class="blue" colspan="1">
              <input  type="text" name="flags" size="36" value="220000221110000000010100000000000000" readonly  Class="InputGrey">
              <input type="button" class="b_text" name="updateFlsg"  value="�޸�" onclick="call_flags()" v_must=1 v_type="string" v_name="�û����ܼ�"> <font class="orange">*</font>
            </TD>
           <TD class="blue">�Ƿ�Ϊ�ۺ�v��</TD>
           <TD class="blue" class="formTd">
		          <select name=flags_no_2> 
   		            <option value="0">��</option>	
		              <option value="1">��׼�ۺ�v��</option>	
			            <option value="2">�����ۺ�v��</option>
			        </select>	
          </td>    	 		
             	
          </TR>
          <TR>
            <TD class="blue">���ڷ�������</TD>
            <TD class="blue"> <select name="inter_fee" v_must=1 v_type="0_9" v_name="���ڷ�������">
<%
        try
        {
                sqlStr ="select FEEINDEX,FEEINDEX||'-->'||FEEINDEX_NAME from  svpmnfeeindex  where feeindex > 0 and region_code='"+regionCode+"' and stop_time>=sysdate and power_right<="+powerRight+" order by feeindex";
                //System.out.println("luxc:"+sqlStr);
                //retArray = callView.sPubSelect("2",sqlStr);
                %>
                
 		<wtc:pubselect name="sPubSelect" outnum="2" retmsg="msg" retcode="code" routerKey="region" routerValue="<%=regionCode%>">
  	 <wtc:sql><%=sqlStr%></wtc:sql>
 	  </wtc:pubselect>
	 <wtc:array id="result_tu7" scope="end"/>               
                
                <%
               
                result = result_tu7;
                int recordNum = result.length;
                for(int i=0;i<recordNum;i++){
                        out.println("<option class='button' value='" + result[i][0] + "'>" + result[i][1] + "</option>");
                }
        }catch(Exception e){
                logger.error("Call sunView is Failed!");
        }
%>
            </select>
             <font class="orange">*</font> </TD>
            <TD class="blue">�����������</TD>
            <TD class="blue">
              <input  type="text" name="out_fee" size="20" value="1" readonly  Class="InputGrey" onKeyPress="return isKeyNumberdot(0)" v_must=1 v_type="0_9" v_name="�����������">
               <font class="orange">*</font> </TD>
          </TR>
          <TR>
            <TD class="blue">��������������</TD>
            <TD class="blue">  <select name="out_grpfee" v_must=0 v_type="0_9" v_name="��������������">
<%
            int recordNum = result.length;
            for(int i=0;i<recordNum;i++){
                    out.println("<option class='button' value='" + result[i][0] + "'>" + result[i][1] + "</option>");
            }
%>
            </select>
               <font class="orange">*</font> 
            </TD>
            <TD class="blue">���Żݷ�������</TD>
            <TD class="blue">
              <input  type="text" name="normal_fee" size="20" value="1" readonly  Class="InputGrey" onKeyPress="return isKeyNumberdot(0)" v_must=0 v_type="0_9" v_name="���Żݷ�������">
               <font class="orange">*</font> </TD>
          </TR>
          <TR>
            <TD class="blue">���Ź��������</TD>
            <TD class="blue">
              <input  type="text" name="adm_no" size="20" value="61860" onKeyPress="return isKeyNumberdot(0)" v_must=0 v_type="0_9" v_name="���Ź��������">
               <font class="orange">*</font> </TD>
            <TD class="blue">���л���Աת�Ӻ�</TD>
            <TD class="blue">
              <input  type="text" name="trans_no" size="20" value="1860" onKeyPress="return isKeyNumberdot(0)" v_must=0 v_type="0_9" v_name="���л���Աת�Ӻ�">
               <font class="orange">*</font> </TD>
          </TR>
          <TR>
            <TD class="blue">���к�����ʾ��ʽ</TD>
            <TD class="blue">
              <select name="display" id="display" v_must=1 v_type="0_9" v_name="���к�����ʾ��ʽ">
                <option value="0">0->ʹ�ø��˱�־</option>
                <option value="1" selected>1->��ʾ�̺�</option>
                <option value="2">2->��ʾ��ʵ����</option>
                <option value="3">3->PBX������ʾ��ʵ���룬������ʾ�̺�</option>
              </select> <font class="orange">*</font>
            </TD>
            <TD class="blue">�������պ�Ⱥ��</TD>
            <TD class="blue">
              <input  type="text" name="max_clnum" size="20" value="10" onKeyPress="return isKeyNumberdot(0)" v_must=0 v_type="0_9" v_name="�������պ�Ⱥ��">
            </TD>
          </TR>
          <TR>
            <TD class="blue">���պ�Ⱥ����û���</TD>
            <TD class="blue">
              <input  type="text" name="max_numcl" size="20" value="100" v_must=1 v_type="int" v_name="���պ�Ⱥ����û���" onKeyPress="return isKeyNumberdot(0)">
            </TD>
            <TD class="blue">���û�������պ�Ⱥ��</TD>
            <TD class="blue">
              <input  type="text" name="pmax_close" size="20" value="1" v_must=1 v_type="int" v_name="���û�������պ�Ⱥ��" onKeyPress="return isKeyNumberdot(0)">
            </TD>
          </TR>
          <TR>
            <TD class="blue">����������������</TD>
            <TD class="blue">
              <input  type="text" name="max_outnum" size="20" value="100" v_must=1 v_type="int" v_name="����������������" onKeyPress="return isKeyNumberdot(0)">
            </TD>
            <TD class="blue">��������û���</TD>
            <TD class="blue">
              <input  type="text" name="max_users" size="20" v_must=1 v_type="int" value="1000" v_name="��������û���" onKeyPress="return isKeyNumberdot(0)">
            	 <font class="orange">*</font>
            </TD>
          </TR>
          <TR>
            <TD class="blue">�����ʷ��ײ�����</TD>
            <TD class="blue">
              <select name="pkg_type" v_must=0 v_type="0_9" v_name="�����ʷ��ײ�����">
                <option value="0" selected >0->���ײ�</option>
                <option value="1">1->�ײ�</option>
              </select>
            </TD>
            <TD class="blue">�ʷ��ײ���Ч����</TD>
            <TD class="blue">
              <input name="pkg_day" type="text"  id="pkg_day" v_must=0 v_type="date" v_name="�ʷ��ײ���Ч����" onKeyPress="return isKeyNumberdot(0)" value="<%=addDate%>" size="20" >
            </TD>
          </TR>
          <TR>
            <TD class="blue">���ۿ�</TD>
            <TD class="blue">
              <input  type="text" name="discount" size="20" value="100" v_must=1 v_type="int" v_name="���ۿ�" onKeyPress="return isKeyNumberdot(1)">
            </TD>
            <TD class="blue">�����·����޶�</TD>
            <TD class="blue">
              <input  type="text" name="lmt_fee" size="20" value="1000000" v_must=1 v_type="int" v_name="�����·����޶�" onKeyPress="return isKeyNumberdot(1)">
            </TD>
          </TR>
        </TABLE>
        <TABLE cellSpacing="0">
           <TR>
               <TD class="blue" width="18%">��ע</TD>
               <TD class="blue" width="82%" colspan="3">
               <input  name="sysnote" size="60" readonly  Class="InputGrey">
               <input  name="tonote" size="60" type="hidden">
               </TD>
           </TR>

       </TABLE>

        <TABLE width="98%" border=0 align=center cellpadding="4" cellSpacing=1>
          <TBODY>
            <TR>
              <TD align=center id="footer">
              <input  name="sure"  type="button"  class="b_foot" value="ȷ��" onclick="refMain()"  >
              <input  name="reset1"  onClick="" type=reset value="���"  class="b_foot">
              <input  name="kkkk"  onClick="parent.window.close()" type="button" class="b_foot" value="�ر�">
              </TD>
            </TR>
          </TBODY>
        </TABLE>

		<jsp:include page="/npage/common/pwd_comm.jsp"/>
			<%@ include file="/npage/include/footer.jsp" %>
</FORM>
 <script language="JavaScript">
 document.frm.iccid.focus();
 query_prodAttr();
 </script>
</BODY>
</HTML>



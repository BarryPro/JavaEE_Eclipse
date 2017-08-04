<%
/********************
 * version v2.0
 * ������: si-tech
 * update by qidp @ 2009-01-15
 ********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="org.apache.log4j.Logger"%>
<%@ page import="com.sitech.boss.pub.*" %>
<%@ page import="com.sitech.boss.spubcallsvr.viewBean.SPubCallSvrImpl"%>
<%@ page import="com.sitech.boss.s1900.config.productCfg" %>
<%@ include file="../../include/remark.htm" %>

<%
    String opCode = "3519";
    String opName = "���Ų�Ʒ�ʷѱ��";
    Logger logger = Logger.getLogger("f3519.jsp");

    String ip_Addr = (String)session.getAttribute("ipAddr");
    String workno = (String)session.getAttribute("workNo");
    String workname = (String)session.getAttribute("workName");
    String org_code = (String)session.getAttribute("orgCode");
    String nopass  = (String)session.getAttribute("password");
    String Department = org_code;
    String regionCode = Department.substring(0,2);
    String districtCode = Department.substring(2,4);

    String sqlStr = "";
    ArrayList retArray = new ArrayList();
    String[][] result = new String[][]{};

%>
<html xmlns="http://www.w3.org/1999/xhtml">
<HEAD>
<TITLE>���Ų�Ʒ�ʷѱ��</TITLE>
</HEAD>
<SCRIPT type=text/javascript>

//core.loadUnit("debug");
//core.loadUnit("rpccore");
onload=function(){
    //core.rpc.onreceive = doProcess;
}

function doProcess(packet)
{
    var retType = packet.data.findValueByName("retType");
    var retCode = packet.data.findValueByName("retCode");
    self.status="";

    //---------------------------------------
    if(retType == "GrpCustInfo") //BOSS�����û���Ʒ����ͻ���Ϣ��ѯ
    {
        var retname = packet.data.findValueByName("retname");
        if(retCode=="000000")
        {
            document.frm.cust_name.value = retname;
			document.frm.unit_id.focus();
        }
        else
        {
            retMessage = retMessage + "[errorCode1��" + retCode + "]";
            rdShowMessageDialog(retMessage,0);
            return false;
        }
     }
	 if(retType == "getSysAccept")
     {
        if(retCode == "000000")
        {
            var sysAccept = packet.data.findValueByName("sysAccept");
			document.frm.login_accept.value=sysAccept;
			showPrtDlg("Detail","ȷʵҪ��ӡ���������","Yes");
			if (rdShowConfirmDialog("�Ƿ��ύȷ�ϲ�����")==1){
				page = "f3519_cfm.jsp";
				frm.action=page;
				frm.method="post";
				frm.submit();
			}
			else return false;
         }
        else
        {
                rdShowMessageDialog("��ѯ��ˮ����,�����»�ȡ��",0);
				return false;
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
	        	frm.custPwd.value = "";
	        	frm.custPwd.focus();
    	    	return false;	        	
            } else {
                rdShowMessageDialog("�ͻ�����У��ɹ���",2);
                document.frm.sysnote.value = "BOSS���Ų�Ʒ�ʷѱ��";
                document.frm.tonote.value = "BOSS���Ų�Ʒ�ʷѱ��";
                document.frm.sure.disabled = false;
            }
         }
        else
        {
            rdShowMessageDialog("�ͻ�����У�����������У�飡",0);
    		return false;
        }
     }
     


	var retType = packet.data.findValueByName("retType");
    var retCode = packet.data.findValueByName("retCode");
	var retMessage=packet.data.findValueByName("retMessage");
    self.status="";
    if(retType == "UserId")
    {
        if(retCode == "000000")
        {
            var retUserId = packet.data.findValueByName("retnewId");    	    
    	    document.frm.grp_id.value = retUserId;
			document.frm.grp_userno.value=retUserId;
            document.frm.reset1.disabled = false;
    	    document.frm.grpQuery.disabled = true;
            document.frm.grp_name.focus();
         }
        else
        {
            rdShowMessageDialog("û�еõ��û�ID,�����»�ȡ��",0);
			return false;
        }
		//�õ������û���ŵ�ʱ�򣬵õ����Ŵ���
		//getGrpId();
    }
    if(retType == "GrpId") //�õ����Ŵ���
    {
        if(retCode == "000000")
        {
            var GrpId = packet.data.findValueByName("GrpId");
            document.frm.grp_userno.value = oneTok(GrpId,"|",1);
         }
        else
        {
            var retMessage = packet.data.findValueByName("retMessage");
            rdShowMessageDialog(retMessage, 0);
        }
	}
    if(retType == "GrpNo") //�õ������û����
    {
        if(retCode == "0")
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
   
    if(retType == "AccountId") //�õ��ʻ�ID
    {
        if(retCode == "000000")
        {
            var retnewId = packet.data.findValueByName("retnewId");
            document.frm.account_id.value = retnewId;
            document.frm.accountQuery.disabled = true;
			document.frm.user_passwd.focus();
         }
        else
        {
            rdShowMessageDialog("û�еõ��ʻ�ID,�����»�ȡ��",0);
        }
    }
    //---------------------------------------
    if(retType == "UnitInfo")
    {
        //������Ϣ��ѯ
        var retname = packet.data.findValueByName("retname");
        if(retCode=="000000")
        {
            document.frm.unit_name.value = retname;
			document.frm.contract_name.focus();
        }
        else
        {
            retMessage = retMessage + "[errorCode1:" + retCode + "]";
                rdShowMessageDialog(retMessage,0);
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
                document.frm.ProdAttrQuery.disabled = false;
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
    if(retType=="getBillingType")//�õ�sbillspcode�е� billingtype luxc add 20070916
    {
    	
    	if(retCode="000000")
    	{
    		
    		var billingtype = packet.data.findValueByName("billingtype");
    		document.all.billingtype.value = billingtype;
    		
    		if(billingtype == "00" || billingtype == "01")//�����ѻ����
    		{
    			document.all.tr_gongnengfee.style.display = "none";
    		}
    		else if(billingtype == "02")//�������
    		{
    			document.all.tr_gongnengfee.style.display = "block";
    		}
    		else
    		{
    			document.all.tr_gongnengfee.style.display = "none";
    			
    			//alert("��ѯsbillspcode,billingtype����="+billingtype);
    		}
    		
    	}
    	else
    	{
    		rdShowMessageDialog(retMessage);
    	}
    }
 }

//���ù������棬���м��ſͻ�ѡ��
function getInfo_Cust()
{
    var pageTitle = "���ſͻ�ѡ��";
    var fieldName = "֤������|�ͻ�ID|�ͻ�����|�û�ID|�û���� |�û�����|��Ʒ����|��Ʒ����|����ID|�����ʻ�|Ʒ������|Ʒ�ƴ���|";
	var sqlStr = "";
    var selType = "S";    //'S'��ѡ��'M'��ѡ
    var retQuence = "12|0|1|2|3|4|5|6|7|8|9|10|11|";
    var retToField = "iccid|cust_id|cust_name|grp_id|user_no|grp_name|product_code2|product_name2|unit_id|account_id|sm_name|sm_code|";
    var cust_id = document.frm.cust_id.value;
    if(document.frm.iccid.value == "" &&
       document.frm.cust_id.value == "" &&
       document.frm.unit_id.value == "" &&
       document.frm.user_no.value == "")
    {
        rdShowMessageDialog("������֤�����롢���ſͻ�ID�����ű�Ż��Ų�Ʒ��Ž��в�ѯ��",0);
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

    if(document.frm.user_no.value == "0")
    {
    	frm.user_no.value = "";
        rdShowMessageDialog("���Ų�Ʒ��Ų���Ϊ0��",0);
    	return false;
    }

    PubSimpSelCust(pageTitle,fieldName,sqlStr,selType,retQuence,retToField); 
}

function PubSimpSelCust(pageTitle,fieldName,sqlStr,selType,retQuence,retToField)
{
    var path = "<%=request.getContextPath()%>/npage/s3519/f3519_sel.jsp";
    path = path + "?sqlStr=" + sqlStr + "&retQuence=" + retQuence;
    path = path + "&fieldName=" + fieldName + "&pageTitle=" + pageTitle;
    path = path + "&selType=" + selType+"&iccid=" + document.all.iccid.value;
    path = path + "&cust_id=" + document.all.cust_id.value;
    path = path + "&unit_id=" + document.all.unit_id.value;
    path = path + "&user_no=" + document.all.user_no.value;

    retInfo = window.open(path,"newwindow","height=450, width=1000,top=50,left=100,scrollbars=yes, resizable=no,location=no, status=yes");

	return true;
}

function getvaluecust(retInfo)
{
  var retToField = "iccid|cust_id|cust_name|grp_id|user_no|grp_name|product_code2|product_name2|unit_id|account_id|sm_name|sm_code|";
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
}

function check_HidPwd()
{

	if(document.frm.product_code.value == document.frm.product_code2.value)
    {
        rdShowMessageDialog("���Ǿɵļ�������Ʒ��������ѡ���¼�������Ʒ��",0);
        document.frm.product_code.focus();
        return false;
    }
    
    var cust_id = document.all.cust_id.value;
    var Pwd1 = document.all.custPwd.value;
    var checkPwd_Packet = new AJAXPacket("../s3519/pubCheckPwd.jsp","���ڽ�������У�飬���Ժ�......");
    checkPwd_Packet.data.add("retType","checkPwd");
	checkPwd_Packet.data.add("cust_id",cust_id);
	checkPwd_Packet.data.add("Pwd1",Pwd1);
	core.ajax.sendPacket(checkPwd_Packet);
	checkPwd_Packet = null;		
}
function getSysAccept()
{
	var getSysAccept_Packet = new AJAXPacket("../s3519/pubSysAccept.jsp","�������ɲ�����ˮ�����Ժ�......");
	getSysAccept_Packet.data.add("retType","getSysAccept");
	core.ajax.sendPacket(getSysAccept_Packet);
	getSysAccept_Packet = null;   
}
function showPrtDlg(printType,DlgMessage,submitCfm)
{  //��ʾ��ӡ�Ի���
   var h=190;
   var w=400;
   var t=screen.availHeight/2-h/2;
   var l=screen.availWidth/2-w/2;
   var printStr = printInfo(printType);
   if(printStr == "failed")
   {    return false;   }

   var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no"
   var path = "<%=request.getContextPath()%>/npage/innet/hljPrint.jsp?DlgMsg=" + DlgMessage;
   var path = path + "&printInfo=" + printStr + "&submitCfm=" + submitCfm;
   var ret=window.showModalDialog(path,"",prop);
}
	 
function printInfo(printType)
{ 
		var retInfo = "";
 		retInfo+='<%=workname%>'+"|";
    	retInfo+='<%=new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss", Locale.getDefault()).format(new java.util.Date())%>'+"|";
    	retInfo+="֤������:"+document.frm.iccid.value+"|";
    	retInfo+="���ſͻ�����:"+document.frm.cust_name.value+"|";
    	retInfo+="���Ų�Ʒ���:"+document.frm.user_no.value+"|";
    	retInfo+="�ʻ�ID:"+document.frm.account_id.value+"|";
    	retInfo+="����Ʒ��:"+document.frm.sm_name.value+"|";
    	retInfo+=""+"|";
		retInfo+=""+"|";
    	retInfo+=""+"|";
    	retInfo+=""+"|";
    	retInfo+=""+"|";
    	retInfo+=""+"|";
    	retInfo+=""+"|";
    	retInfo+=""+"|";
    	retInfo+=""+"|";
    	retInfo+=""+"|";
    	retInfo+=""+"|";
    	retInfo+=""+"|";
    	retInfo+=""+"|";
    	retInfo+="ҵ�����ͣ�"+document.frm.sm_name.value+"BOSS���Ų�Ʒ�ʷѱ��"+"|";
    	retInfo+="��ˮ��"+document.frm.login_accept.value+"|";
    	retInfo+="���ǰ��Ʒ��"+document.frm.product_name2.value+"|";
    	retInfo+="������Ʒ��"+document.frm.product_code.value.replace(/\|/g,",")+"|";
    	retInfo+="���Ӳ�Ʒ��"+document.frm.product_append.value.replace(/\|/g,",")+"|";
    	retInfo+=""+"|";
    	retInfo+=""+"|";
    	retInfo+=""+"|";
    	retInfo+=""+"|";
    	retInfo+=document.all.tonote.value+" "+document.all.simBell.value+"|";
		 return retInfo;
}
function refMain(){
	getAfterPrompt();
    var checkFlag; //ע��javascript��JSP�ж���ı���Ҳ������ͬ,���������ҳ����.
    //˵�������ֳ�����,һ���������Ƿ��ǿ�,��һ���������Ƿ�Ϸ�.
    //if(check(frm))
    //{
        if(document.frm.product_code.value == ""){
            rdShowMessageDialog("'���Ų�Ʒ'Ϊ������������д");
            return false;
        }
        if(  document.frm.grp_name.value == "" ){
            rdShowMessageDialog("�������ƣ�"+document.frm.grp_name.value+",��������!!");
            document.frm.grp_name.select();
            return false;
        }
        if(  document.frm.grp_id.value == "" ){
            rdShowMessageDialog("���Ŵ����������!!");
            document.frm.grp_id.select();
            return false;
        }
        if(document.frm.product_code.value == document.frm.product_code2.value)
    {
        rdShowMessageDialog("���Ǿɵļ�������Ʒ��������ѡ���¼�������Ʒ��",0);
        document.frm.product_code.focus();
        return false;
    }
		getSysAccept();
		/*
        page = "QrySimBack_3707.jsp";
        frm.action=page;
        frm.method="post";
        frm.submit();
		*/
    //}
    
}  
  
//���ù������棬���в�Ʒ��Ϣѡ��
function getInfo_Prod()
{
    var pageTitle = "���Ų�Ʒѡ��";
    var fieldName = "��Ʒ����|��Ʒ����|�Ƿ��������|��Ч��ʽ|";
	  var sqlStr = "";
    var selType = "S";    //'S'��ѡ��'M'��ѡ
    var retQuence = "3|0|1|3|";
    var retToField = "product_code|product_name|send_flag|";

    //�����ж��Ƿ��Ѿ�ѡ���˷���Ʒ��
    if(document.frm.sm_code.value == "")
    {
        rdShowMessageDialog("������ѡ������Ϣ����Ʒ��",0);
        return false;
    }
    //�����ж��Ƿ��Ѿ�ѡ���˲�Ʒ����
    /*if(document.frm.product_attr.value == "")
    {
        rdShowMessageDialog("������ѡ���Ʒ���ԣ�",0);
        return false;
    }*/

    if(PubSimpSel(pageTitle,fieldName,sqlStr,selType,retQuence,retToField));
}

function PubSimpSel(pageTitle,fieldName,sqlStr,selType,retQuence,retToField)
{
    var path = "<%=request.getContextPath()%>/npage/s3519/fpubprod_sel.jsp";
    path = path + "?sqlStr=" + sqlStr + "&retQuence=" + retQuence;
    path = path + "&fieldName=" + fieldName + "&pageTitle=" + pageTitle;
    path = path + "&selType=" + selType;
	  path = path + "&op_code=" + document.all.op_code.value;
	  path = path + "&sm_code=" + document.all.sm_code.value; 
	  path = path + "&oldMainProduct=" + document.all.product_code2.value;
    path = path + "&product_attr=" + document.all.product_attr.value; 

    retInfo = window.open(path,"newwindow","height=450, width=800,top=50,left=200,scrollbars=yes, resizable=no,location=no, status=yes");
	
	return true;
}

function getvalue(retInfo, retInfoDetail)
{
  	var retToField = "product_code|product_name|send_flag|";
  	if(retInfo ==undefined)      
  	  {   return false;   }
  	var productNum = retInfo.indexOf("|");
  	var product = retInfo.substring(0,productNum);
  	
  	/***
  	if(product==document.all.product_code2.value)
  	{
  			rdShowMessageDialog("ѡ�������Ʒ�ͱ��ǰ������ͬ��",0);
  	      return false;	
  	}
  	***/
  	var retInfo2 = retInfo.substring(productNum+1);
  	var productNum2 = retInfo2.indexOf("|"); 
  	document.all.product_code.value = retInfo.substring(0,productNum+1)+ retInfo2.substring(0,productNum2+1);
  	var send_flag=retInfo2.substring(productNum2+1,retInfo2.length-1);
  	document.all.send_flag.value = send_flag;
  	document.frm.product_prices.value = retInfoDetail;
  	
  	/*luxc add*/
  	if(getBillingType(product));
  	
  
}

function getBillingType(product_code)
{
	//alert("getBillingType()product_code="+product_code);
	if((product_code).trim() == "")
    {
       	rdShowMessageDialog("ѡ���Ų�Ʒʧ��24!",0);
        return false;
    }

    var getBillingType_Packet = new AJAXPacket("fgetBillingType.jsp","���ڻ�ȡbillingtype�����Ժ�......");
	getBillingType_Packet.data.add("retType","getBillingType");
    getBillingType_Packet.data.add("product_code",product_code);
	core.ajax.sendPacket(getBillingType_Packet);
	getBillingType_Packet = null;
	
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
        rdShowMessageDialog("������ѡ������Ϣ����Ʒ��");
        return false;
    }
    //�����ж��Ƿ��Ѿ�ѡ���˲�Ʒ����
    /*if(document.frm.product_attr.value == "")
    {
        rdShowMessageDialog("������ѡ���Ʒ���ԣ�",0);
        return false;
    }*/
    //�����ж��Ƿ��Ѿ������˼��Ų�Ʒ
    if(document.frm.product_code.value == "")
    {
        rdShowMessageDialog("������ѡ���Ų�Ʒ��");
        return false;
    }

    if(PubSimpSelAppend(pageTitle,fieldName,sqlStr,selType,retQuence,retToField));
}

function PubSimpSelAppend(pageTitle,fieldName,sqlStr,selType,retQuence,retToField)
{
    var product_code = document.all.product_code.value;
    var chPos = product_code.indexOf("|");
    product_code = product_code.substring(0,chPos);
    var path = "<%=request.getContextPath()%>/npage/s3500/fpubprodappend_sel.jsp";
    path = path + "?sqlStr=" + sqlStr + "&retQuence=" + retQuence;
    path = path + "&fieldName=" + fieldName + "&pageTitle=" + pageTitle;
    path = path + "&selType=" + selType;
    path = path + "&showType=" + "Default";
	path = path + "&op_code=" + document.all.op_code.value;
	path = path + "&sm_code=" + document.all.sm_code.value; 
	path = path + "&product_code=" + product_code; 

    retInfo = window.open(path,"newwindow","height=450, width=800,top=50,left=200,scrollbars=yes, resizable=no,location=no, status=yes");

	return true;
}

function getvalueProdAppend(retInfo)
{
  var retToField = "product_append|product_name|";
  if(retInfo ==undefined)      
    {   return false;   }

  document.all.product_append.value = retInfo;
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
        rdShowMessageDialog("������ѡ�����Ʒ�ƣ�");
        return false;
    }

    if(PubSimpSelProdAttr(pageTitle,fieldName,sqlStr,selType,retQuence,retToField));
}
function PubSimpSelProdAttr(pageTitle,fieldName,sqlStr,selType,retQuence,retToField)
{
    var path = "<%=request.getContextPath()%>/page/s3519/fpubprodattr_sel.jsp";
    path = path + "?sqlStr=" + sqlStr + "&retQuence=" + retQuence;
    path = path + "&fieldName=" + fieldName + "&pageTitle=" + pageTitle;
    path = path + "&selType=" + selType;
		path = path + "&op_code=" + document.all.op_code.value;
		path = path + "&sm_code=" + document.all.sm_code.value; 

    retInfo = window.open(path,"newwindow","height=450, width=650,top=50,left=200,scrollbars=yes, resizable=no,location=no, status=yes");

	return true;
}
function changeProdAttr() {
	document.frm.product_code.value = "";
    document.frm.product_append.value = "";
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

</script>
<BODY>
<FORM action="" method="post" name="frm" >
<%@ include file="/npage/include/header.jsp" %>
<div class="title">
	<div id="title_zi">���Ų�Ʒ�ʷѱ��</div>
</div>
<input type="hidden" name="product_code2" value="">
<input type="hidden" name="product_level"  value="1">
<input type="hidden" name="op_type" value="1">
<input type="hidden" name="grp_no" value="0">
<input type="hidden" name="tfFlag" value="n">
<input type="hidden" name="chgpkg_day"   value="">
<input type="hidden" name="TCustId"  value="">
<input type="hidden" name="unit_name"  value="">
<input type="hidden" name="login_accept"  value="0"> <!-- ������ˮ�� -->
<input type="hidden" name="op_code"  value="3519">
<input type="hidden" name="OrgCode"  value="<%=org_code%>">
<input type="hidden" name="region_code"  value="<%=regionCode%>">
<input type="hidden" name="district_code"  value="<%=districtCode%>">
<input type="hidden" name="WorkNo"   value="<%=workno%>">
<input type="hidden" name="NoPass"   value="<%=nopass%>">
<input type="hidden" name="ip_Addr"  value=<%=ip_Addr%>>
<input type="hidden" name="product_name"  value="">
<input type="hidden" name="product_attr" value="">
<input type="hidden" name="product_prices"  value="">
<input type="hidden" name="product_type"  value="">
<input type="hidden" name="service_code"  value="">
<input type="hidden" name="service_attr"  value="">
<input type="hidden" name="billingtype"  value="">
<input type="hidden" name="opCode" value="<%=opCode%>">
<input type="hidden" name="opName" value="<%=opName%>">

<TABLE cellSpacing=0>
    <TR>
        <TD class=blue>
            <div align="left">֤������</div>
        </TD>
        <TD>
            <input name=iccid id="iccid" size="20" maxlength="18" v_type="string" v_must=1 index="1">
            <input name=custQuery type=button id="custQuery" class="b_text" onMouseUp="getInfo_Cust();" onKeyUp="if(event.keyCode==13)getInfo_Cust();" style="cursor��hand" value=��ѯ>
            <font class="orange">*</font>
        </TD>
        <TD class=blue>���ſͻ�ID</TD>
        <TD>
            <input type="text" name="cust_id" size="20" maxlength="18" v_type="0_9" v_must=1 index="2">
            <font class="orange">*</font>
        </TD>
    </TR>
    <TR>
        <TD class=blue>
            <div align="left">���ű��</div>
        </TD>
        <TD>
            <input name=unit_id id="unit_id" size="20" maxlength="10" v_type="0_9" v_must=1 index="3">
            <font class="orange">*</font>
        </TD>
        <TD class=blue>�����û����</TD>
        <TD>
            <input name="user_no" size="20" v_must=1 v_type=string index="4">
            <font class="orange">*</font>
        </TD>
    </TR>
    <TR>
        <TD class=blue>���ſͻ�����</TD>
        <TD >
            <input class="InputGrey" name="cust_name" size="20" readonly v_must=1 v_type=string index="4">
            <font class="orange">*</font>
        </TD>
        <TD class=blue>���Ų�Ʒ�����ʻ�</TD>
        <TD>
            <input name="account_id" type="test" class="InputGrey" size="20" maxlength="12" readonly v_type="0_9" v_must=1 index="5">
            <font class="orange">*</font>
        </TD>
    </TR>
    <TR>
        <TD class=blue>���Ų�ƷID</TD>
        <TD>
            <input name="grp_id" type="text" class="InputGrey" size="20" maxlength="12" readonly v_type="0_9" v_must=1 index="3">
            <font class="orange">*</font>
        </TD>
        <TD class=blue>�����û�����</TD>
        <TD>
            <input name="grp_name" type="text" class="InputGrey" size="20" maxlength="60" readonly v_must=1 v_maxlength=60 v_type="string" index="4">
            <font class="orange">*</font>
        </TD>
    </TR>
    <TR>
        <TD class=blue>����Ʒ��</TD>
        <TD>
            <input type="hidden" name="sm_code" size="20" readonly v_must=1 v_type="string" index="6"> 
            <input class="InputGrey" type="text" name="sm_name" size="20" readonly v_must=1 v_type="string" index="6"> 
        </TD>
        <TD class=blue>��������Ʒ</TD>
        <TD>
            <input class="InputGrey" type="text" name="product_name2" size="20" readonly v_must=1 v_type="string" index="6"> 
        </TD>
    </TR>
    <TR>
        <TD class=blue>�¼�������Ʒ</TD>
        <TD>
            <input type="text" name="product_code" size="20" readonly onChange="changeProduct()" v_must=1 v_type="string" value="">
            <input name="prodQuery" type="button" id="ProdQuery"  class="b_text" onMouseUp="getInfo_Prod();" onKeyUp="if(event.keyCode==13)getInfo_Prod();" value="ѡ��">
            <font class="orange">*</font>
        </TD>
        <TD class=blue>��Ч��ʽ</TD>
        <TD>
            <input class="InputGrey" type="text" name="send_flag" size="20" readonly >
        </TD>
    </TR>
    <TR>
        <TD class=blue>���Ÿ��Ӳ�Ʒ</TD>
        <TD >
            <input type="text" name="product_append" size="20" readonly v_must=0 v_type="string" value="">
            <input name="ProdAppendQuery" type="button" id="ProdAppendQuery"  class="b_text" onMouseUp="getInfo_ProdAppend();" onKeyUp="if(event.keyCode==13)getInfo_ProdAppend();" value="ѡ��">
        </TD>
        <TD class=blue>���ſͻ�����</TD>
        <TD >
            <jsp:include page="/npage/common/pwd_1.jsp">
                <jsp:param name="width1" value="16%"  />
                <jsp:param name="width2" value="34%"  />
                <jsp:param name="pname" value="custPwd"  />
                <jsp:param name="pwd" value=""  />
            </jsp:include>
            <input name=chkPass type=button onClick="check_HidPwd();" class="b_text" style="cursor��hand" id="chkPass2" value=У��>
            <font class="orange">*</font>
        </TD>
    </TR>
    
    <TR id="tr_gongnengfee"  name="tr_gongnengfee" style="display:none">
        <TD class=blue>���ܷѸ��ѷ�ʽ</TD>
        <TD colspan=3>
            <select name="gongnengfee" id="gongnengfee" >
                <option value="0"> 0-���Ÿ��� </option>
                <option value="1"> 1-���˸��� </option>
            </select>
            <font class="orange">*</font>
        </TD>
    </TR>
    
    <TR>
        <TD class=blue>��ע</TD>
        <TD colspan="3">
            <input class="InputGrey" name="sysnote" size="60" readonly>
        </TD>
    </TR>
    <TR style="display:none">
        <TD>�û���ע</TD>
        <TD colspan="3">
            <input name="tonote" size="60">
        </TD>
    </TR>
    <TR id="footer">
        <TD colspan="4">
            <input class="b_foot" name="sure"  type=button value="ȷ��"  onclick="refMain()" disabled>
            <input class="b_foot" name="reset1"  onClick="" type=reset value="���" >
            <input class="b_foot" name="kkkk"  onClick="removeCurrentTab()" type=button value="�ر�">
        </TD>
    </TR>
</TABLE>
<%@ include file="/npage/include/footer.jsp" %>
</FORM>
<script language="JavaScript">
    document.frm.iccid.focus();
</script>
</BODY>
</HTML>

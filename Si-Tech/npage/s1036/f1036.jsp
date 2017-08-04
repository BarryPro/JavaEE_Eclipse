<%
/********************
 * version v2.0
 * ������: si-tech
 * update by wangzn @ 2010-7-8 08:58:35
 ********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%
    String opCode = "1036";
    String opName = "���Ų�Ʒ������ǩ";
    
    String workname = (String)session.getAttribute("workName");
    String regionCode = (String)session.getAttribute("regCode");
    String powerRight= (String)session.getAttribute("powerRight");
    String orgCode = (String)session.getAttribute("orgCode");
    
    String sqlStr = "";
    String[] inParams = new String[2];
    
    String[][] result = new String[][]{};
%>
<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="region" routerValue="<%=regionCode%>"  id="loginAccept"/>
<html xmlns="http://www.w3.org/1999/xhtml">
<HEAD>
<TITLE>���Ų�Ʒ������ǩ</TITLE>
</HEAD>
<SCRIPT type="text/javascript">
	$(document).ready(function(){
		
		document.frm.sure.disabled = true;
	});
	
	function getInfo_Cust()
{
    var pageTitle = "���ſͻ�ѡ��";
    var fieldName = "֤������|�ͻ�ID|�ͻ�����|�û�ID|�û���� |�û�����|��Ʒ����|��Ʒ����|���ű��|�����ʻ�|Ʒ������|Ʒ�ƴ���|";
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
	
    var path = "<%=request.getContextPath()%>/npage/s1036/f1036_sel.jsp";
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
    document.frm.grpIdNo.value = document.frm.grp_id.value;
    document.frm.grpOutNo.value = document.frm.user_no.value;
    $("#iccid,#cust_id,#unit_id,#user_no").attr("readOnly",true);
    $("#iccid,#cust_id,#unit_id,#user_no").addClass("InputGrey");
    displayInfo();					//������ʾ
    if($("#sm_code").val() == 'va'){
        QryOldRate();
    }else{
        QryOldAppend();
    }
}	

function QryOldAppend(){
    var vGrpId = $("#grp_id").val();
    var QryOldAppendPacket = new AJAXPacket("../s3692/getOldAppend.jsp","���ڵõ���ǰ���Ÿ��Ӳ�Ʒ��Ϣ�����Ժ�......");
	QryOldAppendPacket.data.add("retType","getOldAppend");
	QryOldAppendPacket.data.add("grpId",vGrpId);
	core.ajax.sendPacket(QryOldAppendPacket);
	QryOldAppendPacket=null;
}
function displayInfo()
{
	
	var sm_code=document.frm.sm_code.value;
	if (sm_code!="va")					//va��BOSS��VPMN; CR�ǲ���ҵ�� 
	{	
		document.all.grpA.style.display="";
		document.all.grpB.style.display="";
		document.all.grpC.style.display="";
		document.all.grpD.style.display="";
		document.all.grpE.style.display="";
	}else 
	 {
	 	document.all.grpUser.style.display="";
		document.all.grpF.style.display="";
		document.all.grpG.style.display="";
		document.all.grpA.style.display="none";
		document.all.grpB.style.display="none";
		document.all.grpC.style.display="none";
		document.all.grpD.style.display="none";
		document.all.grpE.style.display="none";
	 }
}
//У��ͻ�����
function check_HidPwd()
{
  
	  //if(document.frm.product_code.value == document.frm.product_code2.value)
    //{
    //    rdShowMessageDialog("���Ǿɵļ�������Ʒ��������ѡ���¼�������Ʒ��",0);
    //    document.frm.product_code.focus();
    //    return false;
    //}
    
    var cust_id = document.all.cust_id.value;
    var Pwd1 = document.all.custPwd.value;
    var checkPwd_Packet = new AJAXPacket("../s3692/pubCheckPwd.jsp","���ڽ�������У�飬���Ժ�......");
    checkPwd_Packet.data.add("retType","checkPwd");
	checkPwd_Packet.data.add("cust_id",cust_id);
	checkPwd_Packet.data.add("Pwd1",Pwd1);
	core.ajax.sendPacket(checkPwd_Packet);
	checkPwd_Packet = null;		
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
                document.frm.sysnote.value = "BOSS���Ų�Ʒ������ǩ";
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
    			
    		}
    		
    	}
    	else
    	{
    		rdShowMessageDialog(retMessage);
    	}
    }
    
    if(retType == "getOldRate")
	{
		if(retCode == "000000")
		{
			document.frm.oldMainRate.value = packet.data.findValueByName("oldMainRate");
			document.frm.oldMainRateName.value=packet.data.findValueByName("oldMainRateName");
			var ss = packet.data.findValueByName("oldOptionalRate");
			var i= 0, len=ss.length;
			for (i = 0; i < len; i ++)
			{
				if (ss.charAt(i) == "|")
				{
					document.frm.oldOptionalRate.value = document.frm.oldOptionalRate.value + "\n";
				}
				else
				{
					document.frm.oldOptionalRate.value = document.frm.oldOptionalRate.value + ss.charAt(i);
				}
			}
		}
		else
		{
			document.frm.oldMainRate.value = "";
			document.frm.oldOptionalRate.value = "";
			rdShowMessageDialog(retMessage,0);
			return false;
		}
	}
	
	if(retType == "getOldAppend"){
		if(retCode == "000000"){
			var vOldAppend = packet.data.findValueByName("oldAppend");
			vOldAppend = vOldAppend.replace(/@/g, "\n"); //add by qidp @ 2009-12-10 for replace all '@' to '\n'
			$("#old_append_product").val(vOldAppend);
		}else{
			rdShowMessageDialog(retMessage,0);
			return false;
		}
	}
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

    if(PubSimpSel(pageTitle,fieldName,sqlStr,selType,retQuence,retToField));
}
function PubSimpSel(pageTitle,fieldName,sqlStr,selType,retQuence,retToField)
{
    var path = "<%=request.getContextPath()%>/npage/s3692/fpubprod_sel.jsp";
    path = path + "?sqlStr=" + sqlStr + "&retQuence=" + retQuence;
    path = path + "&fieldName=" + fieldName + "&pageTitle=" + pageTitle;
    path = path + "&selType=" + selType;
	path = path + "&op_code=" + document.all.op_code.value;
	path = path + "&sm_code=" + document.all.sm_code.value; 
	path = path + "&oldMainProduct=" + document.all.product_code2.value;
    path = path + "&product_attr=" + document.all.product_attr.value;
    path = path + "&grpId=" + $("#grp_id").val();

    retInfo = window.open(path,"newwindow","height=450, width=800,top=50,left=200,scrollbars=yes, resizable=no,location=no, status=yes");
	
	return true;
}	
function getvalue(retInfo, retInfoDetail)
{
  	var retToField = "product_code|product_name|send_flag|";
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
  	document.frm.product_prices.value = retInfoDetail;
  	
  	/*luxc add*/
  	if(getBillingType($("#product_code").val()));
  
}

function getBillingType(product_code)
{
	if((product_code).trim() == "")
    {
       	rdShowMessageDialog("ѡ���Ų�Ʒʧ��24!",0);
        return false;
    }

    var getBillingType_Packet = new AJAXPacket("../s3692/fgetBillingType.jsp","���ڻ�ȡbillingtype�����Ժ�......");
	getBillingType_Packet.data.add("retType","getBillingType");
    getBillingType_Packet.data.add("product_code",product_code);
	core.ajax.sendPacket(getBillingType_Packet);
	getBillingType_Packet = null;
	
}

function refMain(){
	getAfterPrompt();
    var checkFlag; //ע��javascript��JSP�ж���ı���Ҳ������ͬ,���������ҳ����.
    //˵�������ֳ�����,һ���������Ƿ��ǿ�,��һ���������Ƿ�Ϸ�.
   var sm_code=document.frm.sm_code.value;
    if(sm_code!="va"){
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
      //if(document.frm.product_code.value == document.frm.product_code2.value)
	    //{
	    //    rdShowMessageDialog("���Ǿɵļ�������Ʒ��������ѡ���¼�������Ʒ��",0);
	    //    document.frm.product_code.focus();
	    //    return false;
	    //}
	 }else{
		if(  document.frm.grpIdNo.value == "" )
		{
			rdShowMessageDialog("�����û�ID����Ϊ��!!");
			document.frm.idIccid.select();
			return false;
		}
		
		if (document.frm.oldMainRate.value == "")
		{
			rdShowMessageDialog("ԭ���������ʲ���Ϊ�գ����Ȳ�ѯ����������!");
			document.frm.bQryOldRate.focus();
			return false;
		}
	
		if (document.frm.newRate.value=="")
		{
			rdShowMessageDialog("�·��ʲ���Ϊ��!");
			document.frm.newRate.focus();
			return false;
		}
	}
		showPrtDlg("Detail","ȷʵҪ��ӡ���������","Yes");
		if (rdShowConfirmDialog("�Ƿ��ύȷ�ϲ�����")==1){
			page = "f1036_cfm.jsp";
			$("#sure").attr("disabled",true);
			frm.action=page;
			frm.method="post";
			frm.submit();
			loading();
		}  
}
function showPrtDlg(printType,DlgMessage,submitCfm)
{  //��ʾ��ӡ�Ի���
   var h=180;
   var w=350;
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
    	retInfo+="ҵ�����ͣ�"+document.frm.sm_name.value+"BOSS���Ų�Ʒ������ǩ"+"|";
    	retInfo+="��ˮ��"+document.frm.loginAccept.value+"|";
    	retInfo+="ԭ��Ʒ��"+document.frm.product_name2.value+"|";
    	retInfo+="��ǩ��Ʒ��"+document.frm.product_code.value.replace(/\|/g,",")+"|";
    	retInfo+="���Ӳ�Ʒ��"+document.frm.product_append.value.replace(/\|/g,",")+"|";
    	retInfo+=""+"|";
    	retInfo+=""+"|";
    	retInfo+=""+"|";
    	retInfo+=""+"|";
    	retInfo+=document.all.opNote.value+" "+document.all.simBell.value+"|";
		 return retInfo;
}
function setShouldPay(shouldPay){
	
}
</script>
<BODY>
<FORM action="" method="post" name="frm" >
	<input type="hidden" name="product_code2" value="">
	<input type="hidden" name="op_code"  value="1036">
	<input type="hidden" name="product_attr" value="">
	<input type="hidden" name="product_prices"  value="">
	<input type="hidden" name="product_type"  value="">
	<input type="hidden" name="service_code"  value="">
	<input type="hidden" name="service_attr"  value="">
	<input type="hidden" name="billingtype"  value="">
	<input type="hidden" name="opNote" value="���Ų�Ʒ������ǩ">
	<input type="hidden" name="loginAccept" value="<%=loginAccept%>">
	<input type="hidden" name="simBell" value="">
	<%@ include file="/npage/include/header.jsp" %>
<div class="title">
	<div id="title_zi"><%=opName%></div>
</div>
<table cellspacing="0">
	<TR>
        <TD class="blue">֤������ </TD>
        <TD>
            <input name=iccid id="iccid" size="20" maxlength="18" v_type="string" v_must=1 index="1">
            <input name=custQuery type=button id="custQuery" class="b_text" onMouseUp="getInfo_Cust();" onKeyUp="if(event.keyCode==13)getInfo_Cust();" style="cursor:hand" value=��ѯ>
            <font class="orange">*</font>
        </TD>
        <TD class="blue">���ſͻ�ID </TD>
        <TD>
            <input type="text" name="cust_id" id="cust_id" size="20" maxlength="18" v_type="0_9" v_must=1 index="2">
            <font class="orange">*</font>
        </TD>
    </TR>
    <TR>
        <TD class="blue">���ű��</TD>
        <TD>
            <input name="unit_id" id="unit_id" size="20" maxlength="10" v_type="0_9" v_must=1 index="3">
            <font class="orange">*</font>
        </TD>
        <TD class=blue>���ſͻ����� </TD>
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

    <TR style="display:none" id="grpA">
        <TD class="blue">���ſͻ����� </TD>
        <TD >
            <input class="InputGrey" name="cust_name" size="30" readonly v_must=1 v_type=string index="4">
            <font class="orange">*</font>
        </TD>
        <TD class="blue">���Ų�ƷID </TD>
        <TD>
            <input name="grp_id" id="grp_id" type="text" class="InputGrey" size="20" maxlength="12" readonly v_type="0_9" v_must=1 index="3">
            <font class="orange">*</font>
        </TD>
    </TR>
    <TR style="display:none" id="grpB">
        <TD class="blue">�����û���� </TD>
        <TD>
            <input name="user_no" id="user_no" size="20" v_must=1 v_type=string index="4" readonly>
            <font class="orange">*</font>
        </TD>
        <TD class="blue">�����û����� </TD>
        <TD>
            <input name="grp_name" type="text" class="InputGrey" size="30" maxlength="60" readonly v_must=1 v_maxlength=60 v_type="string" index="4">
            <font class="orange">*</font>
        </TD>
    </TR>
    <TR style="display:none" id="grpC">
    	<TD class="blue">���Ÿ����ʻ� </TD>
        <TD>
            <input name="account_id" type="test" class="InputGrey" size="20" maxlength="12" readonly v_type="0_9" v_must=1 index="5">
            <font class="orange">*</font>
        </TD>
        <TD class="blue">����Ʒ�� </TD>
        <TD>
            <input type="hidden" name="sm_code" id="sm_code" size="20" readonly v_must=1 v_type="string" index="6"> 
            <input class="InputGrey" type="text" name="sm_name" size="20" readonly v_must=1 v_type="string" index="6"> 
        </TD>
        
    </TR>
    <TR style="display:none" id="grpD">
    	<TD class="blue">��ǰ��������Ʒ </TD>
        <TD>
            <input class="InputGrey" type="text" name="product_name2" size="20" readonly v_must=1 v_type="string" index="6"> 
        </TD>
        <TD class="blue">��ǰ���Ÿ��Ӳ�Ʒ </TD>
        <TD>
            <textarea name="old_append_product" id="old_append_product" rows="5" cols="40" value="" readonly></textarea>
        </TD>
    </TR>
    <tr style="display:none;">
        <TD class="blue">��Ч��ʽ </TD>
        <TD colspan='3'>
            <input class="InputGrey" type="text" name="send_flag" size="20" readonly >
        </TD>
    </tr>
    <TR style="display:none" id="grpE">
    	<TD class="blue" nowrap>�¼�������Ʒ </TD>
        <TD>
            <input type="text" name="product_name" size="20" readonly v_must=1 v_type="string" value="">
            <input type="hidden" name="product_code" id="product_code" size="20" readonly v_must=1 v_type="string" value="" >
            <input name="prodQuery" type="button" id="ProdQuery"  class="b_text" onMouseUp="getInfo_Prod();" onKeyUp="if(event.keyCode==13)getInfo_Prod();" value="ѡ��">
            <font class="orange">*</font>
        </TD>
        <TD class="blue" nowrap>�¼��Ÿ��Ӳ�Ʒ </TD>
        <TD>
            <input type="text" name="product_append" id="product_append" size="20" readonly v_must=0 v_type="string" value="">
            <input name="ProdAppendQuery" type="button" id="ProdAppendQuery" disabled class="b_text" onMouseUp="getInfo_ProdAppend();" onKeyUp="if(event.keyCode==13)getInfo_ProdAppend();" value="ѡ��">
        </TD>
    </tr>
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
    
    <tr style="display:none" id="grpUser">
    	<TD class="blue">�����û�ID</TD>
		<TD>
			<input class="InputGrey" name="grpIdNo" size="20" readonly v_must=1 v_type=string  index="4" value="">
			<font color="orange">*</font>
		</TD>
		<TD class="blue">�����û����</TD>
		<TD>
			<input class="button" name="grpOutNo" size="20" v_must=1 v_type=string  index="4" value="">
			<font color="orange">*</font>
		</TD>
	</tr>	
    <TR style="display:none" id="grpF">
		<TD class="blue" nowrap>ԭ����������</TD>
		<TD nowrap>
		    <input name="oldMainRateName" class="InputGrey" type="text" size="35" v_must=1 v_type="string" index="8" value="" readonly>
			<input name="oldMainRate" class="InputGrey" type="hidden" size="35" v_must=1 v_type="string" index="8" value="" readonly>
			<input name=bQryOldRate type=button id="bQryOldRate" class="b_text" onMouseUp="QryOldRate();" onKeyUp="if(event.keyCode==13)QryOldRate();" style="cursor��hand;display:none;" value=��ѯ>
			<font color="orange">*</font>
		</TD>
		<TD class="blue" nowrap>ԭ���ſ�ѡ����</TD>
		<TD nowrap>
			<textarea name="oldOptionalRate" class="button" v_must=0 rows="5" cols="40" v_type="string"  index="8" value="" readonly></textarea>
			<font color="orange">*</font>
		</TD>
	</TR>
	<TR style="display:none" id="grpG">
		<TD class="blue">����������</TD>
		<TD>
			<select name="newRate" id="newRate" v_must=1 v_type="string" index="10">
<%
					try
					{
						sqlStr = "select a.offer_id,a.offer_id || '->' || a.offer_name"
						        +"  from product_offer a,region b ,sregioncode c "
								+"  where c.region_code = substr(:orgCode,1,2) "
								+"   and a.offer_id = b.offer_id"
								+"   and b.group_id = c.group_id"
								+"   and a.offer_attr_type ='VpM0'"
								+" and a.exp_date>=sysdate and b.right_limit<="+powerRight+"";
						
						
						inParams[0] = "select a.offer_id,a.offer_id || '->' || a.offer_name"
						        +"  from product_offer a,region b ,sregioncode c "
								+"  where c.region_code ='"+regionCode+"' "
								+"   and a.offer_id = b.offer_id"
								+"   and b.group_id = c.group_id"
								+"   and a.offer_attr_type ='VpM0'"
								+" and a.exp_date>=sysdate and b.right_limit<="+powerRight;
						
						inParams[1] = "regionCode="+regionCode+",powerRight="+powerRight;
%>
						<wtc:pubselect name="sPubSelect" retcode="retCode" retmsg="retMsg" outnum="2" routerKey="region" routerValue="<%=regionCode%>">
                        	<wtc:sql><%=inParams[0]%></wtc:sql>
                        </wtc:pubselect>
						<wtc:array id="resultTemp1"  scope="end"/>
<%		                
			            result = resultTemp1;
					}
					catch(Exception e){
						System.out.println("ȡ������������Ϣ����!");
					}
					if (result.length>0)
					{
						System.out.println("result.length"+result.length);
						for(int i=0; i < result.length; i ++)
						{
							out.println("<option value='" + result[i][0] + "'>" + result[i][1] + "</option>");
						}
					}
%>
					</select>
					<font color="orange">*</font>
				</TD>
				<TD class="blue">���ſ�ѡ����</TD>
				<TD>
					<select name="optionalRate" id="optionalRate" size="5" MULTIPLE="TRUE" v_must=0 v_type="string" index="10">
<%
					try
					{
					   sqlStr = "select a.offer_id,a.offer_id || '->' || a.offer_name"
						        +"  from product_offer a,region b ,sregioncode c "
								+"  where c.region_code = substr(:orgCode,1,2) "
								+"   and a.offer_id = b.offer_id"
								+"   and b.group_id = c.group_id"
								+"   and a.offer_attr_type ='VpA0'"
								+" and a.exp_date>=sysdate and b.right_limit<="+powerRight+"";
						
						
						inParams[0] = "select a.offer_id,a.offer_id || '->' || a.offer_name"
						        +"  from product_offer a,region b ,sregioncode c "
								+"  where c.region_code ='"+regionCode+"' "
								+"   and a.offer_id = b.offer_id"
								+"   and b.group_id = c.group_id"
								+"   and a.offer_attr_type ='VpA0'"
								+" and a.exp_date>=sysdate and b.right_limit<="+powerRight;
						
						inParams[1] = "regionCode="+regionCode+",powerRight="+powerRight;
%>
						<wtc:pubselect name="sPubSelect" retcode="retCode" retmsg="retMsg" outnum="2" routerKey="region" routerValue="<%=regionCode%>">
                        	<wtc:sql><%=inParams[0]%></wtc:sql>
                        </wtc:pubselect>
						<wtc:array id="resultTemp2"  scope="end"/>
<%		                
			            result = resultTemp2;
					}
					catch(Exception e){
						System.out.println("ȡ���ſ�ѡ������Ϣ����!");
					}
					if (result.length>0)
					{
						System.out.println("result.length"+result.length);
						for(int i=0; i < result.length; i ++)
						{
							out.println("<option value='" + result[i][0] + "'>" + result[i][1] + "</option>");
						}
					}
%>
					</select>
				</TD>
			</tr>
			
    <TR>
        <TD class=blue>��ע</TD>
        <TD colspan="3">
            <input class="InputGrey" name="sysnote" size="60" readonly>
        </TD>
    </TR>
    <TR id="footer">
        <TD colspan="4">
            <input class="b_foot" name="sure"  id="sure"  type=button value="ȷ��"  onclick="refMain()" >
            <input class="b_foot" name="reset1"  onClick="window.location='f3692_1.jsp'" type=button value="���" >
            <input class="b_foot" name="close"  onClick="removeCurrentTab();" type=button value="�ر�">
        </TD>
    </TR>
</table>
	<%@ include file="/npage/include/footer.jsp" %>
</form>	
<script type="text/javascript">
    document.frm.iccid.focus();
</script>
</BODY>
</HTML>

<%
/********************
 * version v2.0
 * ������: si-tech
 * update by leimd @ 2009-04-13
 ********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%
    String opCode = "3692";
    String opName = "���Ų�Ʒ�ʷѱ��";
		
		System.out.println("gaopengSeeLog===3692===init");
    String workname = (String)session.getAttribute("workName");
    String regionCode = (String)session.getAttribute("regCode");
    String powerRight= (String)session.getAttribute("powerRight");
    String orgCode = (String)session.getAttribute("orgCode");
    String sqlStr = "";
	String[] inParams = new String[2];
    String[][] result = new String[][]{};
    String sm_code ="" ;
    
    String dateStr22 = new java.text.SimpleDateFormat("yyyyMMdd").format(new java.util.Date());
    
    String[][] favInfo = (String[][])session.getAttribute("favInfo");
    int infoLen = favInfo.length;
    boolean pwrf = false;
    String tempStr = "";
    for(int ll=0;ll<infoLen;ll++){
        tempStr = (favInfo[ll][0]).trim();
        if(tempStr.compareTo("a317") == 0){
            pwrf = true;
        }
    }
    
    
    String workNo          = (String)session.getAttribute("workNo");
    String in_GrpId        = WtcUtil.repNull(request.getParameter("in_GrpId"));
    String in_ChanceId     = WtcUtil.repNull(request.getParameter("in_ChanceId"));
    String IdNo            = WtcUtil.repNull(request.getParameter("IdNo"));
    String wa_no1          = WtcUtil.repNull(request.getParameter("wa_no1"));
    String crmActiveOpCode = WtcUtil.repNull(request.getParameter("crmActiveOpCode"));
    
    
String retValue = "";//
String retValue_getvalue = "";//
String retValue_yj = "";
String busiflags="";
String duanxintimes="";
String duanxinneirongs="";
//F10964=���ԭ��
//F10965=��ز�Ʒ�˺�
String QryServMC_F10964 = "";
String QryServMC_F10965 = "";

if(in_ChanceId != null&&!"".equals(in_ChanceId)){//������������ʱ���̻����벻Ϊ�ա�
%>
  <wtc:service name="QryServMC" outnum="28" retmsg="msg1" retcode="code1" routerKey="region" routerValue="<%=regionCode%>">
		<wtc:param value="<%=in_GrpId%>" />
		<wtc:param value="<%=in_ChanceId%>" />	
		<wtc:param value="2" />	
		<wtc:param value="<%=IdNo%>" />	
		<wtc:param value="" />	
	</wtc:service>
	<wtc:array id="result_QryServMC1" scope="end" start="0"  length="6"  />
	<wtc:array id="result_QryServMC" scope="end" start="6"  length="22" />
		
<%			


	
String QryServMC_20_userNo = "";
	
if("000000".equals(code1)){
	if(result_QryServMC.length>0){
		QryServMC_20_userNo = result_QryServMC[0][14];
		retValue_getvalue = result_QryServMC[0][10]+"|";
		retValue_yj = result_QryServMC[0][15];
		busiflags  = result_QryServMC[0][16];
		duanxintimes  = result_QryServMC[0][18];
		duanxinneirongs  = result_QryServMC[0][19];
		
		QryServMC_F10964 = result_QryServMC[0][20];
		QryServMC_F10965 = result_QryServMC[0][21];
	}
	
	System.out.println("hejwa-------------------QryServMC_F10964-------------------------->"+QryServMC_F10964);
	System.out.println("hejwa-------------------QryServMC_F10965-------------------------->"+QryServMC_F10965);
%>
  <wtc:service name="s3096QryCheckE" outnum="19" retmsg="msg2" retcode="code2" routerKey="region" routerValue="<%=regionCode%>">
		<wtc:param value="<%=workNo%>" />
		<wtc:param value="<%=in_GrpId%>" />	
		<wtc:param value="u03" />	
		<wtc:param value="<%=in_ChanceId%>" />	
		<wtc:param value="" />	
		<wtc:param value="" />	
		<wtc:param value="<%=QryServMC_20_userNo%>" />			
	</wtc:service>
	<wtc:array id="result_s3096QryCheckE" scope="end"  /> 
<%


	
	 for(int i=0;i<12;i++){
	 	retValue = retValue+result_s3096QryCheckE[0][i]+"|";
	 }
	
}

}


//retValue = 33262|����ר��5000Ԫ����|������Ч|
//document.all.retValue.value = 33262,MZ38,5000,0000,1,0,0.5,|
//vShouldPay = -1


%>
<!--ȡ��ˮ-->
	<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="region" routerValue="<%=regionCode%>"  id="loginAccept"/>
<html xmlns="http://www.w3.org/1999/xhtml">
<HEAD>
<TITLE>���Ų�Ʒ�ʷѱ�� </TITLE>
</HEAD>
<SCRIPT type="text/javascript">
onload = function()
{
	//document.all.grpA.style.display = "none";
     if("<%=pwrf%>" == "true"){
        $("#ProdAppendQuery").attr("disabled",false);
    }
    
    if("<%=retValue%>"!=""){
    	
    	getvaluecust("<%=retValue%>");
    	
    	$("input[name='prodQuery']").hide();
    	
    	getvalue("<%=retValue_getvalue%>", "<%=retValue_yj%>");
    	setShouldPay("-1");
    	
    }
    
    
    $("#busi_flag").val("<%=busiflags%>");
    $("#messhotxftime").val("<%=duanxintimes%>");
    $("#messshotinfos").val("<%=duanxinneirongs%>");
    
	  var busi_flagss = $("#busi_flag").val();
	  if(busi_flagss=="118" || busi_flagss=="227" || busi_flagss=="119" || busi_flagss=="121" || busi_flagss=="120" || busi_flagss=="211") {
			$("#dxxiangguan").show();	
	  }else {
	  	$("#dxxiangguan").hide();
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
    	retInfo+="ҵ�����ͣ�"+document.frm.sm_name.value+"BOSS���Ų�Ʒ�ʷѱ��"+"|";
    	retInfo+="��ˮ��"+document.frm.loginAccept.value+"|";
    	retInfo+="���ǰ��Ʒ��"+document.frm.product_name2.value+"|";
    	retInfo+="������Ʒ��"+document.frm.product_code.value.replace(/\|/g,",")+"|";
    	retInfo+="���Ӳ�Ʒ��"+document.frm.product_append.value.replace(/\|/g,",")+"|";
    	retInfo+=""+"|";
    	retInfo+=""+"|";
    	retInfo+=""+"|";
    	retInfo+=""+"|";
    	retInfo+=document.all.opNote.value+" "+document.all.simBell.value+"|";
		 return retInfo;
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
                document.frm.sysnote.value = "BOSS���Ų�Ʒ�ʷѱ��";
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
	
//���ù������棬���м��ſͻ�ѡ��
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
	
    var path = "<%=request.getContextPath()%>/npage/s3692/f3692_sel.jsp";
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
    var QryOldAppendPacket = new AJAXPacket("getOldAppend.jsp","���ڵõ��ɼ��Ÿ��Ӳ�Ʒ��Ϣ�����Ժ�......");
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

//���ù������棬���в�Ʒ��Ϣѡ��
function getInfo_Prod()
{
		document.frm.product_append.value="";
    //�����ж��Ƿ��Ѿ�ѡ���˷���Ʒ��
    if(document.frm.sm_code.value == "")
    {
        rdShowMessageDialog("������ѡ������Ϣ����Ʒ��",0);
        return false;
    }
    //�����ж��Ƿ��Ѿ�ѡ���˲�Ʒ����
		var pageTitle = "���Ų�Ʒѡ��";
		var fieldName = "";
		var sqlStr = "";
		var selType = "S";    //'S'��ѡ��'M'��ѡ
		var retQuence = "";
		var retToField = "";
		/* begin update for ����IMS�ں�ͨ��Ӫ���Ż��������ʷ����ú;��ֱ���������ĺ�@2014/8/13 */
		if(document.frm.sm_code.value == "RH"){
			fieldName = "��Ʒ����|��Ʒ����|�Ƿ��������|��Ч��ʽ|";
			retQuence = "4|0|1|2|3|";
			retToField = "product_code|product_name|chg_price|send_flag|";
		}else{
			fieldName = "��Ʒ����|��Ʒ����|�Ƿ��������|��Ч��ʽ|";
			retQuence = "3|0|1|3|";
			retToField = "product_code|product_name|send_flag|";
		}
		/* end update for ����IMS�ں�ͨ��Ӫ���Ż��������ʷ����ú;��ֱ���������ĺ�@2014/8/13 */

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

//���Ÿ��Ӳ�Ʒѡ��
function getInfo_ProdAppend()
{
    var pageTitle = "���Ÿ��Ӳ�Ʒѡ��";
    var fieldName = "��Ʒ����|��Ʒ����|";
	var sqlStr = "";
    var selType = "S";    //'S'��ѡ��'M'��ѡ
    var retQuence = "1|0|";
    var retToField = "product_append|";
    var product_code = document.frm.product_code.value;

    //�����ж��Ƿ��Ѿ�ѡ���˷���Ʒ��
    if(document.frm.sm_code.value == "")
    {
        rdShowMessageDialog("������ѡ������Ϣ����Ʒ��");
        return false;
    }
   
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
    var path = "<%=request.getContextPath()%>/npage/s3692/fpubprodappend_sel.jsp";
    path = path + "?sqlStr=" + sqlStr + "&retQuence=" + retQuence;
    path = path + "&fieldName=" + fieldName + "&pageTitle=" + pageTitle;
    path = path + "&selType=" + selType;
    path = path + "&showType=" + "Default";
	path = path + "&op_code=" + document.all.op_code.value;
	path = path + "&sm_code=" + document.all.sm_code.value; 
	path = path + "&product_code=" + product_code; 
	path = path + "&oldMainProduct=" + document.all.product_code2.value;
	path = path + "&grpId=" + $("#grp_id").val();

    retInfo = window.open(path,"newwindow","height=450, width=800,top=50,left=200,scrollbars=yes, resizable=no,location=no, status=yes");

	return true;
}

function getvalue(retInfo, retInfoDetail)
{
		var retToField = "";
		/* begin update for ����IMS�ں�ͨ��Ӫ���Ż��������ʷ����ú;��ֱ���������ĺ�@2014/8/13 */
		if(document.frm.sm_code.value == "RH"){
			retToField = "product_code|product_name|chg_price|send_flag|";
		}else{
			retToField = "product_code|product_name|send_flag|";
		}
		/* end update for ����IMS�ں�ͨ��Ӫ���Ż��������ʷ����ú;��ֱ���������ĺ�@2014/8/13 */
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

    var getBillingType_Packet = new AJAXPacket("fgetBillingType.jsp","���ڻ�ȡbillingtype�����Ժ�......");
	getBillingType_Packet.data.add("retType","getBillingType");
    getBillingType_Packet.data.add("product_code",product_code);
	core.ajax.sendPacket(getBillingType_Packet);
	getBillingType_Packet = null;
	
}

function getvalueProdAppend(retInfo)
{
    $("#product_append").val(retInfo);
}

//У��ͻ�����
function check_HidPwd()
{
    	var old_append_product = $.trim($("#old_append_product").val());
    	var product_append = $.trim($("#product_append").val());
    	if(document.frm.product_code.value == document.frm.product_code2.value && ((product_append.length != 0 && old_append_product.indexOf(product_append) != -1)||(product_append.length == 0 && old_append_product.length ==0)) ){
    		rdShowMessageDialog("�¼��Ÿ��Ӳ�Ʒ�;ɼ��Ÿ��Ӳ�Ʒ���ɼ�������Ʒ���¼�������Ʒ������ȫ��ͬ",0);
    		return false;
    	}
        /*rdShowMessageDialog("���Ǿɵļ�������Ʒ��������ѡ���¼�������Ʒ��",0);
        document.frm.product_code.focus();
        return false;*/
    
    
    var cust_id = document.all.cust_id.value;
    var Pwd1 = document.all.custPwd.value;
    var checkPwd_Packet = new AJAXPacket("../s3692/pubCheckPwd.jsp","���ڽ�������У�飬���Ժ�......");
    checkPwd_Packet.data.add("retType","checkPwd");
	checkPwd_Packet.data.add("cust_id",cust_id);
	checkPwd_Packet.data.add("Pwd1",Pwd1);
	core.ajax.sendPacket(checkPwd_Packet);
	checkPwd_Packet = null;		
}

function QryOldRate()
{
	document.all.oldOptionalRate.value="";
	var QryOldRate_Packet = new AJAXPacket("getOldRate.jsp","���ڵõ�ԭ������������Ϣ�����Ժ�......");
	QryOldRate_Packet.data.add("retType","getOldRate");
	QryOldRate_Packet.data.add("grpIdNo",document.frm.grpIdNo.value);
	QryOldRate_Packet.data.add("regionCode","<%=regionCode%>");
	core.ajax.sendPacket(QryOldRate_Packet);
	QryOldRate_Packet=null;
}


function refMain(){
	
				if($("#F10964").val()=="3"||$("#F10964").val()=="4"){
						if($("#F10965").val()==""){
							rdShowMessageDialog("��������ز�Ʒ�˺�");
							return;
						}
				}
		
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
      var old_append_product = $.trim($("#old_append_product").val());
    	var product_append = $.trim($("#product_append").val());
    	if(document.frm.product_code.value == document.frm.product_code2.value && ((product_append.length != 0 && old_append_product.indexOf(product_append) != -1)||(product_append.length == 0 && old_append_product.length ==0)) ){
    		rdShowMessageDialog("�¼��Ÿ��Ӳ�Ʒ�;ɼ��Ÿ��Ӳ�Ʒ���ɼ�������Ʒ���¼�������Ʒ������ȫ��ͬ",0);
    		return false;
    	}
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
	
		//hejwa add �����ϱ����ſͻ���2014��2�µ�һ��ϵͳ����ĺ�-1-�Ż�����ר�߶˵�����Ϣ֧��ϵͳ���ֹ���  2014��3��12��15:22:27
		//�����ʾ�鷳���ñ����ķ�ʽ������ʾ��
		var hitMessage = "";
		if($("#sm_code").val()=="hl"){
			hitMessage = "��ȷ��ѡ����ʷ�Ϊ�����ʷѷ���Ŀ�ʷѣ�";
		}else{
			hitMessage = "�Ƿ��ύȷ�ϲ�����";
		}
		

  var busi_flagss = $("#busi_flag").val();
	  if(busi_flagss=="118" || busi_flagss=="227" || busi_flagss=="119" || busi_flagss=="121" || busi_flagss=="120" || busi_flagss=="211") {
	 		 	
	 	if(!checkElement(document.all.messhotxftime)){
				return false;
		}
		
		var timess =$("#messhotxftime").val();
		var messshotinfossss =$("#messshotinfos").val();
	 	var jintiantimess="<%=dateStr22%>";
		
		if(timess!="") {
		 	if (timess <= jintiantimess) {
		 	   rdShowMessageDialog("�����·�ʱ�������ڵ�ǰʱ�䣡");
		 	   return false;
		 	}
	 	}
	
		if(!checkElement(document.all.messshotinfos)){
				return false;
		}
		
		if(messshotinfossss.trim() !="" && timess.trim() =="") {
		 	   rdShowMessageDialog("�������Ѷ�������������������Ѷ���ʱ�䣡");
		 	   return false;		
		}
		
	} 		
		
		
		showPrtDlg("Detail","ȷʵҪ��ӡ���������","Yes");
		if (rdShowConfirmDialog(hitMessage)==1){
			page = "f3692_cfm.jsp";
			$("#sure").attr("disabled",true);
			frm.action=page;
			frm.method="post";
			frm.submit();
			loading();
		}  
}
function setShouldPay(shouldPay){
	if(shouldPay=='-1'){
		$("#shouldPay").val('');
		$("#shouldPayDis").val('');
		$("#should_pay").hide();
	}else{
		$("#shouldPay").val(shouldPay);
		$("#shouldPayDis").val(shouldPay);
		$("#should_pay").show();	
	}
	
}


/**
 * ����2����Ѯ���ſͻ���CRM��BOSS�;���ϵͳ����ĺ�-2-boss������ר��0Ԫ�ʷ�˵����Ϣ������
 * 2016��4��12��9:42:51
 * hejwa ������
 */
$(document).ready(function(){
		<%
			if(in_ChanceId != null&&!"".equals(in_ChanceId)){
		%>
				$("#F10965").val("<%=QryServMC_F10965%>");
    		$("#F10964").val("<%=QryServMC_F10964%>");
			go_check_F10964_F10965();
			$("#F10965").blur(function(){
					if($("#F10964").val()=="3"||$("#F10964").val()=="4"){
						go_check_F10965();
					}
			});
		<%}else{%>
			$("#tr_F10964_F10965").hide();
		<%}%>	
});

function go_check_F10964_F10965(){
	  var packet = new AJAXPacket("/npage/s3690/check_F10964_F10965.jsp","���Ժ�...");
        packet.data.add("sPChanceId","<%=in_ChanceId%>");//
    core.ajax.sendPacket(packet,do_check_F10964_F10965);
    packet =null;	
}
function do_check_F10964_F10965(packet){
    var error_code = packet.data.findValueByName("code");//���ش���
    var error_msg =  packet.data.findValueByName("msg");//������Ϣ

    if(error_code=="000000"){//�����ɹ�
    	var result_count =  packet.data.findValueByName("result_count");
    	if(result_count!="0"){
    		$("#F10964").attr("disabled","disabled");
    		$("#F10965").attr("disabled","disabled");
    	}
    }else{//���÷���ʧ��
	    rdShowMessageDialog(error_code+":"+error_msg);
    }
}

function go_check_F10965(){
	  var packet = new AJAXPacket("/npage/s3690/check_F10965.jsp","���Ժ�...");
        packet.data.add("prod_id",$("#F10965").val());//
        packet.data.add("unit_id","<%=in_GrpId%>");//
        packet.data.add("opCode","<%=opCode%>");//
        packet.data.add("c_prod_id",$("#grp_id").val());//
        
    core.ajax.sendPacket(packet,do_check_F10965);
    packet =null;		
}
function do_check_F10965(packet){
    var error_code = packet.data.findValueByName("code");//���ش���
    var error_msg =  packet.data.findValueByName("msg");//������Ϣ

    if(error_code=="000000"){//�����ɹ�
    	var result_count =  packet.data.findValueByName("result_count");
    	if(result_count=="0"){
    		rdShowMessageDialog("���ԭ��ѡ��������Ϣ����Ŀ���͡���������ҵ��Ӧ�á�ʱ����Ҫ��дͬһ���ű����µ�������Ʒ�˺�");
    		$("#F10965").val("");
    		$("#F10964").val("");
    	}
    }else{//���÷���ʧ��
	    rdShowMessageDialog(error_code+":"+error_msg);
    }
}


</script>
<BODY>
<FORM action="" method="post" name="frm" >
	<input type="hidden" name="product_code2" value="">
	<input type="hidden" name="op_code"  value="3692">
	<input type="hidden" name="product_attr" value="">
	<input type="hidden" name="product_prices"  value="">
	<input type="hidden" name="product_type"  value="">
	<input type="hidden" name="service_code"  value="">
	<input type="hidden" name="service_attr"  value="">
	<input type="hidden" name="billingtype"  value="">
	<input type="hidden" name="opNote" value="���Ų�Ʒ�ʷѱ��">
	<input type="hidden" name="loginAccept" value="<%=loginAccept%>">
	<input type="hidden" name="simBell" value="">
	<input type="hidden" id="shouldPay" name="shouldPay" value="">
<input type='hidden' id='chg_price' name='chg_price' value='' /> <%/* �Ƿ����*/%>
<input type="hidden" name="wa_no1" value="<%=wa_no1%>">
<input type="hidden" value="" name="busi_flag" id="busi_flag" />
<%@ include file="/npage/include/header.jsp" %>
<div class="title">
	<div id="title_zi">���Ų�Ʒ�ʷѱ��</div>
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
    	<TD class="blue">�ɼ�������Ʒ </TD>
        <TD>
            <input class="InputGrey" type="text" name="product_name2" size="20" readonly v_must=1 v_type="string" index="6"> 
        </TD>
        <TD class="blue">�ɼ��Ÿ��Ӳ�Ʒ </TD>
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
            <input type="text" name="product_code" id="product_code" size="20" readonly v_must=1 v_type="string" value="" style="display:none;">
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
	<tr id="should_pay" style='display:none'>	
		<TD class=blue>һ���Է���</TD>	
		<TD colspan="3">
            <input class="InputGrey" id='shouldPayDis' size="60" readonly value=''>
        </TD>
    </tr>
    
    <tr style="display:none" id="dxxiangguan">
    	<TD class="blue">�����·�ʱ��</TD>
			        <td>
					 			
   <input id='messhotxftime' name='messhotxftime' type='text' onKeyPress='return isKeyNumberdot(0)' value='' size='20' maxlength='8' v_must=0 v_type='date' v_format='yyyyMMdd'>&nbsp;��ʽ��YYYYMMDD				 			
					 			
										
			        </td>
		<TD class="blue">���Ѷ�������</TD>
		<TD>
			<input type="text" name="messshotinfos" id="messshotinfos" value="" v_type="string"  maxlength="200" size=60  v_must=0  v_maxlength=200 >
		</TD>
	</tr>   
	
	<tr id="tr_F10964_F10965">
	  <TD class=blue >���ԭ��</TD>
	  <TD  colspan=1> 
		  <select id='F10964' name='F10964' datatype=17  >
			  <option selected value=''>--��ѡ��--</option>
			  <option  value='1'>1--����</option>
			  <option  value='2'>2--������</option>
			  <option  value='3'>3--������Ϣ����Ŀ</option>
			  <option  value='4'>4--��������ҵ��Ӧ��</option>
			  <option  value='5'>5--�����ר��һ���շ�</option>
		  </select>
	  </TD>
	  <TD class=blue >��ز�Ʒ�˺�</TD>
	  <TD  colspan=3> 
	  	<input id='F10965' name='F10965' style='ime-mode:disabled' onKeyPress='return isKeyNumberdot(0)' class='button' type='text' datatype=10 maxlength='20' value=''    >
	  	</td>
	</tr>   
    
        <TD class=blue>��ע</TD>
        <TD colspan="3">
            <input class="InputGrey" name="sysnote" size="60" readonly>
        </TD>
    </TR>
    <TR id="footer">
        <TD colspan="4">
            <input class="b_foot" name="sure"  type=button value="ȷ��"  onclick="refMain()" disabled>
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

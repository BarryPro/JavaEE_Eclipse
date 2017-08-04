<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page contentType="text/html;charset=GBK"%>
<%@ page import="org.apache.log4j.Logger"%>
<%@ include file="../../include/remark.htm" %>
<script language="JavaScript" src="<%=request.getContextPath()%>/npage/s1400/pub.js"></script>

<%
    Logger logger = Logger.getLogger("s3439.jsp");
    String workno = WtcUtil.repNull((String)session.getAttribute("workNo"));
    String workname = WtcUtil.repNull((String)session.getAttribute("workName"));
	String org_code = WtcUtil.repNull((String)session.getAttribute("orgCode"));
	String nopass  = WtcUtil.repNull((String)session.getAttribute("password"));
	String region_code=WtcUtil.repNull((String)session.getAttribute("regCode"));
	String regionCode = region_code;
	String getAcceptFlag = "";
	String printAccept="";
	ArrayList retArray = new ArrayList();
	ArrayList retArray1 = new ArrayList();
	String sqlStr = "";
	String[][] result = new String[][]{};
	String[][] result1 = new String[][]{};
	
	String opCode = "3439";
	String opName = "APN�ն˰󶨺�����ϸ��ѯ";
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<HEAD>
<TITLE>APN�ն˰󶨺�����ϸ��ѯ</TITLE>
</HEAD>
<SCRIPT type=text/javascript>
var i="";
var backArrMsg;
//core.loadUnit("debug");
//core.loadUnit("rpccore");
onload=function(){
    //core.rpc.onreceive = doProcess;
}
function doProcess(packet)
{
    var retType = packet.data.findValueByName("retType");
    var retCode = packet.data.findValueByName("retCode");
	var retMessage = packet.data.findValueByName("retMessage");
    self.status="";
    if(retType == "submit")
    {
	   if(retCode=="0")
        {
            rdShowMessageDialog("ȷ�ϳɹ�,��ˮ["+packet.data.findValueByName("loginAccept")+"]",2);
        }
        else
        {
            retMessage = retMessage + "[errorCode1:" + retCode + "]";
			rdShowMessageDialog(retMessage,0);
			return false;
        }
	}
    if(retType == "s3436Init")
    {
		if(retCode == "0")
        {
			document.frm.custName.value=packet.data.findValueByName("custName");
            document.frm.hidPwd.value=packet.data.findValueByName("user_passwd");
			document.frm.id_iccid.value=packet.data.findValueByName("id_iccid");
			document.frm.custName.value=packet.data.findValueByName("custName");
			document.frm.custAddr.value=packet.data.findValueByName("custAddr");
			document.frm.productCode.value=packet.data.findValueByName("productCode");
			document.frm.productName.value=packet.data.findValueByName("productName");
			document.frm.contractNo.value=packet.data.findValueByName("contractNo");
			document.frm.grpIdNo.value=packet.data.findValueByName("grpIdNo");
			backArrMsg =packet.data.findValueByName("backArrMsg");
			var tmpObj="apnNo";
			document.all(tmpObj).options.length=0;
			document.all(tmpObj).options.length=backArrMsg.length;
			alert(backArrMsg.length)
			for(i=0;i<backArrMsg.length;i++){
				    document.all(tmpObj).options[i].text=backArrMsg[i][0];
				    document.all(tmpObj).options[i].value=backArrMsg[i][0];
			}
		}
        else
        {
            rdShowMessageDialog("û�еõ�������Ϣ,�����»�ȡ��",0);
			frm.TGrpId.focus();
        }
    }
	if(retType == "s3439ApnVer")
    {
		if(retCode == "000000")
        {
			document.frm.billType.value=packet.data.findValueByName("billType");
			if (document.frm.billType.value == "T")
			    document.frm.billName.value = "�ն˼Ʒ�";
			else
			    document.frm.billName.value = "�˿ڼƷ�";
			document.frm.apnId.value=packet.data.findValueByName("apnId");
			document.frm.terminalNum.value=packet.data.findValueByName("terminalNum");
			document.frm.usedNum.value=packet.data.findValueByName("usedNum");
			document.frm.remainNum.value=packet.data.findValueByName("remainNum");
			document.frm.smCode.value=packet.data.findValueByName("smCode");
			document.frm.apnName.value=packet.data.findValueByName("apnName");
		}
        else
        {
            rdShowMessageDialog("û�еõ�APN��Ϣ�������»�ȡ��",0);
			frm.apnNo.focus();
			return false;
        }
        getApnTerm();
    }
	if(retType == "s3436TermVer")
    {
		if(retCode == "0")
        {
			document.frm.terminalId.value=packet.data.findValueByName("terminalId");
			document.frm.terminalName.value=packet.data.findValueByName("terminalName");
			document.frm.terminalType.value=packet.data.findValueByName("terminalType");
			document.frm.roamType.value=packet.data.findValueByName("roamType");
			document.frm.ipAddress.value=packet.data.findValueByName("ipAddress");
			document.frm.internetIp.value=packet.data.findValueByName("internetIp");
			document.frm.terminalIp.value=packet.data.findValueByName("terminalIp");
			document.frm.serviceIp.value=packet.data.findValueByName("serviceIp");
		}
        else
        {
            rdShowMessageDialog("û�еõ��ն˺�����Ϣ�������»�ȡ��",0);
			frm.terminalNo.focus();
        }
    }
	if(retType == "checkPass") //���ſͻ�����У��
     {
        if(retCode == "000000")
        {
            var retResult = packet.data.findValueByName("retResult");
    		frm.checkPwd_Flag.value = retResult;
            if (retResult == "false") {
    	    	rdShowMessageDialog("���벻��!����������!",0);
	        	frm.grouppass.value = "";
	        	frm.grouppass.focus();
    	    	frm.checkPwd_Flag.value = "false";
				document.frm.sure.disabled = false;
    	    	return false;
            } else {
                rdShowMessageDialog("����У��ɹ���",2);
                document.frm.sure.disabled = false;
            }
         }
        else
        {
            rdShowMessageDialog("���벻��!����������!",0);
			document.frm.sure.disabled = false;
    		return false;
        }
     }
}
//��ӡ��Ϣ
	 function printInfo(printType)
	 {
	<%
        //ȡ�ô�ӡ��ˮ
        try
        {
                //sqlStr ="select sMaxSysAccept.nextval from dual";
                //retArray = callView.sPubSelect("1",sqlStr);
                %>
                    <wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="region" routerValue="<%=regionCode%>"  id="seq"/>
                <%
                //result = (String[][])retArray.get(0);
                //printAccept = (result[0][0]).trim();
                printAccept = seq;
        }catch(Exception e){
                out.println("rdShowMessageDialog('ȡϵͳ������ˮʧ�ܣ�',0);");
                getAcceptFlag = "failed";
        }
	%>
        var getAcceptFlag = "<%=getAcceptFlag%>";
		var printAccept="<%=printAccept%>";
		document.all.login_accept.value=printAccept;
        if(getAcceptFlag == "failed")
        {   return "failed";    }
		var retInfo = "";
 		retInfo+='<%=workname%>'+"|";
    	retInfo+='<%=new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss", Locale.getDefault()).format(new java.util.Date())%>'+"|";
    	retInfo+="���ű��:"+document.frm.TGrpId.value+"|";
    	retInfo+="��������:"+document.frm.custName.value+"|";
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
    	retInfo+=""+"|";
    	retInfo+=""+"|";
    	retInfo+=""+"|";
		retInfo+=""+"|";
    	retInfo+=""+"|";
    	retInfo+="ҵ�����ͣ�APN�ն˰󶨺�����ϸ��ѯ"+"|";
    	retInfo+="�ն˺���:"+document.frm.terminalNo.value+"|";
		retInfo+="IP����:"+document.all.IPType.options[document.all.IPType.selectedIndex].text
    	retInfo+="IP��ַ:"+document.frm.ipAddress.value+"|";
    	retInfo+="��ˮ:"+document.all.login_accept.value+"|";
    	retInfo+=""+"|";
    	retInfo+=document.all.sysnote.value+"|";
    	retInfo+=document.all.simBell.value+"|";
		 return retInfo;
	 }
function changeOpr(selObj)
{
	if(selObj.options[selObj.selectedIndex].value=="d")
	{
		document.all.terminalType.readOnly = true;
		document.all.roamType.readOnly = true;
		//document.all.internetIp.readOnly = true;
		//document.all.terminalIp.readOnly = true;
		//document.all.serviceIp.readOnly = true;

	}else
	{
		document.all.terminalType.readOnly = false;
		document.all.roamType.readOnly = false;
		//document.all.internetIp.readOnly = false;
		//document.all.terminalIp.readOnly = false;
		//document.all.serviceIp.readOnly = false;
	}
}
function changeType(){
	if (document.frm.IPType.value==1)
	{
		document.frm.ipAddress.disabled=true;
	}
	else{
		document.frm.ipAddress.disabled=false;
	}
}
function writeList(selectFlag,apnNo,terminalNum,billType,apnProductCode,apnProductName)
{
	var html="<tr><td bgcolor=E8E8E8><input type=checkbox name=selectFlag"+selectFlag+" value="+selectFlag+"></td>";
	html+="<td bgcolor=E8E8E8><input name=apnNo"+selectFlag+" type='text' class='button' value='"+apnNo+"' id=apnNo size=25></td>";
    html+="<td bgcolor=E8E8E8><input name=terminalNum"+selectFlag+" type='text' value='"+terminalNum+"' class=button id=terminalNum size=5></td>";
	selected1="";
	selected2="";
	if(billType=="P")
	{
		selected1=" selected"
	}
	if(billType=="T")
	{
		selected2=" selected"
	}
	html+="<td bgcolor=E8E8E8><select name=billType"+selectFlag+" id=billType><option value='T'"+selected2+">�ն˼Ʒ�</option><option value='P'"+selected1+">�˿ڼƷ�</option></select></td>";
	html+="<td bgcolor=E8E8E8><input name=apnProductName"+selectFlag+" type='text' value='"+apnProductName+"' class=button id=apnProductName size=15 readonly><input name=apnProductCode"+selectFlag+" type='text' value='"+apnProductCode+"' id=apnProductCode><input name=oldapnProductCode_temp"+selectFlag+" type='text' value='"+apnProductCode+"' id=oldapnProductCode_temp><input type=button name=get1222 class=button value=��ѯ style='cursor:hand' onclick='getInfo_Prod(apnProductName"+selectFlag+",apnProductCode"+selectFlag+")'></td></tr>";
	return html;
}
//��ʾ��ӡ�Ի���
function showPrtDlg(printType,DlgMessage,submitCfm)
{
   var h=150;
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

//���ύ
  function refMain(){

	 var checkFlag; //ע��javascript��JSP�ж���ı���Ҳ������ͬ,���������ҳ����.
	 if(document.all.IPType.value=="0"){

		if(document.all.ipAddress.value==""){

			alert("������IP��ַ��Ϣ!");

			return;

		}
	 }

	 showPrtDlg("Detail","ȷʵҪ��ӡ���������","Yes");
	 if (rdShowConfirmDialog("�Ƿ��ύȷ�ϲ�����")!=1){
		 delete(doSubmit_Packet);
		return false;
	}
	var notes="<%=workno%>Ϊ����"+document.all.TGrpId.value+"����apn��ַ"+document.all.optype.options[document.all.optype.selectedIndex].text;
	document.all.sysnote.value=notes;
	 var doSubmit_Packet = new AJAXPacket("s3436Cfm.jsp?systemNote="+document.all.sysnote.value+"&opNote="+document.all.sysnote.value,"�����ύ��ǰҳ�棬���Ժ�......");
	doSubmit_Packet.data.add("retType","submit");
	doSubmit_Packet.data.add("opCode",document.all.op_code.value);
	doSubmit_Packet.data.add("smCode",document.all.smCode.value);
	doSubmit_Packet.data.add("loginPasswd","<%=nopass%>");
	doSubmit_Packet.data.add("grpIdNo",document.all.grpIdNo.value);
	doSubmit_Packet.data.add("apnId",document.all.apnId.value);
	doSubmit_Packet.data.add("apnNo",document.all.apnNo.value);
	doSubmit_Packet.data.add("terminalId",document.all.terminalId.value);
	doSubmit_Packet.data.add("terminalNo",document.all.terminalNo.value);
	doSubmit_Packet.data.add("terminalType",document.all.terminalType.options.value);
	doSubmit_Packet.data.add("roamType",document.all.roamType.options.value);
	doSubmit_Packet.data.add("ipAddress",document.all.ipAddress.value);
	doSubmit_Packet.data.add("internetIp",document.all.internetIp.value);
	doSubmit_Packet.data.add("terminalIp",document.all.terminalIp.value);
	doSubmit_Packet.data.add("serviceIp",document.all.serviceIp.value);
	doSubmit_Packet.data.add("oprTypeValue",document.all.optype.options.value);
	doSubmit_Packet.data.add("login_accept",document.all.login_accept.value);
	core.ajax.sendPacket(doSubmit_Packet);
	doSubmit_Packet = null;
  }

//ȥ������Ϣ
function getId()
{
    //�õ�����ID
	if(document.all.TGrpId.value==""){
		rdShowMessageDialog("���ű�Ų���Ϊ��!");
		return;
	}
    /*var getGrpId_Packet = new RPCPacket("s3436Init.jsp","���ڻ����Ϣ�����Ժ�......");
    getGrpId_Packet.data.add("retType","GrpId");
	getGrpId_Packet.data.add("opCode",document.all.op_code.value);
    getGrpId_Packet.data.add("grpUserNo",document.all.TGrpId.value);
	getGrpId_Packet.data.add("smCode",document.all.smCode.value);
    core.rpc.sendPacket(getGrpId_Packet);
    delete(getGrpId_Packet);*/
	var pageTitle = "�����û�ѡ��";
    var fieldName = "�����û�ID|���֤��|��Ʒ����|��Ʒ����|�����ʺ�|��������|���ŵ�ַ|APN��ַ|";
	var sqlStr = "";
    var selType = "S";    //'S'��ѡ��'M'��ѡ
    var retQuence = "13|0|1|2|3|4|5|6|7|8|9|10|11|12|";
    var retToField = "grpIdNo|id_iccid|productCode|productName|contractNo|custName|custAddr|belongCode|apnNo|";
    if(PubSimpSelGrpUser(pageTitle,fieldName,sqlStr,selType,retQuence,retToField));
}
//��ѯ�б�
function PubSimpSelGrpUser(pageTitle,fieldName,sqlStr,selType,retQuence,retToField)
{
    var path = "<%=request.getContextPath()%>/npage/s3430/fpubGrpUser3439.jsp";
    path = path + "?sqlStr=" + sqlStr + "&retQuence=" + retQuence;
    path = path + "&fieldName=" + fieldName + "&pageTitle=" + pageTitle;
    path = path + "&selType=" + selType;
	path = path + "&op_code=3435";
	path = path + "&grpUserNo=" + document.all.TGrpId.value;
	path = path + "&sm_code=" +document.all.smCode.value;
    retInfo = window.open(path,"newwindow","height=450, width=700,top=50,left=200,scrollbars=yes, resizable=no,location=no, status=yes");

	return true;
}
//�õ�������Ϣ
function getValueGrp(retInfo)
{
  var retToField = "grpIdNo|id_iccid|productCode|productName|contractNo|custName|custAddr|belongCode|apnNo|";
  if(retInfo ==undefined)
    {   return false;   }

	var chPos_field = retToField.indexOf("|");
    var chPos_retStr;
    var valueStr;
    var obj;
	var apnNo_str;
	var terminalNum_str;
	var billType_str;
	var apnProductCode_str;
	var apnProductName_str;
	var num=0;
    while(chPos_field > -1)
    {
        obj = retToField.substring(0,chPos_field);
        chPos_retInfo = retInfo.indexOf("|");
        valueStr = retInfo.substring(0,chPos_retInfo);
		if(num==8){
		  apnNo_str=valueStr;
		}
		if(num==9){
		  terminalNum_str=valueStr;
		}
		if(num==10){
		  billType_str=valueStr;
		}
		if(num==11){
		  apnProductCode_str=valueStr;
		}
		if(num==12){
		  apnProductName_str=valueStr;
		}
        document.all(obj).value = valueStr;
		//alert("document.all."+obj+".value="+document.all(obj).value);
        retToField = retToField.substring(chPos_field + 1);
        retInfo = retInfo.substring(chPos_retInfo + 1);
        chPos_field = retToField.indexOf("|");
		num++;
    }
		var tmpObj="apnNo";
		var apnNum=apnNo_str.split('~').length-1;
		var backArrMsg=apnNo_str.split('~');
		document.all(tmpObj).options.length=0;
		document.all(tmpObj).options.length=apnNum;	
		
		for(i=0;i<apnNum;i++){
			document.all(tmpObj).options[i].text=backArrMsg[i];
			document.all(tmpObj).options[i].value=backArrMsg[i];
		}
		/*var tmpObj="apnNo";
		document.all(tmpObj).options.length=0;
		document.all(tmpObj).options.length=apnNum;
		for(i=0;i<backArrMsg.length;i++){
			document.all(tmpObj).options[i].text=backArrMsg[i][0];
			document.all(tmpObj).options[i].value=backArrMsg[i][0];
		} */
	//showList(apnNo_str,terminalNum_str,billType_str,apnProductCode_str,apnProductName_str);
}
function getApnTerm()
{
    var pageTitle = "APN���������ϸ��ѯ";
    var fieldName = "�û�����|�û�����|IP��ַ|��������|����ʱ��|������ˮ|";
    var sqlStr = "";
    var selType = "N";
    var retQuence = "6|0|1|2|3|4|5|";
    var retToField = "";

    getApnTermMsg(pageTitle,fieldName,sqlStr,selType,retQuence,retToField);
}
function getApnTermMsg(pageTitle,fieldName,sqlStr,selType,retQuence,retToField)
{
    /*
    ����1(pageTitle)����ѯҳ�����
    ����2(fieldName)�����������ƣ���'|'�ָ��Ĵ�
    ����3(sqlStr)��sql���
    ����4(selType)������1 rediobutton 2 checkbox
    ����5(retQuence)����������Ϣ������������� �������ʶ����'|'�ָ�����"3|0|1|2"��ʾ����3����0��1��2
    ����6(retToField))������ֵ����������,��'|'�ָ�
    */
 
    var path = "s3439_1.jsp";   
    path = path + "?sqlStr=" + sqlStr + "&retQuence=" + retQuence;
    path = path + "&fieldName=" + fieldName + "&pageTitle=" + pageTitle;
    path = path + "&selType=" + selType;  
    path = path + "&apnNo=" + document.all.apnNo.value; 
    path = path + "&grpIdNo=" + document.all.grpIdNo.value; 
   
    retInfo = window.open(path);
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

function s3439ApnVer()
{
	if(document.all.apnNo.value==""){
		alert("APN���벻��Ϊ��!");
		return;
	}
	if(document.all.grpIdNo.value==""){
		alert("���Ȳ�ѯ������Ϣ!");
		return;
	}
	var s3439ApnVer_Packet = new AJAXPacket("s3439ApnVer.jsp","���ڻ����Ϣ�����Ժ�......");
    s3439ApnVer_Packet.data.add("retType","s3439ApnVer");
    s3439ApnVer_Packet.data.add("grpIdNo",document.all.grpIdNo.value);
	s3439ApnVer_Packet.data.add("apnNo",document.all.apnNo.value);
    core.ajax.sendPacket(s3439ApnVer_Packet);
    s3439ApnVer_Packet = null;
}

function s3436TermVer()
{
	if(document.all.terminalNo.value==""){
		alert("�ն˺��벻��Ϊ��!");
		return;
	}
	if(document.all.apnId.value==""){
		alert("���Ȳ�ѯAPN��Ϣ!");
		return;
	}
	if(document.all.grpIdNo.value==""){
		alert("���Ȳ�ѯ������Ϣ!");
		return;
	}
	var s3436TermVer_Packet = new AJAXPacket("s3436TermVer.jsp","���ڻ����Ϣ�����Ժ�......");
    s3436TermVer_Packet.data.add("retType","s3436TermVer");
    s3436TermVer_Packet.data.add("grpIdNo",document.all.grpIdNo.value);
	s3436TermVer_Packet.data.add("apnId",document.all.apnId.value);
	s3436TermVer_Packet.data.add("oprType",document.all.optype.value);
	s3436TermVer_Packet.data.add("terminalNo",document.all.terminalNo.value);
	s3436TermVer_Packet.data.add("smCode",document.all.smCode.value);
    core.ajax.sendPacket(s3436TermVer_Packet);
    s3436TermVer_Packet = null;

}
function evalstr(str)
{
	return eval("document.all."+str+".value");
}


</script>
<BODY>
<FORM action="" method="post" name="frm" >
<input type="hidden" name="checkPwd_Flag" value="false">		<!--����У���־-->
<input type="hidden" id=hidPwd name="hidPwd" v_name="ԭʼ����">
<input type="hidden" name="chgSrvStart" value="">
<input type="hidden" name="chgSrvStop"  value="">
<input type="hidden" name="chgPkgDay"   value="">
<input type="hidden" name="TCustId"  value="">
<input type="hidden" name="op_code"  value="3436">
<input type="hidden" name="WorkNo"   value="<%=workno%>">
<input type="hidden" name="NoPass"   value="<%=nopass%>">
<input type="hidden" name="OrgCode"  value="<%=org_code%>">
<input type="hidden" name="apnId">
<input type="hidden" name="idNo" value="">
<input type="hidden" name="terminalId">
<input type="hidden" name="belongCode" id="belongCode" value="">
<input type="hidden" name="grpIdNo">
<input type="hidden" name="contractNo">
<input type="hidden" name="login_accept"  value="0"> <!-- ������ˮ�� -->
<%@ include file="/npage/include/header.jsp" %>
<div class="title">
	<div id="title_zi">APN�ն˰󶨺�����ϸ��ѯ</div>
</div>

        <TABLE cellSpacing=0>
          <TR>
            <td class='blue' nowrap>���ű��</TD>
            <TD><input name="TGrpId"  value="" size="20" v_must=1 v_type=string index="1">
              <input type="button" name="get1" class="b_text" value="��ѯ" style="cursor:hand" onclick="getId()">
             <font class='orange'>*</font> </TD>
            <td class='blue' nowrap>��������</TD>
            <TD width=34%><input name="custName" id="custName" value="" size="25" readonly v_must=1 v_type=string index="2">
            </TD>
          </TR>
          <TR>
            <!--TD >�������룺</TD>
            <TD>
				<jsp:include page="/page/common/pwd_1.jsp">
					<jsp:param name="width1" value="16%"  />
					<jsp:param name="width2" value="34%"  />
					<jsp:param name="pname" value="grouppass"  />
					<jsp:param name="pwd" value=""  />
				</jsp:include>
            <input type="button" name="get12" class="button" value="У��" style="cursor:hand" onclick="checkPass()"> <font color="#FF0000">*</font> </TD-->
            <td class='blue' nowrap>����֤��</TD>
            <TD colspan=3><input name="id_iccid" type="text" id="id_iccid" size="25" readonly></TD>
          </TR>
			<TR>
			   <td class='blue' nowrap>���ŵ�ַ</TD>
			   <TD colspan="3">
			   <input name="custAddr" id="custAddr" size="60" readonly>
			   </TD>
		   </TR>
          <TR>
            <td class='blue' nowrap>��Ʒ</TD>
            <TD colspan=3><input name="productCode" type="text" id="productCode" size="5" readonly>
            <input name="productName" type="text" id="productName" size="25" readonly></TD>
          </TR>

          <tr>
            <td class='blue' nowrap>APN����</td>
            <td colspan='3'><!--input name="apnNo" class="button" id="apnNo"  value="" size="20" v_must=1 v_type=string v_name=APN���� index="1"-->
			  <select name="apnNo" id="apnNo"></select>
			  <input type="button" name="get13" class="b_text" value="��ѯ" style="cursor:hand" onclick="s3439ApnVer()">
			  <font class='orange'>*</font>
			</td>
            <input name="billType" type="hidden" id="billType" size="20" readonly>
           </tr>
          <tr>
            <td class='blue' nowrap>��Ȩ����</td>
            <td><input name="apnName" type="text" id="apnName" size="20" readonly></td>
            <td class='blue' nowrap>�Ʒѷ�ʽ</td>
            <td><input name="billName" type="text" id="billName" size="20" readonly></td>
          </tr>
          <tr>
            <td class='blue' nowrap>����ն�����</td>
            <td><input name="terminalNum" type="text" id="terminalNum" size="20" readonly></td>
            <td class='blue' nowrap>�����ӵ��ն���</td>
            <td><input name="usedNum" type="text" id="usedNum" size="20" readonly></td>
          </tr>
          <tr>
            <td class='blue' nowrap>��������</td>
            <td><input name="remainNum" type="text" id="remainNum" size="20" readonly></td>
            <td class='blue' nowrap>ҵ��Ʒ��</td>
            <td><input name="smCode" type="text" id="smCode" size="20" value="ap" readonly></td>
          </tr>
     </table>
              <div id="footer">
							  <input class="b_foot" name="reset1"  onClick="" type=reset value="���">
							  <input class="b_foot" name="kkkk"  onClick="removeCurrentTab()" type=button value="�ر�">
							  <input name="internetIp" type="hidden" value="">
							  <input name="terminalIp" type="hidden" value="">
							  <input name="serviceIp" type="hidden" value="">
              </div>
<%@ include file="/npage/include/footer.jsp" %>
</FORM>
 <script language="JavaScript">
//У������ļ�������
function checkPass(){
if(document.all.custName.value==""){
   alert("���Ȳ�ѯ���ű��");
   return;
}
    var checkPwd_Packet = new AJAXPacket("checkPassword.jsp","����У�����룬���Ժ�......");

    checkPwd_Packet.data.add("retType","checkPass");
	checkPwd_Packet.data.add("inputPass",document.all.grouppass.value);
	checkPwd_Packet.data.add("rightPass",document.all.hidPwd.value);

	core.ajax.sendPacket(checkPwd_Packet);
	checkPwd_Packet = null;
}

 </script>
</BODY>
</HTML>

   
<%
/********************
 version v2.0
 ������ si-tech
 update hejw@2009-2-24
********************/
%>
              
<%
  String opCode = "3436";
  String opName = "�ն���APN��Ӧ";
%>              

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http//www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http//www.w3.org/1999/xhtml">
	
<%@ include file="/npage/include/public_title_name.jsp" %> 
<%@ page contentType="text/html;charset=Gb2312"%>
<%@ include file="../../include/remark.htm" %>

<%
    Logger logger = Logger.getLogger("s3436.jsp");
    
    String workno = (String)session.getAttribute("workNo");
	String org_code = (String)session.getAttribute("orgCode");
	String nopass  = (String)session.getAttribute("password");
	String region_code= (String)session.getAttribute("regCode");
	
	String getAcceptFlag = "";
	String printAccept="";
	String sqlStr = "";
	String[][] result = new String[][]{};

	String provinceRun="2800";
	String scpId="";
	if(Integer.parseInt(provinceRun) == 2800)
	  scpId = "101"; 
	
	boolean pwrf=false;
	String[][] temfavStr=(String[][])session.getAttribute("favInfo");
    String[] favStr=new String[temfavStr.length];
    for(int i=0;i<favStr.length;i++)
	{
		 if("a272".equals(temfavStr[i][0].trim()))
		{
			pwrf=true;
			break;
		 }
	}
	
	
		 %>
        	 <wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="region" routerValue="<%=region_code%>"  id="sysAcceptl" /> 
       
       <%
                printAccept = sysAcceptl;
	 
%>
<HTML>
<HEAD>
<TITLE>�ն���APN��Ӧ</TITLE>
</HEAD>
<SCRIPT type=text/javascript>
var i="";
var backArrMsg;
function doProcess(packet)
{
    var retType = packet.data.findValueByName("retType");
    var retCode = packet.data.findValueByName("retCode");
    var retMessage = packet.data.findValueByName("retMessage");
    self.status="";
    
    if(retType == "submit")
    {
	   if(retCode=="000000")
        {
            rdShowMessageDialog("ȷ�ϳɹ�,��ˮ["+packet.data.findValueByName("loginAccept")+"]",2);
            document.frm.reset();
        }
        else
        {
            var path="<%=request.getContextPath()%>/npage/s3430/s3430_printxls.jsp?phoneNo=" + document.frm.terminalNo.value;
            //retMessage = retMessage + "[errorCode1:" + retCode + "]";
	    
	   if (rdShowConfirmDialog(retMessage + "[errorCode1:" + retCode + "]"+"<br>�Ƿ񱣴������Ϣ��")==1)	
		{
			path = path + "&returnMsg=" + retMessage + "&unitID=" + document.frm.TGrpId.value;
	  		path = path + "&loginAccept=" + packet.data.findValueByName("loginAccept") + "&grpName=" + document.frm.custName.value ;
	  		path = path + "&op_Code=" + document.all.optype.options[document.all.optype.selectedIndex].text ;
	  		path = path + "&APN_code=" + document.all.apnNo.options[document.all.apnNo.selectedIndex].text ;
          		window.open(path);
		}		
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
	if(retType == "s3436ApnVer")
    {
		if(retCode == "000000")
        {  
			document.frm.billType.value=packet.data.findValueByName("billType");
			document.frm.apnId.value=packet.data.findValueByName("apnId");
			document.frm.terminalNum.value=packet.data.findValueByName("terminalNum");
			document.frm.usedNum.value=packet.data.findValueByName("usedNum");
			document.frm.remainNum.value=packet.data.findValueByName("remainNum");
			document.frm.smCode.value=packet.data.findValueByName("smCode");
		}
        else
        {
            rdShowMessageDialog("û�еõ�APN��Ϣ�������»�ȡ��",0);
			frm.apnNo.focus();
        }
    }
	if(retType == "s3436TermVer")
    {
		if(retCode == "000000")
        {  
			document.frm.terminalId.value=packet.data.findValueByName("terminalId");
			document.frm.terminalName.value=packet.data.findValueByName("terminalName");
			document.frm.terminalType.value=packet.data.findValueByName("terminalType");
			document.frm.roamType.value=packet.data.findValueByName("roamType");
			document.frm.ipAddress.value=packet.data.findValueByName("ipAddress");
			if(document.frm.ipAddress.value=="")
			{
				document.frm.IPType.value=1;
			}
			else
			{
				document.frm.IPType.value=0;
			}
			document.frm.internetIp.value=packet.data.findValueByName("internetIp");
			document.frm.terminalIp.value=packet.data.findValueByName("terminalIp");
			document.frm.serviceIp.value=packet.data.findValueByName("serviceIp"); 
			document.frm.sure.disabled=false;
		}
        else
    {	
      
	  var path="<%=request.getContextPath()%>/npage/s3430/s3430_printxls.jsp?phoneNo=" + document.frm.terminalNo.value;
           // retMessage = retMessage + "[errorCode1:" + retCode + "]";
	    
	   if (rdShowConfirmDialog("�������"+retCode+"<br>������Ϣ"+retMessage +"<br>�Ƿ񱣴������Ϣ��")==1)	
		{
			path = path + "&returnMsg=" + retMessage + "&unitID=" + document.frm.TGrpId.value;
	  		path = path + "&loginAccept=" + packet.data.findValueByName("loginAccept") + "&grpName=" + document.frm.custName.value ;
	  		path = path + "&op_Code=" + document.all.optype.options[document.all.optype.selectedIndex].text ;
	  		path = path + "&APN_code=" + document.all.apnNo.options[document.all.apnNo.selectedIndex].text ;
          		window.open(path);
		}			
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
				<%
				if(!pwrf)
				{
				%>
				document.frm.sure.disabled = false;
				<%
				}	
				%>   	
    	    	return false;	        	
            } else {
                rdShowMessageDialog("����У��ɹ���",2);
                document.frm.sure.disabled = false;
            }
         }
        else
        {
            rdShowMessageDialog("���벻��!����������!",0);
			<%
			if(!pwrf)
			{
			%>
			document.frm.sure.disabled = false;
			<%
			}	
			%>  
    		return false;
        }
     }	
}
//��ӡ��Ϣ
	 function printInfo(printType)
	 { 

        var getAcceptFlag = "<%=getAcceptFlag%>";
		var printAccept="<%=printAccept%>";
		document.all.login_accept.value=printAccept;
        if(getAcceptFlag == "failed")
        {   return "failed";    }
		var retInfo = "";
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
    	retInfo+="ҵ�������ն���APN��Ӧ"+"|";
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
	var html="<tr><td><input type=checkbox name=selectFlag"+selectFlag+" value="+selectFlag+"></td>";
	html+="<td><input name=apnNo"+selectFlag+" type='text'  value='"+apnNo+"' id=apnNo size=25></td>";
    html+="<td><input name=terminalNum"+selectFlag+" type='text' value='"+terminalNum+"'  id=terminalNum size=5></td>";
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
	html+="<td><select name=billType"+selectFlag+" id=billType><option value='T'"+selected2+">�ն˼Ʒ�</option><option value='P'"+selected1+">�˿ڼƷ�</option></select></td>";
	html+="<td><input name=apnProductName"+selectFlag+" type='text' value='"+apnProductName+" id=apnProductName size=15 readonly><input name=apnProductCode"+selectFlag+" type='text' value='"+apnProductCode+"' id=apnProductCode><input name=oldapnProductCode_temp"+selectFlag+" type='text' value='"+apnProductCode+"' id=oldapnProductCode_temp><input type=button name=get1222 class=button value=��ѯ style='cursor:hand' class=b_text onclick='getInfo_Prod(apnProductName"+selectFlag+",apnProductCode"+selectFlag+")'></td></tr>";
	return html;
}
//��ʾ��ӡ�Ի���
function showPrtDlg(printType,DlgMessage,submitCfm)
{  
   var h=178;
   var w=395;
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
	getAfterPrompt();
	  
	 var checkFlag; //ע��javascript��JSP�ж���ı���Ҳ������ͬ,���������ҳ����.
	 if(document.all.IPType.value=="0"){
  	
		if(document.all.ipAddress.value==""){
		
			rdShowMessageDialog("������IP��ַ��Ϣ��",0);
		
			return;
	
		}
		if(!(ipcheck(document.all.ipAddress.value)))
		{
			rdShowMessageDialog("����IP��ַ��Ϣ��ʽ����ȷ��",0);
		
			return;
		}	
	 }
	 if(document.all.terminalType.value==""){
		
			rdShowMessageDialog("�������ն����ͣ�",0);
			document.all.terminalType.focus();
			return;
	
		}
		if(document.all.roamType.value==""){
		
			rdShowMessageDialog("�������������ͣ�",0);
			document.all.roamType.focus();
			return;
	
		}
		if(document.all.terminalNo.value==""){
			rdShowMessageDialog("�ն˺��벻��Ϊ��!",0);
			return;
		}
	
	 showPrtDlg("Detail","ȷʵҪ��ӡ���������","Yes");
	 if (rdShowConfirmDialog("�Ƿ��ύȷ�ϲ�����")!=1){
		 delete(doSubmit_Packet); 
		return false;
	}
	<%String workName = (String)session.getAttribute("workName");%>
	var notes="<%=workName%>Ϊ����"+document.all.TGrpId.value+"����apn�ն�"+document.all.optype.options[document.all.optype.selectedIndex].text;
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
	doSubmit_Packet.data.add("TGrpId",document.all.TGrpId.value);
	core.ajax.sendPacket(doSubmit_Packet);
	doSubmit_Packet = null;
  }

//ȥ������Ϣ
function getId()
{
    //�õ�����ID
	if(document.all.TGrpId.value==""){
		rdShowMessageDialog("���ű�Ų���Ϊ��!",0);
		return;
	}
 
	var pageTitle = "�����û�ѡ��";
    var fieldName = "�����û�ID|���֤��|��Ʒ����|��Ʒ����|��Ʒ�ʺ�|��������|���ŵ�ַ|APN��ַ|";
	var sqlStr = "";
    var selType = "S";    //'S'��ѡ��'M'��ѡ
    var retQuence = "13|0|1|2|3|4|5|6|7|8|9|10|11|12|";
    var retToField = "grpIdNo|id_iccid|productCode|productName|contractNo|custName|custAddr|belongCode|apnNo|";
    
    if(PubSimpSelGrpUser(pageTitle,fieldName,sqlStr,selType,retQuence,retToField));	
}
//��ѯ�б�
function PubSimpSelGrpUser(pageTitle,fieldName,sqlStr,selType,retQuence,retToField)
{
    var path = "<%=request.getContextPath()%>/npage/s3430/fpubGrpUser3436.jsp";
    path = path + "?sqlStr=" + sqlStr + "&retQuence=" + retQuence;
    path = path + "&fieldName=" + fieldName + "&pageTitle=" + pageTitle;
    path = path + "&selType=" + selType;
	path = path + "&op_code=3435";
	path = path + "&grpUserNo=" + document.all.TGrpId.value; 
	path = path + "&sm_code=" +document.all.smCode.value; 
	
    retInfo = window.open(path,"newwindow","height=450, width=900,top=50,left=200,scrollbars=yes, resizable=no,location=no, status=yes");

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
 
	s3436ApnVer()
}
//
function s3436ApnVer()
{
	if(document.all.apnNo.value==""){
		rdShowMessageDialog("APN���벻��Ϊ��!",0);
		return;
	}
	if(document.all.grpIdNo.value==""){
		rdShowMessageDialog("���Ȳ�ѯ������Ϣ!",0);
		return;
	}
	var s3436ApnVer_Packet = new AJAXPacket("s3436ApnVer.jsp","���ڻ����Ϣ�����Ժ�......");
    s3436ApnVer_Packet.data.add("retType","s3436ApnVer");
    s3436ApnVer_Packet.data.add("grpIdNo",document.all.grpIdNo.value);
	s3436ApnVer_Packet.data.add("apnNo",document.all.apnNo.value);
    core.ajax.sendPacket(s3436ApnVer_Packet);
    s3436ApnVer_Packet = null;
}

function s3436TermVer()
{
	if(document.all.terminalNo.value==""){
		rdShowMessageDialog("�ն˺��벻��Ϊ��!",0);
		return;
	}
	if(document.all.apnId.value==""){
		rdShowMessageDialog("���Ȳ�ѯAPN��Ϣ!",0);
		return;
	}
	if(document.all.grpIdNo.value==""){
		rdShowMessageDialog("���Ȳ�ѯ������Ϣ!",0);
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
function   ipcheck(ipvalue)   
  {   
   var   reg   =   /^\d{1,3}(\.\d{1,3}){3}$/;   
  if   (reg.test(ipvalue))   
  {   
  var   ary   =   ipvalue.split('.');   
  for(  key   in   ary)   
  {   
  if   (parseInt(ary[key])   >   255   )   
  return   false;   
  }   
  return   true;   
    
  }else   
  return   false;   

  }


</script>
<BODY>
<FORM action="" method="post" name="frm" >
	<%@ include file="/npage/include/header.jsp" %>                         


	<div class="title">
		<div id="title_zi">�ն���APN��Ӧ</div>
	</div>
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
 
 
      <table cellspacing="0">
          <tbody> 
          <tr > 
            <td width=16% class="blue">��������</td>
            <td nowrap class="blue"> �ն���APN��Ӧ</td>
          </tbody> 
        </table>
       <table cellspacing="0">
          <TR>
            <TD  width=16% class="blue"> 
              <div align="left">���ű��</div>
            </TD>
            <TD width=34%>
            	<input  name="TGrpId"  value="" size="20" v_must=1 v_type=string   index="1">
              <input type="button" class="b_text" name="get1"  value="��ѯ" style="cursor:hand" onclick="getId()">
             <font class="orange">*</font> </TD>
            <TD width=16% class="blue">��������</TD>
            <TD width=34%><input name="custName"  id="custName" value="" size="25" readonly  class="InputGrey" v_must=1 v_type=string v_name="��������" index="2">
            </TD>
          </TR>
          <TR>
 
            <TD class="blue">����֤��</TD>
            <TD colspan="3"><input name="id_iccid" type="text"  id="id_iccid" size="25" readonly class="InputGrey"></TD>
			
          </TR>
			<TR>
			   <TD  class="blue">���ŵ�ַ</TD>
			   <TD colspan="3">
			   <input name="custAddr"  id="custAddr" size="60" readonly class="InputGrey">
			   </TD>
		   </TR>
          <TR> 
            <TD   class="blue">��Ʒ</TD>
            <TD colspan="3">
            	<input name="productCode" type="text"  id="productCode" size="10" readonly class="InputGrey">
            <input name="productName" type="text"  id="productName" size="25" readonly class="InputGrey"></TD>
          </TR>
		  
		  <TR><TD class="blue">��������</TD>
           
			<TD width="34%" colspan="3">
			<select name="optype" id="optype" style="WIDTH: 130px" onChange="changeOpr(this)">
			  
				<option value="a">���</option>
                        
				<option value="d">ɾ��</option> 
            
			</select> 
            
		 </TD>
			
		 </TR>

          <tr>
            <td width="16%" class="blue">APN����</td>
            <td>
			  <select name="apnNo" id="apnNo"></select>
			  <font class="orange">*</font> </td>
            <td width="16%" class="blue">�Ʒѷ�ʽ</td>
            <td>
			<select name="billType" id="billType">
					<option value='T'>�ն˼Ʒ�</option>
					<option value='P'>�˿ڼƷ�</option>
            </select>			
            </td>
          </tr>
          <tr>
            <td class="blue">����ն�����</td>
            <td><input name="terminalNum" type="text"  id="terminalNum"  readonly class="InputGrey"></td>
            <td class="blue">�����ӵ��ն���</td>
            <td><input name="usedNum" type="text"  id="usedNum" readonly class="InputGrey">            </td>
          </tr>
          <tr>
            <td class="blue">��������</td>
            <td><input name="remainNum" type="text"  id="remainNum" readonly class="InputGrey"></td>
            <td class="blue">ҵ��Ʒ��</td>
            <td><input name="smCode" type="text"  id="smCode" value="ap" readonly class="InputGrey"></td>
          </tr>
          
        </TABLE>
		
 
		<table  cellspacing="0" >
          <tr>
            <td width="16%" class="blue">�ն˺���</td>
            <td width="34%"><input name="terminalNo" type="text"  id="terminalNo" size="20">
              <input type="button" name="get132"  class="b_text" value="��ѯ" style="cursor:hand" onclick="s3436TermVer()"><font class="orange">*</font></td>
            <td width="16%" class="blue">�ն��û�����</td>
            <td width="34%"><input name="terminalName" type="text"  id="terminalName" size="20" readonly class="InputGrey"></td>
          </tr>
          <tr>
            <td class="blue">�ն�����</td>
            <td><select name="terminalType" id="terminalType">
				<%
				sqlStr = "SELECT terminal_type,terminal_name from sTermType WHERE region_code='"+region_code+"' and sm_code='ap' AND valid_flag = 'Y'";
				//retArray = callView.sPubSelect("2",sqlStr);
				%>
				
		<wtc:pubselect name="sPubSelect" outnum="2" retmsg="msg1" retcode="code1" routerKey="region" routerValue="<%=region_code%>">
  	 <wtc:sql><%=sqlStr%></wtc:sql>
 	  </wtc:pubselect>
	 <wtc:array id="result_t1" scope="end"/>				
				
				<%
				result = result_t1;
				for(int i = 0 ; i < result.length ; i ++)
				{
				%>
                	<option value="<%=result[i][0]%>"><%=result[i][1]%></option>
                <%}%>
                </select>															
			<font class="orange">*</font></td>
            <td class="blue">��������</td>	
            <td><select name="roamType" id="roamType">
			<%
				sqlStr = "SELECT roam_type,roam_name from sDdnRoamType WHERE region_code='"+region_code+"' and sm_code='ap' AND valid_flag = 'Y'";
				System.out.println("@@@@@@@@@@@@@@@@@@@sqlStr="+sqlStr);
				//retArray = callView.sPubSelect("2",sqlStr);
				%>
				
		<wtc:pubselect name="sPubSelect" outnum="2" retmsg="msg2" retcode="code2" routerKey="region" routerValue="<%=region_code%>">
  	 <wtc:sql><%=sqlStr%></wtc:sql>
 	  </wtc:pubselect>
	 <wtc:array id="result_t2" scope="end"/>				
				
				<%
				result = result_t2;
				for(int i = 0 ; i < result.length ; i ++)
				{
			%>
                <option value="<%=result[i][0]%>"><%=result[i][1]%></option>
            <%}%>
            </select></td>
          </tr>
          <tr>
			<td class="blue">IP����</td>
			<td>
				<select name="IPType" id="IPType" onchange="changeType()">
					<option value="0">��̬IP</option>
					<option value="1">��̬IP</option>
				</select>
			</td>
            <td class="blue">IP��ַ</td>
            <td>
            	<input name="ipAddress" type="text"  id="ipAddress" size="25">
            </td>
 
          </tr>
        </table>
 
		
	    <TABLE cellSpacing="0">
           <TR>
			   <TD width="16%" class="blue">ϵͳ��ע</TD>
			   <TD colspan="3">
			   <input  name="sysnote" size="60" readonly class="InputGrey">
			   </TD>
		   </TR>
	   </TABLE>
      
        <TABLE cellSpacing="0">
          <TBODY>
            <TR >
              <TD align=center id="footer">
			  <input  name="sure"  type=button class="b_foot" value="ȷ��"  onclick="refMain()" disabled>
			  <input  name="reset1"  onClick="" class="b_foot"  type=reset value="���">
			  <input  name="kkkk"  onClick="removeCurrentTab()"  class="b_foot"  type=button value="�ر�">
			  <input name="internetIp" type="hidden" value="">
			  <input name="terminalIp" type="hidden" value="">
			  <input name="serviceIp" type="hidden" value="">
              </TD>
            </TR>
          </TBODY>
        </TABLE>
 
		<jsp:include page="/npage/common/pwd_comm.jsp"/>
			<%@ include file="/npage/include/footer.jsp" %>
</FORM>
 <script language="JavaScript">
//У������ļ�������
function checkPass(){
if(document.all.custName.value==""){  
   rdShowMessageDialog("���Ȳ�ѯ���ű��",0);
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

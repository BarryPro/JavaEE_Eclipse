   
<%
/********************
 version v2.0
 开发商 si-tech
 update hejw@2009-2-24
********************/
%>
              
<%
  String opCode = "3436";
  String opName = "终端与APN对应";
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
<TITLE>终端与APN对应</TITLE>
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
            rdShowMessageDialog("确认成功,流水["+packet.data.findValueByName("loginAccept")+"]",2);
            document.frm.reset();
        }
        else
        {
            var path="<%=request.getContextPath()%>/npage/s3430/s3430_printxls.jsp?phoneNo=" + document.frm.terminalNo.value;
            //retMessage = retMessage + "[errorCode1:" + retCode + "]";
	    
	   if (rdShowConfirmDialog(retMessage + "[errorCode1:" + retCode + "]"+"<br>是否保存错误信息？")==1)	
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
            rdShowMessageDialog("没有得到集团信息,请重新获取！",0);
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
            rdShowMessageDialog("没有得到APN信息，请重新获取！",0);
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
	    
	   if (rdShowConfirmDialog("错误代码"+retCode+"<br>错误信息"+retMessage +"<br>是否保存错误信息？")==1)	
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
	if(retType == "checkPass") //集团客户密码校验
     {
        if(retCode == "000000")
        {
            var retResult = packet.data.findValueByName("retResult");
    		frm.checkPwd_Flag.value = retResult; 
            if (retResult == "false") {
    	    	rdShowMessageDialog("密码不对!请重新输入!",0);
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
                rdShowMessageDialog("密码校验成功！",2);
                document.frm.sure.disabled = false;
            }
         }
        else
        {
            rdShowMessageDialog("密码不对!请重新输入!",0);
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
//打印信息
	 function printInfo(printType)
	 { 

        var getAcceptFlag = "<%=getAcceptFlag%>";
		var printAccept="<%=printAccept%>";
		document.all.login_accept.value=printAccept;
        if(getAcceptFlag == "failed")
        {   return "failed";    }
		var retInfo = "";
    	retInfo+='<%=new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss", Locale.getDefault()).format(new java.util.Date())%>'+"|";
    	retInfo+="集团编号:"+document.frm.TGrpId.value+"|";
    	retInfo+="集团名称:"+document.frm.custName.value+"|";
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
    	retInfo+="业务类型终端与APN对应"+"|";
    	retInfo+="终端号码:"+document.frm.terminalNo.value+"|";
		retInfo+="IP类型:"+document.all.IPType.options[document.all.IPType.selectedIndex].text
    	retInfo+="IP地址:"+document.frm.ipAddress.value+"|";
    	retInfo+="流水:"+document.all.login_accept.value+"|";
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
	html+="<td><select name=billType"+selectFlag+" id=billType><option value='T'"+selected2+">终端计费</option><option value='P'"+selected1+">端口计费</option></select></td>";
	html+="<td><input name=apnProductName"+selectFlag+" type='text' value='"+apnProductName+" id=apnProductName size=15 readonly><input name=apnProductCode"+selectFlag+" type='text' value='"+apnProductCode+"' id=apnProductCode><input name=oldapnProductCode_temp"+selectFlag+" type='text' value='"+apnProductCode+"' id=oldapnProductCode_temp><input type=button name=get1222 class=button value=查询 style='cursor:hand' class=b_text onclick='getInfo_Prod(apnProductName"+selectFlag+",apnProductCode"+selectFlag+")'></td></tr>";
	return html;
}
//显示打印对话框
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

//主提交
  function refMain(){
	getAfterPrompt();
	  
	 var checkFlag; //注意javascript和JSP中定义的变量也不能相同,否则出现网页错误.
	 if(document.all.IPType.value=="0"){
  	
		if(document.all.ipAddress.value==""){
		
			rdShowMessageDialog("请输入IP地址信息！",0);
		
			return;
	
		}
		if(!(ipcheck(document.all.ipAddress.value)))
		{
			rdShowMessageDialog("输入IP地址信息格式不正确！",0);
		
			return;
		}	
	 }
	 if(document.all.terminalType.value==""){
		
			rdShowMessageDialog("请输入终端类型！",0);
			document.all.terminalType.focus();
			return;
	
		}
		if(document.all.roamType.value==""){
		
			rdShowMessageDialog("请输入漫游类型！",0);
			document.all.roamType.focus();
			return;
	
		}
		if(document.all.terminalNo.value==""){
			rdShowMessageDialog("终端号码不能为空!",0);
			return;
		}
	
	 showPrtDlg("Detail","确实要打印电子免填单吗？","Yes");
	 if (rdShowConfirmDialog("是否提交确认操作？")!=1){
		 delete(doSubmit_Packet); 
		return false;
	}
	<%String workName = (String)session.getAttribute("workName");%>
	var notes="<%=workName%>为集团"+document.all.TGrpId.value+"办理apn终端"+document.all.optype.options[document.all.optype.selectedIndex].text;
	document.all.sysnote.value=notes;
	 var doSubmit_Packet = new AJAXPacket("s3436Cfm.jsp?systemNote="+document.all.sysnote.value+"&opNote="+document.all.sysnote.value,"正在提交当前页面，请稍候......");
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

//去集团信息
function getId()
{
    //得到集团ID
	if(document.all.TGrpId.value==""){
		rdShowMessageDialog("集团编号不能为空!",0);
		return;
	}
 
	var pageTitle = "集团用户选择";
    var fieldName = "集团用户ID|身份证号|产品代码|产品名称|产品帐号|集团名称|集团地址|APN地址|";
	var sqlStr = "";
    var selType = "S";    //'S'单选；'M'多选
    var retQuence = "13|0|1|2|3|4|5|6|7|8|9|10|11|12|";
    var retToField = "grpIdNo|id_iccid|productCode|productName|contractNo|custName|custAddr|belongCode|apnNo|";
    
    if(PubSimpSelGrpUser(pageTitle,fieldName,sqlStr,selType,retQuence,retToField));	
}
//查询列表
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
//得到返回信息
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
		rdShowMessageDialog("APN号码不能为空!",0);
		return;
	}
	if(document.all.grpIdNo.value==""){
		rdShowMessageDialog("请先查询集团信息!",0);
		return;
	}
	var s3436ApnVer_Packet = new AJAXPacket("s3436ApnVer.jsp","正在获得信息，请稍候......");
    s3436ApnVer_Packet.data.add("retType","s3436ApnVer");
    s3436ApnVer_Packet.data.add("grpIdNo",document.all.grpIdNo.value);
	s3436ApnVer_Packet.data.add("apnNo",document.all.apnNo.value);
    core.ajax.sendPacket(s3436ApnVer_Packet);
    s3436ApnVer_Packet = null;
}

function s3436TermVer()
{
	if(document.all.terminalNo.value==""){
		rdShowMessageDialog("终端号码不能为空!",0);
		return;
	}
	if(document.all.apnId.value==""){
		rdShowMessageDialog("请先查询APN信息!",0);
		return;
	}
	if(document.all.grpIdNo.value==""){
		rdShowMessageDialog("请先查询集团信息!",0);
		return;
	}
	var s3436TermVer_Packet = new AJAXPacket("s3436TermVer.jsp","正在获得信息，请稍候......");
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
		<div id="title_zi">终端与APN对应</div>
	</div>
<input type="hidden" name="checkPwd_Flag" value="false">		<!--密码校验标志-->
<input type="hidden" id=hidPwd name="hidPwd" v_name="原始密码">
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
<input type="hidden" name="login_accept"  value="0"> <!-- 操作流水号 -->
 
 
      <table cellspacing="0">
          <tbody> 
          <tr > 
            <td width=16% class="blue">操作类型</td>
            <td nowrap class="blue"> 终端与APN对应</td>
          </tbody> 
        </table>
       <table cellspacing="0">
          <TR>
            <TD  width=16% class="blue"> 
              <div align="left">集团编号</div>
            </TD>
            <TD width=34%>
            	<input  name="TGrpId"  value="" size="20" v_must=1 v_type=string   index="1">
              <input type="button" class="b_text" name="get1"  value="查询" style="cursor:hand" onclick="getId()">
             <font class="orange">*</font> </TD>
            <TD width=16% class="blue">集团名称</TD>
            <TD width=34%><input name="custName"  id="custName" value="" size="25" readonly  class="InputGrey" v_must=1 v_type=string v_name="集团名称" index="2">
            </TD>
          </TR>
          <TR>
 
            <TD class="blue">集团证件</TD>
            <TD colspan="3"><input name="id_iccid" type="text"  id="id_iccid" size="25" readonly class="InputGrey"></TD>
			
          </TR>
			<TR>
			   <TD  class="blue">集团地址</TD>
			   <TD colspan="3">
			   <input name="custAddr"  id="custAddr" size="60" readonly class="InputGrey">
			   </TD>
		   </TR>
          <TR> 
            <TD   class="blue">产品</TD>
            <TD colspan="3">
            	<input name="productCode" type="text"  id="productCode" size="10" readonly class="InputGrey">
            <input name="productName" type="text"  id="productName" size="25" readonly class="InputGrey"></TD>
          </TR>
		  
		  <TR><TD class="blue">操作类型</TD>
           
			<TD width="34%" colspan="3">
			<select name="optype" id="optype" style="WIDTH: 130px" onChange="changeOpr(this)">
			  
				<option value="a">添加</option>
                        
				<option value="d">删除</option> 
            
			</select> 
            
		 </TD>
			
		 </TR>

          <tr>
            <td width="16%" class="blue">APN号码</td>
            <td>
			  <select name="apnNo" id="apnNo"></select>
			  <font class="orange">*</font> </td>
            <td width="16%" class="blue">计费方式</td>
            <td>
			<select name="billType" id="billType">
					<option value='T'>终端计费</option>
					<option value='P'>端口计费</option>
            </select>			
            </td>
          </tr>
          <tr>
            <td class="blue">最大终端数量</td>
            <td><input name="terminalNum" type="text"  id="terminalNum"  readonly class="InputGrey"></td>
            <td class="blue">已增加的终端数</td>
            <td><input name="usedNum" type="text"  id="usedNum" readonly class="InputGrey">            </td>
          </tr>
          <tr>
            <td class="blue">可用数量</td>
            <td><input name="remainNum" type="text"  id="remainNum" readonly class="InputGrey"></td>
            <td class="blue">业务品牌</td>
            <td><input name="smCode" type="text"  id="smCode" value="ap" readonly class="InputGrey"></td>
          </tr>
          
        </TABLE>
		
 
		<table  cellspacing="0" >
          <tr>
            <td width="16%" class="blue">终端号码</td>
            <td width="34%"><input name="terminalNo" type="text"  id="terminalNo" size="20">
              <input type="button" name="get132"  class="b_text" value="查询" style="cursor:hand" onclick="s3436TermVer()"><font class="orange">*</font></td>
            <td width="16%" class="blue">终端用户名称</td>
            <td width="34%"><input name="terminalName" type="text"  id="terminalName" size="20" readonly class="InputGrey"></td>
          </tr>
          <tr>
            <td class="blue">终端类型</td>
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
            <td class="blue">漫游类型</td>	
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
			<td class="blue">IP类型</td>
			<td>
				<select name="IPType" id="IPType" onchange="changeType()">
					<option value="0">静态IP</option>
					<option value="1">动态IP</option>
				</select>
			</td>
            <td class="blue">IP地址</td>
            <td>
            	<input name="ipAddress" type="text"  id="ipAddress" size="25">
            </td>
 
          </tr>
        </table>
 
		
	    <TABLE cellSpacing="0">
           <TR>
			   <TD width="16%" class="blue">系统备注</TD>
			   <TD colspan="3">
			   <input  name="sysnote" size="60" readonly class="InputGrey">
			   </TD>
		   </TR>
	   </TABLE>
      
        <TABLE cellSpacing="0">
          <TBODY>
            <TR >
              <TD align=center id="footer">
			  <input  name="sure"  type=button class="b_foot" value="确认"  onclick="refMain()" disabled>
			  <input  name="reset1"  onClick="" class="b_foot"  type=reset value="清除">
			  <input  name="kkkk"  onClick="removeCurrentTab()"  class="b_foot"  type=button value="关闭">
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
//校验输入的集团密码
function checkPass(){
if(document.all.custName.value==""){  
   rdShowMessageDialog("请先查询集团编号",0);
   return;
}
    var checkPwd_Packet = new AJAXPacket("checkPassword.jsp","正在校验密码，请稍候......");
	
    checkPwd_Packet.data.add("retType","checkPass");
	checkPwd_Packet.data.add("inputPass",document.all.grouppass.value);
	checkPwd_Packet.data.add("rightPass",document.all.hidPwd.value);
	
	core.ajax.sendPacket(checkPwd_Packet);
	checkPwd_Packet = null;
}

 </script>
</BODY>
</HTML>

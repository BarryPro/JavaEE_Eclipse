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
	String opName = "APN终端绑定号码明细查询";
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<HEAD>
<TITLE>APN终端绑定号码明细查询</TITLE>
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
            rdShowMessageDialog("确认成功,流水["+packet.data.findValueByName("loginAccept")+"]",2);
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
            rdShowMessageDialog("没有得到集团信息,请重新获取！",0);
			frm.TGrpId.focus();
        }
    }
	if(retType == "s3439ApnVer")
    {
		if(retCode == "000000")
        {
			document.frm.billType.value=packet.data.findValueByName("billType");
			if (document.frm.billType.value == "T")
			    document.frm.billName.value = "终端计费";
			else
			    document.frm.billName.value = "端口计费";
			document.frm.apnId.value=packet.data.findValueByName("apnId");
			document.frm.terminalNum.value=packet.data.findValueByName("terminalNum");
			document.frm.usedNum.value=packet.data.findValueByName("usedNum");
			document.frm.remainNum.value=packet.data.findValueByName("remainNum");
			document.frm.smCode.value=packet.data.findValueByName("smCode");
			document.frm.apnName.value=packet.data.findValueByName("apnName");
		}
        else
        {
            rdShowMessageDialog("没有得到APN信息，请重新获取！",0);
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
            rdShowMessageDialog("没有得到终端号码信息，请重新获取！",0);
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
				document.frm.sure.disabled = false;
    	    	return false;
            } else {
                rdShowMessageDialog("密码校验成功！",2);
                document.frm.sure.disabled = false;
            }
         }
        else
        {
            rdShowMessageDialog("密码不对!请重新输入!",0);
			document.frm.sure.disabled = false;
    		return false;
        }
     }
}
//打印信息
	 function printInfo(printType)
	 {
	<%
        //取得打印流水
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
                out.println("rdShowMessageDialog('取系统操作流水失败！',0);");
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
    	retInfo+="业务类型：APN终端绑定号码明细查询"+"|";
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
	html+="<td bgcolor=E8E8E8><select name=billType"+selectFlag+" id=billType><option value='T'"+selected2+">终端计费</option><option value='P'"+selected1+">端口计费</option></select></td>";
	html+="<td bgcolor=E8E8E8><input name=apnProductName"+selectFlag+" type='text' value='"+apnProductName+"' class=button id=apnProductName size=15 readonly><input name=apnProductCode"+selectFlag+" type='text' value='"+apnProductCode+"' id=apnProductCode><input name=oldapnProductCode_temp"+selectFlag+" type='text' value='"+apnProductCode+"' id=oldapnProductCode_temp><input type=button name=get1222 class=button value=查询 style='cursor:hand' onclick='getInfo_Prod(apnProductName"+selectFlag+",apnProductCode"+selectFlag+")'></td></tr>";
	return html;
}
//显示打印对话框
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

//主提交
  function refMain(){

	 var checkFlag; //注意javascript和JSP中定义的变量也不能相同,否则出现网页错误.
	 if(document.all.IPType.value=="0"){

		if(document.all.ipAddress.value==""){

			alert("请输入IP地址信息!");

			return;

		}
	 }

	 showPrtDlg("Detail","确实要打印电子免填单吗？","Yes");
	 if (rdShowConfirmDialog("是否提交确认操作？")!=1){
		 delete(doSubmit_Packet);
		return false;
	}
	var notes="<%=workno%>为集团"+document.all.TGrpId.value+"办理apn地址"+document.all.optype.options[document.all.optype.selectedIndex].text;
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
	core.ajax.sendPacket(doSubmit_Packet);
	doSubmit_Packet = null;
  }

//去集团信息
function getId()
{
    //得到集团ID
	if(document.all.TGrpId.value==""){
		rdShowMessageDialog("集团编号不能为空!");
		return;
	}
    /*var getGrpId_Packet = new RPCPacket("s3436Init.jsp","正在获得信息，请稍候......");
    getGrpId_Packet.data.add("retType","GrpId");
	getGrpId_Packet.data.add("opCode",document.all.op_code.value);
    getGrpId_Packet.data.add("grpUserNo",document.all.TGrpId.value);
	getGrpId_Packet.data.add("smCode",document.all.smCode.value);
    core.rpc.sendPacket(getGrpId_Packet);
    delete(getGrpId_Packet);*/
	var pageTitle = "集团用户选择";
    var fieldName = "集团用户ID|身份证号|产品代码|产品名称|付费帐号|集团名称|集团地址|APN地址|";
	var sqlStr = "";
    var selType = "S";    //'S'单选；'M'多选
    var retQuence = "13|0|1|2|3|4|5|6|7|8|9|10|11|12|";
    var retToField = "grpIdNo|id_iccid|productCode|productName|contractNo|custName|custAddr|belongCode|apnNo|";
    if(PubSimpSelGrpUser(pageTitle,fieldName,sqlStr,selType,retQuence,retToField));
}
//查询列表
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
    var pageTitle = "APN号码操作明细查询";
    var fieldName = "用户号码|用户名称|IP地址|操作工号|操作时间|操作流水|";
    var sqlStr = "";
    var selType = "N";
    var retQuence = "6|0|1|2|3|4|5|";
    var retToField = "";

    getApnTermMsg(pageTitle,fieldName,sqlStr,selType,retQuence,retToField);
}
function getApnTermMsg(pageTitle,fieldName,sqlStr,selType,retQuence,retToField)
{
    /*
    参数1(pageTitle)：查询页面标题
    参数2(fieldName)：列中文名称，以'|'分隔的串
    参数3(sqlStr)：sql语句
    参数4(selType)：类型1 rediobutton 2 checkbox
    参数5(retQuence)：返回域信息，返回域个数＋ 返回域标识，以'|'分隔，如"3|0|1|2"表示返回3个域0，1，2
    参数6(retToField))：返回值存放域的名称,以'|'分隔
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
		alert("APN号码不能为空!");
		return;
	}
	if(document.all.grpIdNo.value==""){
		alert("请先查询集团信息!");
		return;
	}
	var s3439ApnVer_Packet = new AJAXPacket("s3439ApnVer.jsp","正在获得信息，请稍候......");
    s3439ApnVer_Packet.data.add("retType","s3439ApnVer");
    s3439ApnVer_Packet.data.add("grpIdNo",document.all.grpIdNo.value);
	s3439ApnVer_Packet.data.add("apnNo",document.all.apnNo.value);
    core.ajax.sendPacket(s3439ApnVer_Packet);
    s3439ApnVer_Packet = null;
}

function s3436TermVer()
{
	if(document.all.terminalNo.value==""){
		alert("终端号码不能为空!");
		return;
	}
	if(document.all.apnId.value==""){
		alert("请先查询APN信息!");
		return;
	}
	if(document.all.grpIdNo.value==""){
		alert("请先查询集团信息!");
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


</script>
<BODY>
<FORM action="" method="post" name="frm" >
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
<%@ include file="/npage/include/header.jsp" %>
<div class="title">
	<div id="title_zi">APN终端绑定号码明细查询</div>
</div>

        <TABLE cellSpacing=0>
          <TR>
            <td class='blue' nowrap>集团编号</TD>
            <TD><input name="TGrpId"  value="" size="20" v_must=1 v_type=string index="1">
              <input type="button" name="get1" class="b_text" value="查询" style="cursor:hand" onclick="getId()">
             <font class='orange'>*</font> </TD>
            <td class='blue' nowrap>集团名称</TD>
            <TD width=34%><input name="custName" id="custName" value="" size="25" readonly v_must=1 v_type=string index="2">
            </TD>
          </TR>
          <TR>
            <!--TD >集团密码：</TD>
            <TD>
				<jsp:include page="/page/common/pwd_1.jsp">
					<jsp:param name="width1" value="16%"  />
					<jsp:param name="width2" value="34%"  />
					<jsp:param name="pname" value="grouppass"  />
					<jsp:param name="pwd" value=""  />
				</jsp:include>
            <input type="button" name="get12" class="button" value="校验" style="cursor:hand" onclick="checkPass()"> <font color="#FF0000">*</font> </TD-->
            <td class='blue' nowrap>集团证件</TD>
            <TD colspan=3><input name="id_iccid" type="text" id="id_iccid" size="25" readonly></TD>
          </TR>
			<TR>
			   <td class='blue' nowrap>集团地址</TD>
			   <TD colspan="3">
			   <input name="custAddr" id="custAddr" size="60" readonly>
			   </TD>
		   </TR>
          <TR>
            <td class='blue' nowrap>产品</TD>
            <TD colspan=3><input name="productCode" type="text" id="productCode" size="5" readonly>
            <input name="productName" type="text" id="productName" size="25" readonly></TD>
          </TR>

          <tr>
            <td class='blue' nowrap>APN号码</td>
            <td colspan='3'><!--input name="apnNo" class="button" id="apnNo"  value="" size="20" v_must=1 v_type=string v_name=APN号码 index="1"-->
			  <select name="apnNo" id="apnNo"></select>
			  <input type="button" name="get13" class="b_text" value="查询" style="cursor:hand" onclick="s3439ApnVer()">
			  <font class='orange'>*</font>
			</td>
            <input name="billType" type="hidden" id="billType" size="20" readonly>
           </tr>
          <tr>
            <td class='blue' nowrap>鉴权名称</td>
            <td><input name="apnName" type="text" id="apnName" size="20" readonly></td>
            <td class='blue' nowrap>计费方式</td>
            <td><input name="billName" type="text" id="billName" size="20" readonly></td>
          </tr>
          <tr>
            <td class='blue' nowrap>最大终端数量</td>
            <td><input name="terminalNum" type="text" id="terminalNum" size="20" readonly></td>
            <td class='blue' nowrap>已增加的终端数</td>
            <td><input name="usedNum" type="text" id="usedNum" size="20" readonly></td>
          </tr>
          <tr>
            <td class='blue' nowrap>可用数量</td>
            <td><input name="remainNum" type="text" id="remainNum" size="20" readonly></td>
            <td class='blue' nowrap>业务品牌</td>
            <td><input name="smCode" type="text" id="smCode" size="20" value="ap" readonly></td>
          </tr>
     </table>
              <div id="footer">
							  <input class="b_foot" name="reset1"  onClick="" type=reset value="清除">
							  <input class="b_foot" name="kkkk"  onClick="removeCurrentTab()" type=button value="关闭">
							  <input name="internetIp" type="hidden" value="">
							  <input name="terminalIp" type="hidden" value="">
							  <input name="serviceIp" type="hidden" value="">
              </div>
<%@ include file="/npage/include/footer.jsp" %>
</FORM>
 <script language="JavaScript">
//校验输入的集团密码
function checkPass(){
if(document.all.custName.value==""){
   alert("请先查询集团编号");
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

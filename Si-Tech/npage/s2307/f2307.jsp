   
<%
/********************
 version v2.0
 开发商 si-tech
 update hejw@2009-2-5
********************/
%>
              
<%
  String opCode = "2307";
  String opName = "动态信誉度申请/取消";
%>              

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http//www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http//www.w3.org/1999/xhtml">
<%@ include file="/npage/include/public_title_name.jsp" %> 
	
	
<%@ page contentType= "text/html;charset=gb2312" %>
<%@ taglib uri="weblogic-tags.tld" prefix="wl" %>
<%@ page import="com.sitech.boss.f2307.ejb.*"%>
<%@ page import="com.sitech.boss.f2307.wrapper.*"%>
<%@ page import="com.sitech.boss.pub.util.*" %>
<%@ page import="java.util.ArrayList"%>
<%

String workNo = (String)session.getAttribute("workNo");
String workName = (String)session.getAttribute("workName");
String nopass = (String)session.getAttribute("password");
String rightCode = (String)session.getAttribute("rightCode");
String[][] favInfo = (String[][])session.getAttribute("favInfo");
String region_codeT = (String)session.getAttribute("regCode");
String orgCode = (String)session.getAttribute("orgCode");

//comImpl co=new comImpl();
String sqIdtype = "select id_type,id_name from sidtype";
//ArrayList sIdTypeArr = co.spubqry32("2",sqIdtype);
%>

		<wtc:pubselect name="sPubSelect" outnum="2" retmsg="msg2" retcode="code2" routerKey="region" routerValue="<%=region_codeT%>">
  	 <wtc:sql><%=sqIdtype%></wtc:sql>
 	  </wtc:pubselect>
	 <wtc:array id="result_t1" scope="end"/>

<%
String[][] sIdTypeStr = result_t1;


int favFlag = 0 ;
//begin add by diling for 对密码权限整改 @2011/11/1 
    boolean pwrf = false;
	String pubOpCode = opCode;
%>
	<%@ include file="/npage/public/pubCheckPwdPower.jsp" %>
<%
    System.out.println("==第三批======f2307.jsp==== pwrf = " + pwrf);
if(pwrf){               
    favFlag = 1;
}
//end add by diling for 对密码权限整改 @2011/11/1 

%>
<%

ArrayList arr = F2307Wrapper.getFuncFee(region_codeT);

String[][] fee = (String[][])arr.get(0);   
//System.out.println(fee.length);
String tHandFee = "0";
int feeFlag = 0;
if(fee.length==0){
tHandFee="0";
feeFlag = 0;
}else{
tHandFee=fee[0][1];
for(int i = 0 ; i < favInfo.length ; i ++){
	if(favInfo[i][0].trim().equals(fee[0][2])){
		feeFlag = 1;
	}
}

}

String ph_no = request.getParameter("ph_no");
%>

 <wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="regioncode" routerValue="<%=region_codeT%>"  id="sysAcceptl" /> 

<HTML><HEAD>
<TITLE>动态信誉度申请/取消
</TITLE><!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">


<!--
<META content=no-cache http-equiv=Pragma>
<META content=no-cache http-equiv=Cache-Control>
-->

<META content="MSHTML 5.00.3315.2870" name=GENERATOR>
<%@ include file="/npage/common/pwd_comm.jsp" %>
</HEAD>
<script language="javascript">
var printFlag=9;
var flag1 = 0;
var timeFlag = 0;
onload=function(){
	self.status="";
	document.all.phoneNo.focus();
}
function doProcess(packet){
	var phoneNo = packet.data.findValueByName("phoneNo");
	var backString = packet.data.findValueByName("backString");
	var cfmFlag = packet.data.findValueByName("flag1");
	if(cfmFlag==99){
		if(backString==1){
			rdShowMessageDialog("验证成功！",2);
			document.frm.submit.disabled=false;
		}else{
			rdShowMessageDialog("密码不正确！",0);
			document.frm.submit.disabled=true;
		}
	}
	if(cfmFlag==1){
			var errCode = packet.data.findValueByName("errCode");
			var errMsg = packet.data.findValueByName("errMsg");
		
			var errCodeInt = parseInt(errCode);

			if(errCodeInt==0){
				rdShowMessageDialog("操作成功！",2);
				document.frm.backLoginAccept.value=backString[0][0];
				
				
				if(document.frm.handFee.value!=0){
					printBill();
				}else{
					window.location="f2307.jsp?ph_no="+phoneNo;
				}
			
			}else{
				rdShowMessageDialog(errCode + " : " + errMsg);
				window.location="f2307.jsp?ph_no="+phoneNo;
			}
			
		
		
	}
	if(cfmFlag==9){
		//rdShowMessageDialog("该号码不存在！");
		var errCode = packet.data.findValueByName("errCode");
			var errMsg = packet.data.findValueByName("errMsg");
		rdShowMessageDialog(errCode + " : " + errMsg);
		document.frm.phoneNo.value="";
				document.frm.qry.disabled=false;
				document.frm.phoneNo.disabled=false;
				flag1=0;
				return;
	}
	if(cfmFlag==0){
	if(backString==""){
		rdShowMessageDialog("查询失败！");
		document.frm.qry.disabled=false;
		document.frm.phoneNo.disabled=false;
		document.frm.phoneNo.value="";
	}else{
	if(document.frm.favFlag.value==1){
		document.frm.submit.disabled=false;
	}
	document.frm.customPass.value=backString[0][4];
	document.frm.userId.value=backString[0][0];
	document.frm.runName.value=backString[0][6];
	document.frm.cardType.value=backString[0][15];
	document.frm.gradeName.value=backString[0][8];
	document.frm.custAddress.value=backString[0][11]; //11
	document.frm.idCardNo.value=backString[0][14]; //14
	document.frm.totalPrepay.value=backString[0][17];
	document.frm.totalOwe.value=backString[0][16];
	document.frm.custName.value=backString[0][3];
	var creditI = 0;
	document.frm.expireTime.value=backString[0][22];
	document.frm.asCustPhone.value=backString[0][23];
	document.frm.smName.value = backString[0][2];

	if(document.frm.expireTime.value == "")
	{
	    document.frm.chgStatus.value = "N";
	    document.frm.expireTime.value = "20500101";
	    document.frm.chgStatusValue.value = "动态信誉度申请";
	}
	else
	{
	    document.frm.chgStatus.value = "R";
	    document.frm.chgStatusValue.value = "动态信誉度取消";
	    document.frm.expireTime.disabled = true;
	}
		var idI = 0 ;
		for(idI = 0 ; idI < document.frm.asIdType.length ; idI ++){
			
			if(document.frm.asIdType.options[idI].value==backString[0][24]){
				document.frm.asIdType.options[idI].selected=true;
			}
		}
		document.frm.asIdIccid.value=backString[0][14]; //25
		document.frm.asIdAddress.value=backString[0][11];//26
		document.frm.asContractAddress.value=backString[0][27];
		document.frm.asNotes.value=backString[0][28];
		

	document.frm.qryFlag.value=backString[0][21];
	document.frm.oldCredit.value=backString[0][21];
	document.frm.qryFlagT.value=backString[0][21];
	document.frm.newCredit.value=backString[0][21];
	flag1=1;
	document.frm.handFee.disabled=false;
	document.frm.factPay.disabled=false;
	
	}
}
	
}
function submitt(){

      if(document.frm.phoneNo.value==""){
      	rdShowMessageDialog("请输入手机号码！");
      	return;
      }
      if(!checkElement(document.frm.phoneNo)){
			document.frm.phoneNo.value = "";
			return;
	}
		document.frm.qry.disabled=true;
		document.frm.phoneNo.disabled=true;
		var myPacket = new AJAXPacket("getUserInfo.jsp","正在提交，请稍候......");
		myPacket.data.add("workNo",document.frm.workNo.value);
		myPacket.data.add("phoneNo",document.frm.phoneNo.value);
		myPacket.data.add("opCode",document.frm.opCode.value);
		myPacket.data.add("orgCode",document.frm.orgCode.value);
		
    	core.ajax.sendPacket(myPacket);
myPacket =null;
		
}
function getRemain(){

if(flag1!=1){
rdShowMessageDialog("请先查询用户信息！");
return;
}


if(parseFloat(document.frm.handFee.value) > parseFloat(document.frm.handFeeT.value)){
	rdShowMessageDialog("手续费不能大于"+document.frm.handFeeT.value);
	return;
}

document.frm.remain.value=document.frm.factPay.value-document.frm.handFee.value;
}
function submitCfm(){
	getAfterPrompt();
if(flag1==1){
	if(document.frm.remark.value.length==0){
		document.frm.remark.value= document.frm.chgStatusValue.value;
	}	
		
	if(!forReal(document.frm.handFee)){
			return;
		}
		if(parseFloat(document.frm.handFee.value) > parseFloat(document.frm.handFeeT.value)){
	rdShowMessageDialog("手续费不能大于"+document.frm.handFeeT.value);
	return;
}
		
		var creditI = 0;
		var newCredit = "";
	for(creditI = 0 ; creditI < document.frm.qryFlag.length ; creditI ++){
		if(document.frm.qryFlag.options[creditI].selected){
			newCredit = document.frm.qryFlag.options[creditI].value;
			
		}
	}
	var idJ = 0 ;
		var inputIdType = 0;
		for(idJ = 0 ; idJ < document.frm.asIdType.length ; idJ ++){
			if(document.frm.asIdType.options[idJ].selected==true){
				inputIdType = document.frm.asIdType.options[idJ].value;
			}
		}
	var expireTimeValue = "";
	if(document.frm.chgStatus.value=="N"){
		if(!forDate(document.frm.expireTime)){
		return;
		}
		if(document.frm.nowDate.value>=document.frm.expireTime.value){
		rdShowMessageDialog("有效期应该大于当前日期");
		return false;
		}
		expireTimeValue=document.frm.expireTime.value+" 00:00:00";
		
	}
		printCommit();
		if(printFlag!=1){
			return;
		}
		document.frm.submit.disabled=true;
		var myPacket = new AJAXPacket("f2307Cfm.jsp?asCustName="+document.frm.asCustName.value+"&asCustPhone="+document.frm.asCustPhone.value+"&asIdIccid="+document.frm.asIdIccid.value+"&asIdAddress="+document.frm.asIdAddress.value+"&asContractAddress="+document.frm.asContractAddress.value+"&asNotes="+document.frm.asNotes.value+"&sysRemark="+document.frm.sysRemark.value+"&remark="+document.frm.remark.value,"正在提交，请稍候......");
		
		myPacket.data.add("loginAccept",document.frm.loginAccept.value);
		myPacket.data.add("opCode",document.frm.opCode.value);
		myPacket.data.add("workNo",document.frm.workNo.value);
		myPacket.data.add("noPass",document.frm.noPass.value);
		myPacket.data.add("asIdType",inputIdType);
		myPacket.data.add("orgCode",document.frm.orgCode.value);
		myPacket.data.add("idNo",document.frm.userId.value);
		myPacket.data.add("oldCredit",document.frm.qryFlagT.value);
		
		myPacket.data.add("newCredit",document.all.qryFlag.value);
		//myPacket.data.add("newCredit",document.frm.chgStatus.value);
		myPacket.data.add("expireTime",expireTimeValue);
		myPacket.data.add("handFee",document.frm.handFeeT.value);
		myPacket.data.add("factPay",document.frm.handFee.value);

		//myPacket.data.add("ipAdd",document.frm.ipAdd.value);
		myPacket.data.add("chgStatus",document.frm.chgStatus.value);
		myPacket.data.add("phoneNo",document.frm.phoneNo.value);
		
    	core.ajax.sendPacket(myPacket);
			myPacket = null;
    	}else{
    	rdShowMessageDialog("请先查询用户信息！");
    	}
}
function verifyPass(){
	if(flag1==1){
		var m = document.frm.inputPass.value;
		var n = document.frm.customPass.value;
        	var myPacket = new AJAXPacket("verifyPass.jsp","正在提交，请稍候......");
		
		myPacket.data.add("inputPass",m);
		myPacket.data.add("customPass",n);
		
		
    	core.ajax.sendPacket(myPacket);

    	myPacket = null;
		
		
	}else{
    		rdShowMessageDialog("请先查询用户信息！");
	}

}
function getExpireTime(){
if(document.frm.chgStatus.value=="Y"){
	document.frm.qryFlag.disabled=false;
	document.frm.qryFlag.focus();
}else{
document.frm.qryFlag.disabled=true;
}
if(document.frm.chgStatus.value!="Y"){
	document.frm.expireTime.disabled=false;
	document.frm.timeFlag.value=1;
}else{
	document.frm.expireTime.disabled=true;
	document.frm.timeFlag.value=0;
}

}
function resett(){
document.frm.asCustName.value="";
document.frm.asCustPhone.value="";
document.frm.asIdType.options[0].selected=true;
document.frm.asIdIccid.value="";
document.frm.asIdAddress.value="";
document.frm.asContractAddress.value="";
document.frm.asNotes.value="";
document.frm.customPass.value="";
document.frm.inputPass.value="";
document.frm.userId.value="";
document.frm.runName.value="";
document.frm.gradeName.value="";
document.frm.idCardNo.value="";				
document.frm.totalPrepay.value="";				
document.frm.totalOwe.value="";
document.frm.custName.value="";

document.frm.qry.disabled=false;
document.frm.phoneNo.disabled=false;
document.frm.submit.disabled=true;
document.frm.custAddress.value="";

document.frm.cardType.value="";
printFlag=9;
timeFlag=0;
flag1=0;
}


function  modify()
{
    var a = parseInt(document.frm.rightCode.value,10) ;
    var b = parseInt(document.frm.qryFlag.value,10) ;
    if(a == "0" && b > "0")
	{
		rdShowMessageDialog("对不起！您只能修改成负值,请重新操作！");
		document.frm.qryFlag.value= "0";
		document.frm.qryFlag.focus();
		return false;
	}
}
</script>
<FORM action="" method=post name="frm"  onKeyUp="chgFocus(frm)">

<%@ include file="/npage/include/header.jsp" %>


	<div class="title">
		<div id="title_zi">动态信誉度申请/取消</div>
	</div>
        
        <table cellspacing="0">
        <tbody>
              <tr> 
            <td class="blue" width="10%" > 用户号码 </td>
            <td width="23%"  align=left>
              <input id=Text2 type=text size=17 name=phoneNo v_type="mobphone" maxlength=11 index="0" onKeyUp="if(event.keyCode==13)submitt()" value =<%=activePhone!=null?activePhone:ph_no%> readOnly  Class="InputGrey">
              <input  id=Text2 type=button size=17 name=qry value="查询" onclick="submitt()" class="b_text">
            </td>
            
            <td class="blue" width="10%">用户密码 </td>
            <td colspan="3"> 
            <jsp:include page="/npage/common/pwd_one1.jsp">
	      <jsp:param name="width1" value="16%"  />
	      <jsp:param name="width2" value="34%"  />
	      <jsp:param name="pname" value="inputPass"  />
	      <jsp:param name="pwd" value="12345"  />
 	   </jsp:include>
 	   
 	   <%if(favFlag==0){%>
            
            <input  id=Text2 type=button size=17 name=verifyPass1 value="验证密码" onclick="verifyPass()" class="b_text">
            
            <%}else{%>
            <input  id=Text2 type=button size=17 name=verifyPass1 value="验证密码" onclick="verifyPass()"  class="b_text">
            
            <%}%>
            
              </td>
          </tr>
          <tr > 
            <td width="10%"  class="blue">用户I D</td>
            <td align=left width="23%" > 
              <input  
            id=Text2 type=text size=17 name=userId Class="InputGrey" readOnly>
            </td>
            <td  width="10%" class="blue">当前状态</td>
            <td  width="19%"> 
              <input  type=text size=17 name=runName Class="InputGrey" readOnly>
            </td>
            <td  width="10%" class="blue">级别</td>
            <td  width="28%"> 
              <input  type=text size=17 name=gradeName Class="InputGrey" readOnly>
            </td>
          </tr>
              <tr> 
            <td width="10%"  class="blue"> 当前预存</td>
            <td align=left width="23%" > 
              <input  
            id=Text2 type=text size=17 name=totalPrepay Class="InputGrey" readOnly>
            </td>
            <td  width="10%" class="blue">当前欠费</td>
            <td  width="19%"> 
              <input  
            id=Text2 type=text size=17 name=totalOwe readOnly  Class="InputGrey">
            </td>
            <td  width="10%" class="blue">大客户标志</td>
            <td  width="28%"> 
              <input  type=text size=17 name=cardType readonly  Class="InputGrey">
            </td>
          </tr>
          <tr > 
            <td width="10%"  class="blue"> 客户名称</td>
            <td align=left width="23%" > 
              <input  id=Text2 type=text size=17 name=custName Class="InputGrey" readOnly> 
            </td>
            <td  width="10%" class="blue">当前信誉度</td>
            <td  width="19%"> 
            <input  type=text size=17 name="qryFlag" v_must=1 v_type="int" v_name="当前信誉度" onBlur="if(this.value!=''){if(checkElement('qryFlag')==false){return false;}};" onchange="modify()" Class="InputGrey" readOnly> 
	
            </td>
            <td  width="10%" class="blue">业务类型</td>
            <td  width="28%"> 
              <input  type=text size=17 name=chgStatusValue readonly  Class="InputGrey">
              <input type=hidden name=chgStatus value="">
            </td>
          </tr>
             <tr> 
            <td width="10%" style="display:none" class="blue"> 担保人名称</td>
            <td align=left width="23%" style="display:none"> 
              <input  id=Text2 type=text size=17 name=asCustName maxlength=20 onkeyup="value=value.replace(/[@#$%!^&*()<>?|]/g,'');">
            </td>
            <td  width="10%" style="display:none" class="blue">担保人联系电话</td>
            <td  width="19%" style="display:none"> 
              <input  id=Text2 type=text size=17 name=asCustPhone maxlength=20  >
            </td>
            <td  width="14%" class="blue">有效期</td>
            <td  width="21%" colspan=5> 
              <input  type=text size=17 name=expireTime index="3" v_format="yyyyMMdd">
              <input  id=Text2 type=hidden size=17 name=asContractAddress  maxlength=20 onkeyup="value=value.replace(/[@#$%!^&*()<>?|]/g,'');">
            </td>
          </tr>
          <tr style="display:none"> 
            <td width="20%"  class="blue"> 担保人证件类型</td>
            <td align=left width="23%" > 
              <select size=1 name=asIdType  >
              <%for(int i = 0 ; i < sIdTypeStr[0].length ; i ++){%>
              <option value="<%=sIdTypeStr[0][i]%>"><%=sIdTypeStr[0][i]%></option>
              <%}%>
              </select>
            </td>
            <td  width="20%" class="blue">证件号码</td>
            <td  width="19%"> 
              <input  id=Text2 type=text size=17 name=asIdIccid  maxlength=20>
            </td>
            <td  width="24%" class="blue">证件地址</td>
            <td  width="19%" colspan=2> 
              <input  id=Text2 type=text size=17 name=asIdAddress  maxlength=20 onkeyup="value=value.replace(/[@#$%!^&*()<>?|]/g,'');" size="38">
            </td>
          </tr>
          <tr  style="display:none"> 
            <td width="10%"  class="blue"> 担保备注</td>
            <td align=left width="23%" > 
              <input  id=Text2a type=text size=30 name=asNotes1  maxlength=30 onkeyup="value=value.replace(/[@#$%!^&*()<>?|]/g,'');">
            </td>
          </tr>
          </TBODY> 
        </TABLE>
		 <!--HR SIZE=1 width="100%"-->
        <TABLE cellSpacing="0" style="display:none">
          <TBODY> 
          <tr > 
            <td width="10%"  class="blue">手续费</td>
            <td align=left width="23%" > 
              <input  id=Text2 type=text size=17 index="4" name=handFee <%if(feeFlag==0){%>readOnly<%}%> value="<%=tHandFee%>" v_type=float v_name="手续费">
            </td>
            <td  width="10%" class="blue">实收</td>
            <td  width="19%" > 
              <input  id=Text2 type=text size=17 name=factPay index="5" onKeyUp="if(event.keyCode==13){getRemain()}" Class="InputGrey" readOnly> &nbsp;
              <input  id=Text2 type=button size=17 name=getUseInfo value="-->" onclick="getRemain()" class="b_text">
            </td>
            <td  width="10%" class="blue">找零</td>
            <td  width="28%">
              <input  id=Text2 type=text size=17 name=remain Class="InputGrey" readOnly> 
            </td>
          </tr>
          </TBODY> 
        </TABLE>
        <table cellspacing="0">
 
         <tr>
            <td  class="blue">备注
            	<input  id=Text2 type="hidden" size=60 name=asNotes  maxlength=30 index="5" onkeyup="value=value.replace(/[@#$%!^&*()<>?|]/g,'');" >
			<input  id=Text3 type=text size=60 name=remark value=""  onkeyup="value=value.replace(/[@#$%!^&*()<>?|]/g,'');" Class="InputGrey" readOnly></td>
          </tr>
		   
        </table>
        <TABLE cellSpacing="0">
          <TBODY>
            <TR >
              <TD align=middle id="footer"><input  name=submit  index="7" type=button value="确认" onclick="submitCfm()" onKeyUp="if(event.keyCode==13){submitCfm()}"  class="b_foot">
               &nbsp;&nbsp; 
              <input  name=back  type=button value="清除" onclick="resett()" class="b_foot">
              &nbsp;&nbsp; 
              <input  name=back  type=button value="关闭"  onClick="removeCurrentTab()" class="b_foot">
             
              
              
            </TD>
            </TR>
          </TBODY>
        </TABLE></td>

<input type=hidden name=opCode value="2307">


<input type=hidden name=workNo value=<%=workNo%>>
<input type=hidden name=noPass value=<%=nopass%>>
<input type=hidden name=rightCode value=<%=rightCode%>>
<input type=hidden name=orgCode value=<%=orgCode%>>
<input type=hidden name=sysRemark value="用户信誉度修改">
<input type=hidden name=ipAdd value="<%=request.getRemoteAddr()%>">
<input type=hidden name=handFeeT value="<%=tHandFee%>">
<input type=hidden name=qryFlagT value="">
<input type=hidden name=newCredit value="">
<input type=hidden name=oldCredit value="">
<input type=hidden name=customPass>
<input type=hidden name=idCardNo>
<input type=hidden name=custAddress>
<input type=hidden name=backLoginAccept>
<input type=hidden name=timeFlag value="0">
<input type=hidden name=favFlag value="<%=favFlag%>">
<input type=hidden name=nowDate value="<%=new java.text.SimpleDateFormat("yyyy", Locale.getDefault()).format(new java.util.Date())%><%=new java.text.SimpleDateFormat("MM", Locale.getDefault()).format(new java.util.Date())%><%=new java.text.SimpleDateFormat("dd", Locale.getDefault()).format(new java.util.Date())%>">
<input type="hidden" name="loginAccept" value="<%=sysAcceptl%>">
<input type="hidden" name="smName" value="">
<%@ include file="../../include/remark.htm" %>
 <%@ include file="/npage/include/footer.jsp" %>   
</FORM>
</td></tr></table>
<script>

function printCommit()
{          
	// in here form check
	showPrtDlg("Detail","确实要进行电子免填单打印吗？","Yes");  	 
}

function showPrtDlg(printType,DlgMessage,submitCfn)
{  
   document.all.sysRemark.value="用户"+document.all.phoneNo.value+document.all.chgStatusValue.value;
   if((document.all.asNotes.value).trim().length==0)
   {
	  document.all.asNotes.value="操作员<%=workName%>"+"对用户"+document.all.phoneNo.value+"进行" + document.all.chgStatusValue.value;
   }	
	
   //显示打印对话框 
   var h=210;
   var w=400;
   var t=screen.availHeight/2-h/2;
   var l=screen.availWidth/2-w/2;

   var printStr = printInfo(printType);

    var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no" 
     
     
     var pType="subprint";                     // 打印类型print 打印 subprint 合并打印
     var billType="1";                      //  票价类型1电子免填单、2发票、3收据
     var sysAccept =<%=sysAcceptl%>;                       // 流水号
     var printStr = printInfo(printType);   //调用printinfo()返回的打印内容
     var mode_code=null;                        //资费代码
     var fav_code=null;                         //特服代码
     var area_code=null;                        //小区代码
     var opCode =   "<%=opCode%>";                         //操作代码
     var phoneNo = <%=activePhone%>;                            //客户电话
     
    var path = "<%=request.getContextPath()%>/npage/innet/hljBillPrint_jc_hw.jsp?DlgMsg=" + DlgMessage+ "&submitCfm=" + submitCfn;
	var path=path+"&mode_code="+mode_code+"&fav_code="+fav_code+"&area_code="+area_code+"&opCode=<%=opCode%>&sysAccept="+sysAccept+"&phoneNo="+document.all.phoneNo.value+"&submitCfm="+submitCfn+"&pType="+pType+"&billType="+billType+ "&printInfo=" + printStr;

	var ret=window.showModalDialog(path,printStr,prop);   
     
   if(typeof(ret)!="undefined")
   {
	ret="confirm";
     if((ret=="confirm")&&(submitCfn == "Yes"))
     {

       if(rdShowConfirmDialog('确认要进行此项服务吗？')==1)
       {
       	printFlag=1;
       }
     }
   }
}

function printInfo(printType)
{
  	var retInfo = "";
	var note_info1 = "";
	var note_info2 = "";
	var note_info3 = "";
	var note_info4 = "";
	var opr_info = "";
	var cust_info = "";
		

    if(printType == "Detail")
    {
      cust_info+="客户姓名：" +document.all.custName.value+"|";
      cust_info+="手机号码："+document.all.phoneNo.value+"|";
      cust_info+="客户地址："+document.all.custAddress.value+"|";
      cust_info+="证件号码："+document.all.idCardNo.value+"|";

      opr_info+="用户品牌："+document.frm.smName.value+"  办理业务："+document.all.chgStatusValue.value+"|";
      opr_info+="操作流水："+document.all.loginAccept.value+"  生效时间："+'<%=new java.text.SimpleDateFormat("yyyyMMdd ", Locale.getDefault()).format(new java.util.Date())%>'+"|";
    }  
    if(printType == "Bill")
    {	//打印发票
    }
    
    note_info1+="备注："+"|";
    
    retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
    retInfo=retInfo.replace(new RegExp("#","gm"),"%23"); //把“#"替换为url格式

    return retInfo;	
}
</script>
<script>
function printBill(){
	  var infoStr="";  
      retInfo+="客户名称：" +document.all.custName.value+"|";
      retInfo+="手机号码："+document.all.phoneNo.value+"|";
      retInfo+="客户地址："+document.all.custAddress.value+"|";
      retInfo+="现金："+document.all.handFee.value+"|";
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
      retInfo+=" "+"|";
      retInfo+=document.all.chgStatusValue.value +" *手续费："+document.frm.handFee.value+"*流水号："+document.frm.backLoginAccept.value+"|";
      retInfo+=" "+"|";
      retInfo+=" "+"|";
      retInfo+=" "+"|";
      retInfo+=" "+"|";
      retInfo+=" "+"|";
      retInfo+=" "+"|";
      retInfo+=" "+"|";
      retInfo+=document.all.sysRemark.value+"|";
      retInfo+=document.all.remark.value+"|"; 
	location.href="<%=request.getContextPath()%>/npage/innet/hljPrint.jsp?retInfo="+infoStr+"&dirtPage=f2307.jsp";  
                  
}
</script>
</BODY>
<%@ include file="/npage/public/hwObject.jsp" %> 
</HTML>

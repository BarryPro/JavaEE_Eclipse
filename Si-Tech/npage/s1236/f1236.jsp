<%
/********************
 version v2.0
开发商: si-tech
********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//Dtd XHTML 1.0 transitional//EN" "http://www.w3.org/tr/xhtml1/Dtd/xhtml1-transitional.dtd">
<%@ page contentType= "text/html;charset=gb2312" %>
<%@ include file="/npage/include/public_title_name.jsp" %>

<%
	String opCode = request.getParameter("opCode");
	String opName = request.getParameter("opName");
	String activePhone1=request.getParameter("activePhone1");
	
	String workNo = (String)session.getAttribute("workNo");
	String nopass = (String)session.getAttribute("password");
	String workName = (String)session.getAttribute("workName");
	String org_codeT = (String)session.getAttribute("orgCode");
	String region_codeT = org_codeT.substring(0,2);
	String[][]  favInfo = (String[][])session.getAttribute("favInfo");

	int favFlag = 0 ;
	
	//2011/6/23 wanghfa添加 对密码权限整改 start
  boolean pwrf=false;
	String pubOpCode = opCode;
	String pubWorkNo = workNo;
%>
	<%@ include file="/npage/public/pubCheckPwdPower.jsp" %>
<%
	System.out.println("====wanghfa====f1236.jsp==== pwrf = " + pwrf);
	if (pwrf) {
		favFlag = 1;
	}
	//2011/6/23 wanghfa添加 对密码权限整改 end


String paraStr[]=new String[1];
%>
<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="region" routerValue="<%=region_codeT%>"  id="seq"/>
<%
paraStr[0] = seq;
System.out.println("11111111111：" +paraStr[0]);

//ArrayList arr = F1236Wrapper.getFuncFee(region_codeT);
//String[][] fee = (String[][])arr.get(0);   
StringBuffer sq1 = new StringBuffer();
sq1.append("select function_code,hand_fee,favour_code");
sq1.append("  from sNewFunctionFee ");
sq1.append(" where region_code=?");
sq1.append(" and function_code='1236'");
String sqlparam = region_codeT;
System.out.println(sq1.toString());
%>
<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=region_codeT%>" outnum="2">
	<wtc:sql><%=sq1.toString()%></wtc:sql>
	<wtc:param value="<%=sqlparam%>"/> 
</wtc:pubselect>
<wtc:array id="fee" scope="end" />
<%
System.out.println(fee.length);
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

%>
<html xmlns="http://www.w3.org/1999/xhtml"><head>
<title><%=opName%></title>
<!--
<META content=no-cache http-equiv=Pragma>
<META content=no-cache http-equiv=Cache-Control>
-->

<META content="MSHTML 5.00.3315.2870" name=GENERATOR>
<%@ include file="../../npage/common/pwd_comm.jsp" %>

</HEAD>
<script language="javascript">
var printFlag=9;
var flag = 0;
onload=function(){
	if("<%=activePhone1%>"==""||"<%=activePhone1%>"=="null"){
		removeCurrentTab();
	}
	//document.frm.submit.disabled=true;/*申告：佳木斯详单密码变更问题 @2012/7/26 */
	self.status="";
	var op_code=$("input[@name=qryPwdFlag][@checked]").val();
	beforePrompt(op_code); 
}

 function sel1() {
            document.all.opCode.value = "122a";
			document.all.oldPasswd.value="";
		    document.all.passwd2.value = "";
		    document.all.passwd1.value="";
			document.all.oldPasswd.readOnly = true;
			beforePrompt("122a");
 }
 
 function sel2() {
           document.all.opCode.value = "122b";
		   document.all.oldPasswd.value="";
		   document.all.passwd2.value = "";
		   document.all.passwd1.value="";
		   document.all.oldPasswd.readOnly = false;
		   document.all.passwd2.readOnly = false;
		   document.all.passwd1.readOnly = false;
		   beforePrompt("122b"); 
}
 
 function sel3() {
           document.all.opCode.value = "122c";
		   document.all.oldPasswd.value="";
		   document.all.passwd2.value = "";
		   document.all.passwd1.value="";
		   document.all.oldPasswd.readOnly = true;
		   document.all.passwd2.readOnly = false;
		   document.all.passwd1.readOnly = false;
		   beforePrompt("122c"); 
 }
 
 function sel4() {
           document.all.opCode.value = "122d";
		   document.all.oldPasswd.value="";
		   document.all.passwd2.value = "";
		   document.all.passwd1.value="";
		   document.all.oldPasswd.readOnly = true;
		   document.all.passwd2.readOnly = true;
		   document.all.passwd1.readOnly = true;
		   beforePrompt("122d"); 
 }
 function beforePrompt(op_code){
	var packet = new AJAXPacket("/npage/include/getBeforePrompt.jsp","请稍后...");
	packet.data.add("opCode" ,op_code);
	core.ajax.sendPacketHtml(packet,doGetBeforePrompt,true);//异步
	packet =null;
}
function doGetBeforePrompt(data)
{
	$('#wait').hide();
	$('#beforePrompt').html(data);
}
function getAfterPrompt(op_code)
{
	var packet = new AJAXPacket("/npage/include/getAfterPrompt.jsp","请稍后...");
	packet.data.add("opCode" ,op_code);
    core.ajax.sendPacket(packet,doGetAfterPrompt,false);//同步
	packet =null;
}

function doGetAfterPrompt(packet)
{
	var retCode = packet.data.findValueByName("retCode"); 
	var retMsg = packet.data.findValueByName("retMsg"); 
	if(retCode=="000000"){
		promtFrame(retMsg);
	}
}
function doProcess(packet){
	
	var backString = packet.data.findValueByName("backString");
	var cfmFlag = packet.data.findValueByName("flag");

	if(cfmFlag==99){
		if(backString==1){
			rdShowMessageDialog("验证成功！",2);
			document.frm.submit.disabled=false;
		}else{
			rdShowMessageDialog("密码不正确！");
			//document.frm.submit.disabled=true;
		}
	}
	if(cfmFlag==1){
			var errCode = packet.data.findValueByName("errCode");
			var errMsg = packet.data.findValueByName("errMsg");
		
			var errCodeInt = parseInt(errCode);

			if(errCodeInt==0){
				rdShowMessageDialog("操作成功！",2);
				document.location="f1236.jsp?activePhone1="+document.all.phoneNo.value+"&opCode=<%=opCode%>&opName=<%=opName%>";
				document.frm.passwd2.value="";
				document.frm.passwd1.value="";
				document.frm.backLoginAccept.value=backString[0][0];
				
			
			if(document.frm.handFee.value!=0){
				printBill();
			}
			document.frm.phoneNo.value="";
			document.frm.customPass.value="";
			document.frm.userId.value="";
			document.frm.runName.value="";
			document.frm.gradeName.value="";
			document.frm.totalPrepay.value="";
			document.frm.totalOwe.value="";
			document.frm.custName.value="";
			document.frm.factPay.value="";
			document.frm.remain.value="";
			document.frm.remark.value="";
			document.frm.qryFlag.value="";
			document.frm.cardType.value="";
			document.frm.idCardNo.value="";
			document.frm.custAddress.value="";
			document.frm.asCustName.value="";
				document.frm.asCustPhone.value="";
				document.frm.asIdType.options[0].selected=true;
				document.frm.asIdIccid.value="";
				document.frm.asIdAddress.value="";
				document.frm.asContractAddress.value="";
				document.frm.asNotes.value="";

			flag=0;
			resett();
			}else{
				/**
				rdShowMessageDialog(errCode + ":" + errMsg);
				document.frm.passwd2.value="";
				document.frm.passwd1.value="";
				resett();
				return;
				**/
				retMessage = errMsg + "[errCode:" + errCode + "]";
    			rdShowMessageDialog(retMessage,0); 
				location = "f1236.jsp?activePhone1="+document.all.phoneNo.value+"&opCode=<%=opCode%>&opName=<%=opName%>";               		
				return false;
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
				flag=0;
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
	document.frm.smName.value=backString[0][2];
	document.frm.userId.value=backString[0][0];
	document.frm.runName.value=backString[0][6];
	document.frm.cardType.value=backString[0][15];
	document.frm.gradeName.value=backString[0][8];
	document.frm.custAddress.value=backString[0][11];
	document.frm.idCardNo.value=backString[0][14];
	document.frm.totalPrepay.value=backString[0][17];
	document.frm.totalOwe.value=backString[0][16];
	document.frm.custName.value=backString[0][3];
	
	document.frm.asCustName.value=backString[0][23];
		document.frm.asCustPhone.value=backString[0][24];
		
		
		var idI = 0 ;
		for(idI = 0 ; idI < document.frm.asIdType.length ; idI ++){
			
			if(document.frm.asIdType.options[idI].value==backString[0][25]){
				document.frm.asIdType.options[idI].selected=true;
			}
		}
		document.frm.asIdIccid.value=backString[0][26];
		document.frm.asIdAddress.value=backString[0][27];
		document.frm.asContractAddress.value=backString[0][28];
		document.frm.asNotes.value=backString[0][29];
		
		document.frm.pwdFlag.value=backString[0][30];
		//alert("document.frm.pwdFlag.value="+document.frm.pwdFlag.value);
	   
	
	
	
	if(backString[0][21]==""){
		document.frm.qryFlag.value="详单可查询状态";
		document.frm.qryFlagT.value="N";
	}
	if(backString[0][21]=="N"){
		document.frm.qryFlag.value="详单不可查询状态";
		document.frm.qryFlagT.value="Y";
	}
	if(backString[0][21]=="Y"){
		document.frm.qryFlag.value="详单可查询状态";
		document.frm.qryFlagT.value="N";
	}
	
	if(document.all.opCode.value == "122a" && document.frm.pwdFlag.value=="Y")
	{
		rdShowMessageDialog("该已经申请了二次密码！");
		
	}
	else if(document.all.opCode.value != "122a")
	{
		//alert(document.frm.pwdFlag.value);
		if(document.frm.pwdFlag.value=="N")
		{
			rdShowMessageDialog("该用户没有申请二次密码！");
			 location = "f1236.jsp?activePhone1="+document.all.phoneNo.value+"&opCode=<%=opCode%>&opName=<%=opName%>";
		}
	}
	
	
	flag=1;
	document.frm.handFee.disabled=false;
	document.frm.factPay.disabled=false;
	
	}
}
	
}
function submitt(){
	
	if(!check())
	{
		return;
	}

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
		myPacket=null;
		
}
function getRemain(){

if(flag!=1){
rdShowMessageDialog("请先查询用户信息！",0);
return;
}


if(parseFloat(document.frm.handFee.value) > parseFloat(document.frm.handFeeT.value)){
	rdShowMessageDialog("手续费不能大于"+document.frm.handFeeT.value,0);
	return;
}

document.frm.remain.value=document.frm.factPay.value-document.frm.handFee.value;
}
function submitCfm(){
var op_code=$("input[@name=qryPwdFlag][@checked]").val();
getAfterPrompt(op_code);
	//2012/2/8 wanghfa添加
	if ($("#custName").val() == "") {
		rdShowMessageDialog("提交前请先进行查询！", 1);
		return false;
	}
/* 密码检查 */
if(document.all.opCode.value == "122c" || document.all.opCode.value == "122a")
{   
	if(document.all.passwd2.value==""){ 
		 rdShowMessageDialog("密码不能为空！请输入",0);
		 return false;
	}
	if(document.all.passwd1.value==""){ 
		rdShowMessageDialog("密码不能为空！请输入",0); 
		return false;
  }
	if(document.all.passwd2.value != document.all.passwd1.value)
	{
		rdShowMessageDialog("新密码和确认密码不一致！请重新输入",0);
		document.all.passwd2.value = "";
		document.all.passwd1.value = "";
		//document.all.passwd2.focus();
		return false;
	}
}
if(document.all.opCode.value == "122b")
{
	if(document.all.oldPasswd.value==""){
		 rdShowMessageDialog("旧密码不能为空！请输入",0);
		 return false;
		};
	if(document.all.passwd2.value==""){ 
		 rdShowMessageDialog("密码不能为空！请输入",0);
		 return false;
	}
	if(document.all.passwd1.value==""){ 
		rdShowMessageDialog("密码不能为空！请输入",0); 
		return false;
  }
	if(document.all.passwd2.value != document.all.passwd1.value)
	{
		rdShowMessageDialog("新密码和确认密码不一致！请重新输入",0);
		document.all.passwd2.value = "";
		document.all.passwd1.value = "";
		//document.all.passwd2.focus();
		return false;
	}
}
//if(flag==1){ modify huy 20050721


	if(document.frm.remark.value.length==0){
		document.frm.remark.value="详单二次密码设置";
	}	

	var idJ = 0 ;
		var inputIdType = 0;
		for(idJ = 0 ; idJ < document.frm.asIdType.length ; idJ ++){
			if(document.frm.asIdType.options[idJ].selected==true){
				inputIdType = document.frm.asIdType.options[idJ].value;
			}
		}
	if(!forReal(document.frm.handFee)){
			return;
		}
		
		
		if(parseFloat(document.frm.handFee.value) > parseFloat(document.frm.handFeeT.value)){
	rdShowMessageDialog("手续费不能大于"+document.frm.handFeeT.value,0);
	return;
}
		printCommit();
		if(printFlag!=1){
			return;
		}
		document.frm.submit.disabled=true;
		
		var myPacket = new AJAXPacket("f1236Cfm.jsp?asCustName="+document.frm.asCustName.value+"&asCustPhone="+document.frm.asCustPhone.value+"&asIdIccid="+document.frm.asIdIccid.value+"&asIdAddress="+document.frm.asIdAddress.value+"&asContractAddress="+document.frm.asContractAddress.value+"&asNotes="+document.frm.asNotes.value+"&sysRemark="+document.frm.sysRemark.value+"&remark="+document.frm.remark.value+"&qryNote=","正在提交，请稍候......");

		myPacket.data.add("loginAccept",document.frm.loginAccept.value);

		myPacket.data.add("opCode",document.all.opCode.value);
		myPacket.data.add("workNo",document.frm.workNo.value);
		myPacket.data.add("asIdType",inputIdType);
		myPacket.data.add("noPass",document.frm.noPass.value);
		myPacket.data.add("passwd",document.frm.passwd2.value);
		myPacket.data.add("orgCode",document.frm.orgCode.value);
		myPacket.data.add("idNo",document.frm.userId.value);
		myPacket.data.add("handFee",document.frm.handFeeT.value);
		myPacket.data.add("factPay",document.frm.handFee.value);
		myPacket.data.add("ipAdd",document.frm.ipAdd.value);
		myPacket.data.add("qryFlag",document.frm.qryFlagT.value);
		myPacket.data.add("activePhone",document.frm.phoneNo.value);
		
  	
    	core.ajax.sendPacket(myPacket);
    	myPacket=null;
		/** modify huy 20050721
    	}else
    	{

    	rdShowMessageDialog("请先查询用户信息！");
    	}
		**/
}
function verifyPass(){
	if(flag==1){
		var m = document.frm.inputPass.value;
		var n = document.frm.customPass.value;
    var myPacket = new AJAXPacket("verifyPass.jsp","正在提交，请稍候......");
		
		myPacket.data.add("inputPass",m);
		myPacket.data.add("customPass",n);
    core.ajax.sendPacket(myPacket);
    myPacket=null;
	}else{
    		rdShowMessageDialog("请先查询用户信息！",0);
	}

}
function resett(){
document.frm.customPass.value="";
//document.frm.inputPass.value="";
document.frm.userId.value="";
document.frm.runName.value="";
document.frm.gradeName.value="";
document.frm.idCardNo.value="";				
document.frm.totalPrepay.value="";				
document.frm.totalOwe.value="";
document.frm.custName.value="";
document.frm.qryFlag.value="";
document.frm.qry.disabled=false;
document.frm.phoneNo.disabled=false;
document.frm.submit.disabled=true;
document.frm.custAddress.value="";
document.frm.asCustName.value="";
document.frm.asCustPhone.value="";
document.frm.asIdType.options[0].selected=true;
document.frm.asIdIccid.value="";
document.frm.asIdAddress.value="";
document.frm.asContractAddress.value="";
document.frm.asNotes.value="";
document.frm.cardType.value="";
printFlag=9;

flag=0;
}





function turnit(exp)
{

	 if (exp.style.display=="none" && document.frm.qryPwdFlag.value =="122d")
	  {
	   exp.style.display="";
	  }
	  
	 else
	  {
	  
	  exp.style.display="none";
	   }

}

function check()
{
	if(document.frm.passwd2.value != document.frm.passwd1.value)
	{
	rdShowMessageDialog("密码不一致,请重新操作！");
	document.frm.passwd2.value="";
	document.frm.passwd1.value="";
	//document.frm.passwd2.focus();
	return false;
	}
	return true;
}


</script>
<body>
<form action="" method=post name="frm" onKeyUp="chgFocus(frm)">
<%@ include file="/npage/include/header.jsp" %>
<div class="title">
	<div id="title_zi">请选择操作类型</div>
</div>
	    <table  cellspacing="0">
	      <tbody>
	       <tr > 
	        <td width="10%" class="blue">操作类型</td>
	        <td colspan="5">
	        	<input name="qryPwdFlag" type="radio" value="122a"  onClick="sel1()" checked/>
	          申请 
						<input type="radio" name="qryPwdFlag" onClick="sel2()" value="122b"/>
	          修改
	          <input type="radio" name="qryPwdFlag" onClick="sel3()" value="122c"/>
	          重置
	          <input type="radio" name="qryPwdFlag" onClick="sel4()" value="122d"/>
	          取消
	        </td>
	      </tr>
	
	      <tr> 
	        <td class="blue"> 服务号码</td>
	        <td align=left> 
	          <input class=button id=Text2 type=text size=17 name=phoneNo v_type="mobphone" v_name="移动号码" maxlength=11 index="0" onKeyUp="if(event.keyCode==13)submitt()" value="<%=activePhone1%>" readonly/>
	          <input class=b_text id=Text2 type=button size=17 name=qry value="查询" onclick="submitt()"  >
	        </td>
	       <td  colspan="4">&nbsp;</td>
                </tr>
                <tr> 
                  <td class="blue">用户名称</td>
                  <td align=left> 
                    <input Class="InputGrey" id=Text2 type=text size=17 name=custName  readonly>
                  </td>
                  <td class="blue">当前状态</td>
                  <td> 
                    <input Class="InputGrey" type=text size=17 name=runName  readonly>
                  </td>
                  <td class="blue">级别</td>
                  <td> 
                    <input Class="InputGrey" type=text size=17 name=gradeName  readonly>
                  </td>
                </tr>
                <tr> 
                  <td class="blue">当前预存</td>
                  <td align=left > 
                    <input Class="InputGrey" id=Text2 type=text size=17 name=totalPrepay  readonly>
                  </td>
                  <td class="blue">当前欠费</td>
                  <td> 
                    <input Class="InputGrey" id=Text2 type=text size=17 name=totalOwe readonly>
                  </td>
                  <td class="blue">大客户标志</td>
                  <td> 
                    <input Class="InputGrey" type=text size=17 name=cardType  readonly>
                  </td>
                </tr>
                    <input class=button  type=hidden size=17 name=userId disabled >                 
                    <input class=button  type=hidden size=17 name=qryFlag disabled >
           </table>
        </div>
		<div id="Operation_Table"> 
		<div class="title">
			<div id="title_zi">业务办理</div>
		</div>  
           <table cellspacing="0">
                <tr id=better> 
				         <td class="blue" width="10%"> 原密码</td>
                <td align=left width="23%"> 
                	<jsp:include page="/npage/common/pwd_one.jsp">
							      <jsp:param name="width1" value="16%"  />
							      <jsp:param name="width2" value="34%"  />
							      <jsp:param name="pname" value="oldPasswd"  />
							      <jsp:param name="pwd" value="12345"  />
					 	   		</jsp:include>
                  <!--  <input class=button  id=Text2 type="password" v_type="0_9" v_name="原密码"  size=17 name="oldPasswd"  v_must=1 maxlength="8" index="2"  readonly >-->
                 </td> 
            	<td class="blue" width="10%">新密码</td>
            	<td width="23%">
            	<jsp:include page="/npage/common/pwd_one.jsp">
					      <jsp:param name="width1" value="16%"  />
					      <jsp:param name="width2" value="34%"  />
					      <jsp:param name="pname" value="passwd2"  />
					      <jsp:param name="pwd" value="12345"  />
			 	   		</jsp:include>
				   <!--<input class="button" id=text3  type="password" v_type="0_9" v_name="新密码"  name="passwd2" size="17" v_must=1 maxlength="8"  >-->
				   </td>
            	<td class="blue" width="10%">确认密码</td>
            	<td>
            	<jsp:include page="/npage/common/pwd_one.jsp">
					      <jsp:param name="width1" value="16%"  />
					      <jsp:param name="width2" value="34%"  />
					      <jsp:param name="pname" value="passwd1"  />
					      <jsp:param name="pwd" value="12345"  />
			 	   		</jsp:include>
            	<!--	<input id=text4 class="button" type="password"  v_type="0_9" v_name="确认密码" name="passwd1" size="17" v_must=1 maxlength="8" onChange="check()"  >  -->
            	</td>                   
                </tr>
                 <tr style="DISPLAY: none"> 
            
            <td class="blue"> 担保人名称</td>
            <td align=left > 
              <input class=button id=Text2 type=text size=17 name=asCustName maxlength=20 onkeyup="value=value.replace(/[@#$%!^&*()<>?|]/g,'');">
            </td>
            
            
            <td class="blue">担保人联系电话</td>
            <td > 3
              <input class=button id=Text2 type=text size=17 name=asCustPhone  v_maxlength=20 v_type=phone  v_name="担保人联系电话">
            </td>
            <td class="blue">联系地址</td>
            <td colspan=2> 
              
              <input class=button 
            id=Text2 type=text size=17 name=asContractAddress  maxlength=20 onkeyup="value=value.replace(/[@#$%!^&*()<>?|]/g,'');">
            
            </td>
          </tr>
          <tr style="DISPLAY: none"> 
           
           <td class="blue"> 担保人证件类型</td>
           <td align=left >
             <select size=1 name=asIdType  >
				       <wtc:qoption name="sPubSelect" outnum="2">
				          <wtc:sql>select id_type,id_name from sidtype</wtc:sql>
				       </wtc:qoption>
             </select>
           </td>
           <td class="blue">证件号码</td>
           <td> 
             <input class=button id=Text2 type=text size=17 name=asIdIccid  maxlength=20>
           </td>
            <td class="blue">证件地址</td>
            <td colspan=2> 
              
              <input class=button 
            id=Text2 type=text size=17 name=asIdAddress  maxlength=20 onkeyup="value=value.replace(/[@#$%!^&*()<>?|]/g,'');">
            
            </td>
          </tr>
          
          <tr style="display:none"> 
            
            <td class="blue">担保备注</td>
            <td align=left > 
              <input class=button 
            id=Text2a type=text size=30 name=asNotes1  maxlength=30 onkeyup="value=value.replace(/[@#$%!^&*()<>?|]/g,'');">
            </td>
            <td colspan="4">&nbsp;</td>
          </tr>
           </tbody> 
       </table>
        <table  cellSpacing="0">
          <tbody> 
          <tr> 
            <td width="10%" class="blue">手续费</td>
            <td align=left width="23%" > 
              <input class=button 
            id=Text2 type=text size=17 name=handFee <%if(feeFlag==0){%>disabled<%}%> value="<%=tHandFee%>" v_type=float v_name="手续费" index="3">
            </td>
            <td  width="10%" class="blue">实收</td>
            <td  width="23%" > 
              <input class=button id=Text2 type=text size=17 name=factPay disabled index="4" onKeyUp="if(event.keyCode==13){getRemain()}">&nbsp;
              <input class=b_text id=Text2 type=button size=17 name=getUseInfo value="-->" onclick="getRemain()"  >
            </td>
            <td  width="10%" class="blue">找零</td>
            <td>
              <input class=button id=Text2 type=text size=17 name=remain disabled >
            </td>
          </tr>
          </tbody> 
        </table>
        <table cellspacing="0" >
          <tr style="display:none">
            <td class="blue">用户备注</td>
            <td><input class=button id=Text3 type=text size=60 name=remark value=""  onkeyup="value=value.replace(/[@#$%!^&*()<>?|]/g,'');" readonly></td>
          </tr>
          <tr style="display:none">
          <td class="blue" width="10%">说明</td>
          <td>1、如用户申请“详单禁查”业务，则原“详单查询二次密码”失效；<br>&nbsp;2、如用户申请“详单查询二次密码”，则系统会默认用户取消“详单禁查”业务。 </td>
		  </tr>
		  <!--根据用户要求,手工输入的备注隐藏与系统备注相同即可-->
		  <tr style="display:none"> 
		   <td class="blue">用户备注
       </td>
       <td>
       	<input id=Text2 type=text size=60 name=asNotes  maxlength=30 index="5" onkeyup="value=value.replace(/[@#$%!^&*()<>?|]/g,'');">
      </td>
		</tr>
     </table>
<!-- ningtn 2011-7-12 08:33:59 扩大电子工单 -->
<jsp:include page="/npage/public/hwReadCustCard.jsp">
	<jsp:param name="hwAccept" value="<%=paraStr[0]%>"  />
	<jsp:param name="showBody" value="01"  />
</jsp:include>
        <table  cellSpacing="0">
            <tr>
              <td align=middle id="footer">
              <input class="b_foot" name=submit  type=button value="确认" onclick="submitCfm()" onKeyUp="if(event.keyCode==13){submitCfm()}" index="6">
              <input class="b_foot" name=back  type=button value="清除" onclick="resett()">
              <input class="b_foot" name=back  type=button value="关闭" onclick="removeCurrentTab()">
            </td>
            </tr>
        </table>
<input type=hidden name=loginAccept value="<%=paraStr[0]%>">
<input type=hidden name=opCode value="122a">
<input type=hidden name=workNo value=<%=workNo%>>
<input type=hidden name=noPass value=<%=nopass%>>
<input type=hidden name=orgCode value=<%=org_codeT%>>
<input type=hidden name=sysRemark value="详单禁查申请变更">
<input type=hidden name=ipAdd value="<%=request.getRemoteAddr()%>">
<input type=hidden name=handFeeT value="<%=tHandFee%>">
<input type=hidden name=qryFlagT>
<input type=hidden name=customPass>
<input type=hidden name=custName11>
<input type=hidden name=idCardNo>
<input type=hidden name=custAddress>
<input type=hidden name=backLoginAccept>
<input type=hidden name=pwdFlag>
<input type=hidden name=smName value="">
<input type=hidden name=favFlag value="<%=favFlag%>">
<input type=hidden name="activePhone" value="<%=activePhone1%>">
<div id="relationArea" style="display:none"></div>
	<div id="wait" style="display:none">
	<img  src="/nresources/default/images/blue-loading.gif" />
 </div>
<div id="beforePrompt"></div>   
<%@ include file="../../include/remark.htm" %> 
<%@ include file="/npage/include/footer_simple.jsp" %> 
</FORM>
</td></tr></table>
<script>

function printCommit()
{          
	// in here form check
	showPrtDlg("Detail","确实要进行电子免填单打印吗？","Yes");  	 
}

function showPrtDlg(printType,DlgMessage,submitCfn)
{  //显示打印对话框 
   var h=210;
   var w=400;
   var t=screen.availHeight/2-h/2;
   var l=screen.availWidth/2-w/2;
 	 var pType="subprint";
	 var billType="1";  
   
   var printStr = printInfo(printType);
   var mode_code=null;
	 var fav_code=null;
	 var area_code=null
	 var op_code=document.all.opCode.value;
	 var phoneNo=document.all.phoneNo.value;
	 var sysAccept = document.all.loginAccept.value;
		/* ningtn */
		var iccidInfoStr = $("#firstId").val() + "|" + $("#secondId").val();	
		var accInfoStr = $("#accInfoHid1").val() + "|" +$("#accInfoHid2").val()+ "|" +$("#accInfoHid3").val()+ "|" +$("#accInfoHid4").val();
		/* ningtn */
   var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no" 
   var path = "<%=request.getContextPath()%>/npage/innet/hljBillPrint_jc_hw.jsp?DlgMsg="+DlgMessage+ "&iccidInfo=" + iccidInfoStr + "&accInfoStr="+accInfoStr;
   var path = path  + "&mode_code="+mode_code+"&fav_code="+fav_code+"&area_code="+area_code+"&opCode="+op_code+"&sysAccept="+sysAccept+"&phoneNo="+phoneNo+"&submitCfm="+submitCfn+"&pType="+pType+"&billType="+billType+ "&printInfo=" + printStr;
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
    if(printType == "Detail")
    {
			var cust_info="";
			var opr_info="";
			var note_info1="";
			var note_info2="";
			var note_info3="";
			var note_info4="";
			var retInfo = "";
    	
    	cust_info+="手机号码：   "+document.frm.phoneNo.value+"|";
			cust_info+="客户姓名：   "+document.frm.custName.value+"|";
			cust_info+="客户地址：   "+document.frm.idCardNo.value+"|";
			cust_info+="证件号码：   "+document.frm.custAddress.value+"|";

		var businessType;
		if(document.all.qryPwdFlag[0].checked)
		{	businessType = "申请";}
		if(document.all.qryPwdFlag[1].checked)
		{	businessType = "修改";}
		if(document.all.qryPwdFlag[2].checked)
		{	businessType = "重置";}
		if(document.all.qryPwdFlag[3].checked)
		{	businessType = "取消";}

		opr_info+="用户品牌:"+document.all.smName.value+"|";
		opr_info+="业务类型：二次密码设置"+businessType+"|";
		opr_info+="流水号码："+"<%=paraStr[0]%>"+"|";
		note_info1+= "备注："+"|";
        retInfo = cust_info+"#"+opr_info+"#"+note_info1+"#"+note_info2+"#"+note_info3+"#"+note_info4+"#";
		retInfo=retInfo.replace(new RegExp("#","gm"),"%23");
    }  
    if(printType == "Bill")
    {	//打印发票
    }
    return retInfo;	
}
</script>
<script>
function printBill(){
	 var infoStr="";                                                                         
	     infoStr+=" "+"|";
         infoStr+='<%=new java.text.SimpleDateFormat("yyyy", Locale.getDefault()).format(new java.util.Date())%>'+"|";
	 infoStr+='<%=new java.text.SimpleDateFormat("MM", Locale.getDefault()).format(new java.util.Date())%>'+"|";
	 infoStr+='<%=new java.text.SimpleDateFormat("dd", Locale.getDefault()).format(new java.util.Date())%>'+"|";
	 infoStr+=document.frm.phoneNo.value+"|";//移动号码                                                   
	 infoStr+=" "+"|";//合同号码                                                                               
	 infoStr+=document.frm.custName.value+"|";//用户名称                                                
	 infoStr+=document.frm.custAddress.value+"|";//用户地址    
	 infoStr+="现金"+"|";
		 infoStr+=document.frm.handFee.value+"|";                                            
	 infoStr+="详单禁查申请。*手续费："+document.frm.handFee.value+"*流水号："+document.frm.backLoginAccept.value+"|";
	 location="chkPrint.jsp?retInfo="+infoStr+"&dirtPage=f1236.jsp";                    
}
</script>
</BODY>
<!-- ningtn 2011-8-4 11:22:43 电子化工单扩大范围 -->
<%@ include file="/npage/public/hwObject.jsp" %> 
</HTML>

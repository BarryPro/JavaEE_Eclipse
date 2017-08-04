<%
    /********************
     version v2.0
     开发商: si-tech
     *
     *update:ningtn@2010-10-8 三码合一
     *
     ********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<%@ page contentType="text/html; charset=GB2312" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ include file="../../npage/bill/getMaxAccept.jsp" %>
<html>
<head>
<title>三码合一</title>
<META content="MSHTML 5.00.3315.2870" name=GENERATOR>
<%
	System.out.println("========= ningtn ======== fb632.jsp");
	String opCode = request.getParameter("opCode");
	String opName = request.getParameter("opName");
	String regionCode= (String)session.getAttribute("regCode");
	String loginAccept = "0";
	String chnSource = "01";
	String workNo = (String)session.getAttribute("workNo");
	String password = (String)session.getAttribute("password");
	String phoneNo = activePhone;
	String userPwd = "";
	String printAccept="";
	printAccept = getMaxAccept();
	
	String paraAray[] = new String[7];
	paraAray[0] = loginAccept;
	paraAray[1] = chnSource;
	paraAray[2] = opCode;
	paraAray[3] = workNo;
	paraAray[4] = password;
	paraAray[5] = phoneNo;
	paraAray[6] = userPwd;
	
	String custName = "";
	String custAdddress = "";
	String cardType = "";
	String cardNo = "";
	String smCode = "";
	String belong = "";
	String runTyoe = "";
	String vip = "";
	String prepay_fee = "";
%>

<wtc:service name="sb632Qry" routerKey="regionCode" routerValue="<%=regionCode%>" 
			retcode="errCode" retmsg="errMsg"  outnum="16">
		<wtc:param value="<%=paraAray[0]%>"/>
		<wtc:param value="<%=paraAray[1]%>"/>
		<wtc:param value="<%=paraAray[2]%>"/>
		<wtc:param value="<%=paraAray[3]%>"/>
		<wtc:param value="<%=paraAray[4]%>"/>
		<wtc:param value="<%=paraAray[5]%>"/>
		<wtc:param value="<%=paraAray[6]%>"/>
</wtc:service>
<wtc:array id="result" scope="end" start="0" length="11"/>
<wtc:array id="result1" scope="end" start="11" length="5"/>
<%
	System.out.println("============== ningtn ======== errCode : " + errCode);
	if(errCode.equals("0")||errCode.equals("000000")){
		System.out.println("================ ningtn =========查询成功" + errCode);
		if(result != null && result.length > 0){
			custName 	 = result[0][2];
			custAdddress = result[0][3];
			cardType 	 = result[0][4];
			cardNo 		 = result[0][5];
			smCode 		 = result[0][6];
			belong 		 = result[0][7];
			runTyoe 	 = result[0][8];
			vip 		 = result[0][9];
			prepay_fee 	 = result[0][10];
			
			System.out.println("================ ningtn =========查询成功" + custName);
		}
		for(int i = 0; i < result1.length ; i++){
			System.out.println("======lichaoa======= " + result1[i][0]);
			System.out.println("======lichaoa======= " + result1[i][1]);
			System.out.println("======lichaoa======= " + result1[i][2]);
			System.out.println("======lichaoa======= " + result1[i][3]);
			System.out.println("======lichaoa======= " + result1[i][4]);
		}
	}else{
%>
	<script language="javascript">
		rdShowMessageDialog("错误代码：<%=errCode%>，错误信息：<%=errMsg%>",0);
		removeCurrentTab();
	</script>
<%
	}
	
  //手机品牌
  String sqlAgentCode = " select  unique a.brand_code,trim(b.brand_name) from sPhoneSalCfg a,schnresbrand b where a.region_code='" + regionCode + "' and a.sale_type='0' and a.brand_code=b.brand_code and valid_flag='Y' and a.spec_type like 'P%' and is_valid='1'";
  System.out.println("sqlAgentCode====="+sqlAgentCode);

  //手机类型
  String sqlPhoneType = "select unique a.type_code,trim(b.res_name), b.brand_code from sPhoneSalCfg a,schnrescode_chnterm b where a.region_code='" + regionCode + "' and  a.type_code=b.res_code and a.brand_code=b.brand_code and valid_flag='Y' and a.sale_type='0' and a.spec_type like 'P%' and is_valid='1'";
  System.out.println("sqlPhoneType====="+sqlPhoneType);

  //营销代码
  String sqlsaleType = "select unique a.sale_code,trim(a.sale_name), a.brand_code,a.type_code from sPhoneSalCfg a where a.region_code='" + regionCode + "' and a.sale_type='0' and valid_flag='Y' and a.spec_type like 'P%'";
  System.out.println("sqlsaleType====="+sqlsaleType);
%>
<wtc:pubselect name="sPubSelect" outnum="2" retmsg="msg1" retcode="code1" routerKey="region" routerValue="<%=regionCode%>">
	<wtc:sql><%=sqlAgentCode%></wtc:sql>
</wtc:pubselect>
<wtc:array id="agentCodeStr" scope="end"/>

<wtc:pubselect name="sPubSelect" outnum="3" retmsg="msg2" retcode="code2" routerKey="region" routerValue="<%=regionCode%>">
	<wtc:sql><%=sqlPhoneType%></wtc:sql>
</wtc:pubselect>
<wtc:array id="phoneTypeStr" scope="end"/>

<wtc:pubselect name="sPubSelect" outnum="4" retmsg="msg2" retcode="code2" routerKey="region" routerValue="<%=regionCode%>">
	<wtc:sql><%=sqlsaleType%></wtc:sql>
</wtc:pubselect>
<wtc:array id="saleTypeStr" scope="end"/>

<script language="javascript">
	window.onload = function() {
		pasChange();
	}
  //定义应用全局的变量
  var SUCC_CODE	= "0";   		//自己应用程序定义
  var ERROR_CODE  = "1";			//自己应用程序定义
  var YE_SUCC_CODE = "0000";		//根据营业系统定义而修改

  var oprType_Add = "a";
  var oprType_Upd = "u";
  var oprType_Del = "d";
  var oprType_Qry = "q";

  var arrPhoneType = new Array();//手机型号代码
  var arrPhoneName = new Array();//手机型号名称
  var arrAgentCode = new Array();//代理商代码
  var selectStatus = 0;

  var arrsalecode =new Array();
  var arrsaleName=new Array();
  var arrsalebarnd=new Array();
  var arrsaletype=new Array();
  
  var imeiCode = new Array();
  var activeTime = new Array();

<%
  for(int i=0;i<phoneTypeStr.length;i++)
  {
	out.println("arrPhoneType["+i+"]='"+phoneTypeStr[i][0]+"';\n");
	out.println("arrPhoneName["+i+"]='"+phoneTypeStr[i][1]+"';\n");
	out.println("arrAgentCode["+i+"]='"+phoneTypeStr[i][2]+"';\n");
  }
  for(int l=0;l<saleTypeStr.length;l++)
  {
	out.println("arrsalecode["+l+"]='"+saleTypeStr[l][0]+"';\n");
	out.println("arrsaleName["+l+"]='"+saleTypeStr[l][1]+"';\n");
	out.println("arrsalebarnd["+l+"]='"+saleTypeStr[l][2]+"';\n");
	out.println("arrsaletype["+l+"]='"+saleTypeStr[l][3]+"';\n");

  }
%>

function selectChange(control, controlToPopulate, ItemArray, GroupArray)
{
	var myEle ;
	var x ;
	// Empty the second drop down box of any choices
	for (var q=controlToPopulate.options.length;q>=0;q--) controlToPopulate.options[q]=null;
	// ADD Default Choice - in case there are no values
	
	myEle = document.createElement("option") ;
	myEle.value = "";
	myEle.text ="--请选择--";
	controlToPopulate.add(myEle) ;
	for ( x = 0 ; x < ItemArray.length  ; x++ )
	{
		if ( GroupArray[x] == control.value )
		{
			myEle = document.createElement("option") ;
			myEle.value = arrPhoneType[x] ;
			myEle.text = ItemArray[x] ;
			controlToPopulate.add(myEle) ;
		}
	}
}

function typechange(){
	var myEle1 ;
	var x1 ;
	for (var q1=document.all.sale_code.options.length;q1>=0;q1--) document.all.sale_code.options[q1]=null;
	myEle1 = document.createElement("option") ;
	myEle1.value = "";
	myEle1.text ="--请选择--";
	document.all.sale_code.add(myEle1) ;
	
	for ( x1 = 0 ; x1 < arrsaletype.length  ; x1++ )
	{
		if ( arrsaletype[x1] == document.all.phone_type.value  && arrsalebarnd[x1] == document.all.agent_code.value)
		{
			myEle1 = document.createElement("option") ;
			myEle1.value = arrsalecode[x1];
			myEle1.text = arrsaleName[x1];
			document.all.sale_code.add(myEle1) ;
		}
	}
}

function salechage(){

	var getNote_Packet = new AJAXPacket("../s1141/f1145_getcardrpc.jsp","正在获得营销明细，请稍候......");
	
	getNote_Packet.data.add("retType","getcard");
	getNote_Packet.data.add("saletype","0");
	getNote_Packet.data.add("regionCode","<%=regionCode%>");
	getNote_Packet.data.add("salecode",document.all.sale_code.value);
	getNote_Packet.data.add("bindType","1");
	core.ajax.sendPacket(getNote_Packet,doSaleChange);
	getNote_Packet =null;
}
function doSaleChange(packet){
	var retCode = packet.data.findValueByName("retCode");
   	var retMessage = packet.data.findValueByName("retMessage");
	if(retCode!=0){
		rdShowMessageDialog(retMessage);
		return ;
	}
	$("#price").val(packet.data.findValueByName("phonemoney"));
	$("#sum_money").val(packet.data.findValueByName("phonemoney"));
}

function checkimeino()
{
	 if (document.frm.IMEINo.value.length == 0) {
		rdShowMessageDialog("IMEI号码不能为空，请重新输入 !!",0);
		document.frm.IMEINo.focus();
		document.frm.confirm.disabled = true;
		return false;
     }
    if($("#phone_type").val() == null || $("#phone_type").val().length == 0){
    	rdShowMessageDialog("请选择手机型号!",0);
		document.frm.phone_type.focus();
		document.frm.confirm.disabled = true;
		return false;
    }
	var myPacket = new AJAXPacket("../s1141/queryimei.jsp","正在校验IMEI信息，请稍候......");
	myPacket.data.add("imei_no",(document.all.IMEINo.value).trim());
	myPacket.data.add("brand_code",(document.all.agent_code.options[document.all.agent_code.selectedIndex].value).trim());
	myPacket.data.add("style_code",(document.all.phone_type.options[document.all.phone_type.selectedIndex].value).trim());
	myPacket.data.add("opcode",(document.all.opcode.value).trim());
	myPacket.data.add("retType","0");
	core.ajax.sendPacket(myPacket,doCheckImei);
	myPacket = null;
}
function doCheckImei(packet){
	var retResult = packet.data.findValueByName("retResult");
	if(retResult == "000000"){
		rdShowMessageDialog("IMEI号校验成功1！",2);
		document.frm.IMEINo.readOnly=true;
		document.frm.confirm.disabled=false;
		return ;
	
	}else if(retResult == "000001"){
		rdShowMessageDialog("IMEI号校验成功2！",2);
		document.frm.confirm.disabled=false;
		document.frm.IMEINo.readOnly=true;
		return ;
	
	}else if(retResult == "000003"){
		rdShowMessageDialog("IMEI号不在营业员归属营业厅或IMEI号与业务办理机型不符！",0);
		document.frm.confirm.disabled=true;
		return false;
	}else{
		rdShowMessageDialog("IMEI号不存在或者已经使用！",0);
		document.frm.confirm.disabled=true;
		return false;
	}
}

function viewConfirm(obj)
{
	checkElement(obj);
	if(document.frm.IMEINo.value=="")
	{
		document.frm.confirm.disabled=true;
	}

}
function printCommit()
 {
	getAfterPrompt();
  	//校验
  	//if(!check(frm)) return false;

	with(document.frm){
		if($("#userName").val()==""){
			rdShowMessageDialog("请输入姓名!",1);
			$("#userName")[0].focus();
			return false;
		}
		if(agent_code.value==""){
			rdShowMessageDialog("请输入手机品牌!",1);
			agent_code.focus();
			return false;
		}
		if(phone_type.value==""){
			rdShowMessageDialog("请输入手机型号!",1);
			phone_type.focus();
			return false;
		}
		if(sale_code.value==""){
			rdShowMessageDialog("请输入营销代码!",1);
			sale_code.focus();
			return false;
		}
		if (IMEINo.value.length == 0) {
			rdShowMessageDialog("IMEI号码不能为空，请重新输入 !!",1);
			IMEINo.focus();
			confirm.disabled = true;
			return false;
		}
		if(opNote.value=="")
		{
			opNote.value=phone_no.value+"办理购机赠礼业务";
		}
		phone_typename.value=document.all.agent_code.options[document.all.agent_code.selectedIndex].text+document.all.phone_type.options[document.all.phone_type.selectedIndex].text;
		
	}

 //打印工单并提交表单
  var ret = showPrtDlg("Detail","确实要进行电子免填单打印吗？","Yes");
  if(typeof(ret)!="undefined")
  {
    if((ret=="confirm"))
    {
      if(rdShowConfirmDialog('确认电子免填单吗？')==1)
      {
	    frmCfm();
      }
	}
	if(ret=="continueSub")
	{
      if(rdShowConfirmDialog('确认要提交信息吗？')==1)
      {
	    frmCfm();
      }
	}
  }
  else
  {
     if(rdShowConfirmDialog('确认要提交信息吗？')==1)
     {
	   frmCfm();
     }
  }
  return true;
}
function frmCfm(){
	frm.submit();
	return true;
}
function showPrtDlg(printType,DlgMessage,submitCfm)
{  //显示打印对话框
	var h=210;
	var w=400;
	var t=screen.availHeight/2-h/2;
	var l=screen.availWidth/2-w/2;
	var pType="subprint";
	var billType="1";
	var sysAccept = document.all.login_accept.value;
	var printStr = printInfo(printType);
	
	var mode_code=null;
	var fav_code=null;
	var area_code=null
	
	var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no";
	var path = "<%=request.getContextPath()%>/npage/innet/hljBillPrint_jc.jsp?DlgMsg="+DlgMessage;
	var path = path  + "&mode_code="+mode_code+"&fav_code="+fav_code+"&area_code="+area_code+"&opCode=<%=opCode%>&sysAccept="+sysAccept+"&phoneNo=<%=phoneNo%>&submitCfm=" + submitCfm+"&pType="+pType+"&billType="+billType+ "&printInfo=" + printStr;
	var ret=window.showModalDialog(path,printStr,prop);
	return ret;
}

function printInfo(printType)
{
	var cust_info="";
	var opr_info="";
	var note_info1="";
	var note_info2="";
	var note_info3="";
	var note_info4="";
	var retInfo = "";
	
	cust_info+= "手机号码：     "+document.all.phone_no.value+"|";
	cust_info+= "客户姓名：     "+document.all.userName.value+"|";
	cust_info+= "证件号码：     "+document.all.cardNo.value+"|";
	cust_info+= "客户地址：     "+document.all.userAddress.value+"|";
	
	opr_info+="用户品牌："+document.all.smCode.value+"                   办理业务：三码合一裸机销售"+"|";
	opr_info+="操作流水："+document.all.login_accept.value+"|";
	opr_info+="手机型号："+document.all.agent_code.options[document.all.agent_code.selectedIndex].text+document.all.phone_type.options[document.all.phone_type.selectedIndex].text
  				+"      IMEI码："+document.frm.IMEINo.value+"|";
	note_info1 += "备注：" + $("#opNote").val() + "|";
	retInfo = cust_info+"#"+opr_info+"#"+note_info1+"#"+note_info2+"#"+note_info3+"#"+note_info4+"#";
	retInfo=retInfo.replace(new RegExp("#","gm"),"%23");
    return retInfo;
}
	
	function pasChange() {
		var updateAccept = new Array();
		var oldimei = new Array();
		var activedate = new Array();
		
		<%for(int i = 0; i < result1.length ; i++){%>
			updateAccept[<%=i%>] = "<%=result1[i][0]%>";
			oldimei[<%=i%>] = "<%=result1[i][1]%>";
			activedate[<%=i%>] = "<%=result1[i][2]%>";
		<%}%>
		var num = document.getElementById("old_msg").value;
		document.getElementById("updateAccept").value = updateAccept[num];
		document.getElementById("oldimei").value = oldimei[num];
		document.getElementById("activedate").value = activedate[num];
	}
</script>
</head>
<body>
<form name="frm" method="POST" action="fb632Cfm.jsp">
<%@ include file="/npage/include/header.jsp" %>
<div class="title">
	<div id="title_zi">用户信息</div>
</div>
<table cellspacing="0">
	<tr>
		<td class="blue">客户姓名</td>
		<td><input name="userName" id="userName" type="text" Class="InputGrey" readOnly value="<%=custName%>"/></td>
		<td class="blue">客户地址</td>
		<td><input name="userAddress" id="userAddress" type="text" Class="InputGrey" readOnly size="50" value="<%=custAdddress%>"/></td>
	</tr>
	<tr>
		<td class="blue">证件类型</td>
		<td><input name="cardType" id="cardType" type="text" Class="InputGrey" readOnly value="<%=cardType%>"/></td>
		<td class="blue">证件号码</td>
		<td><input name="cardNo" id="cardNo" type="text" Class="InputGrey" readOnly value="<%=cardNo%>"/></td>
	</tr>
	<tr>
		<td class="blue">业务品牌</td>
		<td><input name="smCode" id="smCode" type="text" Class="InputGrey" readOnly value="<%=smCode%>"/></td>
		<td class="blue">归属地</td>
		<td><input name="belong" id="belong" type="text" Class="InputGrey" readOnly value="<%=belong%>"/></td>
	</tr>
	<tr>
		<td class="blue">当前状态</td>
		<td><input name="runTyoe" id="runTyoe" type="text" Class="InputGrey" readOnly value="<%=runTyoe%>"/></td>
		<td class="blue">VIP等级</td>
		<td><input name="vip" id="vip" type="text" Class="InputGrey" readOnly value="<%=vip%>"/></td>
	</tr>
	<tr>
		<td class="blue">可用预存</td>
		<td colspan="3"><input name="prepay_fee" id="prepay_fee" type="text" Class="InputGrey" readOnly value="<%=prepay_fee%>"/></td>
	</tr>
	<%/*lichaoa*/%>
	<tr>
		<td class="blue">原绑定信息</td>
		<td colspan="3">
			<SELECT id="old_msg" name="old_msg" v_must=1  onchange="pasChange();" v_name="原绑定信息" style="width:600px">
				<%for(int i = 0; i < result1.length ; i++){%>
				<option value="<%=i%>"><%="手机型号："+result1[i][3]+"，原imei码："+result1[i][1]+"，激活时间："+result1[i][2]+"，"+result1[i][4]%></option>
				<%}%>
			</select>
		</td>
	</tr>
	
	
</table>
</div>
<div id="Operation_Table">
	<div class="title">
		<div id="title_zi">业务办理</div>
	</div>
	<table cellspacing="0">
		<table cellspacing="0">
			<tr>
				<td class="blue">手机品牌</td>
				<td>
					<SELECT id="agent_code" name="agent_code" v_must=1  onchange="selectChange(this, phone_type, arrPhoneName, arrAgentCode);" v_name="手机代理商">
						<option value ="">--请选择--</option>
						<%for(int i = 0 ; i < agentCodeStr.length ; i ++){%>
						<option value="<%=agentCodeStr[i][0]%>"><%=agentCodeStr[i][1]%></option>
						<%}%>
					</select>
					<font class="orange">*</font>
				</td>
				<td class="blue">手机型号</td>
				<td>
					<select size=1 name="phone_type" id="phone_type" v_must=1 v_name="手机型号" onchange="typechange()">
					</select>
					<font class="orange">*</font>
				</td>
			</tr>
			<tr>
			<td class="blue">营销方案</td>
			<td colspan="3">
				<select size=1 name="sale_code" id="sale_code" v_must=1 v_name="营销代码" onchange="salechage()">
				</select>
				<font class="orange">*</font>
			</td>
			</tr>
			<tr>
				<td class="blue">购机款</td>
				<td><input type="text" name="price" id="price" Class="InputGrey" readOnly/></td>
				<td class="blue">应付金额</td>
				<td><input type="text" name="sum_money" id="sum_money" Class="InputGrey" readOnly/></td>
			</tr>
			<TR>
				<TD  class="blue" nowrap>
					IMEI码
				</TD>
				<TD colspan="3">
					<input name="IMEINo" id="IMEINo" type="text" v_must="1" v_type="0_9" v_name="IMEI码"  maxlength=15 value="" onblur="viewConfirm(this)">
					<input name="checkimei" class="b_text" type="button" value="校验" onclick="checkimeino()">
					<font class="orange">*</font>
				</TD>
			</TR>
			<TR id=showHideTr >
				<TD  class="blue" nowrap>付机时间</TD>
				<TD >
					<input name="payTime"  type="text" v_must="1" v_name="付机时间" v_type="date" onblur="viewConfirm(this)" 
						value="<%=new java.text.SimpleDateFormat("yyyyMMdd", Locale.getDefault()).format(new java.util.Date())%>" />
					(年月日)<font class="orange">*</font>
				</TD>
				<TD class="blue" nowrap>保修时限</TD>
				<TD >
					<input name="repairLimit" v_type="0_9"  size="10" type="text" v_name="保修时限" value="12" onblur="viewConfirm(this)">
					(个月)<font class="orange">*</font>
				</TD>
			</TR>
			<tr>
				<td  class="blue">用户备注</td>
				<td colspan="3">
				<input name="opNote" type="text"  id="opNote" size="60" maxlength="60" value="三码合一裸机销售" >
				</td>
			</tr>
	</table>
<table cellspacing="0">
	<tr>
	    <td colspan="3" id="footer">
	      <input class="b_foot" type="button" name="confirm" id="confirm" value="确认&打印" disabled onClick="printCommit()" />
	      <input class="b_foot" type="reset" name="back" value="清除" />
	      <input class="b_foot" type="button" name="qryPage" value="关闭" onClick="removeCurrentTab()"/>
	    </td>
	</tr>
</table>
<input type="hidden" name="opcode" value="<%=opCode%>" />
<input type="hidden" name="opName" value="<%=opName%>" />
<input type="hidden" name="phone_no" value="<%=phoneNo%>" />
<input type="hidden" name="phone_typename" />
<input type="hidden" name="login_accept" value="<%=printAccept%>" />

<input type="hidden" name="updateAccept" value="" />
<input type="hidden" name="oldimei" value="" />
<input type="hidden" name="activedate" value="" />

<%@ include file="/npage/include/footer.jsp" %> 
</form>
</body>
</html>

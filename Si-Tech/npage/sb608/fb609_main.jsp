<%
    /********************
     version v2.0
     开发商: si-tech
     *
     *create:wanghfa@2010-9-26 三口之家
     *
     ********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<html>
<head>
<title>加入三口之家</title>
<META content="MSHTML 5.00.3315.2870" name=GENERATOR>

<%
	String opCode = WtcUtil.repNull(request.getParameter("opCode"));
	String opName = WtcUtil.repNull(request.getParameter("opName"));
	String pwrf = WtcUtil.repNull(request.getParameter("pwrf"));
	System.out.println("=========wanghfa========= fb609_main.jsp " + opCode + ", " + opName + ", " + pwrf);
	
	String fatherPhone1 = WtcUtil.repNull(request.getParameter("fatherPhone1"));
	String fatherPwd1 = WtcUtil.repNull(request.getParameter("fatherPwd1"));
	String memberPhone1 = WtcUtil.repNull(request.getParameter("memberPhone1"));
	String memberPwd1 = WtcUtil.repNull(request.getParameter("memberPwd1"));
	
	String workNo = WtcUtil.repNull((String)session.getAttribute("workNo"));
	String noPass = WtcUtil.repNull((String)session.getAttribute("password"));
	String result[][] = new String[1][13];
%>

<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="phone" routerValue="<%=activePhone%>" id="printAccept"/>

<%
	System.out.println("===========wanghfa=sB608Valid==0====== loginAccept = ");
	System.out.println("===========wanghfa=sB608Valid==1====== chnSource = 01");
	System.out.println("===========wanghfa=sB608Valid==2====== opCode = " + opCode);
	System.out.println("===========wanghfa=sB608Valid==3====== workNo = " + workNo);
	System.out.println("===========wanghfa=sB608Valid==4====== noPass = " + noPass);
	System.out.println("===========wanghfa=sB608Valid==5====== 家长号码 = " + fatherPhone1);
	System.out.println("===========wanghfa=sB608Valid==6====== 家长密码 = " + fatherPwd1);
	System.out.println("===========wanghfa=sB608Valid==7====== 成员号码 = " + memberPhone1);
	System.out.println("===========wanghfa=sB608Valid==8====== 成员密码 = " + memberPwd1);
%>
<wtc:service name="sB608Valid" routerKey="phone" routerValue="<%=fatherPhone1%>" retcode="retCode1" retmsg="retMsg1" outnum="13">
	<wtc:param value=""/>
	<wtc:param value="01"/>
	<wtc:param value="<%=opCode%>"/>
	<wtc:param value="<%=workNo%>"/>
	<wtc:param value="<%=noPass%>"/>
	<wtc:param value="<%=fatherPhone1%>"/>
	<wtc:param value="<%=fatherPwd1%>"/>
	<wtc:param value="<%=memberPhone1%>"/>
	<wtc:param value="<%=memberPwd1%>"/>
</wtc:service>
<wtc:array id="result1" scope="end"/>
<%
	System.out.println("===========wanghfa======= sB608Valid : " + retCode1 + ", " + retMsg1);
	if (!"000000".equals(retCode1)) {
%>
		<script language=javascript>
			rdShowMessageDialog("<%=retMsg1%>", 1);
			history.go(-1);
		</script>
<%
	} else {
		for (int i = 0; i < result1.length; i ++) {
			for (int j = 0; j < result1[i].length; j ++) {
				System.out.println("========wanghfa======= sB608Valid : result1[" + i + "][" + j + "] = " + result1[i][j]);
				result[i][j] = result1[i][j];
			}
		}
%>


<%
	System.out.println("===========wanghfa=sB608Qry==0====== loginAccept = ");
	System.out.println("===========wanghfa=sB608Qry==1====== chnSource = 01");
	System.out.println("===========wanghfa=sB608Qry==2====== opCode = " + opCode);
	System.out.println("===========wanghfa=sB608Qry==3====== workNo = " + workNo);
	System.out.println("===========wanghfa=sB608Qry==4====== noPass = " + noPass);
	System.out.println("===========wanghfa=sB608Qry==5====== 家长号码 = " + fatherPhone1);
	System.out.println("===========wanghfa=sB608Qry==6====== 家长密码 = " + fatherPwd1);
	System.out.println("===========wanghfa=sB608Qry==7====== 成员号码 = " + memberPhone1);
	System.out.println("===========wanghfa=sB608Qry==8====== 成员密码 = " + memberPwd1);
	System.out.println("===========wanghfa=sB608Qry==9====== 查询类型 = 0");
%>
<wtc:service name="sB608Qry" routerKey="phone" routerValue="<%=fatherPhone1%>" retcode="retCode2" retmsg="retMsg2" outnum="3">
	<wtc:param value=""/>
	<wtc:param value="01"/>
	<wtc:param value="<%=opCode%>"/>
	<wtc:param value="<%=workNo%>"/>
	<wtc:param value="<%=noPass%>"/>
	<wtc:param value="<%=fatherPhone1%>"/>
	<wtc:param value="<%=fatherPwd1%>"/>
	<wtc:param value="<%=memberPhone1%>"/>
	<wtc:param value="<%=memberPwd1%>"/>
	<wtc:param value="0"/>
</wtc:service>
<wtc:array id="result2" scope="end"/>
<%
	System.out.println("===========wanghfa======= sB608Qry : " + retCode2 + ", " + retMsg2);
	if ("000000".equals(retCode2)) {
		for (int i = 0; i < result2.length; i ++) {
			for (int j = 0; j < result2[i].length; j ++) {
				System.out.print("========wanghfa======= sB608Qry : result2[" + i + "][" + j + "] = ");
				System.out.println(result2[i][j]);
			}
		}
	}
%>


<script language=javascript>
	var comments;
	if (!<%=pwrf%>) {
		checkFatherPwd();
	}
	
	function checkFatherPwd() {
		var checkPwd_Packet = new AJAXPacket("/npage/public/pubCheckPwd.jsp","正在进行密码校验，请稍候......");
		checkPwd_Packet.data.add("custType", "01");						//01:手机号码 02 客户密码校验 03帐户密码校验
		checkPwd_Packet.data.add("phoneNo", "<%=fatherPhone1%>");		//移动号码,客户id,帐户id
		checkPwd_Packet.data.add("custPaswd", "<%=fatherPwd1%>");		//用户/客户/帐户密码
		checkPwd_Packet.data.add("idType", "un");						//en 密码为密文，其它情况 密码为明文
		checkPwd_Packet.data.add("idNum", "");							//传空
		checkPwd_Packet.data.add("loginNo", "<%=workNo%>");				//工号
		core.ajax.sendPacket(checkPwd_Packet, doCheckPwd);
		checkPwd_Packet=null;
	}
	
	function doCheckPwd(packet) {
		var retResult = packet.data.findValueByName("retResult");
		var msg = packet.data.findValueByName("msg");
		if (retResult != "000000") {
			rdShowMessageDialog("家长密码错误，" + msg, 1);
			history.go(-1);
		} else {
			checkMemberPwd();
		}
	}
	
	function checkMemberPwd() {
		var checkPwd_Packet = new AJAXPacket("/npage/public/pubCheckPwd.jsp","正在进行密码校验，请稍候......");
		checkPwd_Packet.data.add("custType", "01");						//01:手机号码 02 客户密码校验 03帐户密码校验
		checkPwd_Packet.data.add("phoneNo", "<%=memberPhone1%>");		//移动号码,客户id,帐户id
		checkPwd_Packet.data.add("custPaswd", "<%=memberPwd1%>");		//用户/客户/帐户密码
		checkPwd_Packet.data.add("idType", "un");						//en 密码为密文，其它情况 密码为明文
		checkPwd_Packet.data.add("idNum", "");							//传空
		checkPwd_Packet.data.add("loginNo", "<%=workNo%>");				//工号
		core.ajax.sendPacket(checkPwd_Packet, doCheckPwd);
		checkPwd_Packet=null;
	}
	
	function doCheckPwd(packet) {
		var retResult = packet.data.findValueByName("retResult");
		var msg = packet.data.findValueByName("msg");
		if (retResult != "000000") {
			rdShowMessageDialog("成员密码错误，" + msg, 1);
			history.go(-1);
		}
	}
	
	function submitt() {
		document.getElementById("cubmitt").disabled = "true";
		var productIdObj = document.getElementById("productId");
		
		var getOfferCmtsPacket = new AJAXPacket("fb608_ajaxGetOfferCmts.jsp", "正在获取办理资费描述，请稍后......");
		getOfferCmtsPacket.data.add("offerId", productIdObj.options[productIdObj.selectedIndex].innerText.split("--")[0]);
		core.ajax.sendPacket(getOfferCmtsPacket, doGetCmts);
	}
	
	function doGetCmts(packet) {
		var buttonSub = document.getElementById("cubmitt");
		var retResult = packet.data.findValueByName("retResult");
		
		if (retResult == "000000") {
			comments = packet.data.findValueByName("comments");
		} else {
			comments = "取资费描述失败。";
		}
		
		var ret = showPrtDlg("Detail", "确实要进行电子免填单打印吗？","Yes");	//打印免填单
		
		if(typeof(ret) != "undefined"){
			if (rdShowConfirmDialog("确认要进行此项服务吗？") == 1) {
				frm.submit();
			}
			buttonSub.disabled = "";
		} else {
			if (rdShowConfirmDialog("确认要进行此项服务吗？") == 1) {
				frm.submit();
			}
			buttonSub.disabled = "";
		}
	}
	
	function showPrtDlg(printType, DlgMessage, submitCfm)
	{  //显示打印对话框
		var h = 210;
		var w = 400;
		var t = screen.availHeight / 2 - h / 2;
		var l = screen.availWidth / 2 - w / 2;
		
		var pType = "subprint";
		var billType = "1";
		var sysAccept = "<%=printAccept%>";
		var printStr  =  printInfo(printType);
		var mode_code = null;
		var fav_code = null;
		var area_code = null;
		var opCode = "<%=opCode%>";
		var phoneNo = document.getElementById("memberPhone1").value;
		
		var prop = "dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no";
		var path = "<%=request.getContextPath()%>/npage/innet/hljBillPrint_jc.jsp?DlgMsg=" + DlgMessage+ "&submitCfm=" + submitCfm;
		path = path + "&mode_code="+mode_code+"&fav_code="+fav_code+"&area_code="+area_code+"&opCode=<%=opCode%>&sysAccept="+sysAccept+"&phoneNo="+phoneNo+"&submitCfm="+submitCfm+"&pType="+pType+"&billType="+billType+ "&printInfo=" + printStr;
		
		var ret=window.showModalDialog(path,printStr,prop);
		return ret;
	}
	
	function printInfo(printType)
	{
		var retInfo = "";
		var cust_info="";
		var opr_info="";
		var note_info1="";
		var note_info2="";
		var note_info3="";
		var note_info4="";
		
		cust_info+="手机号码：" + document.getElementById("memberPhone1").value + "|";
		cust_info+="客户姓名：" + document.getElementById("custName").value + "|";
		//cust_info+="证件号码：" + document.getElementById("idNo").value + "|";
		//cust_info+="客户地址：" + document.getElementById("custAddr").value + "|";
		
		opr_info += "业务受理时间：" + '<%=new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss", Locale.getDefault()).format(new java.util.Date())%>'
			+ "  " + "用户品牌: " + document.getElementById("smName").value + "|";
		opr_info += "办理业务：" + document.getElementById("opName").value + "  操作流水：" + "<%=printAccept%>" + "|";
		opr_info += "加入的家庭代码：" + document.getElementById("familyGroupId").value + "  家长号码：<%=fatherPhone1%>" + "|";
		opr_info += "家庭套餐：" + document.getElementById("productId")[document.getElementById("productId").selectedIndex].text + "|";
		
		document.getElementById("opNote").value = "工号<%=workNo%>为<%=memberPhone1%>用户办理<%=opName%>。";
		note_info1 += "备注：工号<%=workNo%>为<%=memberPhone1%>用户办理<%=opName%>。|";
		note_info1 += "资费描述：" + comments + "|";
		note_info1 += "三口之家套餐的有效期为2010年12月1日至2011年6月30日，自2011年7月1日起套餐自动失效，客户不再享受此套餐的优惠。|";
		
		retInfo = strcat(cust_info, opr_info, note_info1, note_info2, note_info3, note_info4);
		retInfo = retInfo.replace(new RegExp("#","gm"), "%23");
		return retInfo;
	}
</script>
</head>
<body>

<form name="frm" action="fb609_cfm.jsp" method="POST">
<input type="hidden" name="opCode" id="opCode" value="<%=opCode%>">
<input type="hidden" name="opName" id="opName" value="<%=opName%>">
<input type="hidden" name="printAccept" id="printAccept" value="<%=printAccept%>">
<input type="hidden" name="fatherPhone1" id="fatherPhone1" value="<%=fatherPhone1%>">
<input type="hidden" name="memberPhone1" id="memberPhone1" value="<%=memberPhone1%>">
<input type="hidden" name="opNote" id="opNote" value="">

<%@ include file="/npage/include/header.jsp" %>
<div class="title">
	<div name="title_zi" id="title_zi">成员信息</div>
</div>
<table cellspacing="0">
	<tr>
		<td class="blue" width="20%">
			客户姓名
		</td>
		<td width="30%">
			<input type="text" name="custName" id="custName" size="40" value="<%=result[0][0]%>" v_must="1" class="InputGrey" readonly>
		</td>
		<td class="blue" width="20%">
			用户号码
		</td>
		<td width="30%">
			<input type="text" name="fatherPhone1" id="fatherPhone1" value="<%=fatherPhone1%>" v_must="1" class="InputGrey" readonly>
		</td>
	</tr>
	<tr>
		<td class="blue">
			业务品牌
		</td>
		<td>
			<input type="text" name="smName" id="smName" value="<%=result[0][2]%>--<%=result[0][1]%>" v_must="1" class="InputGrey" readonly>
		</td>
		<td class="blue">
			<%=result[0][3]%>
		</td>
		<td>
			<input type="text" name="idNo" id="idNo" value="<%=result[0][4]%>" v_must="1" class="InputGrey" readonly>
		</td>
	</tr>
	<tr>
		<td class="blue">
			当前主套餐
		</td>
		<td>
			<input type="text" name="currentProduct" id="currentProduct" size="40" value="<%=result[0][5]%>--<%=result[0][6]%>" v_must="1" class="InputGrey" readonly>
		</td>
		<td class="blue">
			客户类型
		</td>
		<td>
			<input type="text" name="bigCust" id="bigCust" value="<%=result[0][7]%>--<%=result[0][8]%>" v_must="1" class="InputGrey" readonly>
		</td>
	</tr>
	<tr>
		<td class="blue">
			客户地址
		</td>
		<td colspan="3">
			<input type="text" name="custAddr" id="custAddr" size="60" value="<%=result[0][9]%>" v_must="1" class="InputGrey" readonly>
		</td>
	</tr>
</table>

<div class="title">
	<div name="title_zi" id="title_zi">家庭状态</div>
</div>
<table>
	<tr>
		<td class="blue" width="30%">
			家庭代码
		</td>
		<td width="70%">
			<input type="text" name="familyGroupId" id="familyGroupId" value="<%=result[0][10]%>" v_must="1" class="InputGrey" readonly>
		</td>
	</tr>
	<tr>
		<td class="blue" width="30%">
			家庭套餐
		</td>
		<td width="70%">
			<select id="productId" name="productId" style="width:300px">
<%
			for (int i = 0; i < result2.length; i ++) {
%>
				<option value="<%=result2[i][2]%>"><%=result2[i][0]%>--<%=result2[i][1]%></option>
<%
			}
%>
			</select>
		</td>
	</tr>
</table>
<table cellspacing="0">
	<tr>
	    <td id="footer">
	      <input class="b_foot" type=button name="cubmitt" value="确定" onClick="submitt();">
	      <input class="b_foot" type=button name="cubmitt" value="返回" onClick="window.location = 'fb608.jsp?opCode=<%=opCode%>&opName=<%=opName%>';">
	      <input class="b_foot" type=button name=qryPage value="关闭" onClick="removeCurrentTab();">
	    </td>
	</tr>
</table>
<%@ include file="/npage/include/footer_simple.jsp" %> 
</form>
</body>
</html>
<%
	}
%>

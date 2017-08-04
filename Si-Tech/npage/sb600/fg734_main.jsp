<%
    /********************
     version v2.0
     开发商: si-tech
     *
     *create:wanghfa@2010-9-21 短信签名业务
     *
     ********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%
  String opCode = WtcUtil.repNull(request.getParameter("opCode"));
	String opName = WtcUtil.repNull(request.getParameter("opName"));
	String phoneNo = WtcUtil.repNull(request.getParameter("phoneNo"));
	String workNo = WtcUtil.repNull((String)session.getAttribute("workNo"));
	String noPass = WtcUtil.repNull((String)session.getAttribute("password"));
	String regCode = (String)session.getAttribute("regCode");
	String result[][] = new String[1][9];
	
  //获取系统时间
  Date currentTime = new Date(); 
  java.text.SimpleDateFormat formatter = new java.text.SimpleDateFormat("yyyyMMddHHmmss");
  String currentTimeString = formatter.format(currentTime);
%>

<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="region" routerValue="<%=regCode%>" id="printAccept"/>

<wtc:service name="sProWorkFlowCfm" routerKey="region" routerValue="<%=regCode%>" retcode="retCode1" retmsg="retMsg1" outnum="9">
	<wtc:param value="<%=printAccept%>"/>
	<wtc:param value="01"/>
	<wtc:param value="<%=opCode%>"/>
	<wtc:param value="<%=workNo%>"/>
	<wtc:param value="<%=noPass%>"/>
	<wtc:param value="<%=phoneNo%>"/>
	<wtc:param value=""/>
	<wtc:param value="CX"/>     <%/*01：订购及退订；CX：前台验证 */%>
  <wtc:param value="DXQM"/>   <%/* 企业代码 */%>
  <wtc:param value="DXQMCX"/> <%/*12：订购及退订；DXQMCX：前台验证 */%>
  <wtc:param value="06"/> 
  <wtc:param value=""/>
  <wtc:param value=""/>
  <wtc:param value="<%=currentTimeString%>"/>
  <wtc:param value=""/>
</wtc:service>
<wtc:array id="result1" scope="end"/>
<%
	if (!"000000".equals(retCode1)) {
%>
		<script language=javascript>
			rdShowMessageDialog("错误代码：<%=retCode1%><br><%=retMsg1%>", 0);
			window.location.href="fb600.jsp?opCode=<%=opCode%>&opName=<%=opName%>&activePhone=<%=phoneNo%>";
		</script>
<%
	}else{
		for (int i = 0; i < result.length; i ++) {
			for (int j = 0; j < result[i].length; j ++) {
				result[i][j] = result1[i][j];
			}
		}
	}
%>
<html>
<head>
<title><%=opName%></title>
<META content="MSHTML 5.00.3315.2870" name=GENERATOR>
<script language=javascript>
	function submitt() {
		var buttonSub = document.getElementById("cubmitt");
		buttonSub.disabled = "true";
		
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
		var phoneNo = document.getElementById("activePhone");
		
		var prop = "dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no";
		var path = "<%=request.getContextPath()%>/npage/innet/hljBillPrint_jc_hw.jsp?DlgMsg=" + DlgMessage+ "&submitCfm=" + submitCfm;
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
		
		cust_info+="手机号码：" + document.getElementById("activePhone").value + "|";
		cust_info+="客户姓名：" + document.getElementById("custName").value + "|";
		cust_info+="证件号码：" + document.getElementById("idNo").value + "|";
		cust_info+="客户地址：" + document.getElementById("custAddr").value + "|";
		
		opr_info += "业务受理时间：" + '<%=new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss", Locale.getDefault()).format(new java.util.Date())%>'
			+ "  " + "用户品牌: " + document.getElementById("smName").value + "|";
		opr_info += "办理业务：" + document.getElementById("opName").value + "  操作流水："+"<%=printAccept%>"+"|";
		
		document.getElementById("opNote").value = "工号<%=workNo%>为<%=phoneNo%>用户办理<%=opName%>。";
		note_info1 += "备注：工号<%=workNo%>为<%=phoneNo%>用户办理<%=opName%>。|";
		
		retInfo = strcat(cust_info, opr_info, note_info1, note_info2, note_info3, note_info4);
		retInfo = retInfo.replace(new RegExp("#","gm"), "%23");
		return retInfo;
	}
</script>
</head>
<body>

<form name="frm" action="fg734_cfm.jsp" method="POST">
<input type="hidden" name="opCode" id="opCode" value="<%=opCode%>">
<input type="hidden" name="opName" id="opName" value="<%=opName%>">
<input type="hidden" name="phoneNo" id="phoneNo" value="<%=phoneNo%>">
<input type="hidden" name="printAccept" id="printAccept" value="<%=printAccept%>">
<input type="hidden" name="opNote" id="opNote" value="">

<%@ include file="/npage/include/header.jsp" %>
<div class="title">
	<div name="title_zi" id="title_zi"><%=opName%></div>
</div>
<table cellspacing="0">
	<tr>
		<td class="blue" width="20%">
			客户姓名
		</td>
		<td width="30%">
			<input type="text" name="custName" id="custName" value="<%=result[0][0]%>" v_must="1" class="InputGrey" readonly>
		</td>
		<td class="blue" width="20%">
			用户号码
		</td>
		<td width="30%">
			<input type="text" name="activePhone" id="activePhone" value="<%=phoneNo%>" v_must="1" class="InputGrey" readonly>
		</td>
	</tr>
	<tr>
		<td class="blue">
			用户地址
		</td>
		<td>
			<input type="text" name="custAddr" id="custAddr" size="50" value="<%=result[0][1]%>" v_must="1" class="InputGrey" readonly>
		</td>
		<td class="blue">
			证件号码
		</td>
		<td>
			<input type="text" name="idNo" id="idNo" value="<%=result[0][2]%>" v_must="1" class="InputGrey" readonly>
		</td>
	</tr>
	<tr>
		<td class="blue">
			用户品牌
		</td>
		<td>
			<input type="text" name="smName" id="smName" value="<%=result[0][3]%>" v_must="1" class="InputGrey" readonly>
		</td>
		<td class="blue">
			用户归属
		</td>
		<td>
			<input type="text" name="belong" id="belong" value="<%=result[0][4]%>" v_must="1" class="InputGrey" readonly>
		</td>
	</tr>
	<tr>
		<td class="blue">
			用户状态
		</td>
		<td colspan="3">
			<input type="text" name="userState" id="userState" value="<%=result[0][5]%>" v_must="1" class="InputGrey" readonly>
		</td>
	</tr>
</table>
<table cellspacing="0">
	<tr>
	    <td id="footer">
	      <input class="b_foot" type=button name="cubmitt" value="确定" onClick="submitt();">
	      <input class="b_foot" type=button name=qryPage value="关闭" onClick="removeCurrentTab();">
	    </td>
	</tr>
</table>
<%@ include file="/npage/include/footer_simple.jsp" %> 
</form>
</body>
</html>

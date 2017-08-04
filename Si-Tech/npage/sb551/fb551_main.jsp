<%
    /********************
     version v2.0
     开发商: si-tech
     *
     *create:wanghfa@2010-9-6 二人世界情侣号码
     *
     ********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<%@ page contentType="text/html; charset=GB2312" %>
<%@ include file="/npage/include/public_title_name.jsp" %>

<html>
<head>
<title>二人世界业务办理</title>
<META content="MSHTML 5.00.3315.2870" name=GENERATOR>
<%
	String opCode = WtcUtil.repStr(request.getParameter("opCode"), "");
	String opName = WtcUtil.repStr(request.getParameter("opName"), "");
	String workNo = (String)session.getAttribute("workNo");
	String noPass = (String)session.getAttribute("password");
	
	String loverPhone = WtcUtil.repStr(request.getParameter("loverPhone"), "");
	String qryType = "5";
	
	String result[][] = new String[1][20];
	
%>
	<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="phone" routerValue="<%=activePhone%>" id="loginAccept"/>
<%
	System.out.println("===========wanghfa=sB553Qry==0====== loginAccept = " + loginAccept);
	System.out.println("===========wanghfa=sB553Qry==1====== 渠道 = 01");
	System.out.println("===========wanghfa=sB553Qry==2====== opCode = " + opCode);
	System.out.println("===========wanghfa=sB553Qry==3====== workNo = " + workNo);
	System.out.println("===========wanghfa=sB553Qry==4====== noPass = " + noPass);
	System.out.println("===========wanghfa=sB553Qry==5====== 号码1 = " + activePhone);
	System.out.println("===========wanghfa=sB553Qry==6====== 密码1 = ");
	System.out.println("===========wanghfa=sB553Qry==7====== 查询类型 = " + qryType);
	System.out.println("===========wanghfa=sB553Qry==8====== 号码2 = " + loverPhone);
%>
	
	<wtc:service name="sB553Qry" routerKey="phone" routerValue="<%=activePhone%>" retcode="retCode1" retmsg="retMsg1" outnum="20">
		<wtc:param value="<%=loginAccept%>"/>
		<wtc:param value="01"/>
		<wtc:param value="<%=opCode%>"/>
		<wtc:param value="<%=workNo%>"/>
		<wtc:param value="<%=noPass%>"/>
		<wtc:param value="<%=activePhone%>"/>
		<wtc:param value=""/>
		<wtc:param value="<%=qryType%>"/>
		<wtc:param value="<%=loverPhone%>"/>
	</wtc:service>
	<wtc:array id="result1"  scope="end"/>
<%
	System.out.println("==========wanghfa============= sB553Qry : " + retCode1 + "," + retMsg1);
	
	if (!retCode1.equals("000000")) {
%>
		<script language="JavaScript">
			rdShowMessageDialog("sB553Qry代码：<%=retCode1%>，信息：<%=retMsg1%>",0);
			history.go(-1);
		</script>
<%
	} else {
		System.out.println("===========wanghfa======== result1 = " + result1.length);
		if (result1.length > 0) {
			for (int j = 0; j < result1[0].length; j ++) {
				System.out.println("==========wanghfa==================== result1[0]["+j+"] = " + result1[0][j]);
				result[0][j] = result1[0][j];
			}
		}
	}

%>

<script language=javascript>
	function submitt() {
		var buttonSub = document.getElementById("submitB");
		buttonSub.disabled = "true";
		
		var opCodeObj = document.getElementById("opCode");
		if (opCodeObj.value == "b551") {
			frm.action = "fb551_cfm.jsp";
		} else if (opCodeObj.value == "b552") {
			frm.action = "fb552_cfm.jsp";
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
		var sysAccept = "<%=loginAccept%>";
		var printStr  =  printInfo(printType);
		var mode_code = null;
		var fav_code = null;
		var area_code = null;
		var opCode = "<%=opCode%>";
		var phoneNo = document.getElementById("activePhone");
		
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
		
		cust_info+="手机号码：" + document.getElementById("activePhone").value + "|";
		cust_info+="客户姓名：" + document.getElementById("custName").value + "|";
		//cust_info+="证件号码：" + document.getElementById("id").value + "|";
		//cust_info+="客户地址：" + document.getElementById("custAddr").value + "|";
		
		opr_info += "业务受理时间：" + '<%=new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss", Locale.getDefault()).format(new java.util.Date())%>'
			+ "  " + "用户品牌: " + document.getElementById("smName").value + "|";
		opr_info += "办理业务：" + document.getElementById("opName").value + "  操作流水："+"<%=loginAccept%>"+"|";
		opr_info += "办理的情侣号码：" + document.getElementById("loverPhone").value + "|";
		opr_info += "|";
		opr_info += "情侣号码客户姓名：" + document.getElementById("loverName").value + "|";
		//opr_info += "情侣号码证件号码：" + document.getElementById("loverId").value + "|";
		//opr_info += "情侣号码客户地址：" + document.getElementById("loverCustAddr").value + "|";
		
		note_info1 += "备注：工号<%=workNo%>为<%=activePhone%>用户和<%=result[0][9]%>用户办理二人世界业务。|";
		note_info1 += "情侣号码变更每月仅允许变更一次，且免费。一个号码不能够与多个号码建立情侣绑定关系。|";

		retInfo = strcat(cust_info, opr_info, note_info1, note_info2, note_info3, note_info4);
		retInfo = retInfo.replace(new RegExp("#","gm"), "%23");
		return retInfo;
	}

</script>
</head>
<body>

<form name="frm" method="POST">
<input type="hidden" name="opCode" id="opCode" value="<%=opCode%>">
<input type="hidden" name="opName" id="opName" value="<%=opName%>">
<input type="hidden" name="opNote" id="opNote" value="">
<input type="hidden" name="loginAccept" id="loginAccept" value="<%=loginAccept%>">
<input type="hidden" name="custAddr" id="custAddr" value="<%=result[0][8]%>">
<input type="hidden" name="loverCustAddr" id="loverCustAddr" value="<%=result[0][17]%>">

<%@ include file="/npage/include/header.jsp" %>
<div class="title">
	<div id="title_zi">用户信息</div>
</div>
<table cellspacing="0">
	<tr>
		<td class="blue" width="20%">
			电话号码
		</td>
		<td width="30%">
			<input type="text" name="activePhone" id="activePhone" value="<%=result[0][0]%>" v_must="1" class="InputGrey" readonly>
		</td>
		<td class="blue"width="20%">
			客户姓名
		</td>
		<td width="30%">
			<input type="text" name="custName" id="custName" size="40" value="<%=result[0][2]%>" v_must="1" class="InputGrey" readonly>
		</td>
	</tr>
	<tr>
		<td class="blue" width="20%">
			业务品牌
		</td>
		<td width="30%">
			<input name="smName" id="smName" type="text" class="InputGrey" value="<%=result[0][3]%>" readonly>
		</td>
		<td class="blue" width="20%">
			<%=result[0][4]%>
		</td>
		<td width="30%">
			<input type="text" name="id" id="id" size="40" value="<%=result[0][5]%>" v_must="1" class="InputGrey" readonly>
		</td>
	</tr>
	<tr>
		<td class="blue" width="20%">
			主资费
		</td>
		<td width="30%" colspan="3">
			<input name="mainFee" id="mainFee" type="text" class="InputGrey" size="60" value="<%=result[0][6]%>--<%=result[0][7]%>" readonly>
		</td>
	</tr>
</table>

<div class="title">
	<div id="title_zi">情侣号码信息</div>
</div>
<table cellspacing="0">
	<tr>
		<td class="blue" width="20%">
			电话号码
		</td>
		<td width="30%">
			<input type="text" name="loverPhone" id="loverPhone" value="<%=result[0][9]%>" v_must="1" class="InputGrey" readonly>
		</td>
		<td class="blue"width="20%">
			客户姓名
		</td>
		<td width="30%">
			<input type="text" name="loverName" id="loverName" size="40" value="<%=result[0][11]%>" v_must="1" class="InputGrey" readonly>
		</td>
	</tr>
	<tr>
		<td class="blue" width="20%">
			业务品牌
		</td>
		<td width="30%">
			<input name="loverSmName" id="loverSmName" type="text" class="InputGrey" value="<%=result[0][12]%>" readonly>
		</td>
		<td class="blue" width="20%">
			<%=result[0][13]%>
		</td>
		<td width="30%">
			<input type="text" name="loverId" id="loverId" size="40" value="<%=result[0][14]%>" v_must="1" class="InputGrey" readonly>
		</td>
	</tr>
	<tr>
		<td class="blue" width="20%">
			主资费
		</td>
		<td width="30%" colspan="3">
			<input name="loverMainFee" id="loverMainFee" type="text" class="InputGrey" size="60" value="<%=result[0][15]%>--<%=result[0][16]%>" readonly>
		</td>
	</tr>
</table>

<table cellspacing="0">
	<tr>
	    <td colspan="3" id="footer">
	      <input class="b_foot" type=button name="submitB" id="submitB" value="确定" onClick="submitt();">
	      <input class="b_foot" type=button name="" id="" value="返回" onClick="window.location = 'fb551.jsp?activePhone=<%=activePhone%>&opCode=<%=opCode%>&opName=<%=opName%>';">
	      <input class="b_foot" type=button name="" value="关闭" onClick="parent.removeTab('<%=opCode%>')">
	    </td>
	</tr>
</table>
<%@ include file="/npage/include/footer_simple.jsp" %>
</form>
</body>
</html>

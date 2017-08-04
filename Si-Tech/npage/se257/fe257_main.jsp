<%
  /*
   * 功能: 充值卡营销案转赠
   * 版本: 1.0
   * 日期: 20110908
   * 作者: wanghfa
   * 版权: si-tech
  */
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html  xmlns="http://www.w3.org/1999/xhtml">

<%
  response.setHeader("Pragma","No-Cache"); 
  response.setHeader("Cache-Control","No-Cache");
  response.setDateHeader("Expires", 0); 
  request.setCharacterEncoding("GBK");
%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ include file="/npage/common/pwd_comm.jsp" %>
<%@ page contentType="text/html;charset=GBK"%>
<%@ page import="java.util.*"%>
<%@ page import="java.text.*" %>
<%@ include file="/npage/common/pwd_comm.jsp" %>
<%
String opCode = request.getParameter("opCode");
String opName = request.getParameter("opName");
String workNo = (String)session.getAttribute("workNo");
String password = (String)session.getAttribute("password");
String result[] = new String[12];

System.out.println("====fe257_main.jsp====wanghfa==== opCode = " + opCode);
System.out.println("====fe257_main.jsp====wanghfa==== opName = " + opName);
%>
<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="phone" routerValue="<%=activePhone%>" id="printAccept"/>
<%
System.out.println("====wanghfa====fe257_main.jsp====se257Qry====0==== iLoginAccept = " + printAccept);
System.out.println("====wanghfa====fe257_main.jsp====se257Qry====1==== iChnSource = 01");
System.out.println("====wanghfa====fe257_main.jsp====se257Qry====2==== iOpCode = " + opCode);
System.out.println("====wanghfa====fe257_main.jsp====se257Qry====3==== iLoginNo = " + workNo);
System.out.println("====wanghfa====fe257_main.jsp====se257Qry====4==== iLoginPwd = " + password);
System.out.println("====wanghfa====fe257_main.jsp====se257Qry====5==== iPhoneNo = " + activePhone);
System.out.println("====wanghfa====fe257_main.jsp====se257Qry====6==== iUserPwd = ");
%>
<wtc:service name="se257Qry" routerKey="phone" routerValue="<%=activePhone%>" retcode="retCode1" retmsg="retMsg1" outnum="12">
	<wtc:param value="<%=printAccept%>"/>
	<wtc:param value="01"/>
	<wtc:param value="<%=opCode%>"/>
	<wtc:param value="<%=workNo%>"/>
	<wtc:param value="<%=password%>"/>
	<wtc:param value="<%=activePhone%>"/>
	<wtc:param value=""/>
</wtc:service>
<wtc:array id="result1" start="0" length="9" scope="end"/>
<%
System.out.println("====wanghfa=====fe257_main.jsp====se257Qry : " + retCode1 + "," + retMsg1);

if (!retCode1.equals("000000")) {
	%>
	<script language="JavaScript">
		rdShowMessageDialog("se257Qry服务：<%=retCode1%>，<%=retMsg1%>",0);
		history.go(-1);
	</script>
	<%
} else {
	if (result1[0].length > 0) {
		for (int j = 0; j < result1[0].length; j ++) {
			System.out.println("====wanghfa=====fe257_main.jsp====se257Qry==== result1[0]["+j+"] = " + result1[0][j]);
			result[j] = result1[0][j];
		}
	}
}
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title><%=opName%></title>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">

<script language=javascript>
	window.onload = function() {
		moneyChange();
	}
	
	function moneyChange() {
		var prePayFeeObj = document.getElementById("prePayFee");
		var presentFeeObj = document.getElementById("presentFee");
		var myFeeObj = document.getElementById("myFee");
		
		var toPhone1Obj = document.getElementById("toPhone1");
		var toPhone2Obj = document.getElementById("toPhone2");
		var toPhone3Obj = document.getElementById("toPhone3");
		var toFee1Obj = document.getElementById("toFee1");
		var toFee2Obj = document.getElementById("toFee2");
		var toFee3Obj = document.getElementById("toFee3");
		
		if (toFee1Obj.value.trim().length == 0 || toPhone1Obj.value.trim().length == 0) {
			toFee1Obj.value = "0";
		}
		if (toFee2Obj.value.trim().length == 0 || toPhone2Obj.value.trim().length == 0) {
			toFee2Obj.value = "0";
		}
		if (toFee3Obj.value.trim().length == 0 || toPhone3Obj.value.trim().length == 0) {
			toFee3Obj.value = "0";
		}
		
		if (!checkElement(document.getElementById("toFee1"))) {
			document.getElementById("toFee1").focus();
			return false;
		} else if (!checkElement(document.getElementById("toFee2"))) {
			document.getElementById("toFee2").focus();
			return false;
		} else if (!checkElement(document.getElementById("toFee3"))) {
			document.getElementById("toFee3").focus();
			return false;
		}
		
		presentFeeObj.value = parseInt(toFee1Obj.value) + parseInt(toFee2Obj.value) + parseInt(toFee3Obj.value);
		myFeeObj.value = parseInt(prePayFeeObj.value) - parseInt(presentFeeObj.value);
	}
	
	function controlBtn(flag) {
		$("#submitBtn").attr("disabled", flag);
		$("#backBtn").attr("disabled", flag);
		$("#closeBtn").attr("disabled", flag);
	}
	
	function doCfm() {
		controlBtn(true);
		
		var prePayFeeObj = document.getElementById("prePayFee");
		var presentFeeObj = document.getElementById("presentFee");
		var myFeeObj = document.getElementById("myFee");
		
		var toPhone1Obj = document.getElementById("toPhone1");
		var toPhone2Obj = document.getElementById("toPhone2");
		var toPhone3Obj = document.getElementById("toPhone3");
		var toFee1Obj = document.getElementById("toFee1");
		var toFee2Obj = document.getElementById("toFee2");
		var toFee3Obj = document.getElementById("toFee3");
		
		if (toPhone1Obj.value.trim().length == 0) {
			toFee1Obj.value = "0";
		}
		if (toPhone2Obj.value.trim().length == 0) {
			toFee2Obj.value = "0";
		}
		if (toPhone3Obj.value.trim().length == 0) {
			toFee3Obj.value = "0";
		}

		if (toPhone1Obj.value.trim().length == 0 && toPhone2Obj.value.trim().length == 0 && toPhone3Obj.value.trim().length == 0) {
			rdShowMessageDialog("至少有一个转赠号码！", 1);
			controlBtn(false);
			return false;
		}
		if ((toPhone1Obj.value.trim().length != 11 && toPhone1Obj.value.trim().length != 0) ||
			 (toPhone2Obj.value.trim().length != 11 && toPhone2Obj.value.trim().length != 0) ||
			 (toPhone3Obj.value.trim().length != 11 && toPhone3Obj.value.trim().length != 0)) {
			rdShowMessageDialog("转赠号码必须为11位数字！", 1);
			controlBtn(false);
			return false;
		}
		if ("<%=activePhone%>" == toPhone1Obj.value || "<%=activePhone%>" == toPhone2Obj.value ||
			 "<%=activePhone%>" == toPhone3Obj.value ||
			 (toPhone1Obj.value.length != 0 & toPhone2Obj.value.length != 0 && toPhone1Obj.value == toPhone2Obj.value) ||
			 (toPhone1Obj.value.length != 0 & toPhone3Obj.value.length != 0 && toPhone1Obj.value == toPhone3Obj.value) ||
			 (toPhone2Obj.value.length != 0 & toPhone3Obj.value.length != 0 && toPhone2Obj.value == toPhone3Obj.value)) {
			rdShowMessageDialog("办理号码，各赠送号码不允许重复！", 1);
			controlBtn(false);
			return false;
		}
		
		if (parseInt(prePayFeeObj.value) <= 0) {
			rdShowMessageDialog("该营销案不赠送金额，不允许办理此业务！", 1);
			controlBtn(false);
			return false;
		} else if (parseInt(presentFeeObj.value) <= 0) {
			rdShowMessageDialog("赠送金额必须大于0！", 1);
			controlBtn(false);
			return false;
		} else if (parseInt(myFeeObj.value) < 0) {
			rdShowMessageDialog("剩余金额必须大于或等于0！", 1);
			controlBtn(false);
			return false;
		} else if (parseInt(myFeeObj.value) < 0) {
			rdShowMessageDialog("剩余金额必须大于或等于0！", 1);
			controlBtn(false);
			return false;
		}
		
		if (toPhone1Obj.value.trim().length > 0) {
			if (!checkElement(toPhone1Obj)) {
				controlBtn(false);
				return false;
			} else if (parseInt(toFee1Obj.value) <= 0 || (parseInt(toFee1Obj.value) % 100) != 0) {
				rdShowMessageDialog("转赠" + toPhone1Obj.value + "的金额必须是大于0的整百金额！", 1);
				toFee1Obj.focus();
				controlBtn(false);
				return false;
			}
		} else {
			toFee1Obj.value = "";
		}
		if (toPhone2Obj.value.trim().length > 0) {
			if (!checkElement(toPhone2Obj)) {
				controlBtn(false);
				return false;
			} else if (parseInt(toFee2Obj.value) <= 0 || (parseInt(toFee2Obj.value) % 100) != 0) {
				rdShowMessageDialog("赠送" + toPhone2Obj.value + "的金额必须是大于0的整百金额！", 1);
				toFee2Obj.focus();
				controlBtn(false);
				return false;
			}
		} else {
			toFee2Obj.value = "";
		}
		if (toPhone3Obj.value.trim().length > 0) {
			if (!checkElement(toPhone3Obj)) {
				controlBtn(false);
				return false;
			} else if (parseInt(toFee3Obj.value) <= 0 || (parseInt(toFee3Obj.value) % 100) != 0) {
				rdShowMessageDialog("赠送" + toPhone3Obj.value + "的金额必须是大于0的整百金额！", 1);
				toFee3Obj.focus();
				controlBtn(false);
				return false;
			}
		} else {
			toFee3Obj.value = "";
		}
		
		
		var ret = showPrtDlg("Detail", "确实要进行电子免填单打印吗？","Yes");	//打印免填单
		cfm();
	}
	
	function cfm() {
		
		if (rdShowConfirmDialog("确认要进行此项服务吗？") == 1) {
			document.frm.submit();
		} else {
			controlBtn(false);
			return false;
		}
	}

	
	function showPrtDlg(printType, DlgMessage, submitCfm)
	{  //显示打印对话框
		var h=210;
		var w=400;
		var t=screen.availHeight/2-h/2;
		var l=screen.availWidth/2-w/2;

		var pType="subprint";                                      // 打印类型：print 打印 subprint 合并打印
		var billType="1";                                          //  票价类型：1电子免填单、2发票、3收据
		var sysAccept="<%=printAccept%>";                          // 流水号
		var printStr=printInfo(printType);                         //调用printinfo()返回的打印内容
		var mode_code=null;                                        //资费代码
		var fav_code=null;                                         //特服代码
		var area_code=null;                                        //小区代码
		var opCode="<%=opCode%>";                                  //操作代码
		var phoneNo="<%=activePhone%>";         					        //客户电话

		var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no";
		var path = "<%=request.getContextPath()%>/npage/innet/hljBillPrint_jc.jsp?DlgMsg=" + DlgMessage+ "&submitCfm=" + submitCfm;
		path=path+"&mode_code="+mode_code+"&fav_code="+fav_code+"&area_code="+area_code+"&opCode="+opCode+"&sysAccept="+sysAccept+"&phoneNo="+phoneNo+"&submitCfm="+submitCfm+"&pType="+pType+"&billType="+billType+ "&printInfo=" + printStr;
		var ret=window.showModalDialog(path,printStr,prop);
		return ret;
	}
	
	function printInfo(printType) {
		var toPhone1Obj = document.getElementById("toPhone1");
		var toPhone2Obj = document.getElementById("toPhone2");
		var toPhone3Obj = document.getElementById("toPhone3");
		var toFee1Obj = document.getElementById("toFee1");
		var toFee2Obj = document.getElementById("toFee2");
		var toFee3Obj = document.getElementById("toFee3");
		
		var exeDate = "<%=new java.text.SimpleDateFormat("yyyy-MM-dd", Locale.getDefault()).format(new java.util.Date())%>";//得到执行时间
		var retInfo = "";
		var cust_info="";
		var opr_info="";
		var note_info1="";
		var note_info2="";
		var note_info3="";
		var note_info4="";
		
		cust_info+="手机号码：" + document.getElementById("activePhone").value + "|";
		cust_info+="客户姓名：" + document.getElementById("custName").value + "|";
		//cust_info+="证件号码："+ "|";
		//cust_info+="客户地址："+ "|";
		opr_info += "业务名称：<%=opName%>          业务流水：<%=printAccept%>" + "|";
		opr_info += "客户参与营销活动名称：" + document.getElementById("projectName").value + "|";
		opr_info += "赠送话费金额：<%=result[2]%>" + "|";
		var presentNo = 0;
		if (toPhone1Obj.value.trim().length != 0) {
			presentNo ++;
		}
		if (toPhone2Obj.value.trim().length != 0) {
			presentNo ++;
		}
		if (toPhone3Obj.value.trim().length != 0) {
			presentNo ++;
		}
		
		opr_info += "转赠人数：" + presentNo + "          转赠金额：" + document.getElementById("presentFee").value + "|";
		opr_info += "转赠号码及金额明细：" + "|";
		if (toPhone1Obj.value.trim().length != 0) {
			opr_info += toPhone1Obj.value + "   " + toFee1Obj.value + "元|";
		}
		if (toPhone2Obj.value.trim().length != 0) {
			opr_info += toPhone2Obj.value + "   " + toFee2Obj.value + "元|";
		}
		if (toPhone3Obj.value.trim().length != 0) {
			opr_info += toPhone3Obj.value + "   " + toFee3Obj.value + "元|";
		}
		
		document.getElementById("opNote").value = "工号<%=workNo%>为<%=activePhone%>用户办理<%=opName%>。";
		
		note_info1 += ""+"|";
		retInfo = strcat(cust_info, opr_info, note_info1, note_info2, note_info3, note_info4);
		retInfo = retInfo.replace(new RegExp("#","gm"), "%23");
		return retInfo;
	}

</script>
</head>
<body>

<form name="frm" method="POST" action="fe257_cfm.jsp">
<input type="hidden" name="opCode" id="opCode" value="<%=opCode%>">
<input type="hidden" name="opName" id="opName" value="<%=opName%>">
<input type="hidden" name="opNote" id="opNote" value="">
<input type="hidden" name="printAccept" id="printAccept" value="<%=printAccept%>">
<input type="hidden" name="projectCode" id="projectCode" value="<%=result[3]%>">
<input type="hidden" name="sGradeCode" id="sGradeCode" value="<%=result[4]%>">
<input type="hidden" name="partInAccept" id="partInAccept" value="<%=result[5]%>">
<input type="hidden" name="custAddr" id="custAddr" value="<%=result[7]%>">
<input type="hidden" name="idIccId" id="idIccId" value="<%=result[8]%>">

<%@ include file="/npage/include/header.jsp" %>
<div class="title">
	<div id="title_zi">办理信息</div>
</div>
<table>
	<tr>
		<td class="blue" width="20%">
			电话号码
		</td>
		<td width="30%">
			<input type="text" name="activePhone" id="activePhone" value="<%=activePhone%>" class="InputGrey" readonly>
		</td>
		<td class="blue" width="20%">
			客户姓名
		</td>
		<td width="30%">
			<input type="text" name="custName" id="custName" value="<%=result[6]%>" class="InputGrey" readonly>
		</td>
	</tr>
	<tr>
		<td class="blue" width="20%">
			营销案活动名称
		</td>
		<td colspan="3">
			<%=result[0]%>
			<input name="projectName" id="projectName" type="hidden" value="<%=result[0]%>">
		</td>
	</tr>
	<tr>
		<td class="blue" width="20%">
			参与时间
		</td>
		<td width="30%">
			<%=result[1].substring(0,4)%>年<%=result[1].substring(4,6)%>月<%=result[1].substring(6,8)%>日
			<input type="hidden" name="partInTime" id="partInTime" value="<%=result[1]%>" class="InputGrey" readonly>
		</td>
		<td class="blue" width="20%">
			赠送话费金额
		</td>
		<td width="30%">
			<input type="text" name="prePayFee" id="prePayFee" size="10" value="<%=result[2]%>" class="InputGrey" readonly>元
		</td>
	</tr>
	<tr>
		<td class="blue" width="20%">
			转赠总金额
		</td>
		<td width="30%">
			<input type="text" name="presentFee" id="presentFee" size="10" value="" class="InputGrey" readonly>元
		</td>
		<td class="blue" width="20%">
			剩余金额
		</td>
		<td width="30%">
			<input type="text" name="myFee" id="myFee" size="10" value="" class="InputGrey" readonly>元
		</td>
	</tr>
</table>
<br/>
<div class="title">
	<div id="title_zi">录入转增信息</div>
</div>
<table>
	<tr>
		<th width="10%">序号</th>
		<th width="40%">转增手机号码</th>
		<th width="50%">转增金额</th>
	</tr>
	<%
	for (int i = 0; i < 3; i ++) {
		%>
		<tr>
		  <td><%=i+1%></td>
		  <td>
		  	<input type="text" name="toPhone<%=i+1%>" id="toPhone<%=i+1%>" size="12" value="" maxlength="11" v_type="0_9" v_maxlength="11">
		  </td>
		  <td>
		  	<input type="text" name="toFee<%=i+1%>" id="toFee<%=i+1%>" size="10" value="0" v_type="0_9" onchange="moneyChange();">元
		  </td>
		</tr>
		<%
	}
	%>
</table>
<table>
	<tr>
		<td colspan="4" id="footer">
			<input class="b_foot" type=button name="submitBtn" id="submitBtn" value="确定" onClick="doCfm();">
			<input class="b_foot" type=button name="backBtn" id="backBtn" value="返回" onClick="window.location = 'fe257.jsp?activePhone=<%=activePhone%>&opCode=<%=opCode%>&opName=<%=opName%>';">
			<input class="b_foot" type=button name="closeBtn" id="closeBtn" value="关闭" onClick="removeCurrentTab();">
		</td>
	</tr>
</table>
</DIV>
</DIV>

</form>
</body>
</html>

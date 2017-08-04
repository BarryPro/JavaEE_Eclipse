<%
  /*
   * 功能: 关于与浦发银行合作实现手机钱包联名卡产品业务支撑系统改造需求
   * 版本: 1.0
   * 日期: 20110524
   * 作者: 王怀峰wanghfa
   * 版权: si-tech
  */
%>
<!DOCTYPE html PUBLIC "-//W3C//Dtd Xhtml 1.0 transitional//EN" "http://www.w3.org/tr/xhtml1/Dtd/xhtml1-transitional.dtd">
<%@	page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>移动营业厅开联名卡</title>
<META content=no-cache http-equiv=Pragma>
<META content=no-cache http-equiv=Cache-Control>
<META content="MSHTML 5.00.3315.2870" name=GENERATOR>
<%
	String opCode = request.getParameter("opCode");
	String opName = request.getParameter("opName");
	String workNo = (String)session.getAttribute("workNo");
  String password = (String)session.getAttribute("password");
	String idCardType = request.getParameter("idCardType");
	String idIccid = request.getParameter("idIccid");
	String custName = request.getParameter("custName");
	String[] result = new String[6];
	String idCardTypeText = new String();
	String noPhoto = "/9j/4AAQSkZJRgABAQEAYABgAAD/2wBDAAMCAgMCAgMDAwMEAwMEBQgFBQQEBQoHBwYIDAoMDAsK" +
		"CwsNDhIQDQ4RDgsLEBYQERMUFRUVDA8XGBYUGBIUFRT/2wBDAQMEBAUEBQkFBQkUDQsNFBQUFBQU" +
		"FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBT/wAARCABcAFADASIA" +
		"AhEBAxEB/8QAHwAAAQUBAQEBAQEAAAAAAAAAAAECAwQFBgcICQoL/8QAtRAAAgEDAwIEAwUFBAQA" +
		"AAF9AQIDAAQRBRIhMUEGE1FhByJxFDKBkaEII0KxwRVS0fAkM2JyggkKFhcYGRolJicoKSo0NTY3" +
		"ODk6Q0RFRkdISUpTVFVWV1hZWmNkZWZnaGlqc3R1dnd4eXqDhIWGh4iJipKTlJWWl5iZmqKjpKWm" +
		"p6ipqrKztLW2t7i5usLDxMXGx8jJytLT1NXW19jZ2uHi4+Tl5ufo6erx8vP09fb3+Pn6/8QAHwEA" +
		"AwEBAQEBAQEBAQAAAAAAAAECAwQFBgcICQoL/8QAtREAAgECBAQDBAcFBAQAAQJ3AAECAxEEBSEx" +
		"BhJBUQdhcRMiMoEIFEKRobHBCSMzUvAVYnLRChYkNOEl8RcYGRomJygpKjU2Nzg5OkNERUZHSElK" +
		"U1RVVldYWVpjZGVmZ2hpanN0dXZ3eHl6goOEhYaHiImKkpOUlZaXmJmaoqOkpaanqKmqsrO0tba3" +
		"uLm6wsPExcbHyMnK0tPU1dbX2Nna4uPk5ebn6Onq8vP09fb3+Pn6/9oADAMBAAIRAxEAPwD9I9lG" +
		"ypdvtRt9q7TyrEWyjZUu32o2+1AWItlGypdvtRt9qAsRbKNlS7fajb7UBYi2UbKl2+1G32oCxNsF" +
		"GwVNto21BpYh2CsLxB4jTSm+z26rNdkZYMfljHq2O/oP5VtaneJpmnXV5JykETSEDvgZxXkVzPLO" +
		"X81t0rsXmYfxOeW/DPAHoK+M4lzuWVUYwo/xJ7eS7n0OUZdHGTc6nwr8Wbdlcal4m1EWcV/NJOVL" +
		"HZKYI1A68pz39zVKHxRqWk3Uka3Ukhjco8V0fNQkHB+b7w6ev4VqfDFkh8VFScGS1kRc9zuQ/wAg" +
		"a5vV7iCfWdRkV8q91MwPqDIxFfmdbH4ylgKWPjXkqkpyT1eytb+vM+whh6M608PKmuVJPbvc9L8O" +
		"+IrbxFC5jBhuIv8AWQOclc9CD3B9a19gryLRNSbRNXtbtHIi3hJRnhoycNn6feHuK9j21+qcN5xL" +
		"OMI51f4kXaX6P5/mfFZtgI4GsvZ/DLb9UQ7BRsFTbaNtfVnh2J9lGypdvtRt9qk1sYHjO2efwrqq" +
		"xgs4t2YAd8DOP0rxM6hKrsARjJNfRbRhgQQCDwQa8M8Y+FJfDmqtGsbfZJTm2kPIYf3M/wB4encD" +
		"PrX5bxtgatSNPGU1dR0fl2f9eR9tw7iKcefDz3eq/UZ4O1mLSPFNhfXkrpbxlxKyqWwDGwHA5PJF" +
		"YSM4Rd7Evj5iT1Pet/wTe6NY64X12FJLPyWUCWEyqHyuCVAOeNw6HrWRfvDcahdGzjK2zTOYUI5V" +
		"Nx2j8sV+ZVYyeX0k5p+9J8v2ldR1flpp8/l9hFpYiT5WtFr00b289dfkRRebdN9mQktL+7Uf7TfK" +
		"P1Ir6L2V5d8NfB8l3eQ6tcJi0hO6Ld/y0fsR7Drnucelerbfav13gzL6mEwk61VW9o1ZeS2fzuz4" +
		"XiHEwr1o0ofZvf1dtPwItlGypdvtRt9q/Qj5OxJto207bRtqS7Ddtc54otNSvbSWCCCG4hcYKSrk" +
		"H610uKXaalpSVmUrxd0fPOpeEfF0U5+z6XE0eeFJzj8Tk/rV7w/4N8SvcK19pcDJnOx/u/QgYB/H" +
		"Ne77aXy29K8aOS5bGp7VUI39P02PReY4tx5HUdv667mZo6XiW6rdKiYAAVBjA9K0NtP2Gjaa9o80" +
		"Zto207bRtpisLupQwyKr+ZR5lAzwG7u9RsNUntJF1K0ZpY1vJZJpnkBADHeYbx9+1Cg53MVwAAea" +
		"6vQILuLw8Z9N0SPXLK5uZHY2d1LpzIY2Zd8pmnZ23A52nG0qd2TjGnr3wb0vxFrd9qdzqN9FLdSC" +
		"Qxwx25VcIq4BeJj/AA5696tp8NYovDdr4eTV7xNFWSVryGNUjkvEZtwiZ1A2JyQwQAsOMgEg/n+F" +
		"yWvQq1LwvH3uXWLestN7rVN3vF/fY+4r5jhatKFp+9pzK0rba7Wd07Ws191zmfCmu6jqjNPY+FJt" +
		"RkhlWYNB4hA8pWO+NSGf5htxyRhh7Vw1rJpL2wk8rQJLdGt958wJGHMTsFZ5HRQflJcbgSQFBGcj" +
		"17xF8MbfX7q+A1S6sdL1BYVvtNghhMcyxABAGZCyDCgcGrcfgC3t4o0t9W1W38uK2RSlyWw8LErJ" +
		"82eSCQV+4QeVJwRlLIcRNQg9oX1tD3r6aJJbpK/M3+GtQzTCQ5pp6ytp72ne7d+t7cq/F6cKt7Zn" +
		"4eaRPp0dvBJba+Hjkjt2uoBMqu+6OOF2ZkxwArkkZOea1/BV9q+p+LLy5t9W0p7y4EEmpxS6Be2j" +
		"PAhZV8rzXXacFhk7xnnAHFdNp3gKz0/W7LUft1/dCyNwbW2uZQ8cLTEbmBxuYgAqC7MQGOMVrJo0" +
		"SeJp9a82Qzy2cdl5XGwKkkj7vXJMmPwr1cNlWIpzpym7KLWiv0ha+jtvpaz0166edXzDDyhOMNW0" +
		"3dpbuV7aq+2u6V/x2d1G6oPMo8yvsD5Yo/avpR9q+lQeWPejyx71djLmJ/tX0o+1fSoPLHvR5Y96" +
		"LBzE/wBq+lH2r6VB5Y96PLHvRYOYn+1fSj7V9Kg8se9Hlj3osHMT/avpR9q+lQeWPejyx70WDmP/" +
		"2Q==";
	
%>
	<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="phone" routerValue="<%=activePhone%>" id="printAccept"/>
<%
	System.out.println("====wanghfa====fd877_main.jsp====sD877Init====0==== iLoginAccept = 0");
	System.out.println("====wanghfa====fd877_main.jsp====sD877Init====1==== iChnSource = 01");
	System.out.println("====wanghfa====fd877_main.jsp====sD877Init====2==== iOpCode = " + opCode);
	System.out.println("====wanghfa====fd877_main.jsp====sD877Init====3==== iLoginNo = " + workNo);
	System.out.println("====wanghfa====fd877_main.jsp====sD877Init====4==== iLoginPwd = " + password);
	System.out.println("====wanghfa====fd877_main.jsp====sD877Init====5==== iPhoneNo = " + activePhone);
	System.out.println("====wanghfa====fd877_main.jsp====sD877Init====6==== iUserPwd = ");
	System.out.println("====wanghfa====fd877_main.jsp====sD877Init====7==== iOpNote = ");
	System.out.println("====wanghfa====fd877_main.jsp====sD877Init====8==== iIdCardType = " + idCardType);
	System.out.println("====wanghfa====fd877_main.jsp====sD877Init====9==== iIdCardNum = " + idIccid);
	System.out.println("====wanghfa====fd877_main.jsp====sD877Init===10==== iIdCardName = " + custName);
	%>
		<wtc:service name="sD877Init" routerKey="phone" routerValue="<%=activePhone%>" retcode="retCode1" retmsg="retMsg1" outnum="6">
			<wtc:param value="0"/>
			<wtc:param value="01"/>
			<wtc:param value="<%=opCode%>"/>
			<wtc:param value="<%=workNo%>"/>
			<wtc:param value="<%=password%>"/>
			<wtc:param value="<%=activePhone%>"/>
			<wtc:param value=""/>
			<wtc:param value=""/>
			<wtc:param value="<%=idCardType%>"/>
			<wtc:param value="<%=idIccid%>"/>
			<wtc:param value="<%=custName%>"/>
		</wtc:service>
		<wtc:array id="result1"  scope="end"/>
	<%
	System.out.println("====wanghfa====fd877_main.jsp====sD877Init==== " + retCode1 + "," + retMsg1);
	
	if (!(retCode1.equals("000000"))) {
%>
		<script language="JavaScript">
			rdShowMessageDialog("sD877Init代码：<%=retCode1%>，信息：<%=retMsg1%>",0);
			history.go(-1);
		</script>
<%
	} else {
		System.out.println("====wanghfa====fd877_main.jsp====sD877Init==== result1.length = " + result1.length);
		if (result1.length > 0) {
			for (int j = 0; j < result1[0].length; j ++) {
				System.out.println("====wanghfa====fd877_main.jsp====sD877Init==== result1[0]["+j+"] = " + result1[0][j]);
				result[j] = result1[0][j];
			}
			if ("01".equals(result[0])) {
				idCardTypeText = "18位身份证";
			} else if ("02".equals(result[0])) {
				idCardTypeText = "15位身份证";
			}
		}
		if (result[4] == null || "".equals(result[4])) {
			result[4] = noPhoto;
		}
	}
%>
<script language="javascript">

	window.onload=function() {
		displayOnIt(document.getElementById("AuthFlag"));
		document.frm.target = "photoIframe";
		document.frm.action = "photo.jsp";
		document.frm.submit();
	}
	
	function displayOnIt(obj) {
		if (obj.id == "AuthFlag") {
			if (obj.value == "0") {
				document.getElementById("authFailReasonTR").style.display = "";
				document.getElementById("authSuccessTR").style.display = "none";
				document.getElementById("yearIncomeTR").style.display = "none";
			} else if (obj.value == "1") {
				document.getElementById("authFailReasonTR").style.display = "none";
				document.getElementById("authSuccessTR").style.display = "";
				displayOnIt(document.getElementById("creditFlag"));
			}
		} else if (obj.id == "creditFlag") {
			if (obj.value == "0") {
				document.getElementById("yearIncomeTR").style.display = "none";
			} else if (obj.value == "1") {
				document.getElementById("yearIncomeTR").style.display = "";
			}
		}
	}
	
	function controlBtn(flag) {
		$("#submitBtn").attr("disabled", flag);
		$("#backBtn").attr("disabled", flag);
		$("#closeBtn").attr("disabled", flag);
	}
	
	function showPrtDlg(printType, DlgMessage, submitCfm) {  //显示打印对话框
		var h = 210;
		var w = 400;
		var t = screen.availHeight / 2 - h / 2;
		var l = screen.availWidth / 2 - w / 2;
		
		var pType = "subprint";
		var billType = "1";
		var sysAccept = "<%=printAccept%>";
		var printStr = printInfo(printType);
		var mode_code = null;
		var fav_code = null;
		var area_code = null;
		var opCode = "<%=opCode%>";
		var phoneNo = "<%=activePhone%>";
		
		var prop = "dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no";
		var path = "<%=request.getContextPath()%>/npage/innet/hljBillPrint_jc.jsp?DlgMsg=" + DlgMessage + "&submitCfm=" + submitCfm;
		path = path + "&mode_code="+mode_code+"&fav_code="+fav_code+"&area_code="+area_code+"&opCode="+opCode+"&sysAccept="+sysAccept+"&phoneNo="+phoneNo+"&submitCfm="+submitCfm+"&pType="+pType+"&billType="+billType+ "&printInfo=" + printStr;
		
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
		//var note_info4="";
		
		cust_info+="手机号码：<%=activePhone%>|";
		cust_info+="客户姓名：<%=result[2]%>" + "|";
		//cust_info+="证件号码：" + document.getElementById("idCardNo").value + "|";
		//cust_info+="客户地址：" + document.getElementById("custAddr").value + "|";
		
		opr_info += "操作流水:"+'<%=printAccept%>'+"|";
		opr_info += "操作时间:"+'<%=new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss", Locale.getDefault()).format(new java.util.Date())%>'+"|";
		opr_info += "|";
		
		document.getElementById("opNote").value = "工号<%=workNo%>为<%=activePhone%>用户办理<%=opName%>。";
		
		note_info1 += "备注：" + "|";


		retInfo = strcat(cust_info, opr_info, note_info1, note_info2, note_info3);//, note_info4);
		retInfo = retInfo.replace(new RegExp("#","gm"), "%23");
		return retInfo;
	}
	
	function submitt() {
		controlBtn(true);
		var inputDate = new Date(Date.parse(document.getElementById("maturity").value.substr(0,4)+"/"+document.getElementById("maturity").value.substr(4,2)+"/"+document.getElementById("maturity").value.substr(6,2)));
		var nowDate = new Date("<%=new java.text.SimpleDateFormat("yyyy", Locale.getDefault()).format(new java.util.Date())%>/<%=new java.text.SimpleDateFormat("MM", Locale.getDefault()).format(new java.util.Date())%>/<%=new java.text.SimpleDateFormat("dd", Locale.getDefault()).format(new java.util.Date())%>");
		
		if (document.getElementById("AuthFlag").value == "1") {
			if (!checkElement(document.getElementById("maturity"))) {
				controlBtn(false);
				return false;
			} else if (!forDate(document.getElementById("maturity"))) {
				rdShowMessageDialog("请输入正确的证件有效期到期日日期格式！", 1);
				controlBtn(false);
				return false;
			} else if (((inputDate - nowDate)/86400000) <= 90) {
				rdShowMessageDialog("输入的证件有效期到期日已失效，或在90天(包含90天)内失效，请确认输入证件有效期到期日！", 1);
				controlBtn(false);
				return false;
			}
		}
		
		if (document.getElementById("creditFlag").value == "1") {
			if (!checkElement(document.getElementById("yearIncome"))) {
				controlBtn(false);
				return false;
			}
		} else {
			document.getElementById("yearIncome").value = "";
		}
		
		document.frm.target = "_self";
		document.frm.action = "fd877_cfm.jsp";
		var ret = showPrtDlg("Detail", "确实要进行电子免填单打印吗？","Yes");	//打印免填单
		
		if(typeof(ret) != "undefined"){
			if (rdShowConfirmDialog("确认要进行此项服务吗？") == 1) {
				document.frm.submit();
			} else {
				controlBtn(false);
			}
		} else {
			if (rdShowConfirmDialog("确认要进行此项服务吗？") == 1) {
				document.frm.submit();
			} else {
				controlBtn(false);
			}
		}
	}
</script>
</head>
<body>
<form name="frm" method="POST" >
 	<input type="hidden" name="opCode" id="opCode" value="<%=opCode%>">
 	<input type="hidden" name="opName" id="opName" value="<%=opName%>">
 	<input type="hidden" name="printAccept" id="printAccept" value="<%=printAccept%>">
 	<input type="hidden" name="opNote" id="opNote" value="">
 	<input type="hidden" name="photo" id="photo" value="<%=result[4]%>">
 	<input type="hidden" name="accept" id="accept" value="<%=result[5]%>">
 	<input type="hidden" name="activePhone" id="activePhone" value="<%=activePhone%>">

<%@ include file="/npage/include/header.jsp" %>
<div class="title">
	<div id="title_zi">验证结果</div>
</div>
<table cellspacing=0>
	<tr>
		<td class="blue" width="5%" rowspan="4" align="center">公民身份联网核查照片
		<td width="20%" rowspan="4" align="center">
			<!--iframe frameBorder="0" align="center" name="photoIframe" id="photoIframe" marginheight=0 marginwidth=0 scrolling=no scrolling="no" style="height:118px;width:96px"-->
			<iframe frameBorder="0" align="center" name="photoIframe" id="photoIframe" marginheight=0 marginwidth=0 scrolling=no scrolling="no" style="height:450px;width:360px">
			</iframe>
		</td>
		<td class="blue" width="20%">证件类型</td>
		<td width="55%">
			<input type="text" name="idTypeText" id="idTypeText" value="<%=idCardTypeText%>" class="InputGrey" readOnly/>
 			<input type="hidden" name="idType" id="idType" value="<%=result[0]%>">
		</td>
	</tr>
	<tr>
		<td class="blue">证件号码</td>
		<td>
			<input type="text" name="idIccid" id="idIccid" value="<%=result[1]%>" class="InputGrey" readOnly/>
		</td>
	</tr>
	<tr>
		<td class="blue">证件姓名</td>
		<td>
			<input type="text" name="idName" id="idName" value="<%=result[2]%>" class="InputGrey" readOnly/>
		</td>
	</tr>
	<tr>
		<td class="blue">签发机关</td>
		<td>
			<input type="text" name="" id="" size=40 value="<%=result[3]%>" class="InputGrey" readOnly/>
		</td>
	</tr>
</table>
<div class="title">
	<div id="title_zi">营业员验证用户结果</div>
</div>
<table>
	<tr>
		<td class="blue" width="20%">实名制验证通过标志</td>
		<td colspan="3">
			<select name="AuthFlag" id="AuthFlag" onchange="displayOnIt(this)">
				<option value="0">未通过验证</option>
				<option value="1">通过验证</option>
			</select>
		</td>
	</tr>
	<tr name="authFailReasonTR" id="authFailReasonTR" style="display:none">
		<td class="blue" width="20%">未通过验证原因</td>
		<td colspan="3">
			<select name="authFailReason" id="authFailReason" style="width:300px">
				<option value="02">公民身份号码存在， 但与姓名不匹配</option>
				<option value="03">公民身份号码不存在</option>
				<option value="04">其他错误</option>
			</select>
		</td>
	</tr>
	<!--tbody name="authSuccessTR" id="authSuccessTR" style="display:none"-->
		<tr name="authSuccessTR" id="authSuccessTR" style="display:none">
			<td class="blue" width="20%">证件有效期到期日(YYYYMMDD)</td>
			<td width="30%">
				<input type="text" name="maturity" id="maturity" value="" maxlength="8" v_must="1" v_type="0_9" v_format="yyyyMMdd"/>
			</td>
			<td class="blue" width="20%">用户是否申请授信</td>
			<td width="30%">
				<select name="creditFlag" id="creditFlag" onchange="displayOnIt(this)">
					<option value="0" selected>不申请授信</option>
					<option value="1">申请授信</option>
				</select>
			</td>
		</tr>
		<tr name="yearIncomeTR" id="yearIncomeTR" style="display:none">
			<td class="blue" width="20%">宣称年收入</td>
			<td colspan="3">
				<input type="text" name="yearIncome" id="yearIncome" value="" v_type="0_9" v_must="1"/>
			</td>
		</tr>
	<!--/tbody-->
</table>
<table>
	<tr>
		<td align="center" id="footer">
			<input class="b_foot" type=button name="submitBtn" id="submitBtn" value="确认" onClick="submitt()">
			<input class="b_foot" type=button name="backBtn" id="backBtn" value="上一步" onClick="window.location = 'fd877.jsp?opCode=<%=opCode%>&opName=<%=opName%>&activePhone=<%=activePhone%>'">
			<input class="b_foot" type=button name="closeBtn" id="closeBtn" value="关闭" onClick="removeCurrentTab()">
		</td>
	</tr>
</table>
<%@ include file="/npage/include/footer_simple.jsp" %>
</form>
</body>
</html>

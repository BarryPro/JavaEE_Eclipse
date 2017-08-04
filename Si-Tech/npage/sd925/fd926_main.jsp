<%
  /*
   * 功能: 外网高端客户带机转网
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
<title>外网高端客户带机转网</title>
<%
	String opCode = request.getParameter("opCode");
	String opName = request.getParameter("opName");
	String backAccept = request.getParameter("backAccept");
	String workNo = (String)session.getAttribute("workNo");
	String password = (String)session.getAttribute("password");
	String regionCode = (String)session.getAttribute("regCode");
	
	String[] result = new String[9];
	result[7] = "";
	result[8] = "";
%>
	<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="phone" routerValue="<%=activePhone%>" id="printAccept"/>
<%
	System.out.println("====wanghfa====fd926_main.jsp====sd926Qry====0==== iLoginAccept = 0");
	System.out.println("====wanghfa====fd926_main.jsp====sd926Qry====1==== iChnSource = 01");
	System.out.println("====wanghfa====fd926_main.jsp====sd926Qry====2==== inOpCode = " + opCode);
	System.out.println("====wanghfa====fd926_main.jsp====sd926Qry====3==== iLoginNo = " + workNo);
	System.out.println("====wanghfa====fd926_main.jsp====sd926Qry====4==== iLoginPwd = " + password);
	System.out.println("====wanghfa====fd926_main.jsp====sd926Qry====5==== iPhoneNo = " + activePhone);
	System.out.println("====wanghfa====fd926_main.jsp====sd926Qry====6==== iPhonePwd = ");
	System.out.println("====wanghfa====fd926_main.jsp====sd926Qry====7==== iOpNote = ");
	System.out.println("====wanghfa====fd926_main.jsp====sd926Qry====8==== iBackAccept = " + backAccept);
%>
	<wtc:service name="sd926Qry" routerKey="regionCode" routerValue="<%=regionCode%>" retcode="retCode1" retmsg="retMsg1" outnum="9">
		<wtc:param value="0"/>
		<wtc:param value="01"/>
		<wtc:param value="<%=opCode%>"/>
		<wtc:param value="<%=workNo%>"/>
		<wtc:param value="<%=password%>"/>
		<wtc:param value="<%=activePhone%>"/>
		<wtc:param value=""/>
		<wtc:param value=""/>
		<wtc:param value="<%=backAccept%>"/>
	</wtc:service>
	<wtc:array id="result1"  scope="end"/>
<%
	System.out.println("====wanghfa====fd926_main.jsp====sd926Qry====  " + retCode1 + ", " + retMsg1);
	if (!"000000".equals(retCode1)) {
		%>
			<script language="javascript">
				rdShowMessageDialog("sd926Qry：<%=retCode1%>，<%=retMsg1%>", 1);
				window.history.go(-1);
			</script>
		<%
	} else if (result1.length > 0) {
		for (int j = 0; j < result1[0].length; j ++) {
			System.out.println("====wanghfa====fd926_main.jsp====sd926Qry==== result1[0]["+j+"] = " + result1[0][j]);
			result[j] = result1[0][j];
		}
	}
%>
<META content=no-cache http-equiv=Pragma>
<META content=no-cache http-equiv=Cache-Control>
<META content="MSHTML 5.00.3315.2870" name=GENERATOR>
<script language="javascript">

	window.onload=function() {
		
	}
	
	function controlBtn(flag) {
		$("#submitBtn").attr("disabled", flag);
		$("#backBtn").attr("disabled", flag);
		$("#closeBtn").attr("disabled", flag);
	}
	
	function backStep() {
		controlBtn(true);
		window.location = "fd925.jsp?opCode=<%=opCode%>&opName=<%=opName%>&activePhone=<%=activePhone%>&backAccept=<%=backAccept%>";
	}
	
	function submitt() {
		controlBtn(true);
		
		var ret = showPrtDlg("Detail", "确实要进行电子免填单打印吗？","Yes");
		if (rdShowConfirmDialog("确认要进行此项服务吗？") == 1) {
			document.frm.action = "fd926_cfm.jsp?backAccept=<%=backAccept%>";
			document.frm.submit();
		} else {
			controlBtn(false);
		}
	}
	
function showPrtDlg(printType,DlgMessage,submitCfm) {
	var h=180;
	var w=350;
	var t=screen.availHeight/2-h/2;
	var l=screen.availWidth/2-w/2;
	
	var pType="subprint";
	var billType="1";
	var sysAccept =<%=backAccept%>;
	var printStr = printInfo(printType);
	var mode_code=null;
	var fav_code=null;
	var area_code=null;
	var opCode="<%=opCode%>" ;
	var phoneNo="<%=activePhone%>";
	
	var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no";
	var path = "<%=request.getContextPath()%>/npage/innet/hljBillPrint_jc.jsp?DlgMsg=" + DlgMessage+ "&submitCfm=" + submitCfm;
	path+="&mode_code="+mode_code+
		"&fav_code="+fav_code+"&area_code="+area_code+
		"&opCode=<%=opCode%>&sysAccept="+sysAccept+
		"&phoneNo=<%=activePhone%>"+
		"&submitCfm="+submitCfm+"&pType="+
		pType+"&billType="+billType+ "&printInfo=" + printStr;
	var ret=window.showModalDialog(path,printStr,prop);
	return ret;
}

function printInfo(printType)
{
	var cust_info="";  				//客户信息
	var opr_info="";   				//操作信息
	var note_info1=""; 				//备注1
	var note_info2=""; 				//备注2
	var note_info3=""; 				//备注3
	var note_info4=""; 				//备注4
	var retInfo = "";  				//打印内容
	
	cust_info+="手机号码：<%=activePhone%>|";
	cust_info+="客户姓名：<%=result[0]%>|";
	opr_info+="办理业务：<%=opName%>|";
	opr_info+="冲正流水：<%=printAccept%>|";
	opr_info+="业务受理时间：<%=new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss", Locale.getDefault()).format(new java.util.Date())%>"+"|";
	opr_info+="方案名称：<%=result[0]%>|";
	opr_info+="IMEI码：" + document.getElementById("imeiCode").value + "|";
	
	note_info1=" "+"|";
	note_info2=" "+"|";
	note_info3=" "+"|";
	note_info4=" "+"|";
	
	retInfo+=" "+"|";
	retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
	retInfo=retInfo.replace(new RegExp("#","gm"),"%23"); 
    return retInfo;
}
</script>
</head>
<body>
<form name="frm" method="POST" >
 	<input type="hidden" name="opCode" id="opCode" value="<%=opCode%>">
 	<input type="hidden" name="opName" id="opName" value="<%=opName%>">
 	<input type="hidden" name="salePrice" id="salePrice" value="<%=result[7]%>">
 	
	<%@ include file="/npage/include/header.jsp" %>
<div class="title">
	<div id="title_zi">用户信息</div>
</div>
<table cellspacing=0>
	<tr>
		<td class="blue" width="20%">客户名称</td>
		<td>
			<input type="text" name="custName" id="custName" class="InputGrey" value="<%=result[4]%>" readOnly/>
		</td>
		<td class="blue" width="20%">手机号码</td>
		<td>
			<input type="text" name="activePhone" id="activePhone" class="InputGrey" value="<%=activePhone%>" readOnly/>
		</td>
	</tr>
	<tr>
		<td class="blue" width="20%">客户地址</td>
		<td>
			<input type="text" name="custName" id="custName" class="InputGrey" value="<%=result[5]%>" readOnly/>
		</td>
		<td class="blue" width="20%">证件号码</td>
		<td>
			<input type="text" name="activePhone" id="activePhone" class="InputGrey" value="<%=result[6]%>" readOnly/>
		</td>
	</tr>
	<tr>
		<td class="blue" width="20%">IMEI码</td>
		<td colspan="3">
			<input type="text" name="imeiCode" id="imeiCode" class="InputGrey" value="<%=result[8]%>" readOnly/>
		</td>
	</tr>
</table>
<div class="title">
	<div id="title_zi">营销案信息</div>
</div>
<table>
	<tr>
		<td class="blue" width="30%">营销案名称</td>
		<td width="70%">
			<%=result[0]%>
		</td>
	</tr>
	<tr>
		<td class="blue">操作工号</td>
		<td>
			<%=result[1]%>
		</td>
	</tr>
	<tr>
		<td class="blue">消费期限</td>
		<td>
			<%=result[2]%>个月
		</td>
	</tr>
	<tr>
		<td class="blue">办理时间</td>
		<td>
			<%=result[3]%>
		</td>
	</tr>
</table>
<table>
	<tr>
		<td colspan="4" align="center" id="footer">
			<input class="b_foot" type=button name="submitBtn" id="submitBtn" value="确认" onClick="submitt()">    
			<input class="b_foot" type=button name="backBtn" id="backBtn" value="上一步" onClick="backStep()">
			<input class="b_foot" type=button name="closeBtn" id="closeBtn" value="关闭" onClick="removeCurrentTab()">
		</td>
	</tr>
</table>
    <input type="hidden" id="flag" name="flag" value=""/>
    <%@ include file="/npage/include/footer_simple.jsp" %>
</form>
</body>
</html>

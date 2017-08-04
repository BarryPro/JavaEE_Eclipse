<%
/********************
version v1.0
开发商: si-tech
create:wanghfa@2011-12-09
********************/
%>
 <!DOCTYPE html PUBLIC "-//W3C//Dtd XHTML 1.0 transitional//EN" "http://www.w3.org/tr/xhtml1/Dtd/xhtml1-transitional.dtd">
<%
  response.setHeader("Pragma","No-cache");
  response.setHeader("Cache-Control","no-cache");
  response.setDateHeader("Expires", 0);
%>
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>

<%
String opCode = request.getParameter("opCode");
String opName = request.getParameter("opName");
String regionCode = (String)session.getAttribute("regCode");
String workNo = (String)session.getAttribute("workNo");
String password = (String)session.getAttribute("password"); 
String[] result = new String[4];
//String activePhone = request.getParameter("activePhone");
String sql = "";
String sqlVar = "";
%>
<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="region" routerValue="<%=regionCode%>" id="loginAccept"/>
<%
System.out.println("====wanghfa====fe462_main.jsp====se462Init==== 0==== iLoginAccept = 0");
System.out.println("====wanghfa====fe462_main.jsp====se462Init==== 1==== iChnSource = 01");
System.out.println("====wanghfa====fe462_main.jsp====se462Init==== 2==== iOpCode = " + opCode);
System.out.println("====wanghfa====fe462_main.jsp====se462Init==== 3==== iLoginNo = " + workNo);
System.out.println("====wanghfa====fe462_main.jsp====se462Init==== 4==== iLoginPwd = " + password);
System.out.println("====wanghfa====fe462_main.jsp====se462Init==== 5==== iPhoneNo = " + activePhone);
System.out.println("====wanghfa====fe462_main.jsp====se462Init==== 6==== iUserPwd = ");
%>
<wtc:service name="se462Init" routerKey="region" routerValue="<%=regionCode%>" outnum="4" retcode="retCode1" retmsg="retMsg1">
	<wtc:param value="0"/>
	<wtc:param value="01"/>
	<wtc:param value="<%=opCode%>"/>
	<wtc:param value="<%=workNo%>"/>
	<wtc:param value="<%=password%>"/>
	<wtc:param value="<%=activePhone%>"/>
	<wtc:param value=""/>
</wtc:service>
<wtc:array id="result1" scope="end"/>
<%
if (!"000000".equals(retCode1)) {
	%>
	<script language="JavaScript">
		rdShowMessageDialog("se462Init失败！错误代码：<%=retCode1%>，错误信息：<%=retMsg1%>", 0);
		window.location="fe462.jsp?opCode=<%=opCode%>&opName=<%=opName%>&activePhone=<%=activePhone%>";
	</script>
	<%
	return;
} else {
	System.out.println("====wanghfa==== result1.length = " + result1[0].length);
	for (int i = 0; i < result1[0].length; i ++) {
		result[i] = result1[0][i];
	}
}

sql = "select a.project_type,"
	 + "       a.project_code,"
	 + "       a.project_name,"
	 + "       to_char(a.least_prepay),"
	 + "       to_char(a.offer_id),"
	 + "       b.offer_name,"
	 + "       b.offer_comments,"
	 + "       nvl(a.ACTIVE_NOTE, ' '),"
	 + "       to_char(a.exp_date, 'yyyymmdd')"
	 + "  from sFeeTypeAction a, product_offer b"
	 + " where a.region_code = :vRegionCode"
	 + "   and a.is_valid = 'Y'"
	 + "   and to_char(sysdate, 'YYYYMMDD') >= a.begin_time"
	 + "   and to_char(sysdate, 'YYYYMMDD') <= a.end_time"
	 + "   and a.offer_id = b.offer_id";
sqlVar = " vRegionCode=" + regionCode;
%>
<wtc:service name="TlsPubSelCrm" outnum="9" retmsg="retMsgType" retcode="retCodeType" routerKey="region" routerValue="<%=regionCode%>">
	<wtc:param value="<%=sql%>"/>
	<wtc:param value="<%=sqlVar%>"/>
</wtc:service>
<wtc:array id="resultType" scope="end" />
<%
if (!"000000".equals(retCodeType)) {
	%>
	<script language="javascript">
		rdShowMessageDialog("取营销方案错误，请联系管理员！", 1);
		window.location="fe462.jsp?opCode=<%=opCode%>&opName=<%=opName%>&activePhone=<%=activePhone%>";
	</script>
	<%
	return;
}
%>
<head>
<title><%=opName%></title>

<META content="no-cache" http-equiv="Pragma">
<META content="no-cache" http-equiv="Cache-Control">
<META content="0" 	     http-equiv="Expires">
<meta http-equiv="Content-Type" content="text/html; charset=GBK">

<script language=javascript>
	var projectTypes = new Array();
	var projectCodes = new Array();
	var projectNames = new Array();
	var leastPrepays = new Array();
	var offerIds = new Array();
	var offerNames = new Array();
	var offerComments = new Array();
	var activeNotes = new Array();
	var expDates = new Array();
	
	onload = function() {
		<%
		for (int a = 0; a < resultType.length; a ++) {
			%>
			projectTypes[<%=a%>] = "<%=resultType[a][0]%>";
			projectCodes[<%=a%>] = "<%=resultType[a][1]%>";
			projectNames[<%=a%>] = "<%=resultType[a][2]%>";
			leastPrepays[<%=a%>] = parseFloat("<%=resultType[a][3]%>");
			offerIds[<%=a%>] = "<%=resultType[a][4]%>";
			offerNames[<%=a%>] = "<%=resultType[a][5]%>";
			offerComments[<%=a%>] = "<%=resultType[a][6]%>";
			activeNotes[<%=a%>] = "<%=resultType[a][7]%>";
			expDates[<%=a%>] = "<%=resultType[a][8]%>";
			<%
		}
		%>
		projectTypeChange();
	}
	
	function projectTypeChange() {
		var projectType = $("#projectType").val();
		$("#projectCode").empty();
		
		for (var a = 0; a < projectTypes.length; a ++) {
			if (projectTypes[a] == projectType) {
				$("<option value='" + projectCodes[a] + "'>" + projectCodes[a] + "--" + projectNames[a] + "</option>").appendTo($("#projectCode"));
			}
		}
		
		projectCodeChange();
	}
	
	function projectCodeChange() {
		var projectCode = $("#projectCode").val();
		
		if (projectTypes.length == 0) {
			$("#baseFee").val("");
			$("#offerId").val("");
			$("#offerName").val("");
			$("#offerComment").val("");
			$("#activeNote").val("");
			$("#expDate").val("");
		} else {
			for (var a = 0; a < projectTypes.length; a ++) {
				if (projectCodes[a] == projectCode) {
					$("#baseFee").val(leastPrepays[a]);
					$("#offerId").val(offerIds[a]);
					$("#offerName").val(offerNames[a]);
					$("#offerComment").val(offerComments[a]);
					$("#activeNote").val(activeNotes[a]);
					$("#expDate").val(expDates[a]);
				}
			}
		}
	}
	
	function controlBtn(flag) {
		$("#submitBtn").attr("disabled", flag);
		$("#backBtn").attr("disabled", flag);
		$("#closeBtn").attr("disabled", flag);
	}
	
	function doCfm() {
		controlBtn(true);

		if ($("#projectType").val() == null) {
			rdShowMessageDialog("没有方案类型供选择，不可以办理业务！");
			controlBtn(false);
			return false;
		}
		var ret = showPrtDlg("Detail","确实要进行电子免填单打印吗？","Yes");
		
		if (rdShowConfirmDialog("确认要提交信息吗？") != 1) {
			controlBtn(false);
			return false;
		} else {
			document.frm.action = "fe462_cfm.jsp";
			document.frm.submit()
		}
	}
	
	function showPrtDlg(printType,DlgMessage,submitCfm) {  //显示打印对话框
		var h=180;
		var w=350;
		var t=screen.availHeight/2-h/2;
		var l=screen.availWidth/2-w/2;
		
		var pType="subprint";             				 		//打印类型：print 打印 subprint 合并打印
		var billType="1";              				 			//票价类型：1电子免填单、2发票、3收据
		var sysAccept =<%=loginAccept%>;             			//流水号
		var printStr = printInfo(printType);			 		//调用printinfo()返回的打印内容
		var mode_code=null;           							//资费代码
		var fav_code=null;                				 		//特服代码
		var area_code=null;             				 		//小区代码
		var opCode="e462" ;                   			 		//操作代码
		var phoneNo="<%=activePhone%>";                  	 		//客户电话
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

	function printInfo(printType) {
		var cust_info="";  				//客户信息
		var opr_info="";   				//操作信息
		var note_info1=""; 				//备注1
		var note_info2=""; 				//备注2
		var note_info3=""; 				//备注3
		var note_info4=""; 				//备注4
		var retInfo = "";  				//打印内容
		
		cust_info+="手机号码："+document.all.activePhone.value+"|";
		cust_info+="客户姓名："+document.all.custName.value+"|";
		//cust_info+="客户地址："+document.all.custAddr.value+"|";
		//cust_info+="证件号码："+document.all.idIccid.value+"|";
		//retInfo+=" "+"|";
		
		opr_info+="用户品牌："+document.all.smName.value+"    办理业务：四喜号码营销案"+"|";
		opr_info+="操作流水："+document.all.loginAccept.value+"    业务受理时间：<%=new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss", Locale.getDefault()).format(new java.util.Date())%>"+"|";
		opr_info+="赠送可选套餐：" + $("#offerId").val() + "-" + $("#offerName").val() + "|";
		opr_info+="赠送可选套餐有效期：" + $("#expDate").val() + "|";
		opr_info+="|";
		if($("#activeNote").val().trim().length > 0) {
			note_info1+="备注：" + $("#activeNote").val() + "|";
		}
		note_info1+="赠送可选套餐描述：" + $("#offerComment").val() + "|";
		note_info1+="注意事项：|";
		note_info1+="1、用户当月办理，可选资费立即生效；只允许当天冲正营销案，冲正后可选资费立即失效，当冲正次数大于2次时，再次办理营销案时资费为预约生效；办理之后的任何时间都可以取消营销案，取消后可选资费预约失效，当月不能再次办理营销案申请，次月申请时可立即生效。|";
		note_info1+="2、赠送套餐有效期到期，赠送套餐自动取消。|";
		retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
		retInfo=retInfo.replace(new RegExp("#","gm"),"%23"); 
		return retInfo;
}
</script>
</head>
<body>
<form name="frm" method="post" action="fe457_cfm.jsp">
	<input type="hidden" name="opCode" value="<%=opCode%>">
	<input type="hidden" name="opName" value="<%=opName%>">
	<input type="hidden" name="loginAccept" value="<%=loginAccept%>">
	<input type="hidden" name="opNote" value="">
	
	<%@ include file="/npage/include/header.jsp" %>
	<div class="title">
		<div id="title_zi"><%=opName%></div>
	</div>
	<table>
		<tr>
			<td class="blue" width="20%">手机号码</td>
			<td width="30%">
				<input type="text" name="activePhone" value="<%=activePhone%>" class="InputGrey" readonly>
			</td>
			<td class="blue" width="20%">客户名称</td>
			<td width="30%">
				<input name="custName" type="text" class="InputGrey" id="custName" value="<%=result[0]%>" readonly>
			</td>
		</tr>
		<tr>
			<td class="blue">客户地址</td>
			<td colspan="3">
				<input name="custAddr" type="text" class="InputGrey" id="custAddr" value="<%=result[1]%>" readonly>
			</td>
		</tr>
		<tr>
			<td class="blue">证件号码</td>
			<td>
				<input name="idIccid" type="text" class="InputGrey" id="idIccid" value="<%=result[2]%>" readonly>
			</td>
			<td class="blue">品牌名称</td>
			<td>
				<input name="smName" type="text" class="InputGrey" id="smName" value="<%=result[3]%>" readonly>
			</td>
		</tr>
		<tr>
			<td class="blue">方案类型</td>
			<td colspan="3">
				<select id=projectType name=projectType style="width:400px" onchange="projectTypeChange()">
					<%
					sql = "select distinct trim(a.project_type), trim(a.type_name)"
						 + "  from sactivetype a, sFeeTypeAction b"
						 + " where a.op_code = 'e462'"
						 + "   and a.region_code = :vRegionCode"
						 + "   and a.region_code = b.region_code"
						 + "   and a.project_type = b.project_type"
						 + "   and b.is_valid = 'Y'"
						 + "   and b.begin_time <= to_char(sysdate, 'YYYYMMDD')"
						 + "   and b.end_time >= to_char(sysdate, 'YYYYMMDD')";
					sqlVar = " vRegionCode=" + regionCode;
					%>
					<wtc:service name="TlsPubSelCrm" outnum="2" retmsg="retMsgType" retcode="retCodeType" routerKey="region" routerValue="<%=regionCode%>">
						<wtc:param value="<%=sql%>"/>
						<wtc:param value="<%=sqlVar%>"/>
					</wtc:service>
					<wtc:array id="resultType" scope="end" />
					<%
					if (!"000000".equals(retCodeType)) {
						%>
						<script language="javascript">
							rdShowMessageDialog("取营销方案类型错误，请联系管理员！", 1);
							window.location="fe462.jsp?opCode=<%=opCode%>&opName=<%=opName%>&activePhone=<%=activePhone%>";
							return;
						</script>
						<%
						return;
					} else {
						for (int i = 0; i < resultType.length; i ++) {
							%>
							<option value="<%=resultType[i][0]%>"><%=resultType[i][0]%>--<%=resultType[i][1]%></option>
							<%
						}
					}
					
					%>
				</select>
			</td>
		</tr>
		<tr>
			<td class="blue">方案</td>
			<td colspan="3">
				<select id=projectCode name=projectCode style="width:400px" onchange="projectCodeChange()">
				
				</select>
			</td>
		</tr>
		<tr>
			<td class="blue">净预存</td>
			<td colspan="3">
				<input name="baseFee" type="text" class="InputGrey" id="baseFee" readonly>
			</td>
		</tr>
		<tr>
			<td class="blue">资费代码</td>
			<td>
				<input name="offerId" type="text" class="InputGrey" id="offerId" readonly>
			</td>
			<td class="blue">资费名称</td>
			<td>
				<input name="offerName" type="text" class="InputGrey" id="offerName" size="40" readonly>
				<input name="offerComment" type="hidden" id="offerComment">
				<input name="activeNote" type="hidden" id="activeNote">
				<input name="expDate" type="hidden" id="expDate">
			</td>
		</tr>
	</table>

	<table cellspacing="0">
		<tr>
			<td align="center" id="footer">
				<input type="button" name="submitBtn" id="submitBtn" class="b_foot" value="确认" onClick="doCfm()" >
				<input type="button" name="backBtn" id="backBtn" class="b_foot" onclick="window.location='fe462.jsp?opCode=<%=opCode%>&opName=<%=opName%>&activePhone=<%=activePhone%>'" value="返回" >
				<input type="button" name="closeBtn" id="closeBtn" class="b_foot" onclick="removeCurrentTab()" value="关闭">
			</td>
		</tr>
	</table>
<%@ include file="/npage/include/footer.jsp" %>
</form>
</body>
</html>

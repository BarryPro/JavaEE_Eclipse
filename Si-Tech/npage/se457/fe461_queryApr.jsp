<%
/********************
version v1.0
开发商: si-tech
create:wanghfa@2011-12-09
********************/
%>
<%@	page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%
response.setHeader("Pragma","No-cache");
response.setHeader("Cache-Control","no-cache");
response.setDateHeader("Expires", 0);

String opCode = "e461";
String opName = "四喜号码营销方案配置审批";
String regionCode = (String)session.getAttribute("regCode");
String workNo = (String)session.getAttribute("workNo");
String password = (String)session.getAttribute("password"); 

System.out.println("====wanghfa====fe461_queryApr.jsp====se461Qry==== 0==== iLoginAccept = 0");
System.out.println("====wanghfa====fe461_queryApr.jsp====se461Qry==== 1==== iChnSource = 01");
System.out.println("====wanghfa====fe461_queryApr.jsp====se461Qry==== 2==== iOpCode = " + opCode);
System.out.println("====wanghfa====fe461_queryApr.jsp====se461Qry==== 3==== iLoginNo = " + workNo);
System.out.println("====wanghfa====fe461_queryApr.jsp====se461Qry==== 4==== iLoginPwd = " + password);
System.out.println("====wanghfa====fe461_queryApr.jsp====se461Qry==== 5==== iPhoneNo = ");
System.out.println("====wanghfa====fe461_queryApr.jsp====se461Qry==== 6==== iUserPwd = ");
System.out.println("====wanghfa====fe461_queryApr.jsp====se461Qry==== 7==== iRegionCode = " + regionCode);
%>
<wtc:service name="se461Qry" routerKey="region" routerValue="<%=regionCode%>" outnum="22" retcode="retCode1" retmsg="retMsg1">
	<wtc:param value="0"/>
	<wtc:param value="01"/>
	<wtc:param value="<%=opCode%>"/>
	<wtc:param value="<%=workNo%>"/>
	<wtc:param value="<%=password%>"/>
	<wtc:param value=""/>
	<wtc:param value=""/>
	<wtc:param value="<%=regionCode%>"/>
</wtc:service>
<wtc:array id="result1" scope="end"/>
<%
if (!"000000".equals(retCode1)) {
	%>
	<script language="JavaScript">
		rdShowMessageDialog("<%=opName%>失败！错误代码：<%=retCode1%>，错误信息：<%=retMsg1%>", 0);
		removeCurrentTab();
		//window.location="fe457.jsp?opCode=<%=opCode%>&opName=<%=opName%>";
	</script>
	<%
	return;
}
%>
<head>
<title><%=opName%></title>

<META content="no-cache" http-equiv="Pragma">
<META content="no-cache" http-equiv="Cache-Control">
<META content="0" 	     http-equiv="Expires" >
<meta http-equiv="Content-Type" content="text/html; charset=GBK">

<script language=javascript>
	onload = function() {
		
	}
	
	function controlBtn(flag) {
		$("#submitBtn").attr("disabled", flag);
		$("#backBtn").attr("disabled", flag);
		$("#closeBtn").attr("disabled", flag);
	}
	
	function detail(operation, num) {
		$("input[name=opNum]").each(function () {
			if (this.value == num) {
				this.checked = true;
			}
		});
		
		if (operation == "detail") {
			document.frm.action = "fe458_detail.jsp";
			document.frm.submit();
		}
	}
	
	function doCfm() {
		controlBtn(true);
		if (!checkElement(document.getElementById("auditSuggestionSub"))) {
			controlBtn(false);
			return false;
		}
		if (rdShowConfirmDialog("确认审批配置信息吗？") == 1) {
			document.frm.action = "fe461_aprove.jsp";
			document.frm.submit();
		}
	}
</script>
</head>
<body>
<form name="frm" method="POST" action="fe457_cfm.jsp">
<%@ include file="/npage/include/header.jsp" %>
<input type="hidden" name="opCode" value="<%=opCode%>">
<input type="hidden" name="opName" value="<%=opName%>">

	<div class="title">
		<div id="title_zi">营销方案基本信息配置</div>
	</div>
	<table cellspacing="0">
		<tr>
			<th><B>选择</B></th>
			<th><B>方案类型</B></th>
			<th><B>类型名称</B></th>
			<th><B>方案代码</B></th>
			<th><B>方案名称</B></th>
			<th><B>可选资费代码</B></th>
			<th><B>地市名称</B></th>
			<th><B>申请流水</B></th>
			<th><B>查看详细信息</B></th>
		</tr>
		<%
		if ("000000".equals(retCode1)) {
			String checked = "";

			for (int i = 0; i < result1.length; i ++) {
				if (i == 0) {
					checked = "checked";
				} else {
					checked = "";
				}
				%>
				<tr>
					<td>
						<input type="hidden" name="projectType" value="<%=result1[i][0]%>">
						<input type="hidden" name="typeName" value="<%=result1[i][1]%>">
						<input type="hidden" name="projectCode" value="<%=result1[i][2]%>">
						<input type="hidden" name="projectName" value="<%=result1[i][3]%>">
						<input type="hidden" name="offerId" value="<%=result1[i][4]%>">
						<input type="hidden" name="regionName" value="<%=result1[i][5]%>">
						<input type="hidden" name="regionCode" value="<%=result1[i][6]%>">
						<input type="hidden" name="accept" value="<%=result1[i][7]%>">
						
						<input type="hidden" name="leastPrepay" value="<%=result1[i][8]%>">
						<input type="hidden" name="expDate" value="<%=result1[i][9]%>">
						<input type="hidden" name="beginTime" value="<%=result1[i][10]%>">
						<input type="hidden" name="endTime" value="<%=result1[i][11]%>">
						<input type="hidden" name="fileName" value="<%=result1[i][12]%>">
						<input type="hidden" name="fileNo" value="<%=result1[i][13]%>">
						<input type="hidden" name="auditName" value="<%=result1[i][14]%>">
						<input type="hidden" name="auditPhone" value="<%=result1[i][15]%>">
						<input type="hidden" name="activeNote" value="<%=result1[i][16]%>">
						<input type="hidden" name="opWorkNo" value="<%=result1[i][17]%>">
						<input type="hidden" name="auditSuggestion" value="<%=result1[i][18]%>">
						<input type="hidden" name="auditLoginNo" value="<%=result1[i][19]%>">
						<input type="hidden" name="auditDate" value="<%=result1[i][20]%>">
						<input type="hidden" name="auditLoginName" value="<%=result1[i][21]%>">

						<input type="radio" name="opNum" value="<%=i%>" <%=checked%>>
					</td>
					<td>
						<%=result1[i][0]%>
					</td>
					<td>
						<%=result1[i][1]%>
					</td>
					<td>
						<%=result1[i][2]%>
					</td>
					<td>
						<%=result1[i][3]%>
					</td>
					<td>
						<%=result1[i][4]%>
					</td>
					<td>
						<%=result1[i][5]%>
					</td>
					<td>
						<%=result1[i][7]%>
					</td>
					<td>
						<input type="button" class="b_text" value="查看详细信息" onclick="detail('detail', '<%=i%>');">
					</td>
				</tr>
				<%
			}
		}
		%>
</table>
<%
if (result1.length > 0) {
	%>
	<div class="title">
		<div id="title_zi">审批意见</div>
	</div>
	<table cellspacing="0">
		<tr>
			<td width="20%" class="blue">审核是否通过</td>
			<td width="80%">
				<select name="isAuditPass">
					<option value="Y">是</option>
					<option value="N">否</option>
				</select>
			</td>
		</tr>
		<tr>
			<td class="blue">审批意见</td>
			<td>
				<input type="text" name="auditSuggestionSub" id="auditSuggestionSub" value="" size="80" maxlength="60" v_maxlength="60" v_type="string" v_must="1">&nbsp;<font class="orange">*</font>
			</td>
		</tr>
	</table>
	<%
}
%>

<table cellspacing="0">
	<tr>
		<td align="center" id="footer">
			<%
			if (result1.length > 0) {
				%>
				<input class="b_foot" type=button name="submitBtn" id="submitBtn" value="确认" onClick="doCfm();">
				<%
			}
			%>
			<!--input type="button" name="backBtn" id="backBtn" class="b_foot" onclick="window.location='fe457.jsp?opCode=<%=opCode%>&opName=<%=opName%>'" value="返回" -->
			<input type="button" name="closeBtn" id="closeBtn" class="b_foot" onclick="removeCurrentTab()" value="关闭">
		</td>
	</tr>
</table>
<%@ include file="/npage/include/footer.jsp" %>
</form>
</body>
</html>

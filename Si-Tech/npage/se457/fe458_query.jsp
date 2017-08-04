<%
/********************
version v1.0
开发商: si-tech
create:wanghfa@2011-12-09
********************/
%>
<%@	page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="com.sitech.boss.s1100.viewBean.*" %>
<%
response.setHeader("Pragma","No-cache");
response.setHeader("Cache-Control","no-cache");
response.setDateHeader("Expires", 0);

String opCode = "e458";     
String opName = "四喜号码营销方案配置查询";
String regionCode = (String)session.getAttribute("regCode");
String workNo = (String)session.getAttribute("workNo");
String password = (String)session.getAttribute("password"); 

System.out.println("====wanghfa====fe458_query.jsp====se458Qry==== 0==== iLoginAccept = 0");
System.out.println("====wanghfa====fe458_query.jsp====se458Qry==== 1==== iChnSource = 01");
System.out.println("====wanghfa====fe458_query.jsp====se458Qry==== 2==== iOpCode = " + opCode);
System.out.println("====wanghfa====fe458_query.jsp====se458Qry==== 3==== iLoginNo = " + workNo);
System.out.println("====wanghfa====fe458_query.jsp====se458Qry==== 4==== iLoginPwd = " + password);
System.out.println("====wanghfa====fe458_query.jsp====se458Qry==== 5==== iPhoneNo = ");
System.out.println("====wanghfa====fe458_query.jsp====se458Qry==== 6==== iUserPwd = ");
System.out.println("====wanghfa====fe458_query.jsp====se458Qry==== 7==== iRegionCode = " + regionCode);
%>
<wtc:service name="se458Qry" routerKey="region" routerValue="<%=regionCode%>" outnum="22" retcode="retCode1" retmsg="retMsg1">
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
		window.location="fe457.jsp?opCode=<%=opCode%>&opName=<%=opName%>";
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
	
	function doCfm(operation, num) {
		$("#opNum").val(num);
		
		if (operation == "detail") {
			document.frm.action = "fe458_detail.jsp";
			document.frm.submit();
		} else if (operation == "modify") {
			document.frm.action = "fe459_modify.jsp";
			document.frm.submit();
		} else if (operation == "delete") {
			if (rdShowConfirmDialog("确认要删除配置信息吗？") == 1) {
				document.frm.action = "fe460_delete.jsp";
				document.frm.submit();
			}
		}
		
	}
	
</script>
</head>
<body>
<form name="frm" method="post" action="fe457_cfm.jsp">
	<input type="hidden" name="opCode" value="<%=opCode%>">
	<input type="hidden" name="opName" value="<%=opName%>">
	<input type="hidden" name="opNum" id="opNum" value="">
	
	<%@ include file="/npage/include/header.jsp" %>
	<div class="title">
		<div id="title_zi">营销方案基本信息配置查询</div>
	</div>
	<table>
		<tr>
			<th><B>方案类型</B></th>
			<th><B>类型名称<B></th>
			<th><B>方案代码<B></th>
			<th><B>方案名称<B></th>
			<th><B>审批状态<B></th>
			<th><B>可选资费代码<B></th>
			<th><B>操作<B></th>
		</tr>
		<%
		if ("000000".equals(retCode1)) {
			String modifyDisabled = "";
			String deleteDisabled = "";
			for (int i = 0; i < result1.length; i ++) {
				System.out.println("====wanghfa====fe458_query.jsp====result1.length = " + result1.length);
				System.out.println("====wanghfa====fe458_query.jsp====0  " + result1[i][0]);
				System.out.println("====wanghfa====fe458_query.jsp====1  " + result1[i][1]);
				System.out.println("====wanghfa====fe458_query.jsp====2  " + result1[i][2]);
				System.out.println("====wanghfa====fe458_query.jsp====3  " + result1[i][3]);
				System.out.println("====wanghfa====fe458_query.jsp====4  " + result1[i][4]);
				System.out.println("====wanghfa====fe458_query.jsp====5  " + result1[i][5]);
				System.out.println("====wanghfa====fe458_query.jsp====6  " + result1[i][6]);
				System.out.println("====wanghfa====fe458_query.jsp====7  " + result1[i][7]);
				System.out.println("====wanghfa====fe458_query.jsp====8  " + result1[i][8]);
				System.out.println("====wanghfa====fe458_query.jsp====9  " + result1[i][9]);
				System.out.println("====wanghfa====fe458_query.jsp====10 " + result1[i][10]);
				System.out.println("====wanghfa====fe458_query.jsp====11 " + result1[i][11]);
				System.out.println("====wanghfa====fe458_query.jsp====12 " + result1[i][12]);
				System.out.println("====wanghfa====fe458_query.jsp====13 " + result1[i][13]);
				System.out.println("====wanghfa====fe458_query.jsp====14 " + result1[i][14]);
				System.out.println("====wanghfa====fe458_query.jsp====15 " + result1[i][15]);
				System.out.println("====wanghfa====fe458_query.jsp====16 " + result1[i][16]);
				System.out.println("====wanghfa====fe458_query.jsp====17 " + result1[i][17]);
				System.out.println("====wanghfa====fe458_query.jsp====18 " + result1[i][18]);
				System.out.println("====wanghfa====fe458_query.jsp====19 " + result1[i][19]);
				System.out.println("====wanghfa====fe458_query.jsp====20 " + result1[i][20]);
				System.out.println("====wanghfa====fe458_query.jsp====21 " + result1[i][21]);
				%>
				<tr>
					<td>
						<input type="hidden" name="projectType" value="<%=result1[i][0]%>">
						<input type="hidden" name="typeName" value="<%=result1[i][1]%>">
						<input type="hidden" name="projectCode" value="<%=result1[i][2]%>">
						<input type="hidden" name="projectName" value="<%=result1[i][3]%>">
						<input type="hidden" name="flag" value="<%=result1[i][4]%>">
						<input type="hidden" name="offerId" value="<%=result1[i][5]%>">
						<input type="hidden" name="regionName" value="<%=result1[i][6]%>">
						<input type="hidden" name="leastPrepay" value="<%=result1[i][7]%>">
						<input type="hidden" name="expDate" value="<%=result1[i][8]%>">
						<input type="hidden" name="beginTime" value="<%=result1[i][9]%>">
						<input type="hidden" name="endTime" value="<%=result1[i][10]%>">
						<input type="hidden" name="isValid" value="<%=result1[i][11]%>">
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
						<%
						modifyDisabled = "disabled";
						deleteDisabled = "disabled";
						if (workNo.equals(result1[i][17]) && "审批通过".equals(result1[i][4])) {
							modifyDisabled = "";
						}
						if (workNo.equals(result1[i][17]) && !"审批通过".equals(result1[i][4])) {
							deleteDisabled = "";
						}
						%>
						<input type="button" class="b_text" value="查看详细信息" onclick="doCfm('detail', '<%=i%>');">
						<input type="button" class="b_text" value="修改" onclick="doCfm('modify', '<%=i%>');" <%=modifyDisabled%>>
						<input type="button" class="b_text" value="删除" onclick="doCfm('delete', '<%=i%>');" <%=deleteDisabled%>>
					</td>
				</tr>
				<%
			}
		}
		%>
	</table>

	<table cellspacing="0"> 
		<tr>
			<td colspan="6" align="center" id="footer">
				<input type="reset" name="backBtn" id="backBtn" class="b_foot" onclick="window.location='fe457.jsp?opCode=<%=opCode%>&opName=<%=opName%>'" value="返回" >
				<input type="button" name="closeBtn" id="closeBtn" class="b_foot" onclick="removeCurrentTab()" value="关闭">
			</td>
		</tr>
	</table>
<%@ include file="/npage/include/footer.jsp" %>
</form>
</body>
</html>

<%
  /*
   * 功能: e571·跨省专线产品订单状态列表查询
   * 版本: 1.0
   * 日期: 20120220
   * 作者: wanghfa
   * 版权: si-tech
  */
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>

<%
	response.setHeader("Pragma","No-Cache"); 
	response.setHeader("Cache-Control","No-Cache");
	response.setDateHeader("Expires", 0); 
	request.setCharacterEncoding("GBK");
	String opCode = "e571";
	String opName = "跨省专线产品订单状态列表查询";
	String workNo = (String)session.getAttribute("workNo");
	String password = (String)session.getAttribute("password");
	String regionCode = (String)session.getAttribute("regCode");
	String chanceId = request.getParameter("chanceId");
	
	System.out.println("====wanghfa====fe555_cfm.jsp====se555Cfm==== 0 = 0");
	System.out.println("====wanghfa====fe555_cfm.jsp====se555Cfm==== 1 = 01");
	System.out.println("====wanghfa====fe555_cfm.jsp====se555Cfm==== 2 = e571");
	System.out.println("====wanghfa====fe555_cfm.jsp====se555Cfm==== 3 = " + workNo);
	System.out.println("====wanghfa====fe555_cfm.jsp====se555Cfm==== 4 = " + password);
	System.out.println("====wanghfa====fe555_cfm.jsp====se555Cfm==== 5 = ");
	System.out.println("====wanghfa====fe555_cfm.jsp====se555Cfm==== 6 = ");
	System.out.println("====wanghfa====fe555_cfm.jsp====se555Cfm==== 7 = " + chanceId);
%>
	<wtc:service name="se571Qry" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode1" retmsg="retMsg1" outnum="9">
		<wtc:param value="0"/>
		<wtc:param value="01"/>
		<wtc:param value="e571"/>
		<wtc:param value="<%=workNo%>"/>
		<wtc:param value="<%=password%>"/>
		<wtc:param value=""/>
		<wtc:param value=""/>
		<wtc:param value="<%=chanceId%>"/>
	</wtc:service>
	<wtc:array id="result1" scope="end"/>
<%
	if (!"000000".equals(retCode1)) {
		%>
		<script language="javascript">
			rdShowMessageDialog("se571Qry查询错误！<%=retCode1%>, <%=retMsg1%>", 1);
		</script>
		<%
	}
%>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>跨省专线产品订单状态列表查询</title>
<script type=text/javascript>

</script>

</head>
<body>
<form name="frm" action="" method="post" >
<%@ include file="/npage/include/header.jsp" %>
<div class="title">
	<div id="title_zi">跨省专线产品订单状态列表查询</div>
</div>
<table cellspacing=0>
	<tr>
		<td class="blue" width="20%">父商机编号</td>
		<td width="70%">
			<%=chanceId%>
		</td>
	</tr>
</table>
<table>
	<tr>
		<th>商机编号</th>
		<th>商品订单号</th>
		<th>商品订购关系编码</th>
		<th>产品订单号</th>
		<th>产品订购关系编码</th>
		<th>产品订单状态</th>
		<th>操作时间</th>
	</tr>
	<%
	if ("000000".equals(retCode1) && result1.length > 0) {
		for (int i = 0; i < result1.length; i ++) {
			%>
			<tr>
				<td><%="".equals(result1[i][0]) ? "无" : result1[i][0]%></td>
				<td><%="".equals(result1[i][1]) ? "无" : result1[i][1]%></td>
				<td><%="".equals(result1[i][2]) ? "无" : result1[i][2]%></td>
				<td><%="".equals(result1[i][3]) ? "无" : result1[i][3]%></td>
				<td><%="".equals(result1[i][4]) ? "无" : result1[i][4]%></td>
				<td>
					<%
					if ("".equals(result1[i][5].trim())) {
						out.print("无");
					} else if ("0".equals(result1[i][5].trim())) {
						out.print("初始化");
					} else if ("1".equals(result1[i][5].trim())) {
						out.print("已送网络部施工");
					} else if ("2".equals(result1[i][5].trim())) {
						out.print("网络部施工中");
					} else if ("3".equals(result1[i][5].trim())) {
						out.print("施工完成");
					} else if ("4".equals(result1[i][5].trim())) {
						out.print("送联调中");
					} else if ("5".equals(result1[i][5].trim())) {
						out.print("送取消中");
					} else if ("6".equals(result1[i][5].trim())) {
						out.print("联调结束");
					} else if ("7".equals(result1[i][5].trim())) {
						out.print("开通中");
					} else if ("8".equals(result1[i][5].trim())) {
						out.print("已开通");
					} else if ("9".equals(result1[i][5].trim())) {
						out.print("已取消");
					} else {
						out.print("未知状态");
					}
					%>
				</td>
				<td><%="".equals(result1[i][6]) ? "无" : result1[i][6]%></td>
			</tr>
			<%
		}
	}
	%>
</table>

<table>
	<tr>
		<td colspan="4" align="center" id="footer">
			<input class="b_foot" type=button name="backBtn" id="backBtn" value="返回" onclick="window.location='fe571.jsp'">
			<input class="b_foot" type=button name="closeBtn" id="closeBtn" value="关闭" onclick="removeCurrentTab();">
		</td>
	</tr>
</table>
<%@ include file="/npage/include/footer.jsp" %>
</form>
</body>
</html>
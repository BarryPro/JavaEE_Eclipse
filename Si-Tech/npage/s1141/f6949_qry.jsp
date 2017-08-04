<!DOCTYPE html PUBLIC "-//W3C//Dtd Xhtml 1.0 transitional//EN" "http://www.w3.org/tr/xhtml1/Dtd/xhtml1-transitional.dtd">
<%
  /*
   * 功能: 集团统一预存赠礼6949
   * 版本: 1.0
   * 日期: 2009/8/17
   * 作者: sunaj
   * 版权: si-tech
   * update:
  */
%>
<%@	page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="com.sitech.boss.pub.util.*" %>
<%@ include file="../../npage/bill/getMaxAccept.jsp" %>

<%
	String opCode="6949";
	String opName="集团统一预存赠礼 查询";
	String workNo = (String)session.getAttribute("workNo");
	String password = (String)session.getAttribute("password");
	String regionCode = (String)session.getAttribute("regCode");
	String srv_no = (String)request.getParameter("srv_no");
	
	System.out.println("====wanghfa====f6949_qry.jsp====s6949Qry====0==== iLoginAccept = 0");
	System.out.println("====wanghfa====f6949_qry.jsp====s6949Qry====1==== iChnSource = 01");
	System.out.println("====wanghfa====f6949_qry.jsp====s6949Qry====2==== inOpCode = " + opCode);
	System.out.println("====wanghfa====f6949_qry.jsp====s6949Qry====3==== iLoginNo = " + workNo);
	System.out.println("====wanghfa====f6949_qry.jsp====s6949Qry====4==== iLoginPsw = " + password);
	System.out.println("====wanghfa====f6949_qry.jsp====s6949Qry====5==== phoneNo = " + srv_no);
	System.out.println("====wanghfa====f6949_qry.jsp====s6949Qry====6==== userPwd = ");
	System.out.println("====wanghfa====f6949_qry.jsp====s6949Qry====7==== opNote = ");
%>
	<wtc:service name="s6949Qry" routerKey="regionCode" routerValue="<%=regionCode%>" retcode="retCode1" retmsg="retMsg1" outnum="11">
		<wtc:param value="0"/>
		<wtc:param value="01"/>
		<wtc:param value="<%=opCode%>"/>
		<wtc:param value="<%=workNo%>"/>
		<wtc:param value="<%=password%>"/>
		<wtc:param value="<%=srv_no%>"/>
		<wtc:param value=""/>
		<wtc:param value=""/>
	</wtc:service>
	<wtc:array id="result1"  scope="end"/>
<%
	System.out.println("====wanghfa====f6949_qry.jsp====s6949Qry====  " + retCode1 + ", " + retMsg1);
	if (!"000000".equals(retCode1)) {
		%>
			<script language="javascript">
				rdShowMessageDialog("s6949Qry：<%=retCode1%>，<%=retMsg1%>。", 1);
				window.history.go(-1);
			</script>
		<%
	} else {
	}
	System.out.println("====wanghfa====f6949_qry.jsp====bs_s6949Sel====0==== phoneNo = " + srv_no);
%>
	<wtc:service name="bs_s6949Sel" routerKey="regionCode" routerValue="<%=regionCode%>" retcode="retCode2" retmsg="retMsg2" outnum="4">
		<wtc:param value="<%=srv_no%>"/>
	</wtc:service>
	<wtc:array id="result2"  scope="end"/>
<%
	System.out.println("====wanghfa====f6949_qry.jsp====bs_s6949Sel====  " + retCode2 + ", " + retMsg2);
	if (!"000000".equals(retCode2)) {
		%>
			<script language="javascript">
				rdShowMessageDialog("bs_s6949Sel：<%=retCode2%>，<%=retMsg2%>。", 1);
				window.history.go(-1);
			</script>
		<%
	} else {
	}
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>集团统一预存赠礼</title>
<META content=no-cache http-equiv=Pragma>
<META content=no-cache http-equiv=Cache-Control>
<META content="MSHTML 5.00.3315.2870" name=GENERATOR>

<script language="JavaScript">

</script>

</head>
<body>
<form name="frm">
<%@ include file="/npage/include/header.jsp" %>
<div class="title">
	<div id="title_zi">集团统一预存赠礼 查询</div>
</div>
<table cellspacing="0">
	<tr>
		<td class="blue" width="20%">手机号码</td>
		<td width="80%">
			<input class="InputGrey" type="text" name="activePhone" value="<%=srv_no%>" id="phoneNo" readonly >
		</td>
	</tr>
</table>
<table cellspacing="0">
	<tr>
		<th>营销案名称</th>
		<th>业务办理时间</th>
		<th>操作工号</th>
		<th>操作工号归属</th>
		<th>专款类型</th>
		<th>开始时间</th>
		<th>结束时间</th>
	</tr>
<%
	for (int i = 0; i < result1.length; i ++) {
		for (int j = 0; j < result1[i].length; j ++) {
			System.out.println("====wanghfa====f6949_qry.jsp====s6949Qry==== result1["+i+"]["+j+"] = " + result1[i][j]);
		}
		
		for (int x = 0; x < result2.length; x ++) {
			System.out.println("====wanghfa====f6949_qry.jsp====bs_s6949Sel====  = " + result2.length);
			for (int y = 0; y < result2[x].length; y ++) {
				System.out.println("====wanghfa====f6949_qry.jsp====bs_s6949Sel==== result2["+x+"]["+y+"] = " + result2[x][y]);
			}
			
			if (result1[i][10].substring(0,6).equals(result2[x][1].substring(0,6))) {
				%>
					<tr>
						<td><%=result1[i][0]%></td>
						<td><%=result1[i][1]%></td>
						<td><%=result1[i][2]%></td>
						<td><%=result1[i][3]%></td>
						<td><%=result2[x][3]%>(<%=result2[x][0]%>)</td>
						<td><%=result2[x][1]%></td>
						<td><%=result2[x][2]%></td>
					</tr>
				<%
			}
		}
	}
%>
	<tr>
		<td colspan="7" align="center" id="foot">
			<input name="back" onClick="window.location='f6949_login.jsp?activePhone=<%=srv_no%>'" type="button" class="b_foot" value="返回">
			<input name="back" onClick="removeCurrentTab()" type="button" class="b_foot" value="关闭">
		</td>
	</tr>
</table>
	
<%@ include file="/npage/include/footer.jsp" %>
</form>
</body>
</html>

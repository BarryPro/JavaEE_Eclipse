<%
/********************
 * version v2.0
 * 开发商: si-tech
 * update by zhangshuaia @ 2009-08-05
 ********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page language="java" import="java.sql.*" %>
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="com.sitech.boss.pub.util.*" %>
<%@ page import="org.apache.log4j.Logger"%>

<%
	String opCode = "4140";
	String opName = "投诉退费原因维护--查询";

	String work_no = (String)session.getAttribute("workNo");
	String loginName = (String)session.getAttribute("workName");
	String org_Code = (String)session.getAttribute("orgCode");
	String regionCode = org_Code.substring(0,2);

	String FirstClass = request.getParameter("FirstClass3");				//退费一级原因
	String SecondClass = request.getParameter("SecondClass3");			//退费二级原因

	String ReqPageName=WtcUtil.repNull(request.getParameter("ReqPageName"));
%>
<wtc:sequence name="TlsPubSelBoss" key="sMaxSysAccept" routerKey="region" routerValue="<%=regionCode%>"  id="seq"/>
<%
  String sysAccept = seq;
  System.out.println("sysAccept="+sysAccept);
  String op_code = "4140";
%>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>

<META content=no-cache http-equiv=Pragma>
<META content=no-cache http-equiv=Cache-Control>
<META content="MSHTML 5.00.3315.2870" name=GENERATOR>

<title><投诉退费原因维护--查询</title>

<%@ include file="../../npage/s4140/head_4140_3_javascript.htm" %>
<script type="text/javascript" src="/npage/s3000/js/S3000.js"></script>
<script language=javascript>
onload=function()
{
	document.all.b_back.focus();
	var regionCode = document.all.regionCode.value;
	var op_code = document.all.op_code.value;
	var FirstClass = document.all.FirstClass.value;
	var SecondClass = document.all.SecondClass.value;
	self.status="";
	document.qryOprInfoFrame.location = "f4140_3_getInfo.jsp?regionCode="+regionCode+"&op_code="+op_code+"&FirstClass="+FirstClass+"&SecondClass="+SecondClass;
}
</script>
</head>

<body>

<form action="" method="POST" name="f4140_3"  onKeyUp="chgFocus(f4140_3)">
<%@ include file="/npage/include/header.jsp" %>
<div class="title">
	<div id="title_zi">业务信息</div>
</div>
<input type="hidden" name="op_code" id="op_code" value="<%=op_code%>">
<input type="hidden" name="regionCode" value="<%=regionCode%>">
<input type="hidden" name="FirstClass" value="<%=FirstClass%>">
<input type="hidden" name="SecondClass" value="<%=SecondClass%>">
<%@ include file="../../include/remark.htm" %>
<table cellspacing="0">
	<tr>
		<td style="height:0;">
			<iframe frameBorder="0" id="qryOprInfoFrame" align="center" name="qryOprInfoFrame" scrolling="yes" style="height:300px;overflow-y:auto; visibility:inherit; width:99%; z-index:1; display:block;"  onload="document.getElementById('qryOprInfoFrame').style.height=qryOprInfoFrame.document.body.scrollHeight+'px'"></iframe>
		</td>
	</tr>
</table>
<table cellspacing="0">
	<tr id="footer">
		<td colspan="4">
			<input class="b_foot" type="hidden" name="confirm" value="确认"  onClick=" printCommit()" disabled>
			<input class="b_foot" type="hidden" name=back value="清除" onclick="doReset()" >
			<input class="b_foot" type="button" name="b_back" value="返回"  onClick="javaScript:history.go(-1)">
		</td>
	</tr>
</table>
<%@ include file="/npage/include/footer.jsp" %>
</form>
</body>
</html>

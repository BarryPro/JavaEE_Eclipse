<%
/***************************************
***	version v1.0
***	开发商: si-tech
***	作	者：zhangyan
***	日	期：2012/3/7 18:21:51
***************************************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<%@ page contentType="text/html; charset=GB2312" %>
<%@ include file="/npage/include/public_title_name.jsp" %>

<html>
<%
String opCode = WtcUtil.repStr(request.getParameter("opCode"), "");
String opName = WtcUtil.repStr(request.getParameter("opName"), "");
String regCode= WtcUtil.repNull((String)session.getAttribute("regCode"));
String workNo	= WtcUtil.repNull((String)session.getAttribute("workNo"));

String iLoginAccept	=""; /*流水*/
String iChnSource		=""; /*渠道标识*/
String iOpCode			="e665"; /*操作代码*/
String iLoginNo			=workNo; /*工号*/
String iLoginPwd		=""; /*工号密码*/
String iPhoneNo			=""; /*手机号码*/
String iUserPwd			=""; /*号码密码*/
String iOpNote			=""; /*备注*/
String iOpType			=request.getParameter("opType"); 
String iOpTypeName	="";
if (iOpType.equals("1"))
{
	iOpTypeName="新增";
}
else if (iOpType.equals("1"))
{
	iOpTypeName="修改";
}
else
{
	iOpTypeName="删除";
}
iOpNote="集团产品托收关系维护"+iOpTypeName;
String iContractNo	=request.getParameter("contractNo"); 
String iPayCode			=request.getParameter("payCode");
String iBankCode		=request.getParameter("bankCode"); /*银行代码*/
String iPostBankCode=request.getParameter("postBankCode"); /*局方银行代码*/
String iAccountNo		=request.getParameter("accountNo"); /*银行帐号*/
String iGrpIdNo			=request.getParameter("grpIdNo");
%>
<head>
<META content="MSHTML 5.00.3315.2870" name=GENERATOR>
<script language=javascript>
function doBack()
{
	history.go(-1);
}

</script>
</head>

<wtc:service name="sE665Cfm" outnum			="20" 
	retcode		="errcode1" 		retmsg			="errmsg1" 
	routerKey	="region" 			routerValue	="<%=regCode%>">
	<wtc:param value="<%=iLoginAccept%>" />
	<wtc:param value="<%=iChnSource%>" />
	<wtc:param value="<%=iOpCode%>" />
	<wtc:param value="<%=iLoginNo%>" />
	<wtc:param value="<%=iLoginPwd%>" />
	<wtc:param value="<%=iPhoneNo%>" />
	<wtc:param value="<%=iUserPwd%>" />
	<wtc:param value="<%=iOpNote%>" />
	<wtc:param value="<%=iOpType%>" />
	<wtc:param value="<%=iContractNo%>" />
	<wtc:param value="<%=iPayCode%>" />
	<wtc:param value="<%=iBankCode%>" />
	<wtc:param value="<%=iPostBankCode%>" />
	<wtc:param value="<%=iAccountNo%>" />
	<wtc:param value="<%=iGrpIdNo%>" />
</wtc:service>
<wtc:array id="result3" start="0" length="20" scope="end"/>
<script language="javascript">
var errCode = "<%=errcode1%>"
if (errCode!="000000")
{
	rdShowMessageDialog("errCode="+"<%=errcode1%>"
		+"调用服务出错，请联系系统管理员！");
	document.frm.action="fE665Qry.jsp";
	document.submit();
}
</script>
<body>
<form name="frm" method="POST">
<%@ include file="/npage/include/header.jsp" %>
<div class="title">
	<div name="title_zi" id="title_zi">出错列表</div>
</div>
<table cellspacing="0">
	<tr>
		<th class="blue" align="center">产品账户</td>
		<th class="blue" align="center">出错原因</td>
	</tr>
	<%
	for ( int i=0;i<result3.length;i++ )
	{
	%>
	<tr>
		<td align="center"><%=result3[i][0]%></td>	
		<td align="center"><%=result3[i][1]%></td>	
	</tr>
	<%
	}
	%>
	<tr>
		<td colspan="2" align="center">
			列表为空，则说明全部成功！
		</td>
	</tr>
	<tr>
		<td colspan="2" id="footer">
			<input class="b_foot" type=button name="back" value="返回" 
				onclick="doBack();">
			<input class="b_foot" type=button name="closeB" value="关闭" 
				onClick="removeCurrentTab();">
		</td>
	</tr>
</table>

<%@ include file="/npage/include/footer_simple.jsp" %> 
</form>
</body>
</html>
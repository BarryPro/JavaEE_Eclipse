<%
/***************************************
***	version v1.0
***	������: si-tech
***	��	�ߣ�zhangyan
***	��	�ڣ�2012/3/7 18:21:51
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

String iLoginAccept	=""; /*��ˮ*/
String iChnSource		=""; /*������ʶ*/
String iOpCode			="e665"; /*��������*/
String iLoginNo			=workNo; /*����*/
String iLoginPwd		=""; /*��������*/
String iPhoneNo			=""; /*�ֻ�����*/
String iUserPwd			=""; /*��������*/
String iOpNote			=""; /*��ע*/
String iOpType			=request.getParameter("opType"); 
String iOpTypeName	="";
if (iOpType.equals("1"))
{
	iOpTypeName="����";
}
else if (iOpType.equals("1"))
{
	iOpTypeName="�޸�";
}
else
{
	iOpTypeName="ɾ��";
}
iOpNote="���Ų�Ʒ���չ�ϵά��"+iOpTypeName;
String iContractNo	=request.getParameter("contractNo"); 
String iPayCode			=request.getParameter("payCode");
String iBankCode		=request.getParameter("bankCode"); /*���д���*/
String iPostBankCode=request.getParameter("postBankCode"); /*�ַ����д���*/
String iAccountNo		=request.getParameter("accountNo"); /*�����ʺ�*/
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
		+"���÷����������ϵϵͳ����Ա��");
	document.frm.action="fE665Qry.jsp";
	document.submit();
}
</script>
<body>
<form name="frm" method="POST">
<%@ include file="/npage/include/header.jsp" %>
<div class="title">
	<div name="title_zi" id="title_zi">�����б�</div>
</div>
<table cellspacing="0">
	<tr>
		<th class="blue" align="center">��Ʒ�˻�</td>
		<th class="blue" align="center">����ԭ��</td>
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
			�б�Ϊ�գ���˵��ȫ���ɹ���
		</td>
	</tr>
	<tr>
		<td colspan="2" id="footer">
			<input class="b_foot" type=button name="back" value="����" 
				onclick="doBack();">
			<input class="b_foot" type=button name="closeB" value="�ر�" 
				onClick="removeCurrentTab();">
		</td>
	</tr>
</table>

<%@ include file="/npage/include/footer_simple.jsp" %> 
</form>
</body>
</html>
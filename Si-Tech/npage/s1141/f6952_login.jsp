<%
  /* *********************
   * ����:������������Ԥ��
   * �汾: 1.0
   * ����: 2009/09/02
   * ����: fengry
   * ��Ȩ: si-tech
   * *********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<%@ page contentType="text/html; charset=GBK" %>
<%@ page import="com.sitech.boss.pub.util.ErrorMsg" %>
<%@ include file="/npage/include/public_title_name.jsp" %>

<%
	request.setCharacterEncoding("GBK");
%>
<html>
<head>
<title>������������Ԥ��</title>
<%
	String opCode = "6952";
	String opName = "������������Ԥ��";
	activePhone = WtcUtil.repNull(request.getParameter("activePhone"));
	String orgCode =(String)session.getAttribute("orgCode");
	String regionCode = orgCode.substring(0,2);
	System.out.println("regionCode======================"+regionCode);
	System.out.println("f6952_login.jsp-->activePhone==="+activePhone+"@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@");
%>

<META content=no-cache http-equiv=Pragma>
<META content=no-cache http-equiv=Cache-Control>
<META content="MSHTML 5.00.3315.2870" name=GENERATOR>

<%
  String Prosql = "select project_code, project_name from sPayReturn where region_code = '"+regionCode+"'";
  System.out.println("Prosql==="+Prosql);
%>
<wtc:pubselect name="sPubSelect" routerKey="phone" routerValue="<%=activePhone%>" retcode="ProRetCode" retmsg="ProRetMsg" outnum="2">
	<wtc:sql><%=Prosql%></wtc:sql>
</wtc:pubselect>
<wtc:array id="ProStr" scope="end" />
<%
	if(ProRetCode.equals("0") || ProRetCode.equals("000000"))
	{
		System.out.println("���÷���sPubSelect in f6952_login.jsp �ɹ�@@@@@@@@@@@@@@@@@@@@@@@@@@");	        	
	}
	else
	{
		System.out.println("���÷���sPubSelect in f6952_login.jsp ʧ��@@@@@@@@@@@@@@@@@@@@@@@@@@");
%>
		<script language="JavaScript">
		rdShowMessageDialog("�������ʧ�ܣ�");
		history.go(-1);
		</script>
<%}%>

<script language=javascript>
onload = function()
{
	self.status = "";
}

//----------------��֤���ύ����-----------------
function doCfm()
{
	if(document.all.PhoneNo.value.trim().len()==0)
	{
		parent.removeTab("<%=opCode%>");
		return false;
	}	
	frm.submit();
}

</script>
</head>

<body>
<form name="frm" method="POST" action="f6952_1.jsp">
	<%@ include file="/npage/include/header.jsp" %>
	<div class="title">
		<div id="title_zi">������������Ԥ��</div>
	</div>
 	<input type="hidden" name="opCode" value="<%=opCode%>">
 	<input type="hidden" name="opName" value="<%=opName%>">
 	<input type="hidden" name="activePhone" value="<%=activePhone%>">
	<table cellspacing="0">
		<tr>
			<td class="blue">�ֻ�����</td>
			<td>
				<input type="text" size="12" name="PhoneNo" value="<%=activePhone%>" id="PhoneNo" v_minlength=1 v_maxlength=16 v_type="mobphone" v_must=1 maxlength="11" index="0" class="InputGrey" readOnly>
				<font class="orange">*</font>
			</td>
			<td width="16%" class="blue">Ԥ������</td>
			<td>
				<select class="button" type="select" name="ProCodeStr" id="ProCodeStr">
					<%for(int i=0; i<ProStr.length; i++){%>
						<option value="<%=ProStr[i][0]%>--><%=ProStr[i][1]%>"> <%=ProStr[i][0]%>--><%=ProStr[i][1]%> </option>
					<%}%>
				</select>
			</td>
		</tr>
	</table>
	<table cellspacing="0">
		<tr>
			<td id="footer" colspan="4">
				<input class="b_foot" type="button" name="confirm" value="ȷ��" onClick="doCfm()" index="2">&nbsp;
				<input class="b_foot" type="button" name="close" value="�ر�" onClick="parent.removeTab('<%=opCode%>')">
			</td>
		</tr>
	</table>
	<%@ include file="/npage/include/footer_simple.jsp" %>
</form>
</body>
</html>

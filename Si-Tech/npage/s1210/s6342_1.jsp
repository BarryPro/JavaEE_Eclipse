<%
  /* *********************
   * ����:�����������ʱ���ѯ
   * �汾: 1.0
   * ����: 2010/01/19
   * ����:cangjin 
   * ��Ȩ: si-tech
   * *********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="com.sitech.crmpd.boss.bo.ContactInfo"%>

<html>
<META http-equiv=Content-Type content="text/html; charset=GBK">
<head>
<title>�����������ʱ���ѯ</title>
<%

	String opCode = "6342";
	String opName = "�����������ʱ���ѯ";
	String phone_no = request.getParameter("PhoneNo");
	String total_date = "";
	String workNo = (String)session.getAttribute("workNo");

	String phoneNo = WtcUtil.repNull(request.getParameter("activePhone"));
	String ProCode_Str = WtcUtil.repNull(request.getParameter("ProCodeStr"));
	String ProCode[] = ProCode_Str.split("-->");
  
	String password = (String)session.getAttribute("password");
	

%>

<wtc:service name="s6342Init" routerKey="phone" routerValue="<%=phoneNo%>" retcode="initRetCode" retmsg="initRetMsg" outnum="9">
		<wtc:param value=""/>
		<wtc:param value="01"/>
		<wtc:param value="<%=opCode%>"/>
		<wtc:param value="<%=workNo%>"/>
		<wtc:param value=""/>
		<wtc:param value="<%=phone_no%>"/>
		<wtc:param value=""/>
</wtc:service>
<wtc:array id="initStr" scope="end"/>
<%
	System.out.println("initRetCode==="+initRetCode);
	System.out.println("initRetMsg==="+initRetMsg);
	if(!(initRetCode.equals("000000")))
	{
%>
		<script language=javascript>
			rdShowMessageDialog("<%=initRetMsg%>");
			window.location="s6342_login.jsp";
		</script>
<%
		return;
	}
	total_date = initStr[0][3];
%>

<script language="javascript">

function doCfm()
{	
	frm.submit();
}


</script>
</head>

<body>
<%@ include file="/npage/include/header.jsp" %>

	<div class="title">
		<div id="title_zi">��ѯ��Ϣ</div>
	</div>
 	<input type="hidden" name="opCode" value="<%=opCode%>">
 	<input type="hidden" name="opName" value="<%=opName%>">
	<table cellspacing="0">
		<tr>
			<td class="blue">�ֻ�����</td>
			<td>
				<input name="phone_no" value="<%=phone_no%>" type="text" class="InputGrey" v_must=1 readonly id="phoneNo" maxlength="20" size="40">
			</td>
			<td class="blue">�������ʱ��</td>
			<td>
				<input name="total_date" value="<%=total_date%>" type="text" class="InputGrey" v_must=1 readonly id="total_date" maxlength="20" size="40">
			</td>
		</tr>
        
			<td colspan="6" id="footer">
				<input class="b_foot" type="button" name="b_clear" value="����" onClick="window.location.href='s6342_login.jsp';">
			</td>
		</tr>
	</table>
<%@ include file="/npage/include/footer.jsp" %>
</form>
</body>
</html>

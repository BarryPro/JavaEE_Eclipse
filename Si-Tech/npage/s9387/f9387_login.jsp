<!DOCTYPE html PUBLIC "-//W3C//Dtd Xhtml 1.0 transitional//EN" "http://www.w3.org/tr/xhtml1/Dtd/xhtml1-transitional.dtd">
<%
  /*
   * ����: WLAN��ͨ�ʷ��ײ�����
   * �汾: 1.0
   * ����: 2010/6/24
   * ����: dujl
   * ��Ȩ: si-tech
   * update:
  */
%>
<%@	page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%
	request.setCharacterEncoding("GBK");
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>WLAN��ͨ�ʷ��ײ�����</title>
<%

    String opCode=request.getParameter("opCode");
	String opName=request.getParameter("opName");	
	String phoneNo = (String)request.getParameter("activePhone");
    String workNo=(String)session.getAttribute("workNo");
    String regionCode=(String)session.getAttribute("regCode");
%>

</script>
<META content=no-cache http-equiv=Pragma>
<META content=no-cache http-equiv=Cache-Control>
<META content="MSHTML 5.00.3315.2870" name=GENERATOR>
<script language="javascript">
onload=function()
{
	var opCode = "<%=opCode%>";
	if(opCode=="9387")
	{
		document.all.opFlag[0].checked=true;
	}
	if(opCode=="9388")
	{
		document.all.opFlag[1].checked=true;
	}
	if(opCode=="9389")
	{
		document.all.opFlag[2].checked=true;
	}
}

//----------------��֤���ύ����-----------------
function doCfm(subButton)
{
	controlButt(subButton);			//��ʱ���ư�ť�Ŀ�����

	var radio1 = document.getElementsByName("opFlag");
	for(var i=0;i<radio1.length;i++)
	{
		if(radio1[i].checked)
		{
			var opFlag = radio1[i].value;
			if(opFlag=="10")
			{
				document.all.opCode.value="9387";
				document.all.opName.value="WLAN��ͨ�ʷ��ײ�����";
				frm.action="f9387_1.jsp";
			}
			else if(opFlag=="11")
			{
				document.all.opCode.value="9388";
				document.all.opName.value="WLAN��ͨ�ʷ��ײͱ��";
				frm.action="f9388_1.jsp";
			}
			else if(opFlag=="12")
			{
				document.all.opCode.value="9389";
				document.all.opName.value="WLAN��ͨ�ʷ��ײ�ȡ��";
				frm.action="f9388_1.jsp";
			}
		}
	}
	
	frm.submit();	
	return true;
}

function controlButt(subButton)
{
	subButt2 = subButton;
	subButt2.disabled = true;
	setTimeout("subButt2.disabled = false",3000);
}

</script>
</head>
<body>
<form name="frm" method="POST" onKeyUp="chgFocus(frm)">
	<input type="hidden" name="opCode" value="<%=opCode%>">
	<input type="hidden" name="opName" value="<%=opName%>">
	<%@ include file="/npage/include/header.jsp" %>
	<div class="title">
		<div id="title_zi">ѡ���������</div>
	</div>
<table cellspacing="0">
	<tr>
		<td class="blue" width="20%">��������</td>
		<td colspan="3">
			<input type="radio" name="opFlag" value="10"" checked>�ײ�����&nbsp;&nbsp;
			<input type="radio" name="opFlag" value="11">�ײͱ��&nbsp;&nbsp;
			<input type="radio" name="opFlag" value="12">�ײ�ȡ��
		</td>
	</tr>
	<tr>
		<td class="blue">�ֻ�����</td>
		<td>
			<input type="text" size="15" name="srv_no" value="<%=activePhone%>" id="srv_no" v_minlength=1 v_maxlength=16 v_type="mobphone" v_must=1 maxlength="11" index="0" class="InputGrey" readOnly>
				<font color="orange">*</font>
		</td>
	</tr>   
	<tr>
		<td colspan="4" align="center" id="footer"> 
			<input class="b_foot" type=button name="confirm" value="ȷ��" onClick="doCfm(this)" index="2">
			<input class="b_foot" type=button name=back value="���" onClick="frm.reset()">
			<input class="b_foot" type=button name=qryP value="�ر�" onClick="removeCurrentTab();">
		</td>
	</tr>
</table>
    <%@ include file="../../npage/common/pwd_comm.jsp" %>
    <%@ include file="/npage/include/footer_simple.jsp" %>
</form>
</body>
</html>

<%
  /* *********************
   * ����:�ֻ����ӹ���ϵͳ
   * �汾: 1.0
   * ����: 2009/7/30
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
<title>�ֻ����ӹ���ϵͳ</title>
<%
	String opCode = request.getParameter("opCode");
	String opName = request.getParameter("opName");
	activePhone = WtcUtil.repNull(request.getParameter("activePhone"));
	System.out.println("f6936_login.jsp-->activePhone==="+activePhone);
%>

<META content=no-cache http-equiv=Pragma>
<META content=no-cache http-equiv=Cache-Control>
<META content="MSHTML 5.00.3315.2870" name=GENERATOR>
<script language=javascript>
onload = function()
{
	self.status = "";
}

//----------------��֤���ύ����-----------------
function doCheck()
{
	if(document.frm.querytype.value == "99")
	{
		document.all.opcode.value="6937";
		document.all.opName.value="�ֻ�����ȫҵ���˶�";
		doCfm();
	}
	else if(document.frm.querytype.value == "04")
	{
		document.all.opcode.value="6938";
		document.all.opName.value="�ֻ�����ҵ����ͣ";
		doCfm();
	}	
	else if(document.frm.querytype.value == "05")
	{
		document.all.opcode.value="6939";
		document.all.opName.value="�ֻ�����ҵ��ָ�";
		doCfm();
	}
	else if(document.frm.querytype.value == "06")
	{
		document.all.opcode.value="6940";
		document.all.opName.value="�ֻ�����ҵ�񶩹�";
		Check6940();
	}
	else if(document.frm.querytype.value == "07")
	{
		document.all.opcode.value="6941";
		document.all.opName.value="�ֻ�����ҵ���˶�";
		doCfm();
	}
}

function doCfm()
{
	if(document.all.srv_no.value.trim().len()==0)
	{
		parent.removeTab("<%=opCode%>");
		return false;
	}	
	frm.submit();
}

function Check6940()
{
	if(rdShowConfirmDialog("��ȷ���û����ֻ��ն��Ƿ�֧���ֻ����ӹ��ܣ�") == 1)
	{
		doCfm();		
	}	
}

function queryChg()
{
	document.all.chgType.value=document.all.querytype.value;
}

</script>
</head>

<body>
<form name="frm" method="POST" action="f6936_1.jsp">
	<%@ include file="/npage/include/header.jsp" %>
	<div class="title">
		<div id="title_zi">�ֻ����ӹ���ϵͳ</div>
	</div>
	<input type="hidden" name="activePhone" value="<%=activePhone%>">
	<input type="hidden" name="chgType" value="">
	<input type="hidden" name="opcode" value="">
	<input type="hidden" name="opName" value="">

	<table cellspacing="0">
		<tr>
			<td width="16%" class="blue">�������</td>
			<td>
				<input class="InputGrey" value="<%=activePhone%>" name="srv_no" id="srv_no" readonly>
			</td>             
			<td class="blue">��������</td>
			<td>
				<select name="querytype" id="querytype" onchange="queryChg();">
					<option value="99" >�ֻ�����ȫҵ���˶�</option>
				<!-- liujian 2012-7-4 13:13:34 ���ڹر��ֻ�����ҵ��BOSS��ͨȨ�޵ĺ�	-->
				<!--
					<option value="04" >�ֻ�����ҵ����ͣ</option> 
					<option value="05" >�ֻ�����ҵ��ָ�</option>
					<option value="06" >�ֻ�����ҵ�񶩹�</option>
				-->
					<option value="07" >�ֻ�����ҵ���˶�</option>			
				</select>
			</td>
		</tr>	
		<tr>
			<td id="footer" colspan="4">
				<input class="b_foot" type="button" name="confirm" value="ȷ��" onClick="doCheck()" index="2">&nbsp;
				<input class="b_foot" type="button" name="close" value="�ر�" onClick="parent.removeTab('<%=opCode%>')">
			</td>
		</tr>
	</table>
	<%@ include file="/npage/include/footer_simple.jsp" %>
</form>
</body>
</html>

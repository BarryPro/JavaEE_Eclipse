<!DOCTYPE html PUBLIC "-//W3C//Dtd Xhtml 1.0 transitional//EN" "http://www.w3.org/tr/xhtml1/Dtd/xhtml1-transitional.dtd">
<%

  /*
   * ����:��������������
   * �汾: 1.0
   * ����: 2010/06/01
   * ����: dujl
   * ��Ȩ: si-tech
  */
%>
<%@	page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="java.util.*" %>
<%@ page import="java.io.*"%>

<%
	response.setHeader("Pragma","No-Cache"); 
	response.setHeader("Cache-Control","No-Cache");
	response.setDateHeader("Expires", 0); 
    
	String opCode = "8436";
	String opName = "��������������";
	String dateStr = new java.text.SimpleDateFormat("yyyyMM").format(new java.util.Date());
	String orgCode =(String)session.getAttribute("orgCode");
	String regionCode = orgCode.substring(0,2);

%>
<html xmlns="http://www.w3.org/1999/xhtml">
<HEAD>
<script language="JavaScript">
<!--

onload=function()
{		
	
}

function resetJsp()
{
	document.frm.phoneNo.value == "";
	document.frm.endTime.value == "";
}

function cfm()
{
	if(document.all.phoneNo.value.trim() == "")
	{
		document.all.phoneNo.value = "";
		rdShowMessageDialog("������绰���룡");
		return false;
	}
	
	if(document.all.phoneNo.value.length != "11")
	{
		document.all.phoneNo.value = "";
		rdShowMessageDialog("������绰����λ������ȷ��");
		return false;
	}
	
	if(document.all.endTime.value.trim() == "")
	{
		document.all.endTime.value = "";
		rdShowMessageDialog("�������������ޣ�");
		return false;
	}
	
	if(document.all.endTime.value.length != "8")
	{
		document.all.endTime.value = "";
		rdShowMessageDialog("�������������޸�ʽ����ȷ��");
		return false;
	}
	
	if(document.all.endTime.value.trim().substr(4,2) > 12)
	{
		document.all.endTime.value = "";
		rdShowMessageDialog("���������������·ݲ���ȷ��");
		return false;
	}
	
	if(document.all.endTime.value.trim().substr(6,2) > 31)
	{
		document.all.endTime.value = "";
		rdShowMessageDialog("�����������������ڲ���ȷ��");
		return false;
	}
	
	if(document.all.endTime.value.trim() > "20500101")
	{
		document.all.endTime.value = "20500101";
	}
	
	frm.submit();
}

</script> 
 
<title>��������������</title>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
</head>
<BODY>
<form action="f8436Cfm.jsp" method="post" name="frm"  >
	<input type="hidden" name="opCode" value="<%=opCode%>">
	<input type="hidden" name="opName" value="<%=opName%>">
	<%@ include file="/npage/include/header.jsp" %>
	<div class="title">
		<div id="title_zi">��������������</div>
	</div>

<table cellspacing="0">
    <tr>
		<td class="blue" width="20%">�ֻ�����</td>
    	<td colspan="3">
    		<input name="phoneNo" type="text" class="button" size="25" maxlength="15" id="phoneNo"  v_must=1 v_type=0_9 v_name="�ֻ�����" onKeyPress="return isKeyNumberdot(0)" onKeyDown="if(event.keyCode==13) check_HidPwd();">&nbsp;&nbsp;
    		<font color="red">*</font>
    	</td>
  	</tr>
  	<tr>
		<td class="blue" width="20%">��������</td>
    	<td colspan="3">
    		<input name="endTime" type="text" class="button" size="25" maxlength="8" id="endTime"  v_must=1 v_type=0_9 v_name="��������" onKeyPress="return isKeyNumberdot(0)" onKeyDown="if(event.keyCode==13) check_HidPwd();">&nbsp;&nbsp;
    		<font color="red">��*��ʽΪYYYYMMDD��</font>
    	</td>
  	</tr>
  	<tr> 
		<td align="center" id="footer" colspan="4">
			<input type="button" name="select" class="b_foot" value="ȷ��" onclick="cfm()">
			&nbsp;
			<input type="button" name="reset" class="b_foot" value="���" onclick="resetJsp()">
		</td>
	</tr>
</table>
 <%@ include file="/npage/include/footer.jsp" %>
</form>
</BODY>
</HTML>

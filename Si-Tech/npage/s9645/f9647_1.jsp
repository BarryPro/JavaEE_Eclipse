<!DOCTYPE html PUBLIC "-//W3C//Dtd Xhtml 1.0 transitional//EN" "http://www.w3.org/tr/xhtml1/Dtd/xhtml1-transitional.dtd">
<%
  /*
   * ����:ע��������²�ѯ
   * �汾: 1.0
   * ����: 2009/5/21
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
 
	String opCode = "9647";
	String opName = "ע��������²�ѯ";
	String dateStr = new java.text.SimpleDateFormat("yyyyMM").format(new java.util.Date());
	String orgCode =(String)session.getAttribute("orgCode");
	String regionCode = orgCode.substring(0,2);
	StringBuffer  insql = new StringBuffer();

%>

<html xmlns="http://www.w3.org/1999/xhtml">
<HEAD>
<script language="JavaScript">
<!--

onload=function()
{	
	self.status="";
}

function commitJsp()
{
	if(document.all.beginTime.value.trim()=="")
	{
		rdShowMessageDialog("�����뿪ʼʱ��!");
	  	return false;
	}
	if(document.all.endTime.value.trim()=="")
	{
		rdShowMessageDialog("���������ʱ��!");
	  	return false;
	}
	if(document.all.beginTime.value>document.all.endTime.value)
	{
		rdShowMessageDialog("��ʼʱ�䲻�ܴ��ڽ���ʱ��!");
	  	return false;
	}
	if(document.all.updateType.value=="")
	{
		rdShowMessageDialog("�������������!");
	  	return false;
	}
	
	frm.submit();
}
 		
</script> 
 
<title>ע��������²�ѯ</title>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
</head>
<BODY>
<form action="f9647_2.jsp" method="post" name="frm"  >
	<input type="hidden" name="opCode" value="<%=opCode%>">
	<input type="hidden" name="opName" value="<%=opName%>">
	<%@ include file="/npage/include/header.jsp" %>
	<div class="title">
		<div id="title_zi">ע��������²�ѯ</div>
	</div>
<table cellspacing="0">             
	<tr> 
		<td class="blue">��ʼʱ��</td>
		<td> 
			<input name="beginTime" type="text" class="button" maxlength="8" v_name="��ʼʱ��">(YYYYMMDD)
    	</td>
		<td class="blue">����ʱ��</td>
		<td> 
			<input name="endTime" type="text" class="button"  maxlength="8" v_name="����ʱ��">(YYYYMMDD)
    	</td>
	</tr>
	<tr>
		<td class="blue" nowrap>��������</td>
		<td>
			<select name="updateType">
				<option value="" selected>--��ѡ��--</option>
				<option value="U" >�޸�</option>
				<option value="A">����</option>
        		<option value="D">ɾ��</option>
			</select>
		</td>
		<td class="blue" nowrap>��������</td>
		<td> 
			<input name="op_code" type="text" class="button" id="op_code" >
    	</td>
	</tr>	
	<tr> 
		<td align="center" id="footer" colspan="4"> 
			<input type="button" name="confirm" class="b_foot" value="��ѯ" onclick="commitJsp()">
		</td>
	</tr>
</table>
	 <%@ include file="/npage/include/footer.jsp" %>
</form>
</BODY>
</HTML>

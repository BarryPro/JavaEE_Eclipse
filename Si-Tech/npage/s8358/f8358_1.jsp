<!DOCTYPE html PUBLIC "-//W3C//Dtd Xhtml 1.0 transitional//EN" "http://www.w3.org/tr/xhtml1/Dtd/xhtml1-transitional.dtd">
<%

  /*
   * ����:��ѯ�����û���Ϣ������ƽ̨��
   * �汾: 1.0
   * ����: 2009/11/09
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
    
	String opCode = "8358";
	String opName = "��ѯ�����û���Ϣ������ƽ̨��";
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

function selQry()
{
	if(document.all.confirmFlag.value=="oprPromptConfirm")
	{
		if(document.all.phoneNo.value.trim()=="")
		{
			rdShowMessageDialog("�������ֻ����룡");
			return;
		}
		
		var phoneNo = document.frm.phoneNo.value;
		
		document.getElementById("qryOprInfoFrame").style.display="block"; 
		document.qryOprInfoFrame.location = "f8358Info.jsp?phoneNo="+phoneNo;
		
	}
}

function resetJsp()
{
	
}

</script> 
 
<title>��ѯ�����û���Ϣ������ƽ̨��</title>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
</head>
<BODY>
<form action="" method="post" name="frm"  >
	<input type="hidden" name="confirmFlag" value="oprPromptConfirm">
	<input type="hidden" name="opCode" value="<%=opCode%>">
	<input type="hidden" name="opName" value="<%=opName%>">
	<input type="hidden" name="regionCode" value="<%=regionCode%>">
	<%@ include file="/npage/include/header.jsp" %>
	<div class="title">
		<div id="title_zi">��ѯ�����û���Ϣ������ƽ̨��</div>
	</div>

<table cellspacing="0">
    <tr>
		<td class="blue" width="20%">�ֻ�����</td>
    	<td colspan="3">
    		<input name="phoneNo" type="text" class="button" size="25" maxlength="15" id="phoneNo"  v_must=1 v_type=0_9 v_name="�ֻ�����">
    	</td>
  	</tr>
  	<tr> 
		<td align="center" id="footer" colspan="4">
			<input type="button" name="select" class="b_foot" value="��ѯ" onclick="selQry()">
			&nbsp;
			<input type="button" name="reset" class="b_foot" value="���" onclick="resetJsp()">
		</td>
	</tr>
</table>
<table cellspacing="0">
	<tr>
		<td style="height:0;">
			<iframe frameBorder="0" id="qryOprInfoFrame" align="center" name="qryOprInfoFrame" scrolling="yes" style="height:300px;overflow-y:auto; visibility:inherit; width:100%; z-index:1; display:none;"  onload="document.getElementById('qryOprInfoFrame').style.height=qryOprInfoFrame.document.body.scrollHeight+'px'"></iframe>
		</td>
	</tr>
</table>
<table cellspacing="0">
	<tr>
		<td style="height:0;">
			<iframe frameBorder="0" id="qryOprAuditInfoFrame" align="center" name="qryOprAuditInfoFrame" scrolling="yes" style="height:300px; overflow-x:auto;overflow-y:auto; visibility:inherit; width:100%; z-index:1; display:none;"  onload="document.getElementById('qryOprInfoFrame').style.height=qryOprInfoFrame.document.body.scrollHeight+'px'"></iframe>
		</td>
	</tr>
</table>
 <%@ include file="/npage/include/footer.jsp" %>
</form>
</BODY>
</HTML>

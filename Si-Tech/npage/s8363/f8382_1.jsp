<!DOCTYPE html PUBLIC "-//W3C//Dtd Xhtml 1.0 transitional//EN" "http://www.w3.org/tr/xhtml1/Dtd/xhtml1-transitional.dtd">
<%
  /*
   * ����:Ӫҵ����PC�����Ű�����
   * �汾: 1.0
   * ����: 2010/03/18
   * ����: dujl
   * ��Ȩ: si-tech
  */
%>
<%@	page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ include file="/npage/bill/getMaxAccept.jsp" %>
<%@ page import="java.util.*" %>

<%
	response.setHeader("Pragma","No-Cache"); 
	response.setHeader("Cache-Control","No-Cache");
	response.setDateHeader("Expires", 0); 
 
	String opCode = "8382";
	String opName = "Ӫҵ����������Ϣ������";
	String iLoginAccept = "";
	iLoginAccept = getMaxAccept();
%>

<html xmlns="http://www.w3.org/1999/xhtml">
<HEAD>
<script language="JavaScript">
onload=function()
{		
	init();
}

function init()
{
	
}	
var bind_values1 = new Array() ;
var notes = new Array() ;
//----����һ����ҳ��ѡ����֯�ڵ�--- ����
function select_groupId()
{
	var path = "<%=request.getContextPath()%>/npage/rpt/common/grouptree_login.jsp";
    window.open(path,'_blank','height=600,width=300,scrollbars=yes');
}

//ȷ�ϰ�ť
function CommitJsp()
{
	if(document.all.macAddr.value.trim() == "")
	{
		rdShowMessageDialog("PC�����Ų���Ϊ�գ������룡");
		return false;
	}
	if(document.all.groupId.value.trim() == "")
	{
		rdShowMessageDialog("Ӫҵ������Ϊ�գ���ѡ��");
		return false;
	}
	
//	document.form1.action="f8382Cfm.jsp";
 	form1.submit();
}


</script> 
 
<title>Ӫҵ����������Ϣ������</title>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
</head>
<BODY>
<form  method="post" name="form1"  action="f8382Cfm.jsp">
	<%@ include file="/npage/include/header.jsp" %>
	<div class="title">
		<div id="title_zi">Ӫҵ����������Ϣ������</div>
	</div>
<table cellspacing="0">
	<tr>
		<td class="blue">PC������</td>
		<td>
			<input type="text" name="macAddr" id="macAddr" class="button" size="60" maxlength="60">&nbsp;&nbsp;<font color="orange">*</font>
		</td>
	</tr>
	<tr>
		<td class="blue" width="20%">Ӫҵ��</td>
		<td>
			<input type="hidden" name="groupId" id="groupId">
			<input type="text" name="groupName" id="groupName" v_must="1" v_type="string" maxlength="60" class="InputGrey" readonly size="30">&nbsp;<font color="orange">*</font>
			<input name="addButton" class="b_text" type="button" value="ѡ��" onClick="select_groupId()" >	
		</td>
	</tr>
	
	<tr> 
		<td align="center" id="footer" colspan="2">
			<input type="button" name="confirm" class="b_foot" value="ȷ��" onclick="CommitJsp()">
			&nbsp;
			<input type="button" name="close" class="b_foot" value="�ر�" onclick="removeCurrentTab()">
		</td>
	</tr>
</table>
	<input type="hidden" name="opCode" value="<%=opCode%>">
	<input type="hidden" name="opName" value="<%=opName%>">
	<input type="hidden" name="iLoginAccept" value="<%=iLoginAccept%>">
	
	<%@ include file="/npage/include/footer.jsp" %>
</form>
</BODY>
</HTML>
<%
/********************
 version v2.0
 ������: si-tech
 ����: dujl
********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html  xmlns="http://www.w3.org/1999/xhtml">
	
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page contentType="text/html;charset=GBK"%>
<%@ page import="java.util.*"%>
<%
  request.setCharacterEncoding("GBK");
%>
<html>
<head>
<title>�ֻ�֧���˻���Ϣ��ѯ</title>

<%
    String opCode = "9997";
    String opName = "�ֻ�֧���˻����ײ�ѯ";
    String phoneNo = request.getParameter("activePhone");
    String orgCode =(String)session.getAttribute("orgCode");
	String regionCode = orgCode.substring(0,2);

%>

</script>
<META content=no-cache http-equiv=Pragma>
<META content=no-cache http-equiv=Cache-Control>
<META content="MSHTML 5.00.3315.2870" name=GENERATOR>

<script language=javascript>
onload=function()
{
	self.focus();
}

//----------------��֤���ύ����-----------------
function check_HidPwd()
{
	if(document.frm.phoneNo.value=="")
	{
		 rdShowMessageDialog("�������ֻ�����!");
		 document.frm.phoneNo.focus();
		 return false;
	}

  	if( document.frm.phoneNo.value.length != 11 )
  	{
		rdShowMessageDialog("�ֻ�����ֻ����11λ!");
		document.frm.phoneNo.value = "";
		return false;
  	}
}

function doCfm()
{
	if(document.frm.phoneNo.value=="")
  	{
	     rdShowMessageDialog("�������ֻ�����!");
	     document.frm.phoneNo.focus();
	     return false;
  	}
  	
  	if( document.frm.phoneNo.value.length != 11 )
  	{
	     rdShowMessageDialog("�ֻ�����ֻ����11λ!");
	     document.frm.phoneNo.value = "";
	     return false;
  	}
  	
  	if(document.frm.beginDt.value=="")
  	{
	     rdShowMessageDialog("�����뽻�׿�ʼʱ��!");
	     document.frm.beginDt.focus();
	     return false;
  	}
  	
  	if(document.frm.endDt.value=="")
  	{
	     rdShowMessageDialog("�����뽻�׽���ʱ��!");
	     document.frm.endDt.focus();
	     return false;
  	}
  	
  	var phoneNo = document.frm.phoneNo.value;
  	var beginDt = document.frm.beginDt.value;
  	var endDt = document.frm.endDt.value;
  	
  	document.getElementById("qryOprInfoFrame").style.display="block"; 
	document.qryOprInfoFrame.location = "f9997Info.jsp?phoneNo="+phoneNo+"&beginDt="+beginDt+"&endDt="+endDt;
	
}

</script>
</head>
<body>

<form name="frm" method="POST">
<%@ include file="/npage/include/header.jsp" %>
	<div class="title">
		<div id="title_zi"><%=opName%></div>
	</div>
    <table cellspacing="0">
		<tr colspan="2">
			<td class="blue" width="25%">�ֻ�����</td>
			<td> 
				<input class="button"type="text" name="phoneNo" size="20" maxlength="11"  onKeyPress="return isKeyNumberdot(0)" onKeyDown="if(event.keyCode==13) check_HidPwd();">
			</td>
			<td>&nbsp;</td>
			<td>&nbsp;</td>
		</tr>
		<tr>
			<td class="blue" >������ʼʱ��<font color="orange">(YYYYMMDDhhmmss)</font></td>
			<td>
    			<input name="beginDt" type="text" class="button" id="beginDt" size="20" maxlength="14" v_must=1 v_type=string v_name="������ʼʱ��" onKeyPress="return isKeyNumberdot(1)" onKeyDown="if(event.keyCode==13) doprint();">
    		</td>
    		<td class="blue" >���׽���ʱ��<font color="orange">(YYYYMMDDhhmmss)</font></td>
			<td>
    			<input name="endDt" type="text" class="button" id="endDt" size="20" maxlength="14" v_must=1 v_type=string v_name="���׽���ʱ��" onKeyPress="return isKeyNumberdot(1)" onKeyDown="if(event.keyCode==13) doprint();">
    		</td>
		</tr>
		<tr>
			<td colspan="4" id="footer"> 
		  		<div align="center"> 
				  <input class="b_foot" type=button name="confirm" value="��ѯ" onClick="doCfm()" index="2">    
				  <input class="b_foot" type=button name=back value="���" onClick="frm.reset()">
				  <input class="b_foot" type=button name=qryP value="�ر�" onClick="removeCurrentTab();">
		  		</div>
			</td>
		</tr>
	</table>

<input type="hidden" name="opCode" value="<%=opCode%>" >
<input type="hidden" name="opName" value="<%=opName%>" >

<div id="oprDiv" style="display:block">
	<table cellspacing="0">
		<tr>
			<td style="height:0;">
				<iframe frameBorder="0" id="qryOprInfoFrame" align="center" name="qryOprInfoFrame" scrolling="yes" style="height:300px;overflow-y:auto; visibility:inherit; width:100%; z-index:1; display:none;"  onload="document.getElementById('qryOprInfoFrame').style.height=qryOprInfoFrame.document.body.scrollHeight+'px'"></iframe>
			</td>
		</tr>
	</table>
	<table>
		<tr>
			<td style="height:0;">
				<iframe frameBorder="0" id="qryOprAuditInfoFrame" align="center" name="qryOprAuditInfoFrame" scrolling="yes" style="height:300px; overflow-x:auto;overflow-y:auto; visibility:inherit; width:100%; z-index:1; display:none;"  onload="document.getElementById('qryOprInfoFrame').style.height=qryOprInfoFrame.document.body.scrollHeight+'px'"></iframe>
			</td>
		</tr>
	</table>
</div>

<%@ include file="/npage/include/footer_simple.jsp" %>
</form>
</body>
</html>


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
//    String opCode = "9996";
//    String opName = "�ֻ�֧���˻���Ϣ��ѯ";
    String opCode=request.getParameter("opCode");
    String opName=request.getParameter("opName");
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
  	
  	frm.submit();
}

</script>
</head>
<body>
	
<form name="frm" method="POST" action="f9996_2.jsp">
<%@ include file="/npage/include/header.jsp" %> 	
	<div class="title">
		<div id="title_zi"><%=opName%></div>
	</div>
    <table cellspacing="0">
		<tr>
			<td class="blue" width="20%">�ֻ�����</td>
			<td> 
				<input class="button"type="text" name="phoneNo" size="20" maxlength="11"  onKeyPress="return isKeyNumberdot(0)" onKeyDown="if(event.keyCode==13) check_HidPwd();">
			</td>
		</tr>
		<tr> 
			<td colspan="2" id="footer"> 
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
<%@ include file="/npage/include/footer_simple.jsp" %>
</form>
   
</body>
</html>


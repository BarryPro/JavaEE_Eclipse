<%
/********************
 version v2.0
 ������: si-tech
 ģ�飺���Ŀ�����
 update zhaohaitao at 2008.12.25
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
<title>���Ŀ�����</title>
<%
	String opCode = request.getParameter("opCode");
  	String opName = request.getParameter("opName");
%>

<META content=no-cache http-equiv=Pragma>
<META content=no-cache http-equiv=Cache-Control>
<META content="MSHTML 5.00.3315.2870" name=GENERATOR>

<script language=javascript>
  onload=function()
  {
 	self.status="";
    //document.all.srv_no.focus();
  }

//----------------��֤���ύ����-----------------
function doCfm(subButton)
{
	controlButt(subButton);//��ʱ���ư�ť�Ŀ�����
	if(check(frm))
	{
		frm.action="f1253Main.jsp";
		frm.submit();	
	}
}
</script>
</head>
<body>
	
<form name="frm" method="POST" onKeyUp="chgFocus(frm)">
	
	<%@ include file="/npage/include/header.jsp" %>  
	
	<div class="title">
		<div id="title_zi"><%=opName%></div>
	</div>
	
<table cellspacing="0">
	<tr>
		<td class="blue">�ֻ�����</td>
		<td> 
			<input class="InputGrey"  type="text" name="srv_no" value="<%=activePhone%>" id="srv_no" v_minlength=1 v_maxlength=16 v_type="mobphone" index="0" >
		</td>
	</tr>
	<tr>
		<td id="footer" colspan="2" > 
			<div align="center"> 
				<input class="b_foot" type=button name="confirm" value="ȷ��" onClick="doCfm(this)" index="2">    
				<input class="b_foot" type=button name=qryP value="�ر�" onClick="removeCurrentTab();">
			</div>
		</td>
	</tr>
</table>
   <%@ include file="/npage/include/footer_simple.jsp" %>
   <input type="hidden" name="opCode" value="<%=opCode%>">
   <input type="hidden" name="opName" value="<%=opName%>">
   </form>
</body>
</html>
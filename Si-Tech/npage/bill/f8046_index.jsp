<!DOCTYPE html PUBLIC "-//W3C//Dtd Xhtml 1.0 transitional//EN" "http://www.w3.org/tr/xhtml1/Dtd/xhtml1-transitional.dtd">
<%
  /*
   * ����: Ӫ����ȡ��8046
   * �汾: 1.0
   * ����: 2010/11/03
   * ����: huangrong
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
<title>Ӫ����ȡ��</title>
<%

  String opCode=request.getParameter("opCode");
	String opName=request.getParameter("opName");	
	String phoneNo = (String)request.getParameter("activePhone");
  String workNo=(String)session.getAttribute("workNo");
  String regionCode=(String)session.getAttribute("regCode");
  String[][] favInfo=(String[][])session.getAttribute("favInfo");
%>

<META content=no-cache http-equiv=Pragma>
<META content=no-cache http-equiv=Cache-Control>
<META content="MSHTML 5.00.3315.2870" name=GENERATOR>
<script language="javascript">
  onload=function()
  {
		document.all.opFlag[0].checked=true;
  }

//----------------��֤���ύ����-----------------
function doCfm(subButton)
{
	var radio1 = document.getElementsByName("opFlag");
	var flag = document.getElementById("flag");
	for(var i=0;i<radio1.length;i++)
	{
		if(radio1[i].checked)
		{
			var opFlag = radio1[i].value;
			if(opFlag=="one")
			{
				flag.value="0";			
			}else if(opFlag=="two")
			{
				flag.value="1";
			}
			frm.action="f8046_login.jsp";
			document.all.opcode.value="8046";
		}
  }
	frm.submit();	
	return true;
}

</script>
</head>
<body>
<form name="frm" method="POST" onKeyUp="chgFocus(frm)">
 	<input type="hidden" name="opcode" >
	<%@ include file="/npage/include/header.jsp" %>
	<div class="title">
		<div id="title_zi">ѡ���������</div>
	</div>
<table cellspacing="0">
	<tr> 
		<td class="blue" width="20%">��������</td>
		<td colspan="3">
			<input type="radio" name="opFlag" value="one">��ЧӪ����ȡ��&nbsp;&nbsp;
			<input type="radio" name="opFlag" value="two">ԤԼӪ����ȡ��&nbsp;&nbsp;
			<input type="hidden" name="phoneNo" value="<%=phoneNo%>">
			<input type="hidden" name="flag" id="flag" value="">
			
			
		</td>
	</tr>     
	<tr> 
		<td colspan="4" align="center" id="footer"> 
			<input class="b_foot" type=button name="confirm" value="ȷ��" onClick="doCfm(this)" index="2">    
			<input class="b_foot" type=button name=qryP value="�ر�" onClick="removeCurrentTab();">
		</td>
	</tr>
</table>
    <%@ include file="/npage/include/footer_simple.jsp" %>
</form>
</body>
</html>

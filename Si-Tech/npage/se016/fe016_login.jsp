<!DOCTYPE html PUBLIC "-//W3C//Dtd Xhtml 1.0 transitional//EN" "http://www.w3.org/tr/xhtml1/Dtd/xhtml1-transitional.dtd">
<%
  /*
   * ����: ѫ�¶һ���Ʒ����
   * �汾: 1.0
   * ����: 2011/7/5
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
<title>ѫ�¶һ���Ʒ����</title>
<%
  String opCode=request.getParameter("opCode");
	String opName=request.getParameter("opName");	
%>

<META content=no-cache http-equiv=Pragma>
<META content=no-cache http-equiv=Cache-Control>
<META content="MSHTML 5.00.3315.2870" name=GENERATOR>
<script language="javascript">
  onload=function()
  {
  	var opCode = "<%=opCode%>";
  	if(opCode=="e016"){
		document.all.opFlag[0].checked=true;	
  	}
  	if(opCode=="e017"){
		document.all.opFlag[1].checked=true;  		
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

			var flag=document.getElementById("flag");
			if(opFlag=="one")
			{
				frm.action="fe016_1.jsp";
			
			}else if(opFlag=="two")
			{
				frm.action="fe017_1.jsp";
			}
		}
  }
	frm.submit();	
	return true;
}
 function controlButt(subButton){
	subButt2 = subButton;
	subButt2.disabled = true;
	setTimeout("subButt2.disabled = false",3000);
  }
</script>
</head>
<body>
<form name="frm" method="POST" onKeyUp="chgFocus(frm)">
	<%@ include file="/npage/include/header.jsp" %>
	<div class="title">
		<div id="title_zi">ѡ���������</div>
	</div>
<table cellspacing="0">
	<tr> 
		<td class="blue" width="20%">��������</td>
		<td colspan="3">
			<input type="radio" name="opFlag" value="one">����&nbsp;&nbsp;
			<input type="radio" name="opFlag" value="two">�޸�&nbsp;&nbsp;
		</td>
	</tr>       
	<tr> 
		<td colspan="4" align="center" id="footer"> 
			<input class="b_foot" type=button name="confirm" value="ȷ��" onClick="doCfm(this)" index="2">    
			<input class="b_foot" type=button name="close" value="�ر�" onClick="removeCurrentTab();">
		</td>
	</tr>
</table>
    <%@ include file="../../npage/common/pwd_comm.jsp" %>
    <%@ include file="/npage/include/footer_simple.jsp" %>
</form>
</body>
</html>


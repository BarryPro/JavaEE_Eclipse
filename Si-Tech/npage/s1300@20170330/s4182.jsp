<%
/********************
 version v2.0
������: si-tech
********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	
<%@ page contentType="text/html;charset=GB2312"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%
  request.setCharacterEncoding("GBK");
%>

<head>
<title>POS�ɷѲ�ѯ����</title>
<%
	String opCode = (String)request.getParameter("opCode");
	String opName="POS�ɷѲ�ѯ����";

	String work_no = (String)session.getAttribute("workNo");
	String loginName = (String)session.getAttribute("workName");
	String org_Code = (String)session.getAttribute("orgCode");
	
%>

<script language=javascript>
  onload=function()
  {
    if("<%=opCode%>" == "4183"){
        document.all.opFlag[1].checked = true;
    }else{
        document.all.opFlag[0].checked = true;
    }
  }

//----------------��֤���ύ����-----------------
function doCfm(subButton)
{
  controlButt(subButton);//��ʱ���ư�ť�Ŀ�����
  if(!check(frm)) return false;
  var radio1 = document.getElementsByName("opFlag");
  for(var i=0;i<radio1.length;i++)
  {
    if(radio1[i].checked)
		{
		  var opFlag = radio1[i].value;
		  if(opFlag=="one")
		  {
		    alert("�˹���δ����!");		    
		  }else if(opFlag=="two")
		  {
		    frm.action="s4183_1.jsp";
		  }
		}
  }
  frm.submit();	
  return true;
}
</script>
</head>
<body>
	
<form name="frm" method="POST" onKeyUp="chgFocus(frm)">
<%@ include file="/npage/include/header.jsp" %>
<div class="title">
	<div id="title_zi">POS�ɷѲ�ѯ</div>
</div>

<table cellspacing="0">
	<TR> 
		<TD class="blue">��������</TD>
		<TD class="blue" colspan="3">
		<input type="radio" name="opFlag" value="one" >POS�ɷѲ�ѯ���׽���&nbsp;&nbsp;
		<input type="radio" name="opFlag" value="two" >POS�ɷ����˲�ѯ����
		</TD>
	</TR>
	<tr> 
		<td class="blue">����</td>
		<td class="blue" colspan="3"> 
		<input class="InputGrey"  type="text" name="work_no" id="work_no" value="<%=work_no%>">
		</td>
	</tr>
	<tr>    
		<td class=Lable nowrap colspan="4">&nbsp;</td>
	</tr>
	<tr> 
		<td colspan="4" id="footer"> 
			<div align="center"> 
			<input class="b_foot" type=button name="confirm" value="ȷ��" onClick="doCfm(this)" index="2">    
			<input class="b_foot" type=button name=back value="���" onClick="frm.reset()">
			<input class="b_foot" type=button name=qryP value="�ر�" onClick="parent.removeTab('<%=opCode%>');">
			</div>
		</td>
	</tr>
</table>
<%@ include file="/npage/include/footer_simple.jsp"%>
</form>
</body>
</html>
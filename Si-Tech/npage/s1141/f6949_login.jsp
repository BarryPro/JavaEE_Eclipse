<!DOCTYPE html PUBLIC "-//W3C//Dtd Xhtml 1.0 transitional//EN" "http://www.w3.org/tr/xhtml1/Dtd/xhtml1-transitional.dtd">
<%
  /*
   * ����: ����ͳһԤ������6949
   * �汾: 1.0
   * ����: 2008/12/30
   * ����: leimd
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
<title>����ͳһԤ������</title>
<%
    String opCode="6949";
	String opName="����ͳһԤ������";	
	String phoneNo = (String)request.getParameter("activePhone");
    String workNo=(String)session.getAttribute("workNo");
    String regionCode=(String)session.getAttribute("regCode");
    String[][] favInfo=(String[][])session.getAttribute("favInfo");
	boolean workNoFlag=false;
	if(workNo.substring(0,1).equals("k"))
		workNoFlag=true;
%>

</script>
<META content=no-cache http-equiv=Pragma>
<META content=no-cache http-equiv=Cache-Control>
<META content="MSHTML 5.00.3315.2870" name=GENERATOR>
<script language="javascript">
  onload=function()
  {
  	var opCode = "<%=opCode%>";
  	if(opCode=="6949"){
		document.all.opFlag[0].checked=true;
		opchange();		
  	}
  	if(opCode=="6950"){
		document.all.opFlag[1].checked=true;  
		opchange();			
  	}
  }
//----------------��֤���ύ����-----------------
function doCfm(subButton)
{
	controlButt(subButton);			//��ʱ���ư�ť�Ŀ�����
//	if(!check(frm)) return false; 
	var radio1 = document.getElementsByName("opFlag");
	for(var i=0;i<radio1.length;i++)
	{
		if(radio1[i].checked)
		{
			var opFlag = radio1[i].value;
			if(opFlag=="one") {
				document.getElementById("preFlag").value = "0";
				frm.action="f6949_1.jsp";
				document.all.opcode.value="6949";
			} else if(opFlag=="two") {
				if(document.all.backaccept.value==""){
					rdShowMessageDialog("������ҵ����ˮ��",1)
					return;
				}
				document.getElementById("preFlag").value = "0";
				frm.action="f6950_1.jsp";
				document.all.opcode.value="6950";
			} else if(opFlag=="three") {
				document.getElementById("preFlag").value = "1";
				frm.action="f6949_1.jsp";
				document.all.opcode.value="6949";
			} else if(opFlag=="four") {
				if(document.all.backaccept.value==""){
					rdShowMessageDialog("������ҵ����ˮ��",1)
					return;
				}
				document.getElementById("preFlag").value = "1";
				frm.action="f6950_1.jsp";
				document.all.opcode.value="6950";
			} else if(opFlag=="five") {
				frm.action="f6949_qry.jsp";
				document.all.opcode.value="6949";
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
function opchange(){
	
	 if(document.all.opFlag[0].checked==true || document.all.opFlag[2].checked==true || document.all.opFlag[4].checked==true) 
	{
	  	document.all.backaccept_id.style.display = "none";
	}else{
	  	document.all.backaccept_id.style.display = "";
	}
}
</script>
</head>
<body>
<form name="frm" method="POST" onKeyUp="chgFocus(frm)">
 	<input type="hidden" name="opcode" >
 	<input type="hidden" name="preFlag" id="preFlag" value="">
 	
	<%@ include file="/npage/include/header.jsp" %>
	<div class="title">
		<div id="title_zi">ѡ���������</div>
	</div>
<table cellspacing="0">
	<tr> 
		<td class="blue" width="20%">��������</td>
		<td colspan="3">
			<input type="radio" name="opFlag" value="one" onclick="opchange()">����&nbsp;&nbsp;
			<input type="radio" name="opFlag" value="two" onclick="opchange()">����&nbsp;&nbsp;
			<input type="radio" name="opFlag" value="three" onclick="opchange()">ԤԼ����&nbsp;&nbsp;
			<input type="radio" name="opFlag" value="four" onclick="opchange()">ԤԼ����&nbsp;&nbsp;
			<input type="radio" name="opFlag" value="five" onclick="opchange()">��ѯ
		</td>
	</tr>    
	<tr> 
		<td class="blue">�ֻ����� </td>
		<td> 
			<input type="text" size="12" name="srv_no" value="<%=activePhone%>" id="srv_no" v_minlength=1 v_maxlength=16 v_type="mobphone" v_must=1 maxlength="11" index="0" class="InputGrey" readOnly>
				<font color="orange">*</font>
		</td>
	</tr>
	<tr style="display:none" id="backaccept_id"> 
		<td class="blue">ҵ����ˮ</td>
		<td colspan="3">
			<input class="button" type="text" name="backaccept" v_must=1 >
				<font color="orange">*</font>
		</td>
	</tr>    
	<tr> 
		<td colspan="4" align="center" id="footer"> 
			<input class="b_foot" type=button name="confirm" value="ȷ��" onClick="doCfm(this)" index="2">    
			<input class="b_foot" type=button name=back value="���" onClick="frm.reset()">
			<input class="b_foot" type=button name=qryP value="�ر�" onClick="removeCurrentTab();">
		</td>
	</tr>
</table>
    <%@ include file="../../npage/common/pwd_comm.jsp" %>
    <%@ include file="/npage/include/footer_simple.jsp" %>
</form>
</body>
</html>

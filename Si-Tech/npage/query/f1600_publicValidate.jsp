<%
    /********************
     version v2.0
     ������: si-tech
     *
     *create by lipf 20120326
     *
     ********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%
  request.setCharacterEncoding("GBK");
%>

<html>
<head>
<title>�û������޸�</title>
<META content="MSHTML 5.00.3315.2870" name=GENERATOR>
<%@ include file="/npage/common/pwd_comm.jsp" %>
<%
	String opCode = request.getParameter("opCode");
	System.out.println("ningtn opCode " + opCode);
	String opName = request.getParameter("opName");
	String inputType="0";
	String changType="0";
	String op_code=request.getParameter("opCode");
	String workNo = (String)session.getAttribute("workNo");
	String broadPhone = request.getParameter("broadPhone");
	String idNo= request.getParameter("idNo");
	activePhone=request.getParameter("activePhone");
	
	String operationType=request.getParameter("oprationType");
	if (operationType!=null&&operationType.equals("change")){
		changType=request.getParameter("changType");
		if (changType.equals("1")){
			inputType="1";
		}else{ 
			inputType="0";
		}
	}
%>


<script language=javascript>

	onload=function()
	{
		if(<%=activePhone%>==null||<%=activePhone%>==""){
			rdShowMessageDialog("�����´򿪴��޸���ҳ��!");
			parent.removeTab("<%=opCode%>");
			return false;
		}
 		self.status="";
 		/* ����opcode�ж�Ӧ���ĸ�radio�н��� */
  	var changType = "<%=changType%>";
  	if(changType == "0"){
  		$("input[name='r_cus']:eq(0)").attr("checked",'checked');
  	}else{
  		$("input[name='r_cus']:eq(1)").attr("checked",'checked'); 
  	}
 		//��ʼ����ʱ��,�����û������Ƿ���Ҫ����
 		for(var i=0;i<document.getElementsByName("r_cus").length;i++){
 			if(document.getElementsByName("r_cus")[i].checked){
 				if(document.getElementsByName("r_cus")[i].value=="0"){
 					$('#pwd1').css({'display':'block'});
					$('#pwd2').css({'display':'block'});
 				}else{
 					$('#pwd1').css({'display':'none'});
					$('#pwd2').css({'display':'none'});
 				}
 			}
 		}
	}

	$(document).ready(function(){
		
	});

	function changeidtype()
	{
		if (document.all.identity_type.value == "01")
		{
			document.all.identity_info.disabled = false;
		}else{
			document.all.identity_info.disabled = true;
		}	
	}

//-------2---------��֤���ύ����-----------------
	function doCfm(){ 
		if(document.s3216.t_new_pass.value.length==0){
			rdShowMessageDialog("�����벻��Ϊ�գ�");
			document.all.t_new_pass.focus();
			return;
		}
		if(document.s3216.t_new_pass.value.trim().len() != 6){
			rdShowMessageDialog("������ĳ���Ӧ����6λ");
			document.all.t_new_pass.focus();
			return;
		}
		
		if(!forNonNegInt(document.s3216.t_new_pass)){
			return;
		}
		
		if(document.s3216.t_conf_pass.value.trim().len()==0){
			rdShowMessageDialog("У�����벻��Ϊ��!");
			return;				
		}
		
		if(!forNonNegInt(document.s3216.t_conf_pass)){
			return;
		}
		
		if(document.s3216.t_new_pass.value!=document.s3216.t_conf_pass.value){
			rdShowMessageDialog("������������벻һ�£�");
			return;
		}
		
		s3216.action="f1600_pwdMain.jsp";
	  s3216.submit();
	}


</script>
</head>
<body>

<form name="s3216" method="POST">
  <input type="hidden" name="ReqPageName" id="ReqPageName" value="f1600_publicValidate">
  <input type="hidden" name="rCus" value="">
  <input type="hidden" name="activePhone" value="<%=activePhone%>">
  <input type="hidden" name="idNo" value="<%=idNo%>">
<%@ include file="/npage/include/header.jsp" %>     	
		<div class="title">
			<div id="title_zi">ѡ���������</div>
		</div>
<table cellspacing="0">
<tr>
    <td class="blue">��������</td>
    <td colspan="3">
        ��������
    </td>
</tr>
<tr>
		<td width="16%" class="blue">����˺�</td>
    <td>
       <input type="text" name="broadPhone" id="broadPhone" value="<%=broadPhone%>" class="InputGrey" readonly>
       <input type="hidden" name="cus_id" id="cus_id" value="<%=activePhone%>" />
    </td>
</tr>
<tr>
  <TD width="13%" class="blue"><div align="left">������</div></TD>
	<TD >
		<input name="t_new_pass" type="password" onKeyPress="return isKeyNumberdot(0)" 
		class="button"  maxlength="6">
		<font class="orange">*</font> 
	</TD>
</tr>
<tr>
	<TD width="13%" class="blue"><div align="left">������У��</div></TD>
	<TD>
		<input  name="t_conf_pass" type="password" onKeyPress="return isKeyNumberdot(0)"  class="button" prefield="t_new_pass" filedtype="pwd" maxlength="6" onFocus="showReNumberDialog(document.all.t_conf_pass)" >
		<font class="orange">*</font> 
	</TD>
</tr>
<tr>
    <td colspan="5" id="footer">
      <input class="b_foot" type=button name=qryPage value="ȷ��" onClick="doCfm()" index="2" onKeyUp="if(event.keyCode==13){doCfm()}">
      <input class="b_foot" type=button name=back value="���" onClick="s3216.reset()">
      <input class="b_foot" type=button name=qryPage value="�ر�" onClick="parent.removeTab('<%=op_code%>')">
    </td>
</tr>
</table>
<input type="hidden" name="opCode" id="opCode" value="<%=opCode%>" />
<input type="hidden" name="opName" id="opName" value="<%=opName%>" />
  <%@ include file="/npage/include/footer_simple.jsp" %> 
   </form>
</body>
</html>
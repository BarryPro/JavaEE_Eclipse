<!DOCTYPE html PUBLIC "-//W3C//Dtd Xhtml 1.0 transitional//EN" "http://www.w3.org/tr/xhtml1/Dtd/xhtml1-transitional.dtd">
<%
  /*
   * ����:������ȡƱ��ά�벹��
   * �汾: 1.0
   * ����: 2009/5/14
   * ����: wangjya
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
 
	String opCode = "6922";
	String opName = "������ȡƱ��ά�벹��";
	String orgCode =(String)session.getAttribute("orgCode");
	String regionCode = orgCode.substring(0,2);

%>

<html xmlns="http://www.w3.org/1999/xhtml">
<HEAD>
<script language="JavaScript">
<!--	
onload=function()
{		
	init();
}

// ��ʼ��
function init()
{
}
function commitJsp()
{
		getAfterPrompt();
		if(document.all.phone_no.value.trim().length != 11)
		{
			rdShowMessageDialog("�ֻ��������Ϊ11λ!");
			return false;					
		}
		if(document.all.phone_psw.value.trim().length <=0 && document.all.opFlag[0].checked == true)
		{
			rdShowMessageDialog("�������û�����!");
			return false;					
		}
		if(	document.all.opFlag[0].checked == true)
		{
			document.all.cust_type.value = "0";
		}
		else
		{
			document.all.cust_type.value = "1";
		}		
		document.all.phone_password.value = document.all.phone_psw.value.trim();
		frm6922.submit();
}
function opchange(){
	

	 if(document.all.opFlag[0].checked==true) 
	{
	  	
	  	document.all.back_password.style.display = "";
	  }else {
	  	document.all.back_password.style.display = "none";
	  	rdShowMessageDialog("��ؿͻ�����ͨ��'��ؿͻ����ϲ�ѯ'��֤�û�����!");
	  }

}


function Clear()
{
	document.all.phone_no.value = "";
	document.all.phone_psw.value = "";
}
</script> 
 
<title>������ȡƱ��ά�벹��</title>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
</head>
<BODY>
<form action="f6922_2.jsp" method="post" name="frm6922"  >
	<input type="hidden" name="opCode" value="<%=opCode%>">
	<input type="hidden" name="opName" value="<%=opName%>">
	<input type="hidden" name="phone_password" value="">
	<input type="hidden" name="cust_type" value="">
	<%@ include file="/npage/include/header.jsp" %>
	<div class="title">
		<div id="title_zi">������ȡƱ��ά�벹��</div>
	</div>
<table cellspacing="0" id="sel"  >
	<TR> 
	          <TD class="blue">�û�����</TD>
              <TD colspan=3>
        		<input type="radio" name="opFlag" value="one" onclick="opchange()" checked >��ʡ�û�&nbsp;&nbsp;
        		<input type="radio" name="opFlag" value="two" onclick="opchange()" >����û�&nbsp;&nbsp;
	          </TD>
         </TR>                
	<tr> 
		<td class="blue" width="10%" >�ֻ�����:</td>
		<td> 
			<input name="phone_no" type="text" id="phone_no" size="20" maxlength="11"  onKeyPress="return isKeyNumberdot(0)"></td>
    	</td>
    </tr>
	<tr id="back_password" > 
		<td class="blue"  width="10%" >�û�����:</td>
    	<td>
    	  	<jsp:include page="/npage/common/pwd_one_new.jsp">
			<jsp:param name="width1" value="16%"  />
			<jsp:param name="width2" value="34%"  />
			<jsp:param name="pname" value="phone_psw"  />
			<jsp:param name="pwd" value=""  />
			</jsp:include>
    	</td>
	</tr>
	<tr> 
		<td align="center" id="footer" colspan="4"> 
			<input type="button" name="confirm" class="b_foot" value="ȷ��" onclick="commitJsp()">	
			&nbsp;
			<input type="button" name="delete" class="b_foot" value="���" onclick="Clear()">		
		</td>
	</tr>
</table>
	 <%@ include file="/npage/include/footer.jsp" %>
	 	<%@ include file="/npage/common/pwd_comm.jsp"%>
</form>
</BODY>
</HTML>

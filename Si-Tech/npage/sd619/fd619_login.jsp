<%
  /*
   * ����: �ֻ�ƾ֤�ط� d619
   * �汾: 1.8.2
   * ����: 2011/5/13
   * ����: huangrong
   * ��Ȩ: si-tech
   * update:
  */
%>
            
<%
	String opCode = request.getParameter("opCode");
  String opName = request.getParameter("opName");
%>              
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http//www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http//www.w3.org/1999/xhtml">
<%@ include file="/npage/include/public_title_name.jsp" %> 
<%@ include file="../../npage/bill/getMaxAccept.jsp" %>
<%@ page import="com.sitech.crmpd.boss.bo.ContactInfo"%>
<%@ page contentType= "text/html;charset=GBK" %>
 
<HTML><HEAD><TITLE><%=opName%></TITLE>
<META content="text/html; charset=GBK" http-equiv=Content-Type>
<META content=no-cache http-equiv=Pragma>
<META content=no-cache http-equiv=Cache-Control>

<%
String phoneNo = (String)request.getParameter("activePhone");
%>

<script language="JavaScript">
function printCommit(){
  getAfterPrompt();	 
	if( document.frm.phoneNo.value==""){
		rdShowMessageDialog("�ֻ����벻��Ϊ�գ������룡");
		return false;
	}		
	document.frm.confirm.disabled=true;//��ֹ����ȷ��
	document.frm.action = "fd619Cfm.jsp";
	document.frm.submit();
}
</script>
</HEAD>
<BODY >
<FORM  method=post name=frm >
	<%@ include file="/npage/include/header.jsp" %>

	<div class="title">
		<div id="title_zi"><%=opName%></div>
	</div> 
  <table cellspacing="0">
		 	<tr>
	 			<td class="blue">�ֻ�����</td>
	 			<td colspan="3"><input type="text" name="phoneNo" id="phoneNo" value="<%=phoneNo%>" readOnly class="InputGrey"></td>
			</tr>											
	</table>
	<table>					
		 	<tr>	
		 		<td id="footer" colspan="4">
		 			<input type="button" id="confirm" class="b_foot" value="ȷ��" onclick="printCommit()">
		 			<input type="button" id="colse"  class="b_foot" value="�ر�" onclick="removeCurrentTab()">
		 		</td>
		 	</tr>
	</table>
<input type="hidden" name="iOpCode"  value="<%=opCode%>">
<input type="hidden" name="opName" value="<%=opName%>">

</FORM>
		<%@ include file="/npage/include/footer.jsp"%>
</BODY> 	
</HTML>
						
  					

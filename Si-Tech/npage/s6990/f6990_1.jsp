<%
/********************
 version v2.0
 ������ si-tech
 create hejwa@2010-1-14 :14:39
********************/
%>
              
<%
	String opCode = request.getParameter("opCode");
  String opName = request.getParameter("opName");
%>              
			
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http//www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http//www.w3.org/1999/xhtml">
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %> 
<head>
	
<title>�ͻ�����ȵ���������Ϣ </title>
 
<script language=javascript>
	
 function mysub(){
 	document.all.frm.action = "f6990_2.jsp";
 	document.all.frm.submit();
 }
  
</script>
</head>
<body>
	
<form name="frm" method="POST">
<%@ include file="/npage/include/header.jsp" %>
<div class="title">
	<div id="title_zi">�ͻ�����ȵ���������Ϣ</div>
</div>

	<table  cellspacing="0" >
		<tr>
			 <td class="blue">
			 �������
			 </td>
			 
			 <td>
			 	<input type="text" id="phoneNo" name="phoneNo" value="<%=activePhone%>" readOnly class="InputGrey">
			</td>
			
		</tr>
 
		 
		</table>
 
		<table>
		<tr>
			<td id="footer" >
				<input type="button" value="ȷ��" class="b_foot" onclick="mysub()">
				<input type="button" value="�ر�" class="b_foot" onclick="removeCurrentTab()">
			</td>
		</tr>
	</table>

<%@ include file="/npage/include/footer.jsp" %>
</form>
</body>
</html>
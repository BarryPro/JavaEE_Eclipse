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
	
<title>�ֻ����� </title>
 
<script language=javascript>
	
 function mysub(){
 	document.frm.action = "f6993_2.jsp";
 	document.frm.submit();
 }
  
</script>
</head>
<body>
	
<form name="frm" method="POST">
<%@ include file="/npage/include/header.jsp" %>
<div class="title">
	<div id="title_zi">�ֻ�����</div>
</div>

	<table  cellspacing="0" >
		<tr>
			 <td class="blue">
			 �������
			 </td>
			 
			 <td>
			 	<input type="text"  name="phoneNo"  id="phoneNo" value="<%=activePhone%>" readOnly class="InputGrey">
			</td>
			
			<td class="blue">
			 ��������
			 </td>
			 
			 <td>
			 	<select id="opType" name="opType">
			 		<option value="01">����</option>
			 		<option value="02">ȡ��</option>
			  </select>	
			</td>
		</tr>
		<tr>
			<td class="blue">
			 ҵ������
			 </td>
			 
			 <td>
			 	<select id="ywType" name="ywType">
			 		<option value="01">����</option>
			 		<option value="02">����</option>
			  </select>	
			</td>
			
			
			<td class="blue">
			 �·�����
			 </td>
			 
			 <td>
			 	<select id="xfType" name="xfType">
			 		<option value="02">SMS</option>
			 		<option value="01">WAP</option>
			  </select>	
			</td>
		</tr>
 <tr>
			<td class="blue">
			 ��������
			 </td>
			 
			 <td>
			 	<select id="qdType" name="qdType">
			 		<option value="01">BOSS</option>
			 		<option value="02">����Ӫҵ��</option>
			 		<option value="03">����Ӫҵ��</option>
			 		<option value="04">����Ӫҵ��</option>
			 		<option value="05">��ý���ѯ��</option>
			 		<option value="06">10086</option>
			  </select>	
			</td>
			
			
			<td class="blue">
			 &nbsp;
			 </td>
			 
			 <td>
			 	&nbsp;
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
<%
/********************
Ӧ�ò���ҳ��
���ƵĿͻ���������
���룺��request.attribute��ȡ������ ������ �� _paraMap(tux�����Ĭ��ֵ)
�����tux�ӿ�Ҫ��ĸ������� ������ ������
********************/
%>

<%@ page contentType= "text/html;charset=gb2312" %>
<%@ taglib uri="/WEB-INF/wtc.tld" prefix="wtc" %>
<%@ page import="java.util.*" %>
<%@ page import="com.sitech.boss.workflow.ParseParaxml" %>
<%
  	String _wano = (String)request.getAttribute("_wano");
%>

<form name='customform'>
   <input type='hidden' name='wano' value='<%=_wano%>'>
   	���Ѳ�ѯ��<br>
  <table>
<tr>
  	<td>�绰���룺</td>
  	<td>
	<input type='text' name='phone_no' value='13000000001'>
	</td>
	<td>����</td>
	<td>
	<input type='text' name='_1007' >
</td>
</tr><tr>
<td>���:</td>
<td>
	<select name='_1006'>
		<option value='1'>ͨ��</option>
		<option value='0'>��ͨ��</option>
	</select>
</td>
</tr>
</table>
</form>

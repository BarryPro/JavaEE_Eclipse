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
	<input type='text' name='_1145' value='1'>
	<input type='text' name='_1147' value='1'>

</form>

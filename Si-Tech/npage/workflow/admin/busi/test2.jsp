<%
/********************
Ӧ�ò���ҳ��
���ƵĿͻ���������
���룺��request.attribute��ȡ������ ������ �� _paraMap(tux�����Ĭ��ֵ)
�����tux�ӿ�Ҫ��ĸ������� ������ ������
********************/
%>

<%@ include file="/page/workflow/admin/pub/wb_include.jsp" %>

<%
  	String _wano = (String)request.getAttribute("_wano");
  	Map map = (Map)request.getAttribute("_paraMap");
%>

<%!
String getValue(Map map,String key)
{
	String value = (String)map.get(key);
	if(value==null||value.equals(""))
	{
		value="";
	}
	return value;
}
%>
<%@ include file="/page/workflow/admin/pub/head_view.jsp" %>

<form name='customform' action='busi/test20.jsp'>
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
	<input type='text' name='A' value='<%=getValue(map,"A")%>' >
</td>
</tr>
<tr>
  	<td>ͨ�ŷ�:</td>
  	<td>
	<input type='text' name='B' value='<%=getValue(map,"B")%>' readonly>
	</td>
	<td>�Żݷ�:</td>
	<td>
	<input type='text' name='result' value='<%=getValue(map,"result")%>' >
</td>
</tr>

<tr>
<td>���:</td>
<td>
	<select name='_1006' value='<%=getValue(map,"_1006")%>'>
		<option value='1'>ͨ��</option>
		<option value='0'>��ͨ��</option>
	</select>
</td>
</tr>
</table>
</form>
<div id='commanddiv'>
	<input type=button value='����' onclick='return _save(document.customform)'>
	<input type=button value='�ύ' onclick='return _saveAndSubmit(document.customform)'>
</div>
<%@ include file="/page/workflow/admin/pub/foot_view.jsp" %>

<jsp:include page="/page/workflow/admin/pub/f_wb_pub_url_include.jsp"  flush="true"/>

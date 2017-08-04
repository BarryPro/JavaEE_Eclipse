<%
/********************
应用测试页面
定制的客户交互界面
输入：从request.attribute获取订单号 工单号 和 _paraMap(tux传入的默认值)
输出：tux接口要求的各个参数 订单号 工单号
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
   	话费查询：<br>
  <table>
<tr>
  	<td>电话号码：</td>
  	<td>
	<input type='text' name='phone_no' value='13000000001'>
	</td>
	<td>话费</td>
	<td>
	<input type='text' name='A' value='<%=getValue(map,"A")%>' >
</td>
</tr>
<tr>
  	<td>通信费:</td>
  	<td>
	<input type='text' name='B' value='<%=getValue(map,"B")%>' readonly>
	</td>
	<td>优惠费:</td>
	<td>
	<input type='text' name='result' value='<%=getValue(map,"result")%>' >
</td>
</tr>

<tr>
<td>审核:</td>
<td>
	<select name='_1006' value='<%=getValue(map,"_1006")%>'>
		<option value='1'>通过</option>
		<option value='0'>不通过</option>
	</select>
</td>
</tr>
</table>
</form>
<div id='commanddiv'>
	<input type=button value='保存' onclick='return _save(document.customform)'>
	<input type=button value='提交' onclick='return _saveAndSubmit(document.customform)'>
</div>
<%@ include file="/page/workflow/admin/pub/foot_view.jsp" %>

<jsp:include page="/page/workflow/admin/pub/f_wb_pub_url_include.jsp"  flush="true"/>

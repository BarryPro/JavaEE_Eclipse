<%
/********************
应用测试页面
定制的客户交互界面
输入：从request.attribute获取订单号 工单号 和 _paraMap(tux传入的默认值)
输出：tux接口要求的各个参数 订单号 工单号
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
   	话费查询：<br>
  <table>
<tr>
  	<td>电话号码：</td>
  	<td>
	<input type='text' name='phone_no' value='13000000001'>
	</td>
	<td>话费</td>
	<td>
	<input type='text' name='_1007' >
</td>
</tr><tr>
<td>审核:</td>
<td>
	<select name='_1006'>
		<option value='1'>通过</option>
		<option value='0'>不通过</option>
	</select>
</td>
</tr>
</table>
</form>

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
	<input type='text' name='_1145' value='1'>
	<input type='text' name='_1147' value='1'>

</form>

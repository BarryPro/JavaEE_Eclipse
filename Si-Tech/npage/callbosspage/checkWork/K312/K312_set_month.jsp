<%
  /**
   * 功能: 
　 * 版本: 1.0.0
　 * 日期: 
　 * 作者: 
　 * 版权: sitech
   * update:
　 */
%>
<%@ page contentType="text/html;charset=gbk"%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ page import="com.sitech.crmpd.core.wtc.util.*,java.util.*"%>

<%
//获取参数
String dateflag=request.getParameter("dateflag");
String updSql = "update dserialNodate set dateflag = '" + dateflag + "'";
System.out.println(updSql);
%>
<wtc:service name="sPubModify" outnum="3">
		<wtc:param value="<%=updSql%>"/>
		<wtc:param value="dbcall"/>
</wtc:service>				
var response = new AJAXPacket();
response.data.add("retCode","000000");      
core.ajax.receivePacket(response);
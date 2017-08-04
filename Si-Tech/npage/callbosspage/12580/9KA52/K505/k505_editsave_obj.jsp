
<%
	 /*
	 * 功能: 12580群组-新建编辑-update群组
	 * 版本: 1.0.0
	 * 日期: 2009/01/12
	 * 作者: xingzhan
	 * 版权: sitech
	 * update:
	 */
%>

<%@ page contentType="text/html;charset=gb2312"%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ page import="com.sitech.crmpd.core.wtc.util.*,java.util.*,java.text.SimpleDateFormat"%>

<%
  
  String opCode = "K505";
  String opName = "群组维护";
  
  String SERIAL_NO = request.getParameter("SERIAL_NO")==null?"":request.getParameter("SERIAL_NO");
  String GRP_NAME = request.getParameter("GRP_NAME")==null?"":request.getParameter("GRP_NAME");
  String ACCEPT_NO = request.getParameter("ACCEPT_NO")==null?"":request.getParameter("ACCEPT_NO");
  String GRP_DESCR = request.getParameter("GRP_DESCR")==null?"":request.getParameter("GRP_DESCR");
  
  String Sql = "select SERIAL_NO from DMSGGRP where GRP_NAME = '"+GRP_NAME+"' and ACCEPT_NO = '"+ACCEPT_NO+"' and GRP_TYPE = '1'";

%>
<wtc:service name="s151Select" outnum="1">
	<wtc:param value="<%=Sql%>" />
</wtc:service>
<wtc:array id="queryList" scope="end" />
<%
if(queryList.length > 0 && !SERIAL_NO.equalsIgnoreCase(queryList[0][0])){
%>
var response = new AJAXPacket(); 
response.data.add("retCode",'44444'); 
core.ajax.receivePacket(response);
<%
}else{ 
  String strUpSql = "update DMSGGRP set GRP_NAME = '"+GRP_NAME+"',ACCEPT_NO = '"+ACCEPT_NO+"',GRP_DESCR = '"+GRP_DESCR+"' where SERIAL_NO = '"+SERIAL_NO+"'";
%>

<wtc:service name="sKFModify" outnum="2">
	<wtc:param value="<%=strUpSql%>" />
	</wtc:service>
	<wtc:array id="retRows" scope="end" />
	var response = new AJAXPacket(); 
	response.data.add("retCode",<%=retCode%>); 
	core.ajax.receivePacket(response);
<% 
}
%>
	

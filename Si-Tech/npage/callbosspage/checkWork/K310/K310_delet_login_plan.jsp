<%
  /*
   * 功能: 删除计划明细
　 * 版本: 1.0.0
　 * 日期: 2008/11/05
　 * 作者: tancf
　 * 版权: sitech
   * update:
　 */
%>
<%
	String opCode = "K310";
	String opName = "删除计划明细";
%>
<%@ page contentType="text/html;charset=gbk"%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ page import="com.sitech.crmpd.core.wtc.util.*,java.util.*"%>
<%

String primarykey = request.getParameter("primarykey");

String strSql = "delete from dqcloginplan where trim(plan_id) || '_' || trim(object_id) || '_' || trim(content_id) || '_' || trim(login_no) = :v1";
String orgCode = (String)session.getAttribute("orgCode");
String regionCode = orgCode.substring(0,2); 
%>

<wtc:service name="sPubModifyKfCfm" outnum="2" routerKey="region" routerValue="<%=regionCode%>">
<wtc:param value="<%=strSql%>"/>
<wtc:param value="dbchange"/>
<wtc:param value="<%=primarykey%>"/>
</wtc:service>
<wtc:array id="retRows"  scope="end"/>	

var response = new AJAXPacket();
response.data.add("retCode",<%=retCode%>);
core.ajax.receivePacket(response);
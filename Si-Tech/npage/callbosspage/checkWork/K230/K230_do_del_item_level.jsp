<%
  /*
   * 功能: 删除考评项等级
　 * 版本: 1.0.0
　 * 日期: 2008/11/05
　 * 作者: mixh
　 * 版权: sitech
   * update:
　 */
%>
<%
	String opCode = "K230";
	String opName = "删除考评项等级";
%>

<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%
	String orgCode = (String)session.getAttribute("orgCode");
	String regionCode = orgCode.substring(0,2);
	
	String retType    = WtcUtil.repNull(request.getParameter("retType"));
	String serialno   = WtcUtil.repNull(request.getParameter("serialno"));
	String sqlStr     = "delete from dqcckectitemlevel where serialno = :v1 ";
%>

<wtc:service name="sPubModifyKfCfm" outnum="2" routerKey="region" routerValue="<%=regionCode%>">
<wtc:param value="<%=sqlStr%>"/>
	<wtc:param value="dbchange"/>
	<wtc:param value="<%=serialno%>"/>
</wtc:service>

<wtc:array id="queryList" scope="end"/>	

var response = new AJAXPacket();
response.data.add("retType","<%=retType%>");
response.data.add("retCode","<%="000000"%>");
response.data.add("retMsg","<%="success"%>");
core.ajax.receivePacket(response);


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
	String retType    = WtcUtil.repNull(request.getParameter("retType"));
	String serialno   = WtcUtil.repNull(request.getParameter("serialno"));
	String sqlStr     = "delete from dqcckectitemlevel where serialno = '" + serialno + "'";
	System.out.println("############################################");
    System.out.println(sqlStr);
    System.out.println("############################################"); 
%>

<wtc:service name="s151Select" outnum="2">
<wtc:param value="<%=sqlStr%>"/>
</wtc:service>

<wtc:array id="queryList" scope="end"/>	

var response = new AJAXPacket();
response.data.add("retType","<%=retType%>");
response.data.add("retCode","<%="000000"%>");
response.data.add("retMsg","<%="success"%>");
core.ajax.receivePacket(response);


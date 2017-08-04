<%
  /*
   * 功能: 判断当前流水是否已经进行过质检
　 * 版本: 1.0.0
　 * 日期: 
　 * 作者: zengzq
　 * 版权: sitech
   * update:
　 */
%>

<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ page import="com.sitech.crmpd.core.wtc.util.*,java.util.*"%>

<%
		String plan_id = WtcUtil.repNull(request.getParameter("plan_id"));
		String bqcgrouptype = WtcUtil.repNull(request.getParameter("bqcgrouptype"));
		String returnNum = WtcUtil.repNull(request.getParameter("returnNum"));
%>
<wtc:service name="RK400getSerial" outnum="4">
	<wtc:param value="<%=plan_id.trim()%>"/>
	<wtc:param value="<%=bqcgrouptype.trim()%>"/>
	<wtc:param value="<%=returnNum.trim()%>"/>
</wtc:service>
<wtc:row id="row" start="0" length="4">

var response = new AJAXPacket();
response.data.add("retCode","<%=row[0]%>");
response.data.add("retMsg","<%=row[1]%>");
response.data.add("out_returnVal","<%=row[2]%>");
response.data.add("returnNum","<%=row[3]%>");
core.ajax.receivePacket(response);
</wtc:row>
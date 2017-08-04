<%
  /*
   * 功能: 请假日志记录
　 * 版本: 1.0.0
　 * 日期: 2008/10/21
　 * 作者: mixh
　 * 版权: sitech
   *update:
　 */
%>
<%
	//String opCode = "K012";
	//String opName = "请假日志记录";
%>

<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%
	System.out.println("############################################");

	String retType = WtcUtil.repNull(request.getParameter("retType"));
	String id = WtcUtil.repNull(request.getParameter("id"));
	String rest_login_no = WtcUtil.repNull(request.getParameter("rest_login_no"));
	String current_status = WtcUtil.repNull(request.getParameter("current_status"));
	
	System.out.println(id);
	System.out.println(rest_login_no);
	System.out.println(current_status);

   System.out.println("############################################");
   
%>

<wtc:service name="sK012insert" outnum="2">
	<wtc:param value="<%=id%>"/>
	<wtc:param value="<%=rest_login_no%>"/>
	<wtc:param value="<%=current_status%>"/>
</wtc:service>

<wtc:row id="row" start="0" length="2">
<%
System.out.println("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$");
System.out.println(row[0]);
System.out.println(row[1]);
System.out.println("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$");
%>

var response = new AJAXPacket();
response.data.add("retType","<%=retType%>");
response.data.add("retCode","<%=row[0]%>");
response.data.add("retMsg","<%=row[1]%>");
core.ajax.receivePacket(response);

</wtc:row>
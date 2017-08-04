<%
  /*
   * 功能: 请假时间到日志记录
　 * 版本: 1.0.0
　 * 日期: 2008/10/21
　 * 作者: mixh
　 * 版权: sitech
   *update:
　 */
%>
<%
	//String opCode = "K012";
	//String opName = "请假时间到日志记录";
%>

<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%
	System.out.println("############################################");

	String retType = WtcUtil.repNull(request.getParameter("retType"));
	String id = WtcUtil.repNull(request.getParameter("id"));
	String rest_login_no = WtcUtil.repNull(request.getParameter("rest_login_no"));
	String current_status = WtcUtil.repNull(request.getParameter("current_status"));
	
	String  staffstatus = WtcUtil.repNull(request.getParameter("staffstatus"));
	String  checkno = WtcUtil.repNull(request.getParameter("checkno"));
	String  ccsworkno = WtcUtil.repNull(request.getParameter("ccsworkno"));
	String  kf_no = WtcUtil.repNull(request.getParameter("kf_no"));
	String  kf_name= WtcUtil.repNull(request.getParameter("kf_name"));
	String  class_id= WtcUtil.repNull(request.getParameter("class_id"));
	String  org_id= WtcUtil.repNull(request.getParameter("org_id"));
	String  duty= WtcUtil.repNull(request.getParameter("duty"));
	String  op_code= WtcUtil.repNull(request.getParameter("op_code"));		

   System.out.println("############################################");
   
%>

<wtc:service name="sK012upd" outnum="2">
	<wtc:param value="<%=id%>"/>
	<wtc:param value="<%=rest_login_no%>"/>
	<wtc:param value="<%=current_status%>"/>
	<wtc:param value="<%=staffstatus%>"/>
	<wtc:param value="<%=checkno%>"/>
	<wtc:param value="<%=ccsworkno%>"/>
	<wtc:param value="<%=kf_no%>"/>
	<wtc:param value="<%=kf_name%>"/>
	<wtc:param value="<%=class_id%>"/>
	<wtc:param value="<%=org_id%>"/>
	<wtc:param value="<%=duty%>"/>
	<wtc:param value="<%=op_code%>"/>	
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
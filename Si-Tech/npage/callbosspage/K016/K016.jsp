<%
  /*
   * 功能: 请求来话日志记录
　 * 版本: 1.0.0
　 * 日期: 2008/10/22
　 * 作者: mixh
　 * 版权: sitech
   *update:
　*/
%>
<%
	//String opCode = "K016";
	//String opName = "请求来话日志记录";
%>

<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%

   String retType = WtcUtil.repNull(request.getParameter("retType"));
   String login_no = WtcUtil.repNull(request.getParameter("login_no"));
   String staffstatus = WtcUtil.repNull(request.getParameter("staffstatus"));
   String checkno = WtcUtil.repNull(request.getParameter("checkno"));
   String ccsworkno = WtcUtil.repNull(request.getParameter("ccsworkno"));
   String op_code = WtcUtil.repNull(request.getParameter("op_code"));
   String kf_no = WtcUtil.repNull(request.getParameter("kf_no"));
   String kf_name = WtcUtil.repNull(request.getParameter("kf_name"));
   String class_id = WtcUtil.repNull(request.getParameter("class_id"));
   String org_id = WtcUtil.repNull(request.getParameter("org_id"));
   String duty = WtcUtil.repNull(request.getParameter("duty"));
%>

<wtc:service name="sK016insert" outnum="2">
	<wtc:param value="<%=login_no%>"/>
	<wtc:param value="<%=staffstatus%>"/>
	<wtc:param value="<%=checkno%>"/>
	<wtc:param value="<%=ccsworkno%>"/>
	<wtc:param value="<%=op_code%>"/>
	<wtc:param value="<%=kf_no%>"/>
	<wtc:param value="<%=kf_name%>"/>	
	<wtc:param value="<%=class_id%>"/>
	<wtc:param value="<%=org_id%>"/>
	<wtc:param value="<%=duty%>"/>			
</wtc:service>
<wtc:row id="row" start="0" length="2" scope="end">
<%
     //System.out.println("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$");
     //System.out.println(retCode);
     //System.out.println(retMsg);
     //System.out.println("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$");

%>

var response = new AJAXPacket();
response.data.add("retType","<%=retType%>");
response.data.add("retCode","<%=retCode%>");
response.data.add("retMsg","<%=retMsg%>");
core.ajax.receivePacket(response);

</wtc:row>
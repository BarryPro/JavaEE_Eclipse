<%
  /*
   * 功能: 挂机释放日志记录
　 * 版本: 1.0.0
　 * 日期: 2008/10/17
　 * 作者: mixh
　 * 版权: sitech
   *update:
　*/
%>
<%
	//String opCode = "K005";
	//String opName = "挂机释放日志记录";
%>

<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%
   String retType = WtcUtil.repNull(request.getParameter("retType"));
   String contact_id = WtcUtil.repNull(request.getParameter("contact_id"));
   String login_no = WtcUtil.repNull(request.getParameter("login_no"));
   String staffstatus = WtcUtil.repNull(request.getParameter("staffstatus"));
   String checkno = WtcUtil.repNull(request.getParameter("checkno"));
   String ccsworkno = WtcUtil.repNull(request.getParameter("ccsworkno"));
   String kf_no = WtcUtil.repNull(request.getParameter("kf_no"));
   String kf_name = WtcUtil.repNull(request.getParameter("kf_name"));
   String class_id = WtcUtil.repNull(request.getParameter("class_id"));
   String org_id = WtcUtil.repNull(request.getParameter("org_id"));
   String duty = WtcUtil.repNull(request.getParameter("duty"));
   String op_code = WtcUtil.repNull(request.getParameter("op_code"));
   String now_yyyy_mm = WtcUtil.repNull(request.getParameter("now_yyyy_mm"));
   String outCallFlag = WtcUtil.repNull(request.getParameter("outCallFlag"));
   String hang_up = WtcUtil.repNull(request.getParameter("hang_up"));
%>

<wtc:service name="sK013insert" outnum="2">
	<wtc:param value="<%=contact_id%>"/>
	<wtc:param value="<%=login_no%>"/>
	<wtc:param value="<%=staffstatus%>"/>
	<wtc:param value="<%=checkno%>"/>
	<wtc:param value="<%=ccsworkno%>"/>
	<wtc:param value="<%=kf_no%>"/>
	<wtc:param value="<%=kf_name%>"/>
	<wtc:param value="<%=class_id%>"/>
	<wtc:param value="<%=org_id%>"/>
	<wtc:param value="<%=duty%>"/>
	<wtc:param value="<%=op_code%>"/>
	<wtc:param value="<%=now_yyyy_mm%>"/>
  <wtc:param value="<%=hang_up%>"/>
  <wtc:param value="<%=outCallFlag%>"/>	
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




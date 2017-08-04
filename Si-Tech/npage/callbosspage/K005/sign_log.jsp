<%
  /*
   * 功能: 签入、签出日志记录
　 * 版本: 1.0.0
　 * 日期: 2008/10/17
　 * 作者: mixh
　 * 版权: sitech
   *update:
　*/
%>
<%
	//String opCode = "K005";
	//String opName = "签入、签出日志记录";
%>

<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%

   String retType = WtcUtil.repNull(request.getParameter("retType"));
   String login_no = WtcUtil.repNull(request.getParameter("login_no"));
   String ipaddress = WtcUtil.repNull(request.getParameter("ipaddress"));
   String grade_code = WtcUtil.repNull(request.getParameter("grade_code"));

   /*
   String retType = "chkExample";
   String login_no = "102";
   String ipaddress = "10.204.16.104";
   String grade_code = "5";
   */
%>

<wtc:service name="sK005insert" outnum="2">
	<wtc:param value="<%=login_no%>"/>
	<wtc:param value="<%=ipaddress%>"/>
	<wtc:param value="<%=grade_code%>"/>
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




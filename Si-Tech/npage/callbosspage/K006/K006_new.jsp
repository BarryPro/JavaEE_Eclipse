<%
  /*
   * 功能: 签出日志记录
　 * 版本: 1.0.0
　 * 日期: 2008/10/17
　 * 作者: mixh
　 * 版权: sitech
   *update:
　*/
%>
<%
	//String opCode = "K006";
	//String opName = "签出日志记录";
%>

<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%

   String retType = WtcUtil.repNull(request.getParameter("retType"));
   String login_no = WtcUtil.repNull(request.getParameter("login_no"));
   String ipaddress = WtcUtil.repNull(request.getParameter("ipaddress"));
   String grade_code = WtcUtil.repNull(request.getParameter("grade_code"));
   String staffstatus = WtcUtil.repNull(request.getParameter("staffstatus"));
   String checkno = WtcUtil.repNull(request.getParameter("checkno"));
   String ccsworkno = WtcUtil.repNull(request.getParameter("ccsworkno"));
   String op_code = WtcUtil.repNull(request.getParameter("op_code"));
%>

<wtc:service name="sK006insert" outnum="2">
	<wtc:param value="<%=login_no%>"/>
	<wtc:param value="<%=ipaddress%>"/>
	<wtc:param value="<%=grade_code%>"/>
	<wtc:param value="<%=staffstatus%>"/>
	<wtc:param value="<%=checkno%>"/>
	<wtc:param value="<%=ccsworkno%>"/>
	<wtc:param value="<%=op_code%>"/>	
</wtc:service>
	<wtc:array id="rows"  scope="end"/>
	<%
	  if(rows[0][0].equals("000001")){
	     retCode = "000001";
	     retMsg = "保存关系失败";
	  }
	  out.println("login_no|"+login_no+"|ipaddress|"+ipaddress+"|grade_code|"+grade_code+"|staffstatus|"+staffstatus+"|checkno|"+checkno+"|ccsworkno|"+ccsworkno+"|op_code|"+op_code);
	//System.out.println("login_no|"+login_no+"|ipaddress|"+ipaddress+"|grade_code|"+grade_code+"|staffstatus|"+staffstatus+"|checkno|"+checkno+"|ccsworkno|"+ccsworkno+"|op_code|"+op_code+"kangxq");
	%>
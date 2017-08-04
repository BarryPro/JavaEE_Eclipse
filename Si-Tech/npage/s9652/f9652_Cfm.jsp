<%
  /*
   * 功能: 清理记录
   * 版本: 1.0
   * 日期: 2009/05/22
   * 作者: yanpx
   * 版权: si-tech
   * update:
   */
%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ page contentType="text/html; charset=GBK" %>
<%@ page import="java.util.*"%>
<%@ page import="java.text.*"%>
<%
	 	String opCode = request.getParameter("opCode");
	 	String opName = request.getParameter("opName");
		String work_no =(String)session.getAttribute("workNo");
		String org_code =(String)session.getAttribute("orgCode");
		String regionCode = org_code.substring(0,2);
		
		
		String taskId=request.getParameter("taskId"); 
		String taskStatus=request.getParameter("taskStatus");
		String taskNote=request.getParameter("taskNote"); 
		

%>
	<wtc:service name="sStatuCh" routerKey="regionCode" routerValue="<%=regionCode%>"  retcode="errCode" retmsg="errMsg"  outnum="2" >
		<wtc:param value="<%=taskId%>"/>
		<wtc:param value="<%=taskStatus%>"/>
		<wtc:param value="<%=taskNote%>"/>
		<wtc:param value="<%=work_no%>"/>
	</wtc:service>
	<wtc:array id="result1" scope="end"/>
var response = new AJAXPacket();
response.data.add("retCode","<%=errCode%>");
response.data.add("retMsg" ,"<%=errMsg%>");
core.ajax.receivePacket(response);
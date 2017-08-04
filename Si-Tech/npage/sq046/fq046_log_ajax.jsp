<%
  /*
   * 功能:客户订单缴费异常记录处理
　 * 版本:  v1.0
　 * 日期: 2009-01-15 10:00
　 * 作者: wanglj
　 * 版权: sitech
　*/
%> 
<%@ page contentType= "text/html;charset=gb2312" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ page import="com.sitech.boss.pub.util.CreatePlanerArray"%>
<%
	System.out.println("----------------------------------------------fq046_log_ajax.jsp---------------------------------------");
	String opCode = request.getParameter("opCode");
%>
<%@ page import="java.util.*"%>

<%   
	String loginNo = request.getParameter("loginNo");
	String custOrderId = request.getParameter("custOrderId");
	String opNote = request.getParameter("opNote");
%>

 	<wtc:service name="s3781Close" outnum="1">
		<wtc:param value="<%=loginNo%>"/> 
		<wtc:param value="<%=custOrderId%>"/> 								
		<wtc:param value="<%=opCode%>"/> 
		<wtc:param value="0"/> 
		<wtc:param value="<%=opNote%>"/> 									
	</wtc:service>	

<%
     System.out.println("retCode in s3195Cfm==========="+retCode);
	 System.out.println("retMsg in s3195Cfm==========="+retMsg);
%>
var response = new AJAXPacket();
response.data.add("errorCode","<%=retCode%>");
core.ajax.receivePacket(response);
 
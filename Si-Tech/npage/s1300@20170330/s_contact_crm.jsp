<%@ page contentType= "text/html;charset=GBK" %>
<%@ page import="java.util.*"%>
<%@ taglib uri="/WEB-INF/wtc.tld" prefix="wtc" %>
<%
	
	String workNo = (String)session.getAttribute("workNo");
	String password = (String)session.getAttribute("password"); 
	String s_login_accept = request.getParameter("s_login_accept");
	String regCode=(String)session.getAttribute("regCode");
	String s_op_code =  request.getParameter("opCode");
	String s_phone_no =  request.getParameter("s_phone_no");
	
	 
	 
 
   
%>
	<wtc:service name="sevalCfm"  routerKey="region" routerValue="<%=regCode%>" 
		retcode="scodes" retmsg="smsgs" outnum="2" >
		<wtc:param value="<%=s_login_accept%>"/>
		<wtc:param value="01"/>
		<wtc:param value="<%=s_op_code%>"/>
		<wtc:param value="<%=workNo%>"/>
		<wtc:param value="<%=password%>"/>
		<wtc:param value="<%=s_phone_no%>"/>
		<wtc:param value=""/>
	 
	</wtc:service>
<%
  System.out.println("%%ffffffffffffffffffffff NPS接口调用结果 is fffffffff "+scodes);
  
%>

<%
/********************
version v2.0
������: si-tech
update:anln@2009-02-25 ҳ�����,�޸���ʽ
********************/
%>
<%@ page contentType="text/html;charset=gb2312"%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ page import="com.sitech.csp.bsf.pwm.util.*"%>

<%
 
	
	MD5 _md5 = new MD5();
	
	String MD5in = request.getParameter("MD5in");
	if(MD5in==null) MD5in = "not input";
	
	
	String MD5out = _md5.encode(MD5in);  
	
 
out.println("����:["+MD5in+"]");
out.println("<br>");
out.println("MD5���ܽ��:["+MD5out+"]");



%>

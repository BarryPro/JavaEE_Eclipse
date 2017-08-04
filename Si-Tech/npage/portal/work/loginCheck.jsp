<%@ page contentType= "text/html;charset=GBK" %>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.util.HashMap"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="java.util.Date"%>
<%@ page import="com.sitech.boss.pub.util.*"%>
<%@ page import="org.apache.log4j.Logger"%>
<%@ page errorPage="../common/errorpage.jsp" %>
<%@ taglib uri="/WEB-INF/wtc.tld" prefix="wtc" %>
<% 
  
 String workNo = request.getParameter("username");
 String nopass=request.getParameter("password");
 String selfIp = request.getRemoteAddr();
 String login_ip = request.getHeader("x-forwarded-for");
        if(login_ip == null || login_ip.length() == 0 || "unknown".equalsIgnoreCase(login_ip)) {
            login_ip = request.getHeader("Proxy-Client-IP");
        }
        if(login_ip == null || login_ip.length() == 0 || "unknown".equalsIgnoreCase(login_ip)) {
            login_ip = request.getHeader("WL-Proxy-Client-IP");
        }
        if(login_ip == null || login_ip.length() == 0 || "unknown".equalsIgnoreCase(login_ip)) {
           login_ip = request.getRemoteAddr();
        }
        System.out.println(login_ip);
 try{       
%>
<wtc:service name="sLoginCheck" outnum="44">
	<wtc:param value="<%=workNo%>"/>
	<wtc:param value="<%=nopass%>"/>
	<wtc:param value="<%=selfIp%>"/>
</wtc:service>
<%
System.out.println(selfIp);
System.out.println(retCode);
System.out.println(retMsg);
if(retCode.equals("000000") || retCode.equals("900099")){
	 out.print(retCode);
	}  
}catch(Exception ex)
{
	ex.printStackTrace();
}			 
%>
<%
if( workNo!=null ){ 
	    String	sqlStr = "update dLoginMsg set try_times=0 where login_no ='"+workNo+"'";
try{ 
%>
<wtc:pubselect name="sPubSelect" outnum="1">
	<wtc:sql><%=sqlStr%></wtc:sql>
</wtc:pubselect>
<%
		}catch(Exception ex)
		{
%>
		  <script>
		  	alert('结束登录验证调用失');
		  </script>
<%
		}
}
%>
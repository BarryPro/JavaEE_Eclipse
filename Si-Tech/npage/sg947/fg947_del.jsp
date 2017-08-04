<%
/**********************************
	zhangyan@2013/8/14 10:48:10
***********************************/
%>

<%@ include file = "/npage/include/public_title_name_p.jsp" %>
<%@ page contentType = "text/html;charset=GBK" %>
<%
String accept = request.getParameter( "logacc" );
String chnSrc = request.getParameter( "chnSrc" );
String opCode = request.getParameter( "opCode" );
String workNo = (String)session.getAttribute("workNo");
String passwd = (String)session.getAttribute("password");

String phoNo = request.getParameter( "phoNo" );   
String usrPwd = request.getParameter( "usrPwd" );
String pho_no1 = request.getParameter( "del_pho1" );
String pho_no2 = request.getParameter( "del_pho2" );
String regCode = request.getParameter( "regCode");

String opName = request.getParameter( "opName" );
%>
<wtc:service name = "sPtpPhoneDel" outnum = "30"routerKey = "region" routerValue = "<%=regCode%>" 
	retcode = "rc_cfm" retmsg = "rm_cfm" >
	<wtc:param value = "<%=accept%>"/>
	<wtc:param value = "<%=chnSrc%>"/>
	<wtc:param value = "<%=opCode%>"/>
	<wtc:param value = "<%=workNo%>"/>
	<wtc:param value = "<%=passwd%>"/>
	<wtc:param value = "<%=phoNo%>"/>
	<wtc:param value = "<%=usrPwd%>"/>
	<wtc:param value = "<%=pho_no1%>"/>
	<wtc:param value = "<%=pho_no2%>"/>
</wtc:service>
<wtc:array id="rst" scope="end" />
<%

if( !"000000".equals(rc_cfm))
{
%>
	<script>
		rdShowMessageDialog( "<%=rc_cfm%>" + ":" + "<%=rm_cfm%>" , 0 );
		window.location = 'f<%=opCode%>_main.jsp?opCode=<%=opCode%>&opName=<%=opName%>';
	</script>    
<%
}
else
{%>
	<script>
		rdShowMessageDialog( "<%=rc_cfm%>"+":"+"<%=rm_cfm%>" , 2 );
		window.location = 'f<%=opCode%>_main.jsp?opCode=<%=opCode%>&opName=<%=opName%>';
	</script>
<%
}%>

<%
/**********************************
	zhangyan@2013/8/14 10:48:10
***********************************/
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" 
	"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page contentType = "text/html;charset=GBK" %>
<%
String accept = request.getParameter( "accept" );
String chnSrc = request.getParameter( "chnSrc" );
String opCode = request.getParameter( "opCode" );
String workNo = request.getParameter( "workNo" );
String passwd = request.getParameter( "passwd" );

String phoNo = request.getParameter( "phoneNo" );   
String usrPwd = request.getParameter( "usrPwd" );
String biz_code = request.getParameter( "biz_code" );
String biz_type = request.getParameter( "biz_type" );

String regCode = request.getParameter( "regCode");
String opName = request.getParameter( "opName" );
%>
<wtc:service name = "si095Cfm" outnum = "30"
	routerKey = "region" routerValue = "<%=regCode%>" 
	retcode = "rc_cfm" retmsg = "rm_cfm" >
	<wtc:param value = "<%=accept%>"/>
	<wtc:param value = "<%=chnSrc%>"/>
	<wtc:param value = "<%=opCode%>"/>
	<wtc:param value = "<%=workNo%>"/>
	<wtc:param value = "<%=passwd%>"/>
	<wtc:param value = "<%=phoNo%>"/>
	<wtc:param value = "<%=usrPwd%>"/>
	<wtc:param value = "<%=biz_code%>"/>
</wtc:service>
<wtc:array id="rst" scope="end" />
<%

if( !"000000".equals(rc_cfm))
{
%>
	<script>
		rdShowMessageDialog( "<%=rc_cfm%>" + ":" + "<%=rm_cfm%>" , 0 );
		window.location = 'f<%=opCode%>_main.jsp?opCode=<%=opCode%>&opName=<%=opName%>'
			+'&activePhone=<%=phoNo%>';
	</script>    
<%
}
else
{
%>
	<script>
		rdShowMessageDialog( "<%=rc_cfm%>" + ":" + "<%=rm_cfm%>" , 0 );
		window.location = 'f<%=opCode%>_main.jsp?opCode=<%=opCode%>&opName=<%=opName%>'
			+'&activePhone=<%=phoNo%>';
	</script>    
<%
}
%>

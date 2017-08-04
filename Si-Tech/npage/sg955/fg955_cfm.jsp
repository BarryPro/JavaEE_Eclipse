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
String workNo = request.getParameter( "workNo" );
String passwd = request.getParameter( "passwd" );

String phoNo = request.getParameter( "phoNo" );   
String usrPwd = request.getParameter( "usrPwd" );
String pho_no1 = request.getParameter( "pho_no1" );
String op_type = request.getParameter( "op_type" );
String regCode = request.getParameter( "regCode");
String retOkMsg = "";
if("0".equals(op_type)){
	retOkMsg = "添加黑名单操作成功";
}else if("1".equals(op_type)){
	retOkMsg = "解除黑名单操作成功";
}

String opName = request.getParameter( "opName" );
String opNote = opCode + opName + pho_no1;
%>
<wtc:service name = "sG955Cfm" outnum = "30"routerKey = "region" routerValue = "<%=regCode%>" 
	retcode = "rc_cfm" retmsg = "rm_cfm" >
	<wtc:param value = "<%=accept%>"/>
	<wtc:param value = "<%=chnSrc%>"/>
	<wtc:param value = "<%=opCode%>"/>
	<wtc:param value = "<%=workNo%>"/>
	<wtc:param value = "<%=passwd%>"/>
		
	<wtc:param value = "<%=pho_no1%>"/>
	<wtc:param value = "<%=usrPwd%>"/>
	<wtc:param value = "<%=opNote%>"/>
	<wtc:param value = "<%=op_type%>"/>
</wtc:service>
<wtc:array id="rst" scope="end" />
<%

if( !"000000".equals(rc_cfm))
{
%>
	<script>
		rdShowMessageDialog( "<%=rm_cfm%>" , 0 );
		window.location = 'f<%=opCode%>_main.jsp?opCode=<%=opCode%>&opName=<%=opName%>';
	</script>    
<%
}
else
{%>
	<script>
		rdShowMessageDialog( "<%=retOkMsg%>" , 2 );
		window.location = 'f<%=opCode%>_main.jsp?opCode=<%=opCode%>&opName=<%=opName%>';
	</script>
<%
}%>
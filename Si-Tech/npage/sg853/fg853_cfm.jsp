<%
/*******************
 * °æ±¾: 1.0
 * ×÷Õß: zhangyan
*******************/
%>
<%@ include file = "/npage/include/public_title_name_p.jsp" %>
<%@ page contentType = "text/html;charset=GBK" %>
<%
String regCode = ( String )session.getAttribute ( "regCode" );

String accept = request.getParameter( "logacc" );
String chnSrc = request.getParameter( "chnSrc" );
String opCode = request.getParameter( "opCode" );
String workNo = ( String ) session.getAttribute( "workNo" );
String passwd = ( String ) session.getAttribute( "password" );

String phoNo = request.getParameter( "phoNo" );   
String usrPwd = "";
String biz_type = "ZY";
String sp_id = "045105";
String biz_cfode = "ZY0501";

String iOprCode = "03";
String eff_date = request.getParameter( "opTime" );
String exp_date = "20501231000000";
String op_time = eff_date;	
String opNote = opCode + request.getParameter("opName");

String Account = request.getParameter( "Account" );
String BindReminder = request.getParameter( "BindReminder" );
String UseReminder = request.getParameter( "UseReminder" );

String remark = "2";
String BusiType = "1021";

%>
	<wtc:service name="sProWorkFlowCfm" outnum="30"
		routerKey="region" routerValue="<%=regCode%>" retcode="rc" retmsg="rm" >
		<wtc:param value = "<%=accept%>"/>
		<wtc:param value = "<%=chnSrc%>"/>
		<wtc:param value = "<%=opCode%>"/>
		<wtc:param value = "<%=workNo%>"/>
		<wtc:param value = "<%=passwd%>"/>
			
		<wtc:param value = "<%=phoNo%>"/>
		<wtc:param value = "<%=usrPwd%>"/>
		<wtc:param value = "<%=biz_type%>"/>
		<wtc:param value = "<%=sp_id%>"/>
		<wtc:param value = "<%=biz_cfode%>"/>
			
		<wtc:param value = "<%=iOprCode%>"/>
		<wtc:param value = "<%=eff_date%>"/>
		<wtc:param value = "<%=exp_date%>"/>
		<wtc:param value = "<%=op_time%>"/>
		<wtc:param value = "<%=opNote%>"/>
			
		<wtc:param value = "<%=Account%>"/>
		<wtc:param value = "<%=remark%>"/>
		<wtc:param value = "<%=BindReminder%>"/>
		<wtc:param value = "<%=UseReminder%>"/>
		<wtc:param value = "<%=BusiType%>"/>
	</wtc:service>
	<wtc:array id="rst" scope="end" />
<%

if( !"000000".equals(rc))
{
%>
	<script>
		rdShowMessageDialog(" <%=rc%>" + ":" + "<%=rm%>" , 0 );
		removeCurrentTab();
	</script>	
<%
}
else
{%>
	<script>
		rdShowMessageDialog( "<%=rc%>" + ":" + "<%=rm%>" , 2);
		removeCurrentTab();
	</script>
<%
}%>


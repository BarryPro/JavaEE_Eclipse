<%
/**********************************
	zhangyan@2013/8/14 10:48:10
***********************************/
%>

<%@ include file = "/npage/include/public_title_name_p.jsp" %>
<%@ page contentType = "text/html;charset=GBK" %>
<%@ page import ="java.text.SimpleDateFormat" %>
<%@ page import ="java.util.Date" %>
<%@ page import ="java.text.DateFormat"%>
<%
Calendar cal = Calendar.getInstance();
cal.add(java.util.Calendar.HOUR_OF_DAY,1);
SimpleDateFormat sf = new SimpleDateFormat("yyyyMMddHHmmss");


String accept = request.getParameter( "logacc" );
String chnSrc = request.getParameter( "chnSrc" );
String opCode = request.getParameter( "opCode" );
String workNo = ( String ) session.getAttribute( "workNo" );
String passwd = ( String ) session.getAttribute( "password" );

String phoNo = request.getParameter( "phone_no" );   
String usrPwd = "";
String biz_type = "ZY";
String sp_id = "045105";
String biz_cfode = "ZY0502";

String opName = request.getParameter( "opName" );
String iOprCode = "11";
String eff_date = sf.format(cal.getTime());
String exp_date = "20501231000000";
String op_time = sf.format(cal.getTime());

String op_note = opCode + opName;
String regCode = ( String ) session.getAttribute ( "regCode" );
String new_pwd = request.getParameter( "new_pwd" );
String act_no = phoNo+".cmcc-hlj";

%>
<wtc:service name = "sProWorkFlowCfm" outnum = "30"routerKey = "region" routerValue = "<%=regCode%>" 
	retcode = "rc_cfm" retmsg = "rm_cfm" >
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
	<wtc:param value = "<%=op_note%>"/>
		
	<wtc:param value = "<%=act_no%>"/>
</wtc:service>
<wtc:array id="rst" scope="end" />
<%
if( !"000000".equals(rc_cfm))
{
%>
	<script>
		rdShowMessageDialog( "<%=rc_cfm%>" + ":" + "<%=rm_cfm%>" , 0 );
		removeCurrentTab();
	</script>    
<%
}
else
{%>
	<script>
		rdShowMessageDialog( "<%=rc_cfm%>"+":"+"<%=rm_cfm%>" , 2 );
		removeCurrentTab();
	</script>
<%
}%>

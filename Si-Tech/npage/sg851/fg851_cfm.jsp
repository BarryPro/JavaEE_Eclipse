
<%
/*******************
 * °æ±¾: 1.0
 * ×÷Õß: zhangyan
*******************/
%>
<%@ include file="/npage/include/public_title_name_p.jsp" %>
<%@ page contentType= "text/html;charset=GBK" %>
<%
String accept = request.getParameter( "logacc" );
String chnSrc = request.getParameter( "chnSrc" );
String opCode = request.getParameter( "opCode" );
String workNo = ( String ) session.getAttribute( "workNo" );
String passwd = ( String ) session.getAttribute( "password" );

String phoNo = request.getParameter( "phoNo" );   
String usrPwd = "";
String s_regCode= request.getParameter("regCode");
String SerialNo = request.getParameter("SerialNo");
String biz_type = "ZY";

String sp_id = "045105";
String biz_cfode = "ZY0501";
String iOprCode = "01";
String opName = request.getParameter( "opName" );
String eff_date = request.getParameter( "opTime" );

String exp_date = "20501231000000";
String op_time = eff_date;
String Account = request.getParameter("Account");
String remark = "2";
String BusiType = "1021";

String op_note = opCode + opName;
%>
<wtc:service name="sProWorkFlowCfm" outnum="30"
	routerKey="region" routerValue="<%=s_regCode%>" retcode="rc_cfm" retmsg="rm_cfm" >
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
		
	<wtc:param value = "<%=Account%>"/>
	<wtc:param value = "<%=remark%>"/>
	<wtc:param value = "<%=BusiType%>"/>
</wtc:service>
<wtc:array id="rstCfm" scope="end" />
<%

if( !"000000".equals(rc_cfm))
{
%>
	<script>
		rdShowMessageDialog("<%=rc_cfm%>"+":"+"<%=rm_cfm%>" , 0);
		removeCurrentTab();
	</script>	
<%
}
else
{%>
	<script>
		rdShowMessageDialog("<%=rc_cfm%>"+":"+"<%=rm_cfm%>" , 2);
		removeCurrentTab();
	</script>
<%
}%>


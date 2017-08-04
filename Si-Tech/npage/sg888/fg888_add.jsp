<%
/********************
 * °æ±¾: 1.0
 * ×÷Õß: zhangyan
********************/
%>

%>
<%@ include file="/npage/include/public_title_name_p.jsp" %>
<%@ page contentType= "text/html;charset=GBK" %>
<%
String s_accept        =request.getParameter("hd_loginacc");
String s_chnSrc        ="01";
String s_opCode        =request.getParameter("hd_opCode");
String s_workNo = (String)session.getAttribute("workNo");
String s_passwd = (String)session.getAttribute("password");
String s_phone = "";
String s_usrPwd = "";
String pho_no = request.getParameter("pho_no");
String reg_code = request.getParameter("reg_code");
String s_regCode= ( String )session.getAttribute("regCode");
String s_opName = request.getParameter("hd_opName");

%>
<wtc:service name="sG888Add" outnum="30"
	routerKey="region" routerValue="<%=s_regCode%>" retcode="rc_cfm" retmsg="rm_cfm" >
	<wtc:param value="<%=s_accept%>"/>
	<wtc:param value="<%=s_chnSrc%>"/>
	<wtc:param value="<%=s_opCode%>"/>
	<wtc:param value="<%=s_workNo%>"/>
	<wtc:param value="<%=s_passwd%>"/>
	<wtc:param value="<%=s_phone%>"/>
	<wtc:param value="<%=s_usrPwd%>"/>
	<wtc:param value="tst"/>
	<wtc:param value="<%=reg_code%>"/>
	<wtc:param value="<%=pho_no%>"/>
</wtc:service>
<wtc:array id="rst" scope="end" />
<%

if( !"000000".equals(rc_cfm))
{
%>
	<script>
		rdShowMessageDialog("<%=rc_cfm%>"+":"+"<%=rm_cfm%>" , 0);
		window.location = 'fg888_main.jsp?opCode=<%=s_opCode%>&opName=<%=s_opName%>';
	</script>    
<%
}
else
{%>
	<script>
		rdShowMessageDialog("<%=rc_cfm%>"+":"+"<%=rm_cfm%>" , 2);
		window.location = 'fg888_main.jsp?opCode=<%=s_opCode%>&opName=<%=s_opName%>';
	</script>
<%
}%>


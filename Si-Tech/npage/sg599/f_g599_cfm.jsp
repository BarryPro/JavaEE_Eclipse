<%
/*
 * 功能: 省内携号
 * 版本: 1.0
 * 日期: 2012/3/9 14:19:13
 * 作者: zhangyan
 * 版权: si-tech
 * update:
*/

%>
<%@ include file="/npage/include/public_title_name_p.jsp" %>
<%@ page contentType= "text/html;charset=GBK" %>
<%
String s_accept		=request.getParameter("hd_accept");
String s_chnSrc		="01";
String s_opCode		=request.getParameter("hd_opCode");
String s_workNo = (String)session.getAttribute("workNo");
String s_passwd = (String)session.getAttribute("password");
String s_phone = "";
String s_usrPwd = "";
String s_json = request.getParameter("jsonText");
String s_regCode= request.getParameter("regCode");

String s_opName = request.getParameter("hd_opName");

String[] jsons = new String[30];
int start = 0;

for (int i = 0; i < (s_json.length() / 400) + 1; i ++) {
	if (i == (s_json.length() / 400)) {
		jsons[i] = s_json.substring(start, s_json.length());
	} else {
		jsons[i] = s_json.substring(start, start + 400);
		start += 400;
	}
}
System.out.println("zhangyan~~~~~~~~~~~~~s_json~~~~~~~~~~~~```"+s_json);
%>
<wtc:service name="sg599Cfm" outnum="30"
	routerKey="region" routerValue="<%=s_regCode%>" retcode="rc_cfm" retmsg="rm_cfm" >
	<wtc:param value="<%=s_accept%>"/>
	<wtc:param value="<%=s_chnSrc%>"/>
	<wtc:param value="<%=s_opCode%>"/>
	<wtc:param value="<%=s_workNo%>"/>
	<wtc:param value="<%=s_passwd%>"/>
	<wtc:param value="<%=s_phone%>"/>
	<wtc:param value="<%=s_usrPwd%>"/>
	<wtc:params value="<%=jsons%>"/>
</wtc:service>
<wtc:array id="rst_doGetProdAA" scope="end" />
<%

System.out.println("zhangyan~~~~~~~~~~~~~rc_cfm~~~~~~~~~~~~```"+rc_cfm);
System.out.println("zhangyan~~~~~~~~~~~~~rm_cfm~~~~~~~~~~~~```"+rm_cfm);

if( "000000".equals(rc_cfm))
{
%>
	<script>
		rdShowMessageDialog("<%=s_opCode%>提交成功!",2);
		window.location = 'f_g599_main.jsp?opCode=<%=s_opCode%>&opName=<%=s_opName%>';
	</script>
<%
}
else
{%>
	<script>
		rdShowMessageDialog("<%=rc_cfm%>"+":"+"<%=rm_cfm%>" , 0);
		window.location = 'f_g599_main.jsp?opCode=<%=s_opCode%>&opName=<%=s_opName%>';
	</script>
<%
}%>
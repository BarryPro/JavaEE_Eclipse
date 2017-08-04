<%
/*
 * 版本: 1.0
 * 日期: 2012/3/9 14:19:13
 * 作者: zhangyan
 * 版权: si-tech
 * update:
*/

%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="../../npage/common/serverip.jsp" %>

<%
String s_accept		=request.getParameter("hd_loginacc");
String s_chnSrc		="01";
String s_opCode		=request.getParameter("hd_opCode");
String s_workNo = (String)session.getAttribute("workNo");
String s_passwd = (String)session.getAttribute("password");
String s_phone = "";
String s_usrPwd = "";
String s_json = request.getParameter("jsonText");
String s_regCode=  WtcUtil.repNull((String)session.getAttribute("regCode"));

String s_opName = request.getParameter("hd_opName");

String inputFile = request.getParameter("inputFile");
String iServerIpAddr = realip.trim();  
String filenames = request.getParameter("filenames");


String[] jsons = new String[100];
int start = 0;
System.out.println("zhangyan~~~~~s_json"+s_json);
System.out.println("zhangyan~~~~~s_accept"+s_accept);

for (int i = 0; i < (s_json.length() / 400) + 1; i ++) {
	if (i == (s_json.length() / 400)) {
		jsons[i] = s_json.substring(start, s_json.length());
	} else {
		jsons[i] = s_json.substring(start, start + 400);
		start += 400;
	}
	if(i>=10){
	%>
	<script>
		rdShowMessageDialog("集团物联网成员增加"+":"+"订购产品过多，请分多笔操作。" , 0);
		window.location = 'f_g663_main.jsp?opCode=<%=s_opCode%>&opName=集团物联网成员增加';
	</script>
	<% 
	}
}
System.out.println("gaopengSeeLogG663=======~~~~~~~~~~~~~s_json~~~~~~~~~~~~```"+s_json);
%>
<html xmlns="http://www.w3.org/1999/xhtml"> 
<head>
<script language="javascript">
	function goback(){
		window.location = 'f_g663_main.jsp?opCode=<%=s_opCode%>&opName=集团物联网成员增加';
	}
</script>
</head>
<body>
<form method="POST" action = "" name="frm">

<DIV id="Operation_Table">
<wtc:service name="sg663Cfm" outnum="30"
	routerKey="region" routerValue="<%=s_regCode%>" retcode="rc_cfm" retmsg="rm_cfm" >
	<wtc:param value="<%=s_accept%>"/>
	<wtc:param value="<%=s_chnSrc%>"/>
	<wtc:param value="<%=s_opCode%>"/>
	<wtc:param value="<%=s_workNo%>"/>
	<wtc:param value="<%=s_passwd%>"/>
	<wtc:param value="<%=s_phone%>"/>
	<wtc:param value="<%=s_usrPwd%>"/>
	<wtc:params value="<%=jsons%>"/>
	<wtc:param value="<%=inputFile%>"/>
	<wtc:param value="<%=iServerIpAddr%>"/>
	<wtc:param value="<%=filenames%>"/>
</wtc:service>
<wtc:array id="rst_doGetProdAA" scope="end" />
<%

if( "000000".equals(rc_cfm))
{
	System.out.println("~~~~~~~~~~rst_doGetProdAA[0][0]~~~~~~~~~"+rst_doGetProdAA[0][0]);

%>
	<div>
	<div class="title">
		<div id="title_zi">操作结果</div>
	</div>
	 <table>

			<tr>
				<td WIDTH = '20%' ALIGN = 'center' class = 'blue'>操作流水</td>
				<td><%=rst_doGetProdAA[0][0]%>&nbsp;&nbsp<font class="orange">此流水用于在m238集团物联网业务状态  查询使用</font></td>
			</tr>

		</table>
		
	<table>
		<tr>
			<td id="footer">
				<input type="button" name="back" class="b_foot" value="返回" onClick="goback()"  >
				<input class="b_foot" type="button" name=btnCls value="关闭"
						onClick="removeCurrentTab();">		
			</td>
		</tr>
	</table>
<%
}
else
{%>
	<script>
		rdShowMessageDialog("<%=rc_cfm%>"+":"+"<%=rm_cfm%>" , 0);
		window.location = 'f_g663_main.jsp?opCode=<%=s_opCode%>&opName=集团物联网成员增加';
	</script>
<%
}%>
</div>
</form>
</body>
<html>
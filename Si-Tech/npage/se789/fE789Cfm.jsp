<%
/********************
 version v2.0
开发商: si-tech
update:zhangyan@2012/4/25 20:34:34
********************/
%>
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%
String regCode	=(String)session.getAttribute("regCode");

String iLoginAccept=request.getParameter("printAccept");
String iChnSource="01" ; /*渠道类型*/
String iOpCode =request.getParameter("opCode"); /*操作代码*/
String iLoginNo=(String)session.getAttribute("workNo") ;/*操作工号*/ 
String iLoginPwd=(String)session.getAttribute("password"); /*工号密码*/
String iPhoneNo =request.getParameter("phoneNo");/*手机号码*/
String iUserPwd ="";/*手机密码*/
String iIpAddr=(String)session.getAttribute("ipAddr");
String iImeiNo=request.getParameter("oldImeiNo");
String iOfr=request.getParameter("ofrId");
String ijson=request.getParameter("jsonSI");
ijson=ijson.replaceAll(",","，");
ijson=ijson.replaceAll("\"","'");

%>
<wtc:service name="se789Cfm" 
	routerKey="region" routerValue="<%=regCode%>" 
	retmsg="rmE789Cfm" retcode="rcE789Cfm" outnum="1">
	<wtc:param value="<%=iLoginAccept%>"/>
	<wtc:param value="<%=iChnSource%>"/>
	<wtc:param value="<%=iOpCode%>"/>
	<wtc:param value="<%=iLoginNo%>"/>
	<wtc:param value="<%=iLoginPwd%>"/>
	<wtc:param value="<%=iPhoneNo%>"/>
	<wtc:param value="<%=iUserPwd%>"/>
	<wtc:param value="<%=iIpAddr%>"/>
	<wtc:param value="<%=iImeiNo%>"/>
	<wtc:param value="<%=ijson%>"/>		
	<wtc:param value="<%=iOfr%>"/>
</wtc:service>
<wtc:array id="rstE789Cfm" scope="end" />	

<script>
	rdShowMessageDialog("<%=rcE789Cfm%>:<%=rmE789Cfm%>");
	removeCurrentTab();
</script>


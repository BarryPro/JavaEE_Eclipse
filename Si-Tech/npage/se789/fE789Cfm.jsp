<%
/********************
 version v2.0
������: si-tech
update:zhangyan@2012/4/25 20:34:34
********************/
%>
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%
String regCode	=(String)session.getAttribute("regCode");

String iLoginAccept=request.getParameter("printAccept");
String iChnSource="01" ; /*��������*/
String iOpCode =request.getParameter("opCode"); /*��������*/
String iLoginNo=(String)session.getAttribute("workNo") ;/*��������*/ 
String iLoginPwd=(String)session.getAttribute("password"); /*��������*/
String iPhoneNo =request.getParameter("phoneNo");/*�ֻ�����*/
String iUserPwd ="";/*�ֻ�����*/
String iIpAddr=(String)session.getAttribute("ipAddr");
String iImeiNo=request.getParameter("oldImeiNo");
String iOfr=request.getParameter("ofrId");
String ijson=request.getParameter("jsonSI");
ijson=ijson.replaceAll(",","��");
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


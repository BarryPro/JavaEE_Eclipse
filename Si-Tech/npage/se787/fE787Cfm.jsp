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
String iPhoneNo =request.getParameter("orderPhoneNo");/*�ֻ�����*/
String iUserPwd ="";/*�ֻ�����*/
String iCCID=request.getParameter("orderIdIccId");
String iIpAddr=(String)session.getAttribute("ipAddr");
String iImeiNo=request.getParameter("orderImei");
String iofferId=request.getParameter("orderOfferId");
String iPayAddr=request.getParameter("orderAddr");
String ibindICCID=request.getParameter("hdGId");
String ibindSHEBAOCARD=request.getParameter("hdNId");
String ibindName=request.getParameter("hdGName");
String ijson=request.getParameter("jsonSI");
ijson=ijson.replaceAll(",","��");
ijson=ijson.replaceAll("\"","'");

System.out.println("zhangyan`~~opCode~~~"+iOpCode);
System.out.println("zhangyan~~~~ibindICCID~~~~"+ibindICCID);
System.out.println("zhangyan~~~~ibindSHEBAOCARD~~~~"+ibindSHEBAOCARD);
System.out.println("zhangyan~~~~ibindName~~~~"+ibindName);
System.out.println("zhangyan~~~~ijson~~~~"+ijson);

%>
<wtc:service name="se787Cfm" 
	routerKey="region" routerValue="<%=regCode%>" 
	retmsg="rmE787Cfm" retcode="rcE787Cfm" outnum="1">
	<wtc:param value="<%=iLoginAccept%>"/>
	<wtc:param value="<%=iChnSource%>"/>
	<wtc:param value="<%=iOpCode%>"/>
	<wtc:param value="<%=iLoginNo%>"/>
	<wtc:param value="<%=iLoginPwd%>"/>
	<wtc:param value="<%=iPhoneNo%>"/>
	<wtc:param value="<%=iUserPwd%>"/>
	<wtc:param value="<%=iIpAddr%>"/>
	<wtc:param value="<%=iCCID%>"/>
	<wtc:param value="<%=iImeiNo%>"/>
	<wtc:param value="<%=iofferId%>"/>
	<wtc:param value="<%=iPayAddr%>"/>
	<wtc:param value="<%=ibindICCID%>"/>
	<wtc:param value="<%=ibindSHEBAOCARD%>"/>
	<wtc:param value="<%=ibindName%>"/>
	<wtc:param value="<%=ijson%>"/>
</wtc:service>
<wtc:array id="rstE787Cfm" scope="end" />	

<script>
	rdShowMessageDialog("<%=rcE787Cfm%>:<%=rmE787Cfm%>");
	removeCurrentTab();
</script>


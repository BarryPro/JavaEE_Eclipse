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
String iImeiNo=request.getParameter("newImeiNo");
String ibindICCID=request.getParameter("strIdIcd");
String ibindSHEBAOCARD=request.getParameter("strNId");
String ibindName=request.getParameter("strName");
String iType=request.getParameter("hdOpTp");
String ijson=request.getParameter("jsonSI");
String iOldImei=request.getParameter("oldImeiNo");

if (iType.equals("1"))
{
/* {deviceid:imei号码,bind:[{nid:111,gid:222},{nid:333,gid:444}……]}*/
ijson="{'deviceid':'"+iOldImei+"'，"+ijson.substring(1,ijson.length()-1)+"}";
}
ijson=ijson.replaceAll(",","，");
ijson=ijson.replaceAll("\"","'");

/*
ijson="{'deviceid':'188451118001881'，"
	+"{'bind':[{'gid':'230206196012190761'，'nid':'0200486429'}，"
	+"{'gid':'230206196012031621'，'nid':'0200486236'}]}";*/
System.out.println("zhangyan`~~opCode~~~"+iOpCode);
System.out.println("zhangyan~~~~ibindICCID~~~~"+ibindICCID);
System.out.println("zhangyan~~~~ibindSHEBAOCARD~~~~"+ibindSHEBAOCARD);
System.out.println("zhangyan~~~~ibindName~~~~"+ibindName);
System.out.println("zhangyan~~~~ijson~~~~"+ijson);

%>
<wtc:service name="se788Cfm" 
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
	<wtc:param value="<%=iImeiNo%>"/>
	<wtc:param value="<%=ibindICCID%>"/>
	<wtc:param value="<%=ibindSHEBAOCARD%>"/>
	<wtc:param value="<%=ibindName%>"/>
	<wtc:param value="<%=iType%>"/>
	<wtc:param value="<%=ijson%>"/>
</wtc:service>
<wtc:array id="rstE788Cfm" scope="end" />	

<script>
	rdShowMessageDialog("<%=rcE787Cfm%>:<%=rmE787Cfm%>");
	removeCurrentTab();
</script>


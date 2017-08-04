<%
/********************
 * version v2.0
 * 开发商: si-tech
 * update by wanglma @ 20110419
 ********************/
%>
<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ page import="java.util.*" %>
<%@ page import="java.text.*" %>
<%
String serviceName = request.getParameter("serviceName");

String regionCode= (String)session.getAttribute("regCode");
String workNo = (String)session.getAttribute("workNo");
String password = (String)session.getAttribute("password");
String strInfo = request.getParameter("strInfo");
System.out.println("----liujian----strInfo=" + strInfo);
System.out.println("----liujian----serviceName=" + serviceName);
String retMessage = "ok";
String loginAccept = "";
String[] params = strInfo.split("\\~\\^\\~");
System.out.println("----liujian----params=" + params.length);
%>
<wtc:sequence name="TlsPubSelCrm" key="sMaxSysAccept" routerKey="region" 
		 routerValue="<%=regionCode%>"  id="seq"/>
<%
	loginAccept = seq;
	System.out.println("----liujian----loginAccept=" + loginAccept);
%>
<wtc:service name="<%=serviceName%>" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode1" retmsg="retMsg1" outnum="1">
	<wtc:param value="<%=loginAccept%>"/>
	<wtc:param value="01"/>
	<wtc:param value="e743"/>
	<wtc:param value="<%=workNo%>"/>
	<wtc:param value="<%=password%>"/>
	<wtc:param value=""/>
	<wtc:param value=""/>
		
<%
	for(int i=0;i<params.length;i++) {
		System.out.println("--------liujian---------params[" + i + "]=" + params[i]);
%>	
		<wtc:param value="<%=params[i].trim()%>"/>
<%	
	}
%>		
	
</wtc:service>
<wtc:array id="result" start="0" length="1" scope="end"/>
<%
if ("000000".equals(retCode1) && result.length > 0) {
	//json串太长，切割成多个
	//目前其他的服务都是[0][0]，如果有新需求则需改造
	StringBuffer sb = new StringBuffer("");
	for(int i=0;i<result.length;i++) {
		sb.append(result[i][0]);
	}
	retMessage = sb.toString();
}
%>
<%=retMessage%>
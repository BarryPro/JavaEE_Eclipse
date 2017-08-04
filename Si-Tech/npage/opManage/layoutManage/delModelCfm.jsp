<%@ page contentType="text/html;charset=GB2312"%>
<%@ taglib uri="/WEB-INF/wtc.tld" prefix="wtc" %>

<%
		  	
	String modeid = request.getParameter("modeid")==null?"":request.getParameter("modeid");
	
	String regionCode = (String)session.getAttribute("regCode");
	String ipAddr = (String)session.getAttribute("ipAddr");
	String workNo = (String)session.getAttribute("workNo");
	String powerCode = (String)session.getAttribute("powerCode");
	String opNote = "工号："+workNo+"删除布局模板";
	
	System.out.println("------------modeid-------------"+modeid);
%>	 
    <wtc:service name="sDelModelCfm" outnum="1" retmsg="msg" retcode="code" routerKey="region" routerValue="<%=regionCode%>">
		<wtc:param value="<%=modeid%>" />
		<wtc:param value="<%=workNo%>" />
		<wtc:param value="e484" />
		<wtc:param value="<%=ipAddr%>" />	
		<wtc:param value="<%=powerCode%>" />		
		<wtc:param value="<%=opNote%>" />		
	</wtc:service>
		
var response = new AJAXPacket();
response.data.add("retCode","<%=code%>");
response.data.add("retMsg","<%=msg%>");
core.ajax.receivePacket(response);	
	 
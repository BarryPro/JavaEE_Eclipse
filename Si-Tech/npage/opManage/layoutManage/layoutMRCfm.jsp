<%@ page contentType="text/html;charset=GB2312"%>
<%@ taglib uri="/WEB-INF/wtc.tld" prefix="wtc" %>

<%
		  	
	String oprole = request.getParameter("oprole")==null?"":request.getParameter("oprole");
	String modeid = request.getParameter("modeid")==null?"":request.getParameter("modeid");
	String optype = request.getParameter("optype")==null?"":request.getParameter("optype");
	
	String regionCode = (String)session.getAttribute("regCode");
	
	System.out.println("-------------oprole------------"+oprole);
	System.out.println("-------------modeid------------"+modeid);
	
	String ipAddr = (String)session.getAttribute("ipAddr");
	String workNo = (String)session.getAttribute("workNo");
	String powerCode = (String)session.getAttribute("powerCode");
	String opNote = "工号："+workNo+"设置角色对应关系";
	
%>	 
    <wtc:service name="sLayoutModeRole" outnum="1" retmsg="msg" retcode="code" routerKey="region" routerValue="<%=regionCode%>">
		<wtc:param value="<%=oprole%>" />
		<wtc:param value="<%=modeid%>" />
		<wtc:param value="<%=optype%>" />	
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
	 
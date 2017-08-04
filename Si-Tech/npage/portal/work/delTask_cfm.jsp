<%@ page contentType= "text/html;charset=gb2312" %>
<%@ taglib uri="/WEB-INF/wtc.tld" prefix="wtc" %>
<%
String regionCode = (String)session.getAttribute("regCode");
String id         = (String)request.getParameter("promptSeq");

System.out.println("--hejwa--op----delTask.jsp-------id------------"+id);
%>

<wtc:service name="sKeyOpr" outnum="2" routerKey="region" routerValue="<%=regionCode%>">
	<wtc:param value="<%=id%>" />
	<wtc:param value="d" />
	<wtc:param value="" />
  	<wtc:param value="" />
  	<wtc:param value="" />
  	<wtc:param value="" />
  	<wtc:param value="" />
</wtc:service>
<wtc:array id="result" scope="end" />	

var response = new AJAXPacket();
response.data.add("retCode","<%=retCode%>");
core.ajax.receivePacket(response);
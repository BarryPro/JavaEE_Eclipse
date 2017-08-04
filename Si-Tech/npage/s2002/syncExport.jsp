<%@ page contentType= "text/html;charset=gbk" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%
	String opCode     =  request.getParameter("opCode");
	String opName     =  request.getParameter("opName");
	String workNo     = (String)session.getAttribute("workNo");
	String password = (String) session.getAttribute("password");
	String regionCode = (String)session.getAttribute("regCode");
	String productId = request.getParameter("productId");
%>	

<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="region" routerValue="<%=regionCode%>" id="printAccept"/>
	
<wtc:service name="s2035MemberQry" routerKey="region" routerValue="<%=regionCode%>" 
	retcode="retCode" retmsg="retMsg" outnum="2">
	<wtc:param value="<%=printAccept%>"/>
	<wtc:param value="01"/>
	<wtc:param value="<%=opCode%>"/>
	<wtc:param value="<%=workNo%>"/>
	<wtc:param value="<%=password%>"/>
	<wtc:param value=""/>
	<wtc:param value=""/>
	<wtc:param value="<%=productId%>"/> 
	<wtc:param value="1"/><%/* 操作类型：0-实时数据查询；1-异步数据导出 */%>
</wtc:service>
<wtc:array id="rows"  scope="end"/>

		var response = new AJAXPacket();
		response.data.add("retCode", "<%=retCode%>");
		response.data.add("retMsg", "<%=retMsg%>");
		core.ajax.receivePacket(response);
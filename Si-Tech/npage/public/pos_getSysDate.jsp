<%
/********************
 version v2.0
������: si-tech
********************/
%>
<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>

<%
		String regionCode = (String)session.getAttribute("regCode");
		String verifyType = request.getParameter("verifyType");
		String sqlStr1 = "select to_char(sysdate,'yyyymmddhh24miss') from dual";
%>			
		<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode1" retmsg="retMsg1" outnum="1">
			<wtc:sql><%=sqlStr1%></wtc:sql>
		</wtc:pubselect>
		<wtc:array id="result1" scope="end" />			
<%
		String sysDate = "";
		sysDate = result1[0][0];
%>	
		
		var response = new AJAXPacket();
		var verifyType = "<%=verifyType%>";
		var sysDate = "<%=sysDate%>";
		response.data.add("verifyType",verifyType);
		response.data.add("sysDate",sysDate);
		core.ajax.receivePacket(response);
		
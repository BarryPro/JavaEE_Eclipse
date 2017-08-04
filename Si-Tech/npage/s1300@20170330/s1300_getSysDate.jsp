<%
/********************
 version v2.0
¿ª·¢ÉÌ: si-tech
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
		String return_code = retCode1;
		String return_msg = retMsg1;
%>	
		
		var response = new AJAXPacket();
		var verifyType = "<%=verifyType%>";
		var sysDate = "<%=sysDate%>";
		var return_code = "<%=return_code%>";
		var return_msg = "<%=return_msg%>";
		response.data.add("return_code",return_code);
		response.data.add("return_msg",return_msg);
		response.data.add("verifyType",verifyType);
		response.data.add("sysDate",sysDate);
		core.ajax.receivePacket(response);
		
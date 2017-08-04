<%@ page contentType= "text/html;charset=gb2312" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ page import="import java.text.SimpleDateFormat;"%>

<%
		String shuxingzhi = WtcUtil.repNull(request.getParameter("shuxingzhi"));
		String fuwuleixing = WtcUtil.repNull(request.getParameter("fuwuleixing"));
		String shuxingdaima = WtcUtil.repNull(request.getParameter("shuxingdaima"));
		String jituanbianhao = WtcUtil.repNull(request.getParameter("jituanbianhao"));
		String phoneNo = WtcUtil.repNull(request.getParameter("phoneNo"));
		String workNo = (String)session.getAttribute("workNo");
		/* liujian add workNo and password 2012-4-5 15:59:15 begin */
		String password = (String) session.getAttribute("password");
		/* liujian add workNo and password 2012-4-5 15:59:15 end */
		String opCode = request.getParameter("opCode");
    String regionCode = (String)session.getAttribute("regCode");
		String current_timeNAME= new SimpleDateFormat("yyyyMMddhhmmssSSS", Locale.getDefault()).format(new java.util.Date());
		
%>				
<wtc:sequence name="sPubSelect" key="sMaxSysAccept" id="loginAccept" />
			<wtc:service name="sCharacterCheck" routerKey="region" routerValue="<%=regionCode%>" outnum="11" retmsg="msg2" retcode="code2">
    		  <wtc:param value="<%=loginAccept%>"/>
    		  <wtc:param value="01"/>
    		  <wtc:param value="<%=opCode%>"/>
    		  <wtc:param value="<%=workNo%>"/>
    		  <wtc:param value="<%=password%>"/>
    		  <wtc:param value="<%=phoneNo%>"/>
					<wtc:param value=""/>
					<wtc:param value="<%=shuxingdaima%>"/>
					<wtc:param value="<%=shuxingzhi%>"/>
					<wtc:param value="<%=fuwuleixing%>"/>
						<wtc:param value="<%=jituanbianhao%>"/>
    	</wtc:service>
    	<wtc:array id="result_t" scope="end"/>



var response = new AJAXPacket();
response.data.add("errorCode","<%=code2%>");
response.data.add("errorMsg","<%=msg2%>");
core.ajax.receivePacket(response);

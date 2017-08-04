<%request.setCharacterEncoding("GB2312");%>
<%@ page contentType="text/html;charset=gb2312" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ page import="com.sitech.boss.pub.util.Encrypt" %>
<%
    
    String oldpassword = (String)request.getParameter("oldpassword");
    String id_no = (String)request.getParameter("id_no");
    String opCode = (String)request.getParameter("opCode");
    String regCode = (String) session.getAttribute("regCode");
    String workNo = (String) session.getAttribute("workNo");
    String ip_Addr = (String) session.getAttribute("ipAddr");
    String password = (String) session.getAttribute("password");
%>
	<wtc:service name="sCheckImsPass" routerKey="region" routerValue="<%=regCode%>" outnum="2" retcode="retCode" retmsg="retMsg">
    <wtc:param value="<%=opCode%>"/>
    <wtc:param value="<%=id_no%>"/>
    <wtc:param value="<%=oldpassword%>"/>
    <wtc:param value="<%=workNo%>"/>
    <wtc:param value="<%=password%>"/>
    <wtc:param value="<%=ip_Addr%>"/>				
	</wtc:service>
	<wtc:array id="result" scope="end"/>

var response = new AJAXPacket();
response.data.add("retCode","<%=retCode%>");
response.data.add("retMsg","<%=retMsg%>");
core.ajax.receivePacket(response);
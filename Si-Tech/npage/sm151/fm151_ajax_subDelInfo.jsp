<%
    /*************************************
    * ��  ��: BOSS��������ƽ̨��������ѯ m151
    * ��  ��: version v1.0
    * ������: si-tech
    * ������: diling @ 2014-8-12
    **************************************/
%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ page contentType="text/html; charset=GBK" %>
<%
    String regionCode = (String) session.getAttribute("regCode");
    String workNo = (String) session.getAttribute("workNo");
    String ip_Addr = (String) session.getAttribute("ipAddr");
    String password = (String) session.getAttribute("password");
    String opCode = (String)request.getParameter("opCode");
    String opName = (String)request.getParameter("opName");
    String phoneNo = (String)request.getParameter("phoneNo");
    String ip = request.getRemoteAddr();
    String opNote = "Ӫҵǰ̨"+workNo+"������BOSS��������ƽ̨������ɾ������";
%>

<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="region" routerValue="<%=regionCode%>" id="printAccept"/>
	
<wtc:service name="sm150SCfm" routerKey="region" routerValue="<%=regionCode%>" outnum="2" retcode="retCode" retmsg="retMsg">
    <wtc:param value="<%=printAccept%>"/>
    <wtc:param value="01"/>
    <wtc:param value="<%=opCode%>"/>
    <wtc:param value="<%=workNo%>"/>
    <wtc:param value="<%=password%>"/>
    <wtc:param value="<%=phoneNo%>"/>
    <wtc:param value=""/>	
    <wtc:param value="<%=ip%>"/>
    <wtc:param value="<%=opNote%>"/>		
</wtc:service>
<wtc:array id="result" scope="end"/>
	
var response = new AJAXPacket();
response.data.add("retCode", "<%=retCode%>");
response.data.add("retMsg", "<%=retMsg%>");
core.ajax.receivePacket(response);
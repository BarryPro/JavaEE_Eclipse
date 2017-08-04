<%request.setCharacterEncoding("GB2312");%>
<%@ page contentType="text/html;charset=gb2312" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ page import="com.sitech.boss.pub.util.Encrypt" %>
<%
    String orgCode = (String) session.getAttribute("orgCode");
    String regionCode = orgCode.substring(0, 2);
    String oldpassword = request.getParameter("oldpassword");
    System.out.println("+++++++++++oldpassword:" + oldpassword);
    String id_no = request.getParameter("id_no");
    String opCode = request.getParameter("opCode");
    String workNo = (String) session.getAttribute("workNo");
    String ip_Addr = (String) session.getAttribute("ipAddr");
    String password = (String) session.getAttribute("password");
    String retRes = "FALSE";
    System.out.println("+++++++++++++id_no=[" + id_no + "]oldpassword=[" + oldpassword + "]");
%>
<wtc:service name="sCheckWidePass" routerKey="region" routerValue="<%=regionCode%>" outnum="2" retcode="retCode" retmsg="retMsg">
    <wtc:param value="<%=opCode%>"/>
    <wtc:param value="<%=id_no%>"/>
    <wtc:param value="<%=oldpassword%>"/>
    <wtc:param value="<%=workNo%>"/>
    <wtc:param value="<%=password%>"/>
    <wtc:param value="<%=ip_Addr%>"/>				
</wtc:service>
<wtc:array id="result" scope="end"/>
<%
    if ("000000".equals(retCode) || "0".equals(retCode))
    {
        retRes = "OK";
        }
    System.out.println("+++++++++++++retRes=[" + retRes + "]");
    System.out.println("+++++++++++++retCode=[" + retCode + "]");
    System.out.println("+++++++++++++retMsg=[" + retMsg + "]");
%>
var response = new AJAXPacket();
response.data.add("retCode","<%=retCode%>");
response.data.add("retMsg","<%=retMsg%>");
response.data.add("retRes","<%=retRes%>");
core.ajax.receivePacket(response);
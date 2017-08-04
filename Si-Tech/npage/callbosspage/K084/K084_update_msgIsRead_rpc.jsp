<%@ page contentType="text/html;charset=gb2312"%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ page import="com.sitech.crmpd.core.wtc.util.*,java.util.*"%>

<%

//String workNo = (String)session.getAttribute("workNo");
//modify wangyong 20090928
//String receive_login_no = (String)session.getAttribute("kfWorkNo");
String receive_login_no = (String)session.getAttribute("workNo");
String orgCode = (String)session.getAttribute("orgCode");
String regionCode = orgCode.substring(0,2);
String sqlStr = "update dnoticecontent set read_flag='Y' where receive_login_no=:v1 and read_flag='N' ";
 
%>
<wtc:service name="sPubModifyKfCfm" outnum="2" routerKey="region" routerValue="<%=regionCode%>">
<wtc:param value="<%=sqlStr%>"/>
<wtc:param value="dbchange"/>
<wtc:param value="<%=receive_login_no%>"/>
</wtc:service>

var response = new AJAXPacket();
response.data.add("retCode","<%=retCode%>");
core.ajax.receivePacket(response);

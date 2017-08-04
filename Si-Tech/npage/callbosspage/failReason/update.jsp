
<%@ page contentType="text/html;charset=gb2312"%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ page import="com.sitech.crmpd.core.wtc.util.*,java.util.*"%>
<%


String code=request.getParameter("code")==null?"":request.getParameter("code");
String name=request.getParameter("name")==null?"":request.getParameter("name");


String sqlArr="UPDATE scalloutfailreson d SET d.failure_name = :v1 WHERE d.failure_code = :v2";
String orgCode = (String)session.getAttribute("orgCode");
String regionCode = orgCode.substring(0,2);
%>
<wtc:service name="sPubModifyKfCfm" outnum="2" routerKey="region" routerValue="<%=regionCode%>">
<wtc:param value="<%=sqlArr%>"/>
<wtc:param value="dbchange"/>
<wtc:param value="<%=name%>"/>
<wtc:param value="<%=code%>"/>
</wtc:service>
<wtc:array id="retRows"  scope="end"/>	
	
	
var response = new AJAXPacket();
response.data.add("retCode",<%=retCode%>);
core.ajax.receivePacket(response);


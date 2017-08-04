<%@ page contentType="text/html;charset=gb2312"%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ page import="com.sitech.crmpd.core.wtc.util.*,java.util.*"%>
<%
	String org_code = (String)session.getAttribute("orgCode");
	String regionCode = org_code.substring(0,2);
	String sendWork = request.getParameter("sendWork");
	String sqlStr = "select t.boss_login_no, to_char(sysdate,'yyyy-mm-dd hh24:mi:ss')"
								+ "  from dloginmsgrelation t"
							  + " where t.kf_login_no=:sendWork";
	String myParams = "sendWork=" + sendWork;
%>

 <wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" outnum="2">
 	 <wtc:param value="<%=sqlStr%>" />
 	 <wtc:param value="<%=myParams%>"/>
 </wtc:service>
 <wtc:array id="queryList" start="0" length="2" scope="end"/>

var response = new AJAXPacket();
response.data.add("boss_login_no","<%=queryList[0][0]%>");
response.data.add("sysdate","<%=queryList[0][1]%>");
core.ajax.receivePacket(response);


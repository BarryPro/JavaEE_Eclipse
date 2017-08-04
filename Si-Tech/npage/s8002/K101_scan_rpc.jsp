<%@ page contentType="text/html;charset=gb2312"%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ page import="com.sitech.crmpd.core.wtc.util.*,java.util.*"%>
<%
	String orgCode = (String)session.getAttribute("orgCode");
  String regionCode = orgCode.substring(0,2);
  String loginNo = request.getParameter("login_no");
  String sqlStr="update dstaffstatus t set t.hearttime2=t.hearttime, t.hearttime=sysdate where t.login_no=:v1";
%>
	     <wtc:service name="sPubModifyKfCfm" outnum="2" routerKey="region" routerValue="<%=regionCode%>">
	       <wtc:param value="<%=sqlStr%>" />
	       <wtc:param value="dbchange"/>
	       <wtc:param value="<%=loginNo%>"/>
	     </wtc:service>
<%
   
  System.out.println("\n\n\n======"+retCode);
%>
var response = new AJAXPacket();
response.data.add("retCode","<%=retCode%>");
core.ajax.receivePacket(response);;
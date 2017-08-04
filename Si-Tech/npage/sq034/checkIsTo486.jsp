<%
/********************
 version v2.0
¿ª·¢ÉÌ: si-tech
*
*create:hejwa 2013-6-24 9:32:09
*
********************/
%>
<%@ page contentType="text/html; charset=gb2312" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%
		String phoneNo = (String)request.getParameter("phoneNo");
		String regionCode  = (String)session.getAttribute("regCode");
		
 		String sqlStr      = "select * from dKDInstallIMSMsg where install_no=:phoneNo and install_type='00' and op_time> (select op_time from dbroadbandmsg where cfm_login=:phoneNo);";
 		String paramIn     = "phoneNo="+phoneNo;
		String returnPhone   = "";
%>		
  <wtc:service name="TlsPubSelCrm" outnum="1" retmsg="msg" retcode="code" routerKey="region" routerValue="<%=regionCode%>">
		<wtc:param value="<%=sqlStr%>" />
		<wtc:param value="<%=paramIn%>" />	
	</wtc:service>
	<wtc:array id="result_t" scope="end"/>
<%
	if(result_t.length>0){
		returnPhone = result_t[0][0];
	}
%>

var response = new AJAXPacket();
response.data.add("returnPhone","<%=returnPhone%>");
core.ajax.receivePacket(response);
<%
/********************
 version v2.0
¿ª·¢ÉÌ: si-tech
*create hejwa 2011-11-1 14:20:23
*
********************/
%>
<%@ page contentType="text/html; charset=gb2312" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%
		String regionCode = (String)session.getAttribute("regCode");
		String loginNo   = (String)request.getParameter("loginNo");  
		String countLoginnoSql = "select count(*) from dloginmsg where login_no='"+loginNo+"'";
		String countLoginno = "0";
%>
	 
	<wtc:pubselect name="sPubSelect" outnum="1" retmsg="msg" retcode="code" routerKey="region" routerValue="<%=regionCode%>">
  		<wtc:sql><%=countLoginnoSql%></wtc:sql>
 		</wtc:pubselect>
	<wtc:array id="result_t" scope="end"/>
<%
		if(result_t.length>0){
			countLoginno = result_t[0][0];
		}
%>
var response = new AJAXPacket();
response.data.add("countLoginno","<%=countLoginno%>");
core.ajax.receivePacket(response);
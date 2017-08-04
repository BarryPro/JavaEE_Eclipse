<%request.setCharacterEncoding("GB2312");%>
<%@ page contentType= "text/html;charset=gb2312" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%
String sqlStr = "select to_char(decode(max(bullet_code),'','0',max(bullet_code)) + 1 ,'0000') from dsysbullet";
String regionCode = (String)session.getAttribute("regCode");
%>
	<wtc:pubselect name="sPubSelect" outnum="1" retmsg="msg" retcode="code" routerKey="region" routerValue="<%=regionCode%>">
  		<wtc:sql><%=sqlStr%></wtc:sql>
 		</wtc:pubselect>
	<wtc:array id="result_t" scope="end"/>
		
var response = new AJAXPacket();
var bullet_code = "<%=result_t[0][0]%>";
response.data.add("bullet_code",bullet_code);
core.ajax.receivePacket(response);




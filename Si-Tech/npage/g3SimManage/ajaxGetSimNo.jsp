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
		String phoneno   = (String)request.getParameter("phoneno");  
		String getSimNo = "select a.SWITCH_NO from dcustsim a,  dcustmsg b where a.id_no= b.id_no and b.phone_no=:phone_no ";
		String myParams="phone_no="+phoneno;
		String simNo = "";
		
%>
	 
  <wtc:service name="TlsPubSelCrm" outnum="1" retmsg="msg" retcode="code" routerKey="region" routerValue="<%=regionCode%>">
		<wtc:param value="<%=getSimNo%>" />
		<wtc:param value="<%=myParams%>" />	
	</wtc:service>
	<wtc:array id="result_t" scope="end"  />
				
<%
		if(result_t.length==1){
			simNo = result_t[0][0];
		}
%>
var response = new AJAXPacket();
response.data.add("simNo","<%=simNo%>");
core.ajax.receivePacket(response);
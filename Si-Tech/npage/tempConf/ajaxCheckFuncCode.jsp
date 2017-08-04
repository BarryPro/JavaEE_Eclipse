<%
/********************
 version v2.0
¿ª·¢ÉÌ: si-tech
*create hejwa 2012-11-30 11:30:11
*
********************/
%>
<%@ page contentType="text/html; charset=gb2312" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%
		String regionCode = (String)session.getAttribute("regCode");
		String funccode   = (String)request.getParameter("funccode");  
		
		String countOpcodeSql = "select count(*) from sfunccode where function_code=:funccode";
		String param1 = "funccode="+funccode;
		String countOpcode = "0";
%>
	 
  <wtc:service name="TlsPubSelCrm" outnum="1" retmsg="msg" retcode="code" routerKey="region" routerValue="<%=regionCode%>">
		<wtc:param value="<%=countOpcodeSql%>" />
		<wtc:param value="<%=param1%>" />	
	</wtc:service>
	<wtc:array id="result_t" scope="end"  />
<%
		if(result_t.length>0){
			countOpcode = result_t[0][0];
		}
		System.out.println("--------countOpcode-----------"+countOpcode);
%>
var response = new AJAXPacket();
response.data.add("countOpcode","<%=countOpcode%>");
core.ajax.receivePacket(response);
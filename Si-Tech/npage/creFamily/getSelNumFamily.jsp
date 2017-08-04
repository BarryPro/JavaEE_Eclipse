<%
/********************
 version v2.0
¿ª·¢ÉÌ: si-tech
*
*create:hejwa@2013-4-18 10:44:06
*
********************/
%>
<%@ page contentType="text/html; charset=gb2312" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%
		String regionCode = (String)session.getAttribute("regCode");
		String workNo  =  (String)session.getAttribute("workNo");
		String errCode = "000000";
		String errMsg = "";
		String selNum = "";
		String newSmCode   = (String)request.getParameter("newSmCode");  
 
%>		
  <wtc:service name="sGetBroadUserNo" outnum="1" retmsg="msg" retcode="code" routerKey="region" routerValue="<%=regionCode%>">
		<wtc:param value="" />
		<wtc:param value="" />
		<wtc:param value="" />
		<wtc:param value="<%=workNo%>" />
		<wtc:param value="" />
		<wtc:param value="" />
		<wtc:param value="" />
		<wtc:param value="103" />							
	</wtc:service>
	<wtc:array id="result_t2" scope="end"  />
 	
<%
 
if(!code.equals("000000")){
		errCode = code;
		errMsg = msg;
		
}else{
	if(result_t2.length>0){
		selNum = result_t2[0][0];
	}
}
%>
 	
var response = new AJAXPacket();

response.data.add("code","<%=errCode%>");
response.data.add("msg","<%=errMsg%>");
response.data.add("selNum","<%=selNum%>");
core.ajax.receivePacket(response);
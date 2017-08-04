<%
/********************
 version v2.0
开发商: si-tech
*
* create hejwa
* 打印免填单存储
* 2013-5-24 14:16:34
*
********************/
%>
<%@ page contentType="text/html; charset=gb2312" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
var retArray = new Array();
<%
	String regionCode     = (String)session.getAttribute("regCode");
	String workNo         = (String)session.getAttribute("workNo");
	
	String sLoginAccept   = request.getParameter("sLoginAccept");
	String cust_info      = request.getParameter("cust_info");
	String opr_info       = request.getParameter("opr_info");
	String note_info1     = request.getParameter("note_info1");
	String note_info2     = request.getParameter("note_info2");
	String note_info3     = request.getParameter("note_info3");
	String note_info4     = request.getParameter("note_info4");
	String opCode         = request.getParameter("opCode");

	String retCode        = "";
	String retMsg         = "";
try{
%>
  <wtc:service name="sPrintSaveInServ" outnum="1" retmsg="msg" retcode="code" routerKey="region" routerValue="<%=regionCode%>">
		<wtc:param value="<%=sLoginAccept%>" />
		<wtc:param value="<%=cust_info%>" />	
		<wtc:param value="<%=opr_info%>" />	
		<wtc:param value="<%=note_info1%>" />			
		<wtc:param value="<%=note_info2%>" />		
		<wtc:param value="<%=note_info3%>" />
		<wtc:param value="<%=note_info4%>" />
		<wtc:param value="<%=opCode%>" />		
		<wtc:param value="<%=workNo%>" />			
	</wtc:service>
 
<%
	retCode   = code;
	retMsg    = msg;
}catch(Exception e){
	retCode   = "444444";
	retMsg    = "系统错误";
}

%>		 	
var response = new AJAXPacket();
response.data.add("retCode","<%=retCode%>");
response.data.add("retMsg","<%=retMsg%>");

core.ajax.receivePacket(response);
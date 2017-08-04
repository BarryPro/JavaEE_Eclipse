<%@ page contentType= "text/html;charset=gbk" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%
  String retType = WtcUtil.repNull(request.getParameter("retType"));  
  String ordernum = WtcUtil.repNull(request.getParameter("ordernum")); 

  System.out.println("------------------ordernum-----------------"+ordernum);

  String regionCode = (String)session.getAttribute("regCode");
%>
	<wtc:service name="sDynSqlCfm" routerKey="region" routerValue="<%=regionCode%>" outnum="3">
		  <wtc:param value="88002"/>
		  <wtc:param value="<%=ordernum%>"/>
		  <wtc:param value="<%=ordernum%>"/>
	</wtc:service>
	<wtc:array id="result_t" scope="end"/>
<%
  System.out.println("------------------retCode-----------------"+retCode);
  System.out.println("------------------retMsg-----------------"+retMsg);
%>	
var response = new AJAXPacket();
response.data.add("retCode",'<%=retCode%>');
response.data.add("retMsg",'<%=retMsg%>');
response.data.add("retType",'<%=retType%>');
core.ajax.receivePacket(response);
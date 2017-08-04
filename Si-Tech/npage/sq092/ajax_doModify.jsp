<%@ page contentType= "text/html;charset=gbk" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%
  String retType = WtcUtil.repNull(request.getParameter("retType"));  
  String ordernum = WtcUtil.repNull(request.getParameter("ordernum")); 
  String newstructvalue = WtcUtil.repNull(request.getParameter("newstructvalue"));
  String CONTENTID = WtcUtil.repNull(request.getParameter("CONTENTID"));  
  System.out.println("------------------ordernum-----------------"+ordernum);
   System.out.println("------------------newstructvalue-----------------"+newstructvalue);
  String regionCode = (String)session.getAttribute("regCode");
  String workNo = (String)session.getAttribute("workNo");
%>
	<wtc:service name="sDynSqlCfm" routerKey="region" routerValue="<%=regionCode%>" outnum="3">
		  <wtc:param value="88001"/>
		  <wtc:param value="<%=workNo%>"/>
		  <wtc:param value="<%=ordernum%>"/>
		  <wtc:param value="<%=CONTENTID%>"/>
		  <wtc:param value="<%=newstructvalue%>"/>
		  <wtc:param value="<%=ordernum%>"/>
		  <wtc:param value="<%=CONTENTID%>"/>
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
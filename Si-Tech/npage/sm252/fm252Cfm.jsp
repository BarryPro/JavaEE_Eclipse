<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%
	/******
	ningtn 2015/2/13 ÐÇÆÚÎå ÏÂÎç 3:40:54
	*/
	System.out.println("============ ningtn pubSelectBySql.jsp ====");
	String regionCode= (String)session.getAttribute("regCode");
  
	String serviceName = WtcUtil.repNull(request.getParameter("serviceName"));
	String outnum = WtcUtil.repNull(request.getParameter("outnum"));
	String inputParamsLength = WtcUtil.repNull(request.getParameter("inputParamsLength"));
	String queryType = WtcUtil.repNull(request.getParameter("queryType"));
	int paramsLength = Integer.parseInt(inputParamsLength);
	String[] inParams = new String[paramsLength];
%>
	<wtc:service name="<%=serviceName%>" outnum="<%=outnum%>" routerKey="region" 
		 routerValue="<%=regionCode%>" retcode="retCode" retmsg="retMsg">
		 <%
		 for(int i = 0; i < paramsLength; i++){
		 inParams[i] = request.getParameter("inParams" + i);
		 %>
		 	<wtc:param value="<%=inParams[i]%>"/>
		 <%
		 }
		 %>
	</wtc:service>



	var response = new AJAXPacket();

	response.data.add("retcode","<%=retCode%>");
	response.data.add("retmsg","<%=retMsg%>");
	core.ajax.receivePacket(response);
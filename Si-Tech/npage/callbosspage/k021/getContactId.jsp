<%@ page contentType= "text/html;charset=gb2312" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%
	String callerPhone = WtcUtil.repNull(request.getParameter("callerPhone"));
	String acceptLoginNo = WtcUtil.repNull(request.getParameter("acceptLoginNo"));
%>
	<wtc:service name="sGetContactId" outnum="5">
		<wtc:param value="1111"/>
		<wtc:param value=""/>
		<wtc:param value="<%=callerPhone%>"/>
		<wtc:param value="<%=acceptLoginNo%>"/>
	</wtc:service>
	<wtc:array id="rows"  scope="end"/>
	<%
	  if(!rows[0][0].equals("000000")){
	     retCode = "000001";
	     retMsg = "获取接触流水号失败";
	  }
	%>

	var response = new AJAXPacket();
	response.data.add("retCode","<%=retCode%>");
	response.data.add("retMsg","<%=retMsg%>");
	response.data.add("contactId","<%=rows[0][2]%>");
	response.data.add("opCode","<%=rows[0][3]%>");
	response.data.add("contactMonth","<%=rows[0][4]%>");
	core.ajax.receivePacket(response);

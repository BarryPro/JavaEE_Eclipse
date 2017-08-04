<%request.setCharacterEncoding("GBK");%>
<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%
  String regionCode = (String) session.getAttribute("regCode");
  String workNo = (String) session.getAttribute("workNo");
  String ip_Addr = (String) session.getAttribute("ipAddr");
  String password = (String) session.getAttribute("password");
  String opCode = "m351";
  
  String phoneNo = (String)request.getParameter("qPhoneNoghs");
  String opNote = workNo+"对用户"+phoneNo+"进行了固话信息修改操作";
	String qCustNames = (String)request.getParameter("qCustNames");
	String qPhoneNos = (String)request.getParameter("qPhoneNos");

%>
	      <wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="region" routerValue="<%=regionCode%>" id="printAccept"/>
	
	<wtc:service name="sm351Cfm" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode" retmsg="retMsg" outnum="6"	>
		<wtc:param value = "<%=printAccept%>"/>
		<wtc:param value = "01"/>
		<wtc:param value = "<%=opCode%>"/>
		<wtc:param value = "<%=workNo%>"/>		
		<wtc:param value = "<%=password%>"/>
		<wtc:param value = ""/>
		<wtc:param value = ""/>
		<wtc:param value = "<%=phoneNo%>"/>
		<wtc:param value = "<%=qCustNames%>"/>
		<wtc:param value = "<%=qPhoneNos%>"/>
		<wtc:param value = "<%=opNote%>"/>
		
	</wtc:service>
	<wtc:array id="ret" scope="end" />

var response = new AJAXPacket();
response.data.add("retCode", "<%=retCode%>");
response.data.add("retMsg", "<%=retMsg%>");

core.ajax.receivePacket(response);
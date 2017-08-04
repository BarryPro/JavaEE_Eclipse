<%@ page contentType="text/html; charset=gb2312"%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%

	String opCode = request.getParameter("opCode");
	String v_phoneNo = request.getParameter("v_phoneNo");
	String steamno = request.getParameter("steamno");
	String companyname = request.getParameter("companyname");
	String workNo = (String)session.getAttribute("workNo");
	String workPwd = (String)session.getAttribute("password");
	String regCode=(String)session.getAttribute("regCode");
	String notes = workNo+"对"+v_phoneNo+"进行物流信息录入";
%>
	<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="region" routerValue="<%=regCode%>" id="printAccept"/>

	<wtc:service name="sm144Cfm" routerKey="region" routerValue="<%=regCode%>" retcode="retCode2" retmsg="retMsg2" outnum="4" >
		<wtc:param value="<%=printAccept%>"/>
		<wtc:param value="01"/>
		<wtc:param value="<%=opCode%>"/>
		<wtc:param value="<%=workNo%>"/>
		<wtc:param value="<%=workPwd%>"/>
		<wtc:param value="<%=v_phoneNo%>"/>
		<wtc:param value=""/>
		<wtc:param value="<%=notes%>"/>
		<wtc:param value="<%=steamno%>"/>
		<wtc:param value="<%=companyname%>"/>
	</wtc:service>
	<wtc:array id="result"  scope="end" />

var response = new AJAXPacket();
response.data.add("retCode2","<%=retCode2%>");
response.data.add("retMsg2","<%=retMsg2%>");
core.ajax.receivePacket(response);

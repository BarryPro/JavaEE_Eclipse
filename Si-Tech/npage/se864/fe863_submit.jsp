<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ include file="../../npage/bill/getMaxAccept.jsp" %>

	<%
    String workNo = (String)session.getAttribute("workNo");
		String regionCode= (String)session.getAttribute("regCode");
		String password = (String)session.getAttribute("password");
		//String PhoneNo = request.getParameter("PhoneNo");
		String groupId = (String)session.getAttribute("groupId");
		String opCode = request.getParameter("opCode");
		String opName = request.getParameter("opName");
		String jsontext=request.getParameter("myJSONText");
		String shenpitype=request.getParameter("shenpitype");
		String shenpimsg=request.getParameter("shenpimsg");
		String unit_id=request.getParameter("unit_id");
		String zgdsl_id=request.getParameter("zgdsl_id");
		String grpnames=request.getParameter("grpnames");

	%>

		<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="regioncode" 
			routerValue="<%=regionCode%>"  id="loginAccept" />
		<wtc:service name="sDealmpCustChg" routerKey="region" routerValue="<%=regionCode%>"
					 retcode="retCode" retmsg="retMsg" outnum="1">
        <wtc:param value="<%=loginAccept%>"/>
        <wtc:param value="01"/>
        <wtc:param value="<%=opCode%>"/>
        <wtc:param value="<%=workNo%>"/>
        <wtc:param value="<%=password%>"/>
        <wtc:param value=""/>
        <wtc:param value=""/>
        <wtc:param value="<%=groupId%>"/>
        <wtc:param value="<%=shenpitype%>"/>
        <wtc:param value="<%=unit_id%>"/>
        <wtc:param value="<%=shenpimsg%>"/>
       	<wtc:param value="<%=zgdsl_id%>"/>
		</wtc:service>
		<wtc:array id="result1" scope="end"/>
			<%

if("000000".equals(retCode)){
		System.out.println(" ======== sDealmpCustChg 调用成功 ========"  + retCode + " | " + retMsg);
		}
	else {
		System.out.println(" ======== sDealmpCustChg 调用失败 ========"  + retCode + " | " + retMsg);
		}
		
		%>

	var response = new AJAXPacket();

	response.data.add("retcode","<%= retCode %>");
	response.data.add("retmsg","<%= retMsg %>");
	core.ajax.receivePacket(response);
<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%
		String workNo = (String)session.getAttribute("workNo");
		String regionCode= (String)session.getAttribute("regCode");
		String password = (String)session.getAttribute("password");
		String groupId = (String)session.getAttribute("groupId");
		
		String khtypes = request.getParameter("khtypes");
		String newphone1 = request.getParameter("phonesno");
		String idnos = request.getParameter("kehuids");

		
%>
		<wtc:service name="sCheckXHKHState" routerKey="region" routerValue="<%=regionCode%>"
					 retcode="retCode" retmsg="retMsg" outnum="2">
				<wtc:param value="0"/>
				<wtc:param value="01"/>
				<wtc:param value="1104"/>
				<wtc:param value="<%=workNo%>"/>
				<wtc:param value="<%=password%>"/>
				<wtc:param value="<%=newphone1%>"/>
				<wtc:param value=""/>
				<wtc:param value="�Ժ���������֤���ͺͺ����Ƿ������һ��ʹ�õĽ���У��"/>
				<wtc:param value="<%=idnos%>"/>
			</wtc:service>
		<wtc:array id="ret" scope="end"/>
<%

	if("000000".equals(retCode)){
		System.out.println(" ======== sCheckXHKHState ���óɹ� ========"  + retCode + " | " + retMsg);

	}
else {
		System.out.println(" ======== sCheckXHKHState ����ʧ�� ========" + retCode + " | " + retMsg);
	}
%>

	var response = new AJAXPacket();
	response.data.add("retcode","<%= retCode %>");
	response.data.add("retmsg","<%= retMsg %>");
	core.ajax.receivePacket(response);
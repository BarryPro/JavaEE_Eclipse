<%@ page contentType= "text/html;charset=gb2312" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%
		String workNo = (String)session.getAttribute("workNo");
		String orgCode = (String)session.getAttribute("orgCode");
		String regionCode= (String)session.getAttribute("regCode");
		String phoneNo = request.getParameter("phoneNo");
		String getBroadSql = "select cfm_login from dbroadbandmsg where phone_no = '" + phoneNo + "'";
		String cfmLogin = "";
		System.out.println("============ getBroadSql ===" + getBroadSql);
%>
	<wtc:pubselect name="sPubSelect" outnum="1"  routerKey="region" 
		 routerValue="<%=regionCode%>" retcode="retCode" retmsg="retMsg">
		<wtc:sql><%=getBroadSql%></wtc:sql>
	</wtc:pubselect>
	<wtc:array id="result" scope="end"/>
<%
	if(!(retCode.equals("0") || retCode.equals("000000"))){
	}else if(result != null && result.length > 0){
		cfmLogin = result[0][0];
	}
	System.out.println("============ cfmLogin ===" + cfmLogin);
%>
	var response = new AJAXPacket();

	response.data.add("retcode","<%= retCode %>");
	response.data.add("retmsg","<%= retMsg %>");
	response.data.add("result","<%=cfmLogin%>");
	core.ajax.receivePacket(response);
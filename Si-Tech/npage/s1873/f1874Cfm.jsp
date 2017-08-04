<%@ page contentType="text/html; charset=gb2312"%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
var result = new Array();
<%
	String org_code = (String)session.getAttribute("orgCode");
	String phone_no = request.getParameter("phone_no").trim();
	String opType = request.getParameter("opType").trim();
	String op_code = request.getParameter("op_code").trim();
	String op_name = request.getParameter("op_name").trim();
	String login_no = request.getParameter("login_no").trim();
	String printAccept = request.getParameter("printAccept").trim();
	String work_no =(String)session.getAttribute("workNo");
%>

	<wtc:service name="s1874Cfm" routerKey="region" routerValue="<%=org_code%>"  outnum="2">
		<wtc:param value="<%=phone_no%>"/>
		<wtc:param value="<%=op_code%>"/>
		<wtc:param value="<%=login_no%>"/>
		<wtc:param value="<%=org_code%>"/>
		<wtc:param value="<%=printAccept%>"/>
	</wtc:service>
	<wtc:array id="result"  scope="end"/>
		
<%
	String url = "/npage/contact/upCnttInfo.jsp?opCode="+op_code +"&retCodeForCntt="+retCode+"&opName="+op_name+"&workNo="+work_no+"&loginAccept="+printAccept+"&pageActivePhone="+phone_no+"&retMsgForCntt="+retMsg+"&opBeginTime="+opBeginTime;
	System.out.println(url);
	if(result.length > 0){
		for(int i=0;i<result[0].length;i++){
%>
			result[<%=i%>] = "<%=result[0][i]%>";
<%
		}
	}
%>
	<jsp:include page="<%=url%>" flush="true" />
	var response = new AJAXPacket();
	response.guid = '<%= request.getParameter("guid") %>';
	response.data.add("retCode","<%=retCode%>");
	response.data.add("retMsg","<%=retMsg%>");
	response.data.add("opType","<%=opType%>");
	response.data.add("result",result);
	core.ajax.receivePacket(response);
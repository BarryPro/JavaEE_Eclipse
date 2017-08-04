<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp"%>
<%
/*主页面传递的参数*/
String s_ajaxType=request.getParameter("ajaxType");
String regCode=(String)session.getAttribute("regCode");
if ( s_ajaxType.equals("fn_chkIfo") )
{
	String s_iLoginAccept=request.getParameter("iLoginAccept");
	String s_iOpCode=request.getParameter("iOpCode");
	String s_iLoginNo=request.getParameter("iLoginNo");
	String s_iLoginPwd=request.getParameter("iLoginPwd");
	String s_iPhoneNo=request.getParameter("iPhoneNo");
	String s_iUserPwd=request.getParameter("iUserPwd");
	String s_iUnitId=request.getParameter("iUnitId");
	String s_iCustomerNumber=request.getParameter("iCustomerNumber");
	String s_iOpType=request.getParameter("iOpType");
%>
	<wtc:service name="sg598Check" outnum="5"
		routerKey="region" routerValue="<%=regCode%>" 
		retcode="rc_fnChkIfo" retmsg="rm_fnChkIfo" >
		<wtc:param value="<%=s_iLoginAccept%>"/>
		<wtc:param value="01"/>
		<wtc:param value="<%=s_iOpCode%>"/>
		<wtc:param value="<%=s_iLoginNo%>"/>
		<wtc:param value="<%=s_iLoginPwd%>"/>
		<wtc:param value="<%=s_iPhoneNo%>"/>
		<wtc:param value="<%=s_iUserPwd%>"/>
		<wtc:param value="<%=s_iUnitId%>"/>
		<wtc:param value="<%=s_iCustomerNumber%>"/>
		<wtc:param value="<%=s_iOpType%>"/>
	</wtc:service>
	<wtc:array id="rst_fnChkIfo" scope="end" />

	var response = new AJAXPacket();
	response.data.add("oRetCode" ,"<%=rst_fnChkIfo[0][0]%>");
	response.data.add("oRetMsg"  ,"<%=rst_fnChkIfo[0][1]%>");
	response.data.add("oUnitId"  ,"<%=rst_fnChkIfo[0][2]%>");
	response.data.add("oCustomerNumber" ,"<%=rst_fnChkIfo[0][3]%>");
	response.data.add("oCustomerName"   ,"<%=rst_fnChkIfo[0][4]%>");
	core.ajax.receivePacket(response);
<%
}
else if ( s_ajaxType.equals("fn_doCfm") )
{
	String s_iLoginAccept=request.getParameter("iLoginAccept");
	String s_iOpCode=request.getParameter("iOpCode");
	String s_iLoginNo=request.getParameter("iLoginNo");
	String s_iLoginPwd=request.getParameter("iLoginPwd");
	String s_iPhoneNo=request.getParameter("iPhoneNo");
	String s_iUserPwd=request.getParameter("iUserPwd");
	String s_iCustomerNumber=request.getParameter("iCustomerNumber");
	String s_iOpType=request.getParameter("iOpType");
	String s_iUnitId=request.getParameter("iUnitId");

%>
	<wtc:service name="sg598Cfm" outnum="2"
		routerKey="region" routerValue="<%=regCode%>" 
		retcode="rc_fn_cfm" retmsg="rm_fn_cfm" >
		<wtc:param value="<%=s_iLoginAccept%>"/>
		<wtc:param value="01"/>
		<wtc:param value="<%=s_iOpCode%>"/>
		<wtc:param value="<%=s_iLoginNo%>"/>
		<wtc:param value="<%=s_iLoginPwd%>"/>
		<wtc:param value="<%=s_iPhoneNo%>"/>
		<wtc:param value="<%=s_iUserPwd%>"/>
		<wtc:param value="<%=s_iUnitId%>"/>
		<wtc:param value="<%=s_iCustomerNumber%>"/>
		<wtc:param value="<%=s_iOpType%>"/>
	</wtc:service>
	<wtc:array id="rst_fnCfm" scope="end" />
	
	var response = new AJAXPacket();
	response.data.add("oRetCode" ,"<%=rc_fn_cfm%>");
	response.data.add("oRetMsg"  ,"<%=rm_fn_cfm%>");
	core.ajax.receivePacket(response);
<%
}
%>
		
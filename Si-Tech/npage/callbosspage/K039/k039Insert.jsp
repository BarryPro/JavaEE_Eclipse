<%
	/*
	 * ����: ����CCS
	 * �汾: 1.0
	 * ����: 2008/10/21
	 * ����: tancf
	 * ��Ȩ: sitech
	 * 
	 *  
	 */
%>
<%@ page contentType="text/html;charset=gb2312"%>
<%@ include file="/npage/include/public_title_ajax.jsp"%>
<%
		String retType = request.getParameter("retType").trim();
    String op_code = request.getParameter("op_code").trim();
    String op_note="״̬����Ϊ����CCS";
	  String login_no = (String)session.getAttribute("workNo");  
	  String login_name = (String)session.getAttribute("workName");
	  String org_code = (String)session.getAttribute("orgCode"); 
	  String ip_addr = (String)session.getAttribute("ipAddr");
%>
<wtc:service name="sRK039Insert" outnum="1">
		<wtc:param value="<%=login_no%>"/>
		<wtc:param value=""/>
		<wtc:param value="<%=org_code%>"/>
		<wtc:param value=""/>
		<wtc:param value="<%=op_code%>"/>
		<wtc:param value="<%=ip_addr%>"/>
		<wtc:param value="<%=op_note%>"/>
</wtc:service>
	var response = new AJAXPacket();
	response.data.add("retType","<%=retType%>");
	response.data.add("retCode","<%=retCode%>");
	response.data.add("retMsg","<%=retMsg%>");
	core.ajax.receivePacket(response);	

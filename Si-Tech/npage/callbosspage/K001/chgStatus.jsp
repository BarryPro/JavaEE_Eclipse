<%
	/*
	 * ����: ��Ϣ
	 * �汾: 1.0
	 * ����: 2008/10/21
	 * ����: kouwb 
	 * ��Ȩ: sitech
	 * 
	 *  
	 */
%>
<%@ page contentType="text/html;charset=gb2312"%>
<%@ include file="/npage/include/public_title_name.jsp"%>
<%
		String retType = request.getParameter("retType").trim();
    String op_code = request.getParameter("op_code").trim();
    String phone_no = request.getParameter("phone_no").trim();
    String op_note="����Ϊ��Ϣ״̬";
    String staff_status = "��Ϣ";
	  String login_no = (String)session.getAttribute("workNo");  
	  String login_name = (String)session.getAttribute("workName");
	  String org_code = (String)session.getAttribute("orgCode"); 
	  String ip_addr = (String)session.getAttribute("ipAddr");
%>
<wtc:service name="sKStatChg" outnum="1">
		<wtc:param value="<%=login_no%>"/>
		<wtc:param value="<%=login_name%>"/>
		<wtc:param value="<%=org_code%>"/>
		<wtc:param value="<%=phone_no%>"/>
		<wtc:param value="<%=op_code%>"/>
		<wtc:param value="<%=ip_addr%>"/>
		<wtc:param value="<%=op_note%>"/>
		<wtc:param value="<%=staff_status%>"/>
		<wtc:param value="<%=login_no%>"/>
		<wtc:param value=""/>
		<wtc:param value=""/>
		<wtc:param value=""/>
		<wtc:param value=""/>
</wtc:service>
<wtc:array id="queryList" scope="end" />
	
	
	var response = new AJAXPacket();
	response.data.add("retType","<%=retType%>");
	response.data.add("retCode","<%=retCode%>");
	response.data.add("retMsg","<%=retMsg%>");
	core.ajax.receivePacket(response);	
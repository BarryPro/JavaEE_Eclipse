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
    String opCode="K001";
    String opName="��Ϣ";
	  String loginNo = (String)session.getAttribute("workNo");  
	  String orgCode = (String)session.getAttribute("orgCode"); 
%>
<wtc:service name="sKStatChg" outnum="1">
		<wtc:param value="<%=loginNo%>"/>
		<wtc:param value="<%=loginNo%>"/>
		<wtc:param value="<%=loginNo%>"/>
		<wtc:param value="<%=loginNo%>"/>
		<wtc:param value="<%=loginNo%>"/>
		<wtc:param value="<%=loginNo%>"/>
		<wtc:param value="<%=loginNo%>"/>
		<wtc:param value="<%=loginNo%>"/>
		<wtc:param value="<%=loginNo%>"/>
		<wtc:param value="<%=loginNo%>"/>
		<wtc:param value="<%=loginNo%>"/>
		<wtc:param value="<%=loginNo%>"/>
		<wtc:param value="<%=loginNo%>"/>
</wtc:service>
<wtc:array id="queryList" scope="end" />
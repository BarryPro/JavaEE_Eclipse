<%
  /*
   * ����: 4G��������¼�� m036
   * �汾: 1.0
   * ����: 2014/1/13 
   * ����: diling
   * ��Ȩ: si-tech
  */
%>
<%@ page contentType="text/html; charset=gb2312"%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%

	String opCode = request.getParameter("opCode");
	String v_phoneNo = request.getParameter("phoneNo");

	String workNo = (String)session.getAttribute("workNo");
	String workPwd = (String)session.getAttribute("password");
	String regCode=(String)session.getAttribute("regCode");

	String simNo = WtcUtil.repNull((String)request.getParameter("simNo"));
	String notes = workNo+"�Ժ���"+v_phoneNo+"����sim¼��";

%>
	<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="region" routerValue="<%=regCode%>" id="printAccept"/>

	<wtc:service name="sm141Cfm" routerKey="region" routerValue="<%=regCode%>" retcode="retCode2" retmsg="retMsg2" outnum="4" >
		<wtc:param value="<%=printAccept%>"/>
		<wtc:param value="01"/>
		<wtc:param value="m141"/>
		<wtc:param value="<%=workNo%>"/>
		<wtc:param value="<%=workPwd%>"/>
		<wtc:param value="<%=v_phoneNo%>"/>
		<wtc:param value=""/>
		<wtc:param value="<%=notes%>"/>
		<wtc:param value="<%=simNo%>"/>

	</wtc:service>
	<wtc:array id="result"  scope="end" />

var response = new AJAXPacket();
response.data.add("retCode2","<%=retCode2%>");
response.data.add("retMsg2","<%=retMsg2%>");
core.ajax.receivePacket(response);

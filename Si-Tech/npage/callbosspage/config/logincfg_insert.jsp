<%
  /*
   * ����: ���¿ͷ���½����
�� * �汾: 1.0.0
�� * ����: 2009/04/11
�� * ����: fangyuan
�� * ��Ȩ: sitech
	 *update:
��*/
%>
 
<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%
	 
	String orgCode = (String)session.getAttribute("orgCode");
	String regionCode = orgCode.substring(0,2);
	String login_no = WtcUtil.repNull(request.getParameter("login_no"));
	String passwd = WtcUtil.repNull(request.getParameter("passwd"));
	String subccno = WtcUtil.repNull(request.getParameter("subccno"));

	//modify by hucw,20100618,��dlogincfg���в�������ʱ������subccno�ֶ�;
	String updSql = "insert into dlogincfg(login_no,password,remarks,subccno) values(:v1,:v2,'N',:v3)";
	//String updSql = "insert into dlogincfg(login_no,password,remarks) values(:v1,:v2,'N')";
%>

<wtc:service name="sPubModifyKfCfm" outnum="2" routerKey="region" routerValue="<%=regionCode%>">
	<wtc:param value="<%=updSql%>"/>
	<wtc:param value="dbchange"/>
	<wtc:param value="<%=login_no%>"/>
	<wtc:param value="<%=passwd%>"/>
	<wtc:param value="<%=subccno%>"/>
</wtc:service>
<wtc:array id="rows" scope="end" />

var response = new AJAXPacket();
response.data.add("retCode","<%=retCode%>");
core.ajax.receivePacket(response);






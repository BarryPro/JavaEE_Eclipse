<%
    /*************************************
    * ��  ��: У������ӿ���+��ѯ��ͥҵ������ߵ��Ӱ�����Ϣ
    * ��  ��: version v1.0
    * ������: si-tech
    * ������: diling @ 2014/11/25 
    **************************************/
%>
<%@ page contentType="text/html; charset=GB2312" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%
  String regCode=WtcUtil.repNull((String)session.getAttribute("regCode"));
  String loginNo= (String)session.getAttribute("workNo");
  String password = (String)session.getAttribute("password");
	String opCode = WtcUtil.repStr(request.getParameter("opCode"), "");
	String TVCardNo = WtcUtil.repStr(request.getParameter("TVCardNo"), "");//�����ӿ���
%>
	<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="region" routerValue="<%=regCode%>" id="printAccept"/>
		
	<wtc:service name="sFamTVBusiQry" routerKey="region" routerValue="<%=regCode%>" retcode="retCode" retmsg="retMsg" outnum="7">
		<wtc:param value="<%=printAccept%>"/>
		<wtc:param value="01"/>
		<wtc:param value="<%=opCode%>"/> 
		<wtc:param value="<%=loginNo%>"/>
		<wtc:param value="<%=password%>"/> 
		<wtc:param value=""/>
		<wtc:param value=""/>
		<wtc:param value="0"/> <%/* 0-��֤��������ߵ��ӿ����Ƿ��ظ� 1-��ѯ�����Ϣ*/%>
		<wtc:param value="<%=TVCardNo%>"/>
		<wtc:param value=""/>
		<wtc:param value=""/>
		<wtc:param value=""/>
		<wtc:param value=""/>
	</wtc:service>
	<wtc:array id="ret"  scope="end"/>

var response = new AJAXPacket();
response.data.add("retCode","<%=retCode%>");
response.data.add("retMsg","<%=retMsg%>");
core.ajax.receivePacket(response);
 
	    
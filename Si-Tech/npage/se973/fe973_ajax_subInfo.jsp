<%
    /*************************************
    * 功  能: 宽带账号端口初始化 e973
    * 版  本: version v1.0
    * 开发商: si-tech
    * 创建者: diling @ 2012-8-9
    **************************************/
%>
<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%
	String phoneNo = WtcUtil.repStr((String)request.getParameter("phoneNo"), "");
	String opCode=WtcUtil.repNull((String)request.getParameter("opCode"));
	String broadPhone = WtcUtil.repStr((String)request.getParameter("broadPhone"), "");
	String regCode = (String)session.getAttribute("regCode");
  String loginNo = (String)session.getAttribute("workNo");
  String password = (String)session.getAttribute("password");
%>
 <wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="region" routerValue="<%=regCode%>" id="printAccept"/>

	<wtc:service name="sE973Cfm" routerKey="region" routerValue="<%=regCode%>" retcode="retCode" retmsg="retMsg" outnum="2">
		<wtc:param value="<%=printAccept%>"/>
		<wtc:param value="01"/>
		<wtc:param value="<%=opCode%>"/> 
		<wtc:param value="<%=loginNo%>"/>
		<wtc:param value="<%=password%>"/> 
		<wtc:param value="<%=phoneNo%>"/>
		<wtc:param value=""/>
		<wtc:param value=""/>
		<wtc:param value="<%=broadPhone%>"/>
		<wtc:param value="0000"/>
	</wtc:service>
	<wtc:array id="ret"  scope="end"/>
<%
 System.out.println("---e973----retCode="+retCode);
%>
var response = new AJAXPacket();
response.data.add("retcode","<%=retCode%>");
response.data.add("retmsg","<%=retMsg%>");
core.ajax.receivePacket(response);
 
	    
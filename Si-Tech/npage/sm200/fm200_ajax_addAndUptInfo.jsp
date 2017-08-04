<%
    /*************************************
    * 功  能: m200·IDC交换机端口信息维护 
    * 版  本: version v1.0
    * 开发商: si-tech
    * 创建者: diling @ 2014/11/22
    **************************************/
%>
<%@ page contentType="text/html; charset=GB2312" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%
	String regCode=WtcUtil.repNull((String)session.getAttribute("regCode"));
	String loginNo= (String)session.getAttribute("workNo");
	String password = (String)session.getAttribute("password");
	String opCode = WtcUtil.repStr(request.getParameter("opCode"), "");
	String portName = WtcUtil.repStr(request.getParameter("portName"), "");
	String unitCustName = WtcUtil.repStr(request.getParameter("unitCustName"), "");
	String portId = WtcUtil.repStr(request.getParameter("portId"), "");
	String opType = WtcUtil.repStr(request.getParameter("opType"), "");
	System.out.println("diling--"+portName+"--"+unitCustName+"--"+portId+"--"+opType);
%>
<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="region" routerValue="<%=regCode%>" id="printAccept"/>

	<wtc:service name="sm200Cfm" routerKey="region" routerValue="<%=regCode%>" retcode="retCode" retmsg="retMsg" outnum="2">
		<wtc:param value="<%=printAccept%>"/>
		<wtc:param value="01"/>
		<wtc:param value="<%=opCode%>"/> 
		<wtc:param value="<%=loginNo%>"/>
		<wtc:param value="<%=password%>"/> 
		<wtc:param value=""/>
		<wtc:param value=""/>
		<wtc:param value="<%=opType%>"/>
		<wtc:param value="<%=portId%>"/>
		<wtc:param value="<%=portName%>"/>
		<wtc:param value="<%=unitCustName%>"/>
	</wtc:service>
	<wtc:array id="ret"  scope="end"/>

var response = new AJAXPacket();
response.data.add("retCode","<%=retCode%>");
response.data.add("retMsg","<%=retMsg%>");
response.data.add("opType","<%=opType%>");
core.ajax.receivePacket(response);
 
	    
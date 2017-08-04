<%
    /*************************************
    * 功  能: 智能网管控查询 e874
    * 版  本: version v1.0
    * 开发商: si-tech
    * 创建者: diling @ 2012-6-7
    **************************************/
%>
<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%
  String loginNo = (String)session.getAttribute("workNo");
  String password = (String)session.getAttribute("password");
  String regCode = (String)session.getAttribute("regCode");
	String opCode=WtcUtil.repNull((String)request.getParameter("opCode"));
	String limitRatioVal = WtcUtil.repStr(request.getParameter("limitRatioVal"), "");
	String groupIdVal = WtcUtil.repStr(request.getParameter("groupIdVal"), "");
	System.out.println("---------diling -------------e874---limitRatioVal="+limitRatioVal);
%>
 <wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="region" routerValue="<%=regCode%>" id="printAccept"/>

	<wtc:service name="se874Cfm" routerKey="region" routerValue="<%=regCode%>" retcode="retCode" retmsg="retMsg" outnum="2">
		<wtc:param value="<%=printAccept%>"/>
		<wtc:param value="01"/>
		<wtc:param value="<%=opCode%>"/> 
		<wtc:param value="<%=loginNo%>"/>
		<wtc:param value="<%=password%>"/> 
		<wtc:param value=""/>
		<wtc:param value=""/>
		<wtc:param value="<%=groupIdVal%>"/>
		<wtc:param value="<%=limitRatioVal%>"/>
	</wtc:service>
	<wtc:array id="ret"  scope="end"/>
<%
 System.out.println("---e874----retCode="+retCode);
%>
var response = new AJAXPacket();
response.data.add("retcode","<%=retCode%>");
response.data.add("retmsg","<%=retMsg%>");
core.ajax.receivePacket(response);
 
	    
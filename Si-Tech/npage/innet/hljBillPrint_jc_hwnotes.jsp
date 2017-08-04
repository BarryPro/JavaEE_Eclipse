<%
    /*************************************
    * 功  能: 电子工单增加备注 
    * 版  本: version v1.0
    * 开发商: si-tech
    * 创建者: wanghyd @ 2012-8-1
    **************************************/
%>
<%@ page contentType="text/html; charset=GB2312" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%
    String regCode=WtcUtil.repNull((String)session.getAttribute("regCode"));
    String loginNo= (String)session.getAttribute("workNo");
	String login_accept= WtcUtil.repStr(request.getParameter("login_accept"), "");
	String opCode = WtcUtil.repStr(request.getParameter("opCode"), "");
	String notes = WtcUtil.repStr(request.getParameter("notesss"), "");
%>
	<wtc:service name="sPrt_PrtMsg" routerKey="regionCode" routerValue="<%=regCode%>" retcode="retCode" retmsg="retMsg" outnum="1">
		<wtc:param value="<%=login_accept%>"/>
		<wtc:param value="<%=loginNo%>"/>
		<wtc:param value="<%=opCode%>"/> 
		<wtc:param value="<%=notes%>"/>
	</wtc:service>
	<wtc:array id="ret"  scope="end"/>

var response = new AJAXPacket();
response.data.add("errCode","<%=retCode%>");
response.data.add("errMsg","<%=retMsg%>");
core.ajax.receivePacket(response);
 
	    
<%
    /*************************************
    * 功  能: 集团规模等级修改 e205
    * 版  本: version v1.0
    * 开发商: si-tech
    * 创建者: diling @ 2011-8-16
    **************************************/
%>
<%@ page contentType="text/html; charset=GB2312" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%
    String regCode=WtcUtil.repNull((String)session.getAttribute("regCode"));
    String loginNo= (String)session.getAttribute("workNo");
    String password = (String)session.getAttribute("password");
	String _getUnitId = WtcUtil.repStr(request.getParameter("_getUnitId"), "");
	String _getUnitName = WtcUtil.repStr(request.getParameter("_getUnitName"), "");
	String opCode = WtcUtil.repStr(request.getParameter("opCode"), "");
	String newUnitOwner = WtcUtil.repStr(request.getParameter("newUnitOwner"), "");
%>
	<wtc:service name="se205Cfm" routerKey="regionCode" routerValue="<%=regCode%>" retcode="retCode" retmsg="retMsg" outnum="7">
		<wtc:param value=""/>
		<wtc:param value=""/>
		<wtc:param value="<%=opCode%>"/> 
		<wtc:param value="<%=loginNo%>"/>
		<wtc:param value="<%=password%>"/> 
		<wtc:param value=""/>
		<wtc:param value=""/>
		<wtc:param value="<%=_getUnitId%>"/>
		<wtc:param value="<%=newUnitOwner%>"/>
	</wtc:service>
	<wtc:array id="ret"  scope="end"/>

var response = new AJAXPacket();
var retCode = "<%=ret[0][0]%>";
var retMsg = "<%=ret[0][1]%>";
response.data.add("retcode",retCode);
response.data.add("retmsg",retMsg);
core.ajax.receivePacket(response);
 
	    
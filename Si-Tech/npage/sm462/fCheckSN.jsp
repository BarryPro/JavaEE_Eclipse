<%
/*
* 功能: 
* 版本: 1.0
* 日期: liangyl 2017/02/18 liangyl 关于优化现有ONT管理系统的需求
* 作者: liangyl
* 版权: si-tech
*/
%>
<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%
	String regionCode= (String)session.getAttribute("regCode");
	String work_no = (String)session.getAttribute("workNo");
  	String password = (String)session.getAttribute("password");
	String snNumber = WtcUtil.repNull(request.getParameter("snNumber"));
%>
<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="phone" routerValue="<%=regionCode%>" id="sLoginAccept"/>
<wtc:service name="sJtKDOpenChk" routerKey="regionCode" routerValue="<%=regionCode%>" retcode="retCode" retmsg="retMsg"  outnum="1" >
	<wtc:param value="<%=sLoginAccept%>"/>
	<wtc:param value="01"/>
	<wtc:param value="4977"/>
	<wtc:param value="<%=work_no%>"/>
	<wtc:param value="<%=password%>"/>
	<wtc:param value="SN"/>
	<wtc:param value=""/>
	<wtc:param value="<%=snNumber%>"/>
</wtc:service>
<wtc:array id="result" scope="end"/>
var response = new AJAXPacket();
response.data.add("retcode","<%=retCode%>");
response.data.add("retmsg","<%=retMsg%>");
core.ajax.receivePacket(response);
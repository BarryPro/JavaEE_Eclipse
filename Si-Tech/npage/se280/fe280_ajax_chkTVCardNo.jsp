<%
    /*************************************
    * 功  能: 校验广电电视卡号+查询家庭业务的有线电视办理信息
    * 版  本: version v1.0
    * 开发商: si-tech
    * 创建者: diling @ 2014/11/25 
    **************************************/
%>
<%@ page contentType="text/html; charset=GB2312" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%
  String regCode=WtcUtil.repNull((String)session.getAttribute("regCode"));
  String loginNo= (String)session.getAttribute("workNo");
  String password = (String)session.getAttribute("password");
	String opCode = WtcUtil.repStr(request.getParameter("opCode"), "");
	String TVCardNo = WtcUtil.repStr(request.getParameter("TVCardNo"), "");//广电电视卡号
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
		<wtc:param value="0"/> <%/* 0-验证输入的有线电视卡号是否重复 1-查询相关信息*/%>
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
 
	    
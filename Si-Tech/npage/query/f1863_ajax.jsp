<%
  /*
   * 功能: 数据库信息表
   * 版本: 0.9
   * 日期: 2009/04/01
   * 作者: yanpx
   * 版权: si-tech
   * update:
   */
%>
<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%
	String regionCode 	= (String)session.getAttribute("regionCode");
	String loginNo			=	request.getParameter("loginNo");
	String phoneNo			=	request.getParameter("phoneNo");
	String ConnPhone		=	request.getParameter("ConnPhone");
	String OptType			=	request.getParameter("OptType");
	String SearchType		=	request.getParameter("SearchType");
	String SearchTime		=	request.getParameter("SearchTime");
	String DetType			=	request.getParameter("DetType");
	String WorkListNo		=	request.getParameter("WorkListNo");
	String ReasonText		=	request.getParameter("ReasonText");
	String voiceBillType    =   request.getParameter("voiceBillType");
%>
<wtc:service name="sSendRadomPWD" routerKey="region" routerValue="<%=regionCode%>"  retcode="retCode" retmsg="retMsg" outnum="2">
	 <wtc:param value="<%=loginNo%>"/>
	 <wtc:param value="<%=phoneNo%>"/>
	 <wtc:param value="<%=ConnPhone%>"/>
	 <wtc:param value="<%=OptType%>"/>
	 <wtc:param value="<%=SearchType%>"/>
	 <wtc:param value="<%=SearchTime%>"/>
	 <wtc:param value="<%=DetType%>"/>
	 <wtc:param value="<%=WorkListNo%>"/>
	 <wtc:param value="<%=ReasonText%>"/>
	 <wtc:param value="<%=voiceBillType%>"/>
</wtc:service>
<wtc:array id="result" scope="end" />
var response = new AJAXPacket();
var retCode  = "<%=retCode%>";
var retMsg   = "<%=retMsg%>";
response.data.add("retCode","<%=retCode%>");
response.data.add("retMsg" ,"<%=retMsg%>");
core.ajax.receivePacket(response);
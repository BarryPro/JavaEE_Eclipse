<%
    /*************************************
    * 功  能: 手机支付实名更新 e629
    * 版  本: version v1.0
    * 开发商: si-tech
    * 创建者: diling @ 2012-2-21
    **************************************/
%>
<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%
	String iPhoneNo = WtcUtil.repStr(request.getParameter("iPhoneNo"), "");
	String opCode=WtcUtil.repNull((String)request.getParameter("opCode"));
	String loginNo = WtcUtil.repStr(request.getParameter("loginNo"), "");
	String password = WtcUtil.repStr(request.getParameter("password"), "");
	String groupId = (String)session.getAttribute("groupId");
	String notes = "手机支付实名更新";
	
	//获取系统时间
  Date currentTime = new Date(); 
  java.text.SimpleDateFormat formatter = new java.text.SimpleDateFormat("yyyyMMddHHmmss");
  String currentTimeString = formatter.format(currentTime);
  System.out.println("系统时间="+currentTimeString);
%>
 <wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="phone" routerValue="<%=iPhoneNo%>" id="printAccept"/>
<%
	String printAcceptSub = printAccept.substring(0,6);
	System.out.println("------e629----------printAcceptSub="+printAcceptSub);
	String timeAndAccept = "451"+"BIP1C005"+ currentTimeString + printAcceptSub;
	System.out.println("------e629----------timeAndAccept="+timeAndAccept);
%>
	<wtc:service name="sProWorkFlowCfm" routerKey="phone" routerValue="<%=iPhoneNo%>" retcode="retCode" retmsg="retMsg" outnum="2">
		<wtc:param value="<%=printAccept%>"/>
		<wtc:param value="1"/>
		<wtc:param value="<%=opCode%>"/> 
		<wtc:param value="<%=loginNo%>"/>
		<wtc:param value="<%=password%>"/> 
		<wtc:param value="<%=iPhoneNo%>"/>
		<wtc:param value=""/>
		<wtc:param value="92"/>
		<wtc:param value="045101"/>
		<wtc:param value="ZY0102"/>
    <wtc:param value="22"/>
		<wtc:param value="<%=currentTimeString%>"/>
		<wtc:param value="20501231235959"/>
		<wtc:param value="<%=currentTimeString%>"/>
		<wtc:param value="<%=notes%>"/>
		<wtc:param value="<%=groupId%>"/>
		<wtc:param value="<%=timeAndAccept%>"/>
	</wtc:service>
	<wtc:array id="ret"  scope="end"/>
<%
 System.out.println("---e629----retCode="+retCode);
%>
var response = new AJAXPacket();
response.data.add("retcode","<%=retCode%>");
response.data.add("retmsg","<%=retMsg%>");
core.ajax.receivePacket(response);
 
	    
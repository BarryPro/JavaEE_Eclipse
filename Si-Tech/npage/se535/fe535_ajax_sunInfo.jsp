<%
    /*************************************
    * 功  能: 手机便民卡订购@退订提交页面 e535@e536
    * 版  本: version v1.0
    * 开发商: si-tech
    * 创建者: diling @ 2011-8-16
    **************************************/
%>
<%@ page contentType="text/html; charset=GB2312" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%
    String opCode=WtcUtil.repNull((String)request.getParameter("radioButtonVal"));
    String iPhoneNo=WtcUtil.repNull((String)request.getParameter("iPhoneNo"));
    String loginNo = WtcUtil.repNull((String)request.getParameter("loginNo"));
    String password = WtcUtil.repNull((String)request.getParameter("password"));
    String notes1 = "手机便民卡订购";
    String notes2 = "手机便民卡退订";
    String notes = "";
    if("e535".equals(opCode)){
        notes = notes1;
    }else if("e536".equals(opCode)){
         notes = notes2;
    }
    
    //获取系统时间
    Date currentTime = new Date(); 
    java.text.SimpleDateFormat formatter = new java.text.SimpleDateFormat("yyyyMMddHHmmss");
    String currentTimeString = formatter.format(currentTime);
    System.out.println("系统时间="+currentTimeString);
%>

    <wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="phone" routerValue="<%=iPhoneNo%>" id="printAccept"/>
    
	<wtc:service name="sProWorkFlowCfm" routerKey="phone" routerValue="<%=iPhoneNo%>" retcode="retCode" retmsg="retMsg" outnum="2">
		<wtc:param value="<%=printAccept%>"/>
		<wtc:param value="1"/>
		<wtc:param value="<%=opCode%>"/> 
		<wtc:param value="<%=loginNo%>"/>
		<wtc:param value="<%=password%>"/> 
		<wtc:param value="<%=iPhoneNo%>"/>
		<wtc:param value=""/>
		<wtc:param value="43"/>
		<wtc:param value="901900"/>
		<wtc:param value="-SJBMK"/>
<%
    if("e535".equals(opCode)){
%>
        <wtc:param value="01"/>
<%
    }else if("e536".equals(opCode)){
%>
        <wtc:param value="02"/>
<%
    }
%>
		<wtc:param value="<%=currentTimeString%>"/>
		<wtc:param value="20501231235959"/>
	    <wtc:param value="<%=currentTimeString%>"/>
	    <wtc:param value="<%=notes%>"/>
	</wtc:service>
	<wtc:array id="ret"  scope="end"/>
<%
 System.out.println("---e535----retCode="+retCode);
%>
var response = new AJAXPacket();
response.data.add("retcode","<%=retCode%>");
response.data.add("retmsg","<%=retMsg%>");
core.ajax.receivePacket(response);
 
	    
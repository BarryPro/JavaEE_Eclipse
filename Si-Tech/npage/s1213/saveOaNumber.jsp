<%
/*
* 功能: 
* 版本: 1.0
* 日期: liangyl 2017/04/02 liangyl 一体化 黑龙江移动一体化运营项目计划
* 作者: liangyl
* 版权: si-tech
*/
%>
<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%
	String orgCode = (String)session.getAttribute("orgCode");
	String regionCode = orgCode.substring(0,2);
	
    String iLoginAccept = request.getParameter("iLoginAccept");
    String iChnSource = request.getParameter("iChnSource");
	String iOpCode  = request.getParameter("iOpCode");
	String iLoginNo  = request.getParameter("iLoginNo");
	String iLoginPwd = request.getParameter("iLoginPwd");
	String iPhoneNo = request.getParameter("iPhoneNo");
	String iUserPwd = request.getParameter("iUserPwd");
	String iOANo = request.getParameter("iOANo");
	System.out.println(iLoginAccept);
	System.out.println(iChnSource);
	System.out.println(iOpCode);
	System.out.println(iLoginNo);
	System.out.println(iLoginPwd);
	System.out.println(iPhoneNo);
	System.out.println(iUserPwd);
	System.out.println(iOANo);
		
	String [] inputParam = new String [8] ;
	inputParam[0] = iLoginAccept;
	inputParam[1] = iChnSource;
	inputParam[2] = iOpCode;
	inputParam[3] = iLoginNo;
	inputParam[4] = iLoginPwd;
	inputParam[5] = iPhoneNo;
	inputParam[6] = iUserPwd;
	inputParam[7] = iOANo;
%>
<wtc:service name="sTestCardOpr" routerKey="region" retcode="retCode" retmsg="retMsg" routerValue="<%=regionCode%>" outnum="1" >
	<wtc:param value="<%=inputParam[0]%>"/>
	<wtc:param value="<%=inputParam[1]%>"/>
	<wtc:param value="<%=inputParam[2]%>"/>
	<wtc:param value="<%=inputParam[3]%>"/>
	<wtc:param value="<%=inputParam[4]%>"/>
	<wtc:param value="<%=inputParam[5]%>"/>
	<wtc:param value="<%=inputParam[6]%>"/>
	<wtc:param value="<%=inputParam[7]%>"/>
</wtc:service>
<wtc:array id="retResult" scope="end"/>
var response = new AJAXPacket();
response.data.add("errCode","<%=retCode%>");
response.data.add("errMsg","<%=retMsg%>");
core.ajax.receivePacket(response);
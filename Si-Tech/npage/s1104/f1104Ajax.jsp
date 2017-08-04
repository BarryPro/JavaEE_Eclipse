<%
    /********************
     version v2.0
     开发商: si-tech
     *服务：zhangzhea，掉用：gaopeng
     *2013/4/2 星期二 18:53:11 gaopeng 物联网liyana需求，公共服务
     *
     ********************/
%>
<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp"%>
<%
		String regionCode 			= (String)session.getAttribute("regCode");	
		
		String iLoginAccept 		=  request.getParameter("iLoginAccept");						//流水
		String iChnSource 		=  request.getParameter("iChnSource");						//流水
		String iOpCode 		=  request.getParameter("iOpCode");						//流水
		String iLoginNo 		=  request.getParameter("iLoginNo");						//流水
		String iLoginPwd 		=  request.getParameter("iLoginPwd");						//流水
		
		String iPhoneNo 		=  request.getParameter("iPhoneNo");						//流水
		String iUserPwd 		=  request.getParameter("iUserPwd");						//流水
		String iOfferId 		=  request.getParameter("iOfferId");						//流水
		String iOfferIdStr 		=  request.getParameter("iOfferIdStr");						//流水
		String iOfferStateStr 		=  request.getParameter("iOfferStateStr");						//流水
		
		String iFlagStr 		=  request.getParameter("iFlagStr");						//流水

%>                   		
		<wtc:service name="sWLWOffCheck" routerKey="regionCode" routerValue="<%=regionCode%>" retcode="errCode1" retmsg="errMsg1"  outnum="2">
			<wtc:param value="<%=iLoginAccept%>"/>
			<wtc:param value="<%=iChnSource%>"/>
			<wtc:param value="<%=iOpCode%>"/>
			<wtc:param value="<%=iLoginNo%>"/>
			<wtc:param value="<%=iLoginPwd%>"/>
				
			<wtc:param value="<%=iPhoneNo%>"/>
			<wtc:param value="<%=iUserPwd%>"/>
			<wtc:param value="<%=iOfferIdStr%>"/>
			<wtc:param value="<%=iFlagStr%>"/>
			<wtc:param value="<%=iOfferStateStr%>"/>	

		</wtc:service>
		<wtc:array id="result1" scope="end"/>
<%
    String errCode = errCode1;
    String errMsg = errMsg1;
%>
var response = new AJAXPacket();
response.data.add("oRetCode","<%=errCode%>");
response.data.add("oRetMsg","<%=errMsg%>");
core.ajax.receivePacket(response);

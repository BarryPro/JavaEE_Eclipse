<%
    /********************
     version v2.0
     ������: si-tech
     *����zhangzhea�����ã�gaopeng
     *2013/4/2 ���ڶ� 18:53:11 gaopeng ������liyana���󣬹�������
     *
     ********************/
%>
<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp"%>
<%
		String regionCode 			= (String)session.getAttribute("regCode");	
		
		String iLoginAccept 		=  request.getParameter("iLoginAccept");						//��ˮ
		String iChnSource 		=  request.getParameter("iChnSource");						//��ˮ
		String iOpCode 		=  request.getParameter("iOpCode");						//��ˮ
		String iLoginNo 		=  request.getParameter("iLoginNo");						//��ˮ
		String iLoginPwd 		=  request.getParameter("iLoginPwd");						//��ˮ
		
		String iPhoneNo 		=  request.getParameter("iPhoneNo");						//��ˮ
		String iUserPwd 		=  request.getParameter("iUserPwd");						//��ˮ
		String iOfferId 		=  request.getParameter("iOfferId");						//��ˮ
		String iOfferIdStr 		=  request.getParameter("iOfferIdStr");						//��ˮ
		String iOfferStateStr 		=  request.getParameter("iOfferStateStr");						//��ˮ
		
		String iFlagStr 		=  request.getParameter("iFlagStr");						//��ˮ

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

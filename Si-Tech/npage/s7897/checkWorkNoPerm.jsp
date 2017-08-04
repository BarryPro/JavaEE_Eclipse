<%
/********************
 * version v2.0
 * 开发商: si-tech
 * update by qidp @ 2009-10-19
 ********************/
%>

<% request.setCharacterEncoding("GBK");%>
<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>


<%
    String workNo = WtcUtil.repNull((String)session.getAttribute("workNo"));
    String workPwd = WtcUtil.repNull((String)session.getAttribute("password"));
    String regionCode = WtcUtil.repNull((String)session.getAttribute("regCode"));
    
	String iSmCode = WtcUtil.repNull((String)request.getParameter("smCode"));
	String iOpType = WtcUtil.repNull((String)request.getParameter("opType"));
	String iRequestType = WtcUtil.repNull((String)request.getParameter("reqeustType"));
	String iProductId = WtcUtil.repNull((String)request.getParameter("productId"));
	String iCustId = WtcUtil.repNull((String)request.getParameter("custId"));
	String iIdNo = WtcUtil.repNull((String)request.getParameter("idNo"));

    String errCode = "";
    String errMsg = "";
    
    try{
        %>
            <wtc:service name="sCheckLogin" routerKey="region" routerValue="<%=regionCode%>" retcode="sCheckLoginCode" retmsg="sCheckLoginMsg" outnum="2" >
            	<wtc:param value="<%=workNo%>"/>
            	<wtc:param value="<%=workPwd%>"/> 
                <wtc:param value="<%=iSmCode%>"/>
                <wtc:param value="<%=iOpType%>"/>
                <wtc:param value="<%=iRequestType%>"/>
                <wtc:param value="<%=iProductId%>"/>
                <wtc:param value="<%=iCustId%>"/>
                <wtc:param value="<%=iIdNo%>"/>
            </wtc:service>
        <%
        errCode = sCheckLoginCode;
        errMsg = sCheckLoginMsg;
    }catch(Exception e){
        e.printStackTrace();
        errCode = "999999";
        errMsg = "调用服务sGetPhoneInfo失败！";
    }
%>

var response = new AJAXPacket();
var returnCode = "<%=errCode%>";
var returnMessage = "<%=errMsg%>";
response.data.add("retCode",returnCode);
response.data.add("retMsg",returnMessage);
core.ajax.receivePacket(response);

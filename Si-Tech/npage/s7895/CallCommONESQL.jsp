 <%
	/********************
	 version v2.0
	开发商: si-tech
	update:anln@2009-01-14 页面改造,修改样式
	********************/
%> 

<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>

<%
	String regionCode = WtcUtil.repNull((String)session.getAttribute("regCode"));
	
    String verifyType = request.getParameter("verifyType");
    String iIdNo = WtcUtil.repNull((String)request.getParameter("idNo"));
    String iAddNo = WtcUtil.repNull((String)request.getParameter("addNo"));
    String iProductId = WtcUtil.repNull((String)request.getParameter("productId"));
    String iNoType = WtcUtil.repNull((String)request.getParameter("noType"));
    
    String errorCode = "";
    String errorMsg  = "";
    try{
    %>
        <wtc:service name="verifyMebNo" retcode="retCode" retmsg="retMsg" outnum="2" routerKey="region" routerValue="<%=regionCode%>">
        	<wtc:param value="<%=iNoType%>"/>
        	<wtc:param value="<%=iAddNo%>"/> 
            <wtc:param value="<%=iIdNo%>"/> 
            <wtc:param value="<%=iProductId%>"/> 
        </wtc:service>
        <wtc:array id="retArr" scope="end"/>
    <%
        errorCode = retCode;
        errorMsg  = retMsg ;
    }catch(Exception e){
        e.printStackTrace();
        errorCode = "999999";
        errorMsg  = "调用服务verifyMebNo失败！";
    }
%>
var response = new AJAXPacket();
response.data.add("verifyType","<%= verifyType %>");
response.data.add("errorCode","<%= errorCode %>");
response.data.add("errorMsg","<%= errorMsg %>");
core.ajax.receivePacket(response);



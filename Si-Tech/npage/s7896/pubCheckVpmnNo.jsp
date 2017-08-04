<%
/********************
 * version v2.0
 * 开发商: si-tech
 * update by qidp @ 2009-11-07
 ********************/
%>
<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>

<%
    String regionCode = WtcUtil.repNull((String)session.getAttribute("regCode"));
    
    String iServiceNo = WtcUtil.repNull((String)request.getParameter("serviceNo"));
    String iIdNo = WtcUtil.repNull((String)request.getParameter("idNo"));
    String iProductId = WtcUtil.repNull((String)request.getParameter("productId"));
    String iRealNo = WtcUtil.repNull((String)request.getParameter("realNo"));
    String iShortNo = WtcUtil.repNull((String)request.getParameter("shortNo"));
    
    String retCode = "";
    String retMessage = "";
    String oNoType  = "";
    String updateNoType = WtcUtil.repNull((String)request.getParameter("updateNoType"));
    
	try{
%>
    <wtc:service name="sCheckVpmnNo" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode2" retmsg="retMsg2" outnum="1" >
        <wtc:param value="<%=iServiceNo%>"/>
    	<wtc:param value="<%=iIdNo%>"/>
    	<wtc:param value="<%=iProductId%>"/>
        <wtc:param value="<%=iRealNo%>"/>
        <wtc:param value="<%=iShortNo%>"/>
        <wtc:param value="<%=updateNoType%>"/>
    </wtc:service>
    <wtc:array id="result" scope="end"/>
<%
        retCode = retCode2;
        retMessage = retMsg2;
        if(result.length>0){
            oNoType = result[0][0];
        }
    }catch(Exception e){
        e.printStackTrace();
        retCode="999999";
        retMessage="调用服务sCheckVpmnNo失败！";
    }
%>
var response = new AJAXPacket();
var retMessage="<%=retMessage%>";
var retCode= "<%=retCode%>";
var vNoType = "<%=oNoType%>";

response.data.add("retCode",retCode);
response.data.add("retMsg",retMessage);
response.data.add("noType",vNoType);
core.ajax.receivePacket(response);

<%
/********************
 * version v2.0
 * 开发商: si-tech
 * update by qidp @ 2009-10-30
 ********************/
%>
<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>

<%
    String regionCode       = WtcUtil.repNull((String)session.getAttribute("regCode"));
    
    String iIdNo            = WtcUtil.repNull((String)request.getParameter("idNo"));
    String iLoginAccept     = WtcUtil.repNull((String)request.getParameter("loginAccept"));
    String iChildAccept     = WtcUtil.repNull((String)request.getParameter("childAccept"));
    String iBtnId           = WtcUtil.repNull((String)request.getParameter("btnId"));
    
    String errCode = "";
    String errMsg = "";
    
    try{
    %>
        <wtc:service name="sDL100Cfm" retcode="retCode" retmsg="retMsg" outnum="2" routerKey="region" routerValue="<%=regionCode%>">
        	<wtc:param value="<%=iIdNo%>"/>
        	<wtc:param value="<%=iLoginAccept%>"/> 
        	<wtc:param value="<%=iChildAccept%>"/> 
        </wtc:service>
        <wtc:array id="retArr" scope="end"/>
    <%
        errCode = retCode;
        errMsg = retMsg;
    }catch(Exception e){
        errCode = "999999";
        errMsg = "调用服务sDL100Cfm失败！";
        e.printStackTrace();
    }
%>
var response = new AJAXPacket();
var vRetCode = "<%=errCode%>";
var vRetMsg  = "<%=errMsg%>";
var vBtnId   = "<%=iBtnId%>";

response.data.add("retCode",vRetCode);
response.data.add("retMsg",vRetMsg);
response.data.add("btnId",vBtnId);

core.ajax.receivePacket(response);

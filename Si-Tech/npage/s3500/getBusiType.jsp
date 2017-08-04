<%
/********************
 * CopyRight: si-tech
 * Author   : qidp
 * Date     : 2009-11-18
 ********************/
%>
<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>

<%
    String regionCode = WtcUtil.repNull((String)session.getAttribute("regCode"));
    String iSmCode = WtcUtil.repNull((String)request.getParameter("smCode"));
    String sqlStr = "";
    
    String returnCode = "";
    String returnMessage = "";
    
    String oBusiType = "";
    String oBusiName = "";
    
    try{
        sqlStr = "select a.busi_type,b.busi_name from sbusitypesmcode a,suserbusitype b  where a.sm_code = '"+iSmCode+"' and a.busi_type=b.busi_type";
    %>
        <wtc:pubselect name="sPubSelect" retcode="retCode" retmsg="retMsg" outnum="2" routerKey="region" routerValue="<%=regionCode%>">
        	<wtc:sql><%=sqlStr%></wtc:sql>
        </wtc:pubselect>
        <wtc:array id="retArr" scope="end"/>
    <%
        returnCode = retCode;
        returnMessage = retMsg;
        
        if("000000".equals(returnCode) && retArr.length>0){
            oBusiType = retArr[0][0];
            oBusiName = retArr[0][1];
        }
    }catch(Exception e){
        returnCode = "999999";
        returnMessage = "调用服务sPubSelect失败！";
        e.printStackTrace();
    }
%>
var response = new AJAXPacket();
var retCode = "<%=returnCode%>";
var retMessage = "<%=returnMessage%>";
var vBusiType = "<%=oBusiType%>";
var vBusiName = "<%=oBusiName%>";

response.data.add("retCode",retCode);
response.data.add("retMessage",retMessage);
response.data.add("busiType",vBusiType);
response.data.add("busiName",vBusiName);
core.ajax.receivePacket(response);


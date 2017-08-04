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
    String workPwd = WtcUtil.repNull((String)session.getAttribute("password"));

    String iWorkNo = WtcUtil.repNull((String)request.getParameter("workNo"));
    String iOpCode = WtcUtil.repNull((String)request.getParameter("opCode"));
    String iIdNo = WtcUtil.repNull((String)request.getParameter("idNo"));
    String iSmCode = WtcUtil.repNull((String)request.getParameter("smCode"));
    String iProductId = WtcUtil.repNull((String)request.getParameter("productId"));
    String iSinglePhoneNo = WtcUtil.repNull((String)request.getParameter("singlePhoneNo"));
    String iRequestType = WtcUtil.repNull((String)request.getParameter("requestType"));
    
    String retCode = "";
    String retMessage = "";
    int phoneNoNum = 0;
    String memberUse = "";
    String singlePhoneno  = "";
    
    String sqlStr = "";
	try{
%>
    <wtc:service name="sGetPhoneInfo" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode2" retmsg="retMsg2" outnum="3" >
    	<wtc:param value="0"/>
    	<wtc:param value=""/>
    	<wtc:param value="<%=iOpCode%>"/>
    	<wtc:param value="<%=iWorkNo%>"/>
    	<wtc:param value="<%=workPwd%>"/>
    	<wtc:param value="<%=iSinglePhoneNo%>"/>
    	<wtc:param value=""/>
        <wtc:param value="<%=iIdNo%>"/>
        <wtc:param value="<%=iSmCode%>"/>
        <wtc:param value="<%=iProductId%>"/>
        <wtc:param value="m02"/>
        <wtc:param value="<%=iRequestType%>"/>
    </wtc:service>
    <wtc:array id="result" scope="end"/>
<%
        retCode = retCode2;
        retMessage = retMsg2;
        if("000000".equals(retCode)){
            if(result.length>0){
                phoneNoNum = result.length;
                memberUse = result[0][0];
                singlePhoneno = result[0][1];
            }else{
                phoneNoNum = 0;
            }
        }
    }catch(Exception e){
        e.printStackTrace();
        retCode="999999";
        retMessage="查询集团成员信息失败！";
    }
%>
var response = new AJAXPacket();
var retMessage="<%=retMessage%>";
var retCode= "<%=retCode%>";
var vPhoneNoNum = "<%=phoneNoNum%>";
var vMemberUse = "<%=memberUse%>";
var vSinglePhoneno = "<%=singlePhoneno%>";

response.data.add("retCode",retCode);
response.data.add("retMessage",retMessage);
response.data.add("retPhoneNoNum",vPhoneNoNum);
response.data.add("retMemberUse",vMemberUse);
response.data.add("retSinglePhoneno",vSinglePhoneno);
core.ajax.receivePacket(response);

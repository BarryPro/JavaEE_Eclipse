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
    String iServiceNo = WtcUtil.repNull((String)request.getParameter("serviceNo"));
    String iRegionCode = WtcUtil.repNull((String)request.getParameter("regionCode"));
    String iSinglePhoneNo = WtcUtil.repNull((String)request.getParameter("singlePhoneNo"));
    String iRequestType = WtcUtil.repNull((String)request.getParameter("requestType"));
    
    String retCode = "";
    String retMessage = "";
    int phoneNoNum = 0;
    String memberUse = "";
    String singlePhoneno  = "";
    String singlephoneTypes="";
    String oldofferisds="";
    String oldoffernamesd="";
    
    String sqlStr = "";
	try{

%>
    <wtc:service name="sGetPhoneInfo" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode2" retmsg="retMsg2" outnum="6" >
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
        <wtc:param value="m08"/>
        <wtc:param value="<%=iRequestType%>"/>
    </wtc:service>
    <wtc:array id="result" scope="end"/>
<%
System.out.println("# result = "+result.length);
        retCode = retCode2;
        retMessage = retMsg2;
        if("000000".equals(retCode)){
            if(result.length>0){
                phoneNoNum = result.length;
                memberUse = result[0][0];
                singlePhoneno = result[0][1];
                singlephoneTypes = result[0][3];
                oldofferisds=result[0][4];
                oldoffernamesd=result[0][5];
            }else{
                phoneNoNum = 0;
            }
        }
    }catch(Exception e){
        e.printStackTrace();
        retCode="999999";
        retMessage="查询集团成员信息失败！";
    }
    System.out.println("# phoneNoNum = "+phoneNoNum);
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
response.data.add("singlephoneTypes",'<%=singlephoneTypes%>');
response.data.add("oldofferisds",'<%=oldofferisds%>');
response.data.add("oldoffernamesd",'<%=oldoffernamesd%>');
core.ajax.receivePacket(response);

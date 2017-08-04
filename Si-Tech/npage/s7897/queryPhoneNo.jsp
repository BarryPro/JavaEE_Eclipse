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
    String regionCode = WtcUtil.repNull((String)session.getAttribute("regCode"));
    String workPwd = WtcUtil.repNull((String)session.getAttribute("password"));
    
    String iPhoneNo = WtcUtil.repNull((String)request.getParameter("phoneNo"));
	String iSmCode = WtcUtil.repNull((String)request.getParameter("smCode"));
	String iGrpIdNo = WtcUtil.repNull((String)request.getParameter("grpIdNo"));
	String iOpCode = WtcUtil.repNull((String)request.getParameter("opCode"));
	String iWorkNo = WtcUtil.repNull((String)request.getParameter("workNo"));
	String iProductId = WtcUtil.repNull((String)request.getParameter("productId"));
	String requestType = WtcUtil.repNull((String)request.getParameter("requestType"));

    String oUserIdNo = "";
    String oSmCode = "";
    String oSmName = "";
    String oCustName = "";
    String oUserPwd = "";
    String oMainRate = "";
    String oMainRateName = "";
    String oRunCode = "";
    String oRunNameErr = "";
    String oIccid = "";
    String oCustAddr = "";
    
    String errCode = "";
    String errMsg = "";
    
    try
    {
    %>
        <wtc:service name="sGetPhoneInfo" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode" retmsg="retMsg" outnum="11" >
        	<wtc:param value="0"/>
    	<wtc:param value=""/>
    	<wtc:param value="<%=iOpCode%>"/>
    	<wtc:param value="<%=iWorkNo%>"/>
    	<wtc:param value="<%=workPwd%>"/>
    	<wtc:param value="<%=iPhoneNo%>"/>
    	<wtc:param value=""/>
     	<wtc:param value="<%=iGrpIdNo%>"/>
            <wtc:param value="<%=iSmCode%>"/>
            <wtc:param value="<%=iProductId%>"/>
            <wtc:param value="m03"/>
            <wtc:param value="<%=requestType%>"/>
        </wtc:service>
        <wtc:array id="retArr" scope="end"/>
    <%
        errCode = retCode;
        errMsg = retMsg;
        if("000000".equals(errCode)){
            if(retArr.length>0){
                oUserIdNo = retArr[0][0];
                oSmCode = retArr[0][1];
                oSmName = retArr[0][2];
                oCustName = retArr[0][3];
                oUserPwd = retArr[0][4];
                oMainRate = retArr[0][5];
                oMainRateName = retArr[0][6];
                oRunCode = retArr[0][7];
                oRunNameErr = retArr[0][8];
                oIccid = retArr[0][9];
                oCustAddr = retArr[0][10];
            }else{
                errCode = "999998";
                errMsg = "没有此成员信息！";
            }
        }
    }catch(Exception e){
        e.printStackTrace();
        errCode = "999999";
        errMsg = "调用服务sGetPhoneInfo失败！";
    }
%>

var response = new AJAXPacket();
var vUserIdNo = "<%=oUserIdNo%>";
var vSmCode = "<%=oSmCode%>";
var vSmName = "<%=oSmName%>";
var vCustName = "<%=oCustName%>";
var vUserPwd = "<%=oUserPwd%>";
var vMainRate = "<%=oMainRate%>";
var vMainRateName = "<%=oMainRateName%>";
var vRunCode = "<%=oRunCode%>";
var vRunNameErr = "<%=oRunNameErr%>";
var vIccid = "<%=oIccid%>";
var vCustAddr = "<%=oCustAddr%>";

var returnCode = "<%=errCode%>";
var returnMessage = "<%=errMsg%>";

response.data.add("retCode",returnCode);
response.data.add("retMsg",returnMessage);
response.data.add("userIdNo",vUserIdNo);
response.data.add("smCode",vSmCode);
response.data.add("smName",vSmName);
response.data.add("custName",vCustName);
response.data.add("userPwd",vUserPwd);
response.data.add("mainRate",vMainRate);
response.data.add("mainRateName",vMainRateName);
response.data.add("runCode",vRunCode);
response.data.add("runNameErr",vRunNameErr);
response.data.add("iccid",vIccid);
response.data.add("custAddr",vCustAddr);

core.ajax.receivePacket(response);

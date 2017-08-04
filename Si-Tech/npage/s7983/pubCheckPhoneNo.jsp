<%
/********************
 * version v2.0
 * 开发商: si-tech
 * update by qidp @ 2009-01-13
 ********************/
%>
<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%
    String regionCode = WtcUtil.repNull((String)session.getAttribute("regCode"));
    
    String retType = WtcUtil.repNull((String)request.getParameter("retType"));
    String iLoginNo = WtcUtil.repNull((String)request.getParameter("loginNo"));
    String iLoginPwd = WtcUtil.repNull((String)request.getParameter("loginPwd"));
    String iOpCode = WtcUtil.repNull((String)request.getParameter("opCode"));
    String iOrgCode = WtcUtil.repNull((String)request.getParameter("orgCode"));
    String iGrpIdNo = WtcUtil.repNull((String)request.getParameter("grpIdNo"));
    String iPhoneNo = WtcUtil.repNull((String)request.getParameter("phoneNo"));
    String iProductId = WtcUtil.repNull((String)request.getParameter("productId"));
    String iSmCode = WtcUtil.repNull((String)request.getParameter("smCode"));
    String iRequestType = WtcUtil.repNull((String)request.getParameter("requestType"));
    
    String returnCode = "";
    String returnMsg = "";
    String[][] retArray = new String[][]{};//wnagzn add 2011/6/8 17:14:03
    try{
        %>
        <wtc:service name="sCheckPhoneNo" outnum="8" retcode="retCode" retmsg="retMsg" routerKey="region" routerValue="<%=regionCode%>">
            <wtc:param value="<%=iLoginNo%>"/>
            <wtc:param value="<%=iLoginPwd%>"/>
            <wtc:param value="<%=iOpCode%>"/>
            <wtc:param value="<%=iOrgCode%>"/>
            <wtc:param value="<%=iGrpIdNo%>"/>
            <wtc:param value="<%=iPhoneNo%>"/>
            <wtc:param value="<%=iProductId%>"/>
            <wtc:param value="<%=iSmCode%>"/>
            <wtc:param value="<%=iRequestType%>"/>
        </wtc:service>
		<wtc:array id="retArr" scope="end"/>
        <%
        returnCode = retCode;
        returnMsg = retMsg;
        System.out.println("# return from pubCheckPhoneNo.jsp by Service sCheckPhoneNo -> returnCode = "+retCode);
        System.out.println("# return from pubCheckPhoneNo.jsp by Service sCheckPhoneNo -> returnMsg  = "+retMsg);
        System.out.println("# retArr is  " + retArr);
        if("000000".equals(retCode))
        {
        	retArray = retArr;
        }
    }catch(Exception e){
        returnCode = "999999";
        returnMsg = "调用服务sCheckPhoneNo失败！";
        e.printStackTrace();
    }

%>
var response = new AJAXPacket();
var retType = "<%=retType%>";
var returnCode = "<%=returnCode%>";
var returnMessage = "<%=returnMsg%>";
var returnIdNo = "";
var postCode = "";
var IMPI = "";
var IMPUList = "";
var sCtShortNo  ="";
var sUserType   ="";
var PortalName  ="";
var PortalPass  ="";





<%
if(retArray.length>0)
{
System.out.println("@:***"+retArray[0][0]+"***");
System.out.println("@:***"+retArray[0][1]+"***");
System.out.println("@:***"+retArray[0][2]+"***");
System.out.println("@:***"+retArray[0][3]+"***");
%>
returnIdNo = '<%=retArray[0][0]%>';
postCode = '<%=retArray[0][1]%>';
IMPI = '<%=retArray[0][2]%>';
IMPUList = '<%=retArray[0][3]%>';
sCtShortNo  ='<%=retArray[0][4]%>';
sUserType   ='<%=retArray[0][5]%>';
PortalName  ='<%=retArray[0][6]%>';
PortalPass  ='<%=retArray[0][7]%>';
<%}%>

response.data.add("retType",retType);
response.data.add("retCode",returnCode);
response.data.add("retMessage",returnMessage);
response.data.add("returnIdNo",returnIdNo);
response.data.add("postCode",postCode);
response.data.add("IMPI",IMPI);
response.data.add("IMPUList",IMPUList);
response.data.add("sCtShortNo",sCtShortNo);
response.data.add("sUserType", sUserType );
response.data.add("PortalName",PortalName);
response.data.add("PortalPass",PortalPass);
core.ajax.receivePacket(response);

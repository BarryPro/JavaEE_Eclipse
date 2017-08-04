<%
/********************
 version v2.0
 开发商: si-tech
 update hejw@2009-1-16
********************/
%>

<%@ page contentType= "text/html;charset=gb2312" %>
 <%@ include file="/npage/include/public_title_ajax.jsp" %> 
<%@ page import="java.io.*" %>
<%@ page import="com.sitech.boss.pub.util.Encrypt"%>

<%
	String regionCode = (String)session.getAttribute("regCode");

	//得到输入参数
	String loginNo = request.getParameter("loginNo");
	String phoneNo = request.getParameter("phoneNo");
	String opCode = request.getParameter("opCode");
	String grpIdNo = request.getParameter("grpIdNo");
	String retType = request.getParameter("retType");
	String[][] retStr = new String[][]{};
	String retResult  = "false";
	String retCode="000000";
	String retMessage="";

	String[] paramsIn = new String[4];

    paramsIn[0]=loginNo;
    paramsIn[1]=phoneNo;
    paramsIn[2]=opCode;
    paramsIn[3]=grpIdNo;
	try
	{
%>

    <wtc:service name="s3603Init" outnum="9" retmsg="msg1" retcode="code1" routerKey="region" routerValue="<%=regionCode%>">
			<wtc:params value="<%=paramsIn%>" />
		</wtc:service>
		<wtc:array id="result_t" scope="end" />

<%        //retStr = callView.callService("s3603Init", paramsIn, "9", "region", regionCode);
        
        //System.out.println("--------------result_t--------------hjw"+result_t.length);
        
        retStr = result_t;
        retCode = code1;
        retMessage = msg1;
        if (retCode.equals("000000"))
        {
        	retResult  = "true";
        	retCode  = "000000";
        }
    	else
    	{
    		retResult  = "false";
    	}

	}
	catch(Exception e)
	{
		e.printStackTrace();
		retCode="100002";
		retMessage="密码校验失败！";
	}
%>
var response = new AJAXPacket();
var retType = "<%=retType%>";
var retMessage="<%=retMessage%>";
var retCode= "<%=retCode%>";
var retResult = "<%=retResult%>";

response.data.add("retType",retType);
response.data.add("retResult",retResult);
response.data.add("retCode",retCode);
response.data.add("retMessage",retMessage);
<%
    if (retCode.equals("000000"))
	{
%>
		response.data.add("idNo","<%=retStr[0][0]%>");
		response.data.add("smCode","<%=retStr[0][1]%>");
		response.data.add("smName","<%=retStr[0][2]%>");
		response.data.add("custName","<%=retStr[0][3]%>");
		response.data.add("userPwd","<%=retStr[0][4]%>");
		response.data.add("mainRate","<%=retStr[0][5]%>");
		response.data.add("mainRateName","<%=retStr[0][6]%>");
		response.data.add("runCode","<%=retStr[0][7]%>");
		response.data.add("runName","<%=retStr[0][8]%>");
<%
	}
%>
core.ajax.receivePacket(response);

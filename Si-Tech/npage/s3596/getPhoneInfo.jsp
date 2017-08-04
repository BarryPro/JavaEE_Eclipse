<%
/********************
 version v2.0
 开发商: si-tech
  wuxy@2009-4-19
********************/
%>

<%@ page contentType= "text/html;charset=GBK" %>
 <%@ include file="/npage/include/public_title_ajax.jsp" %> 
<%@ page import="java.io.*" %>
<%@ page import="com.sitech.boss.pub.util.Encrypt"%>

<%
	String regionCode = (String)session.getAttribute("regCode");

	//得到输入参数
	String loginNo = request.getParameter("loginNo");
	String phoneNo = request.getParameter("phoneNo");
	String opCode = request.getParameter("opCode");
	String retType = request.getParameter("retType");
	String[][] retStr = new String[][]{};
	String retResult  = "false";
	String retCode="000000";
	String retMessage="";
	
	System.out.println("phoneNo="+phoneNo);
	System.out.println("loginNo="+loginNo);
	System.out.println("opCode="+opCode);
	

	String[] paramsIn = new String[4];

    paramsIn[0]=loginNo;
    paramsIn[1]=phoneNo;
    paramsIn[2]=opCode;
	try
	{
%>

	<wtc:service name="s3596InitEXC" outnum="12" retmsg="msg1" retcode="code1" routerKey="region" routerValue="<%=regionCode%>">
		<wtc:param value="<%=loginNo%>" />
		<wtc:param value="<%=phoneNo%>" />
		<wtc:param value="<%=opCode%>" />
	</wtc:service>
	<wtc:array id="result_t" scope="end" />

<%       
        
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
		retMessage="获取用户资料失败！";
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
		
		response.data.add("custName","<%=retStr[0][0]%>");
		response.data.add("runState","<%=retStr[0][1]%>");
		response.data.add("vregionCode","<%=retStr[0][2]%>");
		response.data.add("vCustAddresee","<%=retStr[0][3]%>");
		response.data.add("vIdIccid","<%=retStr[0][4]%>");
		response.data.add("vSmName","<%=retStr[0][5]%>");
		
<%
	}
%>
core.ajax.receivePacket(response);

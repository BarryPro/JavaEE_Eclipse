<%
/********************
 version v2.0
开发商: si-tech
********************/
%>

<%@ page contentType= "text/html;charset=gbk" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>

<%
	String regionCode = (String)session.getAttribute("regCode");		//归属代码
	//得到输入参数
	String loginNo = request.getParameter("loginNo");					//操作工号
	String phoneNo = request.getParameter("phoneNo");					//手机号码
	String opCode = request.getParameter("opCode");						//操作代码
	String grpIdNo = request.getParameter("grpIdNo");					//集团用户ID
	String retType = request.getParameter("retType");					//返回类型
    	ArrayList paramsIn = new ArrayList();
//	String[] retStr = null;
//	SPubCallSvrImpl callView = new SPubCallSvrImpl();
	String retResult  = "false";
	String retCode="000000";
	String retMessage="";

    paramsIn.add(new String[]{loginNo});
    paramsIn.add(new String[]{phoneNo});
    paramsIn.add(new String[]{opCode});
    paramsIn.add(new String[]{grpIdNo});
	
//        retStr = callView.callService("s2903Init", paramsIn, "11", "region", regionCode);
//		callView.printRetValue();
%>
	<wtc:service name="s2903Init" routerKey="region" routerValue="<%=regionCode%>" outnum="11" retcode="retCode1" retmsg="retMsg1">
		<wtc:param value="<%=loginNo%>"/>
		<wtc:param value="<%=phoneNo%>"/>
		<wtc:param value="<%=opCode%>"/>
		<wtc:param value="<%=grpIdNo%>"/>
	</wtc:service>
	<wtc:array id="retStr" scope="end"/>
<%
        retCode = retCode1;
        retMessage= retMsg1;
        if (retCode.equals("000000"))
        {
        	retResult  = "true";
        }
    	else
    	{
    		retResult  = "false";
    	}
    	if (retStr != null&&retStr.length>0)
    	{
	    	for (int i = 0; i < retStr[0].length; i ++)
	    	{
	    		System.out.println("retStr[0][" + i + "]=[" + retStr[0][i] + "]");
	    	}
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
    if (retCode.equals("000000")&retStr.length>0)
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
		response.data.add("id_iccid","<%=retStr[0][9]%>");
		response.data.add("cust_address","<%=retStr[0][10]%>");
<%
	}
%>
core.ajax.receivePacket(response);

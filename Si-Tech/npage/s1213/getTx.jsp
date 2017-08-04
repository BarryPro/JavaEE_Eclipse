<%
/********************
 -->>描述创建人、时间、模块的功能
 -------------------------创建-----------梁有亮(lingyl) 2016-8-15 14:24:38-------------------
 
 -------------------------后台人员：zuolf--------------------------------------------
********************/
%>
<%@ page contentType="text/html;charset=GB2312"%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%

	String iLoginAccept = WtcUtil.repNull(request.getParameter("iLoginAccept"));
	String iChnSource = WtcUtil.repNull(request.getParameter("iChnSource"));
	String iOpCode = WtcUtil.repNull(request.getParameter("iOpCode"));
	String iLoginNo = WtcUtil.repNull(request.getParameter("iLoginNo"));
	String iLoginPwd = WtcUtil.repNull(request.getParameter("iLoginPwd"));
	String iPhoneNo = WtcUtil.repNull(request.getParameter("iPhoneNo"));
	String iUserPwd = WtcUtil.repNull(request.getParameter("iUserPwd"));
	
	String regionCode = (String)session.getAttribute("regCode");
	String promptPhoneNo="";
	System.out.println("liangyl~~~~~~~~~~~~"+iLoginAccept);
	System.out.println("liangyl~~~~~~~~~~~~"+iChnSource);
	System.out.println("liangyl~~~~~~~~~~~~"+iOpCode);
	System.out.println("liangyl~~~~~~~~~~~~"+iLoginNo);
	System.out.println("liangyl~~~~~~~~~~~~"+iLoginPwd);
	System.out.println("liangyl~~~~~~~~~~~~"+iPhoneNo);
	System.out.println("liangyl~~~~~~~~~~~~"+iUserPwd);
	
	
	String retCode    = "";
	String retMsg     = "";
	
	//7个标准化入参
	String paraAray[] = new String[8];
	
	paraAray[0] = iLoginAccept;                                       //流水
	paraAray[1] = iChnSource;                                     //渠道代码
	paraAray[2] = iOpCode;                                   //操作代码
	paraAray[3] = iLoginNo;   //工号
	paraAray[4] = iLoginPwd; //工号密码
	paraAray[5] = iPhoneNo;                                  //用户号码
	paraAray[6] = iUserPwd;                                       //备注
	paraAray[7] = ""; 

	String serverName = "sG072Qry";
try{
%>
		<wtc:service name="<%=serverName%>" outnum="2" retmsg="msg" retcode="code" routerKey="region" routerValue="<%=regionCode%>">
			<wtc:param value="<%=paraAray[0]%>" />
			<wtc:param value="<%=paraAray[1]%>" />
			<wtc:param value="<%=paraAray[2]%>" />
			<wtc:param value="<%=paraAray[3]%>" />
			<wtc:param value="<%=paraAray[4]%>" />
			<wtc:param value="<%=paraAray[5]%>" />
			<wtc:param value="<%=paraAray[6]%>" />						
			<wtc:param value="<%=paraAray[7]%>" />						
		</wtc:service>
		<wtc:array id="serverResult" scope="end"  />
<%
	retCode = code;
	retMsg = msg;
	if("000000".equals(retCode)){//操作成功
		promptPhoneNo=serverResult[0][1];
    }
	
}catch(Exception ex){
	retCode = "404040";
	retMsg = "调用服务"+serverName+"出错，请联系管理员";
}

%> 	
var response = new AJAXPacket();
response.data.add("code","<%=retCode%>");
response.data.add("msg","<%=retMsg%>");
response.data.add("promptPhoneNo","<%=promptPhoneNo%>");
core.ajax.receivePacket(response);

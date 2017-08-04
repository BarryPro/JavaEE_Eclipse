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
	String regionCode = (String)session.getAttribute("regCode");
	String retCode    = "";
	String retMsg     = "";
	
	String iLoginAccept = request.getParameter("iLoginAccept");
    String iChnSource = request.getParameter("iChnSource");
    String iOpCode = request.getParameter("iOpCode");
    String iLoginNo = request.getParameter("iLoginNo");
    String iLoginPwd = request.getParameter("iLoginPwd");
    String iPhoneNo = request.getParameter("iPhoneNo");
    String iUserPwd = request.getParameter("iUserPwd");
    String iOpNote = request.getParameter("iOpNote");
    String iRemindPhone = request.getParameter("iRemindPhone");
	
 //   System.out.println("liangyl~~~~~~~~"+iLoginAccept);
 //   System.out.println("liangyl~~~~~~~~"+iChnSource);
 //   System.out.println("liangyl~~~~~~~~"+iOpCode);
 //   System.out.println("liangyl~~~~~~~~"+iLoginNo);
 //   System.out.println("liangyl~~~~~~~~"+iLoginPwd);
 //   System.out.println("liangyl~~~~~~~~"+iPhoneNo);
 //   System.out.println("liangyl~~~~~~~~"+iUserPwd);
 //   System.out.println("liangyl~~~~~~~~"+iOpNote);
 //   System.out.println("liangyl~~~~~~~~"+iRemindPhone);
	
    String paraAray[] = new String[9];
	
    paraAray[0] = iLoginAccept;
    paraAray[1] = iChnSource;
    paraAray[2] = iOpCode;
    paraAray[3] = iLoginNo;
    paraAray[4] = iLoginPwd;
    paraAray[5] = iPhoneNo;
    paraAray[6] = iUserPwd;
    paraAray[7] = iOpNote;
    paraAray[8] = iRemindPhone;
    
    
    
    String serverName="sm394Cfm";

try{
%>
		<wtc:service name="<%=serverName%>" outnum="3" retmsg="msg" retcode="code" routerKey="region" routerValue="<%=regionCode%>">
			<wtc:param value="<%=paraAray[0]%>" />
			<wtc:param value="<%=paraAray[1]%>" />
			<wtc:param value="<%=paraAray[2]%>" />
			<wtc:param value="<%=paraAray[3]%>" />
			<wtc:param value="<%=paraAray[4]%>" />
			<wtc:param value="<%=paraAray[5]%>" />
			<wtc:param value="<%=paraAray[6]%>" />
			<wtc:param value="<%=paraAray[7]%>" />
			<wtc:param value="<%=paraAray[8]%>" />
		</wtc:service>
		<wtc:array id="serverResult" scope="end"  />
<%
	retCode = code;
	retMsg = msg;
	
}catch(Exception ex){
	retCode = "404040";
	retMsg = "调用服务"+serverName+"出错，请联系管理员";
}

%> 	
var response = new AJAXPacket();
response.data.add("code","<%=retCode%>");
response.data.add("msg","<%=retMsg%>");
core.ajax.receivePacket(response);

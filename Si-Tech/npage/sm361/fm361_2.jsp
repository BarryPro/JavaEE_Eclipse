<%
/********************
 -->>描述创建人、时间、模块的功能
 -------------------------创建-----------何敬伟(hejwa) 2016-3-28 13:37:56-------------------
 
 -------------------------后台人员：wangzc zuolf--------------------------------------------
********************/
%>

<%@ page contentType="text/html;charset=GB2312"%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%

	String opCode      = WtcUtil.repNull(request.getParameter("opCode"));
	String phoneNo     = WtcUtil.repNull(request.getParameter("phoneNo"));
	String loginAccept = WtcUtil.repNull(request.getParameter("loginAccept"));
	
	
  String regionCode = (String)session.getAttribute("regCode");
	String retCode    = "";
	String retMsg     = "";
 
	//7个标准化入参
	 String paraAray3[] = new String[8];
					paraAray3[0] = "";                                       //流水
					paraAray3[1] = "01";                                     //渠道代码
					paraAray3[2] = opCode;                                   //操作代码
					paraAray3[3] = (String)session.getAttribute("workNo");   //工号
					paraAray3[4] = (String)session.getAttribute("password"); //工号密码
					paraAray3[5] = phoneNo;                            //用户号码
					paraAray3[6] = "";       
					paraAray3[7] = loginAccept;    	
			
			
	String serverName = "sBackAcceptChk";
try{
%>
	 <wtc:service name="<%=serverName%>" outnum="2" retmsg="msg" retcode="code" routerKey="region" routerValue="<%=regionCode%>">
		<wtc:param value="<%=paraAray3[0]%>" />
		<wtc:param value="<%=paraAray3[1]%>" />	
		<wtc:param value="<%=paraAray3[2]%>" />
		<wtc:param value="<%=paraAray3[3]%>" />
		<wtc:param value="<%=paraAray3[4]%>" />
		<wtc:param value="<%=paraAray3[5]%>" />
		<wtc:param value="<%=paraAray3[6]%>" />
		<wtc:param value="<%=paraAray3[7]%>" />	
	</wtc:service>
	<wtc:array id="serverResult" scope="end"  />

			
<%
	retCode = code;
	retMsg = msg;
	System.out.println("--hejwa--------code--------------"+code);
	System.out.println("--hejwa--------msg---------------"+msg);
	System.out.println("--hejwa--------serverResult.length---------------"+serverResult.length);
	 
	
}catch(Exception ex){
	retCode = "404040";
	retMsg = "调用服务"+serverName+"出错，请联系管理员";
}

%> 	
var response = new AJAXPacket();
response.data.add("code","<%=retCode%>");
response.data.add("msg","<%=retMsg%>");
core.ajax.receivePacket(response);

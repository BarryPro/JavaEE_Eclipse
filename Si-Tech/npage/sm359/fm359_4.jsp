<%
/********************
 -->>描述创建人、时间、模块的功能
 -------------------------创建-----------何敬伟(hejwa) 2016-4-11 16:17:08-------------------
 
 -------------------------后台人员：wangzc zuolf--------------------------------------------
********************/
%>

<%@ page contentType="text/html;charset=GB2312"%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%

	String opCode     = WtcUtil.repNull(request.getParameter("opCode"));
	String phoneNo    = WtcUtil.repNull(request.getParameter("phoneNo"));
	String inGearCode = WtcUtil.repNull(request.getParameter("inGearCode"));
	String inGroupId  = WtcUtil.repNull(request.getParameter("inGroupId"));
	String oldGearCode  = WtcUtil.repNull(request.getParameter("oldGearCode")); //原档位
	
	
  String regionCode = (String)session.getAttribute("regCode");
	String retCode    = "";
	String retMsg     = "";
 
	//7个标准化入参
	 String paraAray3[] = new String[10];
					paraAray3[0] = "";                                       //流水
					paraAray3[1] = "01";                                     //渠道代码
					paraAray3[2] = opCode;                                   //操作代码
					paraAray3[3] = (String)session.getAttribute("workNo");   //工号
					paraAray3[4] = (String)session.getAttribute("password"); //工号密码
					paraAray3[5] = phoneNo;                            //用户号码
					paraAray3[6] = "";       
					paraAray3[7] = inGroupId;    	
					paraAray3[8] = inGearCode; 
					paraAray3[9] = oldGearCode; //原档位
			
for(int i=0;i<paraAray3.length;i++){
	System.out.println("----------------paraAray3["+i+"]--------------------->"+paraAray3[i]);
}
	String serverName = "sm359Check";
try{
%>
	 <wtc:service name="<%=serverName%>" outnum="13" retmsg="msg" retcode="code" routerKey="region" routerValue="<%=regionCode%>">
		<wtc:param value="<%=paraAray3[0]%>" />
		<wtc:param value="<%=paraAray3[1]%>" />	
		<wtc:param value="<%=paraAray3[2]%>" />
		<wtc:param value="<%=paraAray3[3]%>" />
		<wtc:param value="<%=paraAray3[4]%>" />
		<wtc:param value="<%=paraAray3[5]%>" />
		<wtc:param value="<%=paraAray3[6]%>" />
		<wtc:param value="<%=paraAray3[7]%>" />	
		<wtc:param value="<%=paraAray3[8]%>" />		
		<wtc:param value="<%=paraAray3[9]%>" />		
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

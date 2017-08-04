<%
/********************
 -->>描述创建人、时间、模块的功能
 -------------------------创建-----------何敬伟(hejwa) 2015-4-22 16:25:30-------------------
 
 -------------------------后台人员：--------------------------------------------
********************/
%>

<%@ page contentType="text/html;charset=GB2312"%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
	var retArray = new Array();//定义返回数组
<%

	String opCode     = WtcUtil.repNull(request.getParameter("opCode"));
	String mode_code  = WtcUtil.repNull(request.getParameter("mode_code"));
	String groupId    = (String)session.getAttribute("groupId");
  String workNo     = (String)session.getAttribute("workNo");
  String password   = (String)session.getAttribute("password");
  String workName   = (String)session.getAttribute("workName");
  String orgCode    = (String)session.getAttribute("orgCode");
  String ipAddrss   = (String)session.getAttribute("ipAddr");
  String regionCode = (String)session.getAttribute("regCode");
	String retCode1   = "";
	String retMsg1    = "";
	
	System.out.println("---hejwa---------groupId--------------------"+groupId);
	System.out.println("---hejwa---------opCode---------------------"+opCode);
	System.out.println("---hejwa---------mode_code------------------"+mode_code);
	System.out.println("---hejwa---------regionCode-----------------"+regionCode);
	
	String main_note = "";

try{
%>
<wtc:service name="s9611Cfm3" routerKey="regionCode" routerValue="<%=regionCode%>"  outnum="4" >
    <wtc:param value="<%=opCode%>"/>
    <wtc:param value="1"/>
    <wtc:param value="13"/>
    <wtc:param value="<%=groupId%>"/>
    <wtc:param value="<%=mode_code%>"/>
    <wtc:param value="10442"/>
    <wtc:param value="<%=regionCode%>"/>
    <wtc:param value=""/>
</wtc:service>
<wtc:array id="result" scope="end" />
<%
	main_note=result.length>0?result[0][0]:"";
	main_note = main_note.replaceAll("\"","");
	main_note = main_note.replaceAll("\'","");
	System.out.println("main_note="+main_note);
 
 System.out.println("---hejwa---------main_note------------------"+main_note);
 
}catch(Exception ex){
	retCode1 = "404040";
	retMsg1 = "调用服务s9611Cfm3出错，请联系管理员";
}

%> 	
var response = new AJAXPacket();
response.data.add("main_note","<%=main_note%>");
core.ajax.receivePacket(response);

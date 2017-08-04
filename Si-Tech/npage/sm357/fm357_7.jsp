<%
/********************
 -->>描述创建人、时间、模块的功能
 -------------------------创建-----------何敬伟(hejwa) 2016-3-2 10:07:45-------------------
 
 -------------------------后台人员：wangzc zuolf--------------------------------------------
********************/
%>

<%@ page contentType="text/html;charset=GB2312"%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%
System.out.println("---hejwa------7777777777777777777--- ------7-----------");
	String opCode      = WtcUtil.repNull(request.getParameter("opCode"));
	String phoneNo     = WtcUtil.repNull(request.getParameter("phoneNo"));
	String inProdCode  = WtcUtil.repNull(request.getParameter("inProdCode"));
	String inGearCode  = WtcUtil.repNull(request.getParameter("inGearCode"));
	
  String workNo     = (String)session.getAttribute("workNo");
  String password   = (String)session.getAttribute("password");
  String workName   = (String)session.getAttribute("workName");
  String orgCode    = (String)session.getAttribute("orgCode");
  String ipAddrss   = (String)session.getAttribute("ipAddr");
  String regionCode = (String)session.getAttribute("regCode");
	String retCode    = "";
	String retMsg     = "";
	
	
	//7个标准化入参
	String paraAray[] = new String[7];
	
	paraAray[0] = "";                                       //流水
	paraAray[1] = "01";                                     //渠道代码
	paraAray[2] = opCode;                                   //操作代码
	paraAray[3] = (String)session.getAttribute("workNo");   //工号
	paraAray[4] = (String)session.getAttribute("password"); //工号密码
	paraAray[5] = phoneNo;                                  //用户号码
	paraAray[6] = "";                                       //用户密码
			
	String serverName = "sm358RemQry";
	
	String prt_cust_name = "";
	String prt_cust_bran = "";
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
		</wtc:service>
		<wtc:array id="serverResult" scope="end"  />
<%
	retCode = code;
	retMsg = msg;
	
 	if(serverResult.length>0){
 		prt_cust_name = serverResult[0][1];
 		prt_cust_bran = serverResult[0][0];
 	}
	
	System.out.println("---hejwa---------prt_cust_name------------------"+prt_cust_name);
	System.out.println("---hejwa---------prt_cust_bran------------------"+prt_cust_bran);
	
}catch(Exception ex){
	ex.printStackTrace();
	retCode = "404040";
	retMsg = "调用服务"+serverName+"出错，请联系管理员";
}

%> 	
var response = new AJAXPacket();
response.data.add("code","<%=retCode%>");
response.data.add("msg","<%=retMsg%>");

response.data.add("prt_cust_name","<%=prt_cust_name%>");
response.data.add("prt_cust_bran","<%=prt_cust_bran%>");

core.ajax.receivePacket(response);

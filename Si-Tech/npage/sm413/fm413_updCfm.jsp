<%
/********************
 -->>描述创建人、时间、模块的功能
 -------------------------创建-----------何敬伟(hejwa) 2016-10-9 9:51:36-------------------
 
 -------------------------后台人员：--------------------------------------------
********************/
%>

<%@ page contentType="text/html;charset=GB2312"%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
	var retArray = new Array();//定义返回数组
<%

	String opCode       = WtcUtil.repNull(request.getParameter("opCode"));
	String phoneNo      = WtcUtil.repNull(request.getParameter("phoneNo"));
	String new_custName = WtcUtil.repNull(request.getParameter("new_custName"));
	
  String regionCode   = (String)session.getAttribute("regCode");
  
  String iOpType      = WtcUtil.repNull(request.getParameter("iOpType"));/*操作类型0改姓名;1改地址*/
	String iOpValue     = WtcUtil.repNull(request.getParameter("iOpValue"));
	String iOpmemo      = WtcUtil.repNull(request.getParameter("iOpmemo"));

                      
	String retCode      = "";
	String retMsg       = "";
	
	System.out.println("---hejwa---------opCode-------------------"+opCode);
	System.out.println("---hejwa---------phoneNo------------------"+phoneNo);
	
	//7个标准化入参
	String paraAray[] = new String[11];
	
	paraAray[0] = "";                                       //流水
	paraAray[1] = "01";                                     //渠道代码
	paraAray[2] = opCode;                                   //操作代码
	paraAray[3] = (String)session.getAttribute("workNo");   //工号
	paraAray[4] = (String)session.getAttribute("password"); //工号密码
	paraAray[5] = phoneNo;                                  //用户号码
	paraAray[6] = "";                                       //用户密码
	paraAray[7] = new_custName;
	paraAray[8] = iOpmemo;
	paraAray[9] = iOpType; 
	paraAray[10] = iOpValue; 

	String serverName = "sm413Cfm";
try{
%>
		<wtc:service name="<%=serverName%>" outnum="2" retmsg="msg" retcode="code" routerKey="region" routerValue="<%=regionCode%>">
<%
			for(int i=0; i<paraAray.length; i++ ){
				System.out.println("-----hejwa-------------paraAray["+i+"]-------------------->"+paraAray[i]);
%>
				<wtc:param value="<%=paraAray[i]%>" />
<%					
			}
%>									
		</wtc:service>
		<wtc:array id="serverResult" scope="end"  />
<%
	retCode = code;
	retMsg = msg;
	System.out.println("--hejwa--------code--------------"+code);
	System.out.println("--hejwa--------msg---------------"+msg);
	

}catch(Exception ex){
	retCode = "404040";
	retMsg = "调用服务"+serverName+"出错，请联系管理员";
}

%> 	
var response = new AJAXPacket();
response.data.add("code","<%=retCode%>");
response.data.add("msg","<%=retMsg%>");
core.ajax.receivePacket(response);

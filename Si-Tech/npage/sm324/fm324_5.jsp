<%
/********************
 -->>描述创建人、时间、模块的功能
 -------------------------创建-----------何敬伟(hejwa) 2015-4-22 16:25:30-------------------
 校验副卡号码 
 -------------------------后台人员：xiahk--------------------------------------------
********************/
%>

<%@ page contentType="text/html;charset=GB2312"%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ page import="com.sitech.boss.pub.util.Encrypt"%>
	var retArray = new Array();//定义返回数组
<%

	String opCode            = WtcUtil.repNull(request.getParameter("opCode"));
	String loginAccept       = WtcUtil.repNull(request.getParameter("loginAccept"));
	String op_type           = WtcUtil.repNull(request.getParameter("op_type"));
	String iPhoneNoMaster    = WtcUtil.repNull(request.getParameter("iPhoneNoMaster"));
	String f_phone_no_strs   = WtcUtil.repNull(request.getParameter("f_phone_no_strs"));
	String f_phone_pass_strs = WtcUtil.repNull(request.getParameter("f_phone_pass_strs"));
	
  String workNo     = (String)session.getAttribute("workNo");
  String password   = (String)session.getAttribute("password");
  String workName   = (String)session.getAttribute("workName");
  String orgCode    = (String)session.getAttribute("orgCode");
  String ipAddrss   = (String)session.getAttribute("ipAddr");
  String regionCode = (String)session.getAttribute("regCode");
	String retCode    = "";
	String retMsg     = "";
	
	
	//7个标准化入参
	String paraAray[] = new String[13];
	
	paraAray[0] = loginAccept;                                       //流水
	paraAray[1] = "01";                                     //渠道代码
	paraAray[2] = opCode;                                   //操作代码
	paraAray[3] = (String)session.getAttribute("workNo");   //工号
	paraAray[4] = (String)session.getAttribute("password"); //工号密码
	paraAray[5] = "";                                  //用户号码
	paraAray[6] = "";                                       //用户密码
	paraAray[7] = iPhoneNoMaster;   
	paraAray[8] = f_phone_no_strs;   
	paraAray[9] = f_phone_pass_strs;   
	paraAray[10] = op_type;   
	paraAray[11] = "";   
	paraAray[12] = "0";   

	String[] arr_f_phone_no   = f_phone_no_strs.split("\\|");
	String[] arr_f_phone_pass = f_phone_pass_strs.split("\\|");
	
	
	for(int i=0; i<arr_f_phone_pass.length; i++){
		arr_f_phone_pass[i] = (String)Encrypt.encrypt(arr_f_phone_pass[i]);
	}	
	
	
		
	for(int i=0; i<paraAray.length; i++){
		System.out.println("--hejwa---入参-----paraAray["+i+"]--------------"+paraAray[i]);
	}	
	
	
	for(int i=0; i<arr_f_phone_no.length; i++){
		System.out.println("--hejwa--手机号数组------arr_f_phone_no["+i+"]--------------"+arr_f_phone_no[i]);
	}	
	
	for(int i=0; i<arr_f_phone_pass.length; i++){
		System.out.println("--hejwa--手机密码数组------arr_f_phone_pass["+i+"]--------------"+arr_f_phone_pass[i]);
	}	
	
	
	String serverName = "sm324Cfm";
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
			<wtc:params value="<%=arr_f_phone_no%>" />				
			<wtc:params value="<%=arr_f_phone_pass%>" />				
			<wtc:param value="<%=paraAray[10]%>" />				
			<wtc:param value="<%=paraAray[11]%>" />				
			<wtc:param value="<%=paraAray[12]%>" />				
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

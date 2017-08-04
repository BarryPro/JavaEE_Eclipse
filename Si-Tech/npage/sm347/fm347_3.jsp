<%
/********************
 -->>描述创建人、时间、模块的功能
 -------------------------创建-----------何敬伟(hejwa) 2015-4-22 16:25:30-------------------
 
 -------------------------后台人员：jingang--------------------------------------------
********************/
%>

<%@ page contentType="text/html;charset=GB2312"%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
	var retArray = new Array();//定义返回数组
<%

	String opCode       = WtcUtil.repNull(request.getParameter("opCode"));
	String iCategory    = WtcUtil.repNull(request.getParameter("iCategory"));
	String iSubPhoneNo  = WtcUtil.repNull(request.getParameter("iSubPhoneNo"));
	String iChrgType    = WtcUtil.repNull(request.getParameter("iChrgType"));
	String bizcode      = WtcUtil.repNull(request.getParameter("bizcode"));
	String iPhoneNo     = WtcUtil.repNull(request.getParameter("iPhoneNo"));
	String opnote       = WtcUtil.repNull(request.getParameter("opnote"));
	String loginAccept  = WtcUtil.repNull(request.getParameter("loginAccept"));
	
	
	
	
  String workNo     = (String)session.getAttribute("workNo");
  String password   = (String)session.getAttribute("password");
  String workName   = (String)session.getAttribute("workName");
  String orgCode    = (String)session.getAttribute("orgCode");
  String ipAddrss   = (String)session.getAttribute("ipAddr");
  String regionCode = (String)session.getAttribute("regCode");
	String retCode    = "";
	String retMsg     = "";
	
	System.out.println("---hejwa---------opCode-------------------"+opCode);
	
	//7个标准化入参
	String paraAray[] = new String[17];
	
	paraAray[0] = loginAccept;                                       //流水
	paraAray[1] = "01";                                     //渠道代码
	paraAray[2] = opCode;                                   //操作代码
	paraAray[3] = (String)session.getAttribute("workNo");   //工号
	paraAray[4] = (String)session.getAttribute("password"); //工号密码
	paraAray[5] = iPhoneNo;                                  //用户号码
	paraAray[6] = "";                                       //用户密码
	
	paraAray[7]  = opnote;  //操作备注                
	paraAray[8]  = "";  //平台流水号              
	paraAray[9]  = iSubPhoneNo;  //副号                    
	paraAray[10] = "74";  //业务类型代码74          
	paraAray[11] = iChrgType;  //计费类型                
	paraAray[12] = iCategory;  //副号码类型              
	paraAray[13] = "";  //副号码序列号            
	paraAray[14] = "";  //副号码配置生效日期和时间
	paraAray[15] = "698034";  //企业代码698034          
	paraAray[16] = bizcode;  //业务代码                


	for(int iii=0;iii<paraAray.length;iii++){
		System.out.println("--hejwa-----------paraAray["+iii+"]----------------->"+paraAray[iii]);
	}
	
	
	String serverName = "sm167Cfm";
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
			<wtc:param value="<%=paraAray[8]%>" />
			<wtc:param value="<%=paraAray[9]%>" />
			<wtc:param value="<%=paraAray[10]%>" />
			<wtc:param value="<%=paraAray[11]%>" />
			<wtc:param value="<%=paraAray[12]%>" />
			<wtc:param value="<%=paraAray[13]%>" />
			<wtc:param value="<%=paraAray[14]%>" />
			<wtc:param value="<%=paraAray[15]%>" />
			<wtc:param value="<%=paraAray[16]%>" />
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

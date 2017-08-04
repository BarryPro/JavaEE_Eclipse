<%
/********************
 -->>描述创建人、时间、模块的功能
 
 -------------------------后台人员：--------------------------------------------
********************/
%>

<%@ page contentType="text/html;charset=GB2312"%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%
	String regionCode     = (String)session.getAttribute("regCode");
	String phoneNo        = WtcUtil.repNull(request.getParameter("phoneNo"));
	String loginAccept    = WtcUtil.repNull(request.getParameter("loginAccept"));
	
	String iCustType   = WtcUtil.repNull(request.getParameter("iCustType"));
	String iCustId     = WtcUtil.repNull(request.getParameter("iCustId"));
	String iCustName      = WtcUtil.repNull(request.getParameter("iCustName"));
                          
	String retCode        = "";
	String retMsg         = "";
	
	
	//7个标准化入参
	String paraAray[] = new String[11];
	
	paraAray[0] = loginAccept;                                       //流水
	paraAray[1] = "01";                                     //渠道代码
	paraAray[2] = "m434";                                   //操作代码
	paraAray[3] = (String)session.getAttribute("workNo");   //工号
	paraAray[4] = (String)session.getAttribute("password"); //工号密码
	paraAray[5] = phoneNo;                                  //用户号码
	paraAray[6] = "";                                       
	paraAray[7] = paraAray[3]+"办理一证多名关系配置"; 
	paraAray[8] = iCustType; 
	paraAray[9] = iCustId;
	paraAray[10] = iCustName;


	String serverName = "sm434Cfm";
try{
%>
		<wtc:service name="<%=serverName%>" outnum="2" retmsg="msg" retcode="code" routerKey="region" routerValue="<%=regionCode%>">
<%
			for(int i=0; i<paraAray.length; i++ ){
				System.out.println("-----liyang-------------paraAray["+i+"]-------------------->"+paraAray[i]);
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
	System.out.println("--liyang--------code-----serverName=["+serverName+"]---------"+code);
	System.out.println("--liyang--------msg------serverName=["+serverName+"]---------"+msg);
 
	
}catch(Exception ex){
	retCode = "404040";
	retMsg = "调用服务"+serverName+"出错，请联系管理员";
}

%> 	
var response = new AJAXPacket();
response.data.add("code","<%=retCode%>");
response.data.add("msg","<%=retMsg%>");
core.ajax.receivePacket(response);

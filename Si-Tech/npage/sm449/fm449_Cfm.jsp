<%
/********************
 -->>描述创建人、时间、模块的功能
 -------------------------创建-----------何敬伟(hejwa) -------------------
 
 -------------------------后台人员：--------------------------------------------
********************/
%>

<%@ page contentType="text/html;charset=GB2312"%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
	var retArray = new Array();//定义返回数组
<%

	String opCode         = WtcUtil.repNull(request.getParameter("opCode"));
	String phoneNo        = WtcUtil.repNull(request.getParameter("phoneNo"));
	String loginAccept    = WtcUtil.repNull(request.getParameter("loginAccept"));
	
	
	String sel_CountTotal = WtcUtil.repNull(request.getParameter("sel_CountTotal"));
	String sel_Count      = WtcUtil.repNull(request.getParameter("sel_Count"));
	String sel_Payment    = WtcUtil.repNull(request.getParameter("sel_Payment"));
	
	
  String regionCode     = (String)session.getAttribute("regCode");
                        
	String retCode        = "";
	String retMsg         = "";
	
	String ret_card_nos   = ""; //返回的有价卡卡号，顿号分隔，最多10个
	
	//7个标准化入参
	String paraAray[] = new String[15];
	
	paraAray[0] = loginAccept;                              //流水
	paraAray[1] = "01";                                     //渠道代码
	paraAray[2] = opCode;                                   //操作代码
	paraAray[3] = (String)session.getAttribute("workNo");   //工号
	paraAray[4] = (String)session.getAttribute("password"); //工号密码
	paraAray[5] = phoneNo;                                  //用户号码
	paraAray[6] = "";                                       //用户密码
	
	paraAray[7] = sel_CountTotal;/*电子有价卡面值*/
	paraAray[8] = sel_Count;/*电子有价卡数量*/
	paraAray[9] = "";/*邮箱地址*/
	paraAray[10] = sel_Payment;/*支付方式*/	
	paraAray[11] = "";/*证件类型*/
	paraAray[12] = "";/*证件号码*/
	paraAray[13] = "";/*发票付款单位*/
	paraAray[14] = "";/**/
	

	String serverName = "sm449Cfm";
try{
%>
		<wtc:service name="<%=serverName%>" outnum="2" retmsg="msg" retcode="code" routerKey="region" routerValue="<%=regionCode%>">
<%
			for(int i=0; i<paraAray.length; i++ ){
				System.out.println("-----hejwa-------------paraAray["+i+"]------["+serverName+"]-------------->"+paraAray[i]);
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
	 
	if(serverResult.length>0){
		ret_card_nos = serverResult[0][1];
		
		System.out.println("-------hejwa-----------serverResult[0][1]-------------->"+serverResult[0][1]);
		System.out.println("-------hejwa-----------serverResult[0][0]-------------->"+serverResult[0][0]);
	}
	
}catch(Exception ex){
	retCode = "404040";
	retMsg = "调用服务"+serverName+"出错，请联系管理员";
}


	System.out.println("--hejwa--------retCode-----serverName=["+serverName+"]---------"+retCode);
	System.out.println("--hejwa--------retMsg------serverName=["+serverName+"]---------"+retMsg);
%> 	
var response = new AJAXPacket();
response.data.add("code","<%=retCode%>");
response.data.add("msg","<%=retMsg%>");
response.data.add("ret_card_nos","<%=ret_card_nos%>");

core.ajax.receivePacket(response);

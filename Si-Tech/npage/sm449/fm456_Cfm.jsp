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
	
	
	String sel_CountTotal    = WtcUtil.repNull(request.getParameter("sel_CountTotal"));
	String sel_ChannelType   = WtcUtil.repNull(request.getParameter("sel_ChannelType"));
	String sel_CardType      = WtcUtil.repNull(request.getParameter("sel_CardType"));
	String sel_Payment       = WtcUtil.repNull(request.getParameter("sel_Payment"));
	String ipt_IDValue       = WtcUtil.repNull(request.getParameter("ipt_IDValue"));
	String ipt_Count         = WtcUtil.repNull(request.getParameter("ipt_Count"));
	String ipt_Publickey     = WtcUtil.repNull(request.getParameter("ipt_Publickey"));
	String ipt_Barepublickey = WtcUtil.repNull(request.getParameter("ipt_Barepublickey"));	

        	
	
  String regionCode     = (String)session.getAttribute("regCode");
                        
	String retCode        = "";
	String retMsg         = "";
	
	String res_accept   = ""; //操作流水
	
	//7个标准化入参
	String paraAray[] = new String[13];
	
	paraAray[0]  = "";                              //流水
	paraAray[1]  = "01";                                     //渠道代码
	paraAray[2]  = opCode;                                   //操作代码
	paraAray[3]  = (String)session.getAttribute("workNo");   //工号
	paraAray[4]  = (String)session.getAttribute("password"); //工号密码
	paraAray[5]  = ipt_IDValue;                                  //用户号码
	paraAray[6]  = "";                                       //用户密码
	
	paraAray[7]  = sel_CountTotal; /*电子有价卡面值*/
	paraAray[8]  = ipt_Count;/*电子有价卡数量*/
	paraAray[9]  = sel_Payment;/*支付方式*/
	paraAray[10] = sel_ChannelType;/*集团客户 11/社会渠道 10 */
	paraAray[11] = ipt_Barepublickey;
	paraAray[12] = ipt_Publickey;
	
	
	String serverName = "sm456Cfm";
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
		res_accept = serverResult[0][0];
		
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
response.data.add("res_accept","<%=res_accept%>");

core.ajax.receivePacket(response);

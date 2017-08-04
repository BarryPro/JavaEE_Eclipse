<%
/********************
 -------------------------创建-----------何敬伟(hejwa)2015-6-16 15:37:05-------------------
 添加提交服务
 -------------------------后台人员：李阳--------------------------------------------
********************/
%>

<%@ page contentType="text/html;charset=GB2312"%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
	var retArray = new Array();//定义返回数组
<%

	String opCode     = WtcUtil.repNull(request.getParameter("opCode"));
	String phone_no_i = WtcUtil.repNull(request.getParameter("phone_no_i"));
	String login_no_i = WtcUtil.repNull(request.getParameter("login_no_i"));
	String iFlag      = WtcUtil.repNull(request.getParameter("iFlag"));
	
  String workNo     = (String)session.getAttribute("workNo");
  String password   = (String)session.getAttribute("password");
  String workName   = (String)session.getAttribute("workName");
  String orgCode    = (String)session.getAttribute("orgCode");
  String ipAddrss   = (String)session.getAttribute("ipAddr");
  String regionCode = (String)session.getAttribute("regCode");
	String retCode    = "";
	String retMsg     = "";
	
	
	//7个标准化入参
	String paraAray[] = new String[8];
	
	paraAray[0] = "0";                                      //流水
	paraAray[1] = "01";                                     //渠道代码
	paraAray[2] = opCode;                                   //操作代码
	paraAray[3] = login_no_i;   //工号
	paraAray[4] = ""; //工号密码
	paraAray[5] = phone_no_i;                                  //用户号码
	paraAray[6] = "";                                       //用户密码
	paraAray[7] = iFlag;                                       /*0查询 1新增 2删除*/

	String serverName = "sm271Cfm";
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
		</wtc:service>
		<wtc:array id="serverResult" scope="end"  />
<%
	retCode = code;
	retMsg = msg;
	
	
	//拼装返回数组
	for(int i=0;i<serverResult.length;i++){
%>
		 retArray[<%=i%>] = new Array();
<%	
		for(int j=0;j<serverResult[i].length;j++){
%>
		    retArray[<%=i%>][<%=j%>] = "<%=serverResult[i][j]%>";
<%		
		}
	}
 
	
}catch(Exception ex){
	retCode = "404040";
	retMsg = "调用服务"+serverName+"出错，请联系管理员";
}

%> 	
var response = new AJAXPacket();
response.data.add("code","<%=retCode%>");
response.data.add("msg","<%=retMsg%>");
response.data.add("retArray",retArray);
core.ajax.receivePacket(response);


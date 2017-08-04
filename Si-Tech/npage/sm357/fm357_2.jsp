<%
/********************
 -->>描述创建人、时间、模块的功能
 -------------------------创建-----------何敬伟(hejwa) 2016-2-29 17:04:50-------------------
 
 -------------------------后台人员：wangzc zuolf--------------------------------------------
********************/
%>

<%@ page contentType="text/html;charset=GB2312"%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
	var retArray = new Array();//定义返回数组
<%

	String opCode     = WtcUtil.repNull(request.getParameter("opCode"));
	String phoneNo    = WtcUtil.repNull(request.getParameter("phoneNo"));
	String inQryType  = WtcUtil.repNull(request.getParameter("inQryType"));
	String inProdCode = WtcUtil.repNull(request.getParameter("inProdCode"));
	String inGearCode = WtcUtil.repNull(request.getParameter("inGearCode"));
	
	
	
  String workNo     = (String)session.getAttribute("workNo");
  String password   = (String)session.getAttribute("password");
  String workName   = (String)session.getAttribute("workName");
  String orgCode    = (String)session.getAttribute("orgCode");
  String ipAddrss   = (String)session.getAttribute("ipAddr");
  String regionCode = (String)session.getAttribute("regCode");
	String retCode    = "";
	String retMsg     = "";
	String num="7";
	System.out.println("---hejwa---------opCode-------------------"+opCode);
	System.out.println("---hejwa---------phoneNo------------------"+phoneNo);
	if(inQryType.equals("2")){
		num="8";
	}
	//7个标准化入参
	String paraAray[] = new String[11];
			paraAray[0] = "";                                       //流水
			paraAray[1] = "01";                                     //渠道代码
			paraAray[2] = opCode;                                   //操作代码
			paraAray[3] = (String)session.getAttribute("workNo");   //工号
			paraAray[4] = (String)session.getAttribute("password"); //工号密码
			paraAray[5] = phoneNo;                              //用户号码
			paraAray[6] = "";  
			paraAray[7] = inQryType;  //查询类型,0:查询家庭产品；1：产品档位; 2:家庭角色ss 
			paraAray[8] = inProdCode;  //产品代码：JTRH,JTDX，查询类型为1是必传
			paraAray[9] = inGearCode;  //家庭产品档位代码:D001,D002,D003,D004，查询类型为2时必传
			

			
	String serverName = "sm357Qry";
try{
%>
		<wtc:service name="<%=serverName%>" outnum="<%=num%>" retmsg="msg" retcode="code" routerKey="region" routerValue="<%=regionCode%>">
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
		</wtc:service>
		<wtc:array id="serverResult" scope="end"  />
			
<%
	retCode = code;
	retMsg = msg;
	System.out.println("--hejwa--------code--------------"+code);
	System.out.println("--hejwa--------msg---------------"+msg);
	System.out.println("--hejwa--------serverResult.length---------------"+serverResult.length);
	
	//拼装返回数组
	for(int i=0;i<serverResult.length;i++){
%>
		 retArray[<%=i%>] = new Array();
<%	
		for(int j=0;j<serverResult[i].length;j++){
			System.out.println("--hejwa--------serverResult["+i+"]["+j+"]---------------"+serverResult[i][j]);
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
response.data.add("inQryType","<%=inQryType%>");
response.data.add("retArray",retArray);
core.ajax.receivePacket(response);

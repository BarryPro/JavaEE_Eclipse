<%
/********************
 -->>描述创建人、时间、模块的功能
 -------------------------创建-----------何敬伟(hejwa) 2015-4-22 16:25:30-------------------
 
 -------------------------后台人员：王文刚--------------------------------------------
********************/
%>

<%@ page contentType="text/html;charset=GB2312"%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
	var retArray = new Array();//定义返回数组
<%

	String opCode         = WtcUtil.repNull(request.getParameter("opCode"));
	String qry_val        = WtcUtil.repNull(request.getParameter("qry_val"));
	String qry_type       = WtcUtil.repNull(request.getParameter("qry_type"));                     
	
  String regionCode     = (String)session.getAttribute("regCode");
                        
	String retCode        = "";
	String retMsg         = "";
	
	System.out.println("---hejwa---------opCode-------------------"+opCode);
	
	//7个标准化入参
	String paraAray[] = new String[9];
	
	paraAray[0] = "";                                       //流水
	paraAray[1] = "01";                                     //渠道代码
	paraAray[2] = opCode;                                   //操作代码
	paraAray[3] = (String)session.getAttribute("workNo");   //工号
	paraAray[4] = (String)session.getAttribute("password"); //工号密码
	paraAray[5] = "";                                  //用户号码
	paraAray[6] = "";                                       //用户密码
	paraAray[7] = qry_type;  
	paraAray[8] = qry_val;  

	String serverName = "sm426Qry";
try{
%>
		<wtc:service name="<%=serverName%>" outnum="10" retmsg="msg" retcode="code" routerKey="region" routerValue="<%=regionCode%>">
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

<%
/********************
 -->>描述创建人、时间、模块的功能
 -------------------------创建-----------何敬伟(hejwa) 2016/12/23 11:05:04-------------------
 关于开发物联卡批开界面实名制信息存储功能的函
 
 -------------------------后台人员：chenlina--------------------------------------------
********************/
%>

<%@ page contentType="text/html;charset=GB2312"%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
	var retArray = new Array();//定义返回数组
<%

	String opCode         = WtcUtil.repNull(request.getParameter("opCode"));
	String InterThin_No   = WtcUtil.repNull(request.getParameter("InterThin_No"));
	                      
  String regionCode     = (String)session.getAttribute("regCode");
                        
	String retCode        = "";
	String retMsg         = "";
	
	
	//7个标准化入参
	String paraAray[] = new String[7];
	
	paraAray[0] = "";                                       //流水
	paraAray[1] = "01";                                     //渠道代码
	paraAray[2] = opCode;                                   //操作代码
	paraAray[3] = (String)session.getAttribute("workNo");   //工号
	paraAray[4] = (String)session.getAttribute("password"); //工号密码
	paraAray[5] = InterThin_No;                                  //用户号码
	paraAray[6] = "";                                       //用户密码

	String serverName = "sWlwBasicQry";
try{
%>
		<wtc:service name="<%=serverName%>" outnum="22" retmsg="msg" retcode="code" routerKey="region" routerValue="<%=regionCode%>">
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
	
	//拼装返回数组
	for(int i=0;i<serverResult.length;i++){
%>
		 retArray[<%=i%>] = new Array();
<%	
		for(int j=0;j<serverResult[i].length;j++){
				System.out.println("--hejwa--------出参------serverName=["+serverName+"]--------serverResult["+i+"]["+j+"]------->"+serverResult[i][j]);
		
%>
		    retArray[<%=i%>][<%=j%>] = "<%=serverResult[i][j]%>";
<%		
		}
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
response.data.add("retArray",retArray);
core.ajax.receivePacket(response);

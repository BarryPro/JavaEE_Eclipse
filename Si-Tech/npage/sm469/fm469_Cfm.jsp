<%
/********************

 -->>描述创建人、时间、模块的功能
 -------------------------创建-----------duming 2017.4.13------------------
 关于新固话产品账期调整情况及现存问题报备的函  信用账期变更
 
 
 -------------------------后台人员：gudd--------------------------------------------
********************/
%>

<%@ page contentType="text/html;charset=GB2312"%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>

<%

	String opCode         = WtcUtil.repNull(request.getParameter("opCode"));
	String other_value   = WtcUtil.repNull(request.getParameter("other_value"));//信用账期
	String external_code   = WtcUtil.repNull(request.getParameter("external_code"));//品牌编码
	
	
	                      
  String regionCode     = (String)session.getAttribute("regCode");
                        
	String retCode        = "";
	String retMsg         = "";
	
	
	
	//标准化入参
	String paraAray[] = new String[9];
	
	paraAray[0] = "0";                                       //流水
	paraAray[1] = "";                                     //渠道代码
	paraAray[2] = opCode;                                   //操作代码
	paraAray[3] = (String)session.getAttribute("workNo");   //工号
	paraAray[4] = (String)session.getAttribute("password"); //工号密码
	paraAray[5] = "";                                  //用户号码
	paraAray[6] =  "";                                       //用户密码
	paraAray[7] =  external_code;                                   //品牌编码
	paraAray[8] =  other_value;                                       //信用账期
	

	String serverName = "sm469Cfm";
try{
%>
		<wtc:service name="<%=serverName%>" outnum="2" retmsg="msg" retcode="code" routerKey="region" routerValue="<%=regionCode%>">
<%
			for(int i=0; i<paraAray.length; i++ ){
				System.out.println("-----duming1-------------paraAray["+i+"]------["+serverName+"]-------------->"+paraAray[i]);
%>
				<wtc:param value="<%=paraAray[i]%>" />
<%					
			}
%>									
		</wtc:service>
		<wtc:array id="serverResult" scope="end"  />
<%
if(serverResult.length>0){
	retCode = serverResult[0][0];
	retMsg = serverResult[0][1];
}
	
}catch(Exception ex){
	retCode = "404040";
	retMsg = "调用服务"+serverName+"出错，请联系管理员";
}


	System.out.println("--duming1--------retCode-----serverName=["+serverName+"]---------"+retCode);
	System.out.println("--duming1--------retMsg------serverName=["+serverName+"]---------"+retMsg);
%> 	
var response = new AJAXPacket();
response.data.add("code","<%=retCode%>");
response.data.add("msg","<%=retMsg%>");
core.ajax.receivePacket(response);

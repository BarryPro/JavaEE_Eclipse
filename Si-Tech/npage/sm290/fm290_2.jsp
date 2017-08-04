<%
/********************
 -->>描述创建人、时间、模块的功能
 -------------------------创建-----------何敬伟(hejwa)2015-7-27 16:58:47-------------------
 
 -------------------------后台人员：dujl--------------------------------------------
********************/
%>

<%@ page contentType="text/html;charset=GB2312"%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
	var retArray = new Array();//定义返回数组
<%

	String opCode     = WtcUtil.repNull(request.getParameter("opCode"));
	String y_year_month    = WtcUtil.repNull(request.getParameter("y_year_month"));
	String region_code    = WtcUtil.repNull(request.getParameter("region_code"));
	
	
	
  String workNo     = (String)session.getAttribute("workNo");
  String password   = (String)session.getAttribute("password");
  String workName   = (String)session.getAttribute("workName");
  String orgCode    = (String)session.getAttribute("orgCode");
  String ipAddrss   = (String)session.getAttribute("ipAddr");
  String regionCode = (String)session.getAttribute("regCode");
	String retCode    = "";
	String retMsg     = "";
	
	
	//7个标准化入参
	String paraAray[] = new String[12];
	
	paraAray[0] = "";                                       //流水         
	paraAray[1] = "01";                                     //渠道代码
	paraAray[2] = opCode;                                   //操作代码
	paraAray[3] = (String)session.getAttribute("workNo");   //工号
	paraAray[4] = (String)session.getAttribute("password"); //工号密码
	paraAray[5] = "";                                  //用户号码
	paraAray[6] = "";                                       //用户密码
	paraAray[7] = "营业前台中奖查询";  //备注
  paraAray[8] = "2";
  paraAray[9] = "";
  paraAray[10] = y_year_month;
  paraAray[11] = region_code;
  
  

	String serverName = "sM290Qry";
try{
%>
		<wtc:service name="<%=serverName%>" outnum="11" retmsg="msg" retcode="code" routerKey="region" routerValue="<%=regionCode%>">
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

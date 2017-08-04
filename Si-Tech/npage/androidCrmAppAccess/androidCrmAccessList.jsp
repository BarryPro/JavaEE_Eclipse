<%
/********************
 version v2.0
开发商: si-tech
*
*hejwa 2013-12-18 15:43:21
*
********************/
%>
<%@ page contentType="text/html; charset=gb2312" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
	var retArray = new Array();
<%
		String opCode 		= request.getParameter("opCode");	
		String input_group_id 		= request.getParameter("input_group_id");	
		String imeiNo 		= request.getParameter("imeiNo");	
		String regionCode = (String)session.getAttribute("regCode");
		String errCode    = "000000";
		String errMsg     = "";
		
		String paraAray[] = new String[9];
		
		paraAray[0] = "";  																			//流水
		paraAray[1] = "01";                                     //渠道代码
		paraAray[2] = opCode;                                   //操作代码
		paraAray[3] = (String)session.getAttribute("workNo");   //工号
		paraAray[4] = (String)session.getAttribute("password"); //工号密码
		paraAray[5] = "";          															//用户号码
		paraAray[6] = "";                                       //用户密码
		paraAray[7] = imeiNo;                                   //imei号码
		paraAray[8] = input_group_id;                                  //

for(int i=0;i<paraAray.length;i++){
	System.out.println("--------------paraAray["+i+"]-------------"+paraAray[i]);
} 
try{ 
%>		
 	<wtc:service name="sm018Qry" outnum="12" retmsg="msg" retcode="code" routerKey="region" routerValue="<%=regionCode%>">
 		<wtc:param value="<%=paraAray[0]%>" />
 		<wtc:param value="<%=paraAray[1]%>" />
 		<wtc:param value="<%=paraAray[2]%>" />
 		<wtc:param value="<%=paraAray[3]%>" />
 		<wtc:param value="<%=paraAray[4]%>" />
 		<wtc:param value="<%=paraAray[5]%>" />					
 		<wtc:param value="<%=paraAray[6]%>" />	
 		<wtc:param value="<%=paraAray[7]%>" />	
 		<wtc:param value="<%=paraAray[8]%>" />	
 	</wtc:service>
 	<wtc:array id="result_t2" scope="end"/>
<%
	for(int i=0;i<result_t2.length;i++){
%>
		retArray[<%=i%>] = new Array();
<%	
		for(int j=0;j<result_t2[i].length;j++){
	  	if(result_t2[i][j]!=null){
%>
			retArray[<%=i%>][<%=j%>]="<%=result_t2[i][j]%>";
<%
			}
		}
	}
%>
<%
	if(!code.equals("000000")){
			errCode = code;
			errMsg = msg;
	}
}catch(Exception e){
		errCode = "40404";
		errMsg = "调用服务系统错误，请联系管理员";
}
	System.out.println("mylog   code== "+errCode);
%>
 	
var response = new AJAXPacket();
response.data.add("code","<%=errCode%>");
response.data.add("msg","<%=errMsg%>");
response.data.add("retArray",retArray);
core.ajax.receivePacket(response);
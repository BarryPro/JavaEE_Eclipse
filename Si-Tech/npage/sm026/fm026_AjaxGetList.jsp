<%
/********************
 version v2.0
 开发商 si-tech
 create hejwa 2014-1-21 9:04:24
 
********************/
%>
              

<%@ page contentType="text/html; charset=gb2312" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
var retArray = new Array();
<%
	String regionCode = (String)session.getAttribute("regCode");
	
	String opCode       = request.getParameter("opCode");
  String sSiName      = request.getParameter("sSiName");
  String sSiAccNumber = request.getParameter("sSiAccNumber");
  String sPhoneNo     = request.getParameter("sPhoneNo");
  
  String paraAray[] = new String[9];
		
		paraAray[0]  = "";  																		 //流水
		paraAray[1]  = "01";                                     //渠道代码
		paraAray[2]  = opCode;                                   //操作代码
		paraAray[3]  = (String)session.getAttribute("workNo");   //工号
		paraAray[4]  = (String)session.getAttribute("password"); //工号密码
		paraAray[5]  = sPhoneNo;     														 //用户号码
		paraAray[6]  = "";                                       //用户密码
		paraAray[7]  = sSiName;                                   
		paraAray[8]  = sSiAccNumber;                                   
		String retCode = "";
		String retMsg  = "";
try{		   
%> 

	<wtc:service name="sm026Qry" outnum="8" retmsg="sm026Qrymsg" retcode="sm026Qrycode" routerKey="region" routerValue="<%=regionCode%>">
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
	<wtc:array id="sm026QryResult" scope="end"/>

<%
	retCode = sm026Qrycode;
	retMsg  = sm026Qrymsg;
	for(int i=0;i<sm026QryResult.length;i++){
%>
		retArray[<%=i%>] = new Array();
<%	
		for(int j=0;j<sm026QryResult[i].length;j++){
	  	if(sm026QryResult[i][j]!=null){
	  		//System.out.println("---------sm026QryResult["+i+"]["+j+"]-------"+sm026QryResult[i][j]);
%>
				retArray[<%=i%>][<%=j%>]="<%=sm026QryResult[i][j]%>";
<%
			}
		}
	}

}catch(Exception e){
	retCode = "40404";
	retMsg  = "调用服务系统错误，请联系管理员";
}
%> 

var response = new AJAXPacket();
response.data.add("code","<%=retCode%>");
response.data.add("msg","<%=retMsg%>");
response.data.add("retArray",retArray);
core.ajax.receivePacket(response);
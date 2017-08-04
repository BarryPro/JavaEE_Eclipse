<%@ page contentType="text/html; charset=gb2312" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%

	String retCode = "";
	String retMsg  = "";
	String regionCode = (String)session.getAttribute("regCode");
	String apkName 	 	= request.getParameter("apkName").trim();
	String opCode  	 	= request.getParameter("opCode");
	String versionId 	= request.getParameter("versionId");
  String bak_dir 	 	= request.getRealPath("/npage/androidFile")+"/";
	String filedownload = bak_dir+apkName;//即将下载的文件的相对路径
	
	File f = new File(filedownload);
  try{
		f.delete();
  }catch(Exception e){
      e.printStackTrace();
  } 
	//调用服务
		String paraAray[] = new String[8];
		
		paraAray[0] = "";  																			//流水
		paraAray[1] = "01";                                     //渠道代码
		paraAray[2] = opCode;                                   //操作代码
		paraAray[3] = (String)session.getAttribute("workNo");   //工号
		paraAray[4] = (String)session.getAttribute("password"); //工号密码
		paraAray[5] = "";          															//用户号码
		paraAray[6] = "";                                       //用户密码
		paraAray[7] = versionId;                                //版本号
		
try{		
%>
	<wtc:service name="sm016Del" outnum="1" retmsg="msg" retcode="code" routerKey="region" routerValue="<%=regionCode%>">
		<wtc:param value="<%=paraAray[0]%>" />
 		<wtc:param value="<%=paraAray[1]%>" />
 		<wtc:param value="<%=paraAray[2]%>" />
 		<wtc:param value="<%=paraAray[3]%>" />
 		<wtc:param value="<%=paraAray[4]%>" />
 		<wtc:param value="<%=paraAray[5]%>" />					
 		<wtc:param value="<%=paraAray[6]%>" />	
 		<wtc:param value="<%=paraAray[7]%>" />	
	</wtc:service>
<%
	retCode = code;
	retMsg  = msg;
}catch(Exception ex){
 	ex.printStackTrace();
	retCode = "40404";
	retMsg = "调用服务系统错误，请联系管理员";
}
%>
var response = new AJAXPacket();
response.data.add("code","<%=retCode%>");
response.data.add("msg","<%=retMsg%>");
core.ajax.receivePacket(response);	
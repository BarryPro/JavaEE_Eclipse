   
<%
/********************
 version v2.0
 开发商 si-tech
 create hejw@2010-5-25 :10:48
********************/
%>

              
<%
  String opName = request.getParameter("opName");
%>              
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http//www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http//www.w3.org/1999/xhtml">
<%@ include file="/npage/include/public_title_name.jsp" %> 


<%@ page contentType= "text/html;charset=gb2312" %>
 
<HTML><HEAD><TITLE><%=opName%></TITLE>
<META content="text/html; charset=gb2312" http-equiv=Content-Type>
<META content=no-cache http-equiv=Pragma>
<META content=no-cache http-equiv=Cache-Control>


<%
String regionCode = (String)session.getAttribute("regCode");

String iChnSource = "01";
String sysAcceptl = WtcUtil.repNull(request.getParameter("sysAcceptl"));
String opCode = WtcUtil.repNull(request.getParameter("opCode"));

String workNo = (String)session.getAttribute("workNo");
String loginPwd = (String)session.getAttribute("password");
String phoneNo = WtcUtil.repNull(request.getParameter("userPhNo"));
String loverNo = WtcUtil.repNull(request.getParameter("loverPhNo"));
String fprodId = WtcUtil.repNull(request.getParameter("fprodId"));
String opNote =  WtcUtil.repNull(request.getParameter("opNote"));
System.out.println("-------------sysAcceptl--------------"+sysAcceptl);
System.out.println("-------------iChnSource--------------"+iChnSource);
System.out.println("-------------opCode------------------"+opCode);
System.out.println("-------------workNo------------------"+workNo);
System.out.println("-------------loginPwd----------------"+loginPwd);
System.out.println("-------------phoneNo-----------------"+phoneNo);
System.out.println("-------------loverNo-----------------"+loverNo);
System.out.println("-------------fprodId-----------------"+fprodId);
System.out.println("-------------opNote------------------"+opNote);
%>	 	
		<wtc:service name="s7690Cfm" outnum="13" retmsg="msg" retcode="code" routerKey="region" routerValue="<%=regionCode%>">
			<wtc:param value="<%=sysAcceptl%>" />
			<wtc:param value="<%=iChnSource%>" />	
			<wtc:param value="<%=opCode%>" />		
			<wtc:param value="<%=workNo%>" />			
			<wtc:param value="<%=loginPwd%>" />				
			<wtc:param value="<%=phoneNo%>" />					
			<wtc:param value="" />						
			<wtc:param value="<%=loverNo%>" />							
			<wtc:param value="" />	
			<wtc:param value="<%=fprodId%>" />								
			<wtc:param value="<%=opNote%>" />									
		</wtc:service>
		<wtc:array id="result_t2" scope="end" />
			
			
			<%String url ="/npage/contact/upCnttInfo.jsp?opCode="+opCode+
							"&retCodeForCntt="+code+
							"&opName="+opName+
							"&workNo="+workNo+
							"&loginAccept="+sysAcceptl+
							"&pageActivePhone="+phoneNo+
							"&retMsgForCntt="+msg+
							"&opBeginTime="+opBeginTime; 
							
							System.out.println("统一接触："+url);
							%>
<jsp:include page="<%=url%>" flush="true" />
	
	
<%

System.out.println("----------code---------"+code);
System.out.println("----------msg----------"+msg);
		if(code.equals("000000")){
%>
<script language="JavaScript">
	 rdShowMessageDialog("业务办理成功",2);
	 removeCurrentTab();
</script>
<%}else{
	%>
	<script language="JavaScript">
	 rdShowMessageDialog("<%=code%>:<%=msg%>",0);
	 history.go(-1);
</script>
	<%}%> 



						
  					
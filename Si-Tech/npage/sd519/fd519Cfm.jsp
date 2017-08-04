<%
  /*
   * 功能: 预存有礼赠亲朋 d519
   * 版本: 1.8.2
   * 日期: 2011/4/22
   * 作者: huangrong
   * 版权: si-tech
   * update:
  */
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
String login_accept = WtcUtil.repNull(request.getParameter("login_accept"));	
String opCode = WtcUtil.repNull(request.getParameter("iOpCode"));
String workNo = (String)session.getAttribute("workNo");
String loginPwd = (String)session.getAttribute("password");
String ipAddr = (String)session.getAttribute("ipAddr");
String phoneNo = WtcUtil.repNull(request.getParameter("phoneNo"));
String bindNo = WtcUtil.repNull(request.getParameter("bindNo"));
String returnFee = WtcUtil.repNull(request.getParameter("returnFee"));
%>	 	
		<wtc:service name="sd519Cfm" outnum="2" retmsg="msg" retcode="code" routerKey="region" routerValue="<%=regionCode%>">
			<wtc:param value="<%=login_accept%>" />
			<wtc:param value="<%=iChnSource%>" />	
			<wtc:param value="<%=opCode%>" />		
			<wtc:param value="<%=workNo%>" />			
			<wtc:param value="<%=loginPwd%>" />				
			<wtc:param value="<%=phoneNo%>" />					
			<wtc:param value="" />						
			<wtc:param value="<%=bindNo%>" />		
			<wtc:param value="<%=returnFee%>" />										
			<wtc:param value="<%=ipAddr%>" />								
			<wtc:param value="" />									
		</wtc:service>
		<wtc:array id="result_t2" scope="end" />
			
			
			<%String url ="/npage/contact/upCnttInfo.jsp?opCode="+opCode+
							"&retCodeForCntt="+code+
							"&opName="+opName+
							"&workNo="+workNo+
							"&loginAccept="+login_accept+
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
	 window.location="/npage/sd519/fd519_login.jsp?activePhone=<%=phoneNo%>&opCode=d519&opName=预存有礼赠亲朋";
</script>
<%}else{
	%>
	<script language="JavaScript">
	 rdShowMessageDialog("<%=code%>:<%=msg%>",0);
	 history.go(-1);
</script>
	<%}%> 



						
  					

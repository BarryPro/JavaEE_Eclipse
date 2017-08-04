<%
  /*
   * 功能: 手机凭证重发 d619
   * 版本: 1.8.2
   * 日期: 2011/5/13
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

<%@ include file="../../npage/bill/getMaxAccept.jsp" %>


<%@ page contentType= "text/html;charset=gb2312" %>
 
<HTML><HEAD><TITLE><%=opName%></TITLE>
<META content="text/html; charset=gb2312" http-equiv=Content-Type>
<META content=no-cache http-equiv=Pragma>
<META content=no-cache http-equiv=Cache-Control>


<%
String iChnSource = "01";
String regionCode = (String)session.getAttribute("regCode");
String workNo = (String)session.getAttribute("workNo");
String workPwd = (String)session.getAttribute("password");
String ipAddr = (String)session.getAttribute("ipAddr");
String phoneNo = WtcUtil.repNull(request.getParameter("phoneNo"));
String opCode = WtcUtil.repNull(request.getParameter("iOpCode"));
String login_accept="";
login_accept = getMaxAccept();
%>	 	
		<wtc:service name="sd619Cfm" outnum="2" retmsg="msg" retcode="code" routerKey="region" routerValue="<%=regionCode%>">
			<wtc:param value=" " />
			<wtc:param value="<%=iChnSource%>" />	
			<wtc:param value="<%=opCode%>" />		
			<wtc:param value="<%=workNo%>" />			
			<wtc:param value="<%=workPwd%>" />				
			<wtc:param value="<%=phoneNo%>" />					
			<wtc:param value="" />						
			<wtc:param value="<%=ipAddr%>" />																		
		</wtc:service>
		<wtc:array id="sd619Cfm_result" scope="end" />
			
			
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
if(code.equals("000000")){
%>
		<script language="JavaScript">
			 rdShowMessageDialog("业务办理成功",2);
			 window.location="/npage/sd619/fd619_login.jsp?activePhone=<%=phoneNo%>&opCode=d619&opName=手机凭证重发";
		</script>
<%
}else{
%>
		<script language="JavaScript">
		 rdShowMessageDialog("<%=code%>:<%=msg%>",0);
		 history.go(-1);
	  </script>
<%
}
%> 



						
  					


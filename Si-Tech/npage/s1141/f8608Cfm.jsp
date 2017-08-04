<%
/********************
version v2.0
开发商: si-tech
update:anln@2009-02-24 页面改造,修改样式
********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType="text/html;charset=Gb2312"%>
<%@ include file="/npage/include/public_title_name.jsp" %>

<%	
	
	
	String opCode = request.getParameter("opcode");
	String opName = (String)request.getParameter("opName");	
	String regionCode= (String)session.getAttribute("regCode");
	System.out.println("opCode==================="+opCode);
	System.out.println("opName==================="+opName);
	
	String work_no =(String)session.getAttribute("workNo");	
	String ip_Addr = (String)session.getAttribute("ipAddr");  
	
	String paraAray[] = new String[6];
	paraAray[0] =request.getParameter("login_accept");
	paraAray[1] = request.getParameter("phone_no");
	paraAray[2] = request.getParameter("opcode");
    	paraAray[3] = work_no;
    	paraAray[4] = request.getParameter("backaccept");
	paraAray[5] = request.getParameter("opNote");
   
	//String[] ret = impl.callService("s8608Cfm",paraAray,"2","region",org_code.substring(0,2));
%>
	<wtc:service name="s8608Cfm" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode1" retmsg="retMsg1" outnum="2" >
		<wtc:param value="<%=paraAray[0]%>"/>
		<wtc:param value="<%=paraAray[1]%>"/>
		<wtc:param value="<%=paraAray[2]%>"/>
		<wtc:param value="<%=paraAray[3]%>"/>
		<wtc:param value="<%=paraAray[4]%>"/>
		<wtc:param value="<%=paraAray[5]%>"/>		
	</wtc:service>
<%
	String errCode = retCode1;
	String errMsg =retMsg1;
	if (errCode.equals("000000"))
	{
%>
	<script language="JavaScript">
	   rdShowMessageDialog("预存话费送笔记本冲正成功!",2);
	   history.go(-2);
	</script>
<%
	}else{
%>   
	<script language="JavaScript">
		rdShowMessageDialog("预存话费送笔记本冲正失败!(<%=errMsg%>",0);
		history.go(-2);
	</script>
<%}%>
<%String url ="/npage/contact/upCnttInfo.jsp?opCode="+opCode+"&retCodeForCntt="+retCode1+"&opName="+opName+"&workNo="+work_no+"&loginAccept="+paraAray[0]+"&pageActivePhone="+paraAray[1]+"&retMsgForCntt="+retMsg1+"&opBeginTime="+opBeginTime; %>
<jsp:include page="<%=url%>" flush="true" />
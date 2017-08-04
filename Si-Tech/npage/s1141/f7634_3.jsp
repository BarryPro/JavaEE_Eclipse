<%
/********************
 version v2.0
 开发商: si-tech
 update sunaj at 2009.9.8
********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html  xmlns="http://www.w3.org/1999/xhtml">
	
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page contentType="text/html;charset=GBK"%>
<%@ page import="java.util.*"%>
<%
  request.setCharacterEncoding("GBK");
%>
<html>
<head>
<title>TD修改IMEI绑定关系</title>
<%
	String loginNo = (String)session.getAttribute("workNo");
	String orgCode = (String)session.getAttribute("orgCode");
  	String regionCode = (String)session.getAttribute("regCode");
  	String passWord = (String)session.getAttribute("password");
  	String opCode=request.getParameter("opCode");
  	String opName=request.getParameter("opName");
  	
  	String paraAray[] = new String[8];
  	paraAray[0] = request.getParameter("login_accept");
  	paraAray[1] = "01";
  	paraAray[2] = opCode;
  	paraAray[3] = loginNo;
  	paraAray[4] = passWord;
  	paraAray[5] = request.getParameter("phone_no");
  	paraAray[6] = "";
  	paraAray[7] = request.getParameter("new_imei");
  	
  	System.out.println("=============++++++++++++++++++++++++++++++++++=================");
  	
%>
<wtc:service  name="s7634Cfm" routerKey="region" routerValue="<%=regionCode%>" outnum="2"  retcode="errCode" retmsg="errMsg">
	<wtc:param  value="<%=paraAray[0]%>"/>
	<wtc:param  value="<%=paraAray[1]%>"/>
	<wtc:param  value="<%=paraAray[2]%>"/>
	<wtc:param  value="<%=paraAray[3]%>"/>
	<wtc:param  value="<%=paraAray[4]%>"/>
	<wtc:param  value="<%=paraAray[5]%>"/>
	<wtc:param  value="<%=paraAray[6]%>"/>
	<wtc:param  value="<%=paraAray[7]%>"/>
</wtc:service>
<wtc:array id="ret" scope="end"/>
<%
	String url = "/npage/contact/upCnttInfo.jsp?opCode="+opCode+"&retCodeForCntt="+errCode+"&opName="+opName+"&workNo="+loginNo+"&loginAccept="+paraAray[0]+"&pageActivePhone="+paraAray[5]+"&retMsgForCntt="+errMsg+"&opBeginTime="+opBeginTime;

	if (errCode.equals("0")||errCode.equals("000000"))
	{
%>
	<script language="JavaScript">
		rdShowMessageDialog("修改IMEI绑定关系成功!");
		window.location="/npage/s1141/f7634_1.jsp?opCode=7634&opName=TD修改IMEI绑定关系";
	</script>
<%
	}else{
%>
<script language="JavaScript">
	rdShowMessageDialog("修改IMEI绑定关系失败!(<%=errMsg%>",0);
	window.location="/npage/s1141/f7634_1.jsp?opCode=7634&opName=TD修改IMEI绑定关系";
</script>
<%}%>
<jsp:include page="<%=url%>" flush="true"/>

	
  	
  	
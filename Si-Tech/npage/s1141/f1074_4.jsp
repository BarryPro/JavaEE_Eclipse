<%
/********************
 version v2.0
 开发商: si-tech
 update zhaoxin
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
<title>铁通固话入网IMEI绑定</title>
<%
	String loginNo = (String)session.getAttribute("workNo");
	String orgCode = (String)session.getAttribute("orgCode");
  	String regionCode = (String)session.getAttribute("regCode");
  	String nopass = (String)session.getAttribute("password");
  	String opcode=request.getParameter("opcode");
  	String opName=request.getParameter("opName");
  	String PhoneNo = request.getParameter("phoneNo");
  	String chnSource = "01";
  	String userPwd = "";
  	String machType = request.getParameter("phone_type");
  	String saleCode = request.getParameter("sale_code");
  	String loginAccept = request.getParameter("login_accept");
  	String IMEINo = request.getParameter("IMEINo");
  	String bxMonth = request.getParameter("repairLimit");
  	
  	
  	String paraAray[] = new String[11];
  	paraAray[0] = loginAccept;
  	paraAray[1] = chnSource;
  	paraAray[2] = opcode;
  	paraAray[3] = loginNo;
  	paraAray[4] = nopass;
  	paraAray[5] = PhoneNo;
  	paraAray[6] = userPwd;
  	paraAray[7] = IMEINo;
  	paraAray[8] = machType;
  	paraAray[9] = saleCode;
  	paraAray[10] = bxMonth;
%>
<wtc:service  name="s1074Cfm" routerKey="region" routerValue="<%=regionCode%>" outnum="2"  retcode="errCode" retmsg="errMsg">
	<wtc:param  value="<%=paraAray[0]%>"/>
	<wtc:param  value="<%=paraAray[1]%>"/>
	<wtc:param  value="<%=paraAray[2]%>"/>
	<wtc:param  value="<%=paraAray[3]%>"/>
	<wtc:param  value="<%=paraAray[4]%>"/>
	<wtc:param  value="<%=paraAray[5]%>"/>
	<wtc:param  value="<%=paraAray[6]%>"/>
	<wtc:param  value="<%=paraAray[7]%>"/>
	<wtc:param  value="<%=paraAray[8]%>"/>
	<wtc:param  value="<%=paraAray[9]%>"/>
	<wtc:param  value="<%=paraAray[10]%>"/>
	<wtc:param  value="1"/>
</wtc:service>
<wtc:array id="ret" scope="end"/>
<%
	String url = "/npage/contact/upCnttInfo.jsp?opCode="+opcode+"&retCodeForCntt="+errCode+"&opName="+opName+"&workNo="+loginNo+"&loginAccept="+paraAray[0]+"&pageActivePhone="+PhoneNo+"&retMsgForCntt="+errMsg+"&opBeginTime="+opBeginTime;

	if (errCode.equals("0")||errCode.equals("000000"))
	{
%>
	<script language="JavaScript">
		rdShowMessageDialog("铁通自采终端固话入网IMEI绑定成功!");
		window.location="f1074_login.jsp?activePhone=<%=PhoneNo%>&opCode=<%=opcode%>";
	</script>
<%
	}else{
%>
<script language="JavaScript">
	rdShowMessageDialog("铁通自采终端固话入网IMEI绑定失败!(<%=errMsg%>",0);
	window.location="f1074_login.jsp?activePhone=<%=PhoneNo%>&opCode=<%=opcode%>";
</script>
<%}%>
<jsp:include page="<%=url%>" flush="true"/>

	
  	
  	
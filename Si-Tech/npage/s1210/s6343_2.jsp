<%
  /* *********************
   * 功能:号码过户限制时间修改
   * 版本: 1.0
   * 日期: 2010/01/26
   * 作者: cangjin
   * 版权: si-tech
   * *********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//Dtd XHTML 1.0 transitional//EN" "http://www.w3.org/tr/xhtml1/Dtd/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page contentType="text/html;charset=GBK"%>
<%@ page import="java.util.*"%>
<%
	request.setCharacterEncoding("GBK");
%>
<%
	String opCode = "6343";
	String work_no = (String)session.getAttribute("workNo");
  String regionCode= (String)session.getAttribute("regCode");
  
  String phone_no = request.getParameter("phoneNo");
  String beginTime = request.getParameter("beginTime");
  String password = (String)session.getAttribute("password");
  
  System.out.println("#####################phone_no : " + phone_no);
  System.out.println("#####################beginTime : " + beginTime);
%>
<wtc:service name="s6342Cfm" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode" retmsg="retMsg" outnum="2">
		<wtc:param value=""/>
		<wtc:param value="01"/>
		<wtc:param value="<%=opCode%>"/>
		<wtc:param value="<%=work_no%>"/>
		<wtc:param value="<%=password%>"/>
		<wtc:param value="<%=phone_no%>"/>
		<wtc:param value=""/>
		<wtc:param value="<%=beginTime%>"/>
</wtc:service>
<wtc:array id="ret" scope="end"/>
<%
	if (retCode.equals("0")||retCode.equals("000000"))
	{
%>
			<script language="JavaScript">
				rdShowMessageDialog("提交成功! ");
				var phone_no = <%=phone_no%>;
				window.location="s6343_login.jsp?opCode=6343&opName=号码过户限制时间修改&activePhone=" + phone_no;
			</script>
<%
	}else{
%>
			<script language="JavaScript">
				rdShowMessageDialog("提交失败!(<%=retMsg%>");
				var phone_no = <%=phone_no%>;
				window.location="s6343_login.jsp?opCode=6343&opName=号码过户限制时间修改&activePhone=" + phone_no;
			</script>
<%}%>
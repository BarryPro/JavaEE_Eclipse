<!DOCTYPE html PUBLIC "-//W3C//Dtd XHTML 1.0 transitional//EN" "http://www.w3.org/tr/xhtml1/Dtd/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page contentType="text/html;charset=GBK"%>
<%
	String workNo = (String)session.getAttribute("workNo");
  String password = (String)session.getAttribute("password");
  String regionCode= (String)session.getAttribute("regCode");
	String opCode =  request.getParameter("opCode");
  String opName =  request.getParameter("opName");
	String printAccept =  request.getParameter("printAccept");
	String preFromNo =  request.getParameter("preFromNo");
	String preToNo =  request.getParameter("preToNo");
	String phoneNo =  request.getParameter("phoneNo");
	String returnUrl = "/npage/se761/fe759Login.jsp?opCode="+opCode+"&opName="+opName;
%>
		<wtc:service name="sPreSrcCfm" routerKey="region" routerValue="<%=regionCode%>"
		  retcode="retCode" retmsg="retMsg" outnum="1">
			<wtc:param value="<%=printAccept%>"/>
			<wtc:param value="01"/>
			<wtc:param value="<%=opCode%>"/>
			<wtc:param value="<%=workNo%>"/>
			<wtc:param value="<%=password%>"/>
			<wtc:param value="<%=phoneNo%>"/>
			<wtc:param value=""/>
			<wtc:param value="<%=preFromNo%>"/>
			<wtc:param value="<%=preToNo%>"/>
		</wtc:service>
		<wtc:array id="result" scope="end"/>
<%
	if("000000".equals(retCode)){
%>
		<script language="JavaScript">
			rdShowMessageDialog("提交成功！");
			location="<%=returnUrl%>";
		</script>
<%
	}else{
%>
		<script language="JavaScript">
			rdShowMessageDialog("提交失败！" + "<%=retCode%>," + "<%=retMsg%>");
			location="<%=returnUrl%>";
		</script>
<%
	}
%>
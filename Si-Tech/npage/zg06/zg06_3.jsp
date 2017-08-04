<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%request.setCharacterEncoding("GBK");%>
<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="com.sitech.boss.pub.config.*" %>
<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>
<%@ taglib uri="/WEB-INF/wtc.tld" prefix="wtc" %>
<%
    String opCode = "zg06";
    String opName = "集团产品余额提醒阀值设置";
	String unit_id=request.getParameter("unit_id");

	String account_id = request.getParameter("account_id");
 
	String fz = request.getParameter("fz");
	String workno = (String)session.getAttribute("workNo");
	String old_ls = request.getParameter("old_ls");
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<HEAD><TITLE>集团产品余额提醒阀值设置</TITLE>
	
</HEAD>
<body>


<FORM method=post name="frm">
<%@ include file="/npage/include/header.jsp" %>
 

<wtc:service name="szg06Cfm" retcode="retCode1" retmsg="retMsg1" outnum="2">
		<wtc:param value="<%=unit_id%>"/>
		<wtc:param value="<%=account_id%>"/>
		<wtc:param value="<%=workno%>"/>
		<wtc:param value="<%=fz%>"/>
		<wtc:param value="<%=old_ls%>"/>
</wtc:service>
<wtc:array id="ret_val1" scope="end"   />	 
<%
	String return_code="";
	String return_msg="";

	return_code=retCode1;
	return_msg=retMsg1;
 	if(!return_code.equals("000000"))
	{
		%>
			<script language="javascript">
				rdShowMessageDialog("集团产品余额提醒阀值设置失败!错误代码"+"<%=return_code%>，错误原因："+"<%=return_msg%>");
				//history.go(-1);
				window.location.href="zg06_1.jsp";
			</script>
		<%
	}
	else
	{
		%>
		
			
		<script language="javascript">
				rdShowMessageDialog("集团产品余额提醒阀值设置成功！");
				window.location.href="zg06_1.jsp";
		</script>	
			 

		<%
	}
%>



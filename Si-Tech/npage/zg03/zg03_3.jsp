<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%request.setCharacterEncoding("GBK");%>
<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="com.sitech.boss.pub.config.*" %>
<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>
<%@ taglib uri="/WEB-INF/wtc.tld" prefix="wtc" %>
<%
    String opCode = "zg03";
    String opName = "网厅空中充值审批";
	
	//工号 手机号码 账号
	String workno = (String)session.getAttribute("workNo");
	 
	String phone_arrays = request.getParameter("phone_arrays");
	String conArrays = request.getParameter("conArrays");
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<HEAD><TITLE>网厅空中充值审批</TITLE>
	
</HEAD>
<body>


<FORM method=post name="frm">
<%@ include file="/npage/include/header.jsp" %>
 

<wtc:service name="s5255_Limit" retcode="retCode1" retmsg="retMsg1" outnum="2">
		<wtc:param value="<%=workno%>"/>
		<wtc:param value="<%=phone_arrays%>"/>
		<wtc:param value="<%=conArrays%>"/>
</wtc:service>
<wtc:array id="ret_val1" scope="end"   />	 
<%
	String return_code="";
	String return_msg="";

	return_code=ret_val1[0][0];
	return_msg=ret_val1[0][1];
 	if(!return_code.equals("000000"))
	{
		%>
			<script language="javascript">
				rdShowMessageDialog("网厅空中充值审批办理失败!错误代码"+"<%=return_code%>，错误原因："+"<%=return_msg%>");
				//history.go(-1);
				window.location.href="zg03_1.jsp";
			</script>
		<%
	}
	else
	{
		%>
		
			
		<script language="javascript">
				rdShowMessageDialog("网厅空中充值审批办理成功！");
				window.location.href="zg03_1.jsp";
		</script>	
			 

		<%
	}
%>



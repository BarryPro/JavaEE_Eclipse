<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%request.setCharacterEncoding("GBK");%>
<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="com.sitech.boss.pub.config.*" %>
<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>
<%@ taglib uri="/WEB-INF/wtc.tld" prefix="wtc" %>
<%
    String opCode = "zg01";
    String opName = "һ��֧������ͳ���ֹ�����";
	String contract_no=request.getParameter("contract_no");

	String pay_money = request.getParameter("pay_money");
	//xl add for hxl ��ѡ��ѡ
	String contract_Nos_Arrays = request.getParameter("contract_Nos_Arrays");
	String workno = (String)session.getAttribute("workNo");
	String nopass = (String)session.getAttribute("password");
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<HEAD><TITLE>һ��֧������ͳ���ֹ�����</TITLE>
	
</HEAD>
<body>


<FORM method=post name="frm">
<%@ include file="/npage/include/header.jsp" %>
 

<wtc:service name="bs_zg01Cfm" retcode="retCode1" retmsg="retMsg1" outnum="2">
		<wtc:param value="<%=contract_no%>"/>
		<wtc:param value="<%=pay_money%>"/>
		<wtc:param value="<%=contract_Nos_Arrays%>"/>
		<wtc:param value="<%=workno%>"/>
		 
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
				rdShowMessageDialog("����֧���ֶ���������ʧ��!�������"+"<%=return_code%>������ԭ��"+"<%=return_msg%>");
				//history.go(-1);
				window.location.href="zg01_1.jsp";
			</script>
		<%
	}
	else
	{
		%>
		
			
		<script language="javascript">
				rdShowMessageDialog("����֧���ֶ���������ɹ���");
				window.location.href="zg01_1.jsp";
		</script>	
			 

		<%
	}
%>



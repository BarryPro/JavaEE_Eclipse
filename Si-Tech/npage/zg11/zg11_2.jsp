<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%request.setCharacterEncoding("GBK");%>
<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="com.sitech.boss.pub.config.*" %>
<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>
<%@ taglib uri="/WEB-INF/wtc.tld" prefix="wtc" %>

<%
    String opCode = "zg11";
    String opName = "GPRS流量状态查";
	String phone_no=request.getParameter("phone_no");
	String s_flag = request.getParameter("flag");
	String s_bz="";
	if(s_flag=="1"||s_flag.equals("1"))
	{
		s_bz="D";
		%><script language="javascript">//alert("需要配wtcD 关闭");</script><%
		System.out.println("aaaaaaaaaaaaaaaaaaaaaaaaaaa "+s_bz);
	}
	else
	{
		s_bz="A";
		%><script language="javascript">//alert("A 开通");</script><%
		System.out.println("ccccccccccccccccccccccccccc "+s_bz);
	}

	//参数入参
	String workno = (String)session.getAttribute("workNo");
	String nopass = (String)session.getAttribute("password");
	String s_param_opCode="6335";
	String ret_val[][];

	String return_code="";
	String return_msg="";
%>
   
<wtc:service name="s6335Cfm" retcode="retCode1" retmsg="retMsg1" outnum="2">
	<wtc:param value="<%=workno%>"/>
	<wtc:param value="<%=nopass%>"/>
	<wtc:param value="<%=s_param_opCode%>"/>
	<wtc:param value="<%=phone_no%>"/>
	<wtc:param value="<%=s_bz%>"/>
</wtc:service>
<wtc:array id="ret_vals" scope="end" />	 
 
<%
	return_code=retCode1;
	return_msg=retMsg1;
 	if(!return_code.equals("000000"))
	{
		%>
			<script language="javascript">
				rdShowMessageDialog("调用接口失败!错误代码"+"<%=return_code%>，错误原因："+"<%=return_msg%>");
				//history.go(-1);
				window.location.href="zg11_1.jsp?activePhone=<%=phone_no%>";
			</script>
		<%
	}
	else
	{
		%>
			<script language="javascript">
				rdShowMessageDialog("开通/关闭成功!");
				//history.go(-1);
				window.location.href="zg11_1.jsp?activePhone=<%=phone_no%>";
			</script>
		<%	
	}
%> 
<html xmlns="http://www.w3.org/1999/xhtml">
<HEAD><TITLE>优惠信息提醒变更记录查询</TITLE>
</HEAD>
<body>


<FORM method=post name="frm1508_2">
<%@ include file="/npage/include/header.jsp" %>
<div class="title">
	<div id="title_zi">优惠信息提醒变更记录查询</div>
</div>

      
    
      	
    	    
        

<%@ include file="/npage/include/footer.jsp" %>
</FORM>
</BODY></HTML>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%request.setCharacterEncoding("GBK");%>
<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="com.sitech.boss.pub.config.*" %>
<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>
<%@ taglib uri="/WEB-INF/wtc.tld" prefix="wtc" %>

<%
    String opCode = "zgbn";
    String opName = "集团产品费用预警阀值设置";
	String account_id=request.getParameter("account_id");
	String thres_value = "";
	String op_type =  request.getParameter("op_type");
	String org_code = (String)session.getAttribute("orgCode");
	String regionCode = org_code.substring(0,2);
	String work_no = (String)session.getAttribute("workNo");
	String nopass = (String)session.getAttribute("password");
	String s_op_note="集团产品费用预警阀值删除";
%>
   
<wtc:service name="bs_zgbnCfm" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode2" retmsg="retMsg2" outnum="2">
			<wtc:param value="<%=opCode%>"/>
			<wtc:param value="<%=work_no%>"/>
			<wtc:param value="<%=account_id%>"/>
			<wtc:param value="<%=thres_value%>"/>
			<wtc:param value="<%=op_type%>"/>
			<wtc:param value="<%=s_op_note%>"/>
</wtc:service>
  
<wtc:array id="result1" scope="end" />
 
<html xmlns="http://www.w3.org/1999/xhtml">
<HEAD><TITLE>集团产品费用预警阀值设置</TITLE>
</HEAD>
<body>
<%
	if(retCode2=="000000" ||retCode2.equals("000000") )
	{
		%>
			<script language="javascript">
				rdShowMessageDialog("删除成功！");
				window.location.href="zgbn_del.jsp";
			</script>
		<%
	}
	else
	{
		%>
			<script language="javascript">
				rdShowMessageDialog("删除失败！错误代码:"+"<%=retCode2%>,错误原因:"+"<%=retMsg2%>");
				window.location.href="zgbn_del.jsp";
			</script>
		<%
	}
%>

 
</BODY></HTML>


<%
/********************
 version v2.0
开发商: si-tech
*
*update:zhanghonga@2008-08-15 页面改造,修改样式
*
********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%request.setCharacterEncoding("GBK");%>
<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="java.text.*" %> 
<%@ page import="java.util.*" %>
<%
    String opCode = "zg10";
    String opName = "集团自由划拨";
	String unit_id=request.getParameter("unit_id");

	//group_no_id="+group_no_id+"&group_no_pay="+group_no_pay+"&group_name="+group_name;
	String group_no_id = request.getParameter("group_no_id");
	String group_no_pay = request.getParameter("group_no_pay");
	String group_name = request.getParameter("group_name");
	String workno = (String)session.getAttribute("workNo");
	String group_accept = request.getParameter("group_accept");
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<HEAD><TITLE>集团自由划拨</TITLE>
	
</HEAD>
<body>


<FORM method=post name="frm">
<%@ include file="/npage/include/header.jsp" %>
 

<wtc:service name="szg10Cfm" retcode="retCode1" retmsg="retMsg1" outnum="2">
		<wtc:param value="<%=group_no_id%>"/>
		<wtc:param value="<%=group_no_pay%>"/>
		<wtc:param value="<%=workno%>"/>
		<wtc:param value="<%=group_name%>"/>
		<wtc:param value="<%=group_accept%>"/> 
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
				rdShowMessageDialog("集团自由划拨失败!错误代码"+"<%=return_code%>，错误原因："+"<%=return_msg%>");
				//history.go(-1);
				window.location.href="zg10_1.jsp";
			</script>
		<%
	}
	else
	{
		 
		 %>
			<script language="javascript">
				rdShowMessageDialog("集团自由划拨成功");
				//history.go(-1);
				window.location.href="zg10_1.jsp";
			</script>
		<%
	}
%>



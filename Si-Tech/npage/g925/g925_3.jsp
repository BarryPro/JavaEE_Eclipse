<%
/********************
 version v2.0
开发商: si-tech
********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page contentType="text/html;charset=GBK"%>
<%@ page import="com.sitech.boss.pub.config.*" %>
<%@ page import="com.sitech.boss.pub.util.*"%>
<%@ include file="../../npage/common/serverip.jsp" %>
<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>
<%/*
* name    : 
* author  : changjiang@si-tech.com.cn
* created : 2003-11-01
* revised : 2003-12-31
*/%>
<%
String opCode = "g925";
String opName = "小额流量费用争议退费";
String workno = (String)session.getAttribute("workNo");
String workname =(String)session.getAttribute("workName");
String orgcode =(String)session.getAttribute("orgCode");//机构代码
String nopass =(String)session.getAttribute("password");
String regionCode = orgcode.substring(0,2);
String op_code = "g925"  ;
String phone_no = request.getParameter("phoneno");
String year_month = request.getParameter("year_month");
String fee = request.getParameter("fee");

 
%>
	<wtc:service name="bg925Cfm" routerKey="regionCode" routerValue="<%=regionCode%>"  retcode="sReturnCode" retmsg="sErrorMessage"  outnum="2" >
		<wtc:param value="<%=opCode%>"/>
		<wtc:param value="<%=workno%>"/>
		<wtc:param value="<%=nopass%>"/>
		<wtc:param value="<%=phone_no%>"/>
		<wtc:param value="<%=year_month%>"/>
		<wtc:param value="<%=fee%>"/>
	</wtc:service>
	<wtc:array id="result" scope="end"/>
 
<%   
	sReturnCode = result[0][0];
	sErrorMessage = result[0][1];
	if(!sReturnCode.equals("000000")){
		%>
			<script language="javascript">
				rdShowMessageDialog("退费失败。<br>错误代码：'<%=sReturnCode%>'。<br>错误信息：'<%=sErrorMessage%>'。",0);
				window.location.href="g925_1.jsp?activePhone=<%=phone_no%>";
			</script>
		<% 
		System.out.println("~~~~~~~~~~~~~~~~~~~~~~~g925 错误信息 : " + sErrorMessage);
	}
	
	else
	{
		System.out.println("success~~~~~~~~~~~~~~~~~~~~~~~~~ !");
		%>
			<script language="javascript">
				rdShowMessageDialog("退费成功.",2);
				window.location.href="g925_1.jsp?activePhone=<%=phone_no%>";
			</script>
		<% 
	}
	/*xl add for excel导出*/
	
%>
 




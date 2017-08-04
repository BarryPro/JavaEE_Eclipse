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
String opCode = "e277";
String opName = "网上预约选号和营销案的绑定";
String workno = (String)session.getAttribute("workNo");
String workname =(String)session.getAttribute("workName");
String orgcode =(String)session.getAttribute("orgCode");//机构代码
String nopass =(String)session.getAttribute("password");
String regionCode = orgcode.substring(0,2);
String op_code = "1008"  ;
String remark = request.getParameter("remark");
String sSaveName = request.getParameter("sSaveName");
String filename = request.getParameter("filename"); 
//String serverIp=request.getServerName();
String serverIp=realip.trim();
System.out.println("serverIp:"+serverIp);
//System.out.println("3_SBillItem:"+billitem);
String total_fee = "";
String total_no = "";
	int flag = 0;
	String projectType = request.getParameter("projectType");
	String Gift_Code = request.getParameter("Gift_Code");
	String sysAccept = request.getParameter("sysAccept");
%>

	<wtc:service name="se277Cfm" routerKey="regionCode" routerValue="<%=regionCode%>"  retcode="sReturnCode" retmsg="sErrorMessage"  outnum="4" >
		<wtc:param value="<%=sysAccept%>"/>
		<wtc:param value="01"/>
		<wtc:param value="e277"/>
		<wtc:param value="<%=workno%>"/>
		<wtc:param value="<%=nopass%>"/>
		<wtc:param value=""/>	
		<wtc:param value=""/>	
		<wtc:param value="<%=projectType%>"/>
		<wtc:param value="<%=Gift_Code%>"/>
		<wtc:param value="<%=sSaveName%>"/>
		<wtc:param value="<%=serverIp%>"/>	
		<wtc:param value="<%=remark%>"/>					
	</wtc:service>
	<wtc:array id="result" scope="end" />
<%   
	//sReturnCode = result[0][0];
	//sErrorMessage = result[0][1];
	if(!sReturnCode.equals("000000")){
	%>
<script language="javascript">
	rdShowMessageDialog("错误代码<%=sReturnCode%>，错误信息<%=sErrorMessage%>",0);
	location="fe277.jsp";
</script>
	<%
}else {
	%>
<script language="javascript">
	rdShowMessageDialog("网上预约选号和营销案的绑定成功！",2);
	location="fe277.jsp";
</script>

<%}%>
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
String opCode=request.getParameter("opCode");
String opName=request.getParameter("opName");
String workno = (String)session.getAttribute("workNo");
String workname =(String)session.getAttribute("workName");
String orgcode =(String)session.getAttribute("orgCode");//机构代码
String nopass =(String)session.getAttribute("password");
String regionCode = orgcode.substring(0,2);
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
String note = "";
	String sysAccept = request.getParameter("sysAccept");
	String addrUrl = request.getParameter("addrUrl");
	String operateNoVal = request.getParameter("operateNoVal");
	String note1 = "营销目标客户批量添加";
	String note2 = "营销目标客户批量删除";
	if("0".equals(operateNoVal)){
		note = note1;
	}else if("1".equals(operateNoVal)){
		note = note2;

  }

%>
<wtc:service name="se579Cfm" routerKey="region" routerValue="<%=regionCode%>" 
		retcode="retCode" retmsg="retMsg" outnum="2">
		<wtc:param value="<%=sysAccept%>"/>
		<wtc:param value="01"/>
		<wtc:param value="e856"/>
		<wtc:param value="<%=workno%>"/>
		<wtc:param value="<%=nopass%>"/>
		<wtc:param value=""/>
		<wtc:param value=""/>
	  <wtc:param value="<%=operateNoVal%>"/>
	  <wtc:param value="<%=note%>"/>
	  <wtc:param value="<%=addrUrl%>"/>
	  <wtc:param value="233345"/>
	  <wtc:param value="3221"/>
	  <wtc:param value="0"/>
	  <wtc:param value="<%=sSaveName%>"/>
		<wtc:param value="<%=serverIp%>"/>
	</wtc:service>
	<wtc:array id="result" scope="end" />
<%   
	//sReturnCode = result[0][0];
	//sErrorMessage = result[0][1];
	if(!retCode.equals("000000")){
	%>
<script language="javascript">
	rdShowMessageDialog("错误代码<%=retCode%>，错误信息<%=retMsg%>",0);
	location="fe579_main.jsp?opCode=<%=opCode%>&opName=<%=opName%>";
</script>
	<%
}else {
	%>
<script language="javascript">
<%
		if("0".equals(operateNoVal)){
		%>
		rdShowMessageDialog("营销目标客户批量添加成功！",2);
		<%
	}else if("1".equals(operateNoVal)){
		%>
		rdShowMessageDialog("营销目标客户批量删除成功！",2);
		<%
  }
%>
	location="fe579_main.jsp?opCode=<%=opCode%>&opName=<%=opName%>";
</script>

<%}%>
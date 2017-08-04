<%
	/*
	 * 功能: 保存各种状态下时间
	 * 版本: 1.0
	 * 日期: 2009/06/03
	 * 作者: xingzhan 
	 * 版权: sitech
	 * 
	 *  
	 */
%>

<%@ page contentType="text/html;charset=gb2312"%>
<%@ include file="/npage/include/public_title_ajax.jsp"%>
<%@ page import="com.sitech.crmpd.core.wtc.util.*,java.util.*"%>
<%
  String WorkNo = request.getParameter("WorkNo")==null||"".equals(request.getParameter("WorkNo"))?"":request.getParameter("WorkNo"); 
  System.out.println("=====yuanqs" + WorkNo);
  String oprTypeAll = request.getParameter("oprTypeAll")==null||"".equals(request.getParameter("oprTypeAll"))?"":request.getParameter("oprTypeAll"); 
  String oprType = request.getParameter("oprType")==null||"".equals(request.getParameter("oprType"))?"":request.getParameter("oprType"); 
  String sign = request.getParameter("sign")==null||"".equals(request.getParameter("sign"))?"":request.getParameter("sign"); 
  String staffNo = request.getParameter("staffNo")==null||"".equals(request.getParameter("staffNo"))?"":request.getParameter("staffNo"); 
  
  System.out.println("WorkNo="+WorkNo+";oprTypeAll="+oprTypeAll+";oprType="+oprType+";sign="+sign+";staffNo="+staffNo); 
%>
<wtc:service name="sKFRecordLogin" outnum="5">
	<wtc:param value="<%=oprTypeAll%>"/>
	<wtc:param value="<%=oprType%>"/>
	<wtc:param value="<%=sign%>"/>
	<wtc:param value="<%=staffNo%>"/>
	<wtc:param value="<%=WorkNo%>"/>
</wtc:service>
<wtc:array id="result"  scope="end"/>

<%
out.println("000000");

%> 
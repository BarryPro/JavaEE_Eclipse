<%@ page contentType= "text/html;charset=gb2312" %>
<%@ page import="com.sitech.boss.workflow.*"%>
<%@ page import="com.sitech.boss.workflow.cache.*"%>
<%

String _dataId = (String)request.getParameter("_dataId");
System.out.println("---------������棺"+_dataId);
WorkFlowCacheManager.remove(_dataId);
%>

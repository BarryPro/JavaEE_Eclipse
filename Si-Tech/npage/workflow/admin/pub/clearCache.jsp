<%@ page contentType= "text/html;charset=gb2312" %>
<%@ page import="com.sitech.boss.workflow.*"%>
<%@ page import="com.sitech.boss.workflow.cache.*"%>
<%

String _dataId = (String)request.getParameter("_dataId");
System.out.println("---------Çå³ý»º´æ£º"+_dataId);
WorkFlowCacheManager.remove(_dataId);
%>

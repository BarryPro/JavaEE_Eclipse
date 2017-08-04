<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html; charset=GBK"%>
<%@ include file="/npage/callbosspage/notices/head.jsp"%>
<%/*直接跳转到公告类型数修改页面.*/
response.sendRedirect("http://"+serverIpPort+serverCont+"/npage/notices/xtree_user_main.jsp?userId="+userId);
%>
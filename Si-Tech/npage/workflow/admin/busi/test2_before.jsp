<%@ page contentType= "text/html;charset=gb2312" %>
<%@ taglib uri="/WEB-INF/wtc.tld" prefix="wtc" %>
<%@ page import="java.util.*" %>
<%@ page import="com.sitech.boss.workflow.ParseParaxml" %>

<%
		Map _paramap = (Map)request.getAttribute("_paraMap");
  	String _1002 = (String)_paramap.get("_1002");
  	String _1003 = (String)_paramap.get("_1003");
  	int tmp = Integer.parseInt(_1002)-Integer.parseInt(_1003);
  	_paramap.put("_1007",String.valueOf(tmp));
  	System.out.println("_1007:"+tmp);
%>

 
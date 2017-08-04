<%@ page contentType="text/html;charset=gb2312"%>
<%@ include file="/npage/include/public_title_ajax.jsp"%>
<%@page import="com.sitech.crmpd.kf.cache.*"%>
<%
	String contactId = WtcUtil.repNull(request.getParameter("contactId"));
    String retCode="000000";
    try{
     DInstantCacheManager.getInstance().put(contactId,"");
     System.out.println("OOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOO"+contactId);	
    }
	catch(Exception e){
	retCode="000001";
	}
%>


var response = new AJAXPacket();
response.data.add("retCode",<%=retCode%>);
core.ajax.receivePacket(response);
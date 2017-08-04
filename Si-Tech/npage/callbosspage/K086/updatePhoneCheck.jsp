<%@ page contentType="text/html;charset=gb2312"%>
<%@ include file="/npage/include/public_title_ajax.jsp"%>
<%@page import="com.sitech.crmpd.kf.dto.dcallcall.Dcallcallyyyymm"%>
<%@page import="com.sitech.crmpd.kf.cache.DCallCacheManager"%>
<%
	String contactId = WtcUtil.repNull(request.getParameter("contactId"));
	String verifyType   = WtcUtil.repNull(request.getParameter("type"));
    String retCode="000000";
    try{
		Dcallcallyyyymm upatedcallcallpage=DCallCacheManager.getInstance().getValue(contactId);
		if(verifyType.equalsIgnoreCase("0")){
		upatedcallcallpage.setVertify_passwd_flag("Y");	
			
		}else{
		upatedcallcallpage.setOther_passwd_flag("Y");	
		}
	}
	catch(Exception e){
	retCode="000001";
	}

%>


var response = new AJAXPacket();
response.data.add("retCode",<%=retCode%>);
core.ajax.receivePacket(response);
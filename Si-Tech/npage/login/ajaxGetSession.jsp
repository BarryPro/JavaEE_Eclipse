<%@ page contentType= "text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>

<%
 	
 	String phone_kf_check = (String)session.getAttribute("phone_kf_check");
 	
  java.util.HashMap hm1 = (java.util.HashMap)session.getAttribute("phoneKfCheck");
  
  String phoneNo = WtcUtil.repNull(request.getParameter("phoneNo"));
  String phone_kf_flag = (String)hm1.get(phoneNo);
  if(phone_kf_flag==null) phone_kf_flag = "0";
  
    System.out.println("-----------phoneNo----------------"+phoneNo);
  
  	System.out.println("--------------ajaxGetSession.jsp--------------phone_kf_check---------"+phone_kf_check);
	  System.out.println("--------------ajaxGetSession.jsp--------------phone_kf_flag----------"+phone_kf_flag);
 	
%>

var response = new AJAXPacket();
response.data.add("phone_kf_check","<%=phoneNo%>");
response.data.add("phone_kf_flag","<%=phone_kf_flag%>");
core.ajax.receivePacket(response);
 
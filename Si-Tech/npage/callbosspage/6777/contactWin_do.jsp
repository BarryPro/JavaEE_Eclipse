<%@ page contentType="text/html;charset=gb2312"%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@page import="com.sitech.crmpd.kf.dto.dcallcall.Dcallcallyyyymm"%> 
<%@page import="com.sitech.crmpd.kf.cache.DCallCacheManager"%> 
<%@page import="com.sitech.crmpd.kf.ejb.client.KFEjbClient"%> 
<%@page import="java.util.Calendar"%>
<%@page import="com.sitech.crmpd.kf.ejb.client.KFEjbClient"%> 
<%
 String contactId=request.getParameter("contactId");
 String timemer =(String)KFEjbClient.queryForObject("getSysdate");
 System.out.println(timemer);
 
 String accept_phone= request.getParameter("accept_phone");
 String servicecity = request.getParameter("servicecity");
 String acc_long    = request.getParameter("acc_long");
 String contact_way = request.getParameter("contact_way");
 String language    = request.getParameter("language");
 String brand_name  = request.getParameter("brand_name");
 String brand_grade = request.getParameter("brand_grade");
 String region_code = request.getParameter("region_code");
 String cust_name   = request.getParameter("cust_name");
 String fax_no     = request.getParameter("fax_no");
 String mail_address = request.getParameter("mail_address");
 String cust_phone  = request.getParameter("cust_phone");
 String cust_addr  = request.getParameter("cust_addr");  
 String bak  = request.getParameter("bak"); 
 String retCode="00000";
 String retMsg="新增用户接触成功！";
 try{
	 Dcallcallyyyymm dcallcallyyyymm=new Dcallcallyyyymm();
	 dcallcallyyyymm.setContact_id(contactId);	
	 dcallcallyyyymm.setContactMonth(contactId.substring(0,6));
   dcallcallyyyymm.setAccept_phone(accept_phone);
   dcallcallyyyymm.setServicecity(servicecity);  
   dcallcallyyyymm.setAccept_long(acc_long);     
   dcallcallyyyymm.setAcceptid(contact_way);   
   dcallcallyyyymm.setLanguage(language);      
   dcallcallyyyymm.setSm_code(brand_name);    
   dcallcallyyyymm.setGrade_code(brand_grade);  
   dcallcallyyyymm.setRegion_code(region_code);  
   dcallcallyyyymm.setCust_name(cust_name);    
   dcallcallyyyymm.setFax_no(fax_no);       
   dcallcallyyyymm.setMail_address(mail_address);  
   dcallcallyyyymm.setContact_phone(cust_phone);   
   dcallcallyyyymm.setContact_address(cust_addr);   
   dcallcallyyyymm.setBegin_date(timemer);	
   dcallcallyyyymm.setEnd_date(timemer); 
   dcallcallyyyymm.setBak(bak);      
	 System.out.println(contactId+"!!!!");
	 DCallCacheManager.getInstance().put(contactId,dcallcallyyyymm);	
	 KFEjbClient.insert("insertDcallcall",dcallcallyyyymm);
	 }
 catch(Exception e){
 		e.printStackTrace();
	  retCode = "00001";
    retMsg = "新增用户接触失败！";
	}
%>

var response = new AJAXPacket();
response.data.add("retCode","<%=retCode%>");
core.ajax.receivePacket(response);
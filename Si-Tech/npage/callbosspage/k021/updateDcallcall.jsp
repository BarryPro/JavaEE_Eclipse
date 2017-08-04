<%@ page contentType="text/html;charset=gb2312"%>
<%@ include file="/npage/include/public_title_ajax.jsp"%>
<%@page import="com.sitech.crmpd.kf.dto.dcallcall.Dcallcallyyyymm"%>
<%@page import="com.sitech.crmpd.kf.ejb.client.KFEjbClient"%> 
<%@page import="com.sitech.crmpd.kf.cache.DCallCacheManager"%>

<%
	String contactId = WtcUtil.repNull(request.getParameter("contactid"));
	if(contactId!=null&&!contactId.equals("")&&contactId.length()>6){
	String acceptId=WtcUtil.repNull(request.getParameter("acceptId"));
	String isAnwser=WtcUtil.repNull(request.getParameter("isAnwser"));
	String datea=(String)KFEjbClient.queryForObject("getSysdate");
	//SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
    //datea=df.format(new Date());
	
   String retCode="000000";
	   try{
	   
		   Dcallcallyyyymm upatedcallcallpage=DCallCacheManager.getInstance().getValue(contactId);
		  if(isAnwser.equals("1")){
		  	upatedcallcallpage.setAcceptid(acceptId);
		  	upatedcallcallpage.setBegin_date(datea);
		  	upatedcallcallpage.setEnd_date(datea);
		  }else if(isAnwser.equals("3")){
		  	upatedcallcallpage.setBegin_date(datea);
		  	upatedcallcallpage.setEnd_date(datea);
		  }else if(isAnwser.equals("4")){
		  	upatedcallcallpage.setBegin_date(datea);
		  	upatedcallcallpage.setEnd_date(datea);
		  	upatedcallcallpage.setAcceptid(acceptId);
		  	upatedcallcallpage.setStaffhangup("0");
		  }
		  else{ 	
		  	upatedcallcallpage.setAcceptid(acceptId);
		  }
	  }
	  catch (Exception e)
	  {
	  retCode="000001";
	  }

out.println(retCode); 
} 
%>




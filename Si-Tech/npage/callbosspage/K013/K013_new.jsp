<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@page import="com.sitech.crmpd.kf.ejb.client.KFEjbClient"%> 
<%@page import="com.sitech.crmpd.kf.dto.dcallcall.Dcallcallyyyymm"%>
<%@page import="com.sitech.crmpd.kf.cache.DCallCacheManager" %>
<%@page import="java.util.Calendar"%>

<%
   String contact_id = WtcUtil.repNull(request.getParameter("contact_id"));
   String login_no = WtcUtil.repNull(request.getParameter("login_no"));
   String staffstatus = WtcUtil.repNull(request.getParameter("staffstatus"));
   String ccsworkno = WtcUtil.repNull(request.getParameter("ccsworkno"));
   String now_yyyy_mm = WtcUtil.repNull(request.getParameter("now_yyyy_mm"));
   String hang_up = WtcUtil.repNull(request.getParameter("hang_up"));
   	//String datea="";
   String datea =(String)KFEjbClient.queryForObject("getSysdate");
	//SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
    //datea=df.format(new Date());   
   String retCode="000000";
   String retMsg="³É¹¦";
   String avg_time="0";
    Dcallcallyyyymm upatedcallcallpage=DCallCacheManager.getInstance().getValue(contact_id);
    if(upatedcallcallpage!=null)
		    {
		    System.out.println("AAAAAAAAAAAAAAAAAAAAAAAA"+contact_id);
		    upatedcallcallpage.setRemark("1");
		    upatedcallcallpage.setEnd_date(datea);
		    upatedcallcallpage.setStaffhangup(hang_up);
		    if("13".equals(upatedcallcallpage.getAcceptid())){
	    		upatedcallcallpage.setEnd_date(upatedcallcallpage.getBegin_date());
	    	}
		   try{
		     String start=upatedcallcallpage.getBegin_date();
		     String end=upatedcallcallpage.getEnd_date();
		     Calendar startCTime = Calendar.getInstance();
		     int sy = Integer.parseInt(start.substring(0, 4));
		     int sm = Integer.parseInt(start.substring(5, 7));
		     int sd = Integer.parseInt(start.substring(8, 10));
		     int sh = Integer.parseInt(start.substring(11, 13));
		     int smi= Integer.parseInt(start.substring(14, 16));
		     int sms= Integer.parseInt(start.substring(17, 19));
		     startCTime.set(sy, sm - 1, sd,sh,smi,sms);
		     Calendar endCTime = Calendar.getInstance();
		     int ey = Integer.parseInt(end.substring(0, 4));
		     int em = Integer.parseInt(end.substring(5, 7));
		     int ed = Integer.parseInt(end.substring(8, 10));
		     int eh = Integer.parseInt(end.substring(11, 13));
		     int emi= Integer.parseInt(end.substring(14, 16));
		     int ems= Integer.parseInt(end.substring(17, 19));
		     endCTime.set(ey, em - 1, ed,eh,emi,ems);
		     
		     long startMill = startCTime.getTimeInMillis();
		     long endMill   = endCTime.getTimeInMillis();
		     long senconds  = (endMill - startMill)/(1000);
		          
		     upatedcallcallpage.setAccept_long(String.valueOf(senconds));   
		   }
		   catch(Exception e){
			   retCode="000001";
			   retMsg="Ê§°Ü";
		   }
		    
		    try{
		     upatedcallcallpage.setRemark("2");
		     System.out.println(upatedcallcallpage.toString());	          
	         KFEjbClient.update("updateDcallcall",upatedcallcallpage); 
	         DCallCacheManager.getInstance().remove(contact_id);	     
		    }
		    catch(Exception e){
		    	retCode="000002";
			    retMsg="Ê§°Ü";
		    }	   
		    Integer inta=(Integer)KFEjbClient.queryForObject("getAvgTime",upatedcallcallpage);		    
		    avg_time=String.valueOf(inta);
		    }
    else
    {
        retCode="000003";
	    retMsg="Ê§°Ü";
    }
    out.println(("retCode|"+retCode+"|retMsg|"+retMsg+"|avg_time|"+avg_time).trim());
%>




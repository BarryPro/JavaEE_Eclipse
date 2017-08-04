<%@page contentType="text/html;charset=GBK"%>
<%@page import="com.sitech.crmpd.kf.ejb.client.KFEjbClient"%> 
<%@page import="com.sitech.crmpd.kf.dto.dcallcall.Dcallcallyyyymm"%> 
<%@page import="com.sitech.crmpd.kf.cache.DCallCacheManager"%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>

<%   
        String retCode="000000";
       try{

  		String strNodeId=request.getParameter("strNodeId")==null?"":request.getParameter("strNodeId");
		String strNodeName=request.getParameter("strNodeName")==null?"":request.getParameter("strNodeName");
		String strContactId=request.getParameter("strContactId")==null?"":request.getParameter("strContactId");
		String strContactMonth=request.getParameter("contactMonth")==null?"":request.getParameter("contactMonth");
		String remarkInfo= request.getParameter("remarkInfo")==null?"":request.getParameter("remarkInfo"); 
		
        Dcallcallyyyymm upatedcallcallpage=DCallCacheManager.getInstance().getValue(strContactId);
        if(upatedcallcallpage!=null)
        {     
		upatedcallcallpage.setContact_id(strContactId);
		upatedcallcallpage.setCall_cause_id(strNodeId);
		upatedcallcallpage.setBak(remarkInfo);
		upatedcallcallpage.setCallcausedescs(strNodeName);
		upatedcallcallpage.setContactMonth(strContactMonth);
		}
		else
		{
		Dcallcallyyyymm causeDcall=new Dcallcallyyyymm();
		causeDcall.setContact_id(strContactId);
		causeDcall.setCall_cause_id(strNodeId);
		causeDcall.setBak(remarkInfo);
		causeDcall.setCallcausedescs(strNodeName);
		causeDcall.setContactMonth(strContactMonth);
		KFEjbClient.update("updateCauseDcall",causeDcall); 
		}		
		
     }catch(Exception e)
     {
        retCode="999999";
     
     }
           
%>
var response = new AJAXPacket();
response.data.add("retCode",<%=retCode%>);
core.ajax.receivePacket(response);				 
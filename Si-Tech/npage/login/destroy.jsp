<%@ page import="java.util.Map"%>
<%@ page import="com.sitech.crmpd.boss.bo.ContactInfo"%>
<%@ taglib uri="/WEB-INF/wtc.tld" prefix="wtc" %> 
<%
    String gCustId  = request.getParameter("phone_no")==null?"":request.getParameter("phone_no");
    String Contact_id= "";
        
	  //System.out.println("======url=====");
	  //System.out.println("======url1=====");

   try{    
        Map map = (Map)session.getAttribute("contactInfo");
        ContactInfo contactInfo = (ContactInfo) map.get(gCustId);          
        map.remove(gCustId);  
        Contact_id=contactInfo.getContact_id();    
		    		    
		    Map relInfoMap = (Map)session.getAttribute("contactInfoRelation");    
        String[] phoneArr=(String[])relInfoMap.get(gCustId); 
        relInfoMap.remove(gCustId); 
        
        Map InfoMap = (Map)session.getAttribute("contactInfoMap");
        for(int i=0;i<phoneArr.length;i++){
            InfoMap.remove(phoneArr[i]); 
        }
				System.out.println(map); 	
				System.out.println(InfoMap); 	
				System.out.println(relInfoMap); 	  
				
      }catch(Throwable e)
      {
   
      }

    //System.out.println("======url2=====");
    String url="/npage/contact/EndCntt.jsp?gCustId="+gCustId+"&Contact_id="+Contact_id;  
    //System.out.println("url==="+url);
%>
	
<jsp:include page="<%=url%>" flush="true" />


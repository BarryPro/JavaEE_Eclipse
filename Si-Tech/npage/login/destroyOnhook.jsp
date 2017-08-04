<%
/**
挂机后删除session中储存在map里面的验证信息
hejwa 2010年10月9日13:24:07 add

*/
   try{
   		
   		java.util.HashMap hm2 = new java.util.HashMap();    
   		java.util.HashMap hm1 = (java.util.HashMap)session.getAttribute("phoneKfCheck");
   		session.setAttribute("phoneKfCheck",hm2);
   		
      }catch(Throwable e)
      {
   
      }
%>
	
